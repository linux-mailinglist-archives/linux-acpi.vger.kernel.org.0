Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F381187D6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLJMNe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 07:13:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57785 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLJMNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 07:13:33 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 13df9256bad9aa3c; Tue, 10 Dec 2019 13:13:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 5/9] intel_idle: Refactor intel_idle_cpuidle_driver_init()
Date:   Tue, 10 Dec 2019 13:03:01 +0100
Message-ID: <12822878.tX331RTXvW@kreacher>
In-Reply-To: <35821518.IbFVMVmUy3@kreacher>
References: <35821518.IbFVMVmUy3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the C-state verification and checks from
intel_idle_cpuidle_driver_init() to a separate function,
intel_idle_verify_cstate(), and make the former call it after
checking the CPUIDLE_FLAG_UNUSABLE state flag.

Also combine the drv->states[] updates with the incrementation of
drv->state_count.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the previous version.

---
 drivers/idle/intel_idle.c |   49 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -944,6 +944,22 @@ static void intel_idle_s2idle(struct cpu
 	mwait_idle_with_hints(eax, ecx);
 }
 
+static bool intel_idle_verify_cstate(unsigned int mwait_hint)
+{
+	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
+	unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
+					MWAIT_SUBSTATE_MASK;
+
+	/* Ignore the C-state if there are NO sub-states in CPUID for it. */
+	if (num_substates == 0)
+		return false;
+
+	if (mwait_cstate > 2 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		mark_tsc_unstable("TSC halts in idle states deeper than C2");
+
+	return true;
+}
+
 static void __setup_broadcast_timer(bool on)
 {
 	if (on)
@@ -1332,10 +1348,10 @@ static void __init intel_idle_cpuidle_dr
 	drv->state_count = 1;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-		int num_substates, mwait_hint, mwait_cstate;
+		unsigned int mwait_hint;
 
-		if ((cpuidle_state_table[cstate].enter == NULL) &&
-		    (cpuidle_state_table[cstate].enter_s2idle == NULL))
+		if (!cpuidle_state_table[cstate].enter &&
+		    !cpuidle_state_table[cstate].enter_s2idle)
 			break;
 
 		if (cstate + 1 > max_cstate) {
@@ -1343,34 +1359,19 @@ static void __init intel_idle_cpuidle_dr
 			break;
 		}
 
-		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
-		mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint);
-
-		/* number of sub-states for this state in CPUID.MWAIT */
-		num_substates = (mwait_substates >> ((mwait_cstate + 1) * 4))
-					& MWAIT_SUBSTATE_MASK;
-
-		/* if NO sub-states for this state in CPUID, skip it */
-		if (num_substates == 0)
-			continue;
-
-		/* if state marked as disabled, skip it */
+		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",
 				 cpuidle_state_table[cstate].name);
 			continue;
 		}
 
+		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
+		if (!intel_idle_verify_cstate(mwait_hint))
+			continue;
 
-		if (((mwait_cstate + 1) > 2) &&
-			!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
-			mark_tsc_unstable("TSC halts in idle"
-					" states deeper than C2");
-
-		drv->states[drv->state_count] =	/* structure copy */
-			cpuidle_state_table[cstate];
-
-		drv->state_count += 1;
+		/* Structure copy. */
+		drv->states[drv->state_count++] = cpuidle_state_table[cstate];
 	}
 
 	if (icpu->byt_auto_demotion_disable_flag) {



