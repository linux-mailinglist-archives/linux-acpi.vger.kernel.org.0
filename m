Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE42CC345
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 18:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgLBRRP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 12:17:15 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:37668 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727641AbgLBRRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 12:17:14 -0500
Received: from [100.112.1.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id C2/39-35070-2DAC7CF5; Wed, 02 Dec 2020 17:11:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsWS8eIhr+6lU8f
  jDY7O4bTYf13ComuhgcXC+6dYLb5+u81u8eb4dCaL5fv6GS2aOpvYLD53TGaxWL3nBbPF2i/z
  2CzOnL7E6sDtMWnmDGaPnbPusnv82raGxWPzCi2PeScDPXraNjF5vN93lc1jy9V2Fo/Pm+QCO
  KNYM/OS8isSWDPWrN/JXtAaUXF/QRNbA+Ntzy5GLg4hgf+MErf/97BBOA8YJXY9WwfkcHKwCW
  hLbNnyC8jm4BARkJH4sBasgVlgPpPEtQlX2UFqhAUCJV4engNmswioSDx7NpUFxOYVsJa4dLa
  FGcSWEJCXeNq7nBlkDqeAjcTs7fkgYSGBUIlXq/6wQpQLSpyc+QSslRmovHnrbGYIW0Li4IsX
  UGMUJOZ9XcQCYSdILHt5h3kCo8AsJO2zkLTPQtK+gJF5FaNZUlFmekZJbmJmjq6hgYGuoaGRr
  gGIpZdYpZukV1qsm5pYXKJrqJdYXqxXXJmbnJOil5dasokRGGUpBQwpOxjvvv6gd4hRkoNJSZ
  R31fzj8UJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkePVPAuUEi1LTUyvSMnOAEQ+TluDgURLhlQR
  J8xYXJOYWZ6ZDpE4xKkqJ8xaBJARAEhmleXBtsCRziVFWSpiXkYGBQYinILUoN7MEVf4VozgH
  o5Iwrw8wZQnxZOaVwE1/BbSYCWixy+fDIItLEhFSUg1M1wuy7GcGxnTtb/tRFvmB8T/LpovOG
  7d/2X/gfGX5y5/VagbhXkLG5/ew3VWKc5p/hVv+96SH2xkX3L2WNzufSepQ9h/ZfW5fDC0KOH
  NXq61bs7hEaq+H5H/z98/mTa0MmTXb2fN6wfFn/+ss3fL2Hz2esfq6+4ZjAn0b51fXXpBcul9
  PsW5ntPt94eey5hM5ove6PbNutyx9fkzmZbPsh0lq604ca9JQ94y50WHQeeHpy4gs04cZKxt6
  C+yEX0rJfnI7ap17ueV1o1BvdkiCpdK13Wvt7yTmWzScUdznU6OeJeDdsvKg9nH9RZtEf1/8p
  5C8Zer2Z5+WzRf+zTup+GJm17UrEzWeBPrOF5DtUGIpzkg01GIuKk4EAKC2R1StAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-8.tower-396.messagelabs.com!1606929105!690833!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24901 invoked from network); 2 Dec 2020 17:11:46 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-8.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2020 17:11:46 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id D9F0438AEF4CDC655348;
        Wed,  2 Dec 2020 12:11:45 -0500 (EST)
Received: from localhost.home (10.64.84.211) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 2 Dec 2020
 09:11:42 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v5 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Wed, 2 Dec 2020 12:11:20 -0500
Message-ID: <20201202171120.65269-3-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201202171120.65269-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.84.211]
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

Changes in v5:
 - Use atomic_int with ignoring events
 - Add mutex when accessing ACPI information 
 - Clean up registration code
 - Use cached value in profile_get function
 - Add dytc_cql_command function to clean up and provide common handler
 - Update to work with changes in platform_profile implementation

 drivers/platform/x86/thinkpad_acpi.c | 292 ++++++++++++++++++++++++++-
 1 file changed, 286 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6a4c54db38fb..40b2dece9b0e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -66,6 +66,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/power_supply.h>
+#include <linux/platform_profile.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/initval.h>
@@ -9843,16 +9844,27 @@ static bool has_lapsensor;
 static bool palm_state;
 static bool lap_state;
 
-static int lapsensor_get(bool *present, bool *state)
+static int dytc_command(int command, int *output)
 {
 	acpi_handle dytc_handle;
-	int output;
 
-	*present = false;
-	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle)))
+	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "DYTC", &dytc_handle))) {
+		/* Platform doesn't support DYTC */
 		return -ENODEV;
-	if (!acpi_evalf(dytc_handle, &output, NULL, "dd", DYTC_CMD_GET))
+	}
+	if (!acpi_evalf(dytc_handle, output, NULL, "dd", command))
 		return -EIO;
