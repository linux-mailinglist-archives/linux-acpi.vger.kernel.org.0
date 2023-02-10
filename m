Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B64691AE0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjBJJJE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBJJIa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:08:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099942CFCB;
        Fri, 10 Feb 2023 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020040; x=1707556040;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hrm0j+K5sMknqLeRHZPi95fuEMBi83jRYl1v32nRVsM=;
  b=ny88ZzDwCPmzUosWzwOxB6RUzxgzTnchWCZFI+XHuVtK51P3hvWz1+Yt
   Ph5KRBX+hdeKiukdjBBFQ5KQZa8JJr+tFdxQAi0HFi9D9twbcnsVeAB8r
   nZplY75rffCDqT30HL6+bByGmO6UvtIWh/GztcRGTQBZRaWyHVZhxOMAw
   e18MH4ZNMrmo8+8GGaeS96o4V1w0bVAX14KGFPMcxpf8JWgLjRXw9w6PS
   4j3UM9p9g07KZX2Oky5LPuMrF+6cjZAIh9so9GLsvxXe15t5UO5WZlIMo
   2I3keN7HptSKcBaNBdmp9sc8NemIw1PnZm/c/mw3yT1auf4OnOR/kbOGk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310738862"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="310738862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:07:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661341226"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661341226"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:07:19 -0800
Subject: [PATCH v2 20/20] cxl/dax: Create dax devices for CXL RAM regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:07:19 -0800
Message-ID: <167602003896.1924368.10335442077318970468.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While platform firmware takes some responsibility for mapping the RAM
capacity of CXL devices present at boot, the OS is responsible for
mapping the remainder and hot-added devices. Platform firmware is also
responsible for identifying the platform general purpose memory pool,
typically DDR attached DRAM, and arranging for the remainder to be 'Soft
Reserved'. That reservation allows the CXL subsystem to route the memory
to core-mm via memory-hotplug (dax_kmem), or leave it for dedicated
access (device-dax).

The new 'struct cxl_dax_region' object allows for a CXL memory resource
(region) to be published, but also allow for udev and module policy to
act on that event. It also prevents cxl_core.ko from having a module
loading dependency on any drivers/dax/ modules.

Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564545116.847146.4741351262959589920.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS               |    1 
 drivers/cxl/acpi.c        |    3 +
 drivers/cxl/core/core.h   |    3 +
 drivers/cxl/core/port.c   |    4 +-
 drivers/cxl/core/region.c |  108 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |   12 +++++
 drivers/dax/Kconfig       |   13 +++++
 drivers/dax/Makefile      |    2 +
 drivers/dax/cxl.c         |   53 ++++++++++++++++++++++
 drivers/dax/hmem/hmem.c   |   14 ++++++
 10 files changed, 209 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dax/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..73a9f3401e0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6035,6 +6035,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	nvdimm@lists.linux.dev
+L:	linux-cxl@vger.kernel.org
 S:	Supported
 F:	drivers/dax/
 
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ad0849af42d7..8ebb9a74790d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -731,7 +731,8 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-module_init(cxl_acpi_init);
+/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
+subsys_initcall(cxl_acpi_init);
 module_exit(cxl_acpi_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 479f01da6d35..cde475e13216 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -15,12 +15,14 @@ extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
+extern const struct device_type cxl_dax_region_type;
 extern const struct device_type cxl_region_type;
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
+#define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 #else
@@ -38,6 +40,7 @@ static inline void cxl_region_exit(void)
 #define CXL_REGION_TYPE(x) NULL
 #define SET_CXL_REGION_ATTR(x)
 #define CXL_PMEM_REGION_TYPE(x) NULL
+#define CXL_DAX_REGION_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b45d2796ef35..0bb7a5ff724b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -46,6 +46,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (dev->type == CXL_PMEM_REGION_TYPE())
 		return CXL_DEVICE_PMEM_REGION;
+	if (dev->type == CXL_DAX_REGION_TYPE())
+		return CXL_DEVICE_DAX_REGION;
 	if (is_cxl_port(dev)) {
 		if (is_cxl_root(to_cxl_port(dev)))
 			return CXL_DEVICE_ROOT;
@@ -2015,6 +2017,6 @@ static void cxl_core_exit(void)
 	debugfs_remove_recursive(cxl_debugfs);
 }
 
-module_init(cxl_core_init);
+subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3f6453da2c51..91d334080cab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2272,6 +2272,75 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	return cxlr_pmem;
 }
 
+static void cxl_dax_region_release(struct device *dev)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+
+	kfree(cxlr_dax);
+}
+
+static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_dax_region_type = {
+	.name = "cxl_dax_region",
+	.release = cxl_dax_region_release,
+	.groups = cxl_dax_region_attribute_groups,
+};
+
+static bool is_cxl_dax_region(struct device *dev)
+{
+	return dev->type == &cxl_dax_region_type;
+}
+
+struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
+			  "not a cxl_dax_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_dax_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, CXL);
+
+static struct lock_class_key cxl_dax_region_key;
+
+static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+
+	down_read(&cxl_region_rwsem);
+	if (p->state != CXL_CONFIG_COMMIT) {
+		cxlr_dax = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
+	if (!cxlr_dax) {
+		cxlr_dax = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	cxlr_dax->hpa_range.start = p->res->start;
+	cxlr_dax->hpa_range.end = p->res->end;
+
+	dev = &cxlr_dax->dev;
+	cxlr_dax->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_dax_region_type;
+out:
+	up_read(&cxl_region_rwsem);
+
+	return cxlr_dax;
+}
+
 static void cxlr_pmem_unregister(void *_cxlr_pmem)
 {
 	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
@@ -2356,6 +2425,42 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	return rc;
 }
 
+static void cxlr_dax_unregister(void *_cxlr_dax)
+{
+	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
+
+	device_unregister(&cxlr_dax->dev);
+}
+
+static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc;
+
+	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	if (IS_ERR(cxlr_dax))
+		return PTR_ERR(cxlr_dax);
+
+	dev = &cxlr_dax->dev;
+	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
+					cxlr_dax);
+err:
+	put_device(dev);
+	return rc;
+}
+
 static int match_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
