Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773F61F5490
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFJMXj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 08:23:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60752 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgFJMXj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 08:23:39 -0400
Received: from 89-64-83-71.dynamic.chello.pl (89.64.83.71) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 085cf89194671cbf; Wed, 10 Jun 2020 14:23:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Erik Kaneda <erik.kaneda@intel.com>, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: [RFT][PATCH 3/3] ACPI: OSL: Define ACPI_OS_MAP_MEMORY_FAST_PATH()
Date:   Wed, 10 Jun 2020 14:22:50 +0200
Message-ID: <6458983.dlBdKaB8z0@kreacher>
In-Reply-To: <318372766.6LKUBsbRXE@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <318372766.6LKUBsbRXE@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Define the ACPI_OS_MAP_MEMORY_FAST_PATH() macro to allow
acpi_ex_system_memory_space_handler() to avoid memory unmapping
overhead by deferring the unmap operations to the point when the
AML interpreter is exited after removing the operation region
that held the memory mappings which are not used any more.

That macro, when called on a knwon-existing memory mapping,
causes the reference counter of that mapping in the OS layer to be
incremented and returns a pointer representing the virtual address
of the start of the mapped memory area without really mapping it,
so the first subsequent unmap operation on it will only decrement
the reference counter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c                | 67 +++++++++++++++++++++++--------
 include/acpi/platform/aclinuxex.h |  4 ++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..b75f3a17776f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -302,21 +302,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
 		iounmap(vaddr);
 }
 
-/**
- * acpi_os_map_iomem - Get a virtual address for a given physical address range.
- * @phys: Start of the physical address range to map.
- * @size: Size of the physical address range to map.
- *
- * Look up the given physical address range in the list of existing ACPI memory
- * mappings.  If found, get a reference to it and return a pointer to it (its
- * virtual address).  If not found, map it, add it to that list and return a
- * pointer to it.
- *
- * During early init (when acpi_permanent_mmap has not been set yet) this
- * routine simply calls __acpi_map_table() to get the job done.
- */
-void __iomem __ref
-*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
+static void __iomem __ref *__acpi_os_map_iomem(acpi_physical_address phys,
+					       acpi_size size, bool fast_path)
 {
 	struct acpi_ioremap *map;
 	void __iomem *virt;
@@ -328,8 +315,12 @@ void __iomem __ref
 		return NULL;
 	}
 
-	if (!acpi_permanent_mmap)
+	if (!acpi_permanent_mmap) {
+		if (WARN_ON(fast_path))
+			return NULL;
+
 		return __acpi_map_table((unsigned long)phys, size);
+	}
 
 	mutex_lock(&acpi_ioremap_lock);
 	/* Check if there's a suitable mapping already. */
@@ -339,6 +330,11 @@ void __iomem __ref
 		goto out;
 	}
 
+	if (fast_path) {
+		mutex_unlock(&acpi_ioremap_lock);
+		return NULL;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
@@ -366,6 +362,25 @@ void __iomem __ref
 	mutex_unlock(&acpi_ioremap_lock);
 	return map->virt + (phys - map->phys);
 }
+
+/**
+ * acpi_os_map_iomem - Get a virtual address for a given physical address range.
+ * @phys: Start of the physical address range to map.
+ * @size: Size of the physical address range to map.
+ *
+ * Look up the given physical address range in the list of existing ACPI memory
+ * mappings.  If found, get a reference to it and return a pointer representing
+ * its virtual address.  If not found, map it, add it to that list and return a
+ * pointer representing its virtual address.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) call
+ * __acpi_map_table() to obtain the mapping.
+ */
+void __iomem __ref *acpi_os_map_iomem(acpi_physical_address phys,
+				      acpi_size size)
+{
+	return __acpi_os_map_iomem(phys, size, false);
+}
 EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
 
 void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
@@ -374,6 +389,24 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
+/**
+ * acpi_os_map_memory_fast_path - Fast-path physical-to-virtual address mapping.
+ * @phys: Start of the physical address range to map.
+ * @size: Size of the physical address range to map.
+ *
+ * Look up the given physical address range in the list of existing ACPI memory
+ * mappings.  If found, get a reference to it and return a pointer representing
+ * its virtual address.  If not found, return NULL.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) log a
+ * warning and return NULL.
+ */
+void __ref *acpi_os_map_memory_fast_path(acpi_physical_address phys,
+					acpi_size size)
+{
+	return __acpi_os_map_iomem(phys, size, true);
+}
+
 /* Must be called with mutex_lock(&acpi_ioremap_lock) */
 static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
@@ -1571,6 +1604,8 @@ acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
 
 	return acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
 				   acpi_deactivate_mem_region, NULL, res, NULL);
+
+	acpi_release_unused_memory_mappings();
 }
 EXPORT_SYMBOL_GPL(acpi_release_memory);
 
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 04f88f2de781..1d8be4ac9ef9 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -139,6 +139,10 @@ static inline void acpi_os_terminate_debugger(void)
  * OSL interfaces added by Linux
  */
 
+void *acpi_os_map_memory_fast_path(acpi_physical_address where, acpi_size length);
+
+#define ACPI_OS_MAP_MEMORY_FAST_PATH(a, s)	acpi_os_map_memory_fast_path(a, s)
+
 #endif				/* __KERNEL__ */
 
 #endif				/* __ACLINUXEX_H__ */
-- 
2.26.2




