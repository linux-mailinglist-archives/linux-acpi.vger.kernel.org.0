Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F11187C4
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 13:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJMNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 07:13:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41772 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLJMNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 07:13:32 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 785dde6ab70efc65; Tue, 10 Dec 2019 13:13:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 6/9] intel_idle: Use ACPI _CST for processor models without C-state tables
Date:   Tue, 10 Dec 2019 13:06:25 +0100
Message-ID: <3789365.7kqZenubyC@kreacher>
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

Modify the intel_idle driver to get the C-states information from ACPI
_CST if the processor model is not recognized by it.

The processor is still required to support MWAIT and the information
from ACPI _CST will only be used if all of the C-states listed by
_CST are of the ACPI_CSTATE_FFH type (which means that they are
expected to be entered via MWAIT).

Moreover, the driver assumes that the _CST information is the same
for all CPUs in the system, so it is sufficient to evaluate _CST for
one of them and extract the common list of C-states from there.
Also _CST is evaluated once at the system initialization time and
the driver does not respond to _CST change notifications (that can
be changed in the future).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from the previous version:

 - Append "_ACPI" to the names of the C-states coming from _CST.
 - For ACPI C-states types other than C1 set target_residency as 4 times
   the exit latency (which is closer to the numbers used by intel_idle for
   "known" processors).

---
 drivers/idle/intel_idle.c |  181 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 153 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -41,6 +41,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
 #include <linux/tick.h>
@@ -1111,6 +1112,120 @@ static const struct x86_cpu_id intel_idl
 	{}
 };
 
+#define INTEL_CPU_FAM6_MWAIT \
+	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_MWAIT, 0 }
+
+static const struct x86_cpu_id intel_mwait_ids[] __initconst = {
+	INTEL_CPU_FAM6_MWAIT,
+	{}
+};
+
+static bool intel_idle_max_cstate_reached(int cstate)
+{
+	if (cstate + 1 > max_cstate) {
+		pr_info("max_cstate %d reached\n", max_cstate);
+		return true;
+	}
+	return false;
+}
+
+#ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+#include <acpi/processor.h>
+
+static struct acpi_processor_power acpi_state_table;
+
+/**
+ * intel_idle_cst_usable - Check if the _CST information can be used.
+ *
+ * Check if all of the C-states listed by _CST in the max_cstate range are
+ * ACPI_CSTATE_FFH, which means that they should be entered via MWAIT.
+ */
+static bool intel_idle_cst_usable(void)
+{
+	int cstate, limit;
+
+	limit = min_t(int, min_t(int, CPUIDLE_STATE_MAX, max_cstate + 1),
+		      acpi_state_table.count);
+
+	for (cstate = 1; cstate < limit; cstate++) {
+		struct acpi_processor_cx *cx = &acpi_state_table.states[cstate];
+
+		if (cx->entry_method != ACPI_CSTATE_FFH)
+			return false;
+	}
+
+	return true;
+}
+
+static bool intel_idle_acpi_cst_extract(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct acpi_processor *pr = per_cpu(processors, cpu);
+
+		if (!pr)
+			continue;
+
+		if (acpi_processor_evaluate_cst(pr->handle, cpu, &acpi_state_table))
+			continue;
+
+		acpi_state_table.count++;
+
+		if (!intel_idle_cst_usable())
+			continue;
+
+		if (!acpi_processor_claim_cst_control()) {
+			acpi_state_table.count = 0;
+			return false;
+		}
+
+		return true;
+	}
+
+	pr_debug("ACPI _CST not found or not usable\n");
+	return false;
+}
+
+static void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
+{
+	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
+
+	/*
+	 * If limit > 0, intel_idle_cst_usable() has returned 'true', so all of
+	 * the interesting states are ACPI_CSTATE_FFH.
+	 */
+	for (cstate = 1; cstate < limit; cstate++) {
+		struct acpi_processor_cx *cx;
+		struct cpuidle_state *state;
+
+		if (intel_idle_max_cstate_reached(cstate))
+			break;
+
+		cx = &acpi_state_table.states[cstate];
+
+		state = &drv->states[drv->state_count++];
+
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d_ACPI", cstate);
+		strlcpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
+		state->exit_latency = cx->latency;
+		state->target_residency = cx->latency;
+		if (cx->type > ACPI_STATE_C1)
+			state->target_residency *= 4;
+
+		state->flags = MWAIT2flg(cx->address);
+		if (cx->type > ACPI_STATE_C2)
+			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
+
+		state->enter = intel_idle;
+		state->enter_s2idle = intel_idle_s2idle;
+	}
+}
+#else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
+static inline bool intel_idle_acpi_cst_extract(void) { return false; }
+static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
+#endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
+
 /*
  * intel_idle_probe()
  */
