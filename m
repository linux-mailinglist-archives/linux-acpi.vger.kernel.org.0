Return-Path: <linux-acpi+bounces-18081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADBBFB7EB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 12:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8791F3A39A5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1F3233EE;
	Wed, 22 Oct 2025 10:59:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9011287246;
	Wed, 22 Oct 2025 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130742; cv=none; b=sSntbMnqSrOHZtqtWDDGGMtHH6IAmUipzJOoug58i8VfWvf8Wm/aLSP0qm8osFcqg8nWUDLr3wfkqJ0kF4VP+KK2Sk1DZTLYNqNH8ICQW3Sj/W4PjQMxx2gN6BRVt7zTU3EBuVAnpZnvvyCNekhRqcg8NebFuWvf5cD/8/FpOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130742; c=relaxed/simple;
	bh=jIUZb6aAmxrrEHsEvpWk/MNIk0riJs9b8xLA/wwDV5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjaQzrzBFPRVJkYbvE8/I3rc5QAI+fZr149wPPzsgHnaa5fTWA+4InYAN72YB15Akw76+d5yKEesCHu2O0V5xlx5WuwgroeAjhRZove/+u9N1dn4bJQ54DmylU3sO6ddHcg7Nv7CZ8wygfwwMb2fkmMjUJUZzONZ8hOMgCuc9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013861063;
	Wed, 22 Oct 2025 03:58:52 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E20D3F59E;
	Wed, 22 Oct 2025 03:58:59 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:58:57 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
	sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v3 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
Message-ID: <aPi48fm+cMDmQBN9@arm.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-5-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001150104.1275188-5-sumitg@nvidia.com>

On Wednesday 01 Oct 2025 at 20:31:00 (+0530), Sumit Gupta wrote:
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
> Expose these capabilities through cpufreq sysfs attributes:
> - /sys/.../cpufreq/policy*/min_perf: Read/write min performance limit
> - /sys/.../cpufreq/policy*/max_perf: Read/write max performance limit
> 
> Also update EPP constants for better clarity:
> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       |  55 +++++++++++++++-
>  drivers/cpufreq/cppc_cpufreq.c | 115 +++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  23 ++++++-
>  3 files changed, 191 insertions(+), 2 deletions(-)
> 
[..]
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 732f35096991..864978674efc 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -23,6 +23,7 @@
>  #include <uapi/linux/sched/types.h>
>  
>  #include <linux/unaligned.h>
> +#include <linux/cleanup.h>
>  
>  #include <acpi/cppc_acpi.h>
>  
> @@ -38,6 +39,8 @@ static enum {
>  module_param(fie_disabled, int, 0444);
>  MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
>  
> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);

Should this be under CONFIG_ACPI_CPPC_CPUFREQ_FIE?

> +
>  /* Frequency invariance support */
>  struct cppc_freq_invariance {
>  	int cpu;
> @@ -572,6 +575,70 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
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
> +		if (ret == -EOPNOTSUPP)
> +			return 0;

Should we return success here? The user will have no feedback that
setting min/max performance limits is not supported.

> +		if (ret) {
> +			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
> +				is_min ? "min" : "max", (u64)perf, cpu, ret);
> +			return ret;
> +		}
> +
> +		/* Update cached value only on success */
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
> @@ -873,16 +940,64 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
>  	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
>  }
>  
> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_min_perf, buf);
> +}
> +
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_min_perf(policy, val, true, cpu_data->perf_caps.auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_max_perf, buf);
> +}
> +
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, val, true, cpu_data->perf_caps.auto_sel);

These "work" on the performance scale, so the values read are
performance values and the values that should be provided should be
performance values as well. How is the user supposed to know what that
scale is and what is the range of values it can provide? All of the
other sysfs interfaces work on the "frequency" scale and the lowest and
highest performance values are never exposed to the user.

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
> index 3babc6d6e70a..fc7614eb9dcb 100644
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
> 

