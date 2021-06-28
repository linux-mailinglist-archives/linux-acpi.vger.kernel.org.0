Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D443B5CB6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jun 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhF1Kv5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Jun 2021 06:51:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhF1Kv4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Jun 2021 06:51:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC94D6E;
        Mon, 28 Jun 2021 03:49:31 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B06E63F694;
        Mon, 28 Jun 2021 03:49:30 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:49:29 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210628104929.GA29595@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
 <20210625165418.shi3gkebumqllxma@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625165418.shi3gkebumqllxma@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday 25 Jun 2021 at 22:24:18 (+0530), Viresh Kumar wrote:
> On 25-06-21, 09:54, Ionela Voinescu wrote:
> > Hey,
> > 
> > On Thursday 24 Jun 2021 at 18:34:18 (+0530), Viresh Kumar wrote:
> > > On 24-06-21, 10:48, Ionela Voinescu wrote:
> > > > On Monday 21 Jun 2021 at 14:49:37 (+0530), Viresh Kumar wrote:
> > > > > The Frequency Invariance Engine (FIE) is providing a frequency scaling
> > > > > correction factor that helps achieve more accurate load-tracking.
> > > > [..]
> > > > > +static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> > > > > +{
> > > > > +	struct cppc_freq_invariance *cppc_fi;
> > > > > +	int cpu;
> > > > > +
> > > > > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > > > > +		return;
> > > > > +
> > > > > +	/* policy->cpus will be empty here, use related_cpus instead */
> > > > > +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
> > > > > +
> > > > > +	for_each_cpu(cpu, policy->related_cpus) {
> > > > > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> > > > 
> > > > Do you think it might be worth having here something like:
> > > > 
> > > > 		if (!cppc_fi->cpu_data)
> > > > 			continue;
> > > > 
> > > > This would be to protect against cases where the platform does not boot
> > > > with all CPUs or the module is loaded after some have already been
> > > > offlined. Unlikely, but..
> > > 
> > > Even in that case policy->cpus will contain all offline+online CPUs (at ->init()
> > > time), isn't it ?
> > > 
> > 
> > Right, my bad. I missed cpumask_and(policy->cpus, policy->cpus,
> > cpu_online_mask) being done after init(). It logically seems a bit
> > wrong, but drivers are in control of setting policy->cpus and acting on
> > it, and in this case the driver does the right thing.
> 
> Do you want me to re-add your Reviewed-by here ?
> 

To be honest I would like to have more time on this before you merge the
set, to better understand Qian's results and some observations I have
for Thunder X2 (I will share in a bit).

For the code, I think it's fine. I have a single observation regarding
the following code:

> +static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int cpu, ret;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	for_each_cpu(cpu, policy->cpus) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +		cppc_fi->cpu = cpu;
> +		cppc_fi->cpu_data = policy->driver_data;
> +		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +
> +		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> +		if (ret) {
> +			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
> +				__func__, cpu, ret);
> +			return;
> +		}

For this condition above, think about a scenario where reading counters
for offline CPUs returns an error. I'm not sure if that can happen, to
be honest. That would mean here that you will never initialise the freq
source unless all CPUs in the policy are online at policy creation.

My recommendation is to warn about the failed read of perf counters but
only return from this function if the target CPU is online as well when
reading counters fails.

This is probably a nit, so I'll let you decide if you want to do something
about this.

Thanks,
Ionela.

> +	}
> +
> +	/* Register for freq-invariance */
> +	topology_set_scale_freq_source(&cppc_sftd, policy->cpus);
> +}



> -- 
> viresh
