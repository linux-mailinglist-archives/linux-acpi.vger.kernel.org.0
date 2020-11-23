Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6C2C14B3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 20:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgKWTrr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62814 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgKWTrr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 14:47:47 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 61c4e727b3eb1d26; Mon, 23 Nov 2020 20:41:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ACPI: EC: Untangle error handling in advance_transaction()
Date:   Mon, 23 Nov 2020 20:39:27 +0100
Message-ID: <3740828.yVBKsGfhbx@kreacher>
In-Reply-To: <3259005.CeRvrUlyd7@kreacher>
References: <3259005.CeRvrUlyd7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Introduce acpi_ec_spurious_interrupt() for recording spurious
interrupts and use it for error handling in advance_transaction(),
drop the (now redundant) original error handling block from there
along with a frew goto statements that are not necessary any more.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 23e7b2dec98e..091f0e9f37a0 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -615,6 +615,16 @@ static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long f
 	}
 }
 
+static void acpi_ec_spurious_interrupt(struct acpi_ec *ec, struct transaction *t)
+{
+	if (t->irq_count < ec_storm_threshold)
+		++t->irq_count;
+
+	/* Trigger if the threshold is 0 too. */
+	if (t->irq_count == ec_storm_threshold)
+		acpi_ec_mask_events(ec);
+}
+
 static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
 	struct transaction *t = ec->curr;
@@ -659,8 +669,8 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 		if (t->wlen > t->wi) {
 			if ((status & ACPI_EC_FLAG_IBF) == 0)
 				acpi_ec_write_data(ec, t->wdata[t->wi++]);
-			else
-				goto err;
+			else if (interrupt && !(status & ACPI_EC_FLAG_SCI))
+				acpi_ec_spurious_interrupt(ec, t);
 		} else if (t->rlen > t->ri) {
 			if ((status & ACPI_EC_FLAG_OBF) == 1) {
 				t->rdata[t->ri++] = acpi_ec_read_data(ec);
@@ -671,32 +681,19 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 							   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 					wakeup = true;
 				}
-			} else
-				goto err;
+			} else if (interrupt && !(status & ACPI_EC_FLAG_SCI)) {
+				acpi_ec_spurious_interrupt(ec, t);
+			}
 		} else if (t->wlen == t->wi &&
 			   (status & ACPI_EC_FLAG_IBF) == 0) {
 			ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
 			wakeup = true;
 		}
-		goto out;
 	} else if (!(status & ACPI_EC_FLAG_IBF)) {
 		acpi_ec_write_cmd(ec, t->command);
 		ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
-		goto out;
 	}
-err:
-	/*
-	 * If SCI bit is set, then don't think it's a false IRQ
-	 * otherwise will take a not handled IRQ as a false one.
-	 */
-	if (!(status & ACPI_EC_FLAG_SCI) && interrupt) {
-		if (t->irq_count < ec_storm_threshold)
-			++t->irq_count;
 
-		/* Allow triggering on 0 threshold */
-		if (t->irq_count == ec_storm_threshold)
-			acpi_ec_mask_events(ec);
-	}
 out:
 	if (status & ACPI_EC_FLAG_SCI)
 		acpi_ec_submit_query(ec);
-- 
2.26.2




