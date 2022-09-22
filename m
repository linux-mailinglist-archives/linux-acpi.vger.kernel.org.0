Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630B5E6AE1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 20:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiIVS2I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiIVS1r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 14:27:47 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB810BB2D;
        Thu, 22 Sep 2022 11:26:00 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 9E859147F2;
        Thu, 22 Sep 2022 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1663871079; bh=OFY9dwdCRbyPOSLKBVEyfR0KTYBzrQGtG4ctexJw8jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSLceP+Kqo4BjLvHDJBACUTfZ1MpFg2YlkKxMieNf7cVZCC2bbdd3gSe6Mv3djAW7
         0w9oTvK6cUjQRJPR5yZbD6AV7jMKREMhFQ/uV9DRz+zo5IWNHQE8++CmD9dbCO3+RA
         //00V+7awtFijVv0913jBB2KRBl902d/yHDDbc5sacrPyTJYAdTdu+h5fGnDbOM6qQ
         cyGcq4IZqx+nOX0rFYSq9fnYtvXjzlOpEhNWCizrPNGLO+IiIRbUG5Q2Nu6+fhGUZN
         P3VlOh0zHHwzfuqvfX511uAa/uy8A9O4oHFCTZsBzP/7JtL8z841nhcXV0JRSMgurn
         1VwE5viUs7REA==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH v2 2/2] platform/x86: toshiba_acpi: Add quirk for buttons on Z830
Date:   Thu, 22 Sep 2022 20:24:24 +0200
Message-Id: <20220922182424.934340-3-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922182424.934340-1-lkml@vorpal.se>
References: <20220922182424.934340-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/toshiba_acpi.c | 36 ++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 9f1394b73895..894afe74d815 100644
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
@@ -3260,7 +3271,14 @@ static const char *find_hci_method(acpi_handle handle)
  * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
  * the configured brightness level.
  */
-static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
+#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
+/*
+ * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must use
+ * the value HCI_HOTKEY_ENABLE_QUICKSTART.
+ */
+#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
+
+static const struct dmi_system_id toshiba_dmi_quirks[] = {
 	{
 	 /* Toshiba Portégé R700 */
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
@@ -3268,6 +3286,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
+	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Portégé R830 */
@@ -3277,6 +3296,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
+	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Portégé Z830 */
@@ -3284,6 +3304,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
+	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
 	},
 };
 
@@ -3292,6 +3313,8 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
+	const struct dmi_system_id *dmi_id;
+	long quirks = 0;
 	int ret = 0;
 
 	if (toshiba_acpi)
@@ -3444,8 +3467,15 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	}
 #endif
 
+	dmi_id = dmi_first_match(toshiba_dmi_quirks);
+	if (dmi_id)
+		quirks = (long)dmi_id->driver_data;
+
 	if (turn_on_panel_on_resume == -1)
-		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
+		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
+
+	if (hci_hotkey_quickstart == -1)
+		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
 
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
-- 
2.37.3

