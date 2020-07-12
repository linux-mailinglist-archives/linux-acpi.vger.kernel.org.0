Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF321CA35
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGLQms (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:42:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:15458 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbgGLQmr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:42:47 -0400
IronPort-SDR: YkK9O0scf4ud73GBdmbF2buGE3fsgSE2SABS4W0VBFAVTptFWb90amaH/T6GS49Ko9z16xZ5Z/
 WGWV73YVfFqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128568248"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="128568248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:43 -0700
IronPort-SDR: BRY1o5mofQLRHN4bgOzxUP3BlfjJmA15AoCRhj4kata3D82DY9hHir+Gl2I6TWc3hu0Svqdzu4
 PH5kLuBAg8PA==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="269520993"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:43 -0700
Subject: [PATCH v2 04/22] ACPI: HMAT: Refactor hmat_register_target_device
 to hmem_register_device
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:26:27 -0700
Message-ID: <159457118718.754248.3295937588916329732.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for exposing "Soft Reserved" memory ranges without an
HMAT, move the hmem device registration to its own compilation unit and
make the implementation generic.

The generic implementation drops usage acpi_map_pxm_to_online_node()
that was translating ACPI proximity domain values and instead relies on
numa_map_to_online_node() to determine the numa node for the device.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
 drivers/dax/Kconfig       |    4 +++
 drivers/dax/Makefile      |    3 +-
 drivers/dax/hmem/Makefile |    5 +++
 drivers/dax/hmem/device.c |   65 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c   |    2 +
 include/linux/dax.h       |    8 +++++
 7 files changed, 90 insertions(+), 65 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (98%)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a12e36a12618..134bcb40b2af 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
+#include <linux/dax.h>
 
 static u8 hmat_revision;
 static int hmat_disable __initdata;
@@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
-static void hmat_register_target_device(struct memory_target *target,
-		struct resource *r)
-{
-	/* define a clean / non-busy resource for the platform device */
-	struct resource res = {
-		.start = r->start,
-		.end = r->end,
-		.flags = IORESOURCE_MEM,
-	};
-	struct platform_device *pdev;
-	struct memregion_info info;
-	int rc, id;
-
-	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
-			IORES_DESC_SOFT_RESERVED);
-	if (rc != REGION_INTERSECTS)
-		return;
-
-	id = memregion_alloc(GFP_KERNEL);
-	if (id < 0) {
-		pr_err("memregion allocation failure for %pr\n", &res);
-		return;
-	}
-
-	pdev = platform_device_alloc("hmem", id);
-	if (!pdev) {
-		pr_err("hmem device allocation failure for %pr\n", &res);
-		goto out_pdev;
-	}
-
-	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
-	info = (struct memregion_info) {
-		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
-	};
-	rc = platform_device_add_data(pdev, &info, sizeof(info));
-	if (rc < 0) {
-		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
-		goto out_pdev;
-	}
-
-	rc = platform_device_add_resources(pdev, &res, 1);
-	if (rc < 0) {
-		pr_err("hmem resource allocation failure for %pr\n", &res);
-		goto out_resource;
-	}
-
-	rc = platform_device_add(pdev);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
-		goto out_resource;
-	}
-
-	return;
-
-out_resource:
-	put_device(&pdev->dev);
-out_pdev:
-	memregion_free(id);
-}
-
 static void hmat_register_target_devices(struct memory_target *target)
 {
 	struct resource *res;
@@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
 	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
 		return;
 
-	for (res = target->memregions.child; res; res = res->sibling)
-		hmat_register_target_device(target, res);
+	for (res = target->memregions.child; res; res = res->sibling) {
+		int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
+
+		hmem_register_device(target_nid, res);
+	}
 }
 
 static void hmat_register_target(struct memory_target *target)
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 3b6c06f07326..a229f45d34aa 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,10 @@ config DEV_DAX_HMEM
 
 	  Say M if unsure.
 
+config DEV_DAX_HMEM_DEVICES
+	depends on DEV_DAX_HMEM
+	def_bool y
+
 config DEV_DAX_KMEM
 	tristate "KMEM DAX: volatile-use of persistent memory"
 	default DEV_DAX
diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 80065b38b3c4..9d4ba672d305 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -2,11 +2,10 @@
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
-obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
 
 dax-y := super.o
 dax-y += bus.o
 device_dax-y := device.o
-dax_hmem-y := hmem.o
 
 obj-y += pmem/
+obj-y += hmem/
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
new file mode 100644
index 000000000000..a9d353d0c9ed
--- /dev/null
+++ b/drivers/dax/hmem/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
+obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device.o
+
+dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
new file mode 100644
index 000000000000..b9dd6b27745c
--- /dev/null
+++ b/drivers/dax/hmem/device.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/platform_device.h>
+#include <linux/memregion.h>
+#include <linux/module.h>
+#include <linux/dax.h>
+#include <linux/mm.h>
+
+void hmem_register_device(int target_nid, struct resource *r)
+{
+	/* define a clean / non-busy resource for the platform device */
+	struct resource res = {
+		.start = r->start,
+		.end = r->end,
+		.flags = IORESOURCE_MEM,
+	};
+	struct platform_device *pdev;
+	struct memregion_info info;
+	int rc, id;
+
+	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
+			IORES_DESC_SOFT_RESERVED);
+	if (rc != REGION_INTERSECTS)
+		return;
+
+	id = memregion_alloc(GFP_KERNEL);
+	if (id < 0) {
+		pr_err("memregion allocation failure for %pr\n", &res);
+		return;
+	}
+
+	pdev = platform_device_alloc("hmem", id);
+	if (!pdev) {
+		pr_err("hmem device allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
+	info = (struct memregion_info) {
+		.target_node = target_nid,
+	};
+	rc = platform_device_add_data(pdev, &info, sizeof(info));
+	if (rc < 0) {
+		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
+		goto out_pdev;
+	}
+
+	rc = platform_device_add_resources(pdev, &res, 1);
+	if (rc < 0) {
+		pr_err("hmem resource allocation failure for %pr\n", &res);
+		goto out_resource;
+	}
+
+	rc = platform_device_add(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
+		goto out_resource;
+	}
+
+	return;
+
+out_resource:
+	put_device(&pdev->dev);
+out_pdev:
+	memregion_free(id);
+}
diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem/hmem.c
similarity index 98%
rename from drivers/dax/hmem.c
rename to drivers/dax/hmem/hmem.c
index fe7214daf62e..29ceb5795297 100644
--- a/drivers/dax/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -3,7 +3,7 @@
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/pfn_t.h>
-#include "bus.h"
+#include "../bus.h"
 
 static int dax_hmem_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..5d2c3d9aeb5e 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -221,4 +221,12 @@ static inline bool dax_mapping(struct address_space *mapping)
 	return mapping->host && IS_DAX(mapping->host);
 }
 
+#ifdef CONFIG_DEV_DAX_HMEM_DEVICES
+void hmem_register_device(int target_nid, struct resource *r);
+#else
+static inline void hmem_register_device(int target_nid, struct resource *r)
+{
+}
+#endif
+
 #endif

