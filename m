Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496952B2DC2
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Nov 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKNPBc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 10:01:32 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:5917 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgKNPBc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 14 Nov 2020 10:01:32 -0500
Received: from [100.112.5.40] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id D8/73-08509-841FFAF5; Sat, 14 Nov 2020 15:01:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsWSLveKTdfj4/p
  4g+4zihb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLY4c/oS
  qwOXx6SZM5g9ds66y+7xa9saFo/NK7Q85p0M9Hi/7yqbx5ar7SwenzfJBXBEsWbmJeVXJLBmr
  J5mXjApsGJRz2OWBsYJzl2MXBxCAv8ZJX7svc8E4fxglLi54QxLFyMnB5uAtsSWLb/Yuhg5OE
  QEZCQ+rPUEqWEWaGeSWH3sMRtIjbBAoMS1W3MYQWwWAVWJr2+ms4LYvAI2Eid2HGACsSUE5CV
  mXvrODmJzCthKrG7cCRYXEgiTuLLoOxNEvaDEyZlPwPYyA9U3b53NDGFLSBx88YIZ5AYJAQWJ
  OzMKIUYmSCx7eYd5AqPALCTds5B0z0LSvYCReRWjaVJRZnpGSW5iZo6uoYGBrqGhka6ZrpmZX
  mKVbrJeabFuamJxia6hXmJ5sV5xZW5yTopeXmrJJkZgNKUUsDntYLz9+oPeIUZJDiYlUd4Pq9
  fHC/El5adUZiQWZ8QXleakFh9ilOHgUJLgzX0PlBMsSk1PrUjLzAFGNkxagoNHSYSX7QNQmre
  4IDG3ODMdInWKUZfj5Koli5iFWPLy81KlxHmdQGYIgBRllObBjYAlmUuMslLCvIwMDAxCPAWp
  RbmZJajyrxjFORiVhHlVQFbxZOaVwG16BXQEE9ARH8zWgBxRkoiQkmpgikva0WO/68L7tHRza
  XGTAzNqdBxqyy7H8jKqr3rzRIP7rl2WV2LK/63lM3V2bPSvq7HccnpuhdTKhKAJ4od32/LwtD
  oy8Ajvd10iKufJr3nwQ1LnjEcOu80sJnnHpv9ZKBVR1/Lg+rHpAZOubF/vKbryNOvH6cx3FqY
  c4HU7tK7I9IjT3CQ9iRVeOyJjD+z/+ffxusMnI9+8Y+GfbOfGaLJIV2rRot8pKb92Xaz67+ZY
  Zx5WdfjsapkX85v7n7C0MF4tf3ViuzOXwAILGbP7+dLOnnvf/za/GPDOf3pATwDr7tmPjnIF5
  DvMtczn39a64Iu89cmXBapPIj58m6e74b/X1fczFpsVqnI9OLPzsxJLcUaioRZzUXEiAGnwbN
  2tAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-5.tower-416.messagelabs.com!1605366085!441120!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27313 invoked from network); 14 Nov 2020 15:01:28 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-5.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Nov 2020 15:01:28 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 4530B1DA39F61AD68563;
        Sat, 14 Nov 2020 23:01:23 +0800 (CST)
Received: from banther-ThinkPad-X1-Carbon-Gen-8.home (10.38.56.206) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Sat, 14 Nov 2020 07:01:17 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH v2 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Sat, 14 Nov 2020 10:01:02 -0500
Message-ID: <20201114150102.340618-3-markpearson@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201114150102.340618-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201114150102.340618-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.38.56.206]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support to thinkpad_acpi for Lenovo platforms that have DYTC
version 5 support or newer to use the platform profile feature.

This will allow users to determine and control the platform modes
between low-power, balanced operation and performance modes.

Signed-off-by: Mark Pearson <markpearson@lenovo.com>
---
Changes in v2:
 Address (hopefully) all recommendations from review including:
 - use IS_ENABLED instead of IS_DEFINED
 - update driver to work with all the fixes in platform_profile update
 - improve error handling for invalid inputs
 - move tracking of current profile mode into this driver

 drivers/platform/x86/thinkpad_acpi.c | 278 +++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 890dda284a00..13352ccdfdaf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -72,6 +72,7 @@
 #include <linux/uaccess.h>
 #include <acpi/battery.h>
 #include <acpi/video.h>
