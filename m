Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4942C14B4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgKWTrr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55956 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgKWTrr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 14:47:47 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id fd3d7e39cee1b48e; Mon, 23 Nov 2020 20:41:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ACPI: EC: Simplify error handling in advance_transaction()
Date:   Mon, 23 Nov 2020 20:38:37 +0100
Message-ID: <3207399.h1hCrb0iRi@kreacher>
In-Reply-To: <3259005.CeRvrUlyd7@kreacher>
References: <3259005.CeRvrUlyd7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Notice that the value of t in advance_transaction() does not change
after its initialization and:

 - Initialize t upfront (and rearrange the definitions of local
   variables while at it).

 - Check it against NULL in a block executed when it is NULL.

 - Skip error handling for t == NULL, because a valid pointer value
   of t is required for the error handling.

 - Drop the (now redundant) check of t against NULL from the error
   handling block and reduce the indentation level in there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c4be16a495e1..23e7b2dec98e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -617,9 +617,9 @@ static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long f
 
 static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
-	struct transaction *t;
-	u8 status;
+	struct transaction *t = ec->curr;
 	bool wakeup = false;
+	u8 status;
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
 
@@ -639,7 +639,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 		acpi_clear_gpe(NULL, ec->gpe);
 
 	status = acpi_ec_read_status(ec);
-	t = ec->curr;
+
 	/*
 	 * Another IRQ or a guarded polling mode advancement is detected,
 	 * the next QR_EC submission is then allowed.
@@ -651,9 +651,10 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
 			acpi_ec_complete_query(ec);
 		}
+		if (!t)
+			goto out;
 	}
-	if (!t)
-		goto err;
+
 	if (t->flags & ACPI_EC_COMMAND_POLL) {
 		if (t->wlen > t->wi) {
 			if ((status & ACPI_EC_FLAG_IBF) == 0)
@@ -688,14 +689,13 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 	 * If SCI bit is set, then don't think it's a false IRQ
 	 * otherwise will take a not handled IRQ as a false one.
 	 */
-	if (!(status & ACPI_EC_FLAG_SCI)) {
-		if (interrupt && t) {
-			if (t->irq_count < ec_storm_threshold)
-				++t->irq_count;
-			/* Allow triggering on 0 threshold */
-			if (t->irq_count == ec_storm_threshold)
-				acpi_ec_mask_events(ec);
-		}
+	if (!(status & ACPI_EC_FLAG_SCI) && interrupt) {
+		if (t->irq_count < ec_storm_threshold)
+			++t->irq_count;
+
+		/* Allow triggering on 0 threshold */
+		if (t->irq_count == ec_storm_threshold)
+			acpi_ec_mask_events(ec);
 	}
 out:
 	if (status & ACPI_EC_FLAG_SCI)
-- 
2.26.2




