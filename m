Return-Path: <linux-acpi+bounces-671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857667CB2B3
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BD3B207C7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9933992
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDzwNO9l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4D168DE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:01:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964330E9;
	Mon, 16 Oct 2023 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475712; x=1729011712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWrZJva5wG+790MFHsyIaJ0RzDiu+hSencDWcGkJyIg=;
  b=KDzwNO9lsyyJoPY3Q75oWjJ8J+Sdiy9sNzjK1EW0wOIZ8F++QBZZsLBn
   xs5GSgWvwv49npEfAr+2lxNADv4gsFYCRJkjVpoNp0Il15KQd2Q0yh01C
   Zm0YVCHRsyMfEJzA4OeMbuUnnA/+vFXsfV2iNO9rxFtxibF28mWHe9/Ti
   HtAYj1GyOMUg4GL8+IxMGGFo6tBODQQBVpKHWCpGByifhzWZvSSPhjYOh
   Z/xYq/zGYWczopGMMYjA/NhNhJHdn5QfHhPTY/SeOap9Xf3eooeub3gI7
   TK5n1HOGR2LYQSg5ld1bzjhXd1B/5vD9fLkn63Mh9qbKg7y05dNtOLTIp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385427243"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385427243"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087133858"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087133858"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:35 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 1/3] ACPI: acpi_pad: Replace acpi_driver with platform_driver
Date: Mon, 16 Oct 2023 20:01:23 +0300
Message-ID: <20231016170125.576159-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016170125.576159-1-michal.wilczynski@intel.com>
References: <20231016170125.576159-1-michal.wilczynski@intel.com>
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
 drivers/acpi/acpi_pad.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 7a453c5ff303..36e1049833a3 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
@@ -413,16 +414,16 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 	mutex_unlock(&isolated_cpus_lock);
 }
 
-static void acpi_pad_notify(acpi_handle handle, u32 event,
-	void *data)
+static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
+	struct device *dev = data;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-			dev_name(&device->dev), event, 0);
+						dev_name(dev), event, 0);
 		break;
 	default:
 		pr_warn("Unsupported event [0x%x]\n", event);
@@ -430,8 +431,10 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 	}
 }
 
-static int acpi_pad_add(struct acpi_device *device)
+static int acpi_pad_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	acpi_status status;
 
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
@@ -441,7 +444,9 @@ static int acpi_pad_add(struct acpi_device *device)
 		return -ENODEV;
 
 	status = acpi_install_notify_handler(device->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_pad_notify,
+					     dev);
 	if (ACPI_FAILURE(status)) {
 		acpi_pad_remove_sysfs(device);
 		return -ENODEV;
@@ -450,14 +455,17 @@ static int acpi_pad_add(struct acpi_device *device)
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
 
 	acpi_remove_notify_handler(device->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
+				   ACPI_DEVICE_NOTIFY,
+				   acpi_pad_notify);
 	acpi_pad_remove_sysfs(device);
 }
 
@@ -467,13 +475,12 @@ static const struct acpi_device_id pad_device_ids[] = {
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
 
@@ -487,12 +494,12 @@ static int __init acpi_pad_init(void)
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


