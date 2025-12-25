Return-Path: <linux-acpi+bounces-19845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC0CDD8EB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A813014DBB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB8314A95;
	Thu, 25 Dec 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fmaAjlER"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7632F90C4;
	Thu, 25 Dec 2025 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653403; cv=none; b=XW63n8Ozug6Piysyj1EPyhtEdbUjIWF5FqvkSK8Mp2maGd/wOpt4g24wjF1vEzXcFz2fQ0Nm9PXw8RDOsltFJJ4TsVaRgT9aRDDcTwZEAR4vKXgs0VE07NX6SlfcPWn+bEBWY9gxFJxCi8+YoDDtD0yc48myNJxPx2Zeol81/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653403; c=relaxed/simple;
	bh=E5/2bpGpD/1HmgbHfpLFZ5OjjFTQqf61jSOeamFp3OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rrQ8cyg1dpqC7B/7WTGVjHZ+gK583LcAe6mSaJpuU+6P4s2OzPu/p+3e32O8IgTSAskPgAvVceP98Ig10g+OOy8BPo0oWV9TakkjkNbinmDKVxjGU0QMb/XXWpncRXr+WZLNk5zcg7kh4Zho7NphJaD1qqnI8vf/rgg5Bqz8BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fmaAjlER; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UkT6u8OmSEh7LRMbZlUcWoeNNvCMRTCifKXqrjivKMM=;
	b=fmaAjlERHzTu27FycxeLlyKfYO7s8TArcf0z7oKXfHz9WB3B8yl9QpE0vAdnd0nXOUg+ePIxS
	BsKg6nhjIQ9x51QYuZ/6J0vUXNn0oH3Ymi1zMRfDCIDmg4CJ8Kpg/TgqX5rY/zD4BetDIo2B4eq
	XMswAA5AeyM4kDBcJa/dr8g=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dcN49553lz1cyNt;
	Thu, 25 Dec 2025 17:00:09 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id B53FB405AD;
	Thu, 25 Dec 2025 17:03:16 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 17:03:15 +0800
Message-ID: <faddc6ce-61ce-4016-9a69-563f85bd03b4@huawei.com>
Date: Thu, 25 Dec 2025 17:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
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
 <20251223121307.711773-6-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-6-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
> write the MIN_PERF and MAX_PERF registers.
> 
> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> to expose these controls to userspace. The sysfs values are in frequency
> (kHz) for consistency with other cpufreq sysfs files.
> 
> A mutex is used to serialize sysfs store operations to ensure hardware
> register writes and perf_ctrls updates are atomic.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       |  44 +++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 160 +++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  20 +++++
>  3 files changed, 224 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 403ee988a8c6..9f28c20d902d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1742,6 +1742,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>  
> +/**
> + * cppc_get_min_perf - Read minimum performance register.
> + * @cpu: CPU from which to read register.
> + * @min_perf: Return address.
> + */
> +int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
> +
> +/**
> + * cppc_set_min_perf - Write minimum performance register.
> + * @cpu: CPU to which to write register.
> + * @min_perf: the desired minimum performance value to be updated.
> + */
> +int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
> +
> +/**
> + * cppc_get_max_perf - Read maximum performance register.
> + * @cpu: CPU from which to read register.
> + * @max_perf: Return address.
> + */
> +int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
> +
> +/**
> + * cppc_set_max_perf - Write maximum performance register.
> + * @cpu: CPU to which to write register.
> + * @max_perf: the desired maximum performance value to be updated.
> + */
> +int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a87e7bb2e2f1..1e282dfabc76 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,8 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -538,6 +540,46 @@ static void populate_efficiency_class(void)
>  }
>  #endif
>  
> +/**
> + * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
> + * @policy: cpufreq policy
> + * @val: performance value to set
> + * @is_min: true for min_perf, false for max_perf
> + */
> +static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
> +					bool is_min)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	unsigned int cpu = policy->cpu;
> +	u32 perf;
> +	int ret;
> +
> +	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
> +
> +	ret = is_min ? cppc_set_min_perf(cpu, perf) :
> +		       cppc_set_max_perf(cpu, perf);
> +	if (ret) {
> +		if (ret != -EOPNOTSUPP)
> +			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
> +				is_min ? "min" : "max", (u64)perf, cpu, ret);
> +		return ret;
> +	}
> +
> +	if (is_min)
> +		cpu_data->perf_ctrls.min_perf = perf;
> +	else
> +		cpu_data->perf_ctrls.max_perf = perf;
> +
> +	return 0;
> +}
> +
> +#define cppc_cpufreq_set_min_perf(policy, val) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, true)
> +
> +#define cppc_cpufreq_set_max_perf(policy, val) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, false)
> +
>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  {
>  	struct cppc_cpudata *cpu_data;
> @@ -896,16 +938,134 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>  					    buf, count);
>  }
>  
> +/**
> + * show_min_perf - Show minimum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MIN_PERF register and converts the performance value to
> + * frequency (kHz).
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
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_min_perf - Set minimum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MIN_PERF register.
> + */
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
> +			      size_t count)
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
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +	ret = cppc_cpufreq_set_min_perf(policy, perf);

Clamping value, calling cppc_set_min_perf(), setting
cpu_data->perf_ctrls.min_perf. These things can be accomplished with three
or four more lines of code here. I don't think
cppc_cpufreq_set_mperf_limit() is necessary. Same as in store_max_perf().

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * show_max_perf - Show maximum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MAX_PERF register and converts the performance value to
> + * frequency (kHz).
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
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_max_perf - Set maximum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MAX_PERF register.
> + */
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
> +			      size_t count)
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
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +	ret = cppc_cpufreq_set_max_perf(policy, perf);
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
> index 2860a0252313..a49b50bddaf9 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -173,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
> +extern int cppc_set_min_perf(int cpu, u32 min_perf);
> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
> +extern int cppc_set_max_perf(int cpu, u32 max_perf);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -265,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  {
>  	return -ENODEV;


