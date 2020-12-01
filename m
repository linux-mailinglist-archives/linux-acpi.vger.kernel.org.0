Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621F22C958A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 04:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgLADFL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 22:05:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9078 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgLADFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 22:05:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClRkx6b2lzLxjc;
        Tue,  1 Dec 2020 11:03:53 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.198) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 11:04:18 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <gregkh@linuxfoundation.org>, <Jonathan.Cameron@huawei.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Date:   Tue, 1 Dec 2020 15:59:44 +1300
Message-ID: <20201201025944.18260-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.198]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data, but each cluster
has local L3 tag. On the other hand, each clusters will share some
internal system bus. This means cache coherence overhead inside one cluster
is much less than the overhead across clusters.

+-----------------------------------+                          +---------+
|  +------+    +------+            +---------------------------+         |
|  | CPU0 |    | cpu1 |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   +----+    L3     |         |         |
|  +------+    +------+   cluster   |    |    tag    |         |         |
|  | CPU2 |    | CPU3 |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                          |         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   |    |    L3     |         |         |
|  +------+    +------+             +----+    tag    |         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |   L3    |
                                                               |   data  |
+-----------------------------------+                          |         |
|  +------+    +------+             |    +-----------+         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             +----+    L3     |         |         |
|                                   |    |    tag    |         |         |
|  +------+    +------+             |    |           |         |         |
|  |      |    |      |            ++    +-----------+         |         |
|  +------+    +------+            |---------------------------+         |
+-----------------------------------|                          |         |
+-----------------------------------|                          |         |
|  +------+    +------+            +---------------------------+         |
|  |      |    |      |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   +----+    L3     |         |         |
|  +------+    +------+             |    |    tag    |         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                          |         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |   +-----------+          |         |
|  +------+    +------+             |   |           |          |         |
|                                   |   |    L3     |          |         |
|  +------+    +------+             +---+    tag    |          |         |
|  |      |    |      |             |   |           |          |         |
|  +------+    +------+             |   +-----------+          |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                         ++         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |  +-----------+           |         |
|  +------+    +------+             |  |           |           |         |
|                                   |  |    L3     |           |         |
|  +------+    +------+             +--+    tag    |           |         |
|  |      |    |      |             |  |           |           |         |
|  +------+    +------+             |  +-----------+           |         |
|                                   |                          +---------+
+-----------------------------------+

This patch adds the sched_domain for clusters. On kunpeng 920, without
this patch, domain0 of cpu0 would be MC for cpu0-cpu23 with
min_interval=24, max_interval=48; with this patch, MC becomes domain1,
a new domain0 "CL" including cpu0-cpu3 is added with min_interval=4 and
max_interval=8.
This will affect load balance. For example, without this patch, while cpu0
becomes idle, it will pull a task from cpu1-cpu15. With this patch, cpu0
will try to pull a task from cpu1-cpu3 first. This will have much less
overhead of task migration.

On the other hand, while doing WAKE_AFFINE, this patch will try to find
a core in the target cluster before scanning the llc domain.
This means it will proactively use a core which has better affinity with
target core at first.

Not much benchmark has been done yet. but here is a rough hackbench
result.
we run the below command with different -g parameter to increase system load
by changing g from 1 to 4, for each one of 1-4, we run the benchmark ten times
and record the data to get the average time:

First, we run hackbench in only one NUMA node(cpu0-cpu23):
$ numactl -N 0 hackbench -p -T -l 100000 -g $1

g=1 (seen cpu utilization around 50% for each core)
Running in threaded mode with 1 groups using 40 file descriptors
Each sender will pass 100000 messages of 100 bytes
w/o: 7.689 7.485 7.485 7.458 7.524 7.539 7.738 7.693 7.568 7.674=7.5853
w/ : 7.516 7.941 7.374 7.963 7.881 7.910 7.420 7.556 7.695 7.441=7.6697
performance improvement w/ patch: -1.01%

g=2 (seen cpu utilization around 70% for each core)
Running in threaded mode with 2 groups using 40 file descriptors
Each sender will pass 100000 messages of 100 bytes
w/o: 10.127 10.119 10.070 10.196 10.057 10.111 10.045 10.164 10.162 9.955=10.1006
w/ : 9.694 9.654 9.612 9.649 9.686 9.734 9.607 9.842 9.690 9.710=9.6878
performance improvement w/ patch: 4.08%

