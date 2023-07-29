Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BA767C16
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jul 2023 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjG2EVH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Jul 2023 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjG2EVG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jul 2023 00:21:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48A49D5
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690604465; x=1722140465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LS9NKUVBF9Rsq5yoaG30RGLhDyd1qnIFZRdjliZUYk4=;
  b=X3Bm062TgIjk/iH57K+2RXnvZX6hKJbw4b+4FhT3MzlQntRiZJ4faYIH
   fUZuxGpVRQuVomUh6/mM2rXDYJSxNByrJTDd0v/I//ioch73k1BQWMI5M
   bd3zC6QKDg18EtM+5IXiSrPJGyiBQ1op44D6U0B1Ot8HKXMCyYUqn+qGy
   Z4QsRdP/GnUiZuA7PNk+HdWKiuWYFMp8GwFBVv9EBSwBwgULHbROCZPDG
   ZTgR8R/CJy7o5ilimjEB7TGm1xnPebu2qAbkPMFWB37HGyEbbGs/Zn0cM
   QYt8aPRFovSXY3Idxkfz3Csm2XkS+6n5Fiu5B5HIGvD9FiOz7RWbIG0ag
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="353634257"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="353634257"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 21:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="974286630"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="974286630"
Received: from wenkel1x-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.183])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 21:21:00 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: acpi_tad: Install SystemCMOS address space handler for ACPI000E
Date:   Sat, 29 Jul 2023 12:20:50 +0800
Message-Id: <20230729042050.4413-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently, the SystemCMOS address space handler is installed for the
ACPI RTC devices (PNP0B00/PNP0B01/PNP0B02) only. But there are platforms
with SystemCMOS Operetion Region defined under the ACPI Time and Alarm
Device (ACPI000E), which is used by the ACPI pre-defined control methods
like _GRT (Get the Real time) and _SRT (Set the Real time).

When accessing these control methods via the acpi_tad sysfs interface,
missing SystemCMOS address space handler causes errors like below
[  478.255453] ACPI Error: No handler for Region [RTCM] (00000000a8d2dd39) [SystemCMOS] (20230331/evregion-130)
[  478.255458] ACPI Error: Region SystemCMOS (ID=5) has no handler (20230331/exfldio-261)
[  478.255461] Initialized Local Variables for Method [_GRT]:
[  478.255461]   Local1: 00000000f182542c <Obj>           Integer 0000000000000000
[  478.255464] No Arguments are initialized for method [_GRT]
[  478.255465] ACPI Error: Aborting method \_SB.AWAC._GRT due to previous error (AE_NOT_EXIST) (20230331/psparse-529)

Export two APIs for SystemCMOS address space handler from acpi_cmos_rtc
scan handler and install the handler for the ACPI Time and Alarm
Device from acpi_tad driver.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217714
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_cmos_rtc.c | 25 ++++++++++++++++++-------
 drivers/acpi/acpi_tad.c      | 26 +++++++++++++++++++++-----
 include/acpi/acpi_bus.h      |  9 +++++++++
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 4cf4aef7ce0c..9b55d1593d16 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -51,12 +51,11 @@ acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
 	return AE_OK;
 }
 
-static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
-		const struct acpi_device_id *id)
+int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 {
 	acpi_status status;
 
-	status = acpi_install_address_space_handler(adev->handle,
+	status = acpi_install_address_space_handler(handle,
 			ACPI_ADR_SPACE_CMOS,
 			&acpi_cmos_rtc_space_handler,
 			NULL, NULL);
@@ -67,18 +66,30 @@ static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
 
-static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
+void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
-	if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
+	if (ACPI_FAILURE(acpi_remove_address_space_handler(handle,
 			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
 		pr_err("Error removing CMOS-RTC region handler\n");
 }
+EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
+
+static int acpi_cmos_rtc_attach_handler(struct acpi_device *adev, const struct acpi_device_id *id)
+{
+	return acpi_install_cmos_rtc_space_handler(adev->handle);
+}
+
+static void acpi_cmos_rtc_detach_handler(struct acpi_device *adev)
+{
+	acpi_remove_cmos_rtc_space_handler(adev->handle);
+}
 
 static struct acpi_scan_handler cmos_rtc_handler = {
 	.ids = acpi_cmos_rtc_ids,
-	.attach = acpi_install_cmos_rtc_space_handler,
-	.detach = acpi_remove_cmos_rtc_space_handler,
+	.attach = acpi_cmos_rtc_attach_handler,
+	.detach = acpi_cmos_rtc_detach_handler,
 };
 
 void __init acpi_cmos_rtc_init(void)
diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index e9b8e8305e23..36ba6827d912 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -557,6 +557,7 @@ static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
 static int acpi_tad_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
 
 	device_init_wakeup(dev, false);
@@ -577,6 +578,7 @@ static int acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	acpi_remove_cmos_rtc_space_handler(handle);
 	return 0;
 }
 
@@ -589,6 +591,11 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	unsigned long long caps;
 	int ret;
 
+	ret = acpi_install_cmos_rtc_space_handler(handle);
+	if (ret < 0) {
+		dev_info(dev, "Unable to install space handler\n");
+		return -ENODEV;
+	}
 	/*
 	 * Initialization failure messages are mostly about firmware issues, so
 	 * print them at the "info" level.
@@ -596,22 +603,27 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	status = acpi_evaluate_integer(handle, "_GCP", NULL, &caps);
 	if (ACPI_FAILURE(status)) {
 		dev_info(dev, "Unable to get capabilities\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto remove_handler;
 	}
 
 	if (!(caps & ACPI_TAD_AC_WAKE)) {
 		dev_info(dev, "Unsupported capabilities\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto remove_handler;
 	}
 
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto remove_handler;
 	}
 
 	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
-	if (!dd)
-		return -ENOMEM;
+	if (!dd) {
+		ret = -ENOMEM;
+		goto remove_handler;
+	}
 
 	dd->capabilities = caps;
 	dev_set_drvdata(dev, dd);
@@ -653,6 +665,10 @@ static int acpi_tad_probe(struct platform_device *pdev)
 
 fail:
 	acpi_tad_remove(pdev);
+	/* Don't fallthrough because cmos rtc space handler is removed in acpi_tad_remove() */
+	return ret;
+remove_handler:
+	acpi_remove_cmos_rtc_space_handler(handle);
 	return ret;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c941d99162c0..fb95fff23e5b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -645,6 +645,8 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 #ifdef CONFIG_X86
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
+int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
+void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
@@ -655,6 +657,13 @@ static inline bool acpi_quirk_skip_acpi_ac_and_battery(void)
 {
 	return false;
 }
+static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
+{
+	return 1;
+}
+static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
+{
+}
 #endif
 
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
-- 
2.34.1

