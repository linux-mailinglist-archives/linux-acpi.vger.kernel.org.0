Return-Path: <linux-acpi+bounces-3838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EB85F4DB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0753D282FEF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C12381A1;
	Thu, 22 Feb 2024 09:44:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF573613A;
	Thu, 22 Feb 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595042; cv=none; b=tHcjOHKH6OgKC+Y2OzO1BBeeVqETuw4uhpmEpmKD+Wzx8pQst8+iy40J4aa0YNmzBHAIQZ2M3DsNsswZQEol3R2daX9p1+xLfo/GtjTmpqGBLxncWcm3ivaV5UrKbesLCCYzoVdhGsGO41jhMfPgGSjoOgOfWUe9MGG8xF6iveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595042; c=relaxed/simple;
	bh=obZPR+6UbVULJXHm78nA0C0z595i34qplBI+aY2HQHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SsGzWAv/eMywOpAHRhW4MMgufl/n5EW7d+TQpwMDD64tSNOZWJXHaRF1QrXWQ8DMjs8HSroTNlY31yYyovcoSFWZYG7vFiJ2DPF0OrIAmT/DYEeBHWF8tX2p/P93lDWdcR0s1gadL1qIfOMxlsMsL/t3HjXuEBrWoDbypL8dCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 0d23f7cd2b165d67; Thu, 22 Feb 2024 10:43:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5AFAB66A293;
	Thu, 22 Feb 2024 10:43:56 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dieter Mummenschanz <dmummenschanz@web.de>
Subject:
 [PATCH] Revert "ACPI: EC: Use a spin lock without disabing  interrupts"
Date: Thu, 22 Feb 2024 10:43:56 +0100
Message-ID: <2739288.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhumhhmvghnshgthhgrnhiiseifvggsrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit eb9299beadbd ("ACPI: EC: Use a spin lock without disabing
interrupts") introduced an unexpected user-visible change in
behavior, which is a significant CPU load increase when the EC
is in use.

This most likely happens due to increased spinlock contention
and so reducing this effect would require a major rework of the
EC driver locking.  There is no time for this in the current
cycle, so revert commit eb9299beadbd.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218511
Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 112 +++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index dbdee2924594..02255795b800 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -525,10 +525,12 @@ static void acpi_ec_clear(struct acpi_ec *ec)
 
 static void acpi_ec_enable_event(struct acpi_ec *ec)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	if (acpi_ec_started(ec))
 		__acpi_ec_enable_event(ec);
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 
 	/* Drain additional events if hardware requires that */
 	if (EC_FLAGS_CLEAR_ON_RESUME)
@@ -544,9 +546,11 @@ static void __acpi_ec_flush_work(void)
 
 static void acpi_ec_disable_event(struct acpi_ec *ec)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	__acpi_ec_disable_event(ec);
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 
 	/*
 	 * When ec_freeze_events is true, we need to flush events in
@@ -567,9 +571,10 @@ void acpi_ec_flush_work(void)
 
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
+	unsigned long flags;
 	bool guarded;
 
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, flags);
 	/*
 	 * If firmware SCI_EVT clearing timing is "event", we actually
 	 * don't know when the SCI_EVT will be cleared by firmware after
@@ -585,29 +590,31 @@ static bool acpi_ec_guard_event(struct acpi_ec *ec)
 	guarded = ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
 		ec->event_state != EC_EVENT_READY &&
 		(!ec->curr || ec->curr->command != ACPI_EC_COMMAND_QUERY);
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return guarded;
 }
 
 static int ec_transaction_polled(struct acpi_ec *ec)
 {
+	unsigned long flags;
 	int ret = 0;
 
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, flags);
 	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_POLL))
 		ret = 1;
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return ret;
 }
 
 static int ec_transaction_completed(struct acpi_ec *ec)
 {
+	unsigned long flags;
 	int ret = 0;
 
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, flags);
 	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE))
 		ret = 1;
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return ret;
 }
 
@@ -749,6 +756,7 @@ static int ec_guard(struct acpi_ec *ec)
 
 static int ec_poll(struct acpi_ec *ec)
 {
+	unsigned long flags;
 	int repeat = 5; /* number of command restarts */
 
 	while (repeat--) {
@@ -757,14 +765,14 @@ static int ec_poll(struct acpi_ec *ec)
 		do {
 			if (!ec_guard(ec))
 				return 0;
-			spin_lock(&ec->lock);
+			spin_lock_irqsave(&ec->lock, flags);
 			advance_transaction(ec, false);
-			spin_unlock(&ec->lock);
+			spin_unlock_irqrestore(&ec->lock, flags);
 		} while (time_before(jiffies, delay));
 		pr_debug("controller reset, restart transaction\n");
-		spin_lock(&ec->lock);
+		spin_lock_irqsave(&ec->lock, flags);
 		start_transaction(ec);
-		spin_unlock(&ec->lock);
+		spin_unlock_irqrestore(&ec->lock, flags);
 	}
 	return -ETIME;
 }
@@ -772,10 +780,11 @@ static int ec_poll(struct acpi_ec *ec)
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 					struct transaction *t)
 {
+	unsigned long tmp;
 	int ret = 0;
 
 	/* start transaction */
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
 	if (!acpi_ec_submit_flushable_request(ec)) {
 		ret = -EINVAL;
@@ -786,11 +795,11 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	ec->curr = t;
 	ec_dbg_req("Command(%s) started", acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, tmp);
 
 	ret = ec_poll(ec);
 
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, tmp);
 	if (t->irq_count == ec_storm_threshold)
 		acpi_ec_unmask_events(ec);
 	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
@@ -799,7 +808,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	acpi_ec_complete_request(ec);
 	ec_dbg_ref(ec, "Decrease command");
 unlock:
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
 }
 
