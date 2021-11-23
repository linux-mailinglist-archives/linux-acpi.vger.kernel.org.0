Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E155C45AB86
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhKWSw0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42160 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhKWSwY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:24 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 4b155b4bf842dcfc; Tue, 23 Nov 2021 19:49:15 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6127866AC5A;
        Tue, 23 Nov 2021 19:49:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 09/10] ACPI: EC: Make the event work state machine visible
Date:   Tue, 23 Nov 2021 19:44:46 +0100
Message-ID: <7331762.EvYhyI6sBW@kreacher>
In-Reply-To: <11887969.O9o76ZdvQC@kreacher>
References: <11887969.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.133
X-CLIENT-HOSTNAME: 213.134.175.133
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddufeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The EC driver uses a relatively simple state machine for the event
work handling, but it is not really straightforward to figure out.

The states are as follows:

 "Ready": The event handling work can be submitted.

  In this state, the EC_FLAGS_QUERY_PENDING flag is clear.
 
 "In progress": The event handling work is pending or is being
                processed.  It cannot be submitted again.

  In ths state, the EC_FLAGS_QUERY_PENDING flag is set and both the
  events_to_process count is nonzero and the EC_FLAGS_QUERY_GUARDING
  flag is clear.

 "Complete": The event handling work has been completed, but it still
             cannot be submitted again.

  In ths state, the EC_FLAGS_QUERY_PENDING flag is set and the
  events_to_process count is zero or the EC_FLAGS_QUERY_GUARDING
  flag is set.

The state changes from "Ready" to "In progress" when new event is
detected by advance_transaction() and acpi_ec_submit_event() is
called by it.

Next, the state can change from "In progress" directly to "Ready" in
the following situations:

 * ec_event_clearing is ACPI_EC_EVT_TIMING_STATUS and the state of
   an ACPI_EC_COMMAND_QUERY transaction becomes ACPI_EC_COMMAND_POLL.

 * ec_event_clearing is ACPI_EC_EVT_TIMING_QUERY and the state of
   an ACPI_EC_COMMAND_QUERY transaction becomes
   ACPI_EC_COMMAND_COMPLETE.

 * ec_event_clearing is either ACPI_EC_EVT_TIMING_STATUS or
   ACPI_EC_EVT_TIMING_QUERY and there are no more events to
   process (ie. ec->events_to_process becomes 0).

If ec_event_clearing is ACPI_EC_EVT_TIMING_EVENT, however, the
state must change from "In progress" to "Complete" before it
can change to "Ready".  The changes from "In progress" to
"Complete" in that case occur in the following situations:

 * The state of an ACPI_EC_COMMAND_QUERY transaction becomes
   ACPI_EC_COMMAND_COMPLETE.

 * There are no more events to process (ie. ec->events_to_process
   becomes 0).

Finally, the state changes from "Complete" to "Ready" when
advance_transaction() is invoked when the state is "Complete" and
the state of the current transaction is not ACPI_EC_COMMAND_POLL.

