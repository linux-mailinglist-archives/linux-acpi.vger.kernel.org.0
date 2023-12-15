Return-Path: <linux-acpi+bounces-2457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4420B814704
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 12:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB5A1F23464
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056724B51;
	Fri, 15 Dec 2023 11:34:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E7250E5;
	Fri, 15 Dec 2023 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id a3d939aa62efad4a; Fri, 15 Dec 2023 12:27:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D8D0F668B1E;
	Fri, 15 Dec 2023 12:27:47 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, Daniel Drake <drake@endlessm.com>
Subject: [PATCH v1 3/3] ACPI: EC: Use a spin lock without disabing interrupts
Date: Fri, 15 Dec 2023 12:27:30 +0100
Message-ID: <3287818.aeNJFYEL58@kreacher>
In-Reply-To: <2330034.ElGaqSPkdT@kreacher>
References: <2330034.ElGaqSPkdT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since all of the ACPI EC driver code runs in thread context after recent
changes, it does not need to disable interrupts on the local CPU when
acquiring a spin lock.

Make it use the spin lock without disabling interrupts.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |  112 ++++++++++++++++++++++--------------------------------
 1 file changed, 46 insertions(+), 66 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -525,12 +525,10 @@ static void acpi_ec_clear(struct acpi_ec
 
 static void acpi_ec_enable_event(struct acpi_ec *ec)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	if (acpi_ec_started(ec))
 		__acpi_ec_enable_event(ec);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 
 	/* Drain additional events if hardware requires that */
 	if (EC_FLAGS_CLEAR_ON_RESUME)
@@ -546,11 +544,9 @@ static void __acpi_ec_flush_work(void)
 
 static void acpi_ec_disable_event(struct acpi_ec *ec)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	__acpi_ec_disable_event(ec);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 
 	/*
 	 * When ec_freeze_events is true, we need to flush events in
@@ -571,10 +567,9 @@ void acpi_ec_flush_work(void)
 
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
-	unsigned long flags;
 	bool guarded;
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	/*
 	 * If firmware SCI_EVT clearing timing is "event", we actually
 	 * don't know when the SCI_EVT will be cleared by firmware after
@@ -590,31 +585,29 @@ static bool acpi_ec_guard_event(struct a
 	guarded = ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
 		ec->event_state != EC_EVENT_READY &&
 		(!ec->curr || ec->curr->command != ACPI_EC_COMMAND_QUERY);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 	return guarded;
 }
 
 static int ec_transaction_polled(struct acpi_ec *ec)
 {
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_POLL))
 		ret = 1;
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 	return ret;
 }
 
 static int ec_transaction_completed(struct acpi_ec *ec)
 {
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE))
 		ret = 1;
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 	return ret;
 }
 
@@ -756,7 +749,6 @@ static int ec_guard(struct acpi_ec *ec)
 
 static int ec_poll(struct acpi_ec *ec)
 {
-	unsigned long flags;
 	int repeat = 5; /* number of command restarts */
 
 	while (repeat--) {
@@ -765,14 +757,14 @@ static int ec_poll(struct acpi_ec *ec)
 		do {
 			if (!ec_guard(ec))
 				return 0;
-			spin_lock_irqsave(&ec->lock, flags);
+			spin_lock(&ec->lock);
 			advance_transaction(ec, false);
-			spin_unlock_irqrestore(&ec->lock, flags);
+			spin_unlock(&ec->lock);
 		} while (time_before(jiffies, delay));
 		pr_debug("controller reset, restart transaction\n");
-		spin_lock_irqsave(&ec->lock, flags);
+		spin_lock(&ec->lock);
 		start_transaction(ec);
-		spin_unlock_irqrestore(&ec->lock, flags);
+		spin_unlock(&ec->lock);
 	}
 	return -ETIME;
 }
