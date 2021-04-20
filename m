Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED05364F78
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 02:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhDTA1C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 20:27:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhDTA1C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 20:27:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FPPYG6wX6zPrjD;
        Tue, 20 Apr 2021 08:23:30 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.79) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 08:26:20 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <tim.c.chen@linux.intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>,
        <vincent.guittot@linaro.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <lenb@kernel.org>, <peterz@infradead.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <msys.mizuma@gmail.com>, <valentin.schneider@arm.com>,
        <gregkh@linuxfoundation.org>, <jonathan.cameron@huawei.com>,
        <juri.lelli@redhat.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <aubrey.li@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>, <xuwei5@huawei.com>, <prime.zeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <yangyicong@huawei.com>,
        <liguozhu@hisilicon.com>, <linuxarm@openeuler.org>,
        <hpa@zytor.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v6 4/4] scheduler: Add cluster scheduler level for x86
Date:   Tue, 20 Apr 2021 12:18:44 +1200
Message-ID: <20210420001844.9116-5-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.79]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
is shared among a cluster of cores instead of being exclusive
to one single core.

To prevent oversubscription of L2 cache, load should be
balanced between such L2 clusters, especially for tasks with
no shared data.

Also with cluster scheduling policy where tasks are woken up
in the same L2 cluster, we will benefit from keeping tasks
related to each other and likely sharing data in the same L2
cluster.

Add CPU masks of CPUs sharing the L2 cache so we can build such
L2 cluster scheduler domain.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v6:
  * added topology_cluster_cpumask() for x86, code provided by Tim.

 arch/x86/Kconfig                |  8 ++++++++
 arch/x86/include/asm/smp.h      |  7 +++++++
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/cpu/cacheinfo.c |  1 +
 arch/x86/kernel/cpu/common.c    |  3 +++
 arch/x86/kernel/smpboot.c       | 43 ++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..d597de2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1002,6 +1002,14 @@ config NR_CPUS
 	  This is purely to save memory: each supported CPU adds about 8KB
 	  to the kernel image.
 
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	default n
+	help
+	 Cluster scheduler support improves the CPU scheduler's decision
+	 making when dealing with machines that have clusters of CPUs
+	 sharing L2 cache. If unsure say N here.
+
 config SCHED_SMT
 	def_bool y if SMP
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index c0538f8..9cbc4ae 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -16,7 +16,9 @@
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
+DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
@@ -24,6 +26,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return per_cpu(cpu_llc_shared_map, cpu);
 }
 
+static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
+{
+	return per_cpu(cpu_l2c_shared_map, cpu);
+}
+
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9239399..800fa48 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,6 +103,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
 
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
@@ -114,6 +115,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 
 #ifdef CONFIG_SMP
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
+#define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3ca9be4..0d03a71 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -846,6 +846,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		l2 = new_l2;
 #ifdef CONFIG_SMP
 		per_cpu(cpu_llc_id, cpu) = l2_id;
+		per_cpu(cpu_l2c_id, cpu) = l2_id;
 #endif
 	}
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640ab..0ba282d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7..c85ffa8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@
 
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
+
 /* Per CPU bogomips and other parameters */
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
@@ -501,6 +503,21 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return topology_sane(c, o, "llc");
 }
 
+static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
+
+	/* Do not match if we do not have a valid APICID for cpu: */
+	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
+		return false;
+
+	/* Do not match if L2 cache id does not match: */
+	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
+		return false;
+
+	return topology_sane(c, o, "l2c");
+}
+
 /*
  * Unlike the other levels, we do not enforce keeping a
  * multicore group inside a NUMA node.  If this happens, we will
@@ -522,7 +539,7 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
+#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -540,12 +557,21 @@ static int x86_smt_flags(void)
 	return cpu_smt_flags() | x86_sched_itmt_flags();
 }
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+static int x86_cluster_flags(void)
+{
+	return cpu_cluster_flags() | x86_sched_itmt_flags();
+}
+#endif
 #endif
 
 static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -556,6 +582,9 @@ static int x86_smt_flags(void)
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -583,6 +612,7 @@ void set_cpu_sibling_map(int cpu)
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
+		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
@@ -598,6 +628,8 @@ void set_cpu_sibling_map(int cpu)
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
 
+		if ((i == cpu) || (has_mp && match_l2c(c, o)))
+			link_mask(cpu_l2c_shared_mask, cpu, i);
 	}
 
 	/*
@@ -649,6 +681,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return cpu_llc_shared_mask(cpu);
 }
 
+const struct cpumask *cpu_clustergroup_mask(int cpu)
+{
+	return cpu_l2c_shared_mask(cpu);
+}
+
 static void impress_friends(void)
 {
 	int cpu;
@@ -1332,6 +1369,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
 
 	/*
@@ -1556,7 +1594,10 @@ static void remove_siblinginfo(int cpu)
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
+		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
+	cpumask_clear(cpu_l2c_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
-- 
1.8.3.1

