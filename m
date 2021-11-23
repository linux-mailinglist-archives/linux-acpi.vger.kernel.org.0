Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58F45AB8B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhKWSw2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55778 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbhKWSw0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:26 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 972e9cfc9271efb9; Tue, 23 Nov 2021 19:49:16 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E380C66AC5B;
        Tue, 23 Nov 2021 19:49:15 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 08/10] ACPI: EC: Avoid queuing unnecessary work in acpi_ec_submit_event()
Date:   Tue, 23 Nov 2021 19:43:05 +0100
Message-ID: <1894423.PYKUYFuaPT@kreacher>
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

Notice that it is not necessary to queue up the event work again
if the while () loop in acpi_ec_event_handler() is still running
which is the case if nr_pending_queries is greater than 0 at the
beginning of acpi_ec_submit_event() and modify the code to avoid
doing that.

While at it, rename nr_pending_queries in struct acpi_ec to
events_to_process which actually matches the role of that field
and change its data type to unsigned int which is sufficient.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   17 +++++++++++++----
 drivers/acpi/internal.h |    2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -183,7 +183,7 @@ struct acpi_ec {
 	spinlock_t lock;
 	struct work_struct work;
 	unsigned long timestamp;
-	unsigned long nr_pending_queries;
+	unsigned int events_to_process;
 	unsigned int events_in_progress;
 	unsigned int queries_in_progress;
 	bool busy_polling;
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -453,7 +453,16 @@ static bool acpi_ec_submit_event(struct
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-		ec->nr_pending_queries++;
+		/*
+		 * If events_to_process is greqter than 0 at this point, the
+		 * while () loop in acpi_ec_event_handler() is still running
+		 * and incrementing events_to_process will cause it to invoke
+		 * acpi_ec_submit_query() once more, so it is not necessary to
+		 * queue up the event work to start the same loop again.
+		 */
+		if (ec->events_to_process++ > 0)
+			return true;
+
 		ec->events_in_progress++;
 		return queue_work(ec_wq, &ec->work);
 	}
@@ -665,7 +674,7 @@ static bool advance_transaction(struct a
 	 */
 	if (!t || !(t->flags & ACPI_EC_COMMAND_POLL)) {
 		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
-		    (!ec->nr_pending_queries ||
+		    (!ec->events_to_process ||
 		     test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags))) {
 			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
 			acpi_ec_close_event(ec);
@@ -1223,13 +1232,13 @@ static void acpi_ec_event_handler(struct
 
 	spin_lock_irq(&ec->lock);
 
-	while (ec->nr_pending_queries) {
+	while (ec->events_to_process) {
 		spin_unlock_irq(&ec->lock);
 
 		acpi_ec_submit_query(ec);
 
 		spin_lock_irq(&ec->lock);
-		ec->nr_pending_queries--;
+		ec->events_to_process--;
 	}
 
 	/*



