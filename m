Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52232A4B9
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442158AbhCBLKx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:10:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbhCAXHB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 18:07:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqG6t6yGKzjTnJ;
        Tue,  2 Mar 2021 07:04:38 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.209) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 07:06:09 +0800
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
Subject: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Date:   Tue, 2 Mar 2021 11:59:39 +1300
Message-ID: <20210301225940.16728-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.209]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ARM64 chip Kunpeng 920 has 6 or 8 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data, but each cluster
has local L3 tag. On the other hand, each clusters will share some
internal system bus. This means cache coherence overhead inside one
cluster is much less than the overhead across clusters.

This patch adds the sched_domain for clusters. On kunpeng 920, without
this patch, domain0 of cpu0 would be MC with cpu0~cpu23 with ; with this
patch, MC becomes domain1, a new domain0 "CLS" including cpu0-cpu3.

This will help spread unrelated tasks among clusters, thus decrease the
contention and improve the throughput, for example, stream benchmark can
improve around 4.3%~6.3% by this patch:

w/o patch:
numactl -N 0 /usr/lib/lmbench/bin/stream -P 12 -M 1024M -N 5
STREAM copy latency: 3.36 nanoseconds
STREAM copy bandwidth: 57072.50 MB/sec
STREAM scale latency: 3.40 nanoseconds
STREAM scale bandwidth: 56542.52 MB/sec
STREAM add latency: 5.10 nanoseconds
STREAM add bandwidth: 56482.83 MB/sec
STREAM triad latency: 5.14 nanoseconds
STREAM triad bandwidth: 56069.52 MB/sec

w/ patch:
$ numactl -N 0 /usr/lib/lmbench/bin/stream -P 12 -M 1024M -N 5
STREAM copy latency: 3.22 nanoseconds
STREAM copy bandwidth: 59660.96 MB/sec    ->  +4.5%
STREAM scale latency: 3.25 nanoseconds
STREAM scale bandwidth: 59002.29 MB/sec   ->  +4.3%
STREAM add latency: 4.80 nanoseconds
STREAM add bandwidth: 60036.62 MB/sec     ->  +6.3%
STREAM triad latency: 4.86 nanoseconds
STREAM triad bandwidth: 59228.30 MB/sec   ->  +5.6%

On the other hand, while doing WAKE_AFFINE, this patch will try to find
a core in the target cluster before scanning the whole llc domain. So it
helps gather related tasks within one cluster.
we run the below hackbench with different -g parameter from 2 to 14, for
each different g, we run the command 10 times and get the average time
$ numactl -N 0 hackbench -p -T -l 20000 -g $1

