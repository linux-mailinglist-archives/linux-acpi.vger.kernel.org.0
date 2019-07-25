Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9875B13
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGYW4f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 18:56:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48811 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfGYW4Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 18:56:25 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 029eb76f9a03ea22; Fri, 26 Jul 2019 00:56:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 4/4] ACPI: PM: s2idle: Add acpi_sleep=no_lps0 command line switch
Date:   Fri, 26 Jul 2019 00:56:11 +0200
Message-ID: <2019011.7K24B7Jytf@kreacher>
In-Reply-To: <3471485.I2vrcDHEeC@kreacher>
References: <3471485.I2vrcDHEeC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a kernel command line switch to prevent the LPS0 _DSM funtions
from being invoked (if need be) and rework the suspend-to-idle
blacklist entries in acpisleep_dmi_table[] to make them simply
prevent suspend-to-idle from being used by default on the systems
in question (which really is the original purpose of those entries).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    5 ++-
 arch/x86/kernel/acpi/sleep.c                    |    2 +
 drivers/acpi/sleep.c                            |   34 +++++++++++++++---------
 include/linux/acpi.h                            |    1 
 4 files changed, 29 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -158,11 +158,19 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
-static bool acpi_sleep_no_lps0;
+#define ACPI_SLEEP_AVOID_LPS0_DSM	BIT(0)
+#define ACPI_SLEEP_DEFAULT_S3		BIT(1)
 
-static int __init init_no_lps0(const struct dmi_system_id *d)
+static u8 acpi_sleep_lps0_flags;
+
+void __init acpi_sleep_init_no_lps0(void)
+{
+	acpi_sleep_lps0_flags |= ACPI_SLEEP_AVOID_LPS0_DSM;
+}
+
+static int __init init_default_s3(const struct dmi_system_id *d)
 {
-	acpi_sleep_no_lps0 = true;
+	acpi_sleep_lps0_flags |= ACPI_SLEEP_DEFAULT_S3;
 	return 0;
 }
 
@@ -363,7 +371,7 @@ static const struct dmi_system_id acpisl
 	 * S0 Idle firmware interface.
 	 */
 	{
-	.callback = init_no_lps0,
+	.callback = init_default_s3,
 	.ident = "Dell XPS13 9360",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
@@ -376,7 +384,7 @@ static const struct dmi_system_id acpisl
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057).
 	 */
 	{
-	.callback = init_no_lps0,
+	.callback = init_default_s3,
 	.ident = "ThinkPad X1 Tablet(2016)",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -525,7 +533,7 @@ static void acpi_pm_end(void)
 }
 #else /* !CONFIG_ACPI_SLEEP */
 #define acpi_target_sleep_state	ACPI_STATE_S0
-#define acpi_sleep_no_lps0	(false)
+#define acpi_sleep_lps0_flags	(0)
 static inline void acpi_sleep_dmi_check(void) {}
 #endif /* CONFIG_ACPI_SLEEP */
 
@@ -904,15 +912,15 @@ static int lps0_device_attach(struct acp
 	if (lps0_device_handle)
 		return 0;
 
-	if (acpi_sleep_no_lps0) {
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		return 0;
+
+	if (acpi_sleep_lps0_flags & ACPI_SLEEP_AVOID_LPS0_DSM) {
 		acpi_handle_info(adev->handle,
 				 "Low Power S0 Idle interface disabled\n");
-		return 0;
+		goto default_sleep;
 	}
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-		return 0;
-
 	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
 	/* Check if the _DSM is present and as expected. */
 	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
@@ -933,11 +941,13 @@ static int lps0_device_attach(struct acp
 
 	lpi_device_get_constraints();
 
+default_sleep:
 	/*
 	 * Use suspend-to-idle by default if the default suspend mode was not
 	 * set from the command line.
 	 */
-	if (mem_sleep_default > PM_SUSPEND_MEM)
+	if (mem_sleep_default > PM_SUSPEND_MEM &&
+	    !(acpi_sleep_lps0_flags & ACPI_SLEEP_DEFAULT_S3))
 		mem_sleep_current = PM_SUSPEND_TO_IDLE;
 
 	return 0;
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -471,6 +471,7 @@ void __init acpi_old_suspend_ordering(vo
 void __init acpi_nvs_nosave(void);
 void __init acpi_nvs_nosave_s3(void);
 void __init acpi_sleep_no_blacklist(void);
+void __init acpi_sleep_init_no_lps0(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
Index: linux-pm/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-pm/arch/x86/kernel/acpi/sleep.c
@@ -137,6 +137,8 @@ static int __init acpi_sleep_setup(char
 			acpi_nvs_nosave_s3();
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "no_lps0", 7) == 0)
+			acpi_sleep_init_no_lps0();
 		if (strncmp(str, "nobl", 4) == 0)
 			acpi_sleep_no_blacklist();
 		str = strchr(str, ',');
Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -222,7 +222,8 @@
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, nonvs, sci_force_enable, nobl }
+				  old_ordering, nonvs, sci_force_enable,
+				  no_lps0, nobl }
 			See Documentation/power/video.rst for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
@@ -238,6 +239,8 @@
 			sci_force_enable causes the kernel to set SCI_EN directly
 			on resume from S1/S3 (which is against the ACPI spec,
 			but some broken systems don't work without it).
+			no_lps0 prevents the kernel from using the special
+			LPS0 device interface during suspend-to-idle.
 			nobl causes the internal blacklist of systems known to
 			behave incorrectly in some ways with respect to system
 			suspend and resume to be ignored (use wisely).