@@ -927,7 +936,9 @@ EXPORT_SYMBOL(ec_get_handle);
 
 static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
 		ec_dbg_drv("Starting EC");
 		/* Enable GPE for event processing (SCI_EVT=1) */
@@ -937,28 +948,31 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		}
 		ec_log_drv("EC started");
 	}
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static bool acpi_ec_stopped(struct acpi_ec *ec)
 {
+	unsigned long flags;
 	bool flushed;
 
-	spin_lock(&ec->lock);
+	spin_lock_irqsave(&ec->lock, flags);
 	flushed = acpi_ec_flushed(ec);
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return flushed;
 }
 
 static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	if (acpi_ec_started(ec)) {
 		ec_dbg_drv("Stopping EC");
 		set_bit(EC_FLAGS_STOPPED, &ec->flags);
-		spin_unlock(&ec->lock);
+		spin_unlock_irqrestore(&ec->lock, flags);
 		wait_event(ec->wait, acpi_ec_stopped(ec));
-		spin_lock(&ec->lock);
+		spin_lock_irqsave(&ec->lock, flags);
 		/* Disable GPE for event processing (SCI_EVT=1) */
 		if (!suspending) {
 			acpi_ec_complete_request(ec);
@@ -969,25 +983,29 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		ec_log_drv("EC stopped");
 	}
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static void acpi_ec_enter_noirq(struct acpi_ec *ec)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
 	ec_log_drv("interrupt blocked");
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static void acpi_ec_leave_noirq(struct acpi_ec *ec)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 	ec->busy_polling = ec_busy_polling;
 	ec->polling_guard = ec_polling_guard;
 	ec_log_drv("interrupt unblocked");
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 void acpi_ec_block_transactions(void)
@@ -1119,9 +1137,9 @@ static void acpi_ec_event_processor(struct work_struct *work)
 
 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
 
-	spin_lock(&ec->lock);
+	spin_lock_irq(&ec->lock);
 	ec->queries_in_progress--;
-	spin_unlock(&ec->lock);
+	spin_unlock_irq(&ec->lock);
 
 	acpi_ec_put_query_handler(handler);
 	kfree(q);
@@ -1184,12 +1202,12 @@ static int acpi_ec_submit_query(struct acpi_ec *ec)
 	 */
 	ec_dbg_evt("Query(0x%02x) scheduled", value);
 
-	spin_lock(&ec->lock);
+	spin_lock_irq(&ec->lock);
 
 	ec->queries_in_progress++;
 	queue_work(ec_query_wq, &q->work);
 
-	spin_unlock(&ec->lock);
+	spin_unlock_irq(&ec->lock);
 
 	return 0;
 
@@ -1205,14 +1223,14 @@ static void acpi_ec_event_handler(struct work_struct *work)
 
 	ec_dbg_evt("Event started");
 
-	spin_lock(&ec->lock);
+	spin_lock_irq(&ec->lock);
 
 	while (ec->events_to_process) {
-		spin_unlock(&ec->lock);
+		spin_unlock_irq(&ec->lock);
 
 		acpi_ec_submit_query(ec);
 
-		spin_lock(&ec->lock);
+		spin_lock_irq(&ec->lock);
 
 		ec->events_to_process--;
 	}
@@ -1229,11 +1247,11 @@ static void acpi_ec_event_handler(struct work_struct *work)
 
 		ec_dbg_evt("Event stopped");
 
-		spin_unlock(&ec->lock);
+		spin_unlock_irq(&ec->lock);
 
 		guard_timeout = !!ec_guard(ec);
 
-		spin_lock(&ec->lock);
+		spin_lock_irq(&ec->lock);
 
 		/* Take care of SCI_EVT unless someone else is doing that. */
 		if (guard_timeout && !ec->curr)
@@ -1246,7 +1264,7 @@ static void acpi_ec_event_handler(struct work_struct *work)
 
 	ec->events_in_progress--;
 
-	spin_unlock(&ec->lock);
+	spin_unlock_irq(&ec->lock);
 }
 
 static void clear_gpe_and_advance_transaction(struct acpi_ec *ec, bool interrupt)
@@ -1271,11 +1289,13 @@ static void clear_gpe_and_advance_transaction(struct acpi_ec *ec, bool interrupt
 
 static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
 {
-	spin_lock(&ec->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
 
 	clear_gpe_and_advance_transaction(ec, true);
 
-	spin_unlock(&ec->lock);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
@@ -2085,7 +2105,7 @@ bool acpi_ec_dispatch_gpe(void)
 	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
 	 * to allow the caller to process events properly after that.
 	 */
-	spin_lock(&first_ec->lock);
+	spin_lock_irq(&first_ec->lock);
 
 	if (acpi_ec_gpe_status_set(first_ec)) {
 		pm_pr_dbg("ACPI EC GPE status set\n");
@@ -2094,7 +2114,7 @@ bool acpi_ec_dispatch_gpe(void)
 		work_in_progress = acpi_ec_work_in_progress(first_ec);
 	}
 
-	spin_unlock(&first_ec->lock);
+	spin_unlock_irq(&first_ec->lock);
 
 	if (!work_in_progress)
 		return false;
@@ -2107,11 +2127,11 @@ bool acpi_ec_dispatch_gpe(void)
 
 		pm_pr_dbg("ACPI EC work flushed\n");
 
-		spin_lock(&first_ec->lock);
+		spin_lock_irq(&first_ec->lock);
 
 		work_in_progress = acpi_ec_work_in_progress(first_ec);
 
-		spin_unlock(&first_ec->lock);
+		spin_unlock_irq(&first_ec->lock);
 	} while (work_in_progress && !pm_wakeup_pending());
 
 	return false;
-- 
2.35.3





