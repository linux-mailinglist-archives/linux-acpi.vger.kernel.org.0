Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8CB2D6E11
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 03:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgLKCP5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 21:15:57 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:46880 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387840AbgLKCP3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 21:15:29 -0500
Received: from [100.112.133.223] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id E8/8A-33082-8F4D2DF5; Fri, 11 Dec 2020 02:10:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsWSLveKXffHlUv
  xBqs3yVvsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBmHm3+yFlyMqJjbvZq9gXGGVxcjF4eQwH9GiXXP/rJAOA8YJb7u38/axcjJwS
  agLbFlyy+2LkYODhEBGYkPaz1BapgFtjJJnNy3E6xGWCBQYvrV70wgNouAqsSB69OYQWxeARu
  J+81zwWokBOQlnvYuB4tzCthK3H90mRHEFhIIk3j0sosdol5Q4uTMJywgNjNQffPW2cwQtoTE
  wRcvmGHmzLk4FcpOkFj28g7zBEaBWUjaZyFpn4WkfQEj8ypGi6SizPSMktzEzBxdQwMDXUNDI
  11DYyNdIxMjvcQq3SS90mLd8tTiEl0gt7xYr7gyNzknRS8vtWQTIzDWUgpaPu1gbHjzQe8Qoy
  QHk5Io7+PJl+KF+JLyUyozEosz4otKc1KLDzHKcHAoSfCqXwbKCRalpqdWpGXmAOMeJi3BwaM
  kwpsDkuYtLkjMLc5Mh0idYlSUEudVBkkIgCQySvPg2mCp5hKjrJQwLyMDA4MQT0FqUW5mCar8
  K0ZxDkYlYV5uYOIS4snMK4Gb/gpoMRPQYp5L50EWlyQipKQamNIXmiTLz4wxWH1uW/vm2JD9i
  vFhprbJc578TzvwsbP32aXUjS8fZ7XumJSZlfDHNsmtNlFHx0khsvma3H6F4yHrXpy9OtF3RU
  yNlHMtR3CKr/4sw9rIXdsNnH5v16/TvKCqmW7W2GVsXDH1xO43LmILWcpe5luvi3pqmnUjyaT
  2+2eJdnEd+S1XbH4e6iq/uLRyhdp2zz8btE7tn/ZX99PLzrNdEzLuf7jk1emyftqxn6e/dJYc
  +z9h6c3u2zOX+04p9/3UoRaUIVy09uD8lW998pZ88F2+VvnVKy+vB7eO/iifMX2b2v1T0yZL9
  VtvKGm/l9RteNpKKFsy5M5f/TZh5YBldwsV9rLM8Ql6HqbEUpyRaKjFXFScCAA0iEPmsAMAAA
  ==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-30.tower-356.messagelabs.com!1607652597!26756!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23147 invoked from network); 11 Dec 2020 02:10:00 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-30.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Dec 2020 02:10:00 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id C15A74FD58166321ED9A;
        Fri, 11 Dec 2020 10:09:54 +0800 (CST)
Received: from localhost.home (10.64.86.16) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 10 Dec
 2020 18:09:48 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>,
        <njosh1@lenovo.com>
Subject: [PATCH v6 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Thu, 10 Dec 2020 21:06:30 -0500
Message-ID: <20201211020630.305905-3-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201211020630.305905-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201211020630.305905-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.86.16]
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

Changes in v6:
 - Update file to build against update in v6 platform_profile

 drivers/platform/x86/thinkpad_acpi.c | 292 ++++++++++++++++++++++++++-
 1 file changed, 286 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6a4c54db38fb..e08b3548afd1 100644
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
+		*profile = PLATFORM_PROFILE_LOW;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case DYTC_MODE_PERFORM:
+		*profile =  PLATFORM_PROFILE_PERFORM;
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
+	case PLATFORM_PROFILE_QUIET:
+		*perfmode = DYTC_MODE_QUIET;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		*perfmode = DYTC_MODE_BALANCE;
+		break;
+	case PLATFORM_PROFILE_PERFORM:
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
+	if (profile == PLATFORM_PROFILE_BALANCED) {
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
+	set_bit(PLATFORM_PROFILE_LOW,      dytc_profile.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
+	set_bit(PLATFORM_PROFILE_PERFORM,  dytc_profile.choices);
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
+		platform_profile_remove();
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

