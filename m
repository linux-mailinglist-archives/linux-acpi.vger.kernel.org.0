Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EC719E93
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjFANp1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjFANp0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6FF138;
        Thu,  1 Jun 2023 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627124; x=1717163124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HxqltkL7JKuD7ggSNuK4Mso9OsWPDE3czY/YrRlIRVE=;
  b=RXD35E7ezuXnOzuP1Hic1qqUPX/cHdnmAo6vDsGkH3pnH3kZKnG6e16d
   mhNB246MWwdH7P/dmYskPJVWM4sja2OCedW+eGBMDQvE8WSaDv7UYS4p6
   gR86Wmbfdw/b7Xs6gZsdToc1WNPGp0A3/A/sfh76B1zx7xyNyu9nvKjPN
   +m5L0tMCPN60oPOltpdSmxEvotL4NKUZRUlHNISpgutZJh4rIxrh55FB3
   II9jBJ0yw7LtOnXBZKX60QuF7aN6vQZZTTG30Hjd5PINTPEdG2wxk0ISt
   42XLwXY5QAmwFw1vWnRGJh3V0TuxJRWxVexq9w/npD7VoUc6mQqiV0IzG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068235"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068235"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601931"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601931"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:44 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Jonathan Woithe <jwoithe@just42.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 21/35] platform/x86/fujitsu-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:24 +0200
Message-Id: <20230601131739.300760-22-michal.wilczynski@intel.com>
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
 drivers/platform/x86/fujitsu-laptop.c | 86 +++++++++++++++++----------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 085e044e888e..001333edba9f 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -136,6 +136,8 @@ struct fujitsu_laptop {
 
 static struct acpi_device *fext;
 
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data);
+
 /* Fujitsu ACPI interface function */
 
 static int call_fext_func(struct acpi_device *device,
@@ -382,6 +384,37 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 	return 0;
 }
 
+static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+	struct fujitsu_bl *priv;
+	int oldb, newb;
+
+	priv = acpi_driver_data(device);
+
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
+		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
+				 event);
+		sparse_keymap_report_event(priv->input, -1, 1, true);
+		return;
+	}
+
+	oldb = priv->brightness_level;
+	get_lcd_level(device);
+	newb = priv->brightness_level;
+
+	acpi_handle_debug(device->handle,
+			  "brightness button event [%i -> %i]\n", oldb, newb);
+
+	if (oldb == newb)
+		return;
+
+	if (!disable_brightness_adjust)
+		set_lcd_level(device, newb);
+
+	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
+}
+
 static int acpi_fujitsu_bl_add(struct acpi_device *device)
 {
 	struct fujitsu_bl *priv;
@@ -410,37 +443,17 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return fujitsu_backlight_register(device);
-}
+	ret = fujitsu_backlight_register(device);
+	if (ret)
+		return ret;
 
-/* Brightness notify */
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						 acpi_fujitsu_bl_notify);
+}
 
-static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_bl_remove(struct acpi_device *device)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
-	int oldb, newb;
-
-	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
-				 event);
-		sparse_keymap_report_event(priv->input, -1, 1, true);
-		return;
-	}
-
-	oldb = priv->brightness_level;
-	get_lcd_level(device);
-	newb = priv->brightness_level;
-
-	acpi_handle_debug(device->handle,
-			  "brightness button event [%i -> %i]\n", oldb, newb);
-
-	if (oldb == newb)
-		return;
-
-	if (!disable_brightness_adjust)
-		set_lcd_level(device, newb);
-
-	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_bl_notify);
 }
 
 /* ACPI device for hotkey handling */
@@ -839,6 +852,11 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						acpi_fujitsu_laptop_notify);
+	if (ret)
+		goto err_free_fifo;
+
 	return 0;
 
 err_free_fifo:
@@ -851,6 +869,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -889,13 +909,16 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	}
 }
 
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct fujitsu_laptop *priv;
 	unsigned long flags;
 	int scancode, i = 0;
 	unsigned int irb;
 
+	priv = acpi_driver_data(device);
+
 	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
 		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
 				 event);
@@ -947,7 +970,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
 	.ids = fujitsu_bl_device_ids,
 	.ops = {
 		.add = acpi_fujitsu_bl_add,
-		.notify = acpi_fujitsu_bl_notify,
+		.remove = acpi_fujitsu_bl_remove,
 		},
 };
 
@@ -963,7 +986,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.40.1

