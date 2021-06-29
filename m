Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF13B6FA7
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhF2IuG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 04:50:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhF2IuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 04:50:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746A6D6E;
        Tue, 29 Jun 2021 01:47:39 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150BB3F694;
        Tue, 29 Jun 2021 01:47:38 -0700 (PDT)
Date:   Tue, 29 Jun 2021 09:47:37 +0100
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
Message-ID: <20210629084737.GB2425@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
 <20210625165418.shi3gkebumqllxma@vireshk-i7>
 <20210628104929.GA29595@arm.com>
 <20210629043244.xkjat5dqqjaixkii@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629043244.xkjat5dqqjaixkii@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

On Tuesday 29 Jun 2021 at 10:02:44 (+0530), Viresh Kumar wrote:
> On 28-06-21, 11:49, Ionela Voinescu wrote:
> > To be honest I would like to have more time on this before you merge the
> > set, to better understand Qian's results and some observations I have
> > for Thunder X2 (I will share in a bit).
> 
> Ideally, this code was already merged in 5.13 and would have required
> us to fix any problems as we encounter them. I did revert it because
> it caused a kernel crash and I wasn't sure if there was a sane/easy
> way of fixing that so late in the release cycle. That was the right
> thing to do then.
> 
> All those issues are gone now, we may have an issue around rounding of
> counters or some hardware specific issues, it isn't clear yet.
> 
> But the stuff works fine otherwise, doesn't make the kernel crash and
> it is controlled with a CONFIG_ option, so those who don't want to use
> it can still disable it.
> 
> The merge window is here now, if we don't merge it now, it gets
> delayed by a full cycle (roughly two months) and if we merge it now
> and are able to narrow down the rounding issues, if there are any, we
> will have full two months to make a fix for that and still push it in
> 5.14 itself.
> 
> And so I would like to get it merged in this merge window itself, it
> also makes sure more people would get to test it, like Qian was able
> to figure out a problem here for us.
> 

Okay, makes sense. I have not seen this code actually do anything wrong
so far, and the issues I see on ThunderX2 point more to misbehaving
counters for this purpose. This being said, I would have probably
preferred for this feature to be disabled by default, until we've tested
more, but that won't give the chance to anyone else to test.

> > For the code, I think it's fine. I have a single observation regarding
> > the following code:
> > 
> > > +static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> > > +{
> > > +	struct cppc_freq_invariance *cppc_fi;
> > > +	int cpu, ret;
> > > +
> > > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > > +		return;
> > > +
> > > +	for_each_cpu(cpu, policy->cpus) {
> > > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> > > +		cppc_fi->cpu = cpu;
> > > +		cppc_fi->cpu_data = policy->driver_data;
> > > +		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> > > +		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> > > +
> > > +		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> > > +		if (ret) {
> > > +			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
> > > +				__func__, cpu, ret);
> > > +			return;
> > > +		}
> > 
> > For this condition above, think about a scenario where reading counters
> > for offline CPUs returns an error. I'm not sure if that can happen, to
> > be honest. That would mean here that you will never initialise the freq
> > source unless all CPUs in the policy are online at policy creation.
> > 
> > My recommendation is to warn about the failed read of perf counters but
> > only return from this function if the target CPU is online as well when
> > reading counters fails.
> > 
> > This is probably a nit, so I'll let you decide if you want to do something
> > about this.
> 
> That is a very good observation actually. Thanks for that. This is how
> I fixed it.
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d688877e8fbe..f6540068d0fe 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -171,7 +171,13 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>                 if (ret) {
>                         pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
>                                 __func__, cpu, ret);
> -                       return;
> +
> +                       /*
> +                        * Don't abort if the CPU was offline while the driver
> +                        * was getting registered.
> +                        */
> +                       if (cpu_online(cpu))
> +                               return;
>                 }
>         }
> 
> -- 

Thanks!

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Ionela.

> viresh
