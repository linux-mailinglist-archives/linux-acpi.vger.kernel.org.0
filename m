Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FC33CEB0
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhCPHeB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 16 Mar 2021 03:34:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2700 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhCPHdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2021 03:33:40 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F04Z543PYz680Fx;
        Tue, 16 Mar 2021 15:25:17 +0800 (CST)
Received: from lhreml719-chm.china.huawei.com (10.201.108.70) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 08:33:38 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 07:33:37 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 16 Mar 2021 15:33:35 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
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
Subject: RE: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Thread-Topic: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Thread-Index: AQHXDu99D3AbdiYnOU2vOW1slo8ZO6pv/bYAgBZLeMA=
Date:   Tue, 16 Mar 2021 07:33:35 +0000
Message-ID: <9ac6da7f862347b5af117db74d4d4254@hisilicon.com>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-3-song.bao.hua@hisilicon.com>
 <YD4WwrlVNwlSj/Zn@hirez.programming.kicks-ass.net>
In-Reply-To: <YD4WwrlVNwlSj/Zn@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Tuesday, March 2, 2021 11:43 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de; msys.mizuma@gmail.com; valentin.schneider@arm.com;
> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com
> Subject: Re: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
> 
> On Tue, Mar 02, 2021 at 11:59:39AM +1300, Barry Song wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 88a2e2b..d805e59 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7797,6 +7797,16 @@ int sched_cpu_activate(unsigned int cpu)
> >  	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> >  		static_branch_inc_cpuslocked(&sched_smt_present);
> >  #endif
> > +
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +	/*
> > +	 * When going up, increment the number of cluster cpus with
> > +	 * cluster present.
> > +	 */
> > +	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
> > +		static_branch_inc_cpuslocked(&sched_cluster_present);
> > +#endif
> > +
> >  	set_cpu_active(cpu, true);
> >
> >  	if (sched_smp_initialized) {
> > @@ -7873,6 +7883,14 @@ int sched_cpu_deactivate(unsigned int cpu)
> >  		static_branch_dec_cpuslocked(&sched_smt_present);
> >  #endif
> >
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +	/*
> > +	 * When going down, decrement the number of cpus with cluster present.
> > +	 */
> > +	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
> > +		static_branch_dec_cpuslocked(&sched_cluster_present);
> > +#endif
> > +
> >  	if (!sched_smp_initialized)
> >  		return 0;
> 
> I don't think that's correct. IIUC this will mean the
> sched_cluster_present thing will be enabled on anything with SMT (very
> much including x86 big cores after the next patch).
> 
> I'm thinking that at the very least you should check a CLS domain
> exists, but that might be hard at this point, because the sched domains
> haven't been build yet.

might be able to achieve the same goal by:

int cls_wt = cpumask_weight(cpu_cluster_mask(cpu));
if ((cls_wt > cpumask_weight(cpu_smt_mask(cpu))) &&
     && (cls_wt < cpumask_weight(cpu_coregroup_mask(cpu))))
   sched_cluster_present...

> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a8bd7b..3db7b07 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6009,6 +6009,11 @@ static inline int __select_idle_cpu(int cpu)
> >  	return -1;
> >  }
> >
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +DEFINE_STATIC_KEY_FALSE(sched_cluster_present);
> > +EXPORT_SYMBOL_GPL(sched_cluster_present);
> 
> I really rather think this shouldn't be exported

Ok. Make sense.

> 
> > +#endif
> > +
> >  #ifdef CONFIG_SCHED_SMT
> >  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
> >  EXPORT_SYMBOL_GPL(sched_smt_present);
> 
> This is a KVM wart, it needs to know because mitigation crap.
> 

Ok.

> > @@ -6116,6 +6121,26 @@ static inline int select_idle_core(struct task_struct
> *p, int core, struct cpuma
> >
> >  #endif /* CONFIG_SCHED_SMT */
> >
> > +static inline int _select_idle_cpu(bool smt, struct task_struct *p, int
> target, struct cpumask *cpus, int *idle_cpu, int *nr)
> > +{
> > +	int cpu, i;
> > +
> > +	for_each_cpu_wrap(cpu, cpus, target) {
> > +		if (smt) {
> > +			i = select_idle_core(p, cpu, cpus, idle_cpu);
> > +		} else {
> > +			if (!--*nr)
> > +				return -1;
> > +			i = __select_idle_cpu(cpu);
> > +		}
> > +
> > +		if ((unsigned int)i < nr_cpumask_bits)
> > +			return i;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> >  /*
> >   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against
> the
> > @@ -6124,7 +6149,7 @@ static inline int select_idle_core(struct task_struct
> *p, int core, struct cpuma
> >  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
> int target)
> >  {
> >  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > -	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > +	int i, idle_cpu = -1, nr = INT_MAX;
> >  	bool smt = test_idle_cores(target, false);
> >  	int this = smp_processor_id();
> >  	struct sched_domain *this_sd;
> > @@ -6134,7 +6159,12 @@ static int select_idle_cpu(struct task_struct *p,
> struct sched_domain *sd, int t
> >  	if (!this_sd)
> >  		return -1;
> >
> > -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +	if (!sched_cluster_active())
> > +		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +	if (sched_cluster_active())
> > +		cpumask_and(cpus, cpu_cluster_mask(target), p->cpus_ptr);
> > +#endif
> >
> >  	if (sched_feat(SIS_PROP) && !smt) {
> >  		u64 avg_cost, avg_idle, span_avg;
> > @@ -6155,24 +6185,32 @@ static int select_idle_cpu(struct task_struct *p,
> struct sched_domain *sd, int t
> >  		time = cpu_clock(this);
> >  	}
> >
> > -	for_each_cpu_wrap(cpu, cpus, target) {
> > -		if (smt) {
> > -			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > -			if ((unsigned int)i < nr_cpumask_bits)
> > -				return i;
> > +	/* scan cluster before scanning the whole llc */
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +	if (sched_cluster_active()) {
> > +		i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
> > +		if ((unsigned int) i < nr_cpumask_bits) {
> > +			idle_cpu = i;
> > +			goto done;
> > +		} else if (nr <= 0)
> > +			return -1;
> >
> > -		} else {
> > -			if (!--nr)
> > -				return -1;
> > -			idle_cpu = __select_idle_cpu(cpu);
> > -			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > -				break;
> > -		}
> > +		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +		cpumask_andnot(cpus, cpus, cpu_cluster_mask(target));
> >  	}
> > +#endif
> > +
> > +	i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
> > +	if ((unsigned int) i < nr_cpumask_bits) {
> > +		idle_cpu = i;
> > +		goto done;
> > +	} else if (nr <= 0)
> > +		return -1;
> >
> >  	if (smt)
> >  		set_idle_cores(this, false);
> >
> > +done:
> >  	if (sched_feat(SIS_PROP) && !smt) {
> >  		time = cpu_clock(this) - time;
> >  		update_avg(&this_sd->avg_scan_cost, time);
> 
> And this is just horrific :-(

I was actually quite struggling with this part.
Had tried a couple of ways before sending this.
Still the sent one was quite ugly.

Thanks
Barry