+#include <linux/platform_profile.h>
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -9832,10 +9833,40 @@ static struct ibm_struct lcdshadow_driver_data = {
  * DYTC subdriver, for the Lenovo lapmode feature
  */
 
+#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
+#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
 #define DYTC_CMD_GET          2 /* To get current IC function and mode */
 #define DYTC_GET_LAPMODE_BIT 17 /* Set when in lapmode */
+#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
+
+#define DYTC_QUERY_ENABLE_BIT 8  /* Bit 8 - 0 = disabled, 1 = enabled */
+#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revisision */
+#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
+
+#define DYTC_GET_FUNCTION_BIT 8  /* Bits 8-11 - function setting */
+#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
+#define DYTC_GET_LAPMODE_BIT  17 /* Bit 17 - lapmode. Set when on lap */
+
+#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - funct setting */
+#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
+#define DYTC_SET_VALID_BIT    20 /* Bit 20 - 1 = on, 0 = off */
+
+#define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
+#define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
+#define DYTC_FUNCTION_MMC     11 /* Function = 11, desk mode */
+
+#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
+#define DYTC_MODE_QUIET       3  /* low power mode aka quiet */
+#define DYTC_MODE_BALANCE   0xF  /* default mode aka balance */
+
+#define DYTC_DISABLE_CQL ((DYTC_MODE_BALANCE << DYTC_SET_MODE_BIT) | \
+		(DYTC_FUNCTION_CQL << DYTC_SET_FUNCTION_BIT) | \
+		DYTC_CMD_SET)
+#define DYTC_ENABLE_CQL (DYTC_DISABLE_CQL | (1 << DYTC_SET_VALID_BIT))
 
 static bool dytc_lapmode;