+	return 0;
+}
+
+static int lapsensor_get(bool *present, bool *state)
+{
+	int output, err;
+
+	*present = false;
+	err = dytc_command(DYTC_CMD_GET, &output);
+	if (err)
+		return err;
 
 	*present = true; /*If we get his far, we have lapmode support*/
 	*state = output & BIT(DYTC_GET_LAPMODE_BIT) ? true : false;
@@ -9971,6 +9983,262 @@ static struct ibm_struct proxsensor_driver_data = {
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
+#define DYTC_MODE_BALANCE   0xF  /* Default mode aka balanced */
+
+#define DYTC_SET_COMMAND(function, mode, on) \
+	(DYTC_CMD_SET | (function) << DYTC_SET_FUNCTION_BIT | \
+	 (mode) << DYTC_SET_MODE_BIT | \
+	 (on) << DYTC_SET_VALID_BIT)
+
+#define DYTC_DISABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 0)
+
+#define DYTC_ENABLE_CQL DYTC_SET_COMMAND(DYTC_FUNCTION_CQL, DYTC_MODE_BALANCE, 1)
+
+static bool dytc_profile_available;
+static enum platform_profile_option dytc_current_profile;
+static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
+static DEFINE_MUTEX(dytc_mutex);
+
+static int convert_dytc_to_profile(int dytcmode, enum platform_profile_option *profile)
+{
+	switch (dytcmode) {
+	case DYTC_MODE_QUIET:
+		*profile = platform_profile_low;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  platform_profile_balanced;
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
+	case platform_profile_balanced:
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
+/*
+ * dytc_profile_get: Function to register with platform_profile
+ * handler. Returns current platform profile.
+ */
+int dytc_profile_get(enum platform_profile_option *profile)
+{
+	*profile = dytc_current_profile;
+	return 0;
+}
+
+/*
+ * Helper function - check if we are in CQL mode and if we are
+ *  -  disable CQL,
+ *  - run the command
+ *  - enable CQL
+ *  If not in CQL mode, just run the command
+ */
+int dytc_cql_command(int command, int *output)
+{
+	int err, cmd_err, dummy;
+	int cur_funcmode;
+
+	/* Determine if we are in CQL mode. This alters the commands we do */
+	err = dytc_command(DYTC_CMD_GET, output);
+	if (err)
+		return err;
+
+	cur_funcmode = (*output >> DYTC_GET_FUNCTION_BIT) & 0xF;
+	/* Check if we're OK to return immediately */
+	if ((command == DYTC_CMD_GET) && (cur_funcmode != DYTC_FUNCTION_CQL))
+		return 0;
+
+	if (cur_funcmode == DYTC_FUNCTION_CQL) {
+		atomic_inc(&dytc_ignore_event);
+		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
+		if (err)
+			return err;
+	}
+
+	cmd_err = dytc_command(command,	output);
+	/* Check return condition after we've restored CQL state */
+
+	if (cur_funcmode == DYTC_FUNCTION_CQL) {
+		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
+		if (err)
+			return err;
+	}
+
+	return cmd_err;
+}
+
+/*
+ * dytc_profile_set: Function to register with platform_profile
+ * handler. Sets current platform profile.
+ */
+int dytc_profile_set(enum platform_profile_option profile)
+{
+	int output;
+	int err;
+
+	if (!dytc_profile_available)
+		return -ENODEV;
+
+	err = mutex_lock_interruptible(&dytc_mutex);
+	if (err)
+		return err;
+
+	if (profile == platform_profile_balanced) {
+		/* To get back to balanced mode we just issue a reset command */
+		err = dytc_command(DYTC_CMD_RESET, &output);
+		if (err)
+			goto unlock;
+	} else {
+		int perfmode;
+
+		err = convert_profile_to_dytc(profile, &perfmode);
+		if (err)
+			goto unlock;
+
+		/* Determine if we are in CQL mode. This alters the commands we do */
+		err = dytc_cql_command(DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1), &output);
+		if (err)
+			goto unlock;
+	}
+	/* Success - update current profile */
+	dytc_current_profile = profile;
+unlock:
+	mutex_unlock(&dytc_mutex);
+	return err;
+}
+
+static void dytc_profile_refresh(void)
+{
+	enum platform_profile_option profile;
+	int output, err;
+	int perfmode;
+
+	mutex_lock(&dytc_mutex);
+	err = dytc_cql_command(DYTC_CMD_GET, &output);
+	mutex_unlock(&dytc_mutex);
+	if (err)
+		return;
+
+	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
+	convert_dytc_to_profile(perfmode, &profile);
+	if (profile != dytc_current_profile) {
+		dytc_current_profile = profile;
+		platform_profile_notify();
+	}
+}
+
+static struct platform_profile_handler dytc_profile = {
+	.profile_get = dytc_profile_get,
+	.profile_set = dytc_profile_set,
+};
+
+static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
+{
+	int err, output;
+
+	/* Setup supported modes */
+	set_bit(platform_profile_low,      dytc_profile.choices);
+	set_bit(platform_profile_balanced, dytc_profile.choices);
+	set_bit(platform_profile_perform,  dytc_profile.choices);
+
+	dytc_profile_available = false;
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
+			err = platform_profile_register(&dytc_profile);
+			/*
+			 * If for some reason platform_profiles aren't enabled
+			 * don't quit terminally.
+			 */
+			if (err)
+				return 0;
+
+			dytc_profile_available = true;
+			/* Ensure initial values are correct */
+			dytc_profile_refresh();
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
@@ -10019,8 +10287,14 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		mutex_unlock(&kbdlight_mutex);
 	}
 
-	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED)
+	if (hkey_event == TP_HKEY_EV_THM_CSM_COMPLETED) {
 		lapsensor_refresh();
+#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
+		/* If we are already accessing DYTC then skip dytc update */
+		if (!atomic_add_unless(&dytc_ignore_event, -1, 0))
+			dytc_profile_refresh();
+#endif
+	}
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
@@ -10463,6 +10737,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

