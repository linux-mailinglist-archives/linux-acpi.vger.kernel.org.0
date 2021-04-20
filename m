Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB92364F76
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 02:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhDTA04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 20:26:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16604 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhDTA0w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 20:26:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPPYp5Rrjz19LtT;
        Tue, 20 Apr 2021 08:23:58 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.79) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 08:26:13 +0800
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
Subject: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks within one LLC
Date:   Tue, 20 Apr 2021 12:18:43 +1200
Message-ID: <20210420001844.9116-4-song.bao.hua@hisilicon.com>
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

On kunpeng920, cpus within one cluster can communicate wit each other
much faster than cpus across different clusters. A simple hackbench
can prove that.
hackbench running on 4 cpus in single one cluster and 4 cpus in
different clusters shows a large contrast:
(1) within a cluster:
root@ubuntu:~# taskset -c 0,1,2,3 hackbench -p -T -l 20000 -g 1
Running in threaded mode with 1 groups using 40 file descriptors each
(== 40 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 4.285

(2) across clusters:
root@ubuntu:~# taskset -c 0,4,8,12 hackbench -p -T -l 20000 -g 1
Running in threaded mode with 1 groups using 40 file descriptors each
(== 40 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 5.524

This inspires us to change the wake_affine path to scan cluster to pack
the related tasks. Ideally, a two-level packing vs. spreading heuristic
could be introduced to distinguish between llc-packing and even narrower
(cluster or MC-L2)-packing. But this way would be quite trivial. So this
patch begins from those tasks running in same LLC. This is actually quite
common in real use cases when tasks are bound in a NUMA.

If users use "numactl -N 0" to bind tasks, this patch will scan cluster
rather than llc to select idle cpu. A hackbench running with some groups
of monogamous sender-receiver model shows a major improvement.

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

The below is the result of hackbench:
g                =    6      12      18     24    28    32
w/o                 1.2474 1.5635 1.5133 1.4796 1.6177 1.7898
w/domain            1.1458 1.3309 1.3416 1.4990 1.9212 2.3411
w/domain+affine     0.9500 1.0728 1.1756 1.2201 1.4166 1.5464

w/o: without any change
w/domain: added cluster domain without changing wake_affine
w/domain+affine: added cluster domain, changed wake_affine

while g=6, if we use top -H to show the cpus which tasks are running on,
we can easily find couples are running in same CCL.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v6:
  * emulated a two-level spreading/packing heuristic by only scanning cluster
    in wake_affine path for tasks running in same LLC(also NUMA).

    This partially addressed Dietmar's comment in RFC v3:
    "In case we would like to further distinguish between llc-packing and
     even narrower (cluster or MC-L2)-packing, we would introduce a 2. level
     packing vs. spreading heuristic further down in sis().
   
     IMHO, Barry's current implementation doesn't do this right now. Instead
     he's trying to pack on cluster first and if not successful look further
     among the remaining llc CPUs for an idle CPU."

  * adjusted the hackbench parameter to make relatively low and high load.
    previous patchsets with "-f 10" ran under an extremely high load with
    hundreds of threads, which seems not real use cases.

    This also addressed Vincent's question in RFC v4:
    "In particular, I'm still not convinced that the modification of the wakeup
    path is the root of the hackbench improvement; especially with g=14 where
    there should not be much idle CPUs with 14*40 tasks on at most 32 CPUs."

 block/blk-mq.c                 |  2 +-
 include/linux/sched/topology.h |  5 +++--
 kernel/sched/core.c            |  9 +++++---
 kernel/sched/fair.c            | 47 +++++++++++++++++++++++++-----------------
 kernel/sched/sched.h           |  3 +++
 kernel/sched/topology.c        | 12 +++++++++++
 6 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1c..1418981 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -611,7 +611,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
-	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+	     cpus_share_cache(cpu, rq->mq_ctx->cpu, 0)))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 846fcac..d63d6b8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,7 +176,8 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
-bool cpus_share_cache(int this_cpu, int that_cpu);
+/* return true if cpus share cluster(while cluster=1) or llc cache */
+bool cpus_share_cache(int this_cpu, int that_cpu, int cluster);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -225,7 +226,7 @@ struct sched_domain_topology_level {
 {
 }
 
-static inline bool cpus_share_cache(int this_cpu, int that_cpu)
+static inline bool cpus_share_cache(int this_cpu, int that_cpu, int cluster)
 {
 	return true;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30c300c..c74812a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3126,9 +3126,12 @@ void wake_up_if_idle(int cpu)
 	rcu_read_unlock();
 }
 
-bool cpus_share_cache(int this_cpu, int that_cpu)
+bool cpus_share_cache(int this_cpu, int that_cpu, int cluster)
 {
-	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
+	if (cluster)
+		return per_cpu(sd_cluster_id, this_cpu) == per_cpu(sd_cluster_id, that_cpu);
+	else
+		return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
@@ -3144,7 +3147,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (!cpus_share_cache(smp_processor_id(), cpu, 0))
 		return true;
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a327746..69a1704 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -718,7 +718,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int cluster);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -5786,11 +5786,12 @@ static void record_wakee(struct task_struct *p)
  * whatever is irrelevant, spread criteria is apparent partner count exceeds
  * socket size.
  */
-static int wake_wide(struct task_struct *p)
+static int wake_wide(struct task_struct *p, int cluster)
 {
 	unsigned int master = current->wakee_flips;
 	unsigned int slave = p->wakee_flips;
-	int factor = __this_cpu_read(sd_llc_size);
+	int factor = cluster ? __this_cpu_read(sd_cluster_size) :
+		__this_cpu_read(sd_llc_size);
 
 	if (master < slave)
 		swap(master, slave);
@@ -5812,7 +5813,7 @@ static int wake_wide(struct task_struct *p)
  *			  for the overloaded case.
  */
 static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+wake_affine_idle(int this_cpu, int prev_cpu, int sync, int cluster)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -5826,7 +5827,7 @@ static int wake_wide(struct task_struct *p)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
+	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu, cluster))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
@@ -5882,12 +5883,12 @@ static int wake_wide(struct task_struct *p)
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int this_cpu, int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync, int cluster)
 {
 	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
-		target = wake_affine_idle(this_cpu, prev_cpu, sync);
+		target = wake_affine_idle(this_cpu, prev_cpu, sync, cluster);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -6139,7 +6140,8 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target,
+	int cluster)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
@@ -6154,7 +6156,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	/* cluster is usually quite small like 4, no need SIS_PROP */
+	if (sched_feat(SIS_PROP) && !smt && !cluster) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6191,7 +6194,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (smt)
 		set_idle_cores(this, false);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP) && !smt && !cluster) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
