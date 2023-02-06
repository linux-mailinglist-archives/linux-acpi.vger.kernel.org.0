Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC068B38F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBFBD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBFBDz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A1CDF9;
        Sun,  5 Feb 2023 17:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645434; x=1707181434;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGjDlEaM3SmHqxTQJem08iZ8rEDpl61Vdevr59NhbRE=;
  b=av4WjYS/GIFWEccOeYzYOEsQ0c5yprUOqTWRziN3M+HEke2oc95HsbpP
   rurWoUn1GLC7IenNpl30oNu5tbai5dJRi1+ZUtMJSGJbMTMpdEDCmaSXU
   q7iJ/H//ICzTYR2MUa2JwY308x1cw6MbTqIuldYvbZTWe5Vwi/VScIlyZ
   64IL8CuOWd6g0qYaGHWfjuwPRoyKBgkqm7iHf3PVvm9YlGGrlTZiMG9M9
   H5S+htDW2oEDcdSLB7S37L+0J+gCj7svwN6sTjgaaYnR128/SpcOyuU1m
   hC5Li1DWuRhg1I3RdYPK1t7cTit+9l8nurCdcSvtQ4M6SceXs4cDial9K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309442686"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309442686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775006720"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775006720"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:53 -0800
Subject: [PATCH 15/18] dax/hmem: Convey the dax range via memregion_info()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:53 -0800
Message-ID: <167564543303.847146.11045895213318648441.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for hmem platform devices to be unregistered, stop using
platform_device_add_resources() to convey the address range. The
platform_device_add_resources() API causes an existing "Soft Reserved"
iomem resource to be re-parented under an inserted platform device
resource. When that platform device is deleted it removes the platform
device resource and all children.

Instead, it is sufficient to convey just the address range and let
request_mem_region() insert resources to indicate the devices active in
the range. This allows the "Soft Reserved" resource to be re-enumerated
upon the next probe event.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/device.c |   37 ++++++++++++++-----------------------
 drivers/dax/hmem/hmem.c   |   14 +++-----------
 include/linux/memregion.h |    2 ++
 3 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 20749c7fab81..b1b339bccfe5 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -15,15 +15,8 @@ static struct resource hmem_active = {
 	.flags = IORESOURCE_MEM,
 };
 
-void hmem_register_device(int target_nid, struct resource *r)
+void hmem_register_device(int target_nid, struct resource *res)
 {
-	/* define a clean / non-busy resource for the platform device */
-	struct resource res = {
-		.start = r->start,
-		.end = r->end,
-		.flags = IORESOURCE_MEM,
-		.desc = IORES_DESC_SOFT_RESERVED,
-	};
 	struct platform_device *pdev;
 	struct memregion_info info;
 	int rc, id;
@@ -31,55 +24,53 @@ void hmem_register_device(int target_nid, struct resource *r)
 	if (nohmem)
 		return;
 
-	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
-			IORES_DESC_SOFT_RESERVED);
+	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			       IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
 		return;
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
-		pr_err("memregion allocation failure for %pr\n", &res);
+		pr_err("memregion allocation failure for %pr\n", res);
 		return;
 	}
 
 	pdev = platform_device_alloc("hmem", id);
 	if (!pdev) {
-		pr_err("hmem device allocation failure for %pr\n", &res);
+		pr_err("hmem device allocation failure for %pr\n", res);
 		goto out_pdev;
 	}
 
-	if (!__request_region(&hmem_active, res.start, resource_size(&res),
+	if (!__request_region(&hmem_active, res->start, resource_size(res),
 			      dev_name(&pdev->dev), 0)) {
-		dev_dbg(&pdev->dev, "hmem range %pr already active\n", &res);
+		dev_dbg(&pdev->dev, "hmem range %pr already active\n", res);
 		goto out_active;
 	}
 
 	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
 	info = (struct memregion_info) {
 		.target_node = target_nid,
+		.range = {
+			.start = res->start,
+			.end = res->end,
+		},
 	};
 	rc = platform_device_add_data(pdev, &info, sizeof(info));
 	if (rc < 0) {
-		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
-		goto out_resource;
-	}
-
-	rc = platform_device_add_resources(pdev, &res, 1);
-	if (rc < 0) {
-		pr_err("hmem resource allocation failure for %pr\n", &res);
+		pr_err("hmem memregion_info allocation failure for %pr\n", res);
 		goto out_resource;
 	}
 
 	rc = platform_device_add(pdev);
 	if (rc < 0) {
-		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
+		dev_err(&pdev->dev, "device add failed for %pr\n", res);
 		goto out_resource;
 	}
 
 	return;
 
 out_resource:
-	__release_region(&hmem_active, res.start, resource_size(&res));
+	__release_region(&hmem_active, res->start, resource_size(res));
 out_active:
 	platform_device_put(pdev);
 out_pdev:
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c7351e0dc8ff..5025a8c9850b 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -15,25 +15,17 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	struct memregion_info *mri;
 	struct dev_dax_data data;
 	struct dev_dax *dev_dax;
-	struct resource *res;
-	struct range range;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
 
 	mri = dev->platform_data;
-	range.start = res->start;
-	range.end = res->end;
-	dax_region = alloc_dax_region(dev, pdev->id, &range, mri->target_node,
-			PMD_SIZE, 0);
+	dax_region = alloc_dax_region(dev, pdev->id, &mri->range,
+				      mri->target_node, PMD_SIZE, 0);
 	if (!dax_region)
 		return -ENOMEM;
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = region_idle ? 0 : resource_size(res),
+		.size = region_idle ? 0 : range_len(&mri->range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index bf83363807ac..c01321467789 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -3,10 +3,12 @@
 #define _MEMREGION_H_
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/range.h>
 #include <linux/bug.h>
 
 struct memregion_info {
 	int target_node;
+	struct range range;
 };
 
 #ifdef CONFIG_MEMREGION

