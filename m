Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE745AB9D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhKWSwm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45612 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbhKWSwh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:37 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id be99b942d0b3c572; Tue, 23 Nov 2021 19:49:27 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 99AB066AC5A;
        Tue, 23 Nov 2021 19:49:26 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 01/10] ACPI: EC: Rework flushing of EC work while suspended to idle
Date:   Tue, 23 Nov 2021 19:36:51 +0100
Message-ID: <5787156.lOV4Wx5bFT@kreacher>
In-Reply-To: <11887969.O9o76ZdvQC@kreacher>
References: <11887969.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.133
X-CLIENT-HOSTNAME: 213.134.175.133
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudeffedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The flushing of pending work in the EC driver uses drain_workqueue()
to flush the event handling work that can requeue itself via
advance_transaction(), but this is problematic, because that
work may also be requeued from the query workqueue.

Namely, if an EC transaction is carried out during the execution of
a query handler, it involves calling advance_transaction() which
may queue up the event handling work again.  This causes the kernel
to complain about attempts to add a work item to the EC event
workqueue while it is being drained and worst-case it may cause a
valid event to be skipped.

To avoid this problem, introduce two new counters, events_in_progress
and queries_in_progress, incremented when a work item is queued on
the event workqueue or the query workqueue, respectively, and
decremented at the end of the corresponding work function, and make
acpi_ec_dispatch_gpe() the workqueues in a loop until the both of
these counters are zero (or system wakeup is pending) instead of
calling acpi_ec_flush_work().

At the same time, change __acpi_ec_flush_work() to call
flush_workqueue() instead of drain_workqueue() to flush the event
workqueue.

While at it, use the observation that the work item queued in
acpi_ec_query() cannot be pending at that time, because it is used
only once, to simplify the code in there.

Additionally, clean up a comment in acpi_ec_query() and adjust white
space in acpi_ec_event_processor().

Fixes: f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   57 ++++++++++++++++++++++++++++++++++++------------
 drivers/acpi/internal.h |    2 +
 2 files changed, 45 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -166,6 +166,7 @@ struct acpi_ec_query {
 	struct transaction transaction;
 	struct work_struct work;
 	struct acpi_ec_query_handler *handler;
+	struct acpi_ec *ec;
 };
 
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
@@ -452,6 +453,7 @@ static void acpi_ec_submit_query(struct
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
+		ec->events_in_progress++;
 		queue_work(ec_wq, &ec->work);
 	}
 }
@@ -518,7 +520,7 @@ static void acpi_ec_enable_event(struct
 #ifdef CONFIG_PM_SLEEP
 static void __acpi_ec_flush_work(void)
 {
-	drain_workqueue(ec_wq); /* flush ec->work */
+	flush_workqueue(ec_wq); /* flush ec->work */
 	flush_workqueue(ec_query_wq); /* flush queries */
 }
 
@@ -1103,7 +1105,7 @@ void acpi_ec_remove_query_handler(struct
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static struct acpi_ec_query *acpi_ec_create_query(u8 *pval)
+static struct acpi_ec_query *acpi_ec_create_query(struct acpi_ec *ec, u8 *pval)
 {
 	struct acpi_ec_query *q;
 	struct transaction *t;
@@ -1111,11 +1113,13 @@ static struct acpi_ec_query *acpi_ec_cre
 	q = kzalloc(sizeof (struct acpi_ec_query), GFP_KERNEL);
 	if (!q)
 		return NULL;
+
 	INIT_WORK(&q->work, acpi_ec_event_processor);
 	t = &q->transaction;
 	t->command = ACPI_EC_COMMAND_QUERY;
 	t->rdata = pval;
 	t->rlen = 1;
+	q->ec = ec;
 	return q;
 }
 
@@ -1132,13 +1136,21 @@ static void acpi_ec_event_processor(stru
 {
 	struct acpi_ec_query *q = container_of(work, struct acpi_ec_query, work);
 	struct acpi_ec_query_handler *handler = q->handler;
+	struct acpi_ec *ec = q->ec;
 
 	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
+
 	if (handler->func)
 		handler->func(handler->data);
 	else if (handler->handle)
 		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+
 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
+
+	spin_lock_irq(&ec->lock);
+	ec->queries_in_progress--;
+	spin_unlock_irq(&ec->lock);
+
 	acpi_ec_delete_query(q);
 }
 
@@ -1148,7 +1160,7 @@ static int acpi_ec_query(struct acpi_ec
 	int result;
 	struct acpi_ec_query *q;
 
-	q = acpi_ec_create_query(&value);
+	q = acpi_ec_create_query(ec, &value);
 	if (!q)
 		return -ENOMEM;
 
@@ -1170,19 +1182,20 @@ static int acpi_ec_query(struct acpi_ec
 	}
 
 	/*
-	 * It is reported that _Qxx are evaluated in a parallel way on
-	 * Windows:
+	 * It is reported that _Qxx are evaluated in a parallel way on Windows:
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=94411
 	 *
-	 * Put this log entry before schedule_work() in order to make
-	 * it appearing before any other log entries occurred during the
-	 * work queue execution.
+	 * Put this log entry before queue_work() to make it appear in the log
+	 * before any other messages emitted during workqueue handling.
 	 */
 	ec_dbg_evt("Query(0x%02x) scheduled", value);
-	if (!queue_work(ec_query_wq, &q->work)) {
-		ec_dbg_evt("Query(0x%02x) overlapped", value);
-		result = -EBUSY;
-	}
+
+	spin_lock_irq(&ec->lock);
+
+	ec->queries_in_progress++;
+	queue_work(ec_query_wq, &q->work);
+
+	spin_unlock_irq(&ec->lock);
 
 err_exit:
 	if (result)
@@ -1240,6 +1253,10 @@ static void acpi_ec_event_handler(struct
 	ec_dbg_evt("Event stopped");
 
 	acpi_ec_check_event(ec);
+
+	spin_lock_irqsave(&ec->lock, flags);
+	ec->events_in_progress--;
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
@@ -2021,6 +2038,7 @@ void acpi_ec_set_gpe_wake_mask(u8 action
 
 bool acpi_ec_dispatch_gpe(void)
 {
+	bool work_in_progress;
 	u32 ret;
 
 	if (!first_ec)
@@ -2041,8 +2059,19 @@ bool acpi_ec_dispatch_gpe(void)
 	if (ret == ACPI_INTERRUPT_HANDLED)
 		pm_pr_dbg("ACPI EC GPE dispatched\n");
 
-	/* Flush the event and query workqueues. */
-	acpi_ec_flush_work();
+	/* Drain EC work. */
+	do {
+		acpi_ec_flush_work();
+
+		pm_pr_dbg("ACPI EC work flushed\n");
+
+		spin_lock_irq(&first_ec->lock);
+
+		work_in_progress = first_ec->events_in_progress +
+			first_ec->queries_in_progress > 0;
+
+		spin_unlock_irq(&first_ec->lock);
+	} while (work_in_progress && !pm_wakeup_pending());
 
 	return false;
 }
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -184,6 +184,8 @@ struct acpi_ec {
 	struct work_struct work;
 	unsigned long timestamp;
 	unsigned long nr_pending_queries;
+	unsigned int events_in_progress;
+	unsigned int queries_in_progress;
 	bool busy_polling;
 	unsigned int polling_guard;
 };



