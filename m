Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4726B6ACBB
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfGPQ1e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61836 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfGPQ1T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:19 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id e17e7cc6a5295d67; Tue, 16 Jul 2019 18:27:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 3/8] ACPI: EC: Return bool from acpi_ec_dispatch_gpe()
Date:   Tue, 16 Jul 2019 18:12:59 +0200
Message-ID: <4778086.90p4OrCUAx@kreacher>
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
References: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some systems, if suspend-to-idle is used, the EC may singal system
wakeup events (power button events, for example) as well as events
that should not cause the system to resume and acpi_ec_dispatch_gpe()
needs to be called to determine whether or not the system should
resume then.  In particular, if acpi_ec_dispatch_gpe() doesn't detect
any EC events at all, the system should remain suspended, so it is
useful to know when that is the case.

For this reason, make acpi_ec_dispatch_gpe() return a bool value
indicating whether or not any EC events have been detected by it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   11 ++++++++---
 drivers/acpi/internal.h |    2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1060,10 +1060,15 @@ void acpi_ec_set_gpe_wake_mask(u8 action
 		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
 
-void acpi_ec_dispatch_gpe(void)
+bool acpi_ec_dispatch_gpe(void)
 {
-	if (first_ec)
-		acpi_dispatch_gpe(NULL, first_ec->gpe);
+	u32 ret;
+
+	if (!first_ec)
+		return false;
+
+	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
+	return ret == ACPI_INTERRUPT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -196,7 +196,7 @@ void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_mark_gpe_for_wake(void);
 void acpi_ec_set_gpe_wake_mask(u8 action);
-void acpi_ec_dispatch_gpe(void);
+bool acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);



