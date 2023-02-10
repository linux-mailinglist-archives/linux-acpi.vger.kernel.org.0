Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C52691AD9
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjBJJIa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBJJHk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:07:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205F40E9;
        Fri, 10 Feb 2023 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020023; x=1707556023;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsFyJVK/yMU8PeF2io/JqvsaT5S0XIoYNB1iom5H8o0=;
  b=JpzUwbbIq7mBgQ76cYlGttvVrllYFRZIMo2utqs504MfwtOzmIKGk11s
   9zvC9MDsNi3qJaHVmgZMRyLPlUnDrQhJ03Kv127dIlpjhFW65/EAeem3L
   9FLvsfClekL6jF6VFRsRJdaPjAmXbnuNjgQQX2NnNAjjDXkaXuwv5MQ1X
   nsp+nMGUelTNnT4+autqwJzpZRMsq7PHYjD8kQsCf7kX+77vvJJIMm5Rv
   CE2voMLjtpZny5aR37vgxgQWqMEJu5H4ejPdjBE2G6B41jWxKKS9s2cKI
   9dsrk7Z/dXQvQBLj+cMXJpBiAgojgurO9G2qYBVaA09CAPY757JJ7wXRi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328062621"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328062621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:07:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700392901"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="700392901"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:07:02 -0800
Subject: [PATCH v2 17/20] dax/hmem: Convey the dax range via memregion_info()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:07:02 -0800
Message-ID: <167602002217.1924368.7036275892522551624.stgit@dwillia2-xfh.jf.intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564543303.847146.11045895213318648441.stgit@dwillia2-xfh.jf.intel.com
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

