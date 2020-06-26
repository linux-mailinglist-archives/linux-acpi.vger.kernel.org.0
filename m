Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F220B715
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgFZReN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 13:34:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63350 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgFZReM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2020 13:34:12 -0400
Received: from 89-64-83-223.dynamic.chello.pl (89.64.83.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 69d62dc03bd9ee5c; Fri, 26 Jun 2020 19:34:10 +0200
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
Subject: [RFT][PATCH v3 4/4] ACPI: OSL: Implement acpi_os_map_memory_fast_path()
Date:   Fri, 26 Jun 2020 19:33:53 +0200
Message-ID: <14649052.BMOpmyQVCI@kreacher>
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

Add acpi_os_map_memory_fast_path() and set ACPI_USE_FAST_PATH_MAPPING
to allow acpi_ex_system_memory_space_handler() to avoid unnecessary
memory mapping and unmapping overhead by retaining all memory
mappings created by it until the memory opregions associated with
them go away.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c                | 65 +++++++++++++++++++++++--------
 include/acpi/platform/aclinux.h   |  4 ++
 include/acpi/platform/aclinuxex.h |  3 ++
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 749ae3e32193..b8537ce89ea2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -306,21 +306,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
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
@@ -332,8 +319,12 @@ void __iomem __ref
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
@@ -343,6 +334,11 @@ void __iomem __ref
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
@@ -370,6 +366,25 @@ void __iomem __ref
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
@@ -378,6 +393,24 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
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
 static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
 {
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 784e294dc74c..1a5f8037e3d5 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -118,6 +118,10 @@
 
 #define USE_NATIVE_ALLOCATE_ZEROED
 
+/* Use fast-path memory mapping to optimize memory opregions handling */
+
+#define ACPI_USE_FAST_PATH_MAPPING
+
 /*
  * Overrides for in-kernel ACPICA
  */
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index ad6b905358c5..c64b836ba455 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -141,6 +141,9 @@ static inline void acpi_os_terminate_debugger(void)
  * OSL interfaces added by Linux
  */
 
+void *acpi_os_map_memory_fast_path(acpi_physical_address where,
+				   acpi_size length);
+
 #endif				/* __KERNEL__ */
 
 #endif				/* __ACLINUXEX_H__ */
-- 
2.26.2




