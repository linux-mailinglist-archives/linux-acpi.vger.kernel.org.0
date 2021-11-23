Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487F845AB95
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhKWSwg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49254 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbhKWSwc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:32 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 7e4dc1b2058bac77; Tue, 23 Nov 2021 19:49:22 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0E31566AC5A;
        Tue, 23 Nov 2021 19:49:22 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 04/10] ACPI: EC: Fold acpi_ec_check_event() into acpi_ec_event_handler()
Date:   Tue, 23 Nov 2021 19:39:05 +0100
Message-ID: <2101564.irdbgypaU6@kreacher>
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

Because acpi_ec_event_handler() is the only caller of
acpi_ec_check_event() and the separation of these two functions
makes it harder to follow the code flow, fold the latter into the
former (and simplify that code while at it).

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1215,24 +1215,6 @@ err_exit:
 	return result;
 }
 
-static void acpi_ec_check_event(struct acpi_ec *ec)
-{
-	unsigned long flags;
-
-	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT) {
-		if (ec_guard(ec)) {
-			spin_lock_irqsave(&ec->lock, flags);
-			/*
-			 * Take care of the SCI_EVT unless no one else is
-			 * taking care of it.
-			 */
-			if (!ec->curr)
-				advance_transaction(ec, false);
-			spin_unlock_irqrestore(&ec->lock, flags);
-		}
-	}
-}
-
 static void acpi_ec_event_handler(struct work_struct *work)
 {
 	unsigned long flags;
@@ -1264,7 +1246,15 @@ static void acpi_ec_event_handler(struct
 
 	ec_dbg_evt("Event stopped");
 
-	acpi_ec_check_event(ec);
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT && ec_guard(ec)) {
+		spin_lock_irqsave(&ec->lock, flags);
+
+		/* Take care of SCI_EVT unless someone else is doing that. */
+		if (!ec->curr)
+			advance_transaction(ec, false);
+
+		spin_unlock_irqrestore(&ec->lock, flags);
+	}
 
 	spin_lock_irqsave(&ec->lock, flags);
 	ec->events_in_progress--;