@@ -6244,7 +6247,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, int cluster)
 {
 	struct sched_domain *sd;
 	unsigned long task_util;
@@ -6266,7 +6269,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_cache(prev, target, cluster) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6289,7 +6292,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_cache(recent_used_cpu, target, cluster) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
@@ -6321,11 +6324,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
-	sd = rcu_dereference(per_cpu(sd_llc, target));
+	sd = cluster ? rcu_dereference(per_cpu(sd_cluster, target)) :
+			rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
-
-	i = select_idle_cpu(p, sd, target);
+	i = select_idle_cpu(p, sd, target, cluster);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
@@ -6745,6 +6748,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	/*
+	 * if cpu and prev_cpu share LLC, consider cluster sibling rather
+	 * than llc. this is typically true while tasks are bound within
+	 * one numa
+	 */
+	int cluster = sched_cluster_active() && cpus_share_cache(cpu, prev_cpu, 0);
 
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
@@ -6756,7 +6765,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			new_cpu = prev_cpu;
 		}
 
-		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
+		want_affine = !wake_wide(p, cluster) && cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
 	rcu_read_lock();
@@ -6768,7 +6777,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
-				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, cluster);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
@@ -6785,7 +6794,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, cluster);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4e938ba..b4b7d95 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1487,6 +1487,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
+DECLARE_PER_CPU(int, sd_cluster_size);
+DECLARE_PER_CPU(int, sd_cluster_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 829ac9d..28a2032 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -644,6 +644,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
+DEFINE_PER_CPU(int, sd_cluster_size);
+DEFINE_PER_CPU(int, sd_cluster_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -657,6 +660,15 @@ static void update_top_cache_domain(int cpu)
 	int id = cpu;
 	int size = 1;
 
+	sd = highest_flag_domain(cpu, SD_SHARE_CLS_RESOURCES);
+	if (sd) {
+		id = cpumask_first(sched_domain_span(sd));
+		size = cpumask_weight(sched_domain_span(sd));
+	}
+	rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
+	per_cpu(sd_cluster_size, cpu) = size;
+	per_cpu(sd_cluster_id, cpu) = id;
+
 	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
-- 
1.8.3.1