g=3 (seen cpu utilization around 90% for each core)
Running in threaded mode with 3 groups using 40 file descriptors
Each sender will pass 100000 messages of 100 bytes
w/o: 15.885 15.254 15.932 15.647 16.120 15.878 15.857 15.759 15.674 15.721=15.7727
w/ : 14.974 14.657 13.969 14.985 14.728 15.665 15.191 14.995 14.946 14.895=14.9005
performance improvement w/ patch: 5.53%

g=4
Running in threaded mode with 4 groups using 40 file descriptors
Each sender will pass 100000 messages of 100 bytes
w/o: 20.014 21.025 21.119 21.235 19.767 20.971 20.962 20.914 21.090 21.090=20.8187
w/ : 20.331 20.608 20.338 20.445 20.456 20.146 20.693 20.797 21.381 20.452=20.5647
performance improvement w/ patch: 1.22%

After that, we run the same hackbench in both NUMA nodes(cpu0-cpu47):
g=1
w/o: 7.351 7.416 7.486 7.358 7.516 7.403 7.413 7.411 7.421 7.454=7.4229
w/ : 7.609 7.596 7.647 7.571 7.687 7.571 7.520 7.513 7.530 7.681=7.5925
performance improvement by patch: -2.2%

g=2
w/o: 9.046 9.190 9.053 8.950 9.101 8.930 9.143 8.928 8.905 9.034=9.028
w/ : 8.247 8.057 8.258 8.310 8.083 8.201 8.044 8.158 8.382 8.173=8.1913
performance improvement by patch: 9.3%

g=3
w/o: 11.664 11.767 11.277 11.619 12.557 12.760 11.664 12.165 12.235 11.849=11.9557
w/ : 9.387 9.461 9.650 9.613 9.591 9.454 9.496 9.716 9.327 9.722=9.5417
performance improvement by patch: 20.2%

g=4
w/o: 17.347 17.299 17.655 18.775 16.707 18.879 17.255 18.356 16.859 18.515=17.7647
w/ : 10.416 10.496 10.601 10.318 10.459 10.617 10.510 10.642 10.467 10.401=10.4927
performance improvement by patch: 40.9%

g=5
w/o: 27.805 26.633 24.138 28.086 24.405 27.922 30.043 28.458 31.073 25.819=27.4382
w/ : 13.817 13.976 14.166 13.688 14.132 14.095 14.003 13.997 13.954 13.907=13.9735
performance improvement by patch: 49.1%

It seems the patch can bring a huge increase on hackbench especially when
we bind hackbench to all of cpu0-cpu47, comparing to 5.53% while running
on single NUMA node(cpu0-cpu23)

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/Kconfig       |  7 +++++++
 arch/arm64/kernel/smp.c  | 17 +++++++++++++++++
 include/linux/topology.h |  7 +++++++
 kernel/sched/fair.c      | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d23283..3583c26 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -938,6 +938,13 @@ config SCHED_MC
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
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 355ee9e..5c8f026 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/irq_work.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
+#include <linux/sched/topology.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -726,6 +727,20 @@ void __init smp_init_cpus(void)
 	}
 }
 
+static struct sched_domain_topology_level arm64_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+        { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, cpu_core_flags, SD_INIT_NAME(CL) },
+#endif
+#ifdef CONFIG_SCHED_MC
+        { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+        { NULL, },
+};
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	const struct cpu_operations *ops;
@@ -735,6 +750,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	init_cpu_topology();
 
+	set_sched_topology(arm64_topology);
+
 	this_cpu = smp_processor_id();
 	store_cpu_topology(this_cpu);
 	numa_store_cpu_info(this_cpu);
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 5f66648..2c823c0 100644
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
index 1a68a05..ae8ec910 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6106,6 +6106,37 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 
 #endif /* CONFIG_SCHED_SMT */
 
+#ifdef CONFIG_SCHED_CLUSTER
+/*
+ * Scan the local CLUSTER mask for idle CPUs.
+ */
+static int select_idle_cluster(struct task_struct *p, int target)
+{
+	int cpu;
+
+	/* right now, no hardware with both cluster and smt to run */
+	if (sched_smt_active())
+		return -1;
+
+	for_each_cpu_wrap(cpu, cpu_cluster_mask(target), target) {
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+			continue;
+		if (available_idle_cpu(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
+#else /* CONFIG_SCHED_CLUSTER */
+
+static inline int select_idle_cluster(struct task_struct *p, int target)
+{
+	return -1;
+}
+
+#endif /* CONFIG_SCHED_CLUSTER */
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6270,6 +6301,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	i = select_idle_cluster(p, target);
+	if ((unsigned)i < nr_cpumask_bits)
+		return i;
+
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
-- 
2.7.4

