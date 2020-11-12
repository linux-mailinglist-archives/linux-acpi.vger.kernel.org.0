Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607052B0C8D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKLS0Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 13:26:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:58932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgKLS0X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 13:26:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91A4CB038;
        Thu, 12 Nov 2020 18:26:21 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v4 1/3] x86, sched: Calculate frequency invariance for AMD systems
Date:   Thu, 12 Nov 2020 19:26:12 +0100
Message-Id: <20201112182614.10700-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112182614.10700-1-ggherdovich@suse.cz>
References: <20201112182614.10700-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Nathan Fontenot <nathan.fontenot@amd.com>

This is the first pass in creating the ability to calculate the
frequency invariance on AMD systems. This approach uses the CPPC
highest performance and nominal performance values that range from
0 - 255 instead of a high and base frquency. This is because we do
not have the ability on AMD to get a highest frequency value.

On AMD systems the highest performance and nominal performance
vaues do correspond to the highest and base frequencies for the system
so using them should produce an appropriate ratio but some tweaking
is likely necessary.

Due to CPPC being initialized later in boot than when the frequency
invariant calculation is currently made, I had to create a callback
from the CPPC init code to do the calculation after we have CPPC
data.

Special thanks to "kernel test robot <lkp@intel.com>" for reporting that
compilation of drivers/acpi/cppc_acpi.c is conditional to
CONFIG_ACPI_CPPC_LIB, not just CONFIG_ACPI.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
[ ggherdovich@suse.cz: made safe under CPU hotplug, edited changelog ]
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/include/asm/topology.h |  8 ++++
 arch/x86/kernel/smpboot.c       | 76 ++++++++++++++++++++++++++++++---
 drivers/acpi/cppc_acpi.c        |  3 ++
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f4234575f3fd..f66691d34f4a 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,4 +218,12 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 #endif
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+void init_freq_invariance_cppc(void);
+#else
+static inline void init_freq_invariance_cppc(void)
+{
+}
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..a4ab5cf6aeab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,10 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+#endif
+
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -148,7 +152,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(bool secondary);
+static void init_freq_invariance(bool secondary, bool cppc_ready);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -186,7 +190,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance(true);
+	init_freq_invariance(true, false);
 
 	/*
 	 * Get our bogomips.
@@ -1340,7 +1344,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance(false);
+	init_freq_invariance(false, false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2027,6 +2031,46 @@ static bool intel_set_max_freq_ratio(void)
 	return true;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static bool amd_set_max_freq_ratio(void)
+{
+	struct cppc_perf_caps perf_caps;
+	u64 highest_perf, nominal_perf;
+	u64 perf_ratio;
+	int rc;
+
+	rc = cppc_get_perf_caps(0, &perf_caps);
+	if (rc) {
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		return false;
+	}
+
+	highest_perf = perf_caps.highest_perf;
+	nominal_perf = perf_caps.nominal_perf;
+
+	if (!highest_perf || !nominal_perf) {
+		pr_debug("Could not retrieve highest or nominal performance\n");
+		return false;
+	}
+
+	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	if (!perf_ratio) {
+		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = perf_ratio;
+	arch_set_max_freq_ratio(false);
+
+	return true;
+}
+#else
+static bool amd_set_max_freq_ratio(void)
+{
+	return false;
+}
+#endif
+
 static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
@@ -2038,7 +2082,7 @@ static void init_counter_refs(void)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(bool secondary)
+static void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
 
@@ -2054,6 +2098,12 @@ static void init_freq_invariance(bool secondary)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (!cppc_ready) {
+			return;
+		}
+		ret = amd_set_max_freq_ratio();
+	}
 
 	if (ret) {
 		init_counter_refs();
@@ -2063,6 +2113,22 @@ static void init_freq_invariance(bool secondary)
 	}
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static DEFINE_MUTEX(freq_invariance_lock);
+
+void init_freq_invariance_cppc(void)
+{
+	static bool secondary;
+
+	mutex_lock(&freq_invariance_lock);
+
+	init_freq_invariance(secondary, true);
+	secondary = true;
+
+	mutex_unlock(&freq_invariance_lock);
+}
+#endif
+
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
@@ -2112,7 +2178,7 @@ void arch_scale_freq_tick(void)
 	schedule_work(&disable_freq_invariance_work);
 }
 #else
-static inline void init_freq_invariance(bool secondary)
+static inline void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 }
 #endif /* CONFIG_X86_64 */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7a99b19bb893..368b13cb975d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,7 @@
 #include <linux/ktime.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/topology.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -850,6 +851,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
+	init_freq_invariance_cppc();
+
 	kfree(output.pointer);
 	return 0;
 
-- 
2.26.2

