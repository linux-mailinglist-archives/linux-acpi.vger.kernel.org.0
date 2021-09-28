Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766241B760
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 21:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbhI1TT1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 15:19:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48018 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbhI1TT1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2021 15:19:27 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 865dcda1a85b64b9; Tue, 28 Sep 2021 21:17:46 +0200
Received: from kreacher.localnet (unknown [213.134.187.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A5AE866A742;
        Tue, 28 Sep 2021 21:17:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Reik Keutterling <spielkind@gmail.com>
Subject: [PATCH v1] ACPICA: Avoid evaluating methods too early during system resume
Date:   Tue, 28 Sep 2021 21:17:44 +0200
Message-ID: <5515956.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.41
X-CLIENT-HOSTNAME: 213.134.187.41
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudejjedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdevgfetueetheekudeuvdduteelvefftdfftdejjeeukeffteeikefgiefghedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekjedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrgedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhpihgvlhhkihhnugesghhmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

During wakeup from system-wide sleep states, acpi_get_sleep_type_data()
is called and it tries to get memory from the slab allocator in order
to evaluate a control method, but if KFENCE is enabled in the kernel,
the memory allocation attempt causes an IRQ work to be queued and a
self-IPI to be sent to the CPU running the code which requires the
memory controller to be ready, so if that happens too early in the
wakeup path, it doesn't work.

Prevent that from taking place by calling acpi_get_sleep_type_data()
for S0 upfront, when preparing to enter a given sleep state, and
saving the data obtained by it for later use during system wakeup.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214271
Reported-by: Reik Keutterling <spielkind@gmail.com>
Tested-by: Reik Keutterling <spielkind@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acglobal.h  |    2 ++
 drivers/acpi/acpica/hwesleep.c  |    8 ++------
 drivers/acpi/acpica/hwsleep.c   |    9 +++------
 drivers/acpi/acpica/hwxfsleep.c |    7 +++++++
 4 files changed, 14 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acglobal.h
+++ linux-pm/drivers/acpi/acpica/acglobal.h
@@ -226,6 +226,8 @@ extern struct acpi_bit_register_info
     acpi_gbl_bit_register_info[ACPI_NUM_BITREG];
 ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a);
 ACPI_GLOBAL(u8, acpi_gbl_sleep_type_b);
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a_s0);
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_b_s0);
 
 /*****************************************************************************
  *
Index: linux-pm/drivers/acpi/acpica/hwxfsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwxfsleep.c
+++ linux-pm/drivers/acpi/acpica/hwxfsleep.c
@@ -217,6 +217,13 @@ acpi_status acpi_enter_sleep_state_prep(
 		return_ACPI_STATUS(status);
 	}
 
+	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
+					  &acpi_gbl_sleep_type_a_s0,
+					  &acpi_gbl_sleep_type_b_s0);
+	if (ACPI_FAILURE(status)) {
+		acpi_gbl_sleep_type_a_s0 = ACPI_SLEEP_TYPE_INVALID;
+	}
+
 	/* Execute the _PTS method (Prepare To Sleep) */
 
 	arg_list.count = 1;
Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -192,10 +192,7 @@ acpi_status acpi_hw_legacy_wake_prep(u8
 	 * This is unclear from the ACPI Spec, but it is required
 	 * by some machines.
 	 */
-	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
-					  &acpi_gbl_sleep_type_a,
-					  &acpi_gbl_sleep_type_b);
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_gbl_sleep_type_a_s0 != ACPI_SLEEP_TYPE_INVALID) {
 		sleep_type_reg_info =
 		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE);
 		sleep_enable_reg_info =
@@ -216,9 +213,9 @@ acpi_status acpi_hw_legacy_wake_prep(u8
 
 			/* Insert the SLP_TYP bits */
 
-			pm1a_control |= (acpi_gbl_sleep_type_a <<
+			pm1a_control |= (acpi_gbl_sleep_type_a_s0 <<
 					 sleep_type_reg_info->bit_position);
-			pm1b_control |= (acpi_gbl_sleep_type_b <<
+			pm1b_control |= (acpi_gbl_sleep_type_b_s0 <<
 					 sleep_type_reg_info->bit_position);
 
 			/* Write the control registers and ignore any errors */
Index: linux-pm/drivers/acpi/acpica/hwesleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwesleep.c
+++ linux-pm/drivers/acpi/acpica/hwesleep.c
@@ -147,17 +147,13 @@ acpi_status acpi_hw_extended_sleep(u8 sl
 
 acpi_status acpi_hw_extended_wake_prep(u8 sleep_state)
 {
-	acpi_status status;
 	u8 sleep_type_value;
 
 	ACPI_FUNCTION_TRACE(hw_extended_wake_prep);
 
-	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
-					  &acpi_gbl_sleep_type_a,
-					  &acpi_gbl_sleep_type_b);
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_gbl_sleep_type_a_s0 != ACPI_SLEEP_TYPE_INVALID) {
 		sleep_type_value =
-		    ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
+		    ((acpi_gbl_sleep_type_a_s0 << ACPI_X_SLEEP_TYPE_POSITION) &
 		     ACPI_X_SLEEP_TYPE_MASK);
 
 		(void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),



