Return-Path: <linux-acpi+bounces-18856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10EC57118
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713FE3A7F37
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7439337113;
	Thu, 13 Nov 2025 10:56:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC13346A1;
	Thu, 13 Nov 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031418; cv=none; b=DHVj/Suzqk/e0+lt7/A9kKynqOne0h7XlPGJCNy3htd4Sq3eVntn0JZ6UB8WyE/j6opN+fpGfaHzh1XDkH3IoG7M8NlCfd19QjMM6TK7163SYneiHFUp1WDjqecV1UQkQtEIRtTX0tGBipTjf27oxrcAO+uYrdCRXyOtyaMK6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031418; c=relaxed/simple;
	bh=wwla/DfICk8GpawwzmuHDrOrFU5Yu+Eo/4wBqE+pOAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6WQSNDVcKMeyf6+D+0DySDzrs8hPXzNhKP6UktVhU+QGukgP9o4elhNpd/0lhv+MxGkg3V9NuSELeVUfDonKKQGNaoYuHsqrBMpjdQF2dJ17sVpjuR6QpDLUSXMMD0bxsoX32tVMC3jw8ZSk0dMHrn6ZDxbX8r6juO7jZrD76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 671D212FC;
	Thu, 13 Nov 2025 02:56:48 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B298A3F66E;
	Thu, 13 Nov 2025 02:56:55 -0800 (PST)
Date: Thu, 13 Nov 2025 10:56:54 +0000
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
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
Message-ID: <aRW5dhyN5/JF3F3i@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-5-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-5-sumitg@nvidia.com>

Hi,

On Wednesday 05 Nov 2025 at 17:08:40 (+0530), Sumit Gupta wrote:
> CPPC allows platforms to specify minimum and maximum performance
> limits that constrain the operating range for CPU performance scaling
> when Autonomous Selection is enabled. These limits can be dynamically
> adjusted to implement power management policies or workload-specific
> optimizations.
> 
> Add cppc_get_min_perf() and cppc_set_min_perf() functions to read and
> write the MIN_PERF register, allowing dynamic adjustment of the minimum
> performance floor.
> 
> Add cppc_get_max_perf() and cppc_set_max_perf() functions to read and
> write the MAX_PERF register, enabling dynamic ceiling control for
> maximum performance.
> 
> Expose these capabilities through cpufreq sysfs attributes that accept
> frequency values in kHz (which are converted to/from performance values
> internally):
> - /sys/.../cpufreq/policy*/min_perf: Read/write min perf as freq (kHz)
> - /sys/.../cpufreq/policy*/max_perf: Read/write max perf as freq (kHz)
> 

There's a theoretical problem here for CPUFREQ_SHARED_TYPE_ANY, when
multiple CPUs share a policy, but that existed before your
patches :). Almost all of the files exposed by cppc_cpufreq should be
per-CPU and not per policy: auto_select, energy_performance_preference,
etc., and now min_perf, max_perf and perf_limited.

In practice it's likely not a problem as all CPUs that have P-State
dependencies would likely share all of these controls. But that's not
mandated by the ACPI specification.

