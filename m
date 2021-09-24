Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69AE416E45
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbhIXIxu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbhIXIxo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 04:53:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5CC061756;
        Fri, 24 Sep 2021 01:52:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n23so5491102pfv.4;
        Fri, 24 Sep 2021 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTR3gTe0ahGGrLZzxhQSY2yIXmJjuUPEt1KZkP9ubZA=;
        b=gkVPpSJ26b1+ylmajc6gajeyBeVR3seAF/gltaAFAVP46Ro90bMcYwmMN2OVkD+aPY
         9B3HjBWuO7oiGUlxObeigXos8H3ZZPDV7we5FqhwcjzyAIywhY5av1eJAGYYLuyzCTEF
         AJ8CQW4uC7ry1f7RVtOXEjRciKyh4IG7Pdb5QUZ5S5Xm8LkLYfWEiUH5mjbc4htiDzn1
         Cv1znRn3l1+WXFDw3CDJc+h1wlysCj+3T6A4bTxvLpmF9PFIKz7uwXGl4bKBLUQ60xqK
         uj5v2iwSWD2KwAwnYQ4pQHe+jCj9eX/BL2ZVPM/MifglFGAox323uYuX2xGnTy7nwf+B
         5MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTR3gTe0ahGGrLZzxhQSY2yIXmJjuUPEt1KZkP9ubZA=;
        b=rCZBbIWUJAEp1KYgU0PtUoyJtANRnu/2HyWKXvJOusLuZnkmOVZG1FoskiaTnupyYD
         /m6BmiE8dxYWpNd/PVRdZzyJ5lIPKuritwgOQ57T+CuEOnko38PbmVubIuSw6mIcLDkx
         6MwXUEUo7b+DcicP9gSq9l5ZwDGoCUgnG9aG3WFYlkAk5/68hV6hQBr0gA9nPpqUV67O
         6Nj+gohl/eUEIP2JY1frteRzXukAw16hJrLDYlboAF8Q0Aw6iz70BERhvhIu2d/uuemU
         AZz12ZYwb9aPbVx/oXuETipxkjn75mk+1Jx/vpTUkAS1os5uhvBVES4jjbsX9MOeG2hd
         fdRQ==
X-Gm-Message-State: AOAM533Tl1Uyhz1RHXAeNFZIeQEf4559BK4A12kaqa0/KaGzMliS0bAh
        RDOBl5B4A1ARjavzoZoYjIs=
X-Google-Smtp-Source: ABdhPJzjesgzaiIiH11fSK0xAH95ZUH6yb4VF0Jr/bzPU/E4XBsYgt72Bmi/WMeKY0JQTZOK+M3OJA==
X-Received: by 2002:a63:1d25:: with SMTP id d37mr2878718pgd.52.1632473531221;
        Fri, 24 Sep 2021 01:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:cad3:ec9e:d66f:102d])
        by smtp.gmail.com with ESMTPSA id t15sm9188362pgi.80.2021.09.24.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 01:52:10 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     aubrey.li@linux.intel.com, bp@alien8.de, bristot@redhat.com,
        bsegall@google.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        mark.rutland@arm.com, mgorman@suse.de, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        song.bao.hua@hisilicon.com, sudeep.holla@arm.com,
        tglx@linutronix.de, rafael@kernel.org, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, will@kernel.org, x86@kernel.org,
        yangyicong@huawei.com
Subject: [PATCH RESEND 3/3] scheduler: Add cluster scheduler level for x86
Date:   Fri, 24 Sep 2021 20:51:04 +1200
Message-Id: <20210924085104.44806-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924085104.44806-1-21cnbao@gmail.com>
References: <20210924085104.44806-1-21cnbao@gmail.com>
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
 arch/x86/Kconfig                |  8 ++++++++
 arch/x86/include/asm/smp.h      |  7 +++++++
 arch/x86/include/asm/topology.h |  3 +++
 arch/x86/kernel/cpu/cacheinfo.c |  1 +
 arch/x86/kernel/cpu/common.c    |  3 +++
 arch/x86/kernel/smpboot.c       | 44 ++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dad7f85..bd27b1c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1001,6 +1001,14 @@ config NR_CPUS
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
index 630ff08..08b0e90 100644
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
index 9239399..2548d82 100644
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
index b5e36bd..fe98a14 100644
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
index 0f88859..1c7897c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -85,6 +85,9 @@ u16 get_llc_id(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(get_llc_id);
 
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e24..5094ab0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@
 
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
@@ -557,6 +583,9 @@ static int x86_smt_flags(void)
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
@@ -652,6 +685,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
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
@@ -1335,6 +1373,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
 
 	/*
@@ -1564,7 +1603,10 @@ static void remove_siblinginfo(int cpu)
 
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

