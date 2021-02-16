Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA70031CFDA
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPSGO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 13:06:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:20535 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhBPSGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Feb 2021 13:06:12 -0500
IronPort-SDR: PLj0kUS2do1npY92+VLxfz/wGy+c5ftP4/nTkP824mFAEEIJjfLr+ObLoA7tkVDiaGmZtj7Ebx
 EN+4Z8mlhixQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170630574"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="170630574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:04:25 -0800
IronPort-SDR: i0cr3LxQxbAYuWEbjqkGKe4APMse6AY/KbVPOSZjlooScNtu7j2nmLp+aezh6AutPAxPyVbli8
 yjkWcrfBN6SA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="426560114"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.28.82])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:04:24 -0800
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <38ce39d2d4754d76934bb07370eff48b@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <5aa5115c-6c1e-700c-a758-c51760bfec47@linux.intel.com>
Date:   Tue, 16 Feb 2021 10:04:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <38ce39d2d4754d76934bb07370eff48b@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/3/21 3:32 AM, Song Bao Hua (Barry Song) wrote:

>>
>> Attached below are two RFC patches for creating x86 L2
>> cache sched domain, sans the idle cpu selection on wake up code.  It is
>> similar enough in concept to Barry's patch that we should have a
>> single patchset that accommodates both use cases.
> 
> Hi Tim, Agreed on this.
> hopefully the RFC v4 I am preparing will cover your case.
> 

Barry, 

I've taken a crack at it.  Attached is a patch on top of your
v3 patches to implement L2 cluster sched domain for x86.

Thanks.

Tim

---->8------

From 9189e489b019e110ee6e9d4183e243e48f44ff25 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 16 Feb 2021 08:24:39 -0800
Subject: [RFC PATCH] scheduler: Add cluster scheduler level for x86
To: <valentin.schneider@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>, <vincent.guittot@linaro.org>, <lenb@kernel.org>, <gregkh@linuxfoundation.org>, <jonathan.cameron@huawei.com>, <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, <mark.rutland@arm.com>, <sudeep.holla@arm.com>, <aubrey.li@linux.intel.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, <linuxarm@openeuler.org>, <xuwei5@huawei.com>, <prime.zeng@hisilicon.com>, <tiantao6@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>

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
---
 arch/x86/Kconfig                |  8 ++++++
 arch/x86/include/asm/smp.h      |  7 ++++++
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/cpu/cacheinfo.c |  1 +
 arch/x86/kernel/cpu/common.c    |  3 +++
 arch/x86/kernel/smpboot.c       | 43 ++++++++++++++++++++++++++++++++-
 6 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..10fc95005df7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1008,6 +1008,14 @@ config NR_CPUS
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
index c0538f82c9a2..9cbc4ae3078f 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -16,7 +16,9 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
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
index 9239399e5491..2a11ccc14fb1 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,6 +103,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
 
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3ca9be482a9e..0d03a71e713e 100644
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
index 35ad8480c464..fb08c73d752c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@ EXPORT_SYMBOL(smp_num_siblings);
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 117e24fbfd8a..b9e8780b2617 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
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
@@ -556,6 +582,9 @@ static struct sched_domain_topology_level x86_topology[] = {
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
2.20.1

