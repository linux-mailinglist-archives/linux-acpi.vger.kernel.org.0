Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21B41D2C30
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgENKKF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 06:10:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52220 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENKKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2020 06:10:05 -0400
Received: from 89-64-84-17.dynamic.chello.pl (89.64.84.17) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id bfcb0575ef1464d6; Thu, 14 May 2020 12:10:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE is inactive
Date:   Thu, 14 May 2020 12:10:01 +0200
Message-ID: <4502272.pByIgeXik9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Flushing the EC work while suspended to idle when the EC GPE status
is not set causes some EC wakeup events (notably power button and
lid ones) to be missed after a series of spurious wakeups on the Dell
XPS13 9360 in my office.

If that happens, the machine cannot be woken up from suspend-to-idle
by a power button press or lid status change and it needs to be woken
up in some other way (eg. by a key press).

Flushing the EC work only after successful dispatching the EC GPE,
which means that its status has been set, avoids the issue, so change
the code in question accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi Chris,

Please check if the key press wakeup still works on your system with this patch
applied (on top of https://patchwork.kernel.org/patch/11538065/).

Thanks!

---
 drivers/acpi/ec.c    |    6 +++++-
 drivers/acpi/sleep.c |   15 ++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2020,9 +2020,13 @@ bool acpi_ec_dispatch_gpe(void)
 	 * to allow the caller to process events properly after that.
 	 */
 	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	if (ret == ACPI_INTERRUPT_HANDLED)
+	if (ret == ACPI_INTERRUPT_HANDLED) {
 		pm_pr_dbg("EC GPE dispatched\n");
 
+		/* Flush the event and query workqueues. */
+		acpi_ec_flush_work();
+	}
+
 	return false;
 }
 #endif /* CONFIG_PM_SLEEP */
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -980,13 +980,6 @@ static int acpi_s2idle_prepare_late(void
 	return 0;
 }
 
-static void acpi_s2idle_sync(void)
-{
-	/* The EC driver uses special workqueues that need to be flushed. */
-	acpi_ec_flush_work();
-	acpi_os_wait_events_complete(); /* synchronize Notify handling */
-}
-
 static bool acpi_s2idle_wake(void)
 {
 	if (!acpi_sci_irq_valid())
@@ -1018,7 +1011,7 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
-		 * Cancel the wakeup and process all pending events in case
+		 * Cancel the SCI wakeup and process all pending events in case
 		 * there are any wakeup ones in there.
 		 *
 		 * Note that if any non-EC GPEs are active at this point, the
@@ -1026,8 +1019,7 @@ static bool acpi_s2idle_wake(void)
 		 * should be missed by canceling the wakeup here.
 		 */
 		pm_system_cancel_wakeup();
-
-		acpi_s2idle_sync();
+		acpi_os_wait_events_complete();
 
 		/*
 		 * The SCI is in the "suspended" state now and it cannot produce
@@ -1060,7 +1052,8 @@ static void acpi_s2idle_restore(void)
 	 * of GPEs.
 	 */
 	acpi_os_wait_events_complete(); /* synchronize GPE processing */
-	acpi_s2idle_sync();
+	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 
 	s2idle_wakeup = false;
 



