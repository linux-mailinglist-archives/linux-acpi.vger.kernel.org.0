Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6A6ACAA
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfGPQ1R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43340 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfGPQ1Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:16 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 73767e2c92a2ce24; Tue, 16 Jul 2019 18:27:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 5/8] ACPI: PM: Set s2idle_wakeup earlier and clear it later
Date:   Tue, 16 Jul 2019 18:15:57 +0200
Message-ID: <5118596.pkUOanpXUM@kreacher>
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

The role of the s2idle_wakeup variable is to cause
acpi_pm_wakeup_event() and acpi_pm_notify_handler() to
increment pm_abort_suspend and trigger a wakeup from
suspend-to-idle in case the ACPI SCI wakeup was canceled
by acpi_s2idle_wake().

However, for this purpose it need not be set in acpi_s2idle_wake()
and cleared in acpi_s2idle_sync(), respectively.  In fact, it
may be set as early as in acpi_s2idle_prepare() and cleared as
late as in acpi_s2idle_restore(), so do that to allow subsequent
changes to be simpler.

This change is not expected to alter functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -972,6 +972,8 @@ static int acpi_s2idle_prepare(void)
 	/* Change the configuration of GPEs to avoid spurious wakeup. */
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
+
+	s2idle_wakeup = true;
 	return 0;
 }
 
@@ -991,7 +993,6 @@ static void acpi_s2idle_wake(void)
 	if (acpi_sci_irq_valid() &&
 	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
 		pm_system_cancel_wakeup();
-		s2idle_wakeup = true;
 		/*
 		 * On some platforms with the LPS0 _DSM device noirq resume
 		 * takes too much time for EC wakeup events to survive, so look
@@ -1012,11 +1013,12 @@ static void acpi_s2idle_sync(void)
 	acpi_os_wait_events_complete();	/* synchronize SCI IRQ handling */
 	acpi_ec_flush_work();
 	acpi_os_wait_events_complete();	/* synchronize Notify handling */
-	s2idle_wakeup = false;
 }
 
 static void acpi_s2idle_restore(void)
 {
+	s2idle_wakeup = false;
+
 	acpi_enable_all_runtime_gpes();
 
 	acpi_disable_wakeup_devices(ACPI_STATE_S0);