@@ -780,11 +772,10 @@ static int ec_poll(struct acpi_ec *ec)
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 					struct transaction *t)
 {
-	unsigned long tmp;
 	int ret = 0;
 
 	/* start transaction */
-	spin_lock_irqsave(&ec->lock, tmp);
+	spin_lock(&ec->lock);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
 	if (!acpi_ec_submit_flushable_request(ec)) {
 		ret = -EINVAL;
@@ -795,11 +786,11 @@ static int acpi_ec_transaction_unlocked(
 	ec->curr = t;
 	ec_dbg_req("Command(%s) started", acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
-	spin_unlock_irqrestore(&ec->lock, tmp);
+	spin_unlock(&ec->lock);
 
 	ret = ec_poll(ec);
 
-	spin_lock_irqsave(&ec->lock, tmp);
+	spin_lock(&ec->lock);
 	if (t->irq_count == ec_storm_threshold)
 		acpi_ec_unmask_events(ec);
 	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
@@ -808,7 +799,7 @@ static int acpi_ec_transaction_unlocked(
 	acpi_ec_complete_request(ec);
 	ec_dbg_ref(ec, "Decrease command");
 unlock:
-	spin_unlock_irqrestore(&ec->lock, tmp);
+	spin_unlock(&ec->lock);
 	return ret;
 }
 
@@ -936,9 +927,7 @@ EXPORT_SYMBOL(ec_get_handle);
 
 static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
 		ec_dbg_drv("Starting EC");
 		/* Enable GPE for event processing (SCI_EVT=1) */
@@ -948,31 +937,28 @@ static void acpi_ec_start(struct acpi_ec
 		}
 		ec_log_drv("EC started");
 	}
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 }
 
 static bool acpi_ec_stopped(struct acpi_ec *ec)
 {
-	unsigned long flags;
 	bool flushed;
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	flushed = acpi_ec_flushed(ec);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 	return flushed;
 }
 
 static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	if (acpi_ec_started(ec)) {
 		ec_dbg_drv("Stopping EC");
 		set_bit(EC_FLAGS_STOPPED, &ec->flags);
-		spin_unlock_irqrestore(&ec->lock, flags);
+		spin_unlock(&ec->lock);
 		wait_event(ec->wait, acpi_ec_stopped(ec));
-		spin_lock_irqsave(&ec->lock, flags);
+		spin_lock(&ec->lock);
 		/* Disable GPE for event processing (SCI_EVT=1) */
 		if (!suspending) {
 			acpi_ec_complete_request(ec);
@@ -983,29 +969,25 @@ static void acpi_ec_stop(struct acpi_ec
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		ec_log_drv("EC stopped");
 	}
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 }
 
 static void acpi_ec_enter_noirq(struct acpi_ec *ec)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
 	ec_log_drv("interrupt blocked");
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 }
 
 static void acpi_ec_leave_noirq(struct acpi_ec *ec)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 	ec->busy_polling = ec_busy_polling;
 	ec->polling_guard = ec_polling_guard;
 	ec_log_drv("interrupt unblocked");
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 }
 
 void acpi_ec_block_transactions(void)
@@ -1137,9 +1119,9 @@ static void acpi_ec_event_processor(stru
 
 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
 
-	spin_lock_irq(&ec->lock);
+	spin_lock(&ec->lock);
 	ec->queries_in_progress--;
-	spin_unlock_irq(&ec->lock);
+	spin_unlock(&ec->lock);
 
 	acpi_ec_put_query_handler(handler);
 	kfree(q);
@@ -1202,12 +1184,12 @@ static int acpi_ec_submit_query(struct a
 	 */
 	ec_dbg_evt("Query(0x%02x) scheduled", value);
 
-	spin_lock_irq(&ec->lock);
+	spin_lock(&ec->lock);
 
 	ec->queries_in_progress++;
 	queue_work(ec_query_wq, &q->work);
 
-	spin_unlock_irq(&ec->lock);
+	spin_unlock(&ec->lock);
 
 	return 0;
 
@@ -1223,14 +1205,14 @@ static void acpi_ec_event_handler(struct
 
 	ec_dbg_evt("Event started");
 
-	spin_lock_irq(&ec->lock);
+	spin_lock(&ec->lock);
 
 	while (ec->events_to_process) {
-		spin_unlock_irq(&ec->lock);
+		spin_unlock(&ec->lock);
 
 		acpi_ec_submit_query(ec);
 
-		spin_lock_irq(&ec->lock);
+		spin_lock(&ec->lock);
 
 		ec->events_to_process--;
 	}
@@ -1247,11 +1229,11 @@ static void acpi_ec_event_handler(struct
 
 		ec_dbg_evt("Event stopped");
 
-		spin_unlock_irq(&ec->lock);
+		spin_unlock(&ec->lock);
 
 		guard_timeout = !!ec_guard(ec);
 
-		spin_lock_irq(&ec->lock);
+		spin_lock(&ec->lock);
 
 		/* Take care of SCI_EVT unless someone else is doing that. */
 		if (guard_timeout && !ec->curr)
@@ -1264,7 +1246,7 @@ static void acpi_ec_event_handler(struct
 
 	ec->events_in_progress--;
 
-	spin_unlock_irq(&ec->lock);
+	spin_unlock(&ec->lock);
 }
 
 static void clear_gpe_and_advance_transaction(struct acpi_ec *ec, bool interrupt)
@@ -1289,13 +1271,11 @@ static void clear_gpe_and_advance_transa
 
 static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock(&ec->lock);
 
 	clear_gpe_and_advance_transaction(ec, true);
 
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock(&ec->lock);
 }
 
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
@@ -2105,7 +2085,7 @@ bool acpi_ec_dispatch_gpe(void)
 	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
 	 * to allow the caller to process events properly after that.
 	 */
-	spin_lock_irq(&first_ec->lock);
+	spin_lock(&first_ec->lock);
 
 	if (acpi_ec_gpe_status_set(first_ec)) {
 		pm_pr_dbg("ACPI EC GPE status set\n");
@@ -2114,7 +2094,7 @@ bool acpi_ec_dispatch_gpe(void)
 		work_in_progress = acpi_ec_work_in_progress(first_ec);
 	}
 
-	spin_unlock_irq(&first_ec->lock);
+	spin_unlock(&first_ec->lock);
 
 	if (!work_in_progress)
 		return false;
@@ -2127,11 +2107,11 @@ bool acpi_ec_dispatch_gpe(void)
 
 		pm_pr_dbg("ACPI EC work flushed\n");
 
-		spin_lock_irq(&first_ec->lock);
+		spin_lock(&first_ec->lock);
 
 		work_in_progress = acpi_ec_work_in_progress(first_ec);
 
-		spin_unlock_irq(&first_ec->lock);
+		spin_unlock(&first_ec->lock);
 	} while (work_in_progress && !pm_wakeup_pending());
 
 	return false;




