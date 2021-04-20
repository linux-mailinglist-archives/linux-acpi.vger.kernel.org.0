Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC18364F74
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 02:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhDTA0s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 20:26:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16137 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhDTA0r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 20:26:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPPY01jmkzmdWh;
        Tue, 20 Apr 2021 08:23:16 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.79) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 08:26:06 +0800
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
Subject: [RFC PATCH v6 2/4] scheduler: add scheduler level for clusters
Date:   Tue, 20 Apr 2021 12:18:42 +1200
Message-ID: <20210420001844.9116-3-song.bao.hua@hisilicon.com>
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
improve 20%+ while parallelism is 6 and improve around 5% while paralle-
lism is 12:

(1) -P <parallelism> 6
$ numactl -N 0 /usr/lib/lmbench/bin/stream -P 6 -M 1024M -N 5

w/o patch:
STREAM copy latency: 2.46 nanoseconds
STREAM copy bandwidth: 39096.28 MB/sec
STREAM scale latency: 2.46 nanoseconds
STREAM scale bandwidth: 38970.26 MB/sec
STREAM add latency: 4.45 nanoseconds
STREAM add bandwidth: 32332.04 MB/sec
STREAM triad latency: 4.07 nanoseconds
STREAM triad bandwidth: 35387.69 MB/sec

w/ patch:
STREAM copy latency: 2.02 nanoseconds
STREAM copy bandwidth: 47604.47 MB/sec   +21.7%
STREAM scale latency: 2.04 nanoseconds
STREAM scale bandwidth: 47066.84 MB/sec  +20.8%
STREAM add latency: 3.35 nanoseconds
STREAM add bandwidth: 42942.15 MB/sec    +32.8%
STREAM triad latency: 3.16 nanoseconds
STREAM triad bandwidth: 45619.18 MB/sec  +28.9%

On the other hand,stream result could change significantly during different
tests without the patch, eg:
a.
STREAM copy latency: 2.16 nanoseconds
STREAM copy bandwidth: 44448.45 MB/sec
STREAM scale latency: 2.17 nanoseconds
STREAM scale bandwidth: 44320.77 MB/sec
STREAM add latency: 3.77 nanoseconds
STREAM add bandwidth: 38230.54 MB/sec
STREAM triad latency: 3.88 nanoseconds
STREAM triad bandwidth: 37072.10 MB/sec

b.
STREAM copy latency: 2.16 nanoseconds
STREAM copy bandwidth: 44403.22 MB/sec
STREAM scale latency: 2.39 nanoseconds
STREAM scale bandwidth: 40173.69 MB/sec
STREAM add latency: 3.77 nanoseconds
STREAM add bandwidth: 38232.56 MB/sec
STREAM triad latency: 3.38 nanoseconds
STREAM triad bandwidth: 42592.04 MB/sec

Obviously it is because the 6 threads are put randomly in 6 cores. Sometimes
they are packed in clusters, sometimes they are spread widely.

(2) -P <parallelism> 12
$ numactl -N 0 /usr/lib/lmbench/bin/stream -P 12 -M 1024M -N 5

w/o patch:
STREAM copy latency: 3.37 nanoseconds
STREAM copy bandwidth: 57008.80 MB/sec
STREAM scale latency: 3.38 nanoseconds
STREAM scale bandwidth: 56848.47 MB/sec
STREAM add latency: 5.50 nanoseconds
STREAM add bandwidth: 52398.62 MB/sec
STREAM triad latency: 5.09 nanoseconds
STREAM triad bandwidth: 56591.60 MB/sec

w/ patch:
STREAM copy latency: 3.24 nanoseconds
STREAM copy bandwidth: 59338.60 MB/sec  +4.1%
STREAM scale latency: 3.25 nanoseconds
STREAM scale bandwidth: 58993.23 MB/sec +3.7%
STREAM add latency: 5.19 nanoseconds
STREAM add bandwidth: 55517.45 MB/sec   +5.9%
STREAM triad latency: 4.86 nanoseconds
STREAM triad bandwidth: 59245.34 MB/sec +4.7%

Obviously the load balance between clusters help improve the parallelism
of unrelated tasks.

To evaluate the performance impact to related tasks talking with each
other, we run the below hackbench with different -g parameter from 6
to 32 in a NUMA node with 24 cores, for each different g, we run the
command 20 times and get the average time:
$ numactl -N 0 hackbench -p -T -l 1000000 -f 1 -g $1
As -f is set to 1, this means all threads are talking with each other
monogamously.

hackbench will report the time which is needed to complete a certain number
of messages transmissions between a certain number of tasks, for example:
$ numactl -N 0 hackbench -p -T -l 1000000 -f 1 -g 6
Running in threaded mode with 6 groups using 2 file descriptors each (== 12 tasks)
Each sender will pass 1000000 messages of 100 bytes

The below is the result of hackbench w/ and w/o the patch:
g=    6       12    18      24    28     32
w/o: 1.2474 1.5635 1.5133 1.4796 1.6177 1.7898
w/ : 1.1458 1.3309 1.3416 1.4990 1.9212 2.3411

It seems this patch benefits hackbench when the load is relatively low,
while it hurts hackbench much when the load is relatively high(56 and
64 threads in 24 cores).

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/Kconfig             |  7 +++++++
 include/linux/sched/cluster.h  | 19 +++++++++++++++++++
 include/linux/sched/sd_flags.h |  9 +++++++++
 include/linux/sched/topology.h |  7 +++++++
 include/linux/topology.h       |  7 +++++++
 kernel/sched/core.c            | 20 ++++++++++++++++++++
 kernel/sched/fair.c            |  4 ++++
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        |  6 ++++++
 9 files changed, 80 insertions(+)
 create mode 100644 include/linux/sched/cluster.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b4..9432a30 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -977,6 +977,13 @@ config SCHED_MC
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
index 95bd6ab..30c300c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7840,6 +7840,17 @@ int sched_cpu_activate(unsigned int cpu)
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
 		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+	/*
+	 * When going up, increment the number of cluster cpus with
+	 * cluster present.
+	 */
+	if (cpumask_weight(cpu_cluster_mask(cpu)) > cpumask_weight(cpu_smt_mask(cpu)) &&
+	    cpumask_weight(cpu_cluster_mask(cpu)) < cpumask_weight(cpu_coregroup_mask(cpu)))
+		static_branch_inc_cpuslocked(&sched_cluster_present);
+#endif
+
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -7916,6 +7927,15 @@ int sched_cpu_deactivate(unsigned int cpu)
 		static_branch_dec_cpuslocked(&sched_smt_present);
 #endif
 
+#ifdef CONFIG_SCHED_CLUSTER
+	/*
+	 * When going down, decrement the number of cpus with cluster present.
+	 */
+	if (cpumask_weight(cpu_cluster_mask(cpu)) > cpumask_weight(cpu_smt_mask(cpu)) &&
+	    cpumask_weight(cpu_cluster_mask(cpu)) < cpumask_weight(cpu_coregroup_mask(cpu)))
+		static_branch_dec_cpuslocked(&sched_cluster_present);
+#endif
+
 	if (!sched_smp_initialized)
 		return 0;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdb..a327746 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6021,6 +6021,10 @@ static inline int __select_idle_cpu(int cpu)
 	return -1;
 }
 
+#ifdef CONFIG_SCHED_CLUSTER
+DEFINE_STATIC_KEY_FALSE(sched_cluster_present);
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cbb0b01..4e938ba 100644
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
index d1aec24..829ac9d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1392,6 +1392,7 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_SHARE_CLS_RESOURCES	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
@@ -1511,6 +1512,11 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
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