@@ -2619,8 +2724,7 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
-		dev_dbg(dev, "TODO: hookup devdax\n");
-		return 0;
+		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2ac344235235..b1395c46baec 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -513,6 +513,12 @@ struct cxl_pmem_region {
 	struct cxl_pmem_region_mapping mapping[];
 };
 
+struct cxl_dax_region {
+	struct device dev;
+	struct cxl_region *cxlr;
+	struct range hpa_range;
+};
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -707,6 +713,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_MEMORY_EXPANDER	5
 #define CXL_DEVICE_REGION		6
 #define CXL_DEVICE_PMEM_REGION		7
+#define CXL_DEVICE_DAX_REGION		8
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -725,6 +732,7 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
+struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -739,6 +747,10 @@ static inline int cxl_add_to_region(struct cxl_port *root,
 {
 	return 0;
 }
+static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 /*
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 1163eb62e5f6..bd06e16c7ac8 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -45,6 +45,19 @@ config DEV_DAX_HMEM
 
 	  Say M if unsure.
 
+config DEV_DAX_CXL
+	tristate "CXL DAX: direct access to CXL RAM regions"
+	depends on CXL_REGION && DEV_DAX
+	default CXL_REGION && DEV_DAX
+	help
+	  CXL RAM regions are either mapped by platform-firmware
+	  and published in the initial system-memory map as "System RAM", mapped
+	  by platform-firmware as "Soft Reserved", or dynamically provisioned
+	  after boot by the CXL driver. In the latter two cases a device-dax
+	  instance is created to access that unmapped-by-default address range.
+	  Per usual it can remain as dedicated access via a device interface, or
+	  converted to "System RAM" via the dax_kmem facility.
+
 config DEV_DAX_HMEM_DEVICES
 	depends on DEV_DAX_HMEM && DAX
 	def_bool y
diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 90a56ca3b345..5ed5c39857c8 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -3,10 +3,12 @@ obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
 obj-$(CONFIG_DEV_DAX_PMEM) += dax_pmem.o
+obj-$(CONFIG_DEV_DAX_CXL) += dax_cxl.o
 
 dax-y := super.o
 dax-y += bus.o
 device_dax-y := device.o
 dax_pmem-y := pmem.o
+dax_cxl-y := cxl.o
 
 obj-y += hmem/
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
new file mode 100644
index 000000000000..ccdf8de85bd5
--- /dev/null
+++ b/drivers/dax/cxl.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/dax.h>
+
+#include "../cxl/cxl.h"
+#include "bus.h"
+
+static int cxl_dax_region_probe(struct device *dev)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	int nid = phys_to_target_node(cxlr_dax->hpa_range.start);
+	struct cxl_region *cxlr = cxlr_dax->cxlr;
+	struct dax_region *dax_region;
+	struct dev_dax_data data;
+	struct dev_dax *dev_dax;
+
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
+
+	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
+				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+	if (!dax_region)
+		return -ENOMEM;
+
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = -1,
+		.size = range_len(&cxlr_dax->hpa_range),
+	};
+	dev_dax = devm_create_dev_dax(&data);
+	if (IS_ERR(dev_dax))
+		return PTR_ERR(dev_dax);
+
+	/* child dev_dax instances now own the lifetime of the dax_region */
+	dax_region_put(dax_region);
+	return 0;
+}
+
+static struct cxl_driver cxl_dax_region_driver = {
+	.name = "cxl_dax_region",
+	.probe = cxl_dax_region_probe,
+	.id = CXL_DEVICE_DAX_REGION,
+	.drv = {
+		.suppress_bind_attrs = true,
+	},
+};
+
+module_cxl_driver(cxl_dax_region_driver);
+MODULE_ALIAS_CXL(CXL_DEVICE_DAX_REGION);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5ec08f9f8a57..e5fe8b39fb94 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -72,6 +72,13 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		dev_dbg(host, "deferring range to CXL: %pr\n", res);
+		return 0;
+	}
+
 	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			       IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
@@ -157,6 +164,13 @@ static __exit void dax_hmem_exit(void)
 module_init(dax_hmem_init);
 module_exit(dax_hmem_exit);
 
+/* Allow for CXL to define its own dax regions */
+#if IS_ENABLED(CONFIG_CXL_REGION)
+#if IS_MODULE(CONFIG_CXL_ACPI)
+MODULE_SOFTDEP("pre: cxl_acpi");
+#endif
+#endif
+
 MODULE_ALIAS("platform:hmem*");
 MODULE_ALIAS("platform:hmem_platform*");
 MODULE_LICENSE("GPL v2");

