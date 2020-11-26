Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1809C2C5999
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbgKZQw0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 11:52:26 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:54797 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391591AbgKZQw0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Nov 2020 11:52:26 -0500
Received: from [100.112.135.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 5F/B2-49214-64DDFBF5; Thu, 26 Nov 2020 16:52:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsWSLveKTdft7v5
  4g5MNghb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o8XHZRwWnzsms1is3vOC2WLtl3ls
  FmdOX2J14PaYNHMGs8fOWXfZPX5tW8PisXmFlse8k4EePW2bmDze77vK5rHlajuLx+dNcgGcU
  ayZeUn5FQmsGd8/fmIuuBZSseT1FpYGxq1uXYxcHEIC/xklDjztYYJwHjJKfOieytrFyMnBJq
  AtsWXLL7YuRg4OEQEZiQ9rPUFqmAUWMEl8ub4GrEZYIFBiWv9cZhCbRUBVYsbKe2wgNq+AtcT
  DF1/YQWwJAXmJp73LwWo4BWwkHs95BxYXEgiV6F/6hBmiXlDi5MwnLCA2M1B989bZzBC2hMTB
  Fy+YIeYoSExecJUJwk6QWPbyDvMERoFZSNpnIWmfhaR9ASPzKkaLpKLM9IyS3MTMHF1DAwNdQ
  0MjXUNjI10jAwu9xCrdJL3SYt3y1OISXSO9xPJiveLK3OScFL281JJNjMBISyloubCDcd2bD3
  qHGCU5mJREeZfs2R8vxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3+B2gnGBRanpqRVpmDjDqYdI
  SHDxKIry/bwOleYsLEnOLM9MhUqcYdTlOrlqyiFmIJS8/L1VKnHcbSJEASFFGaR7cCFgCusQo
  KyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHc7yCU8mXklcJteAR3BBHTEdM49IEeUJCKkpBqYD
  NPeu79OWW79Ksf+saFarY39iyZWz6MfLeacnVhwTM3oU/v680wRurFim8x9lple9T2VN++Rg+
  +c3m/Zk+/JCf+evmm+coOW9vciZc7dsg0iacYXfDgfS1XOm2/r+zNRTEXzg9Fb1xnf3FTmyXF
  E/dUp2id+SbunXZMtZsOqHc1mG+8+sv1zxOPHP7F/W4VasxfZqf7QkigqOlvrWdcZldox8/TM
  2/zlG4N2nrm49snD14zGM5+vf6Kuk/PooKTDunpvj7LCJ6dsr77eHPmmNsfzlIcdk6bIvcq/i
  2+ZB/fdz7CYtm7V/Nunl35QU3OLq033qDt2YP1Todfa65qDD++UWB/zfYe5xoMHx/UqlFiKMx
  INtZiLihMB3ZggXrsDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-10.tower-346.messagelabs.com!1606409539!66079!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23422 invoked from network); 26 Nov 2020 16:52:21 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-10.tower-346.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Nov 2020 16:52:21 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 01A4EA03553DB9CF31D3;
        Fri, 27 Nov 2020 00:52:16 +0800 (CST)
Received: from localhost.home (10.64.80.205) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 26 Nov
 2020 08:52:12 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <rjw@rjwysocki.net>,
        <hadess@hadess.net>, <pobrn@protonmail.com>,
        <mario.limnociello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Thu, 26 Nov 2020 11:51:43 -0500
Message-ID: <20201126165143.32776-3-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126165143.32776-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.80.205]
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

Changes in v3:
 - version update for patch series

Changes in v4:
 - Rebase on top of palm sensor patch which led to a little bit of file
   restructuring/clean up
 - Use BIT macro where applicable
 - Formatting fixes
 - Check sysfs node created on exit function
 - implement and use DYTC_SET_COMMAND macro
 - in case of failure setting performance mode make sure CQL mode is
   enabled again before returning.
 - Clean up initialisation and error handling code

  drivers/platform/x86/thinkpad_acpi.c | 306 ++++++++++++++++++++++++++-
 1 file changed, 305 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6a4c54db38fb..8463170391f5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -72,6 +72,7 @@
 #include <linux/uaccess.h>
 #include <acpi/battery.h>
 #include <acpi/video.h>
