Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1E32A4D5
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446552AbhCBLSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380848AbhCBKpL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 05:45:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE012C061788;
        Tue,  2 Mar 2021 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/q+RIdKN1LdajCwadS8XdJgE0yGcOCCHDjF8uy/Zjd0=; b=S7z3H9Rn85JuD+MdFyxrbbCcAD
        jCXZWlLbl8MXwNC6hkZoLgBiV4/07BttpjiqqjQOGJa4GePPzHF44x36TXAxv8PP/0zYwHLcl5tD6
        UsPxwdBxvmNQg9yAPsJ6FxwF49BYuTaxYWnM0nynl+4S8R1//vszFKmFR7+QZy6STkiZQHbebUUUa
        RdlN7VfFDLPZoTluCaDtRmAPRSgBzSaTKI/tQnwEu97ebRWglaydCVNr6sLINpgfQPfNZ7MtmY5O+
        EAx4uhfV45j8nompMHNxVgZCMdq7AVyBXDcSJKYeWVSUCghJpegEPnbNEKwqzhSrzMeGVYFgabPKV
        E8DQIDmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH2Uu-00GxYY-9R; Tue, 02 Mar 2021 10:43:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F335E30011C;
        Tue,  2 Mar 2021 11:43:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC9872027C1AA; Tue,  2 Mar 2021 11:43:14 +0100 (CET)
Date:   Tue, 2 Mar 2021 11:43:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     tim.c.chen@linux.intel.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        lenb@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, msys.mizuma@gmail.com,
        valentin.schneider@arm.com, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
Subject: Re: [RFC PATCH v4 2/3] scheduler: add scheduler level for clusters
Message-ID: <YD4WwrlVNwlSj/Zn@hirez.programming.kicks-ass.net>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301225940.16728-3-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 11:59:39AM +1300, Barry Song wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 88a2e2b..d805e59 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7797,6 +7797,16 @@ int sched_cpu_activate(unsigned int cpu)
>  	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
>  		static_branch_inc_cpuslocked(&sched_smt_present);
>  #endif
> +
> +#ifdef CONFIG_SCHED_CLUSTER
> +	/*
> +	 * When going up, increment the number of cluster cpus with
> +	 * cluster present.
> +	 */
> +	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
> +		static_branch_inc_cpuslocked(&sched_cluster_present);
> +#endif
> +
>  	set_cpu_active(cpu, true);
>  
>  	if (sched_smp_initialized) {
> @@ -7873,6 +7883,14 @@ int sched_cpu_deactivate(unsigned int cpu)
>  		static_branch_dec_cpuslocked(&sched_smt_present);
>  #endif
>  
> +#ifdef CONFIG_SCHED_CLUSTER
> +	/*
> +	 * When going down, decrement the number of cpus with cluster present.
> +	 */
> +	if (cpumask_weight(cpu_cluster_mask(cpu)) > 1)
> +		static_branch_dec_cpuslocked(&sched_cluster_present);
> +#endif
> +
>  	if (!sched_smp_initialized)
>  		return 0;

I don't think that's correct. IIUC this will mean the
sched_cluster_present thing will be enabled on anything with SMT (very
much including x86 big cores after the next patch).

I'm thinking that at the very least you should check a CLS domain
exists, but that might be hard at this point, because the sched domains
haven't been build yet.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b..3db7b07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6009,6 +6009,11 @@ static inline int __select_idle_cpu(int cpu)
>  	return -1;
>  }
>  
> +#ifdef CONFIG_SCHED_CLUSTER
> +DEFINE_STATIC_KEY_FALSE(sched_cluster_present);
> +EXPORT_SYMBOL_GPL(sched_cluster_present);

I really rather think this shouldn't be exported

> +#endif
> +
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);

This is a KVM wart, it needs to know because mitigation crap.

> @@ -6116,6 +6121,26 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>  
>  #endif /* CONFIG_SCHED_SMT */
>  
> +static inline int _select_idle_cpu(bool smt, struct task_struct *p, int target, struct cpumask *cpus, int *idle_cpu, int *nr)
> +{
> +	int cpu, i;
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
> +		if (smt) {
> +			i = select_idle_core(p, cpu, cpus, idle_cpu);
> +		} else {
> +			if (!--*nr)
> +				return -1;
> +			i = __select_idle_cpu(cpu);
> +		} 
> +
> +		if ((unsigned int)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6124,7 +6149,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	int i, idle_cpu = -1, nr = INT_MAX;
>  	bool smt = test_idle_cores(target, false);
>  	int this = smp_processor_id();
>  	struct sched_domain *this_sd;
> @@ -6134,7 +6159,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
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
> @@ -6155,24 +6185,32 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		time = cpu_clock(this);
>  	}
>  
> -	for_each_cpu_wrap(cpu, cpus, target) {
> -		if (smt) {
> -			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> -			if ((unsigned int)i < nr_cpumask_bits)
> -				return i;
> +	/* scan cluster before scanning the whole llc */
> +#ifdef CONFIG_SCHED_CLUSTER
> +	if (sched_cluster_active()) {
> +		i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
> +		if ((unsigned int) i < nr_cpumask_bits) {
> +			idle_cpu = i;
> +			goto done;
> +		} else if (nr <= 0)
> +			return -1;
>  
> -		} else {
> -			if (!--nr)
> -				return -1;
> -			idle_cpu = __select_idle_cpu(cpu);
> -			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> -				break;
> -		}
> +		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +		cpumask_andnot(cpus, cpus, cpu_cluster_mask(target));
>  	}
> +#endif
> +
> +	i = _select_idle_cpu(smt, p, target, cpus, &idle_cpu, &nr);
> +	if ((unsigned int) i < nr_cpumask_bits) {
> +		idle_cpu = i;
> +		goto done;
> +	} else if (nr <= 0)
> +		return -1;
>  
>  	if (smt)
>  		set_idle_cores(this, false);
>  
> +done:
>  	if (sched_feat(SIS_PROP) && !smt) {
>  		time = cpu_clock(this) - time;
>  		update_avg(&this_sd->avg_scan_cost, time);

And this is just horrific :-(