> The frequency-based interface provides a user-friendly abstraction which
> is similar to other cpufreq sysfs interfaces, while the driver handles
> conversion to hardware performance values.
> 
> Also update EPP constants for better clarity:
> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       |  55 ++++++++++-
>  drivers/cpufreq/cppc_cpufreq.c | 166 +++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  23 ++++-
>  3 files changed, 242 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 757e8ce87e9b..ef53eb8a1feb 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1634,7 +1634,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   */
>  int cppc_set_epp(int cpu, u64 epp_val)
>  {
> -	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>  		return -EINVAL;
>  
>  	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> @@ -1757,6 +1757,59 @@ int cppc_set_enable(int cpu, bool enable)
>  	return cppc_set_reg_val(cpu, ENABLE, enable);
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
> +/**
> + * cppc_get_min_perf - Get the min performance register value.
> + * @cpu: CPU from which to get min performance.
> + * @min_perf: Return address.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
> +
> +/**
> + * cppc_set_min_perf() - Write the min performance register.
> + * @cpu: CPU on which to write register.
> + * @min_perf: Value to write to the MIN_PERF register.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_set_min_perf(int cpu, u64 min_perf)
> +{
> +	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
> +
> +/**
> + * cppc_get_max_perf - Get the max performance register value.
> + * @cpu: CPU from which to get max performance.
> + * @max_perf: Return address.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
> +
> +/**
> + * cppc_set_max_perf() - Write the max performance register.
> + * @cpu: CPU on which to write register.
> + * @max_perf: Value to write to the MAX_PERF register.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_set_max_perf(int cpu, u64 max_perf)
> +{
> +	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
> +
>  /**
>   * cppc_get_perf - Get a CPU's performance controls.
>   * @cpu: CPU for which to get performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index cf3ed6489a4f..cde6202e9c51 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -23,10 +23,12 @@
>  #include <uapi/linux/sched/types.h>
>  
>  #include <linux/unaligned.h>
> +#include <linux/cleanup.h>
>  
>  #include <acpi/cppc_acpi.h>
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>  
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
> @@ -582,6 +584,68 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>  	policy->driver_data = NULL;
>  }
>  
> +/**
> + * cppc_cpufreq_set_mperf_limit - Generic function to set min/max performance limit
> + * @policy: cpufreq policy
> + * @val: performance value to set
> + * @update_reg: whether to update hardware register
> + * @update_policy: whether to update policy constraints
> + * @is_min: true for min_perf, false for max_perf
> + */
> +static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
> +					bool update_reg, bool update_policy, bool is_min)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	unsigned int cpu = policy->cpu;
> +	struct freq_qos_request *req;
> +	unsigned int freq;
> +	u32 perf;
> +	int ret;
> +
> +	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
> +	freq = cppc_perf_to_khz(caps, perf);
> +
> +	pr_debug("cpu%d, %s_perf:%llu, update_reg:%d, update_policy:%d\n", cpu,
> +		 is_min ? "min" : "max", (u64)perf, update_reg, update_policy);
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +
> +	if (update_reg) {
> +		ret = is_min ? cppc_set_min_perf(cpu, perf) : cppc_set_max_perf(cpu, perf);
> +		if (ret) {
> +			if (ret != -EOPNOTSUPP)
> +				pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
> +					is_min ? "min" : "max", (u64)perf, cpu, ret);
> +			return ret;
> +		}
> +
> +		if (is_min)
> +			cpu_data->perf_ctrls.min_perf = perf;
> +		else
> +			cpu_data->perf_ctrls.max_perf = perf;
> +	}
> +
> +	if (update_policy) {
> +		req = is_min ? policy->min_freq_req : policy->max_freq_req;
> +
> +		ret = freq_qos_update_request(req, freq);
> +		if (ret < 0) {
> +			pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
> +				is_min ? "min" : "max", cpu, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, true)
> +
> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
> @@ -881,16 +945,118 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
>  	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp, buf, count);
>  }
>  
> +/**
> + * show_min_perf - Show minimum performance as frequency (kHz)
> + *
> + * Reads the MIN_PERF register and converts the performance value to
> + * frequency (kHz) for user-space consumption.
> + */
> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_min_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_min_perf - Set minimum performance from frequency (kHz)
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MIN_PERF register.
> + */
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	ret = cppc_cpufreq_set_min_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * show_max_perf - Show maximum performance as frequency (kHz)
> + *
> + * Reads the MAX_PERF register and converts the performance value to
> + * frequency (kHz) for user-space consumption.
> + */
> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_max_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_max_perf - Set maximum performance from frequency (kHz)
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MAX_PERF register.
> + */
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);

Can you give me some details around updating the policy limits when
auto-select is true? I suppose if P-state selection is autonomous, the
policy limits should not matter, right?

Thanks,
Ionela.

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
> +cpufreq_freq_attr_rw(min_perf);
> +cpufreq_freq_attr_rw(max_perf);
>  
>  static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&freqdomain_cpus,
>  	&auto_select,
>  	&auto_act_window,
>  	&energy_performance_preference_val,
> +	&min_perf,
> +	&max_perf,
>  	NULL,
>  };
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 42e37a84cac9..be7de1222eee 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -39,7 +39,8 @@
>  /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>  #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>  
> -#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +#define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>  
>  /* Each register has the folowing format. */
>  struct cpc_reg {
> @@ -172,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
> +extern int cppc_set_min_perf(int cpu, u64 min_perf);
> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
> +extern int cppc_set_max_perf(int cpu, u64 max_perf);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -264,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_min_perf(int cpu, u64 min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_max_perf(int cpu, u64 max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  {
>  	return -ENODEV;
> -- 
> 2.34.1
> 

