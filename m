Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163021187DA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLJMNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 07:13:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49526 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfLJMNb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 07:13:31 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 0a5678278498855a; Tue, 10 Dec 2019 13:13:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 8/9] intel_idle: Use ACPI _CST for selected known processors
Date:   Tue, 10 Dec 2019 13:13:04 +0100
Message-ID: <2165961.YlpjWumQq8@kreacher>
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

Update the intel_idle driver to get the C-states information from ACPI
_CST in some cases in which the processor is known to the driver, as long as
that information is available and the new use_acpi flag is set in the
profile of the processor in question.

In the cases when there is a specific table of C-states for the given
processor in the driver, that table is used as the primary source of
information on the available C-states, but if ACPI _CST is present,
the C-states that are not listed by it will not be enabled by default
(they still can be enabled later by user space via sysfs, though).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -80,6 +80,7 @@ struct idle_cpu {
 	unsigned long auto_demotion_disable_flags;
 	bool byt_auto_demotion_disable_flag;
 	bool disable_promotion_to_c1e;
+	bool use_acpi;
 };
 
 static const struct idle_cpu *icpu;
@@ -91,6 +92,11 @@ static void intel_idle_s2idle(struct cpu
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
+ * Enable this state by default even if the ACPI _CST does not list it.
+ */
+#define CPUIDLE_FLAG_IGNORE_ACPI	BIT(15)
+
+/*
  * Set this flag for states where the HW flushes the TLB for us
  * and so we don't need cross-calls to keep it consistent.
  * If this flag is set, SW flushes the TLB, so even if the
@@ -1221,9 +1227,33 @@ static void intel_idle_init_cstates_acpi
 		state->enter_s2idle = intel_idle_s2idle;
 	}
 }
+
+static bool intel_idle_off_by_default(u32 mwait_hint)
+{
+	int cstate, limit;
+
+	/*
+	 * If there are no _CST C-states, do not disable any C-states by
+	 * default.
+	 */
+	if (!acpi_state_table.count)
+		return false;
+
+	limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
+	/*
+	 * If limit > 0, intel_idle_cst_usable() has returned 'true', so all of
+	 * the interesting states are ACPI_CSTATE_FFH.
+	 */
+	for (cstate = 1; cstate < limit; cstate++) {
+		if (acpi_state_table.states[cstate].address == mwait_hint)
+			return false;
+	}
+	return true;
+}
 #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
+static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
 /*
@@ -1264,10 +1294,13 @@ static int __init intel_idle_probe(void)
 	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
-	if (icpu)
+	if (icpu) {
 		cpuidle_state_table = icpu->state_table;
-	else if (!intel_idle_acpi_cst_extract())
+		if (icpu->use_acpi)
+			intel_idle_acpi_cst_extract();
+	} else if (!intel_idle_acpi_cst_extract()) {
 		return -ENODEV;
+	}
 
 	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
 		 boot_cpu_data.x86_model);
@@ -1475,7 +1508,13 @@ static void intel_idle_init_cstates_icpu
 			continue;
 
 		/* Structure copy. */
-		drv->states[drv->state_count++] = cpuidle_state_table[cstate];
+		drv->states[drv->state_count] = cpuidle_state_table[cstate];
+
+		if (icpu->use_acpi && intel_idle_off_by_default(mwait_hint) &&
+		    !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IGNORE_ACPI))
+			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
+
+		drv->state_count++;
 	}
 
 	if (icpu->byt_auto_demotion_disable_flag) {



