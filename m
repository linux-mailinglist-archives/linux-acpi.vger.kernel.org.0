Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB443537C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJTTMk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 15:12:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41968 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhJTTMk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Oct 2021 15:12:40 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5bf667436b9baf14; Wed, 20 Oct 2021 21:10:24 +0200
Received: from kreacher.localnet (unknown [213.134.162.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C153166A919;
        Wed, 20 Oct 2021 21:10:23 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: sleep: Do not set suspend_ops unnecessarily
Date:   Wed, 20 Oct 2021 21:10:17 +0200
Message-ID: <4698118.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.32
X-CLIENT-HOSTNAME: 213.134.162.32
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvgedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrdduiedvrdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedvrdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If none of the S1 - S3 sleep states is supported, it is not necessary
to register suspend_ops, so don't do that then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -815,14 +815,18 @@ void __weak acpi_s2idle_setup(void)
 
 static void acpi_sleep_suspend_setup(void)
 {
+	bool suspend_ops_needed = false;
 	int i;
 
 	for (i = ACPI_STATE_S1; i < ACPI_STATE_S4; i++)
-		if (acpi_sleep_state_supported(i))
+		if (acpi_sleep_state_supported(i)) {
 			sleep_states[i] = 1;
+			suspend_ops_needed = true;
+		}
 
-	suspend_set_ops(old_suspend_ordering ?
-		&acpi_suspend_ops_old : &acpi_suspend_ops);
+	if (suspend_ops_needed)
+		suspend_set_ops(old_suspend_ordering ?
+				&acpi_suspend_ops_old : &acpi_suspend_ops);
 
 	acpi_s2idle_setup();
 }



