Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7AB45AB91
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhKWSwd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48556 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhKWSw3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:29 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 1584c9c927258cc1; Tue, 23 Nov 2021 19:49:20 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C43366AC5B;
        Tue, 23 Nov 2021 19:49:19 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 06/10] ACPI: EC: Simplify locking in acpi_ec_event_handler()
Date:   Tue, 23 Nov 2021 19:40:50 +0100
Message-ID: <3163997.44csPzL39Z@kreacher>
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

Because acpi_ec_event_handler() is a work function, it always
runs in process context with interrupts enabled, so it can use
spin_lock_irq() and spin_unlock_irq() for the locking.

Make it do so and adjust white space around those calls.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1217,18 +1217,18 @@ err_exit:
 
 static void acpi_ec_event_handler(struct work_struct *work)
 {
-	unsigned long flags;
 	struct acpi_ec *ec = container_of(work, struct acpi_ec, work);
 
 	ec_dbg_evt("Event started");
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock_irq(&ec->lock);
+
 	while (ec->nr_pending_queries) {
-		spin_unlock_irqrestore(&ec->lock, flags);
+		spin_unlock_irq(&ec->lock);
 
 		acpi_ec_query(ec);
 
-		spin_lock_irqsave(&ec->lock, flags);
+		spin_lock_irq(&ec->lock);
 		ec->nr_pending_queries--;
 	}
 
@@ -1241,23 +1241,23 @@ static void acpi_ec_event_handler(struct
 	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY)
 		acpi_ec_complete_query(ec);
 
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock_irq(&ec->lock);
 
 	ec_dbg_evt("Event stopped");
 
 	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT && ec_guard(ec)) {
-		spin_lock_irqsave(&ec->lock, flags);
+		spin_lock_irq(&ec->lock);
 
 		/* Take care of SCI_EVT unless someone else is doing that. */
 		if (!ec->curr)
 			advance_transaction(ec, false);
 
-		spin_unlock_irqrestore(&ec->lock, flags);
+		spin_unlock_irq(&ec->lock);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	spin_lock_irq(&ec->lock);
 	ec->events_in_progress--;
-	spin_unlock_irqrestore(&ec->lock, flags);
+	spin_unlock_irq(&ec->lock);
 }
 
 static void acpi_ec_handle_interrupt(struct acpi_ec *ec)



