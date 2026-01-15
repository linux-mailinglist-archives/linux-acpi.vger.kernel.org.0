Return-Path: <linux-acpi+bounces-20357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C16ED22FB1
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18A57304DAD1
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5B32E73D;
	Thu, 15 Jan 2026 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="L2x0TQlK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA92E8B98;
	Thu, 15 Jan 2026 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464071; cv=none; b=K8YlHzihxs9nIL/MhcdcuE8evIMG5R5iKrbJq1Sy2vKRXH8+Z8cGLsAcsuENtaGlkcI5kdfNM03CjCgvl4bzeV5hY8OhBxT4X4eSg2hDv2MM8HFZ/3Q7q9o2hGnQ+lSe5p5eGaXg3Qgrc/Y8mMFCDUFwuSBQREp0OXRyblxUYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464071; c=relaxed/simple;
	bh=il+ur2AmFhBIas4/rfObzdgF/u8NIMfbFkNRWVDGI5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXn9IpQDK0OxE3m8JhJBmhhHLOrNYfFABrcYSRJV7HpRhmolln5ik063f2jexLIyOI9yCp2/txvq5yPTkDJK5GRUO4NnpjLxdNB0jSIFNaJswdEwDG2wciT7g8yCp+iTtnn4/ukFhmC5s28pDMdvcGQ1u7BwhRa+b9tCt7ELMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=L2x0TQlK; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oip95iPWTAaoPcXICTEjsNFUgVofongS4JHq1pQa6L4=;
	b=L2x0TQlK4LzJbCmJflrRMkpTVxA6gI83/6eZn6KclUo4gpTexniFkeVPPZiHQhfze0R5d0q50
	gncTICkF2qU7f+3t0GNZEGQqkpil4lcHYzM7UtXsvmTsF6if4POl3WYfSAfaudDPXpKA3RYcOIN
	XxciGDdoRqqFJGWA2w9P58E=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsFhs5dPxz12Lc0;
	Thu, 15 Jan 2026 15:58:05 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 72E6B201E9;
	Thu, 15 Jan 2026 16:01:05 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 16:01:04 +0800
Message-ID: <abc72d3a-990b-4eaa-9043-185e1d205df5@huawei.com>
Date: Thu, 15 Jan 2026 16:01:03 +0800
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
 <14851f8e-b6ac-42ff-9623-b7ac8d8893e2@huawei.com>
 <0a2b7d49-bd1f-442e-9247-705cd2eb0d1c@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <0a2b7d49-bd1f-442e-9247-705cd2eb0d1c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/8 22:38, Sumit Gupta wrote:
> 
> On 25/12/25 17:36, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2025/12/23 20:13, Sumit Gupta wrote:
>>> Add sysfs interface to read/write the Performance Limited register.
>>>
>>> The Performance Limited register indicates to the OS that an
>>> unpredictable event (like thermal throttling) has limited processor
>>> performance. It contains two sticky bits set by the platform:
>>>    - Bit 0 (Desired_Excursion): Set when delivered performance is
>>>      constrained below desired performance. Not used when Autonomous
>>>      Selection is enabled.
>>>    - Bit 1 (Minimum_Excursion): Set when delivered performance is
>>>      constrained below minimum performance.
>>>
>>> These bits remain set until OSPM explicitly clears them. The write
>>> operation accepts a bitmask of bits to clear:
>>>    - Write 1 to clear bit 0
>>>    - Write 2 to clear bit 1
>>>    - Write 3 to clear both bits
>> It's a bit odd that users write a 1 to and then read a 0 from the sysfs
>> file. I think it is better to seperate these two bits, as two sysfs files.
>> Then users can write '0' or 'clear' or others into them to clear each bit.
> 
> I think its better to keep one sysfs interface per HW register.
> Can change the perf_limited write interface to accept bit index
> instead of bitmask.
>  - Write 0 to clear bit 0 (desired performance excursion)
>  - Write 1 to clear bit 1 (minimum performance excursion)
> 
> Thank you,
> Sumit Gupta

I believe that user-facing interfaces should prioritize usability, ideally
allowing users to guess how to use them simply from the interface name
without reading any documentation. While this is nearly impossible, user
interfaces should strive towards this goal, rather than being rigidly bound
to register implementations.

Viresh, Rafael, what do you think?

