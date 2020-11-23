Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4952C14B2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 20:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgKWTrp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61656 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgKWTrp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 14:47:45 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 14:47:44 EST
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 62d924656228e836; Mon, 23 Nov 2020 20:41:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ACPI: EC: Clean up status flags checks in advance_transaction()
Date:   Mon, 23 Nov 2020 20:40:53 +0100
Message-ID: <5941029.rKP6mmzaN7@kreacher>
In-Reply-To: <3259005.CeRvrUlyd7@kreacher>
References: <3259005.CeRvrUlyd7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Eliminate comparisons from the status flags checks in
advance_transaction() (especially from the one that is only correct,
because the value of the flag checked in there is 1) and rearrange
the code for more clarity while at it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 091f0e9f37a0..13565629ce0a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -667,25 +667,24 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 
 	if (t->flags & ACPI_EC_COMMAND_POLL) {
 		if (t->wlen > t->wi) {
-			if ((status & ACPI_EC_FLAG_IBF) == 0)
+			if (!(status & ACPI_EC_FLAG_IBF))
 				acpi_ec_write_data(ec, t->wdata[t->wi++]);
 			else if (interrupt && !(status & ACPI_EC_FLAG_SCI))
 				acpi_ec_spurious_interrupt(ec, t);
 		} else if (t->rlen > t->ri) {
-			if ((status & ACPI_EC_FLAG_OBF) == 1) {
+			if (status & ACPI_EC_FLAG_OBF) {
 				t->rdata[t->ri++] = acpi_ec_read_data(ec);
 				if (t->rlen == t->ri) {
 					ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
+					wakeup = true;
 					if (t->command == ACPI_EC_COMMAND_QUERY)
 						ec_dbg_evt("Command(%s) completed by hardware",
 							   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-					wakeup = true;
 				}
 			} else if (interrupt && !(status & ACPI_EC_FLAG_SCI)) {
 				acpi_ec_spurious_interrupt(ec, t);
 			}
-		} else if (t->wlen == t->wi &&
-			   (status & ACPI_EC_FLAG_IBF) == 0) {
+		} else if (t->wlen == t->wi && !(status & ACPI_EC_FLAG_IBF)) {
 			ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
 			wakeup = true;
 		}
@@ -697,6 +696,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 out:
 	if (status & ACPI_EC_FLAG_SCI)
 		acpi_ec_submit_query(ec);
+
 	if (wakeup && interrupt)
 		wake_up(&ec->wait);
 }
-- 
2.26.2




