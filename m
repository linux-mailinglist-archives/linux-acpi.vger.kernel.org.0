Return-Path: <linux-acpi+bounces-751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B17CE91F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED43B20D80
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B989CA46
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDXN7cTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262341E3D
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 19:10:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198F118;
	Wed, 18 Oct 2023 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656210; x=1729192210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEuW3yOtEdU/a1Okhs6bGa5lUXS9niTft/NxC06rI0c=;
  b=IDXN7cTJTCO41KiM+8cf8PhjVgxbEyVa2fJxQFtizrg1qX0BGLHxgC6t
   sRsAuKJsQstgj7Lrh+sI4SEeNBNkl/XxDETI+89Egc8ggWS4XXy2U6Lkg
   2Dmm1L1xr/384ZK3o91EbCZKFSo3FxdO8fohHjMr96yJy6CX23yCHa2PS
   SYCmHB/BE924gXJGHC7QbtDvwQW2YDF7FK8Qyyh05+2afVpThtQhli47j
   g6qtgI87L7LgSx++5ZVmUpl/P22y2xctziVR/vdzAP8e5w+mj/rLAHlNT
   okMu81zWEQkzBxuiCCHwGpJm3it+cQzqruE548EFd8frOzcYuO03bByOH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323315"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323315"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277283"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277283"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:08 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 1/3] ACPI: acpi_pad: Replace acpi_driver with platform_driver
Date: Wed, 18 Oct 2023 22:09:43 +0300
Message-ID: <20231018190945.252428-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018190945.252428-1-michal.wilczynski@intel.com>
References: <20231018190945.252428-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_pad driver uses struct acpi_driver to register itself while it
would be more logically consistent to use struct platform_driver for this
purpose, because the corresponding platform device is present and the
role of struct acpi_device is to amend the other bus types. ACPI devices
are not meant to be used as proper representation of hardware entities,
but to collect information on those hardware entities provided by the
platform firmware.

Use struct platform_driver for registering the acpi_pad driver.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 7a453c5ff303..25068f2c5b4d 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
@@ -430,8 +431,9 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 	}
 }
 
-static int acpi_pad_add(struct acpi_device *device)
+static int acpi_pad_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
@@ -450,8 +452,10 @@ static int acpi_pad_add(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_pad_remove(struct acpi_device *device)
+static void acpi_pad_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
@@ -467,13 +471,12 @@ static const struct acpi_device_id pad_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, pad_device_ids);
 
-static struct acpi_driver acpi_pad_driver = {
-	.name = "processor_aggregator",
-	.class = ACPI_PROCESSOR_AGGREGATOR_CLASS,
-	.ids = pad_device_ids,
-	.ops = {
-		.add = acpi_pad_add,
-		.remove = acpi_pad_remove,
+static struct platform_driver acpi_pad_driver = {
+	.probe = acpi_pad_probe,
+	.remove_new = acpi_pad_remove,
+	.driver = {
+		.name = "processor_aggregator",
+		.acpi_match_table = pad_device_ids,
 	},
 };
 
@@ -487,12 +490,12 @@ static int __init acpi_pad_init(void)
 	if (power_saving_mwait_eax == 0)
 		return -EINVAL;
 
-	return acpi_bus_register_driver(&acpi_pad_driver);
+	return platform_driver_register(&acpi_pad_driver);
 }
 
 static void __exit acpi_pad_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_pad_driver);
+	platform_driver_unregister(&acpi_pad_driver);
 }
 
 module_init(acpi_pad_init);
-- 
2.41.0