To make this state machine visible in the code, add a new
event_state field to struct acpi_ec and modify the code to use
it istead the EC_FLAGS_QUERY_PENDING and EC_FLAGS_QUERY_GUARDING
flags.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   75 ++++++++++++++++++++++++++++--------------------
 drivers/acpi/internal.h |    8 +++++
 2 files changed, 52 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -92,8 +92,6 @@ enum ec_command {
 
 enum {
 	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
-	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
-	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
 	EC_FLAGS_EVENT_HANDLER_INSTALLED,	/* Event handler installed */
 	EC_FLAGS_EC_HANDLER_INSTALLED,	/* OpReg handler installed */
 	EC_FLAGS_QUERY_METHODS_INSTALLED, /* _Qxx handlers installed */
@@ -450,9 +448,11 @@ static bool acpi_ec_submit_event(struct
 	if (!acpi_ec_event_enabled(ec))
 		return false;
 
-	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+	if (ec->event_state == EC_EVENT_READY) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
+
+		ec->event_state = EC_EVENT_IN_PROGRESS;
 		/*
 		 * If events_to_process is greqter than 0 at this point, the
 		 * while () loop in acpi_ec_event_handler() is still running
@@ -474,11 +474,19 @@ static bool acpi_ec_submit_event(struct
 	return true;
 }
 
+static void acpi_ec_complete_event(struct acpi_ec *ec)
+{
+	if (ec->event_state == EC_EVENT_IN_PROGRESS)
+		ec->event_state = EC_EVENT_COMPLETE;
+}
+
 static void acpi_ec_close_event(struct acpi_ec *ec)
 {
-	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+	if (ec->event_state != EC_EVENT_READY)
 		ec_dbg_evt("Command(%s) unblocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
+
+	ec->event_state = EC_EVENT_READY;
 	acpi_ec_unmask_events(ec);
 }
 
@@ -565,8 +573,8 @@ void acpi_ec_flush_work(void)
 
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
-	bool guarded = true;
 	unsigned long flags;
+	bool guarded;
 
 	spin_lock_irqsave(&ec->lock, flags);
 	/*
@@ -575,19 +583,15 @@ static bool acpi_ec_guard_event(struct a
 	 * evaluating _Qxx, so we need to re-check SCI_EVT after waiting an
 	 * acceptable period.
 	 *
-	 * The guarding period begins when EC_FLAGS_QUERY_PENDING is
-	 * flagged, which means SCI_EVT check has just been performed.
-	 * But if the current transaction is ACPI_EC_COMMAND_QUERY, the
-	 * guarding should have already been performed (via
-	 * EC_FLAGS_QUERY_GUARDING) and should not be applied so that the
-	 * ACPI_EC_COMMAND_QUERY transaction can be transitioned into
-	 * ACPI_EC_COMMAND_POLL state immediately.
+	 * The guarding period is applicable if the event state is not
+	 * EC_EVENT_READY, but otherwise if the current transaction is of the
+	 * ACPI_EC_COMMAND_QUERY type, the guarding should have elapsed already
+	 * and it should not be applied to let the transaction transition into
+	 * the ACPI_EC_COMMAND_POLL state immediately.
 	 */
-	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
-	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY ||
-	    !test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags) ||
-	    (ec->curr && ec->curr->command == ACPI_EC_COMMAND_QUERY))
-		guarded = false;
+	guarded = ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
+		ec->event_state != EC_EVENT_READY &&
+		(!ec->curr || ec->curr->command != ACPI_EC_COMMAND_QUERY);
 	spin_unlock_irqrestore(&ec->lock, flags);
 	return guarded;
 }
@@ -619,16 +623,26 @@ static int ec_transaction_completed(stru
 static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long flag)
 {
 	ec->curr->flags |= flag;
-	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
-		if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS &&
-		    flag == ACPI_EC_COMMAND_POLL)
+
+	if (ec->curr->command != ACPI_EC_COMMAND_QUERY)
+		return;
+
+	switch (ec_event_clearing) {
+	case ACPI_EC_EVT_TIMING_STATUS:
+		if (flag == ACPI_EC_COMMAND_POLL)
 			acpi_ec_close_event(ec);
-		if (ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY &&
-		    flag == ACPI_EC_COMMAND_COMPLETE)
+
+		return;
+
+	case ACPI_EC_EVT_TIMING_QUERY:
+		if (flag == ACPI_EC_COMMAND_COMPLETE)
 			acpi_ec_close_event(ec);
-		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
-		    flag == ACPI_EC_COMMAND_COMPLETE)
-			set_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
+
+		return;
+
+	case ACPI_EC_EVT_TIMING_EVENT:
+		if (flag == ACPI_EC_COMMAND_COMPLETE)
+			acpi_ec_complete_event(ec);
 	}
 }
 
@@ -674,11 +688,9 @@ static bool advance_transaction(struct a
 	 */
 	if (!t || !(t->flags & ACPI_EC_COMMAND_POLL)) {
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
-		    (!ec->events_to_process ||
-		     test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags))) {
-			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
+		    ec->event_state == EC_EVENT_COMPLETE)
 			acpi_ec_close_event(ec);
-		}
+
 		if (!t)
 			goto out;
 	}
@@ -1246,8 +1258,9 @@ static void acpi_ec_event_handler(struct
 	 * event handling work again regardless of whether or not the query
 	 * queued up above is processed successfully.
 	 */
-	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
-	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT)
+		acpi_ec_complete_event(ec);
+	else
 		acpi_ec_close_event(ec);
 
 	spin_unlock_irq(&ec->lock);
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -167,6 +167,13 @@ static inline void acpi_early_processor_
 /* --------------------------------------------------------------------------
                                   Embedded Controller
    -------------------------------------------------------------------------- */
+
+enum acpi_ec_event_state {
+	EC_EVENT_READY = 0,	/* Event work can be submitted */
+	EC_EVENT_IN_PROGRESS,	/* Event work is pending or being processed */
+	EC_EVENT_COMPLETE,	/* Event work processing has completed */
+};
+
 struct acpi_ec {
 	acpi_handle handle;
 	int gpe;
@@ -183,6 +190,7 @@ struct acpi_ec {
 	spinlock_t lock;
 	struct work_struct work;
 	unsigned long timestamp;
+	enum acpi_ec_event_state event_state;
 	unsigned int events_to_process;
 	unsigned int events_in_progress;
 	unsigned int queries_in_progress;



