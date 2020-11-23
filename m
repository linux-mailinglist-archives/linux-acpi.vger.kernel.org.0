Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C932C14B7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgKWTru (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53562 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgKWTrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 14:47:49 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 64c4579c018f95d1; Mon, 23 Nov 2020 20:41:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] ACPI: EC: Fold acpi_ec_clear_gpe() into its caller
Date:   Mon, 23 Nov 2020 20:37:06 +0100
Message-ID: <8467712.e8rTiVh5pU@kreacher>
In-Reply-To: <3259005.CeRvrUlyd7@kreacher>
References: <3259005.CeRvrUlyd7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Fold acpi_ec_clear_gpe() which is only used in one place into its
caller and clean up comments related to that function while at it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0caf5ca1fc07..97e595238a8c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -372,23 +372,6 @@ static inline void acpi_ec_disable_gpe(struct acpi_ec *ec, bool close)
 	}
 }
 
-static inline void acpi_ec_clear_gpe(struct acpi_ec *ec)
-{
-	/*
-	 * GPE STS is a W1C register, which means:
-	 * 1. Software can clear it without worrying about clearing other
-	 *    GPEs' STS bits when the hardware sets them in parallel.
-	 * 2. As long as software can ensure only clearing it when it is
-	 *    set, hardware won't set it in parallel.
-	 * So software can clear GPE in any contexts.
-	 * Warning: do not move the check into advance_transaction() as the
-	 * EC commands will be sent without GPE raised.
-	 */
-	if (!acpi_ec_is_gpe_raised(ec))
-		return;
-	acpi_clear_gpe(NULL, ec->gpe);
-}
-
 /* --------------------------------------------------------------------------
  *                           Transaction Management
  * -------------------------------------------------------------------------- */
@@ -639,13 +622,21 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 	bool wakeup = false;
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
+
 	/*
-	 * By always clearing STS before handling all indications, we can
-	 * ensure a hardware STS 0->1 change after this clearing can always
-	 * trigger a GPE interrupt.
+	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
+	 * changes to always trigger a GPE interrupt.
+	 *
+	 * GPE STS is a W1C register, which means:
+	 *
+	 * 1. Software can clear it without worrying about clearing the other
+	 *    GPEs' STS bits when the hardware sets them in parallel.
+	 *
+	 * 2. As long as software can ensure only clearing it when it is set,
+	 *    hardware won't set it in parallel.
 	 */
-	if (ec->gpe >= 0)
-		acpi_ec_clear_gpe(ec);
+	if (ec->gpe >= 0 && acpi_ec_is_gpe_raised(ec))
+		acpi_clear_gpe(NULL, ec->gpe);
 
 	status = acpi_ec_read_status(ec);
 	t = ec->curr;
-- 
2.26.2




