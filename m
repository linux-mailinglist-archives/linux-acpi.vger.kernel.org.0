Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08442EBB23
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAFIgk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 03:36:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbhAFIgi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 03:36:38 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9jN46qg7zMFWZ;
        Wed,  6 Jan 2021 16:34:44 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 16:35:45 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>,
        <vincent.guittot@linaro.org>, <lenb@kernel.org>,
        <gregkh@linuxfoundation.org>, <jonathan.cameron@huawei.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <aubrey.li@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@openeuler.org>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v3 2/2] scheduler: add scheduler level for clusters
Date:   Wed, 6 Jan 2021 21:30:26 +1300
Message-ID: <20210106083026.40444-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data, but each cluster
has local L3 tag. On the other hand, each clusters will share some
internal system bus. This means cache coherence overhead inside one cluster
is much less than the overhead across clusters.

This patch adds the sched_domain for clusters. On kunpeng 920, without
this patch, domain0 of cpu0 would be MC with cpu0~cpu23 with ; with this
patch, MC becomes domain1, a new domain0 "CLS" including cpu0-cpu3.

This will affect load balance. For example, without this patch, while cpu0
becomes idle, it will pull a task from cpu1-cpu15. With this patch, cpu0
will try to pull a task from cpu1-cpu3 first. This will have much less
overhead of task migration.

On the other hand, while doing WAKE_AFFINE, this patch will try to find
a core in the target cluster before scanning the whole llc domain.
This means it will proactively use a core which has better affinity with
target core at first.

Though it is named "cluster", architectures or machines can define its
exact meaning of cluster as long as some cpus can share some resources
in lower level than llc. So the implementation is applicable to all
architectures.

Different cpus might have different resource sharing like L1, L2, cache
tags, internal busses etc.
Since it is hard to know where we should start to scan, this patch adds
a SD_SHARE_CLS_RESOURCES rather than directly leveraging the existing
SD_SHARE_PKG_RESOURCES flag. Architectures or machines can decide what
is cluster and who should get SD_SHARE_CLS_RESOURCES. select_idle_cpu()
will scan from the first sched_domain with SD_SHARE_CLS_RESOURCES.

The below is a hackbench result:

we run the below command with different -g parameter from 1 to 10, for each
different g, we run the command 10 times and get the average time
$ numactl -N 0 hackbench -p -T -l 20000 -g $1

hackbench will report the time which is needed to complete a certain number
of messages transmissions between a certain number of tasks, for example:
$ numactl -N 0 hackbench -p -T -l 20000 -g 10
Running in threaded mode with 10 groups using 40 file descriptors each
(== 400 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 8.874

The below is the result of hackbench w/ and w/o the patch:
g     1      2      3      4      5      6      7      8      9      10
w/o 1.4777 2.0112 3.1919 4.2654 5.3246 6.4019 7.5939 8.7073 9.7526 10.8987
w/  1.4793 1.9344 2.9080 3.9267 4.8339 5.7186 6.6923 7.5088 8.3715 9.2173
                  +8.9%  +7.9%  +9.3%  +10.7% +11.8% +13.8% +14.2% +15.5%

Tracing the kernel while g=10, it shows select_idle_cpu() has a large chance
to get cpu in the same cluster with the target while it sometimes gets cpu
outside the cluster:
target cpu
19  -> 17
13  -> 15
23  -> 20
23  -> 20
19  -> 17
13  -> 15
16  -> 17
19  -> 17
7   -> 5
10  -> 11
23  -> 20
*23 -> 4
...

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3:
  - rebased againest 5.11-rc2
  - with respect to the comments of Valentin Schneider, Peter Zijlstra,
    Vincent Guittot and Mel Gorman etc.
  * moved the scheduler changes from arm64 to the common place for all
    architectures.
  * added SD_SHARE_CLS_RESOURCES sd_flags specifying the sched_domain
    where select_idle_cpu() should begin to scan from
  * removed redundant select_idle_cluster() function since all code is
    in select_idle_cpu() now. it also avoided scanning cluster cpus
    twice in v2 code;
  * redo the hackbench in one numa after the above changes

 arch/arm64/Kconfig             |  7 +++++++
 include/linux/sched/sd_flags.h |  9 +++++++++
 include/linux/sched/topology.h |  7 +++++++
 include/linux/topology.h       |  7 +++++++
 kernel/sched/fair.c            | 27 +++++++++++++++++++++------
 kernel/sched/topology.c        |  6 ++++++
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e1735..546cd61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -973,6 +973,13 @@ config SCHED_MC
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
diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 34b21e9..fc3c894 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -100,6 +100,15 @@ SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
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
index bf2cc3c..81be614 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -211,6 +211,13 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_CLUSTER
+static inline const struct cpumask *cpu_cluster_mask(int cpu)
+{
+	return topology_cluster_cpumask(cpu);
+}
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce2..c14fae6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6145,6 +6145,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
+	struct sched_domain *prev_ssd = NULL, *ssd;
 	u64 avg_cost, avg_idle;
 	u64 time;
 	int this = smp_processor_id();
@@ -6174,15 +6175,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
-	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+	/*
+	 * we first scan those child domains who declare they are sharing
+	 * cluster resources such as llc tags, internal busses; then scan
+	 * the whole llc
+	 */
+	for_each_domain(target, ssd) {
+		if ((ssd->flags & SD_SHARE_CLS_RESOURCES) || (ssd == sd)) {
+			cpumask_and(cpus, sched_domain_span(ssd), p->cpus_ptr);
+			if (prev_ssd)
+				cpumask_andnot(cpus, cpus, sched_domain_span(prev_ssd));
+			for_each_cpu_wrap(cpu, cpus, target) {
+				if (!--nr)
+					return -1;
+				if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+					goto done;
+			}
+			prev_ssd = ssd;
+		}
+		if (ssd == sd)
 			break;
 	}
 
+done:
 	time = cpu_clock(this) - time;
 	update_avg(&this_sd->avg_scan_cost, time);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5d3675c..79030c9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1361,6 +1361,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_SHARE_CLS_RESOURCES	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
@@ -1480,6 +1481,11 @@ static struct sched_domain_topology_level default_topology[] = {
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
2.7.4

