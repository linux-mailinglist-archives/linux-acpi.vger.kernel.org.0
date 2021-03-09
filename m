Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E073329D8
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhCIPKv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:10:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhCIPKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Mar 2021 10:10:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C2C1042;
        Tue,  9 Mar 2021 07:10:19 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753833F71B;
        Tue,  9 Mar 2021 07:10:19 -0800 (PST)
Date:   Tue, 9 Mar 2021 15:10:17 +0000
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
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/2] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210309151017.GA25243@arm.com>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
 <f72383d451710fc4bc36e7e3015deba40fbe28f3.1614580695.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72383d451710fc4bc36e7e3015deba40fbe28f3.1614580695.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

On Monday 01 Mar 2021 at 12:21:18 (+0530), Viresh Kumar wrote:
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
> freq_scale variable based on the counter updates since the last tick.
> 
> To allow platforms to disable frequency invariance support if they want,
                               ^
			       this CPPC counter-based frequency invariance
			       support..

(disabling this config will not disable cpufreq or arch counter-based FIE)

> this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE, which is enabled by
> default.
> 
> This also exports sched_setattr_nocheck() as the CPPC driver can be
> built as a module.
> 
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm    |   9 ++
>  drivers/cpufreq/cppc_cpufreq.c | 244 +++++++++++++++++++++++++++++++--
>  include/linux/arch_topology.h  |   1 +
>  kernel/sched/core.c            |   1 +
>  4 files changed, 243 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index e65e0a43be64..a3e2d6dfea70 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -19,6 +19,15 @@ config ACPI_CPPC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config ACPI_CPPC_CPUFREQ_FIE
> +	bool "Frequency Invariance support for CPPC cpufreq driver"
> +	depends on ACPI_CPPC_CPUFREQ

It also depends on GENERIC_ARCH_TOPOLOGY.

> +	default y
> +	help
> +	  This enables frequency invariance support for CPPC cpufreq driver.
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^
						    s//based on CPPC counters.

.. or more detailed: This extends frequency invariance support in the
CPPC cpufreq driver, by using CPPC delivered and reference performance
counters.

> +
> +	  If in doubt, say N.
> +
>  config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>  	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
>  	depends on ARCH_SUNXI
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a482c434ea6..c4580a37a1b1 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
[..]
> +static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
> +					     struct cppc_cpudata *cpu_data)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int i;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	for_each_cpu(i, policy->cpus) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, i);
> +		cppc_fi->cpu = i;
> +		cppc_fi->cpu_data = cpu_data;
> +		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +	}
> +}
> +
> +static void cppc_freq_invariance_exit(void)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int i;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
> +
> +	for_each_possible_cpu(i) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, i);
> +		irq_work_sync(&cppc_fi->irq_work);
> +	}
> +
> +	kthread_destroy_worker(kworker_fie);
> +	kworker_fie = NULL;
> +}
> +
> +static void __init cppc_freq_invariance_init(void)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +	struct cppc_freq_invariance *cppc_fi;
> +	struct sched_attr attr = {
> +		.size		= sizeof(struct sched_attr),
> +		.sched_policy	= SCHED_DEADLINE,
> +		.sched_nice	= 0,
> +		.sched_priority	= 0,
> +		/*
> +		 * Fake (unused) bandwidth; workaround to "fix"
> +		 * priority inheritance.
> +		 */
> +		.sched_runtime	= 1000000,
> +		.sched_deadline = 10000000,
> +		.sched_period	= 10000000,
> +	};
> +	int i, ret;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	kworker_fie = kthread_create_worker(0, "cppc_fie");
> +	if (IS_ERR(kworker_fie))
> +		return;
> +
> +	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
> +	if (ret) {
> +		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
> +			ret);
> +		kthread_destroy_worker(kworker_fie);
> +		return;
> +	}
> +

Nit: to me it makes more sense to move the code below to 
cppc_freq_invariance_policy_init(). It seems a bit strange to do part of
the initialization of the per-cpu information there, and part here. But
I do understand the reasons for it. Moving the code below would also
save some cycles going through the CPUs again and will mimic the
frequency invariance setup process in the arm64 topology, where we do
amu_fie_setup() at policy creation time.

It's not a big deal so I'll leave it up to you.

> +	for_each_possible_cpu(i) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, i);
> +
> +		/* A policy failed to initialize, abort */
> +		if (unlikely(!cppc_fi->cpu_data))
> +			return cppc_freq_invariance_exit();
> +
> +		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> +		if (ret) {
> +			pr_warn("%s: failed to read perf counters: %d\n",
> +				__func__, ret);
> +			return cppc_freq_invariance_exit();
> +		}
> +
> +		cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> +	}
> +
> +	/* Register for freq-invariance */
> +	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
> +}

After another very quick round of testing:

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

I did not get the chance to test on ThunderX2 yet, but if you are happy
with your testing on it, I won't delay this any further.

Thanks,
Ionela.
