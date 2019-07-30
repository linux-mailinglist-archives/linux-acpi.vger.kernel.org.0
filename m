Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231E17A57D
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfG3KFa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:05:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41118 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbfG3KFR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jul 2019 06:05:17 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id fdd0436f7e66a7e8; Tue, 30 Jul 2019 12:05:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/8] ACPI: PM: s2idle: Execute LPS0 _DSM functions with suspended devices
Date:   Tue, 30 Jul 2019 11:56:24 +0200
Message-ID: <2068587.dvBf1putrx@kreacher>
In-Reply-To: <7528887.mqcfy9PZua@kreacher>
References: <7528887.mqcfy9PZua@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to Section 3.5 of the "Intel Low Power S0 Idle" document [1],
Function 5 of the LPS0 _DSM is expected to be invoked when the system
configuration matches the criteria for entering the target low-power
state of the platform.  In particular, this means that all devices
should be suspended and in low-power states already when that function
is invoked.

This is not the case currently, however, because Function 5 of the
LPS0 _DSM is invoked by it before the "noirq" phase of device suspend,
which means that some devices may not have been put into low-power
states yet at that point.  That is a consequence of the previous
design of the suspend-to-idle flow that allowed the "noirq" phase of
device suspend and the "noirq" phase of device resume to be carried
out for multiple times while "suspended" (if any spurious wakeup
events were detected) and the point of the LPS0 _DSM Function 5
invocation was chosen so as to call it (and LPS0 _DSM Function 6
analogously) once per suspend-resume cycle (regardless of how many
times the "noirq" phases of device suspend and resume were carried
out while "suspended").

Now that the suspend-to-idle flow has been redesigned to carry out
the "noirq" phases of device suspend and resume once in each cycle,
the code can be reordered to follow the specification that it is
based on more closely.

For this purpose, add ->prepare_late and ->restore_early platform
callbacks for suspend-to-idle, to be executed, respectively, after
the "noirq" phase of suspending devices and before the "noirq"
phase of resuming them and make ACPI use them for the invocation
of LPS0 _DSM functions as appropriate.

While at it, move the LPS0 entry requirements check to be made
before invoking Functions 3 and 5 of the LPS0 _DSM (also once
per cycle) as follows from the specification [1].

Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes in v2.

---
 drivers/acpi/sleep.c    |   36 ++++++++++++++++++++++++------------
 include/linux/suspend.h |    2 ++
 kernel/power/suspend.c  |   12 +++++++++---
 3 files changed, 35 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -955,11 +955,6 @@ static int acpi_s2idle_begin(void)
 
 static int acpi_s2idle_prepare(void)
 {
-	if (lps0_device_handle) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-	}
-
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
 
@@ -973,11 +968,22 @@ static int acpi_s2idle_prepare(void)
 	return 0;
 }
 
-static void acpi_s2idle_wake(void)
+static int acpi_s2idle_prepare_late(void)
 {
-	if (lps0_device_handle && pm_debug_messages_on)
+	if (!lps0_device_handle)
+		return 0;
+
+	if (pm_debug_messages_on)
 		lpi_check_constraints();
 
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+
+	return 0;
+}
+
+static void acpi_s2idle_wake(void)
+{
 	/*
 	 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the SCI has
 	 * not triggered while suspended, so bail out.
@@ -1012,6 +1018,15 @@ static void acpi_s2idle_wake(void)
 	rearm_wake_irq(acpi_sci_irq);
 }
 
+static void acpi_s2idle_restore_early(void)
+{
+	if (!lps0_device_handle)
+		return;
+
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
+}
+
 static void acpi_s2idle_restore(void)
 {
 	s2idle_wakeup = false;
@@ -1022,11 +1037,6 @@ static void acpi_s2idle_restore(void)
 
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
-
-	if (lps0_device_handle) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
-	}
 }
 
 static void acpi_s2idle_end(void)
@@ -1038,7 +1048,9 @@ static void acpi_s2idle_end(void)
 static const struct platform_s2idle_ops acpi_s2idle_ops = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
+	.prepare_late = acpi_s2idle_prepare_late,
 	.wake = acpi_s2idle_wake,
+	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
 };
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -253,13 +253,19 @@ static int platform_suspend_prepare_late
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
 {
-	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare_late ?
-		suspend_ops->prepare_late() : 0;
+	if (state == PM_SUSPEND_TO_IDLE) {
+		if (s2idle_ops && s2idle_ops->prepare_late)
+			return s2idle_ops->prepare_late();
+	}
+	return suspend_ops->prepare_late ? suspend_ops->prepare_late() : 0;
 }
 
 static void platform_resume_noirq(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_TO_IDLE && suspend_ops->wake)
+	if (state == PM_SUSPEND_TO_IDLE) {
+		if (s2idle_ops && s2idle_ops->restore_early)
+			s2idle_ops->restore_early();
+	} else if (suspend_ops->wake)
 		suspend_ops->wake();
 }
 
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -190,7 +190,9 @@ struct platform_suspend_ops {
 struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
+	int (*prepare_late)(void);
 	void (*wake)(void);
+	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
 };



