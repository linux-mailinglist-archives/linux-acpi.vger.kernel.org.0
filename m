Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF41CB522
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEHQqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 12:46:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQqV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2020 12:46:21 -0400
Received: from 89-64-85-173.dynamic.chello.pl (89.64.85.173) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id b97d93fcd990997d; Fri, 8 May 2020 18:46:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] ACPI: EC: s2idle: Avoid premature returns from acpi_s2idle_wake()
Date:   Fri, 08 May 2020 18:46:17 +0200
Message-ID: <1604462.Hd3yvOQCVk@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the EC GPE status is not set after checking all of the other GPEs,
acpi_s2idle_wake() returns 'false', to indicate that the SCI event
that has just triggered is not a system wakeup one, but it does that
without canceling the pending wakeup and re-arming the SCI for system
wakeup which is a mistake, because it may cause valid subsequent
wakeup events to be missed.

Fix that by moving all of the GPE checking logic from
acpi_s2idle_wake() to acpi_ec_dispatch_gpe() and making the
latter return 'true' only if a non-EC GPE has triggered and
'false' otherwise, which will cause acpi_s2idle_wake() to
cancel the pending SCI wakeup and re-arm the SCI for system
wakeup regardless of the EC GPE status.

Fixes: d5406284ff80 ("ACPI: PM: s2idle: Refine active GPEs check")
Reported-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   24 ++++++++++++++++--------
 drivers/acpi/internal.h |    1 -
 drivers/acpi/sleep.c    |   14 ++------------
 3 files changed, 18 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
 		if (acpi_check_wakeup_handlers())
 			return true;
 
-		/*
-		 * If the status bit is set for any enabled GPE other than the
-		 * EC one, the wakeup is regarded as a genuine one.
-		 */
-		if (acpi_ec_other_gpes_active())
+		/* Check non-EC GPE wakeups and dispatch the EC GPE. */
+		if (acpi_ec_dispatch_gpe())
 			return true;
 
 		/*
-		 * If the EC GPE status bit has not been set, the wakeup is
-		 * regarded as a spurious one.
-		 */
-		if (!acpi_ec_dispatch_gpe())
-			return false;
-
-		/*
 		 * Cancel the wakeup and process all pending events in case
 		 * there are any wakeup ones in there.
 		 *
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1994,23 +1994,31 @@ void acpi_ec_set_gpe_wake_mask(u8 action
 		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
 
-bool acpi_ec_other_gpes_active(void)
-{
-	return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX);
-}
-
 bool acpi_ec_dispatch_gpe(void)
 {
 	u32 ret;
 
 	if (!first_ec)
+		return acpi_any_gpe_status_set(U32_MAX);
+
+	/*
+	 * Report wakeup if the status bit is set for any enabled GPE other
+	 * than the EC one.
+	 */
+	if (acpi_any_gpe_status_set(first_ec->gpe))
+		return true;
+
+	if (ec_no_wakeup)
 		return false;
 
+	/*
+	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
+	 * to allow the caller to process events properly after that.
+	 */
 	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	if (ret == ACPI_INTERRUPT_HANDLED) {
+	if (ret == ACPI_INTERRUPT_HANDLED)
 		pm_pr_dbg("EC GPE dispatched\n");
-		return true;
-	}
+
 	return false;
 }
 #endif /* CONFIG_PM_SLEEP */
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
-bool acpi_ec_other_gpes_active(void);
 bool acpi_ec_dispatch_gpe(void);
 #endif
 



