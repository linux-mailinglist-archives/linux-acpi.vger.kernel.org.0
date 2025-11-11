Return-Path: <linux-acpi+bounces-18774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8EDC4D6A9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988643A6F65
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7043570B7;
	Tue, 11 Nov 2025 11:30:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC92FD1CE;
	Tue, 11 Nov 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860625; cv=none; b=aI4PWKZ40wIOSJaY3oLd3pS9tdIX6+v83n3bXBPTrtTEq7Gy+hjMEyxPI7G6HtNFtDHgHPRIRsd/hBiLOXtvlQm2HpYchq7S5kXHxqn2PbVaQ1dw/4+0Uemj+pIlbIK3Ibxk6aLLi2gh7jrxT1h9wG2i1BYV8OmOKwi5A+wLfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860625; c=relaxed/simple;
	bh=mMDVYG9hHoSFptMqJptOJhed/7/j/h46E4OUb7rvRgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kyJknIYi/qxk+WJ2GMUmrKQYdJwUVibgBdK6OjGKmw/KFfmE0FccR4lKSlylDQ9B3OaOzzk5z4vsHNkPRPKFachNfxUq8qm/jIq/xFVV4DuJOKb5AHutMBJK88OSbpDkvgyv3eogR52m9Hn8CKf73k5olETvLz1f1Q6cTc1aJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d5PRY3JTXzcZyM;
	Tue, 11 Nov 2025 19:28:25 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 4457D14027A;
	Tue, 11 Nov 2025 19:30:13 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Nov
 2025 19:30:11 +0800
Message-ID: <e439d370-48a3-40c3-ae54-67d2f844bae5@hisilicon.com>
Date: Tue, 11 Nov 2025 19:30:09 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for
 non-PCC regs
To: Beata Michalska <beata.michalska@arm.com>
CC: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhenglifeng1@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>
References: <20251104065039.1675549-1-zhanjie9@hisilicon.com>
 <aRIXlSOPzAy1nXUQ@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
Content-Language: en-US
In-Reply-To: <aRIXlSOPzAy1nXUQ@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 11/11/2025 12:49 AM, Beata Michalska wrote:
> Hi Jie,
> On Tue, Nov 04, 2025 at 02:50:39PM +0800, Jie Zhan wrote:
>> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
>> scheduler tick but defers the update of arch_freq_scale to a separate
>> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
>>
>> However, this deferred update mechanism is unnecessary and introduces extra
>> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
>> accessing the regs won't sleep and can be safely performed from the tick
>> context.
>>
>> Furthermore, with the CPPC FIE registered, it throws repeated warnings of
>> "cppc_scale_freq_workfn: failed to read perf counters" on our platform with
>> the CPC regs in System Memory and a power-down idle state enabled.  That's
>> because the remote CPU can be in a power-down idle state, and reading its
>> perf counters returns 0.  Moving the FIE handling back to the scheduler
>> tick process makes the CPU handle its own perf counters, so it won't be
>> idle and the issue would be inherently solved.
>>
>> To address the above issues, update arch_freq_scale directly in ticks for
>> non-PCC regs and keep the deferred update mechanism for PCC regs.
> Something about it just didn’t sit right with me, and apparently, it needed some
> time to settle down - thus the delay.
> 
> It all looks sensible though it might be worth to considered applying
> the change on a per-CPU basis, as, in theory at least, different address
> spaces are allowed for different registers (at least according to the ACPI
> spec, if I read it right).
> So I was thinking about smth along the lines of:
Beata,

Right, I see what you want to do.
Some comments inline.

Would you like to make it a full patch so I can include it in the next
version? or some other way?