@@ -1125,17 +1240,15 @@ static int __init intel_idle_probe(void)
 	}
 
 	id = x86_match_cpu(intel_idle_ids);
-	if (!id) {
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-		    boot_cpu_data.x86 == 6)
-			pr_debug("does not run on family %d model %d\n",
-				 boot_cpu_data.x86, boot_cpu_data.x86_model);
-		return -ENODEV;
-	}
-
-	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
-		pr_debug("Please enable MWAIT in BIOS SETUP\n");
-		return -ENODEV;
+	if (id) {
+		if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+			pr_debug("Please enable MWAIT in BIOS SETUP\n");
+			return -ENODEV;
+		}
+	} else {
+		id = x86_match_cpu(intel_mwait_ids);
+		if (!id)
+			return -ENODEV;
 	}
 
 	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
@@ -1151,7 +1264,10 @@ static int __init intel_idle_probe(void)
 	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
-	cpuidle_state_table = icpu->state_table;
+	if (icpu)
+		cpuidle_state_table = icpu->state_table;
+	else if (!intel_idle_acpi_cst_extract())
+		return -ENODEV;
 
 	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
 		 boot_cpu_data.x86_model);
@@ -1333,31 +1449,19 @@ static void intel_idle_state_table_updat
 	}
 }
 
-/*
- * intel_idle_cpuidle_driver_init()
- * allocate, initialize cpuidle_states
- */
-static void __init intel_idle_cpuidle_driver_init(void)
+static void intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
-	struct cpuidle_driver *drv = &intel_idle_driver;
-
-	intel_idle_state_table_update();
-
-	cpuidle_poll_state_init(drv);
-	drv->state_count = 1;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
 		unsigned int mwait_hint;
 
-		if (!cpuidle_state_table[cstate].enter &&
-		    !cpuidle_state_table[cstate].enter_s2idle)
+		if (intel_idle_max_cstate_reached(cstate))
 			break;
 
-		if (cstate + 1 > max_cstate) {
-			pr_info("max_cstate %d reached\n", max_cstate);
+		if (!cpuidle_state_table[cstate].enter &&
+		    !cpuidle_state_table[cstate].enter_s2idle)
 			break;
-		}
 
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
@@ -1380,6 +1484,24 @@ static void __init intel_idle_cpuidle_dr
 	}
 }
 
+/*
+ * intel_idle_cpuidle_driver_init()
+ * allocate, initialize cpuidle_states
+ */
+static void __init intel_idle_cpuidle_driver_init(void)
+{
+	struct cpuidle_driver *drv = &intel_idle_driver;
+
+	intel_idle_state_table_update();
+
+	cpuidle_poll_state_init(drv);
+	drv->state_count = 1;
+
+	if (icpu)
+		intel_idle_init_cstates_icpu(drv);
+	else
+		intel_idle_init_cstates_acpi(drv);
+}
 
 /*
  * intel_idle_cpu_init()
@@ -1398,6 +1520,9 @@ static int intel_idle_cpu_init(unsigned
 		return -EIO;
 	}
 
+	if (!icpu)
+		return 0;
+
 	if (icpu->auto_demotion_disable_flags)
 		auto_demotion_disable();
 



