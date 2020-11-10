Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB02ACBD3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgKJDcX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 22:32:23 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.4]:8526 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731341AbgKJDcW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 22:32:22 -0500
Received: from [100.112.1.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-east-1.aws.symcld.net id 44/46-54728-4C90AAF5; Tue, 10 Nov 2020 03:32:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsWSLveKXfcw56p
  4gyuPtSz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWxx5vQl
  Vgcuj0kzZzB77Jx1l93j17Y1LB6bV2h5zDsZ6PF+31U2jy1X21k8Pm+SC+CIYs3MS8qvSGDNW
  P39M2tBr0/Fq388DYwN9l2MXBxCAv8ZJfb0/2ODcO4DOes/sXYxcnKwCWhLbNnyCyjBwSEiIC
  PxYa0nSA2zQDuTxOpjj9lAaoQF/CR+/W9iBrFZBFQkvmw9ARbnFbCSOHzgF5gtISAv8bR3OVg
  Np4C1xNXjX9lBbCGBEIknO96yQNQLSpyc+QTMZgaqb946mxnClpA4+OIFM8yckxs+MUHYCRLL
  Xt5hnsAoMAtJ+ywk7bOQtC9gZF7FaJZUlJmeUZKbmJmja2hgoGtoaKRroGtkZKSXWKWbpFdar
  JuaWFyia6iXWF6sV1yZm5yTopeXWrKJERhRKQUM93Yw/nn9Qe8QoyQHk5IobxbTqnghvqT8lM
  qMxOKM+KLSnNTiQ4wyHBxKEryObEA5waLU9NSKtMwcYHTDpCU4eJREeF+wAKV5iwsSc4sz0yF
  Spxh1OU6uWrKIWYglLz8vVUqcdwo7UJEASFFGaR7cCFiiucQoKyXMy8jAwCDEU5BalJtZgir/
  ilGcg1FJmPcYyBSezLwSuE2vgI5gAjoiwHEFyBEliQgpqQamefPeTFM5EsG3T9rP5HOx8JvJx
  35FpBWLOwu3TP3OZsObJVqw4WP8Gb3XIZd+ZaivfzLnxDEVwUAW8wW/Cr9Ou+Y4hS3Edsr/dt
  8tTSelbqs5eDjJVzDWKRrHvVCaJJ0muE6L8eslhV2blsY2xt4T/p3Pvnzr8/pJv54ndDGyzij
  UPPN0z/KktZEJ90X36LvXcb95z5l3bP105Q6GXyXvLu3d7t3U6dpqcSaZdW52ZbFLWsC7L7rx
  aqJ7Kxp91fKcvldEmM+4F/XF58uzu9M6uGsuTNozNeXrU524GK/kDZJbOd7cPet907X2gsoei
  /5zD9pmXDA9Nu3Mod2C3Jnm/3sbZea3rg76OmkJq6SYEktxRqKhFnNRcSIAZQaKy68DAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-15.tower-386.messagelabs.com!1604979137!255772!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13138 invoked from network); 10 Nov 2020 03:32:19 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-15.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 03:32:19 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 9A9A59E1579E767D0D4B;
        Tue, 10 Nov 2020 11:32:14 +0800 (CST)
Received: from localhost.home (10.64.89.28) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 9 Nov 2020
 19:32:09 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Mon, 9 Nov 2020 22:31:24 -0500
Message-ID: <20201110033124.3211-4-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110033124.3211-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.28]
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
 drivers/platform/x86/thinkpad_acpi.c | 263 +++++++++++++++++++++++++--
 1 file changed, 246 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fe438a5e1dbe..d70181b5772b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -72,6 +72,7 @@
 #include <linux/uaccess.h>
 #include <acpi/battery.h>
 #include <acpi/video.h>
