Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E6719EAA
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjFANqE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1821E188;
        Thu,  1 Jun 2023 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627162; x=1717163162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/vi7v1x/g1QVLh8luTgsyLNUrAYQyl3fwk+h50LQV4=;
  b=FGzp6qN3xkPhHHjaihWbwenEaA/Mo+V/9eIEKGMkQ1e6ZPjWlX9WI/2V
   4qv13IPk5Hng/s57u1M9nI57zIG51+dZ+6Jwb/YKQMd3yvZYneNu72wag
   xrj8hGAblQgrzZJtfskXVgCCXZzkYeX+ek4litxmqMfMkrbwDqXEp1AEV
   krDxQoU2OfzkJLAIM3ZWzXu23Z1nsRbZIrhTh6DO4xviD4ARKpUCLhuhi
   EUCzn1+vj8bFw6FhDLqubtjNikZ0BTINb0IcaNrWoJcrCkcl5q2ARK6aM
   Z4Gt+2AtpoALvRTN3A3OccHEQ2KfdUdV6BI8VAP8wqCfZh5fpgXkz++39
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068607"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602077"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602077"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:02 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 26/35] platform/x86/toshiba_acpi: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:29 +0200
Message-Id: <20230601131739.300760-27-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/platform/x86/toshiba_acpi.c | 129 +++++++++++++++-------------
 1 file changed, 68 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index b34984bbee33..28d78b018547 100644
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
@@ -3473,6 +3537,10 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (dev->battery_charge_mode_supported)
 		battery_hook_register(&battery_hook);
 
+	ret = acpi_device_install_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_acpi_notify);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -3480,65 +3548,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
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

