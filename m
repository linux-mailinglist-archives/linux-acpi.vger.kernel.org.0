Return-Path: <linux-acpi+bounces-158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B57AF535
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EDD23283421
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4D48EB1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC6450FE
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 18:45:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B911F;
	Tue, 26 Sep 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753943; x=1727289943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsIV3Q3gcUAc21rNqcq+g99sj4f1HzfeIQJnfu00KFE=;
  b=aCdntd0tivFkxDS9b5DH2iVc0G0cRPyBa8PhfEFalxHJkRknJ5s0gvjx
   img5RTQhfHysyg8Y+wmEj9UyN6iHsiW0XpyfuSuoOvjBBp9mTdtcFzeb0
   Ko182z3tkAMKVCsQsGYA5zFJBq/0Gv/VK/AHQzlU9d4mU2a71n+wV8Xcw
   I0cTdD8iQhtzR93tDdCbUqch1Nh61YXlgM+WclLFInaelnpXOwzWzvGbP
   HCYGD4OPy3zPOZlsnKnOwUpV9VkFpWHNfhMZEaji1MVAe6fyPLpNYs/B/
   1Xfzg0rsGxZJTO/PbU0AT78JBSqLfhXC67hu4qgXw+qiKj0RhtKauTabR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378920271"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378920271"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752279646"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752279646"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:34 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@intel.com,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] ACPI: NFIT: Use modern scope based rollback
Date: Tue, 26 Sep 2023 21:45:20 +0300
Message-ID: <20230926184520.2239723-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926184520.2239723-1-michal.wilczynski@intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change rollback in acpi_nfit_init_interleave_set() to use modern scope
based attribute __free(). This is similar to C++ RAII and is a preferred
way for handling local memory allocations.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 78f0f855c4de..079bd663495f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2257,29 +2257,23 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 		struct nd_region_desc *ndr_desc,
 		struct acpi_nfit_system_address *spa)
 {
+	u16 nr = ndr_desc->num_mappings;
+	struct nfit_set_info2 *info2 __free(kfree) =
+		kcalloc(nr, sizeof(*info2), GFP_KERNEL);
+	struct nfit_set_info *info __free(kfree) =
+		kcalloc(nr, sizeof(*info), GFP_KERNEL);
 	struct device *dev = acpi_desc->dev;
 	struct nd_interleave_set *nd_set;
-	u16 nr = ndr_desc->num_mappings;
-	struct nfit_set_info2 *info2;
-	struct nfit_set_info *info;
-	int err = 0;
 	int i;
 
+	if (!info || !info2)
+		return -ENOMEM;
+
 	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
 	if (!nd_set)
 		return -ENOMEM;
 	import_guid(&nd_set->type_guid, spa->range_guid);
 
-	info = kcalloc(nr, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info2 = kcalloc(nr, sizeof(*info2), GFP_KERNEL);
-	if (!info2) {
-		err = -ENOMEM;
-		goto free_info;
-	}
-
 	for (i = 0; i < nr; i++) {
 		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
 		struct nvdimm *nvdimm = mapping->nvdimm;
@@ -2292,8 +2286,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 		if (!memdev || !nfit_mem->dcr) {
 			dev_err(dev, "%s: failed to find DCR\n", __func__);
-			err = -ENODEV;
-			goto free_info2;
+			return -ENODEV;
 		}
 
 		map->region_offset = memdev->region_offset;
@@ -2342,12 +2335,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 
 	ndr_desc->nd_set = nd_set;
 
-free_info2:
-	kfree(info2);
-free_info:
-	kfree(info);
-
-	return err;
+	return 0;
 }
 
 static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,
-- 
2.41.0


