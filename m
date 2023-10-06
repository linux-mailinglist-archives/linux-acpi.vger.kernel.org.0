Return-Path: <linux-acpi+bounces-487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CE7BBEC5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA671C20868
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015538F84
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5vKD2Bu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87930FBE
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 17:31:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35BFC;
	Fri,  6 Oct 2023 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613487; x=1728149487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/SGBfl7Je7pNa8w+6+4h+GBn7+eWQRv7gJpu1bn1/k=;
  b=l5vKD2Bu75Gd1SqYYVfQm9CuZv3+lXZ4ffvgFhPkXrPg0F4aGMaAaNaw
   gL7WJRVuJ701z1DVW2K0JCkHVf/I7gzRXtto87Yq09UKb/KG2rFi3mzuX
   e3QlYDiiWIest8wYSWuvymgL9BzT+rnYBL57kjjYiBRmhfoGZOhyUSFzo
   ni/MhQl05kxRLlg1RedyIs/skvQ2UELq/tfduAO6XaV97mIVCmiYVF8zB
   ofDpqMyknITprcZ7YZKhrwoc0vE2hieEn2HySuAamd0sUxN18Nap9PK7g
   BdlNIfmplEXfAUzIIkgAaPcLbh6eQJQr/It4lgzuvUj6Ew7palHBtx3Rp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387676836"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387676836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745937517"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745937517"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:23 -0700
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
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with platform_driver
Date: Fri,  6 Oct 2023 20:30:54 +0300
Message-ID: <20231006173055.2938160-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006173055.2938160-1-michal.wilczynski@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

NFIT driver uses struct acpi_driver incorrectly to register itself.
This is wrong as the instances of the ACPI devices are not meant
to be literal devices, they're supposed to describe ACPI entry of a
particular device.

Use platform_driver instead of acpi_driver. In relevant places call
platform devices instances pdev to make a distinction with ACPI
devices instances.

NFIT driver uses devm_*() family of functions extensively. This change
has no impact on correct functioning of the whole devm_*() family of
functions, since the lifecycle of the device stays the same. It is still
being created during the enumeration, and destroyed on platform device
removal.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 942b84d94078..fb0bc16fa186 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -15,6 +15,7 @@
 #include <linux/sort.h>
 #include <linux/io.h>
 #include <linux/nd.h>
+#include <linux/platform_device.h>
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
@@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
 		return NULL;
 
-	return to_acpi_device(acpi_desc->dev);
+	return ACPI_COMPANION(acpi_desc->dev);
 }
 
 static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
@@ -3284,11 +3285,11 @@ static void acpi_nfit_put_table(void *table)
 
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, handle, event);
-	device_unlock(&adev->dev);
+	device_lock(dev);
+	__acpi_nfit_notify(dev, handle, event);
+	device_unlock(dev);
 }
 
 static void acpi_nfit_remove_notify_handler(void *data)
@@ -3329,11 +3330,12 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
-static int acpi_nfit_add(struct acpi_device *adev)
+static int acpi_nfit_probe(struct platform_device *pdev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_nfit_desc *acpi_desc;
-	struct device *dev = &adev->dev;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
 	acpi_size sz;
@@ -3360,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
 		return -ENOMEM;
-	acpi_nfit_desc_init(acpi_desc, &adev->dev);
+	acpi_nfit_desc_init(acpi_desc, dev);
 
 	/* Save the acpi header for exporting the revision via sysfs */
 	acpi_desc->acpi_header = *tbl;
@@ -3391,7 +3393,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 		return rc;
 
 	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify, adev);
+					     acpi_nfit_notify, dev);
 	if (rc)
 		return rc;
 
@@ -3475,11 +3477,11 @@ static const struct acpi_device_id acpi_nfit_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
-static struct acpi_driver acpi_nfit_driver = {
-	.name = KBUILD_MODNAME,
-	.ids = acpi_nfit_ids,
-	.ops = {
-		.add = acpi_nfit_add,
+static struct platform_driver acpi_nfit_driver = {
+	.probe = acpi_nfit_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.acpi_match_table = acpi_nfit_ids,
 	},
 };
 
@@ -3517,7 +3519,7 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
-	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	ret = platform_driver_register(&acpi_nfit_driver);
 	if (ret) {
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
@@ -3530,7 +3532,7 @@ static __init int nfit_init(void)
 static __exit void nfit_exit(void)
 {
 	nfit_mce_unregister();
-	acpi_bus_unregister_driver(&acpi_nfit_driver);
+	platform_driver_unregister(&acpi_nfit_driver);
 	destroy_workqueue(nfit_wq);
 	WARN_ON(!list_empty(&acpi_descs));
 }
-- 
2.41.0


