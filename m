Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAB44E94
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFMVhe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 17:37:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49424 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVhe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 17:37:34 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 480796b137926e4f; Thu, 13 Jun 2019 23:37:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shaunak Saha <shaunak.saha@intel.com>
Cc:     linux-acpi@vger.kernel.org, mario_limonciello@dell.com
Subject: Re: drivers/acpi: Change the lpit function call flow
Date:   Thu, 13 Jun 2019 23:37:30 +0200
Message-ID: <2151762.asltZFE8WJ@kreacher>
In-Reply-To: <20190526202750.4614-1-shaunak.saha@intel.com>
References: <20190526202750.4614-1-shaunak.saha@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sunday, May 26, 2019 10:27:50 PM CEST Shaunak Saha wrote:
> In the present implementation sleep function was getting called in
> acpi_s2idle_prepare and as all the devices may not have suspended
> at that stage e.g. if we are telling ec about the S0ix then calling early
> can cause ec reply wrongly interpreted as spurious wake events.
> Here we call it at much later stage in acpi_s2idle_sync. As per the
> specification the entry _DSM function may be invoked when the OS state has
> reached sufficient criteria for processor idle state entry matching
> Entry Trigger defined in LPIT to be interpreted as a request for the
> platform to enter a Low Power S0 Idle (LPI) state. Here we are checking if
> the we reached the minimum D-State defined in the constraint function of
> the LPIT _DSM method before calling the sleep entry function. Also not
> checking for constraint in acpi_s2idle_wake anymore and also changed the
> acpi info loglevel to debug in lpi_check_constraint.

This patch does three different things, two of which are questionable and
one is done incorrectly.

First off, aborting system suspend because S0ix constraints are not met is
a non-starter.  The kernel really cannot refuse to suspend the system for
that reason (and diagnostics can be done after resume anyway).

Second, according to my knowledge, it is not a bug to invoke the
ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you
actually know about any platforms where that may cause real problems
to occur?

Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because
that is called after leaving S0ix and resuming some devices.

I can believe the claim that invoking the ACPI_LPS0_ENTRY _DSM in
acpi_s2idle_prepare() may be too early and it may confuse the EC, say,
but I'm not sure why the ACPI_LPS0_SCREEN_OFF _DSM would be
affected by that too.

So overall, the patch below may actually work, but not the $subject one
(if evaluating the ACPI_LPS0_ENTRY _DSM when the constraints are not
met is *really* problematic, it may be necessary to add the check
for that on top of it).

---
 drivers/acpi/sleep.c    |   13 +++++++++----
 include/linux/suspend.h |    1 +
 kernel/power/suspend.c  |    8 ++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -967,8 +967,6 @@ static int acpi_s2idle_prepare(void)
 {
 	if (lps0_device_handle) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
@@ -983,6 +981,12 @@ static int acpi_s2idle_prepare(void)
 	return 0;
 }
 
+static void acpi_s2idle_sleep(void)
+{
+	if (lps0_device_handle)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+}
+
 static void acpi_s2idle_wake(void)
 {
 	if (!lps0_device_handle)
@@ -1007,6 +1011,8 @@ static void acpi_s2idle_wake(void)
 		 */
 		acpi_ec_dispatch_gpe();
 	}
+
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 }
 
 static void acpi_s2idle_sync(void)
@@ -1034,8 +1040,6 @@ static void acpi_s2idle_restore(void)
 
 	if (lps0_device_handle) {
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
-
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	}
 }
@@ -1049,6 +1053,7 @@ static void acpi_s2idle_end(void)
 static const struct platform_s2idle_ops acpi_s2idle_ops = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
+	.sleep = acpi_s2idle_sleep,
 	.wake = acpi_s2idle_wake,
 	.sync = acpi_s2idle_sync,
 	.restore = acpi_s2idle_restore,
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -190,6 +190,7 @@ struct platform_suspend_ops {
 struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
+	void (*sleep)(void);
 	void (*wake)(void);
 	void (*sync)(void);
 	void (*restore)(void);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -136,10 +136,14 @@ static void s2idle_loop(void)
 		 * so prevent them from terminating the loop right away.
 		 */
 		error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
-		if (!error)
+		if (!error) {
+			if (s2idle_ops && s2idle_ops->sleep)
+				s2idle_ops->sleep();
+
 			s2idle_enter();
-		else if (error == -EBUSY && pm_wakeup_pending())
+		} else if (error == -EBUSY && pm_wakeup_pending()) {
 			error = 0;
+		}
 
 		if (!error && s2idle_ops && s2idle_ops->wake)
 			s2idle_ops->wake();



