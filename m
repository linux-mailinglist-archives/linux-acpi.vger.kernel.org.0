Return-Path: <linux-acpi+bounces-90-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552AD7ADD26
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 052EB281D10
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B11D6A9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17F1C290
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 14:49:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF1115;
	Mon, 25 Sep 2023 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653371; x=1727189371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udNVWtN1gsWM7DD6E00ZbxnbAjYrIGT/BzPOH3ZhiRo=;
  b=GO1gFzNFI0U4XW/tjGCm7tqbvUj771rkCZ8li1VEzXDiHlwZQtITX089
   T+2I2OajF8Spl7AQGG1Y8eNfnmLC5maFnxP3g/M4XPb+FYxvNjRBWjtZM
   dP1UqBNVL1JGLpcbs8qfCTDYwH+PIBos+GlskCyspVq/loz1SdYiXd8Zr
   POY5d+u2w3npX7HzDcqeY6sAoiwLpFCOoGGBLUr44lkir49Qe6LD+6OII
   kNjy4Qu2AMLmCbVWPL4Np2Z3tCGUJ4/dbQ48RPTZlTt/CVCvp+AshcH9q
   yQ5pljCFvbc9W68JLx6CeWmGcuVWYP3GWVPQcnqyY94G+74SM60yqllRL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378548072"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378548072"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409490"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409490"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:27 -0700
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
	rui.zhang@intel.com,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 5/9] ACPI: AC: Replace acpi_driver with platform_driver
Date: Mon, 25 Sep 2023 17:48:38 +0300
Message-ID: <20230925144842.586829-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
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

AC driver uses struct acpi_driver incorrectly to register itself. This
is wrong as the instances of the ACPI devices are not meant to
be literal devices, they're supposed to describe ACPI entry of a
particular device.

Use platform_driver instead of acpi_driver. In relevant places call
platform devices instances pdev to make a distinction with ACPI
devices instances.

Drop unnecessary casts from acpi_bus_generate_netlink_event() and
acpi_notifier_call_chain().

Add a blank line to distinguish pdev API vs local ACPI notify function.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index fd8b392c19f4..78e53d0fdece 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -33,8 +33,9 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_ac_add(struct acpi_device *device);
-static void acpi_ac_remove(struct acpi_device *device);
+static int acpi_ac_probe(struct platform_device *pdev);
+static void acpi_ac_remove(struct platform_device *pdev);
+
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id ac_device_ids[] = {
@@ -51,21 +52,10 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 static int ac_sleep_before_get_state_ms;
 static int ac_only;
 
-static struct acpi_driver acpi_ac_driver = {
-	.name = "ac",
-	.class = ACPI_AC_CLASS,
-	.ids = ac_device_ids,
-	.ops = {
-		.add = acpi_ac_add,
-		.remove = acpi_ac_remove,
-		},
-	.drv.pm = &acpi_ac_pm,
-};
-
 struct acpi_ac {
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
-	struct acpi_device *device;
+	struct device *dev;
 	unsigned long long state;
 	struct notifier_block battery_nb;
 };
@@ -85,10 +75,10 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 		return 0;
 	}
 
-	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
+	status = acpi_evaluate_integer(ACPI_HANDLE(ac->dev), "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_info(ac->device->handle,
+		acpi_handle_info(ACPI_HANDLE(ac->dev),
 				"Error reading AC Adapter state: %s\n",
 				acpi_format_exception(status));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
@@ -129,12 +119,12 @@ static enum power_supply_property ac_props[] = {
 /* Driver Model */
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_ac *ac = data;
+	struct acpi_device *device = ACPI_COMPANION(ac->dev);
 
 	switch (event) {
 	default:
-		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+		acpi_handle_debug(ACPI_HANDLE(ac->dev), "Unsupported event [0x%x]\n",
 				  event);
 		fallthrough;
 	case ACPI_AC_NOTIFY_STATUS:
@@ -152,9 +142,10 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  (u32) ac->state);
-		acpi_notifier_call_chain(device, event, (u32) ac->state);
+						dev_name(ac->dev),
+						event,
+						ac->state);
+		acpi_notifier_call_chain(device, event, ac->state);
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
 }
@@ -211,8 +202,9 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 	{},
 };
 
-static int acpi_ac_add(struct acpi_device *device)
+static int acpi_ac_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
 	struct acpi_ac *ac;
 	int result;
@@ -221,10 +213,11 @@ static int acpi_ac_add(struct acpi_device *device)
 	if (!ac)
 		return -ENOMEM;
 
-	ac->device = device;
+	ac->dev = &pdev->dev;
 	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
-	device->driver_data = ac;
+
+	platform_set_drvdata(pdev, ac);
 
 	result = acpi_ac_get_state(ac);
 	if (result)
@@ -237,7 +230,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger_desc.get_property = get_ac_property;
-	ac->charger = power_supply_register(&ac->device->dev,
+	ac->charger = power_supply_register(&pdev->dev,
 					    &ac->charger_desc, &psy_cfg);
 	if (IS_ERR(ac->charger)) {
 		result = PTR_ERR(ac->charger);
@@ -251,7 +244,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	register_acpi_notifier(&ac->battery_nb);
 
 	result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify, device);
+						 acpi_ac_notify, ac);
 	if (result)
 		goto err_unregister;
 
@@ -269,7 +262,7 @@ static int acpi_ac_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev)
 {
-	struct acpi_ac *ac = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ac *ac = dev_get_drvdata(dev);
 	unsigned int old_state;
 
 	old_state = ac->state;
@@ -284,11 +277,12 @@ static int acpi_ac_resume(struct device *dev)
 #define acpi_ac_resume NULL
 #endif
 
-static void acpi_ac_remove(struct acpi_device *device)
+static void acpi_ac_remove(struct platform_device *pdev)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_ac *ac = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(ACPI_HANDLE(ac->dev),
+				       ACPI_ALL_NOTIFY,
 				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
@@ -296,6 +290,16 @@ static void acpi_ac_remove(struct acpi_device *device)
 	kfree(ac);
 }
 
+static struct platform_driver acpi_ac_driver = {
+	.probe = acpi_ac_probe,
+	.remove_new = acpi_ac_remove,
+	.driver = {
+		.name = "ac",
+		.acpi_match_table = ac_device_ids,
+		.pm = &acpi_ac_pm,
+	},
+};
+
 static int __init acpi_ac_init(void)
 {
 	int result;
@@ -308,7 +312,7 @@ static int __init acpi_ac_init(void)
 
 	dmi_check_system(ac_dmi_table);
 
-	result = acpi_bus_register_driver(&acpi_ac_driver);
+	result = platform_driver_register(&acpi_ac_driver);
 	if (result < 0)
 		return -ENODEV;
 
@@ -317,7 +321,7 @@ static int __init acpi_ac_init(void)
 
 static void __exit acpi_ac_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_ac_driver);
+	platform_driver_unregister(&acpi_ac_driver);
 }
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
-- 
2.41.0


