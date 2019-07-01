Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DDD51AAF
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFXSeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 14:34:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:44997 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfFXSeX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 14:34:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:34:23 -0700
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="152030289"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:34:23 -0700
Subject: [PATCH v4 07/10] resource: Uplevel the pmem "region" ida to a
 global allocator
From:   Dan Williams <dan.j.williams@intel.com>
To:     x86@kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 11:20:06 -0700
Message-ID: <156140040657.2951909.15384446634808002027.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for handling platform differentiated memory types beyond
persistent memory, uplevel the "region" identifier to a global number
space. This enables a device-dax instance to be registered to any memory
type with guaranteed unique names.

Given this is a general identifier for persistent and
performance-differentiated memory, and a standalone header / source file
was NAK'd, house it with the rest of the general resource enumeration
implementation.

Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/Kconfig       |    1 +
 drivers/nvdimm/core.c        |    1 -
 drivers/nvdimm/nd-core.h     |    1 -
 drivers/nvdimm/region_devs.c |   12 +++---------
 include/linux/ioport.h       |   27 +++++++++++++++++++++++++++
 kernel/resource.c            |    6 ++++++
 lib/Kconfig                  |    3 +++
 7 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 54500798f23a..4b3e66fe61c1 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -4,6 +4,7 @@ menuconfig LIBNVDIMM
 	depends on PHYS_ADDR_T_64BIT
 	depends on HAS_IOMEM
 	depends on BLK_DEV
+	select MEMREGION
 	help
 	  Generic support for non-volatile memory devices including
 	  ACPI-6-NFIT defined resources.  On platforms that define an
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index acce050856a8..75fe651d327d 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -463,7 +463,6 @@ static __exit void libnvdimm_exit(void)
 	nd_region_exit();
 	nvdimm_exit();
 	nvdimm_bus_exit();
-	nd_region_devs_exit();
 	nvdimm_devs_exit();
 }
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index e5ffd5733540..17561302dfec 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -133,7 +133,6 @@ struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
 void nvdimm_devs_exit(void);
-void nd_region_devs_exit(void);
 void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 struct nd_region;
 void nd_region_create_ns_seed(struct nd_region *nd_region);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b4ef7d9ff22e..576c390dabd6 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -27,7 +27,6 @@
  */
 #include <linux/io-64-nonatomic-hi-lo.h>
 
-static DEFINE_IDA(region_ida);
 static DEFINE_PER_CPU(int, flush_idx);
 
 static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
@@ -141,7 +140,7 @@ static void nd_region_release(struct device *dev)
 		put_device(&nvdimm->dev);
 	}
 	free_percpu(nd_region->lane);
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
 	if (is_nd_blk(dev))
 		kfree(to_nd_blk_region(dev));
 	else
@@ -1036,7 +1035,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	if (!region_buf)
 		return NULL;
-	nd_region->id = ida_simple_get(&region_ida, 0, 0, GFP_KERNEL);
+	nd_region->id = memregion_alloc(GFP_KERNEL);
 	if (nd_region->id < 0)
 		goto err_id;
 
@@ -1090,7 +1089,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	return nd_region;
 
  err_percpu:
-	ida_simple_remove(&region_ida, nd_region->id);
+	memregion_free(nd_region->id);
  err_id:
 	kfree(region_buf);
 	return NULL;
@@ -1237,8 +1236,3 @@ int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
 
 	return device_for_each_child(&nvdimm_bus->dev, &ctx, region_conflict);
 }
-
-void __exit nd_region_devs_exit(void)
-{
-	ida_destroy(&region_ida);
-}
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 2d79841ee9b9..72ea690b35a4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,12 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#ifdef CONFIG_MEMREGION
+#include <linux/idr.h>
+#else
+#include <linux/errno.h>
+#endif
+
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -287,6 +293,27 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+#ifdef CONFIG_MEMREGION
+extern struct ida memregion_ids;
+static inline int memregion_alloc(gfp_t gfp)
+{
+	return ida_alloc(&memregion_ids, gfp);
+}
+
+static inline void memregion_free(int id)
+{
+	ida_free(&memregion_ids, id);
+}
+#else /* CONFIG_MEMREGION */
+static inline int memregion_alloc(gfp_t gfp)
+{
+	return -ENOMEM;
+}
+
+static inline void memregion_free(int id)
+{
+}
+#endif
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 158f04ec1d4f..82dbd9f28e91 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1637,4 +1637,10 @@ static int __init strict_iomem(char *str)
 	return 1;
 }
 
+#ifdef CONFIG_MEMREGION
+/* identifiers for device memory regions */
+DEFINE_IDA(memregion_ids);
+EXPORT_SYMBOL(memregion_ids);
+#endif
+
 __setup("iomem=", strict_iomem);
diff --git a/lib/Kconfig b/lib/Kconfig
index 90623a0e1942..89f7e4523799 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -602,6 +602,9 @@ config ARCH_NO_SG_CHAIN
 config ARCH_HAS_PMEM_API
 	bool
 
+config MEMREGION
+	bool
+
 # use memcpy to implement user copies for nommu architectures
 config UACCESS_MEMCPY
 	bool

