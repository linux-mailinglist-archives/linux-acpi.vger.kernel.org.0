Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A396ACB8
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfGPQ1e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42392 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPQ1T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:19 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 1fd2e9c27e1a2ddf; Tue, 16 Jul 2019 18:27:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 6/8] PM: sleep: Simplify suspend-to-idle control flow
Date:   Tue, 16 Jul 2019 18:17:18 +0200
Message-ID: <4108141.QW3IihsyBS@kreacher>
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
References: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups
from suspend-to-idle") the "noirq" phases of device suspend and
resume may run for multiple times during suspend-to-idle, if there
are spurious system wakeup events while suspended.  However, this
is complicated and fragile and actually unnecessary.

The main reason for doing this is that on some systems the EC may
signal system wakeup events (power button events, for example) as
well as events that should not cause the system to resume (spurious
system wakeup events).  Thus, in order to determine whether or not
a given event signaled by the EC while suspended is a proper system
wakeup one, the EC GPE needs to be dispatched and to start with that
was achieved by allowing the ACPI SCI action handler to run, which
was only possible after calling resume_device_irqs().

However, dispatching the EC GPE this way turned out to take too much
time in some cases and some EC events might be missed due to that, so
commit 68e22011856f ("ACPI: EC: Dispatch the EC GPE directly on
s2idle wake") started to dispatch the EC GPE right after a wakeup
event has been detected, so in fact the full ACPI SCI action handler
doesn't need to run any more to deal with the wakeups coming from the
EC.

Use this observation to simplify the suspend-to-idle control flow
so that the "noirq" phases of device suspend and resume are each
run only once in every suspend-to-idle cycle, which is reported to
significantly reduce power drawn by some systems when suspended to
idle (by allowing them to reach a deep platform-wide low-power state
through the suspend-to-idle flow).  [What appears to happen is that
the "noirq" resume of devices after a spurious EC wakeup brings some
devices into a state in which they prevent the platform from reaching
the deep low-power state going forward, even after a subsequent
"noirq" suspend phase, and on some systems the EC triggers such
wakeups already when the "noirq" suspend of devices is running for
the first time in the given suspend/resume cycle, so the platform
cannot reach the deep low-power state at all.]

First, make acpi_s2idle_wake() use the acpi_ec_dispatch_gpe() return
value to determine whether or not the wakeup may have been triggered
by the EC (in which case the system wakeup is canceled and ACPI
events are processed in order to determine whether or not the event
is a proper system wakeup one) and use rearm_wake_irq() (introduced
by a previous change) in it to rearm the ACPI SCI for system wakeup
detection in case the system will remain suspended.

Second, drop acpi_s2idle_sync(), which is not needed any more, and
the corresponding global platform suspend-to-idle callback.

Next, drop the pm_wakeup_pending() check (which is an optimization
only) from __device_suspend_noirq() to prevent it from returning
errors on system wakeups occurring before the "noirq" phase of
device suspend is complete (as in the case of suspend-to-idle it is
not known whether or not these wakeups are suprious at that point),
in order to avoid having to carry out a "noirq" resume of devices
on a spurious system wakeup.

Finally, change the code flow in s2idle_loop() to (1) run the
"noirq" suspend of devices once before starting the loop, (2) check
for spurious EC wakeups (via the platform ->wake callback) for the
first time before calling s2idle_enter(), and (3) run the "noirq"
resume of devices once after leaving the loop.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c      |   47 +++++++++++++++++++++-------------------
 drivers/base/power/main.c |    5 ----
 include/linux/suspend.h   |    1 
 kernel/power/suspend.c    |   53 +++++++++++++++++++---------------------------
 4 files changed, 48 insertions(+), 58 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -986,33 +986,37 @@ static void acpi_s2idle_wake(void)
 		lpi_check_constraints();
 
 	/*
-	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
-	 * that the SCI has triggered while suspended, so cancel the wakeup in
-	 * case it has not been a wakeup event (the GPEs will be checked later).
+	 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the SCI has
+	 * not triggered while suspended, so bail out.
 	 */
-	if (acpi_sci_irq_valid() &&
-	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+	if (!acpi_sci_irq_valid() ||
+	    irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
+		return;
+
+	/*
+	 * If there are EC events to process, the wakeup may be a spurious one
+	 * coming from the EC.
+	 */
+	if (acpi_ec_dispatch_gpe()) {
+		/*
+		 * Cancel the wakeup and process all pending events in case
+		 * there are any wakeup ones in there.
+		 *
+		 * Note that if any non-EC GPEs are active at this point, the
+		 * SCI will retrigger after the rearming below, so no events
+		 * should be missed by canceling the wakeup here.
+		 */
 		pm_system_cancel_wakeup();
 		/*
-		 * On some platforms with the LPS0 _DSM device noirq resume
-		 * takes too much time for EC wakeup events to survive, so look
-		 * for them now.
+		 * The EC driver uses the system workqueue and an additional
+		 * special one, so those need to be flushed too.
 		 */
-		acpi_ec_dispatch_gpe();
+		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
+		acpi_ec_flush_work();
+		acpi_os_wait_events_complete(); /* synchronize Notify handling */
 	}
-}
 
-static void acpi_s2idle_sync(void)
-{
-	/*
-	 * Process all pending events in case there are any wakeup ones.
-	 *
-	 * The EC driver uses the system workqueue and an additional special
-	 * one, so those need to be flushed too.
-	 */
-	acpi_os_wait_events_complete();	/* synchronize SCI IRQ handling */
-	acpi_ec_flush_work();
-	acpi_os_wait_events_complete();	/* synchronize Notify handling */
+	rearm_wake_irq(acpi_sci_irq);
 }
 
 static void acpi_s2idle_restore(void)
@@ -1044,7 +1048,6 @@ static const struct platform_s2idle_ops
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.wake = acpi_s2idle_wake,
-	.sync = acpi_s2idle_sync,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
 };
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -191,7 +191,6 @@ struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	void (*wake)(void);
-	void (*sync)(void);
 	void (*restore)(void);
 	void (*end)(void);
 };
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1291,11 +1291,6 @@ static int __device_suspend_noirq(struct
 	if (async_error)
 		goto Complete;
 
-	if (pm_wakeup_pending()) {
-		async_error = -EBUSY;
-		goto Complete;
-	}
-
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -119,48 +119,41 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
-	pm_pr_dbg("suspend-to-idle\n");
-
-	for (;;) {
-		int error;
+	int error;
 
-		dpm_noirq_begin();
+	dpm_noirq_begin();
+	error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
+	if (error)
+		goto resume;
 
-		/*
-		 * Suspend-to-idle equals
-		 * frozen processes + suspended devices + idle processors.
-		 * Thus s2idle_enter() should be called right after
-		 * all devices have been suspended.
-		 *
-		 * Wakeups during the noirq suspend of devices may be spurious,
-		 * so prevent them from terminating the loop right away.
-		 */
-		error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
-		if (!error)
-			s2idle_enter();
-		else if (error == -EBUSY && pm_wakeup_pending())
-			error = 0;
+	pm_pr_dbg("suspend-to-idle\n");
 
-		if (!error && s2idle_ops && s2idle_ops->wake)
+	/*
+	 * Suspend-to-idle equals:
+	 * frozen processes + suspended devices + idle processors.
+	 * Thus s2idle_enter() should be called right after all devices have
+	 * been suspended.
+	 *
+	 * Wakeups during the noirq suspend of devices may be spurious, so try
+	 * to avoid them upfront.
+	 */
+	for (;;) {
+		if (s2idle_ops && s2idle_ops->wake)
 			s2idle_ops->wake();
 
-		dpm_noirq_resume_devices(PMSG_RESUME);
-
-		dpm_noirq_end();
-
-		if (error)
-			break;
-
-		if (s2idle_ops && s2idle_ops->sync)
-			s2idle_ops->sync();
-
 		if (pm_wakeup_pending())
 			break;
 
 		pm_wakeup_clear(false);
+
+		s2idle_enter();
 	}
 
 	pm_pr_dbg("resume from suspend-to-idle\n");
+
+resume:
+	dpm_noirq_resume_devices(PMSG_RESUME);
+	dpm_noirq_end();
 }
 
 void s2idle_wake(void)