+static bool dytc_available;
+static bool dytc_ignore_next_event;
 
 static void dytc_lapmode_notify_change(void)
 {
@@ -9889,22 +9920,188 @@ static ssize_t dytc_lapmode_show(struct device *dev,
 
 static DEVICE_ATTR_RO(dytc_lapmode);
 
-static struct attribute *dytc_attributes[] = {
-	&dev_attr_dytc_lapmode.attr,
-	NULL,
-};
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+static struct platform_profile_handler dytc_profile;
+static enum platform_profile_option dytc_current_profile;
 
-static const struct attribute_group dytc_attr_group = {
-	.attrs = dytc_attributes,
-};
+static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
+{
+	switch (dytcmode) {
+	case DYTC_MODE_QUIET:
+		*profile = profile_low;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  profile_balance;
+		break;
+	case DYTC_MODE_PERFORM:
+		*profile =  profile_perform;
+		break;
+	default: /* Unknown mode */
+		return -EINVAL;
+	}
+	return 0;
+}
 
-static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
+static int convert_profile_to_dytc(enum platform_profile_option profile, int *perfmode)
+{
+	switch (profile) {
+	case profile_low:
+		*perfmode = DYTC_MODE_QUIET;
+		break;
+	case profile_balance:
+		*perfmode = DYTC_MODE_BALANCE;
+		break;
+	case profile_perform:
+		*perfmode = DYTC_MODE_PERFORM;
+		break;
+	default: /* Unknown profile */
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int dytc_perfmode_get(int *perfmode, int *funcmode)
+{
+	int output, err;
+
+	if (!dytc_available)
+		return -ENODEV;
+
+	err = dytc_command(DYTC_CMD_GET, &output);
+	if (err)
+		return err;
+
+	*funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
+	if (*funcmode == DYTC_FUNCTION_CQL) {
+		int dummy;
+		/*
+		 * We can't get the mode when in CQL mode - so we disable CQL
+		 * mode retrieve the mode and then enable it again.
+		 * As disabling/enabling CQL triggers an event we set a flag to
+		 * ignore these events. This will be cleared by the event handler
+		 */
+		dytc_ignore_next_event = true;
+		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
+		if (err)
+			return err;
+		err = dytc_command(DYTC_CMD_GET, &output);
+		if (err)
+			return err;
+		/* Again ignore this event */
+		dytc_ignore_next_event = true;
+		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
+		if (err)
+			return err;
+	}
+	*perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
+	return 0;
+}
+
+/*
+ * dytc_profile_get: Function to register with platform_profile
+ * handler. Returns current platform profile.
+ */
+int dytc_profile_get(enum platform_profile_option *profile)
 {
 	int err;
+	int funcmode, perfmode;
+
+	err = dytc_perfmode_get(&perfmode, &funcmode);
+	if (err)
+		return err;
 
-	err = dytc_lapmode_get(&dytc_lapmode);
-	/* If support isn't available (ENODEV) then don't return an error
-	 * but just don't create the sysfs group
+	/* Convert Lenovo DYTC profile to platform_profile */
+	err = convert_dytc_to_profile(perfmode, profile);
+	if (err)
+		return err;
+
+	dytc_current_profile = *profile;
+	return 0;
+}
+
+/*
+ * dytc_profile_set: Function to register with platform_profile
+ * handler. Sets current platform profile.
+ */
+int dytc_profile_set(enum platform_profile_option profile)
+{
+	int cur_perfmode, cur_funcmode;
+	int err, dytc_set;
+	int output;
+
+	if (!dytc_available)
+		return -ENODEV;
+
+	if (profile == profile_balance) {
+		/* To get back to balance mode we just issue a reset command */
+		err = dytc_command(DYTC_CMD_RESET, &output);
+		if (err)
+			return err;
+	} else {
+		int perfmode;
+		int err;
+
+		err = convert_profile_to_dytc(profile, &perfmode);
+		if (err)
+			return err;
+
+		/* Determine if we are in CQL mode. This alters the commands we do */
+		err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
+		if (err)
+			return err;
+
+		if (cur_funcmode == DYTC_FUNCTION_CQL) {
+			/* To set the mode we need to disable CQL first*/
+			dytc_ignore_next_event = true; /* Ignore event */
+			err = dytc_command(DYTC_DISABLE_CQL, &output);
+			if (err)
+				return err;
+		}
+		dytc_set = (1 << DYTC_SET_VALID_BIT) |
+			(DYTC_FUNCTION_MMC << DYTC_SET_FUNCTION_BIT) |
+			(perfmode << DYTC_SET_MODE_BIT) |
+			DYTC_CMD_SET;
+		err = dytc_command(dytc_set, &output);
+		if (err)
+			return err;
+		if (cur_funcmode == DYTC_FUNCTION_CQL) {
+			dytc_ignore_next_event = true; /* Ignore event */
+			err = dytc_command(DYTC_ENABLE_CQL, &output);
+			if (err)
+				return err;
+		}
+	}
+	/* Success - update current profile */
+	dytc_current_profile = profile;
+	return 0;
+}
+
+static void dytc_profile_refresh(void)
+{
+	enum platform_profile_option profile;
+	int perfmode, funcmode;
+	int err;
+
+	err = dytc_perfmode_get(&perfmode, &funcmode);
+	if (err)
+		return;
+
+	err = convert_dytc_to_profile(perfmode, &profile);
+	if (profile != dytc_current_profile) {
+		dytc_current_profile = profile;
+		platform_profile_notify();
+	}
+}
+#endif
+
+static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
+{
+	int err, output;
+
+	err = dytc_command(DYTC_CMD_QUERY, &output);
+	/*
+	 * If support isn't available (ENODEV) then don't return an error
+	 * and don't create the sysfs group
 	 */
 	if (err == -ENODEV)
 		return 0;
@@ -9912,14 +10109,54 @@ static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
 	if (err)
 		return err;
 
-	/* Platform supports this feature - create the group */
-	err = sysfs_create_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
-	return err;
+	/* Check DYTC is enabled and supports mode setting */
+	dytc_available = false;
+	dytc_ignore_next_event = false;
+
+	if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
+		/* Only DYTC v5.0 and later has this feature. */
+		int dytc_version;
+
+		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
+		if (dytc_version >= 5) {
+			dbg_printk(TPACPI_DBG_INIT,
+				   "DYTC version %d: thermal mode available\n", dytc_version);
+			dytc_available = true;
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+			/* Create platform_profile structure and register */
+			dytc_profile.choices = (1 << profile_low) |
+				(1 << profile_balance) |
+				(1 << profile_perform);
+			dytc_profile.profile_get = dytc_profile_get;
+			dytc_profile.profile_set = dytc_profile_set;
+			err = platform_profile_register(&dytc_profile);
+			/*
+			 * If for some reason platform_profiles aren't enabled
+			 * don't quit terminally.
+			 */
+			if (err)
+				return 0;
+#endif
+			/*
+			 * Note - this has been deprecated by the input sensor implementation,
+			 * but can't be removed until we confirm user space is no longer using
+			 */
+			dytc_lapmode_get(&dytc_lapmode);
+			return device_create_file(&tpacpi_pdev->dev, &dev_attr_dytc_lapmode);
+		}
+	}
+	return 0;
 }
 
 static void dytc_exit(void)
 {
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &dytc_attr_group);
+	if (dytc_available) {
+		device_remove_file(&tpacpi_pdev->dev, &dev_attr_dytc_lapmode);
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+		platform_profile_unregister();
+#endif
+		dytc_available = false;
+	}
 }
 
 static struct ibm_struct dytc_driver_data = {
@@ -10103,8 +10340,15 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 	}
 
 	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
-		dytc_lapmode_refresh();
-		lapsensor_refresh();
+		if (dytc_ignore_next_event)
+			dytc_ignore_next_event = false; /*clear setting*/
+		else {
+			dytc_lapmode_refresh();
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+			dytc_profile_refresh();
+#endif
+			lapsensor_refresh();
+		}
 	}
 
 }
-- 
2.25.1

