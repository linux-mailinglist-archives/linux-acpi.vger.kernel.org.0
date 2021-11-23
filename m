Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1645AB92
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhKWSwe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53574 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhKWSwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:31 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id a90d8b64dcf95691; Tue, 23 Nov 2021 19:49:21 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9E89266AC5A;
        Tue, 23 Nov 2021 19:49:20 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 05/10] ACPI: EC: Rearrange the loop in acpi_ec_event_handler()
Date:   Tue, 23 Nov 2021 19:40:04 +0100
Message-ID: <2820107.e9J7NaK4W3@kreacher>
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

It is not necessary to check ec->nr_pending_queries against 0 in the
while () loop in acpi_ec_event_handler(), because that loop terminates
when ec->nr_pending_queries is 0 and the code depending on that can be
run after the loop has ended.

Modify the code accordingly and while at it rewrite the comment
regarding that code to make it clearer.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1230,18 +1230,17 @@ static void acpi_ec_event_handler(struct
 
 		spin_lock_irqsave(&ec->lock, flags);
 		ec->nr_pending_queries--;
-		/*
-		 * Before exit, make sure that this work item can be
-		 * scheduled again. There might be QR_EC failures, leaving
-		 * EC_FLAGS_QUERY_PENDING uncleared and preventing this work
-		 * item from being scheduled again.
-		 */
-		if (!ec->nr_pending_queries) {
-			if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
-			    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
-				acpi_ec_complete_query(ec);
-		}
 	}
+
+	/*
+	 * Before exit, make sure that the it will be possible to queue up the
+	 * event handling work again regardless of whether or not the query
+	 * queued up above is processed successfully.
+	 */
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
+	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
+		acpi_ec_complete_query(ec);
+
 	spin_unlock_irqrestore(&ec->lock, flags);
 
 	ec_dbg_evt("Event stopped");



