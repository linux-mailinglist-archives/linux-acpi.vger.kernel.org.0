Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E55B50F5
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Sep 2022 21:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIKTu3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIKTuZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 15:50:25 -0400
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5E27B35;
        Sun, 11 Sep 2022 12:50:15 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id D67E4147E1;
        Sun, 11 Sep 2022 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662925789; bh=EjX3Rg73KBeN14SjHX82ygQM0k4y/OXVynbrjRmSMt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoWS+GEyUq6175t18Pmey7kYHnPaXuTZlSalTcBAvtQeJFl21ffXWZbWMyeBSvala
         idoF1UBdsiuUhlJaJjnO1tTVuSlKTTYEoazl/aj+WnazkfCwbinajjnljwe3bgDNJz
         vRxqJm3qa2+zFa3OwVibkTcNlV9qmMq7+FJrMN2stdgZLpNPYIltEfMbk9ZHLrII24
         9zHUl1tC58B6PnJeymB4/wEjshu72T0bSmeDoh7fLrzJf3JZd8T30RgoFj0pgltlqO
         1VVnOgqq88XxRhDlz856LDwXcfdNST5w1i6kMYTYpMCryD6EwGLr8JyV5oiLwRbyUR
         FWld8K8V0Dv8w==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH RFC 2/2] platform/x86: toshiba_acpi: Add quirk for buttons on Z830
Date:   Sun, 11 Sep 2022 21:49:34 +0200
Message-Id: <20220911194934.558019-3-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911194934.558019-1-lkml@vorpal.se>
References: <20220911194934.558019-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Z830 has some buttons that will only work properly as "quickstart"
buttons. To enable them in that mode, a value between 1 and 7 must be
used for HCI_HOTKEY_EVENT. Windows uses 0x5 on this laptop so use that for
maximum predictability and compatibility.

As there is not yet a known way of auto detection, this patch uses a DMI
quirk table. A module parameter is exposed to allow setting this on other
models for testing.

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
---
 drivers/platform/x86/toshiba_acpi.c | 31 ++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 9f1394b73895..dce1f5049bf8 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -58,6 +58,11 @@ module_param(turn_on_panel_on_resume, int, 0644);
 MODULE_PARM_DESC(turn_on_panel_on_resume,
 	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
 
+static int hci_hotkey_quickstart = -1;
+module_param(hci_hotkey_quickstart, int, 0644);
+MODULE_PARM_DESC(hci_hotkey_quickstart,
+	"Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-1 = auto, 0 = no, 1 = yes");
+
 #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
 
 /* Scan code for Fn key on TOS1900 models */
@@ -137,6 +142,7 @@ MODULE_PARM_DESC(turn_on_panel_on_resume,
 #define HCI_ACCEL_MASK			0x7fff
 #define HCI_ACCEL_DIRECTION_MASK	0x8000
 #define HCI_HOTKEY_DISABLE		0x0b
+#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
 #define HCI_HOTKEY_ENABLE		0x09
 #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -2731,10 +2737,15 @@ static int toshiba_acpi_enable_hotkeys(struct toshiba_acpi_dev *dev)
 		return -ENODEV;
 
 	/*
+	 * Enable quickstart buttons if supported.
+	 *
 	 * Enable the "Special Functions" mode only if they are
 	 * supported and if they are activated.
 	 */
-	if (dev->kbd_function_keys_supported && dev->special_functions)
+	if (hci_hotkey_quickstart)
+		result = hci_write(dev, HCI_HOTKEY_EVENT,
+				   HCI_HOTKEY_ENABLE_QUICKSTART);
+	else if (dev->kbd_function_keys_supported && dev->special_functions)
 		result = hci_write(dev, HCI_HOTKEY_EVENT,
 				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
 	else
@@ -3287,6 +3298,21 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 	},
 };
 
+/*
+ * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must use
+ * the value HCI_HOTKEY_ENABLE_QUICKSTART.
+ */
+static const struct dmi_system_id hci_hotkey_quickstart_dmi_ids[] = {
+	{
+	 /* Toshiba Satellite/Portégé Z830 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
+		},
+	},
+};
+
+
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev;
@@ -3447,6 +3473,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (turn_on_panel_on_resume == -1)
 		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
 
+	if (hci_hotkey_quickstart == -1)
+		hci_hotkey_quickstart = dmi_check_system(hci_hotkey_quickstart_dmi_ids);
+
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
 		toshiba_acpi_setup_wwan_rfkill(dev);
-- 
2.37.3

