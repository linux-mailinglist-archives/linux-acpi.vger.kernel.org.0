Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22010158B95
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 10:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBKJEp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 04:04:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43935 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgBKJEo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 04:04:44 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id adfc0e3b68c92435; Tue, 11 Feb 2020 10:04:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] ACPI: EC: Fix flushing of pending work
Date:   Tue, 11 Feb 2020 10:04:40 +0100
Message-ID: <28760106.ljELEbzjY3@kreacher>
In-Reply-To: <2209952.LFAxc7Zn43@kreacher>
References: <2209952.LFAxc7Zn43@kreacher>
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

The problem is that the work item flushed by flush_scheduled_work()
in __acpi_ec_flush_work() may disable the EC GPE and schedule another
work item expected to re-enable it, but that new work item is not
flushed, so __acpi_ec_flush_work() returns with the EC GPE disabled
and the CPU running it goes into an idle state subsequently.  If all
of the other CPUs are in idle states at that point, the EC GPE won't
be re-enabled until at least one CPU is woken up by another interrupt
source, so system wakeup events that would normally come from the EC
then don't work.

This is reproducible on a Dell XPS13 9360 in my office which
sometimes stops reacting to power button and lid events (triggered
by the EC on that machine) after switching from AC power to battery
power or vice versa while suspended to idle (each of those switches
causes the EC GPE to trigger for several times in a row, but they
are not system wakeup events).

To avoid this problem, it is necessary to drain the workqueue
entirely in __acpi_ec_flush_work(), but that cannot be done with
respect to system_wq, because work items may be added to it from
other places while __acpi_ec_flush_work() is running.  For this
reason, make the EC driver use a dedicated workqueue for EC events
processing (let that workqueue be ordered so that EC events are
processed sequentially) and use drain_workqueue() on it in
__acpi_ec_flush_work().

Fixes: 016b87ca5c8c ("ACPI: EC: Rework flushing of pending work")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
   * Use a dedicated wq for EC events.

---
 drivers/acpi/ec.c |   43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -179,6 +179,7 @@ EXPORT_SYMBOL(first_ec);
 
 static struct acpi_ec *boot_ec;
 static bool boot_ec_is_ecdt = false;
+static struct workqueue_struct *ec_wq;
 static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
@@ -469,7 +470,7 @@ static void acpi_ec_submit_query(struct
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
-		schedule_work(&ec->work);
+		queue_work(ec_wq, &ec->work);
 	}
 }
 
@@ -535,7 +536,7 @@ static void acpi_ec_enable_event(struct
 #ifdef CONFIG_PM_SLEEP
 static void __acpi_ec_flush_work(void)
 {
-	flush_scheduled_work(); /* flush ec->work */
+	drain_workqueue(ec_wq); /* flush ec->work */
 	flush_workqueue(ec_query_wq); /* flush queries */
 }
 
@@ -556,8 +557,8 @@ static void acpi_ec_disable_event(struct
 
 void acpi_ec_flush_work(void)
 {
-	/* Without ec_query_wq there is nothing to flush. */
-	if (!ec_query_wq)
+	/* Without ec_wq there is nothing to flush. */
+	if (!ec_wq)
 		return;
 
 	__acpi_ec_flush_work();
@@ -2107,25 +2108,33 @@ static struct acpi_driver acpi_ec_driver
 	.drv.pm = &acpi_ec_pm,
 };
 
-static inline int acpi_ec_query_init(void)
+static void acpi_ec_destroy_workqueues(void)
 {
-	if (!ec_query_wq) {
-		ec_query_wq = alloc_workqueue("kec_query", 0,
-					      ec_max_queries);
-		if (!ec_query_wq)
-			return -ENODEV;
+	if (ec_wq) {
+		destroy_workqueue(ec_wq);
+		ec_wq = NULL;
 	}
-	return 0;
-}
-
-static inline void acpi_ec_query_exit(void)
-{
 	if (ec_query_wq) {
 		destroy_workqueue(ec_query_wq);
 		ec_query_wq = NULL;
 	}
 }
 
+static int acpi_ec_init_workqueues(void)
+{
+	if (!ec_wq)
+		ec_wq = alloc_ordered_workqueue("kec", 0);
+
+	if (!ec_query_wq)
+		ec_query_wq = alloc_workqueue("kec_query", 0, ec_max_queries);
+
+	if (!ec_wq || !ec_query_wq) {
+		acpi_ec_destroy_workqueues();
+		return -ENODEV;
+	}
+	return 0;
+}
+
 static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 	{
 		.ident = "Thinkpad X1 Carbon 6th",
@@ -2157,7 +2166,7 @@ int __init acpi_ec_init(void)
 	int ecdt_fail, dsdt_fail;
 
 	/* register workqueue for _Qxx evaluations */
-	result = acpi_ec_query_init();
+	result = acpi_ec_init_workqueues();
 	if (result)
 		return result;
 
@@ -2188,6 +2197,6 @@ static void __exit acpi_ec_exit(void)
 {
 
 	acpi_bus_unregister_driver(&acpi_ec_driver);
-	acpi_ec_query_exit();
+	acpi_ec_destroy_workqueues();
 }
 #endif	/* 0 */