> 
> 
>>
>>> This enables users to detect if platform throttling impacted a workload.
>>> Users clear the register before execution, run the workload, then check
>>> afterward - if set, hardware throttling occurred during that time window.
>>>
>>> The interface is exposed as:
>>>    /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++
>>>   include/acpi/cppc_acpi.h       | 15 +++++++++
>>>   3 files changed, 102 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 9f28c20d902d..ffd866c1c00d 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1786,6 +1786,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>>
>>> +/**
>>> + * cppc_get_perf_limited - Get the Performance Limited register value.
>>> + * @cpu: CPU from which to get Performance Limited register.
>>> + * @perf_limited: Pointer to store the Performance Limited value.
>>> + *
>>> + * The returned value contains sticky status bits indicating platform-imposed
>>> + * performance limitations.
>>> + *
>>> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
>>> + */
>>> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>>> +{
>>> +     return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>>> +
>>> +/**
>>> + * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
>>> + * @cpu: CPU on which to write register.
>>> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
>>> + *
>>> + * The Performance Limited register contains two sticky bits set by platform:
>>> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
>>> + *     below desired performance. Not used when Autonomous Selection is enabled.
>>> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
>>> + *     below minimum performance.
>>> + *
>>> + * These bits are sticky and remain set until OSPM explicitly clears them.
>>> + * This function only allows clearing bits (the platform sets them).
>>> + *
>>> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
>>> + *         access failure, -EOPNOTSUPP if not supported.
>>> + */
>>> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>>> +{
>>> +     u64 current_val, new_val;
>>> +     int ret;
>>> +
>>> +     /* Only bits 0 and 1 are valid */
>>> +     if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
>>> +             return -EINVAL;
>>> +
>>> +     if (!bits_to_clear)
>>> +             return 0;
>>> +
>>> +     ret = cppc_get_perf_limited(cpu, &current_val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Clear the specified bits */
>>> +     new_val = current_val & ~bits_to_clear;
>>> +
>>> +     return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
>>> +
>>>   /**
>>>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>>>    * Continuous Performance Control package EnableRegister field.
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 1e282dfabc76..1f8825006940 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -1052,12 +1052,42 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>>>        return count;
>>>   }
>>>
>>> +/**
>>> + * show_perf_limited - Show Performance Limited register status
>>> + * @policy: cpufreq policy
>>> + * @buf: buffer to write the value to
>>> + *
>>> + * Read the Performance Limited register to check if platform throttling
>>> + * (thermal/power/current limits) occurred.
>>> + */
>>> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
>>> +{
>>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu,
>>> +                                        cppc_get_perf_limited, buf);
>>> +}
>>> +
>>> +/**
>>> + * store_perf_limited - Clear Performance Limited register bits
>>> + * @policy: cpufreq policy
>>> + * @buf: buffer containing the bitmask of bits to clear
>>> + * @count: number of bytes in buf
>>> + *
>>> + * Write 1 to clear bit 0, 2 to clear bit 1, or 3 to clear both.
>>> + */
>>> +static ssize_t store_perf_limited(struct cpufreq_policy *policy,
>>> +                               const char *buf, size_t count)
>>> +{
>>> +     return cppc_cpufreq_sysfs_store_u64(policy->cpu,
>>> +                                         cppc_set_perf_limited, buf, count);
>>> +}
>>> +
>>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>>   cpufreq_freq_attr_rw(auto_select);
>>>   cpufreq_freq_attr_rw(auto_act_window);
>>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>>   cpufreq_freq_attr_rw(min_perf);
>>>   cpufreq_freq_attr_rw(max_perf);
>>> +cpufreq_freq_attr_rw(perf_limited);
>>>
>>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>>        &freqdomain_cpus,
>>> @@ -1066,6 +1096,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>>        &energy_performance_preference_val,
>>>        &min_perf,
>>>        &max_perf,
>>> +     &perf_limited,
>>>        NULL,
>>>   };
>>>
>>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>>> index a49b50bddaf9..57e04326a4b6 100644
>>> --- a/include/acpi/cppc_acpi.h
>>> +++ b/include/acpi/cppc_acpi.h
>>> @@ -42,6 +42,11 @@
>>>   #define CPPC_EPP_PERFORMANCE_PREF            0x00
>>>   #define CPPC_EPP_ENERGY_EFFICIENCY_PREF              0xFF
>>>
>>> +#define CPPC_PERF_LIMITED_DESIRED_EXCURSION  BIT(0)
>>> +#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION  BIT(1)
>>> +#define CPPC_PERF_LIMITED_MASK               (CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
>>> +                                      CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
>>> +
>>>   /* Each register has the folowing format. */
>>>   struct cpc_reg {
>>>        u8 descriptor;
>>> @@ -177,6 +182,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>>>   extern int cppc_set_min_perf(int cpu, u32 min_perf);
>>>   extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>>>   extern int cppc_set_max_perf(int cpu, u32 max_perf);
>>> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>>> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>>>   extern int amd_detect_prefcore(bool *detected);
>>> @@ -285,6 +292,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
>>>   {
>>>        return -EOPNOTSUPP;
>>>   }
>>> +static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>>   {
>>>        return -ENODEV;
> 