+#include <linux/platform_profile.h>
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -9824,10 +9825,40 @@ static struct ibm_struct lcdshadow_driver_data = {
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
@@ -9881,22 +9912,172 @@ static ssize_t dytc_lapmode_show(struct device *dev,
 
 static DEVICE_ATTR_RO(dytc_lapmode);
 
-static struct attribute *dytc_attributes[] = {
-	&dev_attr_dytc_lapmode.attr,
-	NULL,
-};
+#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
+static struct platform_profile dytc_profile;
 
-static const struct attribute_group dytc_attr_group = {
-	.attrs = dytc_attributes,
-};
+static int convert_dytc_to_profile(int dytcmode)
+{
+	switch (dytcmode) {
+	case DYTC_MODE_QUIET:
+		return profile_low;
+	case DYTC_MODE_BALANCE:
+		return profile_balance;
+	case DYTC_MODE_PERFORM:
+		return profile_perform;
+	default: /* Unknown mode */
+		return profile_unknown;
+	}
+}
 
-static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
+static int convert_profile_to_dytc(int profile)
+{
+	switch (profile) {
+	case profile_low:
+		return DYTC_MODE_QUIET;
+	case profile_balance:
+		return DYTC_MODE_BALANCE;
+	case profile_perform:
+		return DYTC_MODE_PERFORM;
+	default: /* Unknown profile */
+		return -EINVAL;
+	}
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
+int dytc_profile_get(void)
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
+	dytc_profile.cur_profile = convert_dytc_to_profile(perfmode);
+	return dytc_profile.cur_profile;
+}
+
+/*
+ * dytc_profile_set: Function to register with platform_profile
+ * handler. Sets current platform profile.
+ */
+int dytc_profile_set(int profile)
+{
+	int err, dytc_set;
+	int output;
+	int cur_perfmode, cur_funcmode;
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
+		int perfmode = convert_profile_to_dytc(profile);
+
+		if (perfmode < 0)
+			return perfmode;
+
+		/* Determine if we are in CQL mode. This alters the commands we do */
+		err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
+		if (err)
+			return err;
+
+		if (cur_funcmode == DYTC_FUNCTION_CQL) {
+			/* To set the mode we need to disable CQL first*/
+			dytc_ignore_next_event = true; /*ignore event*/
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
+			dytc_ignore_next_event = true; /*ignore event*/
+			err = dytc_command(DYTC_ENABLE_CQL, &output);
+			if (err)
+				return err;
+		}
+	}
+	/* Success - update current profile */
+	dytc_profile.cur_profile = profile;
+	return 0;
+}
+
+static void dytc_profile_refresh(void)
+{
+	int perfmode, funcmode, profile;
+	int err;
+
+	err = dytc_perfmode_get(&perfmode, &funcmode);
+	if (err)
+		return;
+
+	profile = convert_dytc_to_profile(perfmode);
+	if (profile != dytc_profile.cur_profile) {
+		dytc_profile.cur_profile = profile;
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
@@ -9904,14 +10085,55 @@ static int tpacpi_dytc_init(struct ibm_init_struct *iibm)
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
+#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
+			/* Create platform_profile structure and register */
+			dytc_profile.choices = (1 << profile_low) |
+				(1 << profile_balance) |
+				(1 << profile_perform);
+			dytc_profile.profile_get = dytc_profile_get;
+			dytc_profile.profile_set = dytc_profile_set;
+			dytc_profile.cur_profile = profile_unknown;
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
+#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
+		platform_profile_unregister();
+#endif
+		dytc_available = false;
+	}
 }
 
 static struct ibm_struct dytc_driver_data = {
@@ -10095,8 +10317,15 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 	}
 
 	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
-		dytc_lapmode_refresh();
-		lapsensor_refresh();
+		if (dytc_ignore_next_event)
+			dytc_ignore_next_event = false; /*clear setting*/
+		else {
+			dytc_lapmode_refresh();
+#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
+			dytc_profile_refresh();
+#endif
+			lapsensor_refresh();
+		}
 	}
 
 }
-- 
2.28.0

