Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751211541EB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgBFKcT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 05:32:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44890 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgBFKcT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Feb 2020 05:32:19 -0500
Received: from 79.184.253.222.ipv4.supernova.orange.pl (79.184.253.222) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 40d7a63af6c90ca3; Thu, 6 Feb 2020 11:32:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH] ACPI: EC: Fix flushing of pending work
Date:   Thu, 06 Feb 2020 11:32:16 +0100
Message-ID: <2209952.LFAxc7Zn43@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 016b87ca5c8c ("ACPI: EC: Rework flushing of pending work")
introduced a subtle bug into the flushing of pending EC work while
suspended to idle, which may cause the EC driver to fail to
re-enable the EC GPE after handling a non-wakeup event (like a
battery status change event, for example).

The problem is that one of the work items flushed by the
flush_scheduled_work() in __acpi_ec_flush_work() may disable the EC
GPE and schedule another work item expected to re-enable it, but that
new work item is not flushed, so __acpi_ec_flush_work() returns with
the EC GPE disabled and the CPU running it goes into an idle state
subsequently.  If all of the other CPUs are in idle states at that
point, the EC GPE won't be re-enabled until at least one CPU is woken
up by another interrupt source, so system wakeup events that would
normally come from the EC then don't work.

This is reproducible on a Dell XPS13 9360 in my office which
sometimes stops reacting to power button and lid events (triggered
by the EC on that machine) after switching from AC power to battery
power or vice versa while suspended to idle (each of those switches
causes the EC GPE to trigger for several times in a row, but they
are not system wakeup events).

To avoid this problem, change __acpi_ec_flush_work() to call
drain_workqueue() on system_wq instead of flush_scheduled_work(),
which is sufficient to make it go away on the machine mentioned
above.

Fixes: 016b87ca5c8c ("ACPI: EC: Rework flushing of pending work")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -535,7 +535,7 @@ static void acpi_ec_enable_event(struct
 #ifdef CONFIG_PM_SLEEP
 static void __acpi_ec_flush_work(void)
 {
-	flush_scheduled_work(); /* flush ec->work */
+	drain_workqueue(system_wq); /* flush ec->work */
 	flush_workqueue(ec_query_wq); /* flush queries */
 }
 



