Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B771B400B88
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhIDNyx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Sep 2021 09:54:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47782 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhIDNyw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Sep 2021 09:54:52 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 30a6f13132b31d28; Sat, 4 Sep 2021 15:53:49 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 05E4266A3B0;
        Sat,  4 Sep 2021 15:53:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: hybrid: Rework HWP calibration
Date:   Sat, 04 Sep 2021 15:53:39 +0200
Message-ID: <2226916.ElGaqSPkdT@kreacher>
In-Reply-To: <11837325.O9o76ZdvQC@kreacher>
References: <11837325.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhi
 rdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current HWP calibration for hybrid processors in intel_pstate is
fragile, because it depends too much on the information provided by
the platform firmware via CPPC which may not be reliable enough.  It
also need not be so complicated.

In order to improve that mechanism and make it more resistant to
platform firmware issues, make it only use the CPPC nominal_perf
values to compute the HWP-to-frequency scaling factors for all
CPUs and possibly use the HWP_CAP highest_perf values to recompute
them if the ones derived from the CPPC nominal_perf values alone
appear to be too high.

Namely, fetch CPC.nominal_perf for all CPUs present in the system,
find the minimum one and use it as a reference for computing all of
the CPUs' scaling factors (using the observation that for the CPUs
having the minimum CPC.nominal_perf the HWP range of available
performance levels should be the same as the range of available
"legacy" P-states and so the HWP-to-frequency scaling factor for
them should be the same as the corresponding scaling factor used
for representing the P-state values in kHz).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  185 +++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 114 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -271,6 +271,7 @@ static struct cpudata **all_cpu_data;
  * @get_min:		Callback to get minimum P state
  * @get_turbo:		Callback to get turbo P state
  * @get_scaling:	Callback to get frequency scaling factor
+ * @get_cpu_scaling:	Get frequency scaling factor for a given cpu
  * @get_aperf_mperf_shift: Callback to get the APERF vs MPERF frequency difference
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
@@ -284,6 +285,7 @@ struct pstate_funcs {
 	int (*get_min)(void);
 	int (*get_turbo)(void);
 	int (*get_scaling)(void);
+	int (*get_cpu_scaling)(int cpu);
 	int (*get_aperf_mperf_shift)(void);
 	u64 (*get_val)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
@@ -387,6 +389,15 @@ static int intel_pstate_get_cppc_guarant
 	return cppc_perf.nominal_perf;
 }
 
+static u32 intel_pstate_cppc_nominal(int cpu)
+{
+	u64 nominal_perf;
+
+	if (cppc_get_nominal_perf(cpu, &nominal_perf))
+		return 0;
+
+	return nominal_perf;
+}
 #else /* CONFIG_ACPI_CPPC_LIB */
 static inline void intel_pstate_set_itmt_prio(int cpu)
 {
@@ -473,20 +484,6 @@ static void intel_pstate_exit_perf_limit
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-
-static bool intel_pstate_cppc_perf_valid(u32 perf, struct cppc_perf_caps *caps)
-{
-	return perf && perf <= caps->highest_perf && perf >= caps->lowest_perf;
-}
-
-static bool intel_pstate_cppc_perf_caps(struct cpudata *cpu,
-					struct cppc_perf_caps *caps)
-{
-	if (cppc_get_perf_caps(cpu->cpu, caps))
-		return false;
-
-	return caps->highest_perf && caps->lowest_perf <= caps->highest_perf;
-}
 #else /* CONFIG_ACPI */
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -509,15 +506,8 @@ static inline int intel_pstate_get_cppc_
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
-static void intel_pstate_hybrid_hwp_perf_ctl_parity(struct cpudata *cpu)
-{
-	pr_debug("CPU%d: Using PERF_CTL scaling for HWP\n", cpu->cpu);
-
-	cpu->pstate.scaling = cpu->pstate.perf_ctl_scaling;
-}
-
 /**
- * intel_pstate_hybrid_hwp_calibrate - Calibrate HWP performance levels.
+ * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
  *
  * On hybrid processors, HWP may expose more performance levels than there are
@@ -525,115 +515,46 @@ static void intel_pstate_hybrid_hwp_perf
  * scaling factor between HWP performance levels and CPU frequency will be less
  * than the scaling factor between P-state values and CPU frequency.
  *
- * In that case, the scaling factor between HWP performance levels and CPU
- * frequency needs to be determined which can be done with the help of the
- * observation that certain HWP performance levels should correspond to certain
- * P-states, like for example the HWP highest performance should correspond
- * to the maximum turbo P-state of the CPU.
+ * In that case, adjust the CPU parameters used in computations accordingly.
  */
-static void intel_pstate_hybrid_hwp_calibrate(struct cpudata *cpu)
+static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo();
 	int turbo_freq = perf_ctl_turbo * perf_ctl_scaling;
-	int perf_ctl_max = pstate_funcs.get_max();
-	int max_freq = perf_ctl_max * perf_ctl_scaling;
-	int scaling = INT_MAX;
-	int freq;
+	int scaling = cpu->pstate.scaling;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
-	pr_debug("CPU%d: perf_ctl_max = %d\n", cpu->cpu, perf_ctl_max);
+	pr_debug("CPU%d: perf_ctl_max = %d\n", cpu->cpu, pstate_funcs.get_max());
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
 	pr_debug("CPU%d: perf_ctl_scaling = %d\n", cpu->cpu, perf_ctl_scaling);
-
 	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
 	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpu->cpu, cpu->pstate.turbo_pstate);
