Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459145AB9A
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhKWSwl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41074 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbhKWSwe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:52:34 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id c741c9860af4cab6; Tue, 23 Nov 2021 19:49:24 +0100
Received: from kreacher.localnet (unknown [213.134.175.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A150566AC5A;
        Tue, 23 Nov 2021 19:49:23 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 03/10] ACPI: EC: Pass one argument to acpi_ec_query()
Date:   Tue, 23 Nov 2021 19:38:21 +0100
Message-ID: <4686424.GXAFRqVoOG@kreacher>
In-Reply-To: <11887969.O9o76ZdvQC@kreacher>
References: <11887969.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.133
X-CLIENT-HOSTNAME: 213.134.175.133
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrudeffeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddufeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the second argument to acpi_ec_query() is redundant,
because in the only case when it is not NULL, the value passed
through it is only checked against 0 and it can only be 0 when
acpi_ec_query() returns an error code, but its return value
is checked along with the value passed through its second
argument.

Accordingly, modify acpi_ec_query() to take only one argument
and while at it, change its handling of the case when
acpi_ec_transaction() returns an error so as to return that
error value to the caller right away.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -169,7 +169,7 @@ struct acpi_ec_query {
 	struct acpi_ec *ec;
 };
 
-static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
+static int acpi_ec_query(struct acpi_ec *ec);
 static bool advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
 static void acpi_ec_event_processor(struct work_struct *work);
@@ -496,12 +496,10 @@ static inline void __acpi_ec_disable_eve
  */
 static void acpi_ec_clear(struct acpi_ec *ec)
 {
-	int i, status;
-	u8 value = 0;
+	int i;
 
 	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
-		status = acpi_ec_query(ec, &value);
-		if (status || !value)
+		if (acpi_ec_query(ec))
 			break;
 	}
 	if (unlikely(i == ACPI_EC_CLEAR_MAX))
@@ -1164,11 +1162,11 @@ static void acpi_ec_event_processor(stru
 	acpi_ec_delete_query(q);
 }
 
-static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
+static int acpi_ec_query(struct acpi_ec *ec)
 {
+	struct acpi_ec_query *q;
 	u8 value = 0;
 	int result;
-	struct acpi_ec_query *q;
 
 	q = acpi_ec_create_query(ec, &value);
 	if (!q)
@@ -1180,11 +1178,14 @@ static int acpi_ec_query(struct acpi_ec
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
 	result = acpi_ec_transaction(ec, &q->transaction);
-	if (!value)
-		result = -ENODATA;
 	if (result)
 		goto err_exit;
 
+	if (!value) {
+		result = -ENODATA;
+		goto err_exit;
+	}
+
 	q->handler = acpi_ec_get_query_handler_by_value(ec, value);
 	if (!q->handler) {
 		result = -ENODATA;
@@ -1210,8 +1211,7 @@ static int acpi_ec_query(struct acpi_ec
 err_exit:
 	if (result)
 		acpi_ec_delete_query(q);
-	if (data)
-		*data = value;
+
 	return result;
 }
 
@@ -1243,7 +1243,9 @@ static void acpi_ec_event_handler(struct
 	spin_lock_irqsave(&ec->lock, flags);
 	while (ec->nr_pending_queries) {
 		spin_unlock_irqrestore(&ec->lock, flags);
-		(void)acpi_ec_query(ec, NULL);
+
+		acpi_ec_query(ec);
+
 		spin_lock_irqsave(&ec->lock, flags);
 		ec->nr_pending_queries--;
 		/*



