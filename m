Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A925419264B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYK4k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 25 Mar 2020 06:56:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48694 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCYK4k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 06:56:40 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 0c81cca4627adb77; Wed, 25 Mar 2020 11:56:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        =?utf-8?B?T25kxZllag==?= Caletka <ondrej@caletka.cz>
Subject: [PATCH 2/2] ACPI: PM: s2idle: Refine active GPEs check
Date:   Wed, 25 Mar 2020 11:55:48 +0100
Message-ID: <3401112.1UjFo9YGNl@kreacher>
In-Reply-To: <9291082.ZuhHelrm8h@kreacher>
References: <9291082.ZuhHelrm8h@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The check for any active GPEs added by commit fdde0ff8590b ("ACPI:
PM: s2idle: Prevent spurious SCIs from waking up the system") turns
out to be insufficiently precise to prevent some systems from
resuming prematurely due to a spurious EC wakeup, so refine it
by first checking if any GPEs other than the EC GPE are active
and skipping all of the SCIs coming from the EC that do not produce
any genuine wakeup events after processing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206629
Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
Reported-by: Ondřej Caletka <ondrej@caletka.cz>
Tested-by: Ondřej Caletka <ondrej@caletka.cz>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |  5 +++++
 drivers/acpi/internal.h |  1 +
 drivers/acpi/sleep.c    | 19 ++++++++++---------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d1f1cf5d4bf0..9b9094b0b73f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2037,6 +2037,11 @@ void acpi_ec_set_gpe_wake_mask(u8 action)
 		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
 
+bool acpi_ec_other_gpes_active(void)
+{
+	return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX);
+}
+
 bool acpi_ec_dispatch_gpe(void)
 {
 	u32 ret;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 3616daec650b..d44c591c4ee4 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -202,6 +202,7 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
+bool acpi_ec_other_gpes_active(void);
 bool acpi_ec_dispatch_gpe(void);
 #endif
 
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 857a6165c534..2cdd3f991a47 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1013,18 +1013,19 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
-		 * If there are no EC events to process and at least one of the
-		 * other enabled GPEs is active, the wakeup is regarded as a
-		 * genuine one.
-		 *
-		 * Note that the checks below must be carried out in this order
-		 * to avoid returning prematurely due to a change of the EC GPE
-		 * status bit from unset to set between the checks with the
-		 * status bits of all the other GPEs unset.
+		 * If the status bit is set for any enabled GPE other than the
+		 * EC one, the wakeup is regarded as a genuine one.
 		 */
-		if (acpi_any_gpe_status_set(U32_MAX) && !acpi_ec_dispatch_gpe())
+		if (acpi_ec_other_gpes_active())
 			return true;
 
+		/*
+		 * If the EC GPE status bit has not been set, the wakeup is
+		 * regarded as a spurious one.
+		 */
+		if (!acpi_ec_dispatch_gpe())
+			return false;
+
 		/*
 		 * Cancel the wakeup and process all pending events in case
 		 * there are any wakeup ones in there.
-- 
2.16.4