hackbench will report the time which is needed to complete a certain number
of messages transmissions between a certain number of tasks, for example:
$ numactl -N 0 hackbench -p -T -l 20000 -g 10
Running in threaded mode with 10 groups using 40 file descriptors each
(== 400 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 8.874

The below is the result of hackbench w/ and w/o the patch:
g=    2      4     6       8      10     12      14
w/o: 1.9596 4.0506 5.9654 8.0068 9.8147 11.4900 13.1163
w/ : 1.9362 3.9197 5.6570 7.1376 8.5263 10.0512 11.3256
            +3.3%  +5.2%  +10.9% +13.2%  +12.8%  +13.7%

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
-v4:
  * rebased to tip/sched/core with the latest unified code of select_idle_cpu
  * also added benchmark data of spreading unrelated tasks
  * avoided the iteration of sched_domain by moving to static_key(addressing
    Vincent's comment

 arch/arm64/Kconfig             |  7 +++++
 include/linux/sched/cluster.h  | 19 ++++++++++++
 include/linux/sched/sd_flags.h |  9 ++++++
 include/linux/sched/topology.h |  7 +++++
 include/linux/topology.h       |  7 +++++
 kernel/sched/core.c            | 18 ++++++++++++
 kernel/sched/fair.c            | 66 +++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        |  6 ++++
 9 files changed, 126 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/sched/cluster.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b..158b0fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -971,6 +971,13 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters(sharing internal
+	  bus or sharing LLC cache tag). If unsure say N here.
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	help
diff --git a/include/linux/sched/cluster.h b/include/linux/sched/cluster.h
new file mode 100644
index 0000000..ea6c475
--- /dev/null
+++ b/include/linux/sched/cluster.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_CLUSTER_H
+#define _LINUX_SCHED_CLUSTER_H
+
+#include <linux/static_key.h>
+
+#ifdef CONFIG_SCHED_CLUSTER
+extern struct static_key_false sched_cluster_present;
+
+static __always_inline bool sched_cluster_active(void)
+{
+	return static_branch_likely(&sched_cluster_present);
+}
+#else
+static inline bool sched_cluster_active(void) { return false; }
+
+#endif
+
+#endif
diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 34b21e9..fc3c894 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -100,6 +100,15 @@
 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
+ * Domain members share CPU cluster resources (i.e. llc cache tags)
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ *               the cluster resouces (such as llc tags and internal bus)
+ * NEEDS_GROUPS: Caches are shared between groups.
+ */
+SD_FLAG(SD_SHARE_CLS_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+
+/*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778..846fcac 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -42,6 +42,13 @@ static inline int cpu_smt_flags(void)
 }
 #endif
 
+#ifdef CONFIG_SCHED_CLUSTER
+static inline int cpu_cluster_flags(void)
+{
+	return SD_SHARE_CLS_RESOURCES | SD_SHARE_PKG_RESOURCES;
+}
+#endif
+
 #ifdef CONFIG_SCHED_MC
 static inline int cpu_core_flags(void)
 {
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 80d27d7..0b3704a 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -212,6 +212,13 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
+#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
+static inline const struct cpumask *cpu_cluster_mask(int cpu)
+{
+	return topology_cluster_cpumask(cpu);
+}
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a2e2b..d805e59 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7797,6 +7797,16 @@ int sched_cpu_activate(unsigned int cpu)
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
 		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+	/*
+	 * When going up, increment the number of cluster cpus with
+	 * cluster present.
+	 */
+	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
+		static_branch_inc_cpuslocked(&sched_cluster_present);
+#endif
+
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -7873,6 +7883,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 		static_branch_dec_cpuslocked(&sched_smt_present);
 #endif
 
+#ifdef CONFIG_SCHED_CLUSTER
+	/*
+	 * When going down, decrement the number of cpus with cluster present.
+	 */
+	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
+		static_branch_dec_cpuslocked(&sched_cluster_present);
+#endif
+
 	if (!sched_smp_initialized)
 		return 0;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b..3db7b07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6009,6 +6009,11 @@ static inline int __select_idle_cpu(int cpu)
 	return -1;
 }
 
+#ifdef CONFIG_SCHED_CLUSTER
+DEFINE_STATIC_KEY_FALSE(sched_cluster_present);
+EXPORT_SYMBOL_GPL(sched_cluster_present);
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
@@ -6116,6 +6121,26 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 
 #endif /* CONFIG_SCHED_SMT */
 
+static inline int _select_idle_cpu(bool smt, struct task_struct *p, int target, struct cpumask *cpus, int *idle_cpu, int *nr)
+{
+	int cpu, i;
+
+	for_each_cpu_wrap(cpu, cpus, target) {
+		if (smt) {
+			i = select_idle_core(p, cpu, cpus, idle_cpu);
+		} else {
+			if (!--*nr)
+				return -1;
+			i = __select_idle_cpu(cpu);
+		} 
+
+		if ((unsigned int)i < nr_cpumask_bits)
+			return i;
+	}
+
+	return -1;
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6124,7 +6149,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, idle_cpu = -1, nr = INT_MAX;
 	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
@@ -6134,7 +6159,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (!this_sd)
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	if (!sched_cluster_active())
+		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+#ifdef CONFIG_SCHED_CLUSTER
+	if (sched_cluster_active())
+		cpumask_and(cpus, cpu_cluster_mask(target), p->cpus_ptr);
+#endif
 
 	if (sched_feat(SIS_PROP) && !smt) {
 		u64 avg_cost, avg_idle, span_avg;
@@ -6155,24 +6185,32 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		time = cpu_clock(this);
 	}
 
-	for_each_cpu_wrap(cpu, cpus, target) {
-		if (smt) {
-			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned int)i < nr_cpumask_bits)
-				return i;
+	/* scan cluster before scanning the whole llc */
+#ifdef CONFIG_SCHED_CLUSTER
+	if (sched_cluster_active()) {
+		i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
+		if ((unsigned int) i < nr_cpumask_bits) {
+			idle_cpu = i;
+			goto done;
+		} else if (nr <= 0)
+			return -1;
 
-		} else {
-			if (!--nr)
-				return -1;
-			idle_cpu = __select_idle_cpu(cpu);
-			if ((unsigned int)idle_cpu < nr_cpumask_bits)
-				break;
-		}
+		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		cpumask_andnot(cpus, cpus, cpu_cluster_mask(target));
 	}
+#endif
+
+	i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
+	if ((unsigned int) i < nr_cpumask_bits) {
+		idle_cpu = i;
+		goto done;
+	} else if (nr <= 0)
+		return -1;
 
 	if (smt)
 		set_idle_cores(this, false);
 
+done:
 	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522..48a020f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -6,6 +6,7 @@
 
 #include <linux/sched/autogroup.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/cluster.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/cpufreq.h>
 #include <linux/sched/cputime.h>
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d3504..d019c25 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1361,6 +1361,7 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_SHARE_CLS_RESOURCES	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
@@ -1480,6 +1481,11 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+       { cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
+
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
-- 
1.8.3.1

