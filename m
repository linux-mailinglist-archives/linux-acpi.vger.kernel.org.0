Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9E20B722
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFZReQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 13:34:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59282 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgFZReP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2020 13:34:15 -0400
Received: from 89-64-83-223.dynamic.chello.pl (89.64.83.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 33d6153b1b8ab52e; Fri, 26 Jun 2020 19:34:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: [RFT][PATCH v3 3/4] ACPICA: Preserve memory opregion mappings if supported by OS
Date:   Fri, 26 Jun 2020 19:32:27 +0200
Message-ID: <3156511.gHkMriIWEz@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPICA's strategy with respect to the handling of memory mappings
associated with memory operation regions is to avoid mapping the
entire region at once which may be problematic at least in principle
(for example, it may lead to conflicts with overlapping mappings
having different attributes created by drivers).  It may also be
wasteful, because memory opregions on some systems take up vast
chunks of address space while the fields in those regions actually
accessed by AML are sparsely distributed.

For this reason, a one-page "window" is mapped for a given opregion
on the first memory access through it and if that "window" does not
cover an address range accessed through that opregion subsequently,
it is unmapped and a new "window" is mapped to replace it.  Next,
if the new "window" is not sufficient to acess memory through the
opregion in question in the future, it will be replaced with yet
another "window" and so on.  That may lead to a suboptimal sequence
of memory mapping and unmapping operations, for example if two fields
in one opregion separated from each other by a sufficiently wide
chunk of unused address space are accessed in an alternating pattern.

The situation may still be suboptimal if the deferred unmapping
introduced previously is supported by the OS layer.  For instance,
the alternating memory access pattern mentioned above may produce
a relatively long list of mappings to release with substantial
duplication among the entries in it, which could be avoided if
acpi_ex_system_memory_space_handler() did not release the mapping
used by it previously as soon as the current access was not covered
by it.

In order to improve that, modify acpi_ex_system_memory_space_handler()
to take advantage of the memory mappings reference counting at the OS
level if a suitable interface is provided.

Namely, if ACPI_USE_FAST_PATH_MAPPING is set, the OS is expected to
implement acpi_os_map_memory_fast_path() that will return NULL if
there is no mapping covering the given address range known to it.
If such a mapping is there, however, its reference counter will be
incremented and a pointer representing the requested virtual address
will be returned right away without any additional consequences.

That allows acpi_ex_system_memory_space_handler() to acquire
additional references to all new memory mappings with the help
of acpi_os_map_memory_fast_path() so as to retain them until the
memory opregions associated with them go away.  The function will
still use a new "window" mapping if the current one does not
cover the address range at hand, but it will avoid unmapping the
current one right away by adding it to a list of "known" mappings
associated with the given memory opregion which will be deleted at
the opregion deactivation time.  The mappings in that list can be
used every time a "new window" is needed so as to avoid overhead
related to the mapping and unmapping of memory.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acinterp.h |   3 +
 drivers/acpi/acpica/evrgnini.c |   9 +-
 drivers/acpi/acpica/exregion.c | 154 ++++++++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index a6d896cda2a5..95675a7a8a6b 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -479,6 +479,9 @@ void acpi_ex_pci_cls_to_string(char *dest, u8 class_code[3]);
 
 u8 acpi_is_valid_space_id(u8 space_id);
 
+acpi_size acpi_ex_mem_space_context_size(void);
+void acpi_ex_unmap_all_region_mappings(struct acpi_mem_space_context *mem_info);
+
 /*
  * exregion - default op_region handlers
  */
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index aefc0145e583..82f466a128d5 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -46,13 +46,10 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 			local_region_context =
 			    (struct acpi_mem_space_context *)*region_context;
 
-			/* Delete a cached mapping if present */
+			/* Delete memory mappings if present */
 
 			if (local_region_context->mapped_length) {
-				acpi_os_unmap_memory(local_region_context->
-						     mapped_logical_address,
-						     local_region_context->
-						     mapped_length);
+				acpi_ex_unmap_all_region_mappings(local_region_context);
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
@@ -63,7 +60,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 	/* Create a new context */
 
 	local_region_context =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_mem_space_context));
+		ACPI_ALLOCATE_ZEROED(acpi_ex_mem_space_context_size());
 	if (!(local_region_context)) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index d15a66de26c0..4274582619d2 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -14,6 +14,73 @@
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exregion")
 
