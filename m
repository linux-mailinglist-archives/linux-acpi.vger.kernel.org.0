Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713953ACAC6
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 14:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhFRM2c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 08:28:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhFRM2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 08:28:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FF61424;
        Fri, 18 Jun 2021 05:26:22 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6A93F719;
        Fri, 18 Jun 2021 05:26:21 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:26:20 +0100
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
Message-ID: <20210618122620.GA16826@arm.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
 <20210617103415.GA29877@arm.com>
 <20210618073713.dd7ipbgxkuq4inki@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618073713.dd7ipbgxkuq4inki@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

On Friday 18 Jun 2021 at 13:07:13 (+0530), Viresh Kumar wrote:
> On 17-06-21, 11:34, Ionela Voinescu wrote:
> > We can't queue any more work for it as there's no tick for the offline
> > CPU.
> 
> Okay, so as discussed yesterday and confirmed by Peter, CPU hotplug shouldn't be
> a problem and we can avoid handling that here. Good.
> 
> The patch 1/3 from this series is not required anymore. I will get rid of
> stop_cpu() as well.
> 
> The second patch stays as is, as I still don't see another way of fixing the
> same problem on policy ->exit(). We still need that guarantee from topology
> core.
>

Right! That is because we need to make sure the tick does not queue any
more irq work while we do our cleanup (irq_work_sync() and then
kthread_cancel_work_sync()). Then kthread_cancel_work_sync() would
ensure the last worker wraps up so we can free the data.

I was hoping to avoid this but I don't currently see another way either.

> > P.S. I'll give more thought to the rcu use in the arch_topology driver.
> > I'm the boring kind that likes to err on the side of caution, so I tend
> > to agree that it might be good to have even if the current problem could
> > be solved in this driver.
> 
> Before I resend the series again, maybe it is better to align on the idea here
> itself first (as I need to fix some existing potential memleaks in policy
> ->init() first). So here is the new diff, looks okay now ?
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index be4f62e2c5f1..3e9070f107c5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -10,14 +10,18 @@
>  
>  #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
>  
> +#include <linux/arch_topology.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/dmi.h>
> +#include <linux/irq_work.h>
> +#include <linux/kthread.h>
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
> +#include <uapi/linux/sched/types.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -57,6 +61,214 @@ static struct cppc_workaround_oem_info wa_info[] = {
>  	}
>  };
>  
> +#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> +
> +/* Frequency invariance support */
> +struct cppc_freq_invariance {
> +	int cpu;
> +	struct irq_work irq_work;
> +	struct kthread_work work;
> +	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
> +	struct cppc_cpudata *cpu_data;
> +};
> +
> +static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
> +static struct kthread_worker *kworker_fie;
> +
> +static struct cpufreq_driver cppc_cpufreq_driver;
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
> +static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> +				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
> +
> +/**
> + * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
> + * @work: The work item.
> + *
> + * The CPPC driver register itself with the topology core to provide its own
> + * implementation (cppc_scale_freq_tick()) of topology_scale_freq_tick() which
> + * gets called by the scheduler on every tick.
> + *
> + * Note that the arch specific counters have higher priority than CPPC counters,
> + * if available, though the CPPC driver doesn't need to have any special
> + * handling for that.
> + *
> + * On an invocation of cppc_scale_freq_tick(), we schedule an irq work (since we
> + * reach here from hard-irq context), which then schedules a normal work item
> + * and cppc_scale_freq_workfn() updates the per_cpu arch_freq_scale variable
> + * based on the counter updates since the last tick.
> + */
> +static void cppc_scale_freq_workfn(struct kthread_work *work)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> +	struct cppc_cpudata *cpu_data;
> +	unsigned long local_freq_scale;
> +	u64 perf;
> +
> +	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> +	cpu_data = cppc_fi->cpu_data;
> +
> +	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> +		pr_warn("%s: failed to read perf counters\n", __func__);
> +		return;
> +	}
> +
> +	perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
> +				     &fb_ctrs);
> +	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> +
> +	perf <<= SCHED_CAPACITY_SHIFT;
> +	local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
> +
> +	/* This can happen due to counter overflows */
> +	if (unlikely(local_freq_scale > 1024))
> +		local_freq_scale = 1024;
> +
> +	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
> +}
> +
> +static void cppc_irq_work(struct irq_work *irq_work)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +
> +	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
> +	kthread_queue_work(kworker_fie, &cppc_fi->work);
> +}
> +
> +static void cppc_scale_freq_tick(void)
> +{
> +	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
> +
> +	/*
> +	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
> +	 * context.
> +	 */
> +	irq_work_queue(&cppc_fi->irq_work);
> +}
> +
> +static struct scale_freq_data cppc_sftd = {
> +	.source = SCALE_FREQ_SOURCE_CPPC,
> +	.set_freq_scale = cppc_scale_freq_tick,
> +};
> +
> +static int cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int cpu, ret;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return 0;
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
> +
> +			/* Avoid failing driver's probe because of FIE */
> +			return 0;
> +		}
> +	}
> +
> +	/* Register for freq-invariance */
> +	topology_set_scale_freq_source(&cppc_sftd, policy->cpus);
> +	return 0;
> +}
> +
> +/*
> + * We free all the resources on policy's removal and not on CPU removal as the
> + * irq-work are per-cpu and the hotplug core takes care of flushing the pending
> + * irq-works (hint: smpcfd_dying_cpu()) on CPU hotplug. Even if the kthread-work
> + * fires on another CPU after the concerned CPU is removed, it won't harm.
> + *
> + * We just need to make sure to remove them all on policy->exit().
> + */
> +static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int cpu;
> +
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	/* policy->cpus will be empty here, use related_cpus instead */
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
> +
> +	for_each_cpu(cpu, policy->related_cpus) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +		irq_work_sync(&cppc_fi->irq_work);
> +		kthread_cancel_work_sync(&cppc_fi->work);
> +	}
> +}

