Return-Path: <linux-acpi+bounces-19847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C0CDDBAE
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3013016DE8
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5612DC77E;
	Thu, 25 Dec 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xn4pCXMh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF781D5178;
	Thu, 25 Dec 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664423; cv=none; b=l207E90WG1c5n6n0/sVyigvTJhqz8ZVLFz1mtkAUqWczXng0T5PvwE1FY7+XrjmyAwKs6POyHXQ6JuH/SCn+bnmO0I2akvdbulx6Kf6RrUnUo6oFw465S+SnHH5CsqoYTl+Lb3ModJoZKhhm6xLe5n0CxE4+gnBCeZ7I77/hkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664423; c=relaxed/simple;
	bh=CfZDfqheZKksAchbJ/m6MAoeuFVJP6vNYQsZPyvhIvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XU2xeB4wIv1jTTgScYiHEHz4xdk/gpUdfTIOP7yVMVtUxE1m01Ng7jHMKKrajnOxjKGoUlKz0OAtar5xGre0Ikiy5j5GiUybUXB4oDIU9j9y0KvXl4cwdr5sMtzzCXTiYHWtOGcegI+0icfOLufh9tDlBaunuFMmXYsumutIMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xn4pCXMh; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=r/gTW6pJKrRGdzClt7gk9Aa/WNSGGA2RNOf/R+QW7UI=;
	b=xn4pCXMhxOLDLJHW4YZyDalorV15YVeCtfoV/7o399pxZROiSfqVVJHSuE81kihVJswODSA23
	hNbA4D4p0tGrREyLfdgZqOHEIRBjTqPZ6xv44L0YitxSISGhYY3h+qBvHPODZQ6s2Fa9l+ycanF
	elibtJKyCH7MQfwJrqUvXzE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dcS834jvWzcZxm;
	Thu, 25 Dec 2025 20:03:47 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E04884056A;
	Thu, 25 Dec 2025 20:06:55 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 20:06:54 +0800
Message-ID: <14851f8e-b6ac-42ff-9623-b7ac8d8893e2@huawei.com>
Date: Thu, 25 Dec 2025 20:06:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited
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
 <20251223121307.711773-7-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-7-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> Add sysfs interface to read/write the Performance Limited register.
> 
> The Performance Limited register indicates to the OS that an
> unpredictable event (like thermal throttling) has limited processor
> performance. It contains two sticky bits set by the platform:
>   - Bit 0 (Desired_Excursion): Set when delivered performance is
>     constrained below desired performance. Not used when Autonomous
>     Selection is enabled.
>   - Bit 1 (Minimum_Excursion): Set when delivered performance is
>     constrained below minimum performance.
> 
> These bits remain set until OSPM explicitly clears them. The write
> operation accepts a bitmask of bits to clear:
>   - Write 1 to clear bit 0
>   - Write 2 to clear bit 1
>   - Write 3 to clear both bits

It's a bit odd that users write a 1 to and then read a 0 from the sysfs
file. I think it is better to seperate these two bits, as two sysfs files.
Then users can write '0' or 'clear' or others into them to clear each bit.

> 
> This enables users to detect if platform throttling impacted a workload.
> Users clear the register before execution, run the workload, then check
> afterward - if set, hardware throttling occurred during that time window.
> 
> The interface is exposed as:
>   /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++
>  include/acpi/cppc_acpi.h       | 15 +++++++++
>  3 files changed, 102 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 9f28c20d902d..ffd866c1c00d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1786,6 +1786,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>  
> +/**
> + * cppc_get_perf_limited - Get the Performance Limited register value.
> + * @cpu: CPU from which to get Performance Limited register.
> + * @perf_limited: Pointer to store the Performance Limited value.
> + *
> + * The returned value contains sticky status bits indicating platform-imposed
> + * performance limitations.
> + *
> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
> +
> +/**
> + * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
> + * @cpu: CPU on which to write register.
> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
> + *
> + * The Performance Limited register contains two sticky bits set by platform:
> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
> + *     below desired performance. Not used when Autonomous Selection is enabled.
> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
> + *     below minimum performance.
> + *
> + * These bits are sticky and remain set until OSPM explicitly clears them.
> + * This function only allows clearing bits (the platform sets them).
> + *
> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
> + *         access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
> +{
> +	u64 current_val, new_val;
> +	int ret;
> +
> +	/* Only bits 0 and 1 are valid */
> +	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
> +		return -EINVAL;
> +
> +	if (!bits_to_clear)
> +		return 0;
> +
> +	ret = cppc_get_perf_limited(cpu, &current_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear the specified bits */
> +	new_val = current_val & ~bits_to_clear;
> +
> +	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 1e282dfabc76..1f8825006940 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1052,12 +1052,42 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>  	return count;
>  }
>  
> +/**
> + * show_perf_limited - Show Performance Limited register status
> + * @policy: cpufreq policy
> + * @buf: buffer to write the value to
> + *
> + * Read the Performance Limited register to check if platform throttling
> + * (thermal/power/current limits) occurred.
> + */
> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu,
> +					   cppc_get_perf_limited, buf);
> +}
> +
> +/**
> + * store_perf_limited - Clear Performance Limited register bits
> + * @policy: cpufreq policy
> + * @buf: buffer containing the bitmask of bits to clear
> + * @count: number of bytes in buf
> + *
> + * Write 1 to clear bit 0, 2 to clear bit 1, or 3 to clear both.
> + */
> +static ssize_t store_perf_limited(struct cpufreq_policy *policy,
> +				  const char *buf, size_t count)
> +{
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
> +					    cppc_set_perf_limited, buf, count);
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
> @@ -1066,6 +1096,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&energy_performance_preference_val,
>  	&min_perf,
>  	&max_perf,
> +	&perf_limited,
>  	NULL,
>  };
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index a49b50bddaf9..57e04326a4b6 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -42,6 +42,11 @@
>  #define CPPC_EPP_PERFORMANCE_PREF		0x00
>  #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>  
> +#define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
> +#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION	BIT(1)
> +#define CPPC_PERF_LIMITED_MASK		(CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
> +					 CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
> +
>  /* Each register has the folowing format. */
>  struct cpc_reg {
>  	u8 descriptor;
> @@ -177,6 +182,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>  extern int cppc_set_min_perf(int cpu, u32 min_perf);
>  extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>  extern int cppc_set_max_perf(int cpu, u32 max_perf);
> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -285,6 +292,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
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