Jie
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6c684e54fe01..07f4e59f2f0a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1431,38 +1431,47 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>   *
>   * Return: true if any of the counters are in PCC regions, false otherwise
>   */
> -bool cppc_perf_ctrs_in_pcc(void)
> +bool cppc_perf_ctrs_in_pcc(unsigned int cpu)
>  {
> -	int cpu;
> +	struct cpc_register_resource *ref_perf_reg;
> +	struct cpc_desc *cpc_desc;
>  
> -	for_each_present_cpu(cpu) {
> -		struct cpc_register_resource *ref_perf_reg;
> -		struct cpc_desc *cpc_desc;
> +	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  
> -		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> +		return true;
>  
> -		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> -		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> -		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> -			return true;
>  
> +	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
>  
> -		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +	/*
> +	 * If reference perf register is not supported then we should
> +	 * use the nominal perf value
> +	 */
> +	if (!CPC_SUPPORTED(ref_perf_reg))
> +		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
Though not related to this issue, I'm confused that this sort of workaround
appears here - it should be in some init function.
>  
> -		/*
> -		 * If reference perf register is not supported then we should
> -		 * use the nominal perf value
> -		 */
> -		if (!CPC_SUPPORTED(ref_perf_reg))
> -			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +	if (CPC_IN_PCC(ref_perf_reg))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>  
> -		if (CPC_IN_PCC(ref_perf_reg))
> +bool cppc_any_perf_ctrs_in_pcc(void)
> +{
> +	int cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		if (cppc_perf_ctrs_in_pcc(cpu))
>  			return true;
>  	}
>  
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +EXPORT_SYMBOL_GPL(cppc_any_perf_ctrs_in_pcc);
>  
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4fcaec7e2034..fdf5a49c04ed 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -48,7 +48,6 @@ struct cppc_freq_invariance {
>  };
>  
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
> -static bool perf_ctrs_in_pcc;
>  static struct kthread_worker *kworker_fie;
>  
>  static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> @@ -132,7 +131,12 @@ static void cppc_scale_freq_tick_pcc(void)
>  
>  static void cppc_scale_freq_tick(void)
>  {
> -	__cppc_scale_freq_tick(&per_cpu(cppc_freq_inv, smp_processor_id()));
> +	unsigned int cpu = smp_processor_id();
> +
> +	cppc_perf_ctrs_in_pcc(cpu) ? cppc_scale_freq_tick_pcc()
Calling cppc_perf_ctrs_in_pcc() could be expensive here.
I'd prefer something like a static branch or a determined callback for each
cpu.
> +				   : __cppc_scale_freq_tick(
> +				   			&per_cpu(cppc_freq_inv,
> +				   				 cpu));
>  }
>  
>  static struct scale_freq_data cppc_sftd = {
> @@ -152,7 +156,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>  		cppc_fi->cpu = cpu;
>  		cppc_fi->cpu_data = policy->driver_data;
> -		if (perf_ctrs_in_pcc) {
> +		if (cppc_perf_ctrs_in_pcc(cpu)) {
>  			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
>  			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
>  		}
> @@ -193,10 +197,9 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	/* policy->cpus will be empty here, use related_cpus instead */
>  	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
>  
> -	if (!perf_ctrs_in_pcc)
> -		return;
> -
>  	for_each_cpu(cpu, policy->related_cpus) {
> +		if (!cppc_perf_ctrs_in_pcc(cpu))
> +			continue;
>  		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>  		irq_work_sync(&cppc_fi->irq_work);
>  		kthread_cancel_work_sync(&cppc_fi->work);
> @@ -218,14 +221,11 @@ static void __init cppc_freq_invariance_init(void)
>  		.sched_deadline = 10 * NSEC_PER_MSEC,
>  		.sched_period	= 10 * NSEC_PER_MSEC,
>  	};
> +	bool perf_ctrs_in_pcc = cppc_any_perf_ctrs_in_pcc();
>  	int ret;
>  
> -	perf_ctrs_in_pcc = cppc_perf_ctrs_in_pcc();
> -
>  	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
> -		if (!perf_ctrs_in_pcc) {
> -			fie_disabled = FIE_ENABLED;
> -		} else {
> +		if (perf_ctrs_in_pcc) {
>  			pr_info("FIE not enabled on systems with registers in PCC\n");
>  			fie_disabled = FIE_DISABLED;
>  		}
> @@ -234,12 +234,12 @@ static void __init cppc_freq_invariance_init(void)
>  	if (fie_disabled || !perf_ctrs_in_pcc)
>  		return;
>  
> -	cppc_sftd.set_freq_scale = cppc_scale_freq_tick_pcc;
>  
>  	kworker_fie = kthread_run_worker(0, "cppc_fie");
>  	if (IS_ERR(kworker_fie)) {
>  		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
>  			PTR_ERR(kworker_fie));
> +		kworker_fie = NULL;
>  		fie_disabled = FIE_DISABLED;
>  		return;
>  	}
> @@ -255,10 +255,8 @@ static void __init cppc_freq_invariance_init(void)
>  
>  static void cppc_freq_invariance_exit(void)
>  {
> -	if (fie_disabled || !perf_ctrs_in_pcc)
> -		return;
> -
> -	kthread_destroy_worker(kworker_fie);
> +	if (kworker_fie)
> +		kthread_destroy_worker(kworker_fie);
>  }
>  
>  #else
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 13fa81504844..3af503b12f60 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -154,7 +154,8 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> -extern bool cppc_perf_ctrs_in_pcc(void);
> +extern bool cppc_perf_ctrs_in_pcc(unsigned int cpu);
> +extern bool cppc_any_perf_ctrs_in_pcc(void);
would be slightly better to keep cppc_perf_ctrs_in_pcc(void) and add a new
function, e.g. cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu), such that the
old ABI is unchanged.
>  extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
>  extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
>  extern bool acpi_cpc_valid(void);
> @@ -204,7 +205,11 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline bool cppc_perf_ctrs_in_pcc(void)
> +static inline bool cppc_perf_ctrs_in_pcc(unsigned int cpu)
> +{
> +	return false;
> +}
> +static inline bool cppc_any_perf_ctrs_in_pcc(void)
>  {
>  	return false;
>  }
> 
> 
> Additionally, it might be worth to get rid of (at least) some messages printed
> on the path of reading the counters in case it is being done in tick context.
Cool, will have a look.
> 
> Also , I do not have access to any machine using PCC, and it would be good to
> double check that as well.
> 
> ---
> BR
> Beata

>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>> We have tested this on Kunpeng SoCs with the CPC regs both in System Memory
>> and FFH.  More tests on other platforms are welcome.
>>
>> Changelog:
>>
>> v3:
>> - Stash the state of 'cppc_perf_ctrs_in_pcc' so it won't have to check the CPC
>>   regs of all CPUs everywhere (Thanks to the suggestion from Beata Michalska).
>> - Update the commit log, explaining more on the warning issue caused by
>>   accessing perf counters on remote CPUs.
>> - Drop Patch 1 that has been accepted, and rebase Patch 2 on that.
>>
>> v2:
>> https://lore.kernel.org/linux-pm/20250828110212.2108653-1-zhanjie9@hisilicon.com/
>> - Update the cover letter and the commit log based on v1 discussion
>> - Update FIE arch_freq_scale in ticks for non-PCC regs
>>
>> v1:
>> https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 60 ++++++++++++++++++++++++----------
>>  1 file changed, 42 insertions(+), 18 deletions(-)
...

