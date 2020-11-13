Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82AB2B236F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 19:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKMSNa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 13:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMSN3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 13:13:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B510C0613D1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 10:13:29 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605291207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7aFlYdIzEfv2JOKu+3iUrIPJ1A00nqjzBiRhswpxCy8=;
        b=vHAJ8fVnMHTxFGQpO7msv6keDGYp1hJrZSCddAcKsOMDP9Ml0b1OstWC7YyD8vLlkcI+DZ
        jukIStanC15MwXl+bKCAKDT9bfyxMCt7BoRxuKQR68vBCmsECZSn9lUZPRcySCDDHmvCLS
        XYw1alUEdHAdbzdIwIbrAN6fAAe149wM3bXCw/T4VivLNN5TMXs1bXgNfy2qFO1EJqtYxK
        awp6sDiHENTZy24higuu6EfwjBkiiNN+cX+E5iyPsv42ZqdsZt7jePMZAD23SyXraZyzWM
        yfEDyKsnUE3PXcjXf1URb9sPCDcpF4KkR+ugPaSCjfQxzn7C2JtsGgxFbnCpxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605291207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7aFlYdIzEfv2JOKu+3iUrIPJ1A00nqjzBiRhswpxCy8=;
        b=ozBmN8hbH15DzeEjsBp4HoFUozlE+9PU1Z0MVsMnByiITLM6jvkKvEFc3ZrpgTS8asKb+4
        UQOzTG/hrI05h7Bw==
To:     linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: EC: Replace in_interrupt() usage.
Date:   Fri, 13 Nov 2020 19:13:17 +0100
Message-Id: <20201113181317.2227833-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

advance_transaction() is using in_interrupt() to distinguish between an
invocation from the interrupt handler and an invocation from another
part of the stack.

This looks misleading because chains like
  acpi_update_all_gpes() -> acpi_ev_gpe_detect() ->
  acpi_ev_detect_gpe() -> acpi_ec_gpe_handler()

should probably also behave as if they were called from an interrupt
handler.

Replace in_interrupt() usage with a function parameter. Set this
parameter to `true' if invoked from an interrupt handler
(acpi_ec_gpe_handler() and acpi_ec_irq_handler()) and `false' otherwise.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/acpi/ec.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e0cb1bcfffb29..0caf5ca1fc076 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -169,7 +169,7 @@ struct acpi_ec_query {
 };
=20
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
-static void advance_transaction(struct acpi_ec *ec);
+static void advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
 static void acpi_ec_event_processor(struct work_struct *work);
=20
@@ -358,7 +358,7 @@ static inline void acpi_ec_enable_gpe(struct acpi_ec *e=
c, bool open)
 		 * EN=3D1 writes.
 		 */
 		ec_dbg_raw("Polling quirk");
-		advance_transaction(ec);
+		advance_transaction(ec, false);
 	}
 }
=20
@@ -488,7 +488,7 @@ static inline void __acpi_ec_enable_event(struct acpi_e=
c *ec)
 	 * Unconditionally invoke this once after enabling the event
 	 * handling mechanism to detect the pending events.
 	 */
-	advance_transaction(ec);
+	advance_transaction(ec, false);
 }
=20
 static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
@@ -632,14 +632,13 @@ static inline void ec_transaction_transition(struct a=
cpi_ec *ec, unsigned long f
 	}
 }
=20
-static void advance_transaction(struct acpi_ec *ec)
+static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
 	struct transaction *t;
 	u8 status;
 	bool wakeup =3D false;
=20
-	ec_dbg_stm("%s (%d)", in_interrupt() ? "IRQ" : "TASK",
-		   smp_processor_id());
+	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
 	/*
 	 * By always clearing STS before handling all indications, we can
 	 * ensure a hardware STS 0->1 change after this clearing can always
@@ -699,7 +698,7 @@ static void advance_transaction(struct acpi_ec *ec)
 	 * otherwise will take a not handled IRQ as a false one.
 	 */
 	if (!(status & ACPI_EC_FLAG_SCI)) {
-		if (in_interrupt() && t) {
+		if (interrupt && t) {
 			if (t->irq_count < ec_storm_threshold)
 				++t->irq_count;
 			/* Allow triggering on 0 threshold */
@@ -710,7 +709,7 @@ static void advance_transaction(struct acpi_ec *ec)
 out:
 	if (status & ACPI_EC_FLAG_SCI)
 		acpi_ec_submit_query(ec);
-	if (wakeup && in_interrupt())
+	if (wakeup && interrupt)
 		wake_up(&ec->wait);
 }
=20
@@ -767,7 +766,7 @@ static int ec_poll(struct acpi_ec *ec)
 			if (!ec_guard(ec))
 				return 0;
 			spin_lock_irqsave(&ec->lock, flags);
-			advance_transaction(ec);
+			advance_transaction(ec, false);
 			spin_unlock_irqrestore(&ec->lock, flags);
 		} while (time_before(jiffies, delay));
 		pr_debug("controller reset, restart transaction\n");
@@ -1216,7 +1215,7 @@ static void acpi_ec_check_event(struct acpi_ec *ec)
 			 * taking care of it.
 			 */
 			if (!ec->curr)
-				advance_transaction(ec);
+				advance_transaction(ec, false);
 			spin_unlock_irqrestore(&ec->lock, flags);
 		}
 	}
@@ -1259,7 +1258,7 @@ static void acpi_ec_handle_interrupt(struct acpi_ec *=
ec)
 	unsigned long flags;
=20
 	spin_lock_irqsave(&ec->lock, flags);
-	advance_transaction(ec);
+	advance_transaction(ec, true);
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
=20
--=20
2.29.2

