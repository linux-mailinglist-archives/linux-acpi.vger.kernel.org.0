Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF245AB83
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhKWSwX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42058 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbhKWSwX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:23 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 6c1b712ec58d02be; Tue, 23 Nov 2021 19:49:13 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CDA9666AC5B;
        Tue, 23 Nov 2021 19:49:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 10/10] ACPI: EC: Relocate acpi_ec_create_query() and drop acpi_ec_delete_query()
Date:   Tue, 23 Nov 2021 19:46:09 +0100
Message-ID: <3418336.iIbC2pHGDl@kreacher>
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

Move acpi_ec_create_query() after acpi_ec_event_processor(), drop the
no longer needed forward declaration of the latter, and eliminate
acpi_ec_delete_query() which isn't really necessary.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   54 +++++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -170,7 +170,6 @@ struct acpi_ec_query {
 static int acpi_ec_submit_query(struct acpi_ec *ec);
 static bool advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
-static void acpi_ec_event_processor(struct work_struct *work);
 
 struct acpi_ec *first_ec;
 EXPORT_SYMBOL(first_ec);
@@ -1134,33 +1133,6 @@ void acpi_ec_remove_query_handler(struct
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static struct acpi_ec_query *acpi_ec_create_query(struct acpi_ec *ec, u8 *pval)
-{
-	struct acpi_ec_query *q;
-	struct transaction *t;
-
-	q = kzalloc(sizeof (struct acpi_ec_query), GFP_KERNEL);
-	if (!q)
-		return NULL;
-
-	INIT_WORK(&q->work, acpi_ec_event_processor);
-	t = &q->transaction;
-	t->command = ACPI_EC_COMMAND_QUERY;
-	t->rdata = pval;
-	t->rlen = 1;
-	q->ec = ec;
-	return q;
-}
-
-static void acpi_ec_delete_query(struct acpi_ec_query *q)
-{
-	if (q) {
-		if (q->handler)
-			acpi_ec_put_query_handler(q->handler);
-		kfree(q);
-	}
-}
-
 static void acpi_ec_event_processor(struct work_struct *work)
 {
 	struct acpi_ec_query *q = container_of(work, struct acpi_ec_query, work);
@@ -1180,7 +1152,26 @@ static void acpi_ec_event_processor(stru
 	ec->queries_in_progress--;
 	spin_unlock_irq(&ec->lock);
 
-	acpi_ec_delete_query(q);
+	acpi_ec_put_query_handler(handler);
+	kfree(q);
+}
+
+static struct acpi_ec_query *acpi_ec_create_query(struct acpi_ec *ec, u8 *pval)
+{
+	struct acpi_ec_query *q;
+	struct transaction *t;
+
+	q = kzalloc(sizeof (struct acpi_ec_query), GFP_KERNEL);
+	if (!q)
+		return NULL;
+
+	INIT_WORK(&q->work, acpi_ec_event_processor);
+	t = &q->transaction;
+	t->command = ACPI_EC_COMMAND_QUERY;
+	t->rdata = pval;
+	t->rlen = 1;
+	q->ec = ec;
+	return q;
 }
 
 static int acpi_ec_submit_query(struct acpi_ec *ec)
@@ -1229,9 +1220,10 @@ static int acpi_ec_submit_query(struct a
 
 	spin_unlock_irq(&ec->lock);
 
+	return 0;
+
 err_exit:
-	if (result)
-		acpi_ec_delete_query(q);
+	kfree(q);
 
 	return result;
 }