-
-#ifdef CONFIG_ACPI
-	if (IS_ENABLED(CONFIG_ACPI_CPPC_LIB)) {
-		struct cppc_perf_caps caps;
-
-		if (intel_pstate_cppc_perf_caps(cpu, &caps)) {
-			if (intel_pstate_cppc_perf_valid(caps.nominal_perf, &caps)) {
-				pr_debug("CPU%d: Using CPPC nominal\n", cpu->cpu);
-
-				/*
-				 * If the CPPC nominal performance is valid, it
-				 * can be assumed to correspond to cpu_khz.
-				 */
-				if (caps.nominal_perf == perf_ctl_max_phys) {
-					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-					return;
-				}
-				scaling = DIV_ROUND_UP(cpu_khz, caps.nominal_perf);
-			} else if (intel_pstate_cppc_perf_valid(caps.guaranteed_perf, &caps)) {
-				pr_debug("CPU%d: Using CPPC guaranteed\n", cpu->cpu);
-
-				/*
-				 * If the CPPC guaranteed performance is valid,
-				 * it can be assumed to correspond to max_freq.
-				 */
-				if (caps.guaranteed_perf == perf_ctl_max) {
-					intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-					return;
-				}
-				scaling = DIV_ROUND_UP(max_freq, caps.guaranteed_perf);
-			}
-		}
-	}
-#endif
-	/*
-	 * If using the CPPC data to compute the HWP-to-frequency scaling factor
-	 * doesn't work, use the HWP_CAP gauranteed perf for this purpose with
-	 * the assumption that it corresponds to max_freq.
-	 */
-	if (scaling > perf_ctl_scaling) {
-		pr_debug("CPU%d: Using HWP_CAP guaranteed\n", cpu->cpu);
-
-		if (cpu->pstate.max_pstate == perf_ctl_max) {
-			intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-			return;
-		}
-		scaling = DIV_ROUND_UP(max_freq, cpu->pstate.max_pstate);
-		if (scaling > perf_ctl_scaling) {
-			/*
-			 * This should not happen, because it would mean that
-			 * the number of HWP perf levels was less than the
-			 * number of P-states, so use the PERF_CTL scaling in
-			 * that case.
-			 */
-			pr_debug("CPU%d: scaling (%d) out of range\n", cpu->cpu,
-				scaling);
-
-			intel_pstate_hybrid_hwp_perf_ctl_parity(cpu);
-			return;
-		}
-	}
+	pr_debug("CPU%d: HWP-to-frequency scaling factor: %d\n", cpu->cpu, scaling);
 
 	/*
-	 * If the product of the HWP performance scaling factor obtained above
-	 * and the HWP_CAP highest performance is greater than the maximum turbo
-	 * frequency corresponding to the pstate_funcs.get_turbo() return value,
-	 * the scaling factor is too high, so recompute it so that the HWP_CAP
-	 * highest performance corresponds to the maximum turbo frequency.
+	 * If the product of the HWP performance scaling factor and the HWP_CAP
+	 * highest performance is greater than the maximum turbo frequency
+	 * corresponding to the pstate_funcs.get_turbo() return value, the
+	 * scaling factor is too high, so recompute it to make the HWP_CAP
+	 * highest performance correspond to the maximum turbo frequency.
 	 */
 	if (turbo_freq < cpu->pstate.turbo_pstate * scaling) {
-		pr_debug("CPU%d: scaling too high (%d)\n", cpu->cpu, scaling);
-
 		cpu->pstate.turbo_freq = turbo_freq;
 		scaling = DIV_ROUND_UP(turbo_freq, cpu->pstate.turbo_pstate);
-	}
+		cpu->pstate.scaling = scaling;
 
