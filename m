Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D747A58F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfG3KFv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:05:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58453 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbfG3KFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jul 2019 06:05:14 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 7a9f7e593ce976b8; Tue, 30 Jul 2019 12:05:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/8] ACPI: PM: s2idle: Eliminate acpi_sleep_no_ec_events()
Date:   Tue, 30 Jul 2019 12:01:44 +0200
Message-ID: <25240910.MlnzASiNL0@kreacher>
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

Change acpi_ec_suspend() to use pm_suspend_no_platform() instead of
acpi_sleep_no_ec_events(), which allows the latter to be eliminated
along with the s2idle_in_progress variable which is only used by it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New in v2.

---
 drivers/acpi/ec.c       |    2 +-
 drivers/acpi/internal.h |    2 --
 drivers/acpi/sleep.c    |    9 ---------
 3 files changed, 1 insertion(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1941,7 +1941,7 @@ static int acpi_ec_suspend(struct device
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
-	if (acpi_sleep_no_ec_events() && ec_freeze_events)
+	if (!pm_suspend_no_platform() && ec_freeze_events)
 		acpi_ec_disable_event(ec);
 	return 0;
 }
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -696,7 +696,6 @@ static const struct platform_suspend_ops
 	.recover = acpi_pm_finish,
 };
 
-static bool s2idle_in_progress;
 static bool s2idle_wakeup;
 
 /*
@@ -950,7 +949,6 @@ static struct acpi_scan_handler lps0_han
 static int acpi_s2idle_begin(void)
 {
 	acpi_scan_lock_acquire();
-	s2idle_in_progress = true;
 	return 0;
 }
 
@@ -1042,7 +1040,6 @@ static void acpi_s2idle_restore(void)
 
 static void acpi_s2idle_end(void)
 {
-	s2idle_in_progress = false;
 	acpi_scan_lock_release();
 }
 
@@ -1072,7 +1069,6 @@ static void acpi_sleep_suspend_setup(voi
 }
 
 #else /* !CONFIG_SUSPEND */
-#define s2idle_in_progress	(false)
 #define s2idle_wakeup		(false)
 #define lps0_device_handle	(NULL)
 static inline void acpi_sleep_suspend_setup(void) {}
@@ -1083,11 +1079,6 @@ bool acpi_s2idle_wakeup(void)
 	return s2idle_wakeup;
 }
 
-bool acpi_sleep_no_ec_events(void)
-{
-	return !s2idle_in_progress;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -210,11 +210,9 @@ void acpi_ec_flush_work(void);
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 extern bool acpi_s2idle_wakeup(void);
-extern bool acpi_sleep_no_ec_events(void);
 extern int acpi_sleep_init(void);
 #else
 static inline bool acpi_s2idle_wakeup(void) { return false; }
-static inline bool acpi_sleep_no_ec_events(void) { return true; }
 static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 



