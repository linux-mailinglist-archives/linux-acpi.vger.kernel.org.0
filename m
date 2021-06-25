Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73853B3FD6
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFYI5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 04:57:17 -0400
Received: from foss.arm.com ([217.140.110.172]:50524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhFYI5R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 04:57:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6903331B;
        Fri, 25 Jun 2021 01:54:56 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 058393F719;
        Fri, 25 Jun 2021 01:54:55 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:54:54 +0100
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
Message-ID: <20210625085454.GA15540@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

On Thursday 24 Jun 2021 at 18:34:18 (+0530), Viresh Kumar wrote:
> On 24-06-21, 10:48, Ionela Voinescu wrote:
> > On Monday 21 Jun 2021 at 14:49:37 (+0530), Viresh Kumar wrote:
> > > The Frequency Invariance Engine (FIE) is providing a frequency scaling
> > > correction factor that helps achieve more accurate load-tracking.
> > [..]
> > > +static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> > > +{
> > > +	struct cppc_freq_invariance *cppc_fi;
> > > +	int cpu;
> > > +
> > > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > > +		return;
> > > +
> > > +	/* policy->cpus will be empty here, use related_cpus instead */
> > > +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
> > > +
> > > +	for_each_cpu(cpu, policy->related_cpus) {
> > > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> > 
> > Do you think it might be worth having here something like:
> > 
> > 		if (!cppc_fi->cpu_data)
> > 			continue;
> > 
> > This would be to protect against cases where the platform does not boot
> > with all CPUs or the module is loaded after some have already been
> > offlined. Unlikely, but..
> 
> Even in that case policy->cpus will contain all offline+online CPUs (at ->init()
> time), isn't it ?
> 

Right, my bad. I missed cpumask_and(policy->cpus, policy->cpus,
cpu_online_mask) being done after init(). It logically seems a bit
wrong, but drivers are in control of setting policy->cpus and acting on
it, and in this case the driver does the right thing.

Thanks,
Ionela.

> > > +		irq_work_sync(&cppc_fi->irq_work);
> > > +		kthread_cancel_work_sync(&cppc_fi->work);
> > > +	}
> > > +}
> > 
> > The rest of the code is almost the same as the original, so that is all
> > from me :).
> > 
> > Thanks,
> > Ionela.
> 
> -- 
> viresh
