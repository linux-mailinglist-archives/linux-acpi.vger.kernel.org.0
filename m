Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8556ACC0
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPQ1p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54735 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfGPQ1Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:16 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id b0f0202333839c8a; Tue, 16 Jul 2019 18:27:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 8/8] PM: sleep: Drop dpm_noirq_begin() and dpm_noirq_end()
Date:   Tue, 16 Jul 2019 18:21:40 +0200
Message-ID: <4184131.FIsGukcAIl@kreacher>
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

Note that after previous changes dpm_noirq_begin() and
dpm_noirq_end() each have only one caller, so move the code from
them to their respective callers and drop them.

Also note that dpm_noirq_resume_devices() and
dpm_noirq_suspend_devices() need not be exported any more, so make
them both static.

This change is not expected to alter functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   30 ++++++++++++------------------
 include/linux/pm.h        |    4 ----
 2 files changed, 12 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -716,7 +716,7 @@ static void async_resume_noirq(void *dat
 	put_device(dev);
 }
 
-void dpm_noirq_resume_devices(pm_message_t state)
+static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
 	ktime_t starttime = ktime_get();
@@ -760,13 +760,6 @@ void dpm_noirq_resume_devices(pm_message
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
 
-void dpm_noirq_end(void)
-{
-	resume_device_irqs();
-	device_wakeup_disarm_wake_irqs();
-	cpuidle_resume();
-}
-
 /**
  * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -777,7 +770,11 @@ void dpm_noirq_end(void)
 void dpm_resume_noirq(pm_message_t state)
 {
 	dpm_noirq_resume_devices(state);
-	dpm_noirq_end();
+
+	resume_device_irqs();
+	device_wakeup_disarm_wake_irqs();
+
+	cpuidle_resume();
 }
 
 static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
@@ -1357,14 +1354,7 @@ static int device_suspend_noirq(struct d
 	return __device_suspend_noirq(dev, pm_transition, false);
 }
 
-void dpm_noirq_begin(void)
-{
-	cpuidle_pause();
-	device_wakeup_arm_wake_irqs();
-	suspend_device_irqs();
-}
-
-int dpm_noirq_suspend_devices(pm_message_t state)
+static int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
 	int error = 0;
@@ -1421,7 +1411,11 @@ int dpm_suspend_noirq(pm_message_t state
 {
 	int ret;
 
-	dpm_noirq_begin();
+	cpuidle_pause();
+
+	device_wakeup_arm_wake_irqs();
+	suspend_device_irqs();
+
 	ret = dpm_noirq_suspend_devices(state);
 	if (ret)
 		dpm_resume_noirq(resume_event(state));
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -712,8 +712,6 @@ struct dev_pm_domain {
 extern void device_pm_lock(void);
 extern void dpm_resume_start(pm_message_t state);
 extern void dpm_resume_end(pm_message_t state);
-extern void dpm_noirq_resume_devices(pm_message_t state);
-extern void dpm_noirq_end(void);
 extern void dpm_resume_noirq(pm_message_t state);
 extern void dpm_resume_early(pm_message_t state);
 extern void dpm_resume(pm_message_t state);
@@ -722,8 +720,6 @@ extern void dpm_complete(pm_message_t st
 extern void device_pm_unlock(void);
 extern int dpm_suspend_end(pm_message_t state);
 extern int dpm_suspend_start(pm_message_t state);
-extern void dpm_noirq_begin(void);
-extern int dpm_noirq_suspend_devices(pm_message_t state);
 extern int dpm_suspend_noirq(pm_message_t state);
 extern int dpm_suspend_late(pm_message_t state);
 extern int dpm_suspend(pm_message_t state);



