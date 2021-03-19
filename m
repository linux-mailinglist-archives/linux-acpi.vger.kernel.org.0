Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155823427EC
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 22:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSVjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 19 Mar 2021 17:39:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2721 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSVjT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 17:39:19 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F2HGf3y6Sz680nJ;
        Sat, 20 Mar 2021 05:34:34 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 22:39:12 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 21:39:10 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 20 Mar 2021 05:39:08 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC PATCH v5 3/4] scheduler: scan idle cpu in cluster before
 scanning the whole llc
Thread-Topic: [RFC PATCH v5 3/4] scheduler: scan idle cpu in cluster before
 scanning the whole llc
Thread-Index: AQHXHHeZxLBmsb3r8EeP8F1S7SeSAaqL0GzQ
Date:   Fri, 19 Mar 2021 21:39:08 +0000
Message-ID: <d6d9167ea9a3414bad052bbbbe3720e9@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-4-song.bao.hua@hisilicon.com>
In-Reply-To: <20210319041618.14316-4-song.bao.hua@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.173]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Song Bao Hua (Barry Song)
> Sent: Friday, March 19, 2021 5:16 PM
> To: tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org; peterz@infradead.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de
> Cc: msys.mizuma@gmail.com; valentin.schneider@arm.com;
> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Subject: [RFC PATCH v5 3/4] scheduler: scan idle cpu in cluster before scanning
> the whole llc
> 
> On kunpeng920, cpus within one cluster can communicate wit each other
> much faster than cpus across different clusters. A simple hackbench
> can prove that.
> hackbench running on 4 cpus in single one cluster and 4 cpus in
> different clusters shows a large contrast:
> (1) within a cluster:
> root@ubuntu:~# taskset -c 0,1,2,3 hackbench -p -T -l 20000 -g 1
> Running in threaded mode with 1 groups using 40 file descriptors each
> (== 40 tasks)
> Each sender will pass 20000 messages of 100 bytes
> Time: 4.285
> 
> (2) across clusters:
> root@ubuntu:~# taskset -c 0,4,8,12 hackbench -p -T -l 20000 -g 1
> Running in threaded mode with 1 groups using 40 file descriptors each
> (== 40 tasks)
> Each sender will pass 20000 messages of 100 bytes
> Time: 5.524
> 
> This inspires us to change the wake_affine path to scan cluster before
> scanning the whole LLC to try to gatter related tasks in one cluster,
> which is done by this patch.
> 
> To evaluate the performance impact to related tasks talking with each
> other, we run the below hackbench with different -g parameter from 2
> to 14, for each different g, we run the command 10 times and get the
> average time:
> $ numactl -N 0 hackbench -p -T -l 20000 -g $1
> 
> hackbench will report the time which is needed to complete a certain number
> of messages transmissions between a certain number of tasks, for example:
> $ numactl -N 0 hackbench -p -T -l 20000 -g 10
> Running in threaded mode with 10 groups using 40 file descriptors each
> (== 400 tasks)
> Each sender will pass 20000 messages of 100 bytes
> 
> The below is the result of hackbench w/ and w/o cluster patch:
> g=    2      4     6       8      10     12      14
> w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
> w/ : 1.7881 3.7371 5.3301 6.9747 8.6909  9.9235 11.2608
> 
> Obviously some recent commits have improved the hackbench. So the change
> in wake_affine path brings less increase on hackbench compared to what
> we got in RFC v4.
> And obviously it is much more tricky to leverage wake_affine compared to
> leveraging the scatter of tasks in the previous patch as load balance
> might pull tasks which have been compact in a cluster so alternative
> suggestions welcome.
> 
> In order to figure out how many times cpu is picked from the cluster and
> how many times cpu is picked out of the cluster, a tracepoint for debug
> purpose is added in this patch. And an userspace bcc script to print the
> histogram of the result of select_idle_cpu():
> #!/usr/bin/python
> #
> # selectidlecpu.py	select idle cpu histogram.
> #
> # A Ctrl-C will print the gathered histogram then exit.
> #
> # 18-March-2021 Barry Song Created this.
> 
> from __future__ import print_function
> from bcc import BPF
> from time import sleep
> 
> # load BPF program
> b = BPF(text="""
> 
> BPF_HISTOGRAM(dist);
> 
> TRACEPOINT_PROBE(sched, sched_select_idle_cpu)
> {
> 	u32 e;
> 	if (args->idle / 4 == args->target/4)
> 		e = 0; /* idle cpu from same cluster */

Oops here, as -1/4 = 1/4 = 2/4 = 3/4 = 0
So a part of -1 is put here(local cluster) incorrectly.

> 	else if (args->idle != -1)
> 		e = 1; /* idle cpu from different clusters */
> 	else
> 		e = 2; /* no idle cpu */
> 
> 	dist.increment(e);
> 	return 0;
> }
> """)

Fixed it to:

