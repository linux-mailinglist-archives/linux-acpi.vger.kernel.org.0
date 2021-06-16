Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5423A9AEE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhFPMuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 08:50:17 -0400
Received: from foss.arm.com ([217.140.110.172]:36376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhFPMuO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 08:50:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895321042;
        Wed, 16 Jun 2021 05:48:08 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 296883F719;
        Wed, 16 Jun 2021 05:48:08 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:48:06 +0100
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
Subject: Re: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210616124806.GA6495@arm.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I was looking forward to the complete removal of stop_cpu() :).

On Wednesday 16 Jun 2021 at 12:18:09 (+0530), Viresh Kumar wrote:
> The Frequency Invariance Engine (FIE) is providing a frequency scaling
> correction factor that helps achieve more accurate load-tracking.
> 
> Normally, this scaling factor can be obtained directly with the help of
> the cpufreq drivers as they know the exact frequency the hardware is
> running at. But that isn't the case for CPPC cpufreq driver.
> 
> Another way of obtaining that is using the arch specific counter
> support, which is already present in kernel, but that hardware is
> optional for platforms.
> 
> This patch updates the CPPC driver to register itself with the topology
> core to provide its own implementation (cppc_scale_freq_tick()) of
> topology_scale_freq_tick() which gets called by the scheduler on every
> tick. Note that the arch specific counters have higher priority than
> CPPC counters, if available, though the CPPC driver doesn't need to have
> any special handling for that.
> 
> On an invocation of cppc_scale_freq_tick(), we schedule an irq work
> (since we reach here from hard-irq context), which then schedules a
> normal work item and cppc_scale_freq_workfn() updates the per_cpu
> arch_freq_scale variable based on the counter updates since the last
> tick.
> 
> To allow platforms to disable this CPPC counter-based frequency
> invariance support, this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE,
> which is enabled by default.
> 
> This also exports sched_setattr_nocheck() as the CPPC driver can be
> built as a module.
> 
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm    |  10 ++
>  drivers/cpufreq/cppc_cpufreq.c | 232 ++++++++++++++++++++++++++++++---
>  include/linux/arch_topology.h  |   1 +
>  kernel/sched/core.c            |   1 +
>  4 files changed, 227 insertions(+), 17 deletions(-)
> 
[..]
> +static void cppc_cpufreq_start_cpu(struct cpufreq_policy *policy,
> +				   unsigned int cpu)
> +{
> +	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +	int ret;
> +
> +	cppc_fi->cpu = cpu;
> +	cppc_fi->cpu_data = policy->driver_data;
> +	kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +	init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +
> +	ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> +	if (ret) {
> +		pr_warn("%s: failed to read perf counters: %d\n", __func__,
> +			ret);
> +		return;
> +	}
> +
> +	/* Register for freq-invariance */
> +	topology_set_scale_freq_source(&cppc_sftd, cpumask_of(cpu));
> +}
> +
> +static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy,
> +				  unsigned int cpu)
> +{
> +	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpumask_of(cpu));
> +
> +	irq_work_sync(&cppc_fi->irq_work);
> +	kthread_cancel_work_sync(&cppc_fi->work);
> +}

I'll only comment on this for now as I should know the rest.

Let's assume we don't have these, what happens now is the following:

1. We hotplug out the last CPU in a policy, we call the
   .stop_cpu()/exit() function which will free the cppc_cpudata structure.

   The only vulnerability is if we have a last tick on that last CPU,
   after the above callback was called.

2. When the CPU at 1. gets hotplugged back in, the cppc_fi->cpu_data is
   stale.

We do not have a problem when removing the CPPC cpufreq module as we're
doing cppc_freq_invariance_exit() before unregistering the driver and
freeing the data.

Are 1. and 2 the only problems we have, or have I missed any?

Thanks,
Ionela.
