Return-Path: <linux-acpi+bounces-18371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A6C204E1
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 14:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6D560F80
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC2255F52;
	Thu, 30 Oct 2025 13:41:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF72512D7;
	Thu, 30 Oct 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831669; cv=none; b=r+vu2W6QRadWg/2cW6UrKvCDMOK1q/t71SaXkP6eX6AEOeWLMoL3M2hzitmTfV/dQqP9BtP7jhahQ9jJpfp1+dgpObIf498igk/MrX55sDESgkMMK1QKs96ba1qCdtyf/0f8sfU0qqIut9pQXMglVimWK+3x5+NY67+N+GXjOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831669; c=relaxed/simple;
	bh=hzm/Id2y1VJcXDmD80EVO1LsHG4CVJ9Fx3ejcvQaMQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAIBqzpm7Rd0QqJQ+K17buq/Lap8Munv1AfKbeqmc0crWg+4KF2P/j+/CB2cuMC1Z9ScF5vREKMBEAncPqimEiwggnZH6ZKBwDGA6hxfl8cw5bodY/kEowJ3e/0SxRa8lAmC5OJYBKlrAQ19KV7S6CK0a5MffPbC3RGrpwCv1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9211EDB;
	Thu, 30 Oct 2025 06:40:58 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31F363F673;
	Thu, 30 Oct 2025 06:41:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:41:02 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, ionela.voinescu@arm.com,
	zhenglifeng1@huawei.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Update FIE arch_freq_scale in
 ticks for non-PCC regs
Message-ID: <aQNq7uwVCtFfBDMJ@arm.com>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-3-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828110212.2108653-3-zhanjie9@hisilicon.com>

Hi Jie,
On Thu, Aug 28, 2025 at 07:02:12PM +0800, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
> 
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.  Also, reading perf counters of a remote CPU may return 0 if it's
> in a low-power idle state, e.g. power down or reset.
I'm not sure how this is relevant to the changes (?)
> 
> Update arch_freq_scale directly in ticks for non-PCC regs and keep the
> deferred update mechanism for PCC regs.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 52 +++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7724318b3415..66d74b062ceb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -55,31 +55,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>  
>  /**
> - * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
> - * @work: The work item.
> + * __cppc_scale_freq_tick - CPPC arch_freq_scale updater for frequency invariance
> + * @cppc_fi: per-cpu CPPC FIE data.
>   *
> - * The CPPC driver register itself with the topology core to provide its own
> + * The CPPC driver registers itself with the topology core to provide its own
>   * implementation (cppc_scale_freq_tick()) of topology_scale_freq_tick() which
>   * gets called by the scheduler on every tick.
>   *
>   * Note that the arch specific counters have higher priority than CPPC counters,
>   * if available, though the CPPC driver doesn't need to have any special
>   * handling for that.
> - *
> - * On an invocation of cppc_scale_freq_tick(), we schedule an irq work (since we
> - * reach here from hard-irq context), which then schedules a normal work item
> - * and cppc_scale_freq_workfn() updates the per_cpu arch_freq_scale variable
> - * based on the counter updates since the last tick.
>   */
> -static void cppc_scale_freq_workfn(struct kthread_work *work)
> +static void __cppc_scale_freq_tick(struct cppc_freq_invariance *cppc_fi)
>  {
> -	struct cppc_freq_invariance *cppc_fi;
>  	struct cppc_perf_fb_ctrs fb_ctrs = {0};
>  	struct cppc_cpudata *cpu_data;
>  	unsigned long local_freq_scale;
>  	u64 perf;
>  
> -	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
>  	cpu_data = cppc_fi->cpu_data;
>  
>  	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> @@ -104,6 +97,14 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>  	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
>  }
>  
> +static void cppc_scale_freq_workfn(struct kthread_work *work)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +
> +	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> +	__cppc_scale_freq_tick(cppc_fi);
> +}
> +
>  static void cppc_irq_work(struct irq_work *irq_work)
>  {
>  	struct cppc_freq_invariance *cppc_fi;
> @@ -112,7 +113,14 @@ static void cppc_irq_work(struct irq_work *irq_work)
>  	kthread_queue_work(kworker_fie, &cppc_fi->work);
>  }
>  
> -static void cppc_scale_freq_tick(void)
> +/*
> + * Reading perf counters may sleep if the CPC regs are in PCC.  Thus, we
> + * schedule an irq work in scale_freq_tick (since we reach here from hard-irq
> + * context), which then schedules a normal work item cppc_scale_freq_workfn()
> + * that updates the per_cpu arch_freq_scale variable based on the counter
> + * updates since the last tick.
> + */
> +static void cppc_scale_freq_tick_pcc(void)
>  {
>  	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
>  
> @@ -123,6 +131,11 @@ static void cppc_scale_freq_tick(void)
>  	irq_work_queue(&cppc_fi->irq_work);
>  }
>  
> +static void cppc_scale_freq_tick(void)
> +{
> +	__cppc_scale_freq_tick(&per_cpu(cppc_freq_inv, smp_processor_id()));
> +}
> +
>  static struct scale_freq_data cppc_sftd = {
>  	.source = SCALE_FREQ_SOURCE_CPPC,
>  	.set_freq_scale = cppc_scale_freq_tick,
> @@ -140,8 +153,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>  		cppc_fi->cpu = cpu;
>  		cppc_fi->cpu_data = policy->driver_data;
> -		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> -		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +		if (cppc_perf_ctrs_in_pcc()) {
I'm wondering if we really need to go through all present cpus every time this
check is needed. Maybe the result of it could be stashed somehow, especially now
that more invocations are added.

---
BR
Beata
> +			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> +			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> +		}
>  
>  		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>  		if (ret && cpu_online(cpu)) {
> @@ -174,6 +189,9 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	/* policy->cpus will be empty here, use related_cpus instead */
>  	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
>  
> +	if (!cppc_perf_ctrs_in_pcc())
> +		return;
> +
>  	for_each_cpu(cpu, policy->related_cpus) {
>  		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>  		irq_work_sync(&cppc_fi->irq_work);
> @@ -206,9 +224,11 @@ static void __init cppc_freq_invariance_init(void)
>  		}
>  	}
>  
> -	if (fie_disabled)
> +	if (fie_disabled || !cppc_perf_ctrs_in_pcc())
>  		return;
>  
> +	cppc_sftd.set_freq_scale = cppc_scale_freq_tick_pcc;
> +
>  	kworker_fie = kthread_run_worker(0, "cppc_fie");
>  	if (IS_ERR(kworker_fie)) {
>  		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
> @@ -228,7 +248,7 @@ static void __init cppc_freq_invariance_init(void)
>  
>  static void cppc_freq_invariance_exit(void)
>  {
> -	if (fie_disabled)
> +	if (fie_disabled || !cppc_perf_ctrs_in_pcc())
>  		return;
>  
>  	kthread_destroy_worker(kworker_fie);
> -- 
> 2.33.0
> 

