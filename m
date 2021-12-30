Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9B481FEF
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 20:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhL3Tba (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 14:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240383AbhL3Tba (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 14:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640892689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wVI0ozD+5jEPuwpQnFS4h4wJYYBFuWKSizk4uV8v9k=;
        b=AQ0ycOZt8CXvTMJkumIWRofYuKnnPC4aa23jZcCLY0LsyvMiG3/mDIb+1GShIE0JGaUcy2
        B3y4w6OOBuIuHg0EVYTkFDvRJ5dBXSB/Ooh/kA1CSYqq0hSkmhQDQDQUUajit98juvYB4i
        o6nDkdDv4WvdWoWkHB/uJvWX5f2DnpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-h9iWDp7IOZSkZtxWnDlqLQ-1; Thu, 30 Dec 2021 14:31:26 -0500
X-MC-Unique: h9iWDp7IOZSkZtxWnDlqLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 586E21030C23;
        Thu, 30 Dec 2021 19:31:25 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B81765F707;
        Thu, 30 Dec 2021 19:31:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
Date:   Thu, 30 Dec 2021 20:31:19 +0100
Message-Id: <20211230193120.589337-2-hdegoede@redhat.com>
In-Reply-To: <20211230193120.589337-1-hdegoede@redhat.com>
References: <20211230193120.589337-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some x86 ACPI boards have broken AC and battery ACPI devices in their ACPI
tables. This is often tied to these devices using certain PMICs where the
factory OS image seems to be using native charger and fuel-gauge drivers
instead.

So far both the ac and battery drivers have almost identical checks for
these PMICs including both of them having a DMI based mechanism to force
usage of the ACPI ac and battery drivers on some boards even though one
of these PMICs is present, with the same 2 boards listed in both driver's
DMI tables for this.

The only difference is that the ac driver checks for 2 PMICs and the
battery driver only for one. This has grown this way because the other
(Whiskey Cove) PMIC is only used on a few boards (3 known boards) and
although some of these do have non working ACPI battery devices, their
_STA method always returns 0, but that really should not be relied on.

This patch factors out the shared checks into a new
acpi_quirk_skip_acpi_ac_and_battery() helper and moves the ac and
battery drivers over to this new helper.

Note the DMI table is shared with acpi_quirk_skip_i2c_client_enumeration()
and acpi_quirk_skip_serdev_enumeration(), because boards needing DMI quirks
for either of these typically also have broken ac and battery ACPI devices.
The ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY quirk is not set yet on boards
already in this DMI table, to avoid introducing any functional changes
in this refactoring patch.

Besided sharing the code between the ac and battery drivers this
refactoring also moves this quirk handling to under #ifdef CONFIG_X86,
removing this x86 specific code from non x86 ACPI builds.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ac.c        | 43 ++--------------------
 drivers/acpi/battery.c   | 42 ++--------------------
 drivers/acpi/x86/utils.c | 77 +++++++++++++++++++++++++++++++++++++---
 include/acpi/acpi_bus.h  |  5 +++
 4 files changed, 84 insertions(+), 83 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 81aff651a0d4..db487ff9dd1b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -48,19 +48,12 @@ static const struct acpi_device_id ac_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ac_device_ids);
 
-/* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
-static const struct acpi_ac_bl acpi_ac_blacklist[] = {
-	{ "INT33F4", -1 }, /* X-Powers AXP288 PMIC */
-	{ "INT34D3",  3 }, /* Intel Cherrytrail Whiskey Cove PMIC */
-};
-
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev);
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 
 static int ac_sleep_before_get_state_ms;
-static int ac_check_pmic = 1;
 static int ac_only;
 
 static struct acpi_driver acpi_ac_driver = {
@@ -200,12 +193,6 @@ static int __init thinkpad_e530_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int __init ac_do_not_check_pmic_quirk(const struct dmi_system_id *d)
-{
-	ac_check_pmic = 0;
-	return 0;
-}
-
 static int __init ac_only_quirk(const struct dmi_system_id *d)
 {
 	ac_only = 1;
@@ -214,13 +201,6 @@ static int __init ac_only_quirk(const struct dmi_system_id *d)
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id ac_dmi_table[]  __initconst = {
-	{
-		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
-		.callback = ac_do_not_check_pmic_quirk,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
-		},
-	},
 	{
 		/* Kodlix GK45 returning incorrect state */
 		.callback = ac_only_quirk,
@@ -228,15 +208,6 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "GK45"),
 		},
 	},
-	{
-		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
-		.callback = ac_do_not_check_pmic_quirk,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
-		},
-	},
 	{
 		/* Lenovo Thinkpad e530, see comment in acpi_ac_notify() */
 		.callback = thinkpad_e530_quirk,
@@ -341,23 +312,15 @@ static int acpi_ac_remove(struct acpi_device *device)
 
 static int __init acpi_ac_init(void)
 {
-	unsigned int i;
 	int result;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
-	dmi_check_system(ac_dmi_table);
+	if (acpi_quirk_skip_acpi_ac_and_battery())
+		return -ENODEV;
 
-	if (ac_check_pmic) {
-		for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
-			if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
-					     acpi_ac_blacklist[i].hrv)) {
-				pr_info("found native %s PMIC, not loading\n",
-					acpi_ac_blacklist[i].hid);
-				return -ENODEV;
-			}
-	}
+	dmi_check_system(ac_dmi_table);
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0)
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8afa85d6eb6a..bf4b7f0b627a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -52,7 +52,6 @@ static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_ac_is_broken;
-static int battery_check_pmic = 1;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -64,11 +63,6 @@ static const struct acpi_device_id battery_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
-/* Lists of PMIC ACPI HIDs with an (often better) native battery driver */
-static const char * const acpi_battery_blacklist[] = {
-	"INT33F4", /* X-Powers AXP288 PMIC */
-};
-
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
@@ -1104,13 +1098,6 @@ battery_ac_is_broken_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int __init
-battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
-{
-	battery_check_pmic = 0;
-	return 0;
-}
-
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		/* NEC LZ750/LS */
@@ -1139,22 +1126,6 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_DATE, "08/22/2014"),
 		},
 	},
