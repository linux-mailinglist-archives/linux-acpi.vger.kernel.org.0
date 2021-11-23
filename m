Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDA45ABA2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbhKWSwq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65050 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbhKWSwf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:35 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 1ad8e8b56eb6b00b; Tue, 23 Nov 2021 19:49:25 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1F2EE66AC5B;
        Tue, 23 Nov 2021 19:49:25 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 02/10] ACPI: EC: Call advance_transaction() from acpi_ec_dispatch_gpe()
Date:   Tue, 23 Nov 2021 19:37:39 +0100
Message-ID: <4376198.LvFx2qVVIh@kreacher>
In-Reply-To: <11887969.O9o76ZdvQC@kreacher>
References: <11887969.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.133
X-CLIENT-HOSTNAME: 213.134.175.133
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddufeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling acpi_dispatch_gpe() from acpi_ec_dispatch_gpe() is generally
problematic, because it may cause the spurious interrupt handling in
advance_transaction() to trigger in theory.

However, instead of calling acpi_dispatch_gpe() to dispatch the EC
GPE, acpi_ec_dispatch_gpe() can call advance_transaction() directly
on first_ec and it can pass 'false' as its second argument to indicate
calling it from process context.

Moreover, if advance_transaction() is modified to return a bool value
indicating whether or not the EC work needs to be flushed, it can be
used to avoid unnecessary EC work flushing in acpi_ec_dispatch_gpe(),
so change the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -170,7 +170,7 @@ struct acpi_ec_query {
 };
 
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
-static void advance_transaction(struct acpi_ec *ec, bool interrupt);
+static bool advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
 static void acpi_ec_event_processor(struct work_struct *work);
 
@@ -444,18 +444,25 @@ static bool acpi_ec_submit_flushable_req
 	return true;
 }
 
-static void acpi_ec_submit_query(struct acpi_ec *ec)
+static bool acpi_ec_submit_query(struct acpi_ec *ec)
 {
 	acpi_ec_mask_events(ec);
 	if (!acpi_ec_event_enabled(ec))
-		return;
+		return false;
+
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
 		ec->events_in_progress++;
-		queue_work(ec_wq, &ec->work);
+		return queue_work(ec_wq, &ec->work);
 	}
+
+	/*
+	 * The event handling work has not been completed yet, so it needs to be
+	 * flushed.
+	 */
+	return true;
 }
 
 static void acpi_ec_complete_query(struct acpi_ec *ec)
@@ -628,10 +635,11 @@ static void acpi_ec_spurious_interrupt(s
 		acpi_ec_mask_events(ec);
 }
 
-static void advance_transaction(struct acpi_ec *ec, bool interrupt)
+static bool advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
 	struct transaction *t = ec->curr;
 	bool wakeup = false;
+	bool ret = false;
 	u8 status;
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
@@ -698,10 +706,12 @@ static void advance_transaction(struct a
 
 out:
 	if (status & ACPI_EC_FLAG_SCI)
-		acpi_ec_submit_query(ec);
+		ret = acpi_ec_submit_query(ec);
 
 	if (wakeup && interrupt)
 		wake_up(&ec->wait);
+
+	return ret;
 }
 
 static void start_transaction(struct acpi_ec *ec)
@@ -2038,8 +2048,7 @@ void acpi_ec_set_gpe_wake_mask(u8 action
 
 bool acpi_ec_dispatch_gpe(void)
 {
-	bool work_in_progress;
-	u32 ret;
+	bool work_in_progress = false;
 
 	if (!first_ec)
 		return acpi_any_gpe_status_set(U32_MAX);
@@ -2055,9 +2064,17 @@ bool acpi_ec_dispatch_gpe(void)
 	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
 	 * to allow the caller to process events properly after that.
 	 */
-	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	if (ret == ACPI_INTERRUPT_HANDLED)
-		pm_pr_dbg("ACPI EC GPE dispatched\n");
+	spin_lock_irq(&first_ec->lock);
+
+	if (acpi_ec_gpe_status_set(first_ec))
+		work_in_progress = advance_transaction(first_ec, false);
+
+	spin_unlock_irq(&first_ec->lock);
+
+	if (!work_in_progress)
+		return false;
+
+	pm_pr_dbg("ACPI EC GPE dispatched\n");
 
 	/* Drain EC work. */
 	do {



