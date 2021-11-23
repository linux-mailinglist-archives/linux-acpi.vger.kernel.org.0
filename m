Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7245AB8C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhKWSw3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62904 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbhKWSw1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:27 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 70c6fdcfcc8277f6; Tue, 23 Nov 2021 19:49:18 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AD65E66AC5A;
        Tue, 23 Nov 2021 19:49:17 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 07/10] ACPI: EC: Rename three functions
Date:   Tue, 23 Nov 2021 19:42:02 +0100
Message-ID: <10006565.nUPlyArG6x@kreacher>
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

Rename acpi_ec_submit_query() to acpi_ec_submit_event(),
acpi_ec_query() to acpi_ec_submit_query(), and
acpi_ec_complete_query() to acpi_ec_close_event() to make
the names reflect what the functions do.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -169,7 +169,7 @@ struct acpi_ec_query {
 	struct acpi_ec *ec;
 };
 
-static int acpi_ec_query(struct acpi_ec *ec);
+static int acpi_ec_submit_query(struct acpi_ec *ec);
 static bool advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
 static void acpi_ec_event_processor(struct work_struct *work);
@@ -444,7 +444,7 @@ static bool acpi_ec_submit_flushable_req
 	return true;
 }
 
-static bool acpi_ec_submit_query(struct acpi_ec *ec)
+static bool acpi_ec_submit_event(struct acpi_ec *ec)
 {
 	acpi_ec_mask_events(ec);
 	if (!acpi_ec_event_enabled(ec))
@@ -465,7 +465,7 @@ static bool acpi_ec_submit_query(struct
 	return true;
 }
 
-static void acpi_ec_complete_query(struct acpi_ec *ec)
+static void acpi_ec_close_event(struct acpi_ec *ec)
 {
 	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 		ec_dbg_evt("Command(%s) unblocked",
@@ -499,7 +499,7 @@ static void acpi_ec_clear(struct acpi_ec
 	int i;
 
 	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
-		if (acpi_ec_query(ec))
+		if (acpi_ec_submit_query(ec))
 			break;
 	}
 	if (unlikely(i == ACPI_EC_CLEAR_MAX))
@@ -613,10 +613,10 @@ static inline void ec_transaction_transi
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS &&
 		    flag == ACPI_EC_COMMAND_POLL)
-			acpi_ec_complete_query(ec);
+			acpi_ec_close_event(ec);
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY &&
 		    flag == ACPI_EC_COMMAND_COMPLETE)
-			acpi_ec_complete_query(ec);
+			acpi_ec_close_event(ec);
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
 		    flag == ACPI_EC_COMMAND_COMPLETE)
 			set_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
@@ -668,7 +668,7 @@ static bool advance_transaction(struct a
 		    (!ec->nr_pending_queries ||
 		     test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags))) {
 			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
-			acpi_ec_complete_query(ec);
+			acpi_ec_close_event(ec);
 		}
 		if (!t)
 			goto out;
@@ -704,7 +704,7 @@ static bool advance_transaction(struct a
 
 out:
 	if (status & ACPI_EC_FLAG_SCI)
-		ret = acpi_ec_submit_query(ec);
+		ret = acpi_ec_submit_event(ec);
 
 	if (wakeup && interrupt)
 		wake_up(&ec->wait);
@@ -1162,7 +1162,7 @@ static void acpi_ec_event_processor(stru
 	acpi_ec_delete_query(q);
 }
 
-static int acpi_ec_query(struct acpi_ec *ec)
+static int acpi_ec_submit_query(struct acpi_ec *ec)
 {
 	struct acpi_ec_query *q;
 	u8 value = 0;
@@ -1226,7 +1226,7 @@ static void acpi_ec_event_handler(struct
 	while (ec->nr_pending_queries) {
 		spin_unlock_irq(&ec->lock);
 
-		acpi_ec_query(ec);
+		acpi_ec_submit_query(ec);
 
 		spin_lock_irq(&ec->lock);
 		ec->nr_pending_queries--;
@@ -1239,7 +1239,7 @@ static void acpi_ec_event_handler(struct
 	 */
 	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
 	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
-		acpi_ec_complete_query(ec);
+		acpi_ec_close_event(ec);
 
 	spin_unlock_irq(&ec->lock);
 



