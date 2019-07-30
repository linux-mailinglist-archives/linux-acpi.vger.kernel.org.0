Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B07A58C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfG3KFv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:05:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63029 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfG3KFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jul 2019 06:05:14 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id efe23e57fc714eb3; Tue, 30 Jul 2019 12:05:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/8] ACPI: EC: PM: Consolidate some code depending on PM_SLEEP
Date:   Tue, 30 Jul 2019 12:03:26 +0200
Message-ID: <2742454.g7L1spr0te@kreacher>
In-Reply-To: <7528887.mqcfy9PZua@kreacher>
References: <7528887.mqcfy9PZua@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move some routines, including acpi_ec_dispatch_gpe(), that are only
used if CONFIG_PM_SLEEP is set to the #ifdef block containing the EC
suspend and resume callbacks, to make the "full EC PM picture" easier
to follow.

While at it, move the header of acpi_ec_dispatch_gpe() in the
header file to a CONFIG_PM_SLEEP #ifdef block.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New in v2.

---
 drivers/acpi/ec.c       |   54 +++++++++++++++++++++++-------------------------
 drivers/acpi/internal.h |    2 -
 2 files changed, 27 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -194,7 +194,6 @@ void acpi_ec_ecdt_probe(void);
 void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-bool acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
@@ -202,6 +201,7 @@ void acpi_ec_remove_query_handler(struct
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
+bool acpi_ec_dispatch_gpe(void);
 #endif
 
 
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1049,33 +1049,6 @@ void acpi_ec_unblock_transactions(void)
 		acpi_ec_start(first_ec, true);
 }
 
-#ifdef CONFIG_PM_SLEEP
-void acpi_ec_mark_gpe_for_wake(void)
-{
-	if (first_ec && !ec_no_wakeup)
-		acpi_mark_gpe_for_wake(NULL, first_ec->gpe);
-}
-EXPORT_SYMBOL_GPL(acpi_ec_mark_gpe_for_wake);
-
-void acpi_ec_set_gpe_wake_mask(u8 action)
-{
-	if (pm_suspend_no_platform() && first_ec && !ec_no_wakeup)
-		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
-}
-EXPORT_SYMBOL_GPL(acpi_ec_set_gpe_wake_mask);
-#endif
-
-bool acpi_ec_dispatch_gpe(void)
-{
-	u32 ret;
-
-	if (!first_ec)
-		return false;
-
-	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	return ret == ACPI_INTERRUPT_HANDLED;
-}
-
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
@@ -1984,7 +1957,32 @@ static int acpi_ec_resume(struct device
 	acpi_ec_enable_event(ec);
 	return 0;
 }
-#endif
+
+void acpi_ec_mark_gpe_for_wake(void)
+{
+	if (first_ec && !ec_no_wakeup)
+		acpi_mark_gpe_for_wake(NULL, first_ec->gpe);
+}
+EXPORT_SYMBOL_GPL(acpi_ec_mark_gpe_for_wake);
+
+void acpi_ec_set_gpe_wake_mask(u8 action)
+{
+	if (pm_suspend_no_platform() && first_ec && !ec_no_wakeup)
+		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
+}
+EXPORT_SYMBOL_GPL(acpi_ec_set_gpe_wake_mask);
+
+bool acpi_ec_dispatch_gpe(void)
+{
+	u32 ret;
+
+	if (!first_ec)
+		return false;
+
+	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
+	return ret == ACPI_INTERRUPT_HANDLED;
+}
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops acpi_ec_pm = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)



