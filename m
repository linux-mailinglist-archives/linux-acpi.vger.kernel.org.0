Return-Path: <linux-acpi+bounces-18867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF260C586B0
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C33B4A242C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048B35471B;
	Thu, 13 Nov 2025 15:15:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44529D26E;
	Thu, 13 Nov 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046955; cv=none; b=e7dhhF2bZY5myA10jpPpX9/da3x2ADwXP4nF12Hdu8g5yLnK/QRxYO2hDnc9YIDp+o/J1wmIKPRZnXmUVjHw3TgObN3ZlFfNHE/aLMh5nT6bNaXwjI0Evh/TeBb2gKaTnO9Gu+0WstFO7wwT4/qr99bSkTcKhv9ojc4T72AizZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046955; c=relaxed/simple;
	bh=b2qgVXhlTqI+ms4L6K/w37wAIrhIfLu5uz7+Fp58pio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqTUWlK1izF2yjzwf7MVhl2JTHIpr9LqIVwlHkWOEvfcrcQqTqxVwZo0V+sF/5tGmalXNoVSoRCMJe8jlJHWz9+ahzqC9WpHW96r8iT+1bYebKQyBCYYAowaWtFYq+ea0n27aYbrirl8thnQhUlAfisyX3hF4TDpjmSQKzHIsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE6A12FC;
	Thu, 13 Nov 2025 07:15:45 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983693F66E;
	Thu, 13 Nov 2025 07:15:52 -0800 (PST)
Date: Thu, 13 Nov 2025 15:15:47 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
	bbasu@nvidia.com
Subject: Re: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter
 support
Message-ID: <aRX2Iz9+3oMZpX2K@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-9-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-9-sumitg@nvidia.com>

Hi,

As an overall comment, there are now various functions that modify the
autonomous selection configuration in various degrees:
cppc_cpufreq_update_autosel_config, cppc_cpufreq_update_auto_select,
cppc_cpufreq_set_epp_autosel_allcpus.

Are these all really necessary? Some seem single use functions that
make the intention very confusing through the use of several bool
parameters. I think a lot of this complexity can be avoided, so
I'd recommend to re-think the software design a bit.

I've added more details below (and I've skipped review of the previous
patch).

On Wednesday 05 Nov 2025 at 17:08:44 (+0530), Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection at system startup. When autonomous mode
> is enabled, the hardware automatically adjusts CPU performance based on
> workload demands using Energy Performance Preference (EPP) hints.
> 
> This parameter allows to configure the autonomous mode on all CPUs
> without requiring runtime sysfs manipulation if the 'auto_sel' register
> is present.
> 
> When auto_sel_mode=1:
> - All CPUs are configured for autonomous operation during module init
> - EPP is set to performance preference (0x0) by default
> - Min/max performance bounds use defaults
> - CPU frequency scaling is handled by hardware instead of OS governor
> 
> For Documentation/:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  12 ++
>  drivers/cpufreq/cppc_cpufreq.c                | 197 +++++++++++++++---
>  2 files changed, 182 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b8f8f5d74093..048f84008a7e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -929,6 +929,18 @@
>  			Format:
>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance selection.
> +			When enabled, hardware automatically adjusts CPU frequency
> +			on all CPUs based on workload demands. In Autonomous mode,
> +			Energy Performance Preference(EPP) hints guide hardware
> +			toward performance(0x0) or energy efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register support.
> +			Format: <bool>
> +			Default: 0 (disabled)
> +			0: use cpufreq governors
> +			1: enable if supoorted by hardware
> +
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
>  
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d1b44beaddda..0a55ab011317 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,8 +28,12 @@
>  #include <acpi/cppc_acpi.h>
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
> +
>  static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>  
> +/* Autonomous Selection */
> +static bool auto_sel_mode;
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
>  
> +	/*
> +	 * In autonomous selection mode, hardware handles frequency scaling directly
> +	 * based on workload and EPP hints. So, skip the OS frequency set requests.
> +	 */
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	if (!cpu_data->perf_caps.auto_sel)
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);

"When Autonomous Selection is enabled, it is not necessary for OSPM to assess
processor workload performance demand and convey a corresponding performance
delivery request to the platform via the Desired Register. If the Desired
Performance Register exists, OSPM may provide an explicit performance
requirement hint to the platform by writing a non-zero value."

Therefore I believe it's up to the platform to decide if it wants to use
the software hint.

>  	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>  
>  	if (ret)
> @@ -565,6 +574,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  		goto free_mask;
>  	}
>  
> +	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
> +		goto free_mask;
> +	}
> +

This belongs to patch 2/8.

