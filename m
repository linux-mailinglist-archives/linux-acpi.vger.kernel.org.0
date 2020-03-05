Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD217B223
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCEXR6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 18:17:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63419 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXR5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 18:17:57 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 4a20b7f991c383a4; Fri, 6 Mar 2020 00:17:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: EC: Eliminate EC_FLAGS_QUERY_HANDSHAKE
Date:   Fri, 06 Mar 2020 00:17:55 +0100
Message-ID: <4132402.vtZ0fvcVVT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The EC_FLAGS_QUERY_HANDSHAKE switch is never set in the current
code (the only function setting it is defined under #if 0) and
has no effect whatever, so eliminate it and drop the code
depending on it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -182,7 +182,6 @@ static bool boot_ec_is_ecdt = false;
 static struct workqueue_struct *ec_wq;
 static struct workqueue_struct *ec_query_wq;
 
-static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
 static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
@@ -690,21 +689,9 @@ static void advance_transaction(struct a
 			wakeup = true;
 		}
 		goto out;
-	} else {
-		if (EC_FLAGS_QUERY_HANDSHAKE &&
-		    !(status & ACPI_EC_FLAG_SCI) &&
-		    (t->command == ACPI_EC_COMMAND_QUERY)) {
-			ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
-			t->rdata[t->ri++] = 0x00;
-			ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
-			ec_dbg_evt("Command(%s) completed by software",
-				   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-			wakeup = true;
-		} else if ((status & ACPI_EC_FLAG_IBF) == 0) {
-			acpi_ec_write_cmd(ec, t->command);
-			ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
-		} else
-			goto err;
+	} else if (!(status & ACPI_EC_FLAG_IBF)) {
+		acpi_ec_write_cmd(ec, t->command);
+		ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
 		goto out;
 	}
 err:
@@ -1805,22 +1792,6 @@ static void __init acpi_ec_ecdt_start(vo
 	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
 }
 
-#if 0
-/*
- * Some EC firmware variations refuses to respond QR_EC when SCI_EVT is not
- * set, for which case, we complete the QR_EC without issuing it to the
- * firmware.
- * https://bugzilla.kernel.org/show_bug.cgi?id=82611
- * https://bugzilla.kernel.org/show_bug.cgi?id=97381
- */
-static int ec_flag_query_handshake(const struct dmi_system_id *id)
-{
-	pr_debug("Detected the EC firmware requiring QR_EC issued when SCI_EVT set\n");
-	EC_FLAGS_QUERY_HANDSHAKE = 1;
-	return 0;
-}
-#endif
-
 /*
  * On some hardware it is necessary to clear events accumulated by the EC during
  * sleep. These ECs stop reporting GPEs until they are manually polled, if too