Yep, looks good (with its call on cppc_cpufreq_cpu_exit()).

Feel free to post V3 and I'll take an even closer look during testing.

Thanks,
Ionela.


> +
> +static void __init cppc_freq_invariance_init(void)
> +{
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
> +	int ret;
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
> +}
> +
> +static void cppc_freq_invariance_exit(void)
> +{
> +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +		return;
> +
> +	kthread_destroy_worker(kworker_fie);
> +	kworker_fie = NULL;
> +}
> +
> +#else
> +static inline int cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> +{
> +}
> +
> +static inline void cppc_freq_invariance_init(void)
> +{
> +}
> +
> +static inline void cppc_freq_invariance_exit(void)
> +{
> +}
> +#endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
> +
>  /* Callback function used to retrieve the max frequency from DMI */
>  static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
>  {
> @@ -324,11 +536,13 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret)
> +	if (ret) {
>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>  			 caps->highest_perf, cpu, ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return cppc_cpufreq_cpu_fie_init(policy);
>  }
>  
>  static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> @@ -338,6 +552,8 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  	unsigned int cpu = policy->cpu;
>  	int ret;
>  
> +	cppc_cpufreq_cpu_fie_exit(policy);
> +
>  	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
>  
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> @@ -362,26 +578,35 @@ static inline u64 get_delta(u64 t1, u64 t0)
>  	return (u32)t1 - (u32)t0;
>  }
>  
> -static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> -				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> +				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>  {
>  	u64 delta_reference, delta_delivered;
> -	u64 reference_perf, delivered_perf;
> +	u64 reference_perf;
>  
> -	reference_perf = fb_ctrs_t0.reference_perf;
> +	reference_perf = fb_ctrs_t0->reference_perf;
>  
> -	delta_reference = get_delta(fb_ctrs_t1.reference,
> -				    fb_ctrs_t0.reference);
> -	delta_delivered = get_delta(fb_ctrs_t1.delivered,
> -				    fb_ctrs_t0.delivered);
> +	delta_reference = get_delta(fb_ctrs_t1->reference,
> +				    fb_ctrs_t0->reference);
> +	delta_delivered = get_delta(fb_ctrs_t1->delivered,
> +				    fb_ctrs_t0->delivered);
>  
> -	/* Check to avoid divide-by zero */
> -	if (delta_reference || delta_delivered)
> -		delivered_perf = (reference_perf * delta_delivered) /
> -					delta_reference;
> -	else
> -		delivered_perf = cpu_data->perf_ctrls.desired_perf;
> +	/* Check to avoid divide-by zero and invalid delivered_perf */
> +	if (!delta_reference || !delta_delivered)
> +		return cpu_data->perf_ctrls.desired_perf;
> +
> +	return (reference_perf * delta_delivered) / delta_reference;
> +}
> +
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
> +{
> +	u64 delivered_perf;
> +
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
> +					       fb_ctrs_t1);
>  
>  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> @@ -405,7 +630,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  	if (ret)
>  		return ret;
>  
> -	return cppc_get_rate_from_fbctrs(cpu_data, fb_ctrs_t0, fb_ctrs_t1);
> +	return cppc_get_rate_from_fbctrs(cpu_data, &fb_ctrs_t0, &fb_ctrs_t1);
>  }
>  
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> @@ -506,14 +731,21 @@ static void cppc_check_hisi_workaround(void)
>  
>  static int __init cppc_cpufreq_init(void)
>  {
> +	int ret;
> +
>  	if ((acpi_disabled) || !acpi_cpc_valid())
>  		return -ENODEV;
>  
>  	INIT_LIST_HEAD(&cpu_data_list);
>  
>  	cppc_check_hisi_workaround();
> +	cppc_freq_invariance_init();
>  
> -	return cpufreq_register_driver(&cppc_cpufreq_driver);
> +	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
> +	if (ret)
> +		cppc_freq_invariance_exit();
> +
> +	return ret;
>  }
>  
>  static inline void free_cpu_data(void)
> @@ -531,6 +763,7 @@ static inline void free_cpu_data(void)
>  static void __exit cppc_cpufreq_exit(void)
>  {
>  	cpufreq_unregister_driver(&cppc_cpufreq_driver);
> +	cppc_freq_invariance_exit();
>  
>  	free_cpu_data();
>  }
> 
> -- 
> viresh
