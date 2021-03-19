Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34034141E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 05:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhCSEXr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 00:23:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13991 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhCSEXZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 00:23:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F1rLc4ztPzrXP7;
        Fri, 19 Mar 2021 12:21:28 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.211) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 12:23:15 +0800
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
Subject: [RFC PATCH v5 3/4] scheduler: scan idle cpu in cluster before scanning the whole llc
Date:   Fri, 19 Mar 2021 17:16:17 +1300
Message-ID: <20210319041618.14316-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.211]
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

This inspires us to change the wake_affine path to scan cluster before
scanning the whole LLC to try to gatter related tasks in one cluster,
which is done by this patch.

To evaluate the performance impact to related tasks talking with each
other, we run the below hackbench with different -g parameter from 2
to 14, for each different g, we run the command 10 times and get the
average time:
$ numactl -N 0 hackbench -p -T -l 20000 -g $1

hackbench will report the time which is needed to complete a certain number
of messages transmissions between a certain number of tasks, for example:
$ numactl -N 0 hackbench -p -T -l 20000 -g 10
Running in threaded mode with 10 groups using 40 file descriptors each
(== 400 tasks)
Each sender will pass 20000 messages of 100 bytes

The below is the result of hackbench w/ and w/o cluster patch:
g=    2      4     6       8      10     12      14
w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
w/ : 1.7881 3.7371 5.3301 6.9747 8.6909  9.9235 11.2608

Obviously some recent commits have improved the hackbench. So the change
in wake_affine path brings less increase on hackbench compared to what
we got in RFC v4.
And obviously it is much more tricky to leverage wake_affine compared to
leveraging the scatter of tasks in the previous patch as load balance
might pull tasks which have been compact in a cluster so alternative
suggestions welcome.

In order to figure out how many times cpu is picked from the cluster and
how many times cpu is picked out of the cluster, a tracepoint for debug
purpose is added in this patch. And an userspace bcc script to print the
histogram of the result of select_idle_cpu():
#!/usr/bin/python
#
# selectidlecpu.py	select idle cpu histogram.
#
# A Ctrl-C will print the gathered histogram then exit.
#
# 18-March-2021 Barry Song Created this.

from __future__ import print_function
from bcc import BPF
from time import sleep

# load BPF program
b = BPF(text="""

BPF_HISTOGRAM(dist);

TRACEPOINT_PROBE(sched, sched_select_idle_cpu)
{
	u32 e;
	if (args->idle / 4 == args->target/4)
		e = 0; /* idle cpu from same cluster */
	else if (args->idle != -1)
		e = 1; /* idle cpu from different clusters */
	else
		e = 2; /* no idle cpu */

	dist.increment(e);
	return 0;
}
""")

# header
print("Tracing... Hit Ctrl-C to end.")

# trace until Ctrl-C
try:
	sleep(99999999)
except KeyboardInterrupt:
	print()

# output

print("\nlinear histogram")
print("~~~~~~~~~~~~~~~~")
b["dist"].print_linear_hist("idle")

Even while g=14 and the system is quite busy, we can see there are some
chances idle cpu is picked from local cluster:
linear histogram
~~~~~~~~~~~~~~
     idle          : count     distribution
        0          : 15234281 |***********                             |
        1          : 18494    |                                        |
        2          : 53066152 |****************************************|

0: local cluster
1: out of the cluster
2: select_idle_cpu() returns -1

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/trace/events/sched.h | 22 ++++++++++++++++++++++
 kernel/sched/fair.c          | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index cbe3e15..86608cf 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -136,6 +136,28 @@
 );
 
 /*
+ * Tracepoint for select_idle_cpu:
+ */
+TRACE_EVENT(sched_select_idle_cpu,
+
+	TP_PROTO(int target, int idle),
+
+	TP_ARGS(target, idle),
+
+	TP_STRUCT__entry(
+		__field(	int,	target			)
+		__field(	int,	idle			)
+	),
+
+	TP_fast_assign(
+		__entry->target	= target;
+		__entry->idle = idle;
+	),
+
+	TP_printk("target=%d idle=%d", __entry->target, __entry->idle)
+);
+
+/*
  * Tracepoint for waking up a task:
  */
 DECLARE_EVENT_CLASS(sched_wakeup_template,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c92ad9f2..3892d42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6150,7 +6150,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
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
@@ -6171,6 +6176,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		time = cpu_clock(this);
 	}
 
+#ifdef CONFIG_SCHED_CLUSTER
+	if (sched_cluster_active()) {
+		for_each_cpu_wrap(cpu, cpus, target) {
+			if (smt) {
+				i = select_idle_core(p, cpu, cpus, &idle_cpu);
+				if ((unsigned int)i < nr_cpumask_bits)
+					return i;
+
+			} else {
+				if (!--nr)
+					return -1;
+				idle_cpu = __select_idle_cpu(cpu);
+				if ((unsigned int)idle_cpu < nr_cpumask_bits) {
+					goto done;
+				}
+			}
+		}
+
+		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		cpumask_andnot(cpus, cpus, cpu_cluster_mask(target));
+	}
+#endif
+
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6186,6 +6214,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		}
 	}
 
+done:
 	if (smt)
 		set_idle_cores(this, false);
 
@@ -6324,6 +6353,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	i = select_idle_cpu(p, sd, target);
+	trace_sched_select_idle_cpu(target, i);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
1.8.3.1

