Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A1706202
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjEQH7S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEQH6i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57272E4
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310317; x=1715846317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qztspbuvFvAW/W8wYhffgZucSx6tOdeUUrglpHXvAY=;
  b=XZXoXmy8FX4oH5Z81J0Bezddbfs+uSWzjvyw5Qe0sJVcYfS0z1XW3KOQ
   mdl6IBq6HhxHIdnXqcXUhBrCLdBX7EuKH56C99mgcaAuR+lA7Bq8ZKJWy
   zosNTHIeqqRnVVZFuqb1CZgZN5E1PP/EPVYlFrn8XW2zKG6N9VxNWO9yD
   v/kV/WVLBXfKg+XBjtpqEbUEbEe91eV6z30yfAUKHrH5xgXrLRn9cUwzw
   HLd2/mgmSaj6wL91YdPDXdlMPu7qgqZFMs/tGmoERiwuioF1PyTZd+hfW
   VrIiIyNPHMzPfUaxa1uKrPi5tK3+lhrpw7wrV8hK8mRRGimBnUPVwu/5c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105487"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877489"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877489"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:35 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 26/34] platform/x86/toshiba_acpi: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:16 +0200
Message-Id: <20230517075724.153992-27-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c | 131 +++++++++++++++-------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index b34984bbee33..628c7910d653 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3186,10 +3186,74 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 	pr_cont("\n");
 }
 
+static void toshiba_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *acpi_dev = data;
+	struct toshiba_acpi_dev *dev;
+
+	dev = acpi_driver_data(acpi_dev);
+
+	switch (event) {
+	case 0x80: /* Hotkeys and some system events */
+		/*
+		 * Machines with this WMI GUID aren't supported due to bugs in
+		 * their AML.
+		 *
+		 * Return silently to avoid triggering a netlink event.
+		 */
+		if (wmi_has_guid(TOSHIBA_WMI_EVENT_GUID))
+			return;
+		toshiba_acpi_process_hotkeys(dev);
+		break;
+	case 0x81: /* Dock events */
+	case 0x82:
+	case 0x83:
+		pr_info("Dock event received %x\n", event);
+		break;
+	case 0x88: /* Thermal events */
+		pr_info("Thermal event received\n");
+		break;
+	case 0x8f: /* LID closed */
+	case 0x90: /* LID is closed and Dock has been ejected */
+		break;
+	case 0x8c: /* SATA power events */
+	case 0x8b:
+		pr_info("SATA power event received %x\n", event);
+		break;
+	case 0x92: /* Keyboard backlight mode changed */
+		dev->kbd_event_generated = true;
+		/* Update sysfs entries */
+		if (sysfs_update_group(&acpi_dev->dev.kobj,
+				       &toshiba_attr_group))
+			pr_err("Unable to update sysfs entries\n");
+		/* Notify LED subsystem about keyboard backlight change */
+		if (dev->kbd_type == 2 && dev->kbd_mode != SCI_KBD_MODE_AUTO)
+			led_classdev_notify_brightness_hw_changed(&dev->kbd_led,
+					(dev->kbd_mode == SCI_KBD_MODE_ON) ?
+					LED_FULL : LED_OFF);
+		break;
+	case 0x85: /* Unknown */
+	case 0x8d: /* Unknown */
+	case 0x8e: /* Unknown */
+	case 0x94: /* Unknown */
+	case 0x95: /* Unknown */
+	default:
+		pr_info("Unknown event received %x\n", event);
+		break;
+	}
+
+	acpi_bus_generate_netlink_event(acpi_dev->pnp.device_class,
+					dev_name(&acpi_dev->dev),
+					event, (event == 0x80) ?
+					dev->last_key_event : 0);
+}
+
 static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
 
+	acpi_device_remove_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_acpi_notify);
+
 	misc_deregister(&dev->miscdev);
 
 	remove_toshiba_proc_entries(dev);
@@ -3473,72 +3537,17 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (dev->battery_charge_mode_supported)
 		battery_hook_register(&battery_hook);
 
-	return 0;
+	ret = acpi_device_install_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_acpi_notify);
+	if (ret)
+		goto error;
+
+	return ret;
 
 error:
 	toshiba_acpi_remove(acpi_dev);
 	return ret;
 }
 
-static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
-{
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
-
-	switch (event) {
-	case 0x80: /* Hotkeys and some system events */
-		/*
-		 * Machines with this WMI GUID aren't supported due to bugs in
-		 * their AML.
-		 *
-		 * Return silently to avoid triggering a netlink event.
-		 */
-		if (wmi_has_guid(TOSHIBA_WMI_EVENT_GUID))
-			return;
-		toshiba_acpi_process_hotkeys(dev);
-		break;
-	case 0x81: /* Dock events */
-	case 0x82:
-	case 0x83:
-		pr_info("Dock event received %x\n", event);
-		break;
-	case 0x88: /* Thermal events */
-		pr_info("Thermal event received\n");
-		break;
-	case 0x8f: /* LID closed */
-	case 0x90: /* LID is closed and Dock has been ejected */
-		break;
-	case 0x8c: /* SATA power events */
-	case 0x8b:
-		pr_info("SATA power event received %x\n", event);
-		break;
-	case 0x92: /* Keyboard backlight mode changed */
-		dev->kbd_event_generated = true;
-		/* Update sysfs entries */
-		if (sysfs_update_group(&acpi_dev->dev.kobj,
-				       &toshiba_attr_group))
-			pr_err("Unable to update sysfs entries\n");
-		/* Notify LED subsystem about keyboard backlight change */
-		if (dev->kbd_type == 2 && dev->kbd_mode != SCI_KBD_MODE_AUTO)
-			led_classdev_notify_brightness_hw_changed(&dev->kbd_led,
-					(dev->kbd_mode == SCI_KBD_MODE_ON) ?
-					LED_FULL : LED_OFF);
-		break;
-	case 0x85: /* Unknown */
-	case 0x8d: /* Unknown */
-	case 0x8e: /* Unknown */
-	case 0x94: /* Unknown */
-	case 0x95: /* Unknown */
-	default:
-		pr_info("Unknown event received %x\n", event);
-		break;
-	}
-
-	acpi_bus_generate_netlink_event(acpi_dev->pnp.device_class,
-					dev_name(&acpi_dev->dev),
-					event, (event == 0x80) ?
-					dev->last_key_event : 0);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int toshiba_acpi_suspend(struct device *device)
 {
@@ -3583,11 +3592,9 @@ static struct acpi_driver toshiba_acpi_driver = {
 	.name	= "Toshiba ACPI driver",
 	.owner	= THIS_MODULE,
 	.ids	= toshiba_device_ids,
-	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops	= {
 		.add		= toshiba_acpi_add,
 		.remove		= toshiba_acpi_remove,
-		.notify		= toshiba_acpi_notify,
 	},
 	.drv.pm	= &toshiba_acpi_pm,
 };
-- 
2.40.1

