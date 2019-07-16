Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1A6ACA6
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbfGPQ1Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44817 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfGPQ1Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:16 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 492423adba02cbe0; Tue, 16 Jul 2019 18:27:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 7/8] PM: sleep: Integrate suspend-to-idle with generig suspend flow
Date:   Tue, 16 Jul 2019 18:20:44 +0200
Message-ID: <4251553.8YHTM1NVoD@kreacher>
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

After previous changes the suspend-to-idle code flow can be
integrated more tightly with the generic system suspend code flow
by making suspend_enter() call s2idle_loop() later and removing
the direct invocations of dpm_noirq_begin(),
dpm_noirq_suspend_devices(), dpm_noirq_end(), and
dpm_noirq_resume_devices() from the latter, so do that.

This change is not expected to alter functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -119,13 +119,6 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
-	int error;
-
-	dpm_noirq_begin();
-	error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
-	if (error)
-		goto resume;
-
 	pm_pr_dbg("suspend-to-idle\n");
 
 	/*
@@ -150,10 +143,6 @@ static void s2idle_loop(void)
 	}
 
 	pm_pr_dbg("resume from suspend-to-idle\n");
-
-resume:
-	dpm_noirq_resume_devices(PMSG_RESUME);
-	dpm_noirq_end();
 }
 
 void s2idle_wake(void)
@@ -408,11 +397,6 @@ static int suspend_enter(suspend_state_t
 	if (error)
 		goto Devices_early_resume;
 
-	if (state == PM_SUSPEND_TO_IDLE && pm_test_level != TEST_PLATFORM) {
-		s2idle_loop();
-		goto Platform_early_resume;
-	}
-
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		pr_err("noirq suspend of devices failed\n");
@@ -425,6 +409,11 @@ static int suspend_enter(suspend_state_t
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
+	if (state == PM_SUSPEND_TO_IDLE) {
+		s2idle_loop();
+		goto Platform_wake;
+	}
+
 	error = suspend_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;



