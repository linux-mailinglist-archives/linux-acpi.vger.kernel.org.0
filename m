Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF71D9568
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgESLgw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 07:36:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46862 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgESLgw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 07:36:52 -0400
Received: from 89-64-84-14.dynamic.chello.pl (89.64.84.14) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a7004566450acdb1; Tue, 19 May 2020 13:36:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: PM: s2idle: Print type of wakeup debug messages
Date:   Tue, 19 May 2020 13:36:48 +0200
Message-ID: <1709513.f9ygnvZT4z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_s2idle_wake() knows the category of wakeup causing the
system to resume from suspend-to-idle, make it print a unique message
for each of them to help diagnose wakeup issues.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The patch is on top of the linux-next branch in linux-pm.git.

---
 drivers/acpi/sleep.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -992,23 +992,31 @@ static bool acpi_s2idle_wake(void)
 		 * wakeup is pending anyway and the SCI is not the source of
 		 * it).
 		 */
-		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
+		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
 			return true;
+		}
 
 		/*
 		 * If the status bit of any enabled fixed event is set, the
 		 * wakeup is regarded as valid.
 		 */
-		if (acpi_any_fixed_event_status_set())
+		if (acpi_any_fixed_event_status_set()) {
+			pm_pr_dbg("ACPI fixed event wakeup\n");
 			return true;
+		}
 
 		/* Check wakeups from drivers sharing the SCI. */
-		if (acpi_check_wakeup_handlers())
+		if (acpi_check_wakeup_handlers()) {
+			pm_pr_dbg("ACPI custom handler wakeup\n");
 			return true;
+		}
 
 		/* Check non-EC GPE wakeups and dispatch the EC GPE. */
-		if (acpi_ec_dispatch_gpe())
+		if (acpi_ec_dispatch_gpe()) {
+			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
 			return true;
+		}
 
 		/*
 		 * Cancel the SCI wakeup and process all pending events in case
@@ -1027,8 +1035,10 @@ static bool acpi_s2idle_wake(void)
 		 * are pending here, they must be resulting from the processing
 		 * of EC events above or coming from somewhere else.
 		 */
-		if (pm_wakeup_pending())
+		if (pm_wakeup_pending()) {
+			pm_pr_dbg("Wakeup after ACPI Notify sync\n");
 			return true;
+		}
 
 		rearm_wake_irq(acpi_sci_irq);
 	}



