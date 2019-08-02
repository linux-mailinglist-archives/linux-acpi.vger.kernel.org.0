Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFC7F55D
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390950AbfHBKqL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 06:46:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51281 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbfHBKpw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 06:45:52 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 4cf97550f7c11232; Fri, 2 Aug 2019 12:45:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 3/8] ACPI: PM: s2idle: Add acpi.sleep_no_lps0 module parameter
Date:   Fri, 02 Aug 2019 12:38:40 +0200
Message-ID: <2163806.ECDdQTgCPu@kreacher>
In-Reply-To: <5997740.FPbUVk04hV@kreacher>
References: <5997740.FPbUVk04hV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a module parameter to prevent the ACPI LPS0 _DSM functions
from being invoked (if need be) and rework the suspend-to-idle
blacklist entries in acpisleep_dmi_table[] to make them simply
prevent suspend-to-idle from being used by default on the systems
in question (which really is the original purpose of those entries).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

In v2 this was patch 4.

---
 drivers/acpi/sleep.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -89,6 +89,10 @@ bool acpi_sleep_state_supported(u8 sleep
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+static bool sleep_no_lps0 __read_mostly;
+module_param(sleep_no_lps0, bool, 0644);
+MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
+
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 u32 acpi_target_system_state(void)
@@ -158,11 +162,11 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
-static bool acpi_sleep_no_lps0;
+static bool acpi_sleep_default_s3;
 
-static int __init init_no_lps0(const struct dmi_system_id *d)
+static int __init init_default_s3(const struct dmi_system_id *d)
 {
-	acpi_sleep_no_lps0 = true;
+	acpi_sleep_default_s3 = true;
 	return 0;
 }
 
@@ -363,7 +367,7 @@ static const struct dmi_system_id acpisl
 	 * S0 Idle firmware interface.
 	 */
 	{
-	.callback = init_no_lps0,
+	.callback = init_default_s3,
 	.ident = "Dell XPS13 9360",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
@@ -376,7 +380,7 @@ static const struct dmi_system_id acpisl
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057).
 	 */
 	{
-	.callback = init_no_lps0,
+	.callback = init_default_s3,
 	.ident = "ThinkPad X1 Tablet(2016)",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -524,8 +528,9 @@ static void acpi_pm_end(void)
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
 #else /* !CONFIG_ACPI_SLEEP */
+#define sleep_no_lps0	(1)
 #define acpi_target_sleep_state	ACPI_STATE_S0
-#define acpi_sleep_no_lps0	(false)
+#define acpi_sleep_default_s3	(1)
 static inline void acpi_sleep_dmi_check(void) {}
 #endif /* CONFIG_ACPI_SLEEP */
 
@@ -904,12 +909,6 @@ static int lps0_device_attach(struct acp
 	if (lps0_device_handle)
 		return 0;
 
-	if (acpi_sleep_no_lps0) {
-		acpi_handle_info(adev->handle,
-				 "Low Power S0 Idle interface disabled\n");
-		return 0;
-	}
-
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
 
@@ -937,7 +936,7 @@ static int lps0_device_attach(struct acp
 	 * Use suspend-to-idle by default if the default suspend mode was not
 	 * set from the command line.
 	 */
-	if (mem_sleep_default > PM_SUSPEND_MEM)
+	if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
 		mem_sleep_current = PM_SUSPEND_TO_IDLE;
 
 	return 0;
@@ -957,7 +956,7 @@ static int acpi_s2idle_begin(void)
 
 static int acpi_s2idle_prepare(void)
 {
-	if (lps0_device_handle) {
+	if (lps0_device_handle && !sleep_no_lps0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
 	}
@@ -977,7 +976,7 @@ static int acpi_s2idle_prepare(void)
 
 static void acpi_s2idle_wake(void)
 {
-	if (lps0_device_handle && pm_debug_messages_on)
+	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on)
 		lpi_check_constraints();
 
 	/*
@@ -1025,7 +1024,7 @@ static void acpi_s2idle_restore(void)
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
 
-	if (lps0_device_handle) {
+	if (lps0_device_handle && !sleep_no_lps0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	}