-	cpu->pstate.scaling = scaling;
-
-	pr_debug("CPU%d: HWP-to-frequency scaling factor: %d\n", cpu->cpu, scaling);
+		pr_debug("CPU%d: refined HWP-to-frequency scaling factor: %d\n",
+			 cpu->cpu, scaling);
+	}
 
 	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
 					 perf_ctl_scaling);
 
-	freq = perf_ctl_max_phys * perf_ctl_scaling;
-	cpu->pstate.max_pstate_physical = DIV_ROUND_UP(freq, scaling);
+	cpu->pstate.max_pstate_physical =
+			DIV_ROUND_UP(perf_ctl_max_phys * perf_ctl_scaling,
+				     scaling);
 
 	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
 	/*
@@ -1900,6 +1821,38 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static u32 hybrid_ref_perf;
+
+static int hybrid_get_cpu_scaling(int cpu)
+{
+	return DIV_ROUND_UP(core_get_scaling() * hybrid_ref_perf,
+			    intel_pstate_cppc_nominal(cpu));
+}
+
+static void intel_pstate_cppc_set_cpu_scaling(void)
+{
+	u32 min_nominal_perf = U32_MAX;
+	int cpu;
+
+	for_each_present_cpu(cpu) {
+		u32 nominal_perf = intel_pstate_cppc_nominal(cpu);
+
+		if (nominal_perf && nominal_perf < min_nominal_perf)
+			min_nominal_perf = nominal_perf;
+	}
+
+	if (min_nominal_perf < U32_MAX) {
+		hybrid_ref_perf = min_nominal_perf;
+		pstate_funcs.get_cpu_scaling = hybrid_get_cpu_scaling;
+	}
+}
+#else
+static inline void intel_pstate_cppc_set_cpu_scaling(void)
+{
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
+
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
@@ -1928,10 +1881,8 @@ static void intel_pstate_max_within_limi
 
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
-	bool hybrid_cpu = boot_cpu_has(X86_FEATURE_HYBRID_CPU);
 	int perf_ctl_max_phys = pstate_funcs.get_max_physical();
-	int perf_ctl_scaling = hybrid_cpu ? cpu_khz / perf_ctl_max_phys :
-					    pstate_funcs.get_scaling();
+	int perf_ctl_scaling = pstate_funcs.get_scaling();
 
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
 	cpu->pstate.max_pstate_physical = perf_ctl_max_phys;
@@ -1940,10 +1891,13 @@ static void intel_pstate_get_cpu_pstates
 	if (hwp_active && !hwp_mode_bdw) {
 		__intel_pstate_get_hwp_cap(cpu);
 
-		if (hybrid_cpu)
-			intel_pstate_hybrid_hwp_calibrate(cpu);
-		else
+		if (pstate_funcs.get_cpu_scaling) {
+			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
+			if (cpu->pstate.scaling != perf_ctl_scaling)
+				intel_pstate_hybrid_hwp_adjust(cpu);
+		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
+		}
 	} else {
 		cpu->pstate.scaling = perf_ctl_scaling;
 		cpu->pstate.max_pstate = pstate_funcs.get_max();
@@ -3315,6 +3269,9 @@ static int __init intel_pstate_init(void
 			if (!default_driver)
 				default_driver = &intel_pstate;
 
+			if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
+				intel_pstate_cppc_set_cpu_scaling();
+
 			goto hwp_cpu_matched;
 		}
 	} else {