>  	return cpu_data;
>  
>  free_mask:
> @@ -666,11 +681,81 @@ static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>  	return 0;
>  }
>  
> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy *policy, u32 epp)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	pr_debug("cpu%d, epp curr:%u, new:%u\n", cpu, cpu_data->perf_ctrls.energy_perf, epp);
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +
> +	ret = cppc_set_epp(cpu, epp);
> +	if (ret) {
> +		pr_warn("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
> +		return ret;
> +	}
> +	cpu_data->perf_ctrls.energy_perf = epp;
> +
> +	return 0;
> +}
> +
> +/**
> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection configuration
> + * @policy: cpufreq policy for the CPU
> + * @min_perf: minimum performance value to set
> + * @max_perf: maximum performance value to set
> + * @auto_sel: autonomous selection mode enable/disable (also controls min/max perf reg updates)
> + * @epp_val: energy performance preference value
> + * @update_epp: whether to update EPP register
> + * @update_policy: whether to update policy constraints
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
> +					      u64 min_perf, u64 max_perf, bool auto_sel,
> +					      u32 epp_val, bool update_epp, bool update_policy)
> +{
> +	const unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	/*
> +	 * Set min/max performance registers and update policy constraints.
> +	 *   When enabling: update both registers and policy.
> +	 *   When disabling: update policy only.
> +	 * Continue even if min/max are not supported, as EPP and autosel
> +	 * might still be supported.
> +	 */
> +	ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	if (update_epp) {
> +		ret = cppc_cpufreq_update_epp_val(policy, epp_val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", min_perf, max_perf, cpu);
> +
> +	return 0;
> +}

I think cppc_cpufreq_update_auto_select() can be removed and
cppc_cpufreq_update_autosel_config() used in its place. 

cppc_cpufreq_update_autosel_config() would not even need min/max as
arguments as they can be obtained from perf_caps (low/nominal range)
or perf_ctrls (current min/max). This would also simplify
cppc_cpufreq_cpu_init().

> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
>  	struct cppc_cpudata *cpu_data;
>  	struct cppc_perf_caps *caps;
> +	u64 min_perf, max_perf;
>  	int ret;
>  
>  	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	if (cpu_data->perf_caps.auto_sel) {
> +		ret = cppc_set_enable(cpu, true);

Isn't auto-sel enabled at this point? Also, if the auto-sel is
ACPI_TYPE_INTEGER, cppc_set_enable() will return an error,
isn't it?

> +		if (ret) {
> +			pr_err("Failed to enable CPPC on cpu%d (%d)\n", cpu, ret);
> +			goto out;

Do you really want to bail out of the rest of the cpufreq CPU
initialisation, if only auto-select configuration fails?

> +		}
> +
> +		min_perf = cpu_data->perf_ctrls.min_perf ?
> +			   cpu_data->perf_ctrls.min_perf : caps->lowest_nonlinear_perf;
> +		max_perf = cpu_data->perf_ctrls.max_perf ?
> +			   cpu_data->perf_ctrls.max_perf : caps->nominal_perf;
> +
> +		ret = cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, true,
> +							 CPPC_EPP_PERFORMANCE_PREF, true, false);
> +		if (ret) {
> +			cppc_set_enable(cpu, false);
> +			goto out;
> +		}
> +	} else {
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>  	}
>  
>  	cppc_cpufreq_cpu_fie_init(policy);
> @@ -910,7 +1015,6 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>  	u64 min_perf = caps->lowest_nonlinear_perf;
>  	u64 max_perf = caps->nominal_perf;
> -	int ret;
>  
>  	if (enable) {
>  		if (cpu_data->perf_ctrls.min_perf)
> @@ -919,26 +1023,8 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>  			max_perf = cpu_data->perf_ctrls.max_perf;
>  	}
>  
> -	/*
> -	 * Set min/max performance registers and update policy constraints.
> -	 *   When enabling: update both registers and policy.
> -	 *   When disabling: update policy only.
> -	 * Continue even if min/max are not supported, as EPP and autosel
> -	 * might still be supported.
> -	 */
> -	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
> -	if (ret && ret != -EOPNOTSUPP)
> -		return ret;
> -
> -	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
> -	if (ret && ret != -EOPNOTSUPP)
> -		return ret;
> -
> -	ret = cppc_cpufreq_update_autosel_val(policy, enable);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, enable,
> +						  0, false, true);
>  }
>  
>  static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.name = "cppc_cpufreq",
>  };
>  
> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
> +{
> +	int cpu, ret;
> +
> +	for_each_present_cpu(cpu) {
> +		ret = cppc_set_epp(cpu, epp);
> +		if (ret) {
> +			pr_warn("Failed to set EPP on CPU%d (%d)\n", cpu, ret);
> +			goto disable_all;
> +		}
> +
> +		ret = cppc_set_auto_sel(cpu, auto_sel);
> +		if (ret) {
> +			pr_warn("Failed to set auto_sel on CPU%d (%d)\n", cpu, ret);
> +			goto disable_all;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_all:
> +	pr_warn("Disabling auto_sel for all CPUs\n");
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +
> +	return -EIO;
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
> +	bool auto_sel;
>  	int ret;
>  
>  	if (!acpi_cpc_valid())
>  		return -ENODEV;
>  
> +	if (auto_sel_mode) {
> +		/*
> +		 * Check if autonomous selection is supported by testing CPU 0.
> +		 * If supported, enable autonomous mode on all CPUs.
> +		 */
> +		ret = cppc_get_auto_sel(0, &auto_sel);
> +		if (!ret) {
> +			pr_info("Enabling auto_sel_mode (autonomous selection mode)\n");
> +			ret = cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
> +			if (ret) {
> +				pr_warn("Disabling auto_sel_mode, fallback to standard\n");
> +				auto_sel_mode = false;
> +			}
> +		} else {
> +			pr_warn("Disabling auto_sel_mode as not supported by hardware\n");
> +			auto_sel_mode = false;
> +		}
> +	}
> +

Why not check at cppc_cpufreq_cpu_init? In the unlikely case that one
CPU does not support it, I would recommend to issue a warning, rather
than disable auto-sel on all the other CPUs. It is possible that some
CPUs support auto-sel and they have it enabled by default without
exposing that control to the OS. 

>  	cppc_freq_invariance_init();
>  	populate_efficiency_class();
>  
> @@ -1165,10 +1299,19 @@ static int __init cppc_cpufreq_init(void)
>  
>  static void __exit cppc_cpufreq_exit(void)
>  {
> +	int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +	auto_sel_mode = false;
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
> -- 
> 2.34.1
> 

