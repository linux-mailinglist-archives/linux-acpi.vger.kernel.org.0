Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414283F2460
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 03:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhHTBcQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 21:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhHTBcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 21:32:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D8C061756;
        Thu, 19 Aug 2021 18:31:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e15so5036763plh.8;
        Thu, 19 Aug 2021 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpwXYPGrdUyHfCFhqx+kZsq3lqAhvEQ8pq1pJIfmhaA=;
        b=MoY7g6rmnw7kQ3VJRlov8sZWGScSvvu1nvVrW/A9qdTAEgrKkphH/fjLuAG8oE2H3a
         7L/EyYnSuTOThD/85quNqbIGHMCShe7GruNI74wpEU5Z5KqdJVjOOmT1xthwiAEPmbF7
         imPiHG3NAkE2euep2ogofK7X9LiCZA5Ph1JPEJ1YSYyuxyA2oQtovwj8RjeMAKL0S/cG
         a/ct/X8QKxXDjhB4hi2E1XB0cWGnQdSZn0Wvo6S64u/9FZb4/LISH6gcwUrmGHSW1ZGP
         kl/F/TLmIaN9dnjg2LunIUzFSS8fGZ4i1q6LSL6K1aNnBwWuJ3+bS2xHCkqEgdzB88fL
         aSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpwXYPGrdUyHfCFhqx+kZsq3lqAhvEQ8pq1pJIfmhaA=;
        b=TwfEcRcEZAtAt26nI0cfCFo/nbbt4HfFu3+cwjWp4OKZRCgfdzjI1suUrW5cRRVzrh
         4VXgn5hR/AomEtPwbtryMz7xl4zWbVwEjZG5IBuMxoTY0JeRdn4ioY2o0Fo4BZ8X42DD
         4S+ejcULQJm9rZQqHlIHdocM3HL+6KJ8wB2xkjqoQuzMvS86s1qJBP3N4IfCMjcGflV5
         f1kWj7Tm13ymHiUXBOlxj8nhm2F9fZTXG7I/iMrVM2ubAGdXYMZIYcLtEEOQwMIOqKq2
         MSgjaCI7azQXSNXMFJ1JSiXWxgnyzaMhFp2INqkpNMHaI/hLj12FDlSSMInx5BOH9Kzj
         iuxw==
X-Gm-Message-State: AOAM532L4GZnURlnnH4TroOKzt/Mdzb23oxL8fhM/N7F7PVpLrGKD+rt
        SVcoc2i01XLmRV7bROKJwOk=
X-Google-Smtp-Source: ABdhPJzjtnKPlerk8Z12YLYd6mvDfpXGfHlmPvVzrGSIuu733FpZvS6rSLq4D+xYhHXxJ5+Ns65mDA==
X-Received: by 2002:a17:902:c60b:b029:12d:4ea3:34a5 with SMTP id r11-20020a170902c60bb029012d4ea334a5mr14351804plr.34.1629423093591;
        Thu, 19 Aug 2021 18:31:33 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:d23:7118:c805:b5a5])
        by smtp.gmail.com with ESMTPSA id 66sm4877950pfu.67.2021.08.19.18.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 18:31:33 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bp@alien8.de, catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, juri.lelli@redhat.com,
        bristot@redhat.com, lenb@kernel.org, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        sudeep.holla@arm.com, tglx@linutronix.de
Cc:     aubrey.li@linux.intel.com, bsegall@google.com,
        guodong.xu@linaro.org, jonathan.cameron@huawei.com,
        liguozhu@hisilicon.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rostedt@goodmis.org,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, will@kernel.org, x86@kernel.org,
        xuwei5@huawei.com, yangyicong@huawei.com, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 3/3] scheduler: Add cluster scheduler level for x86
Date:   Fri, 20 Aug 2021 13:30:08 +1200
Message-Id: <20210820013008.12881-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820013008.12881-1-21cnbao@gmail.com>
References: <20210820013008.12881-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce is
shared among a cluster of cores instead of being exclusive to one
single core.
To prevent oversubscription of L2 cache, load should be balanced
between such L2 clusters, especially for tasks with no shared data.
On benchmark such as SPECrate mcf test, this change provides a
boost to performance especially on medium load system on Jacobsville.
on a Jacobsville that has 24 Atom cores, arranged into 6 clusters
of 4 cores each, the benchmark number is as follow:

 Improvement over baseline kernel for mcf_r
 copies		run time	base rate
 1		-0.1%		-0.2%
 6		25.1%		25.1%
 12		18.8%		19.0%
 24		0.3%		0.3%

So this looks pretty good. In terms of the system's task distribution,
some pretty bad clumping can be seen for the vanilla kernel without
the L2 cluster domain for the 6 and 12 copies case. With the extra
domain for cluster, the load does get evened out between the clusters.

Note this patch isn't an universal win as spreading isn't necessarily
a win, particually for those workload who can benefit from packing.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/x86/Kconfig                |  8 ++++++
 arch/x86/include/asm/smp.h      |  7 ++++++
 arch/x86/include/asm/topology.h |  3 +++
 arch/x86/kernel/cpu/cacheinfo.c |  1 +
 arch/x86/kernel/cpu/common.c    |  3 +++
 arch/x86/kernel/smpboot.c       | 44 ++++++++++++++++++++++++++++++++-
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 88fb922c23a0..e97356e99bbe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -996,6 +996,14 @@ config NR_CPUS
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
index 630ff08532be..08b0e90623ad 100644
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
index 9239399e5491..2548d824f103 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,17 +103,20 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
 
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
+#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
+#define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d66af2950e06..3528987fef1d 100644
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
index 64b805bd6a54..38871f114af1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -79,6 +79,9 @@ EXPORT_SYMBOL(smp_num_siblings);
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9320285a5e29..5832c6b6348f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
+
 /* Per CPU bogomips and other parameters */
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
@@ -464,6 +466,21 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
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
@@ -523,7 +540,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
+#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -541,12 +558,21 @@ static int x86_smt_flags(void)
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
@@ -557,6 +583,9 @@ static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -584,6 +613,7 @@ void set_cpu_sibling_map(int cpu)
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
+		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
@@ -602,6 +632,9 @@ void set_cpu_sibling_map(int cpu)
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
 
+		if ((i == cpu) || (has_mp && match_l2c(c, o)))
+			link_mask(cpu_l2c_shared_mask, cpu, i);
+
 		if ((i == cpu) || (has_mp && match_die(c, o)))
 			link_mask(topology_die_cpumask, cpu, i);
 	}
@@ -649,6 +682,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
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
@@ -1332,6 +1370,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
 
 	/*
@@ -1556,7 +1595,10 @@ static void remove_siblinginfo(int cpu)
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
2.25.1