-	{
-		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
-		.callback = battery_do_not_check_pmic_quirk,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
-		},
-	},
-	{
-		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
-		.callback = battery_do_not_check_pmic_quirk,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
-		},
-	},
 	{},
 };
 
@@ -1279,19 +1250,12 @@ static struct acpi_driver acpi_battery_driver = {
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
-	unsigned int i;
 	int result;
 
-	dmi_check_system(bat_dmi_table);
+	if (acpi_quirk_skip_acpi_ac_and_battery())
+		return;
 
-	if (battery_check_pmic) {
-		for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
-			if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
-				pr_info("found native %s PMIC, not loading\n",
-					acpi_battery_blacklist[i]);
-				return;
-			}
-	}
+	dmi_check_system(bat_dmi_table);
 
 	result = acpi_bus_register_driver(&acpi_battery_driver);
 	battery_driver_registered = (result == 0);
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 375a0911f06d..5411f2f1254e 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -8,6 +8,8 @@
  * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/platform_device.h>
@@ -210,7 +212,6 @@ bool force_storage_d3(void)
 	return x86_match_cpu(storage_d3_cpu_ids);
 }
 
-#if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 /*
  * x86 ACPI boards which ship with only Android as their factory image usually
  * declare a whole bunch of bogus I2C devices in their ACPI tables and sometimes
@@ -236,8 +237,36 @@ bool force_storage_d3(void)
  */
 #define ACPI_QUIRK_SKIP_I2C_CLIENTS				BIT(0)
 #define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(1)
+#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(2)
+#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(3)
+
+static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
+	/*
+	 * 1. Devices with only the skip / don't-skip AC and battery quirks,
+	 *    sorted alphabetically.
+	 */
+	{
+		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+		.driver_data = (void *)ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY
+	},
+	{
+		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
+		},
+		.driver_data = (void *)ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY
+	},
 
-static const struct dmi_system_id acpi_skip_serial_bus_enumeration_ids[] = {
+	/*
+	 * 2. Devices which also have the skip i2c/serdev quirks and which
+	 *    need the x86-android-tablets module to properly work.
+	 */
+#if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -263,9 +292,11 @@ static const struct dmi_system_id acpi_skip_serial_bus_enumeration_ids[] = {
 		},
 		.driver_data = (void *)ACPI_QUIRK_SKIP_I2C_CLIENTS,
 	},
+#endif
 	{}
 };
 
+#if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
@@ -279,7 +310,7 @@ bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 	const struct dmi_system_id *dmi_id;
 	long quirks;
 
-	dmi_id = dmi_first_match(acpi_skip_serial_bus_enumeration_ids);
+	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
 	if (!dmi_id)
 		return false;
 
@@ -303,7 +334,7 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	if (!adev || !adev->pnp.unique_id || !dev_is_platform(controller_parent))
 		return 0;
 
-	dmi_id = dmi_first_match(acpi_skip_serial_bus_enumeration_ids);
+	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
 
@@ -319,3 +350,41 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
 #endif
+
+/* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
+static const struct {
+	const char *hid;
+	int hrv;
+} acpi_skip_ac_and_battery_pmic_ids[] = {
+	{ "INT33F4", -1 }, /* X-Powers AXP288 PMIC */
+	{ "INT34D3",  3 }, /* Intel Cherrytrail Whiskey Cove PMIC */
+};
+
+bool acpi_quirk_skip_acpi_ac_and_battery(void)
+{
+	const struct dmi_system_id *dmi_id;
+	long quirks = 0;
+	int i;
+
+	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
+	if (dmi_id)
+		quirks = (unsigned long)dmi_id->driver_data;
+
+	if (quirks & ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY)
+		return true;
+
+	if (quirks & ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(acpi_skip_ac_and_battery_pmic_ids); i++) {
+		if (acpi_dev_present(acpi_skip_ac_and_battery_pmic_ids[i].hid, "1",
+				     acpi_skip_ac_and_battery_pmic_ids[i].hrv)) {
+			pr_info_once("found native %s PMIC, skipping ACPI AC and battery devices\n",
+				     acpi_skip_ac_and_battery_pmic_ids[i].hid);
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(acpi_quirk_skip_acpi_ac_and_battery);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 102b1cf433c7..e0fd99462ddd 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -616,12 +616,17 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
 #ifdef CONFIG_X86
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
+bool acpi_quirk_skip_acpi_ac_and_battery(void);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
 {
 	return false;
 }
+static inline bool acpi_quirk_skip_acpi_ac_and_battery(void)
+{
+	return false;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
-- 
2.33.1

