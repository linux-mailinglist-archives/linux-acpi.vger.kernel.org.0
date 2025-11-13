Return-Path: <linux-acpi+bounces-18858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FAC573B7
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39613A9FF5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868D343D66;
	Thu, 13 Nov 2025 11:35:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9522EB5CE;
	Thu, 13 Nov 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033731; cv=none; b=NwEh5a6L3ZvVMd99x3WPR5+d2qb+RAmGxXKuYRPUzjP322WECpMhQo7z6GFtLO0icKqtvmCcrGfDSHQtulhxaW7Fig2jTXUxSzDKIGbSfe2g2s8bOSpPampafa+YMbGu0h593sE2M8DiZhW8llB7vWZ0OsIlAz3q5bwm/61d0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033731; c=relaxed/simple;
	bh=BsIsl7uZSSoVl+EV8NDm1bFnPU8qdtO9iT4JX+2siZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6rpy03BAg4OCwib1FAQg2fmIHrxgHQ6huCR6jmEEpXLlWrCxSsSmBf7IWBEXUAJAmpBZwgDHD5i287imhHulDuh3e4ZO6o2W1mzIR8mdDfXoSA3YIu90b0GQsIp0WnlPGlzFCdAzkz2PNIdO6IhUPE1Yt6otN1vK9r7qEaHeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E70312FC;
	Thu, 13 Nov 2025 03:35:21 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ADDE3F66E;
	Thu, 13 Nov 2025 03:35:28 -0800 (PST)
Date: Thu, 13 Nov 2025 11:35:22 +0000
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
Subject: Re: [PATCH v4 5/8] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited register
Message-ID: <aRXCelsE0kKi4uoU@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-6-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105113844.4086250-6-sumitg@nvidia.com>

Hi,

On Wednesday 05 Nov 2025 at 17:08:41 (+0530), Sumit Gupta wrote:
> Add sysfs interface to read/write the Performance Limited register.
> 
> The Performance Limited register indicates to the OS that an
> unpredictable event (like thermal throttling) has limited processor
> performance. This register is sticky and remains set until reset or
> OS clears it by writing 0.
> 
> The interface is exposed as:
>  /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

What is the intended use of this interface? The performance limited
register has a specific format of status bits with feedback about
performance being limited temporarily and the user can only clear it.

"Contains a resource descriptor with a single Register() descriptor
that describes the register to read to determine if performance was
limited. A nonzero value indicates performance was limited. This
register is sticky, and will remain set until reset or OSPM clears
it by writing 0. See the section “Performance Limiting” for more
details." Also, "The performance limited register should only be used
to report short term, unpredictable events (e.g., PROCHOT being
asserted)."

Therefore, I'm not seeing the value of exposing this via sysfs.

Thanks,
Ionela.

> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 12 ++++++++++++
>  include/acpi/cppc_acpi.h       | 10 ++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ef53eb8a1feb..9b8da3ef06db 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1810,6 +1810,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>  
> +/**
> + * cppc_get_perf_limited - Get the Performance Limited register value.
> + * @cpu: CPU from which to get Performance Limited register.
> + * @perf_limited: Pointer to store the Performance Limited value.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
> +
> +/**
> + * cppc_set_perf_limited() - Write the Performance Limited register.
> + * @cpu: CPU on which to write register.
> + * @perf_limited: Value to write to the perf_limited register.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_set_perf_limited(int cpu, u64 perf_limited)
> +{
> +	return cppc_set_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
> +
>  /**
>   * cppc_get_perf - Get a CPU's performance controls.
>   * @cpu: CPU for which to get performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index cde6202e9c51..a425ad575aa6 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1043,12 +1043,23 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, si
>  	return count;
>  }
>  
> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_perf_limited, buf);
> +}
> +
> +static ssize_t store_perf_limited(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_perf_limited, buf, count);
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
>  cpufreq_freq_attr_rw(min_perf);
>  cpufreq_freq_attr_rw(max_perf);
> +cpufreq_freq_attr_rw(perf_limited);
>  
>  static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&freqdomain_cpus,
> @@ -1057,6 +1068,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&energy_performance_preference_val,
>  	&min_perf,
>  	&max_perf,
> +	&perf_limited,
>  	NULL,
>  };
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index be7de1222eee..8baff46f2ac7 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -177,6 +177,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>  extern int cppc_set_min_perf(int cpu, u64 min_perf);
>  extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>  extern int cppc_set_max_perf(int cpu, u64 max_perf);
> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -285,6 +287,14 @@ static inline int cppc_set_max_perf(int cpu, u64 max_perf)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  {
>  	return -ENODEV;
> -- 
> 2.34.1
> 

