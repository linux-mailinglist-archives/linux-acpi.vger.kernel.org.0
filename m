Return-Path: <linux-acpi+bounces-19855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3293DCDE791
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A78A3000B16
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C28A314A6E;
	Fri, 26 Dec 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eX5igWEe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94663148C8;
	Fri, 26 Dec 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766736231; cv=none; b=LLMsF8sD1FCO9wkfEhRdq7mt+7QKBgBdSg+eWUB+48HHL7v6mEp35rZSvBg+oiP0gw44wTaJLuH74awksh0Lyx087jAZLRGtN6/TYi231okmqS25PkZAmnLy4YiCnFjcMC3qaPcNUdQlPX+vPpgRkpjvqIPeqYhHFkDYNtoa4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766736231; c=relaxed/simple;
	bh=NNtcSaymVfb+eeXD+ID6HdTKYpdAZqMMojsf1gOSp5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PxMqhrUKf0g1dBdnrXt208AYMnNuShTPpwxkSdbNafkh920DvNFSscLUQucbGvRFLaWSsND2mNPUMTVMp39CvD29fhpkSL73CT4zsh88fnYqi9AwqxY6cZ49e4X375qJzxjY583zWm/0BwJ0NBPYrJK2dkIxWfJx528IWorkA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eX5igWEe; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yr33QlKfyzpoEI3opWrGPCwz6K45y5MtWloabdDJsYs=;
	b=eX5igWEe88qSEW5scW/+bRuLCxXMSVK2HTq+/1I05IQxh55LC56HxfXLLpOXS27G95zZHZkOS
	r7Igd+y6GGS+H4PslOzrdL7qGsLTlPEjpSSRzTih0FKpnN7nq6gAIHCHKtRe/poeaIEcxCST6eL
	8cERpNX+JvlyYhzZI1WB0JI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcyht0FrbzKm6H;
	Fri, 26 Dec 2025 16:00:30 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id C983E40539;
	Fri, 26 Dec 2025 16:03:38 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Dec
 2025 16:03:37 +0800
Message-ID: <3887747b-214e-45e5-9f85-d4e20a5e2e68@huawei.com>
Date: Fri, 26 Dec 2025 16:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] cpufreq: CPPC: add autonomous mode boot
 parameter support
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <pierre.gondois@arm.com>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-12-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-12-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection on all CPUs at system startup without
> requiring runtime sysfs manipulation. When autonomous mode is enabled,
> the hardware automatically adjusts CPU performance based on workload
> demands using Energy Performance Preference (EPP) hints.
> 
> When auto_sel_mode=1:
> - All CPUs are configured for autonomous operation during init
> - EPP is set to performance preference (0x0) by default
> - Min/max performance bounds use defaults or already set values
> - CPU frequency scaling is handled by hardware instead of OS governor
> 
> The boot parameter is applied only during first policy initialization.
> User's runtime sysfs configuration is preserved across hotplug.
> 
> For Documentation/:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 13 +++
>  drivers/cpufreq/cppc_cpufreq.c                | 85 +++++++++++++++++--
>  2 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index aab72efa1acd..450f0b0225dc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1035,6 +1035,19 @@ Kernel parameters
>  			Format:
>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register support.
> +			Format: <bool>
> +			Default: 0 (disabled)
> +			0: use cpufreq governors
> +			1: enable if supported by hardware
> +
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
>  
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b3da263c18b0..8c6869e68504 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -30,6 +30,9 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>  
>  static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>  
> +/* Autonomous Selection boot parameter */
> +static bool auto_sel_mode;
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -643,11 +646,16 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>   * cppc_cpufreq_update_autosel_config - Update autonomous selection config
>   * @policy: cpufreq policy
>   * @is_auto_sel: enable/disable autonomous selection
> + * @epp_val: EPP value (used only if update_epp true)
> + * @update_epp: whether to update EPP register
> + * @update_policy: whether to update policy constraints
>   *
>   * Return: 0 on success, negative error code on failure
>   */
>  static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
> -					      bool is_auto_sel)
> +					      bool is_auto_sel, u32 epp_val,
> +					      bool update_epp,
> +					      bool update_policy)

cppc_cpufreq_set_mperf_limit() and cppc_cpufreq_update_autosel_config()
have too much bool input param. Just break them down into several separate
functions and call them only when needed. These two functions are now too
hard to read.

>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> @@ -655,7 +663,6 @@ static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>  	u64 max_perf = caps->nominal_perf;
>  	unsigned int cpu = policy->cpu;
>  	bool update_reg = is_auto_sel;
> -	bool update_policy = true;
>  	int ret;
>  
>  	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> @@ -685,6 +692,17 @@ static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>  	if (ret && ret != -EOPNOTSUPP)
>  		return ret;
>  
> +	/* Update EPP register */
> +	if (update_epp) {
> +		ret = cppc_set_epp(cpu, epp_val);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
> +			return ret;
> +		}
> +		if (!ret)
> +			cpu_data->perf_ctrls.energy_perf = epp_val;
> +	}
> +
>  	/* Update auto_sel register */
>  	ret = cppc_set_auto_sel(cpu, is_auto_sel);
>  	if (ret && ret != -EOPNOTSUPP) {
> @@ -816,11 +834,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	/*
> +	 * Enable autonomous mode on first init if boot param is set.
> +	 * Check last_governor to detect first init and skip if auto_sel
> +	 * is already enabled.
> +	 */
> +	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
> +	    !cpu_data->perf_ctrls.auto_sel) {
> +		/* Enable CPPC - optional register, some platforms need it */
> +		ret = cppc_set_enable(cpu, true);
> +		if (ret) {
> +			if (ret == -EOPNOTSUPP)
> +				pr_debug("CPPC enable not supported CPU%d\n",
> +					 cpu);
> +			else
> +				pr_warn("Failed enable CPPC CPU%d (%d)\n",
> +					cpu, ret);
> +		}
> +
> +		/*
> +		 * Enable autonomous mode; Pass false for update_policy to avoid
> +		 * updating policy limits prematurely as they are not yet fully setup.
> +		 */
> +		ret = cppc_cpufreq_update_autosel_config(policy,
> +							 true,  /* is_auto_sel */
> +							 CPPC_EPP_PERFORMANCE_PREF,
> +							 true,  /* update_epp */
> +							 false); /* update_policy */
> +		if (ret)
> +			pr_warn("Failed autonomous config CPU%d (%d)\n",
> +				cpu, ret);
> +	}
> +
> +	/* If auto mode is enabled, sync policy limits with HW registers */
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		policy->min = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.min_perf ?:
> +					       caps->lowest_nonlinear_perf);
> +		policy->max = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.max_perf ?:
> +					       caps->nominal_perf);
> +	} else {
> +		/* Standard mode: governors control frequency */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d CPU:%d ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>  	}
>  
>  	cppc_cpufreq_cpu_fie_init(policy);
> @@ -991,7 +1052,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>  	if (ret)
>  		return ret;
>  
> -	ret = cppc_cpufreq_update_autosel_config(policy, val);
> +	ret = cppc_cpufreq_update_autosel_config(policy, val, 0, false, true);
>  	if (ret)
>  		return ret;
>  
> @@ -1253,10 +1314,18 @@ static int __init cppc_cpufreq_init(void)
>  
>  static void __exit cppc_cpufreq_exit(void)
>  {
> +	unsigned int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +
>  	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>  	cppc_freq_invariance_exit();
>  }
>  
> +module_param(auto_sel_mode, bool, 0000);
> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
> +
>  module_exit(cppc_cpufreq_exit);
>  MODULE_AUTHOR("Ashwin Chaugule");
>  MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");


