Return-Path: <linux-acpi+bounces-20545-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHCaDL8hcmmPdQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20545-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:10:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414F67143
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F5F6AC4D2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0A36921B;
	Thu, 22 Jan 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NsaOUsNn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AC1CAA7D;
	Thu, 22 Jan 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085334; cv=none; b=RLT3RqBnAkCVNeWk0AMej/UXV73089bgehMRUhfCktuWJ09LV8zO3E1noqb59VjdFAGKRO9oj0QSxeTnngPnXuxdA5cPU6A6bXjCzQjJ5xTF+1G8oYzF7pEiUNWQv4I9cmvml5pF0OzdneHq/J2bOEYgnKTuoplZMb3jAufKGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085334; c=relaxed/simple;
	bh=g44p+Utjr96i7aRFZwxxIDAjb4o9yxAncsQC1czZsZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u7S84vqiDzz2Px3Q/jeCF6mJIX1u2DWN2hbOo54UAieuCdNYx0QMiIFTWRQ9ZDgfjFx14QYQdfulp5h/sTbqn4eOP17X1ESC/4+pRR5EUFjEEjedYcKjrk5wLlFgAC9WSCRSqa+wlPlDFG0zF0nVbehlXIKHrO0q7Zh96/udS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NsaOUsNn; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LILk48d7nhKek/faEudoL9YCrLaV/jEp69B7IF0M/8U=;
	b=NsaOUsNnNbsXgIjyzBbfxAQZsPZ0OusXo/KjriJJe/4eDEJZ9rtO5kOZmpILB82+RJ9YIkhzM
	4E0mZqiV0M2nSAkR/GQ09pK7gTdMng+U6pP4HRMpLsOL6/8SU4FlE3mALpiUUO7VPiAt81uB2Us
	eSWMPuP7mmi5qLGy1Wb0izc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dxgR71FxPz12LDC;
	Thu, 22 Jan 2026 20:31:31 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id D6F3E40569;
	Thu, 22 Jan 2026 20:35:28 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 20:35:27 +0800
Message-ID: <c4a655ac-8674-45fe-8eb5-a0513d3b9bdd@huawei.com>
Date: Thu, 22 Jan 2026 20:35:27 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-7-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-7-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20545-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 9414F67143
X-Rspamd-Action: no action

On 2026/1/20 22:56, Sumit Gupta wrote:
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
>  drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  20 +++++
>  3 files changed, 221 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 45c6bd6ec24b..46bf45f8b0f3 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
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

ACPI spec says it 'must be set to a value that is less than or equal to
that specified by the Maximum Performance Register'. So it may be better
to check it before setting value.

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
> index 229880c4eedb..66e183b45fb0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,8 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -570,6 +572,35 @@ static void populate_efficiency_class(void)
>  }
>  #endif
>  
> +/* Set min/max performance HW register and cache the value */
> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
> +				      u64 val, bool is_min)
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
> +			pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
> +				cpu, is_min ? "min" : "max", perf, ret);
> +		return ret;
> +	}
> +
> +	if (is_min)
> +		cpu_data->perf_ctrls.min_perf = perf;
> +	else
> +		cpu_data->perf_ctrls.max_perf = perf;
> +
> +	return 0;

I think cppc_set_XXX and updating cpudata->perf_ctrls.XXX can be extract
out for not only min_perf and max_perf but also auto_sel and energy_perf
and anything else in perf_ctrls.

> +}
> +
>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  {
>  	struct cppc_cpudata *cpu_data;
> @@ -918,16 +949,142 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
>  CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>  			 cppc_get_epp_perf, cppc_set_epp)
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
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_min_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Use lowest_perf if register is uninitialized (0) */
> +	if (perf == 0)
> +		perf = caps->lowest_perf;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
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
> +	guard(mutex)(&cppc_cpufreq_autonomous_lock);
> +	ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
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
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_max_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Use highest_perf if register is uninitialized or out of range */
> +	if (perf == 0 || perf > caps->highest_perf)
> +		perf = caps->highest_perf;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
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
> +	guard(mutex)(&cppc_cpufreq_autonomous_lock);
> +	ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
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
> index 3fc796c0d902..b358440cd0e2 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
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
> @@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
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