+#include <linux/platform_profile.h>
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -9971,6 +9972,296 @@ static struct ibm_struct proxsensor_driver_data = {
 	.exit = proxsensor_exit,
 };
 
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+
+/*************************************************************************
+ * DYTC Platform Profile interface
+ */
+
+#define DYTC_CMD_QUERY        0 /* To get DYTC status - enable/revision */
+#define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
+#define DYTC_CMD_RESET    0x1ff /* To reset back to default */
+
+#define DYTC_QUERY_ENABLE_BIT 8  /* Bit        8 - 0 = disabled, 1 = enabled */
+#define DYTC_QUERY_SUBREV_BIT 16 /* Bits 16 - 27 - sub revision */
+#define DYTC_QUERY_REV_BIT    28 /* Bits 28 - 31 - revision */
+
+#define DYTC_GET_FUNCTION_BIT 8  /* Bits  8-11 - function setting */
+#define DYTC_GET_MODE_BIT     12 /* Bits 12-15 - mode setting */
+
+#define DYTC_SET_FUNCTION_BIT 12 /* Bits 12-15 - function setting */
+#define DYTC_SET_MODE_BIT     16 /* Bits 16-19 - mode setting */
+#define DYTC_SET_VALID_BIT    20 /* Bit     20 - 1 = on, 0 = off */
+
+#define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
+#define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
+#define DYTC_FUNCTION_MMC     11 /* Function = 11, desk mode */
+
+#define DYTC_MODE_PERFORM     2  /* High power mode aka performance */
+#define DYTC_MODE_QUIET       3  /* Low power mode aka quiet */
+#define DYTC_MODE_BALANCE   0xF  /* Default mode aka balance */
+
+#define DYTC_SET_COMMAND(function, mode, on) \
+	(DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | \
+	 (mode) << DYTC_SET_MODE_BIT | \
+	 (on) << DYTC_SET_VALID_BIT)
+
+#define DYTC_DISABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 0)
+#define DYTC_ENABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 1)
+
+static bool dytc_ignore_next_event;
+static bool dytc_profile_available;
+static enum platform_profile_option dytc_current_profile;
+
+static int dytc_command(int command, int *output)
+{
+	acpi_handle dytc_handle;
+
+	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle))) {
+		/* Platform doesn't support DYTC */
+		return -ENODEV;
+	}
+	if (!acpi_evalf(dytc_handle, output, NULL, "dd", command))
+		return -EIO;
+	return 0;
+}
+
+static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
+{
+	switch (dytcmode) {
+	case DYTC_MODE_QUIET:
+		*profile = platform_profile_low;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  platform_profile_balance;
+		break;
+	case DYTC_MODE_PERFORM:
+		*profile =  platform_profile_perform;
+		break;
+	default: /* Unknown mode */
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int convert_profile_to_dytc(enum platform_profile_option profile, int *perfmode)
+{
+	switch (profile) {
+	case platform_profile_low:
+		*perfmode = DYTC_MODE_QUIET;
+		break;
+	case platform_profile_balance:
+		*perfmode = DYTC_MODE_BALANCE;
+		break;
+	case platform_profile_perform:
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
+	int output, err, cmd_err;
+
+	if (!dytc_profile_available)
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
+
+		cmd_err = dytc_command(DYTC_CMD_GET, &output);
+		/* Check return condition after we've restored CQL state */
+
+		/* Again ignore this event */
+		dytc_ignore_next_event = true;
+		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
+		if (err)
+			return err;
+		if (cmd_err)
+			return cmd_err;
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
+{
+	int funcmode, perfmode;
+	int err;
+
+	err = dytc_perfmode_get(&perfmode, &funcmode);
+	if (err)
+		return err;
+
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
+	int output;
+	int err;
+
+	if (!dytc_profile_available)
+		return -ENODEV;
+
+	if (profile == platform_profile_balance) {
+		/* To get back to balance mode we just issue a reset command */
+		err = dytc_command(DYTC_CMD_RESET, &output);
+		if (err)
+			return err;
+	} else {
+		int perfmode;
+		int cmd_err;
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
+		cmd_err = dytc_command(DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
+				&output);
+		/* Check return condition after we've restored CQL state */
+
+		if (cur_funcmode == DYTC_FUNCTION_CQL) {
+			dytc_ignore_next_event = true; /* Ignore event */
+			err = dytc_command(DYTC_ENABLE_CQL, &output);
+			if (err)
+				return err;
+		}
+		if (cmd_err)
+			return cmd_err;
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
+
+static struct platform_profile_handler dytc_profile = {
+	.choices = BIT(platform_profile_low) |
+		BIT(platform_profile_balance) |
+		BIT(platform_profile_perform),
+	.profile_get = dytc_profile_get,
+	.profile_set = dytc_profile_set,
+};
+
+static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
+{
+	int err, output;
+
+	dytc_profile_available = false;
+	dytc_ignore_next_event = false;
+
+	err = dytc_command(DYTC_CMD_QUERY, &output);
+	/*
+	 * If support isn't available (ENODEV) then don't return an error
+	 * and don't create the sysfs group
+	 */
+	if (err == -ENODEV)
+		return 0;
+	/* For all other errors we can flag the failure */
+	if (err)
+		return err;
+
+	/* Check DYTC is enabled and supports mode setting */
+	if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
+		/* Only DYTC v5.0 and later has this feature. */
+		int dytc_version;
+
+		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
+		if (dytc_version >= 5) {
+			dbg_printk(TPACPI_DBG_INIT,
+				   "DYTC version %d: thermal mode available\n", dytc_version);
+			/* Create platform_profile structure and register */
+			do {
+				err = platform_profile_register(&dytc_profile);
+			} while (err == -EINTR);
+			/*
+			 * If for some reason platform_profiles aren't enabled
+			 * don't quit terminally.
+			 */
+			if (err)
+				return 0;
+			dytc_profile_available = true;
+		}
+	}
+	return 0;
+}
+
+static void dytc_profile_exit(void)
+{
+	if (dytc_profile_available) {
+		dytc_profile_available = false;
+		platform_profile_unregister();
+	}
+}
+
+static struct ibm_struct  dytc_profile_driver_data = {
+	.name = "dytc-profile",
+	.exit = dytc_profile_exit,
+};
+#endif /* CONFIG_ACPI_PLATFORM_PROFILE */
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -10019,8 +10310,15 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		mutex_unlock(&kbdlight_mutex);
 	}
 
-	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED)
+	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
 		lapsensor_refresh();
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+		if (dytc_ignore_next_event)
+			dytc_ignore_next_event = false; /*clear setting*/
+		else
+			dytc_profile_refresh();
+#endif
+	}
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
@@ -10463,6 +10761,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = tpacpi_proxsensor_init,
 		.data = &proxsensor_driver_data,
 	},
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+	{
+		.init = tpacpi_dytc_profile_init,
+		.data = &dytc_profile_driver_data,
+	},
+#endif
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.28.0