TRACEPOINT_PROBE(sched, sched_select_idle_cpu)
{
        u32 e;
        if (args->idle == -1)
                e = 2; /* no idle cpu */
        else if (args->idle / 4 == args->target / 4)
                e = 0; /* idle cpu from same cluster */
        else
                e = 1; /* idle cpu from different clusters */

        dist.increment(e);
        return 0;
}

> 
> # header
> print("Tracing... Hit Ctrl-C to end.")
> 
> # trace until Ctrl-C
> try:
> 	sleep(99999999)
> except KeyboardInterrupt:
> 	print()
> 
> # output
> 
> print("\nlinear histogram")
> print("~~~~~~~~~~~~~~~~")
> b["dist"].print_linear_hist("idle")
> 
> Even while g=14 and the system is quite busy, we can see there are some
> chances idle cpu is picked from local cluster:
> linear histogram
> ~~~~~~~~~~~~~~
>      idle          : count     distribution
>         0          : 15234281 |***********                             |
>         1          : 18494    |                                        |
>         2          : 53066152 |****************************************|
> 
> 0: local cluster
> 1: out of the cluster
> 2: select_idle_cpu() returns -1

After fixing the script, the new histogram is like:
linear histogram
~~~~~~~~~~~~~~~~
     idle          : count     distribution
        0          : 2765930  |*                                       |
        1          : 68934    |                                        |
        2          : 77667475 |****************************************|

We get 
Local cluster: 3.4358%
Out of cluster: 0.0856%
-1(no idle before nr becomes 0): 96.4785%

> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  include/trace/events/sched.h | 22 ++++++++++++++++++++++
>  kernel/sched/fair.c          | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index cbe3e15..86608cf 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -136,6 +136,28 @@
>  );
> 
>  /*
> + * Tracepoint for select_idle_cpu:
> + */
> +TRACE_EVENT(sched_select_idle_cpu,
> +
> +	TP_PROTO(int target, int idle),
> +
> +	TP_ARGS(target, idle),
> +
> +	TP_STRUCT__entry(
> +		__field(	int,	target			)
> +		__field(	int,	idle			)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->target	= target;
> +		__entry->idle = idle;
> +	),
> +
> +	TP_printk("target=%d idle=%d", __entry->target, __entry->idle)
> +);
> +
> +/*
>   * Tracepoint for waking up a task:
>   */
>  DECLARE_EVENT_CLASS(sched_wakeup_template,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c92ad9f2..3892d42 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6150,7 +6150,12 @@ static int select_idle_cpu(struct task_struct *p, struct
> sched_domain *sd, int t
>  	if (!this_sd)
>  		return -1;
> 
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +	if (!sched_cluster_active())
> +		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +#ifdef CONFIG_SCHED_CLUSTER
> +	if (sched_cluster_active())
> +		cpumask_and(cpus, cpu_cluster_mask(target), p->cpus_ptr);
> +#endif
> 
>  	if (sched_feat(SIS_PROP) && !smt) {
>  		u64 avg_cost, avg_idle, span_avg;
> @@ -6171,6 +6176,29 @@ static int select_idle_cpu(struct task_struct *p, struct
> sched_domain *sd, int t
>  		time = cpu_clock(this);
>  	}
> 
> +#ifdef CONFIG_SCHED_CLUSTER
> +	if (sched_cluster_active()) {
> +		for_each_cpu_wrap(cpu, cpus, target) {
> +			if (smt) {
> +				i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +				if ((unsigned int)i < nr_cpumask_bits)
> +					return i;
> +
> +			} else {
> +				if (!--nr)
> +					return -1;
> +				idle_cpu = __select_idle_cpu(cpu);
> +				if ((unsigned int)idle_cpu < nr_cpumask_bits) {
> +					goto done;
> +				}
> +			}

BTW, if I return -1 here directly and don't fall back to LLC, I
can even get a better benchmark:

g=            2      4     6       8      10     12      14
w/o:        1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
w/ :        1.7881 3.7371 5.3301 6.9747 8.6909  9.9235 11.2608
return -1:  1.8324 3.6140 5.1029 6.5016 8.1867  9.7559 10.7716

so it seems the wake-up path change is much more trivial to
get a real and good impact, comparing to the previous 2/4
patch in which we are only spreading tasks.

> +		}
> +
> +		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +		cpumask_andnot(cpus, cpus, cpu_cluster_mask(target));
> +	}
> +#endif
> +
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (smt) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -6186,6 +6214,7 @@ static int select_idle_cpu(struct task_struct *p, struct
> sched_domain *sd, int t
>  		}
>  	}
> 
> +done:
>  	if (smt)
>  		set_idle_cores(this, false);
> 
> @@ -6324,6 +6353,7 @@ static int select_idle_sibling(struct task_struct *p,
> int prev, int target)
>  		return target;
> 
>  	i = select_idle_cpu(p, sd, target);
> +	trace_sched_select_idle_cpu(target, i);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
> 
> --
> 1.8.3.1

Thanks
Barry

