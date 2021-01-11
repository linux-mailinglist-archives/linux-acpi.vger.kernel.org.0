Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C0A2F1AE3
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbhAKQ11 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 11:27:27 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:55771 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbhAKQ11 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 11:27:27 -0500
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id E7/FC-00973-D5B7CFF5; Mon, 11 Jan 2021 16:22:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsWS8eIhr25s9Z9
  4g2X93BZfv91mt3hzfDqTxfJ9/YwWnzsms1is3vOC2eLM6UusDmwev7atYfGYdzLQ4/2+q2we
  W662s3h83iQXwBrFmpmXlF+RwJrx9upqpoLfMRVbb25naWB869vFyMUhJPCfUWL59eusEM4DR
  onLi64AOZwcbALaElu2/GLrYuTgEBGQkfiw1hOkhllgF6PElf5uFpAaYQFfic8P3oPVsAioSj
  w+IwVi8gpYSZy5Vg9SISEgL/G0dzkziM0JVHGm6zFYp5CAisT9B0vYQGxeAUGJkzOfgMWZgeq
  bt85mhrAlJA6+eMEMM2f2zL3sEHaCxLKXd5gnMArMQtI+C0n7LCTtCxiZVzGaJhVlpmeU5CZm
  5ugaGhjoGhoa6RrqWljqJVbpJumVFuumJhaX6BrqJZYX6xVX5ibnpOjlpZZsYgRGQ0oBY+QOx
  n2vP+gdYpTkYFIS5WUx/xMvxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3XyVQTrAoNT21Ii0zBx
  iZMGkJDh4lEd6aKqA0b3FBYm5xZjpE6hSjopQ4bwNIQgAkkVGaB9cGSwaXGGWlhHkZGRgYhHg
  KUotyM0tQ5V8xinMwKgnzXgSZwpOZVwI3/RXQYiagxawOv0EWlyQipKQamKTLAzTme2Qu8OyZ
  E2ZdOedGV/ufjK7mpPOscW9Sutp9ZSdP9NiWkVnh8KRPMr1VaBfrredGsYfWcRcwrY5ZW/Zua
  pngkxP/d7/orw1o6njY7zFxc8PUTwu8N5obOfgZTOCtPnfz96t3DLrqRyfPv2X8S7H73+odnK
  d2VKa9bPpiwNsRUGXjI/y1ZYLOzRQXP4eejNjGl65p5swFpd9Vj3VxLfF++7gx5pz+buGrk/a
  vCFxibRWueDfEROnfmso9t3uMXmonM3BoPZvPfftYklrn3GymXb897V6fzoyWntPR9Tnthpl7
  EcfjuYu1HXU+aTyrSf5ltsjxkPXZFxNLhU+5PDn4Q1y5PuXeDM0TSizFGYmGWsxFxYkAx4CZh
  4EDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-18.tower-386.messagelabs.com!1610382173!1395082!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19245 invoked from network); 11 Jan 2021 16:22:53 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-18.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Jan 2021 16:22:53 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id EA907777F995A54FF9C5;
        Mon, 11 Jan 2021 11:22:52 -0500 (EST)
Received: from localhost.home (10.64.89.60) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 11 Jan
 2021 08:22:50 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <njoshi1@lenovo.com>
Subject: [PATCH v9] platform/x86: thinkpad_acpi: Add platform profile support
Date:   Mon, 11 Jan 2021 11:22:37 -0500
Message-ID: <20210111162237.3469-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.60]
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

Changes in v7 & v8:
 - version bump along with rest of patch series

Changes in v9:
 - Update define names to be correct with the linux-pm branches accepted
   version
 - Rename DYTC_MODE_QUIET to LOW_POWER just because it's confusing. It
   was originally based on internal documentation.
Note - originally this patch was part of a series but with the other two
pieces being accepted into the acpi maintainers branch this one becomes
standalone.

 drivers/platform/x86/thinkpad_acpi.c | 294 ++++++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e03df2881dc6..c5645331cfac 100644
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
@@ -9854,16 +9855,27 @@ static bool has_lapsensor;
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
@@ -9982,6 +9994,264 @@ static struct ibm_struct proxsensor_driver_data = {
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
+#define DYTC_MODE_LOWPOWER    3  /* Low power mode */
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
+	case DYTC_MODE_LOWPOWER:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case DYTC_MODE_BALANCE:
+		*profile =  PLATFORM_PROFILE_BALANCED;
+		break;
+	case DYTC_MODE_PERFORM:
+		*profile =  PLATFORM_PROFILE_PERFORMANCE;
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
+	case PLATFORM_PROFILE_LOW_POWER:
+		*perfmode = DYTC_MODE_LOWPOWER;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		*perfmode = DYTC_MODE_BALANCE;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
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
+int dytc_profile_get(struct platform_profile_handler *pprof,
+			enum platform_profile_option *profile)
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
+int dytc_profile_set(struct platform_profile_handler *pprof,
+			enum platform_profile_option profile)
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
+	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
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
@@ -10030,8 +10300,14 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
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
@@ -10474,6 +10750,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