+struct acpi_mem_mapping {
+	acpi_physical_address physical_address;
+	u8 *logical_address;
+	acpi_size length;
+	struct acpi_mem_mapping *next_mm;
+};
+
+struct acpi_mm_context {
+	struct acpi_mem_space_context mem_info;
+	struct acpi_mem_mapping *first_mm;
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_mem_space_context_size
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Size of internal memory operation region representation.
+ *
+ ******************************************************************************/
+acpi_size acpi_ex_mem_space_context_size(void)
+{
+	ACPI_FUNCTION_TRACE(acpi_ex_mem_space_context_size);
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	return sizeof(struct acpi_mm_context);
+#else
+	return sizeof(struct acpi_mem_space_context);
+#endif
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_unmap_all_region_mappings
+ *
+ * PARAMETERS:  mem_info            - Region specific context
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Unmap all mappings associated with a memory operation region.
+ *
+ ******************************************************************************/
+void acpi_ex_unmap_all_region_mappings(struct acpi_mem_space_context *mem_info)
+{
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	struct acpi_mm_context *mm_context = (struct acpi_mm_context *)mem_info;
+	struct acpi_mem_mapping *mm;
+#endif
+
+	ACPI_FUNCTION_TRACE(acpi_ex_unmap_all_region_mappings);
+
+	acpi_os_unmap_memory(mem_info->mapped_logical_address,
+			     mem_info->mapped_length);
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	while (mm_context->first_mm) {
+		mm = mm_context->first_mm;
+		mm_context->first_mm = mm->next_mm;
+		acpi_os_unmap_memory(mm->logical_address, mm->length);
+		ACPI_FREE(mm);
+	}
+#endif
+
+	return_VOID;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_system_memory_space_handler
@@ -44,6 +111,10 @@ acpi_ex_system_memory_space_handler(u32 function,
 	u32 length;
 	acpi_size map_length;
 	acpi_size page_boundary_map_length;
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	struct acpi_mm_context *mm_context = (struct acpi_mm_context *)mem_info;
+	struct acpi_mem_mapping *mm;
+#endif
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -102,7 +173,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 					 mem_info->mapped_length))) {
 		/*
 		 * The request cannot be resolved by the current memory mapping;
-		 * Delete the existing mapping and create a new one.
+		 * Delete the current cached mapping and get a new one.
 		 */
 		if (mem_info->mapped_length) {
 
@@ -112,6 +183,36 @@ acpi_ex_system_memory_space_handler(u32 function,
 					     mem_info->mapped_length);
 		}
 
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+		/*
+		 * Look for an existing saved mapping matching the address range
+		 * at hand.  If found, make the OS layer bump up the reference
+		 * counter of that mapping, cache it and carry out the access.
+		 */
+		for (mm = mm_context->first_mm; mm; mm = mm->next_mm) {
+			if (address < mm->physical_address)
+				continue;
+
+			if ((u64)address + length >
+					(u64)mm->physical_address + mm->length)
+				continue;
+
+			/*
+			 * When called on a known-existing memory mapping,
+			 * acpi_os_map_memory_fast_path() must return the same
+			 * logical address as before or NULL.
+			 */
+			if (!acpi_os_map_memory_fast_path(mm->physical_address,
+							  mm->length))
+				continue;
+
+			mem_info->mapped_logical_address = mm->logical_address;
+			mem_info->mapped_physical_address = mm->physical_address;
+			mem_info->mapped_length = mm->length;
+			goto access;
+		}
+#endif /* ACPI_USE_FAST_PATH_MAPPING */
+
 		/*
 		 * October 2009: Attempt to map from the requested address to the
 		 * end of the region. However, we will never map more than one
@@ -143,9 +244,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-		    acpi_os_map_memory(address, map_length);
-		if (!mem_info->mapped_logical_address) {
+		logical_addr_ptr = acpi_os_map_memory(address, map_length);
+		if (!logical_addr_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_UINT64(address),
@@ -156,10 +256,56 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Save the physical address and mapping size */
 
+		mem_info->mapped_logical_address = logical_addr_ptr;
 		mem_info->mapped_physical_address = address;
 		mem_info->mapped_length = map_length;
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+		/*
+		 * Create a new mm list entry to save the new mapping for
+		 * removal at the operation region deactivation time.
+		 */
+		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
+		if (!mm) {
+			/*
+			 * No room to save the new mapping, but this is not
+			 * critical.  Just log the error and carry out the
+			 * access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Not enough memory to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			goto access;
+		}
+		/*
+		 * Bump up the new mapping's reference counter in the OS layer
+		 * to prevent it from getting dropped prematurely.
+		 */
+		if (!acpi_os_map_memory_fast_path(address, map_length)) {
+			/*
+			 * Something has gone wrong, but this is not critical.
+			 * Log the error, free the mm list entry that won't be
+			 * used and carry out the access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			ACPI_FREE(mm);
+			goto access;
+		}
+		mm->physical_address = address;
+		mm->logical_address = logical_addr_ptr;
+		mm->length = map_length;
+		mm->next_mm = mm_context->first_mm;
+		mm_context->first_mm = mm;
 	}
 
+access:
+#else /* !ACPI_USE_FAST_PATH_MAPPING */
+	}
+#endif /* !ACPI_USE_FAST_PATH_MAPPING */
 	/*
 	 * Generate a logical pointer corresponding to the address we want to
 	 * access
-- 
2.26.2




