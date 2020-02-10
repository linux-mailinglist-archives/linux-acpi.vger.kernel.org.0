Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9451575DA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2020 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgBJMpd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Feb 2020 07:45:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56364 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbgBJMpc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2020 07:45:32 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id b5b46441409b89cc; Mon, 10 Feb 2020 13:45:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH] ACPI: PM: s2idle: Avoid possible race related to the EC GPE
Date:   Mon, 10 Feb 2020 13:45:29 +0100
Message-ID: <11464642.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is theoretically possible for the ACPI EC GPE to be set after the
s2idle_ops->wake() called from s2idle_loop() has returned and before
the subsequent pm_wakeup_pending() check is carried out.  If that
happens, the resulting wakeup event will cause the system to resume
even though it may be a spurious one.

To avoid that race, first make the ->wake() callback in struct
platform_s2idle_ops return a bool value indicating whether or not
to let the system resume and rearrange s2idle_loop() to use that
value instad of the direct pm_wakeup_pending() call if ->wake() is
present.

Next, rework acpi_s2idle_wake() to process EC events and check
pm_wakeup_pending() before rearming the SCI for system wakeup
to prevent it from triggering prematurely and add comments to
that function to explain the rationale for the new code flow.

Fixes: 56b991849009 ("PM: sleep: Simplify suspend-to-idle control flow")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c    |   46 ++++++++++++++++++++++++++++++++--------------
 include/linux/suspend.h |    2 +-
 kernel/power/suspend.c  |    9 +++++----
 3 files changed, 38 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -990,21 +990,28 @@ static void acpi_s2idle_sync(void)
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 }
 
-static void acpi_s2idle_wake(void)
+static bool acpi_s2idle_wake(void)
 {
-	/*
-	 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the SCI has
-	 * not triggered while suspended, so bail out.
-	 */
-	if (!acpi_sci_irq_valid() ||
-	    irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
-		return;
-
-	/*
-	 * If there are EC events to process, the wakeup may be a spurious one
-	 * coming from the EC.
-	 */
-	if (acpi_ec_dispatch_gpe()) {
+	if (!acpi_sci_irq_valid())
+		return pm_wakeup_pending();
+
+	while (pm_wakeup_pending()) {
+		/*
+		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
+		 * SCI has not triggered while suspended, so bail out (the
+		 * wakeup is pending anyway and the SCI is not the source of
+		 * it).
+		 */
+		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
+			return true;
+
+		/*
+		 * If there are no EC events to process, the wakeup is regarded
+		 * as a genuine one.
+		 */
+		if (!acpi_ec_dispatch_gpe())
+			return true;
+
 		/*
 		 * Cancel the wakeup and process all pending events in case
 		 * there are any wakeup ones in there.
@@ -1017,8 +1024,19 @@ static void acpi_s2idle_wake(void)
 
 		acpi_s2idle_sync();
 
+		/*
+		 * The SCI is in the "suspended" state now and it cannot produce
+		 * new wakeup events till the rearming below, so if any of them
+		 * are pending here, they must be resulting from the processing
+		 * of EC events above or coming from somewhere else.
+		 */
+		if (pm_wakeup_pending())
+			return true;
+
 		rearm_wake_irq(acpi_sci_irq);
 	}
+
+	return false;
 }
 
 static void acpi_s2idle_restore_early(void)
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -191,7 +191,7 @@ struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
-	void (*wake)(void);
+	bool (*wake)(void);
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -131,11 +131,12 @@ static void s2idle_loop(void)
 	 * to avoid them upfront.
 	 */
 	for (;;) {
-		if (s2idle_ops && s2idle_ops->wake)
-			s2idle_ops->wake();
-
-		if (pm_wakeup_pending())
+		if (s2idle_ops && s2idle_ops->wake) {
+			if (s2idle_ops->wake())
+				break;
+		} else if (pm_wakeup_pending()) {
 			break;
+		}
 
 		pm_wakeup_clear(false);
 



