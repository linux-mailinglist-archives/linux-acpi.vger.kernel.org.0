Return-Path: <linux-acpi+bounces-10018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA529E96A7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 14:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ECD16AB3D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DED1F2C47;
	Mon,  9 Dec 2024 13:16:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153D1ACED6;
	Mon,  9 Dec 2024 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750171; cv=none; b=rYAGaFdhTMiod4DRWcipFcA7I1x55Yf93ynCRJAdk5T6yhEJqlyFWTNJLE2+9Opjd6am2p0tybZ0jycJkty3RRDVZi3lGEVFXBbEwXa7xt1nqwX981eAkirzxZy8l+L00FqAPldQw6jG2PMBR3cBpbg5YivNPAW7Gpyj+4/gIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750171; c=relaxed/simple;
	bh=ZoM7m5WcA6NFZRC9zfZ+uWiPM0xBl0KV4cb4WNZWwCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCIonm1oU+pHkbl2VHtUJQiDncnprWjyWsCvv/gXn/4TiuKWTu8CrZp2ZmYaAPnZHcL3x9EuACw30/Y+O+6DE9bOxd1JhaikR5zUEvX4vrvR2Nb50SMM1RRg6YJ6JLApgCMtAWM0Y80pDUDW/7QGAmNYHU/ubcz0AnUKLsm3qHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAD22113E;
	Mon,  9 Dec 2024 05:16:34 -0800 (PST)
Received: from [10.57.67.149] (unknown [10.57.67.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F84C3F720;
	Mon,  9 Dec 2024 05:16:03 -0800 (PST)
Message-ID: <43b4cdee-ba78-4421-bdc6-cefebe3eaf8b@arm.com>
Date: Mon, 9 Dec 2024 14:15:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com
References: <20241114084816.1128647-1-zhenglifeng1@huawei.com>
 <20241114084816.1128647-4-zhenglifeng1@huawei.com>
 <9f46991d-98c3-41f5-8133-6612b397e33a@arm.com>
 <fc7cbe88-64a3-4b65-ae37-3a1f50257f22@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <fc7cbe88-64a3-4b65-ae37-3a1f50257f22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Lifeng,

On 12/9/24 09:40, zhenglifeng (A) wrote:
> Hello Pierre,
> 
> On 2024/12/6 22:23, Pierre Gondois wrote:
>> Hello Lifeng,
>>
>> On 11/14/24 09:48, Lifeng Zheng wrote:
>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>> driver.
>>>
>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> ---
>>>    .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++
>>>    drivers/cpufreq/cppc_cpufreq.c                | 141 ++++++++++++++++++
>>>    2 files changed, 195 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> index 206079d3bd5b..ba7b8ea613e5 100644
>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>            This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>            drivers are in use.
>>>    +What:        /sys/devices/system/cpu/cpuX/cpufreq/auto_select
>>> +Date:        October 2024
>>> +Contact:    linux-pm@vger.kernel.org
>>> +Description:    Autonomous selection enable
>>> +
>>> +        Read/write interface to control autonomous selection enable
>>> +            Read returns autonomous selection status:
>>> +                0: autonomous selection is disabled
>>> +                1: autonomous selection is enabled
>>> +
>>> +            Write '1' to enable autonomous selection.
>>> +            Write '0' to disable autonomous selection.
>>> +
>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>> +
>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
>>> +Date:        October 2024
>>> +Contact:    linux-pm@vger.kernel.org
>>> +Description:    Autonomous activity window
>>> +
>>> +        This file indicates a moving utilization sensitivity window to
>>> +        the platform's autonomous selection policy.
>>> +
>>> +        Read/write an integer represents autonomous activity window (in
>>> +        microseconds) from/to this file. The max value to write is
>>> +        1270000000 but the max significand is 127. This means that if 128
>>> +        is written to this file, 127 will be stored. If the value is
>>> +        greater than 130, only the first two digits will be saved as
>>> +        significand.
>>> +
>>> +        Writing a zero value to this file enable the platform to
>>> +        determine an appropriate Activity Window depending on the workload.
>>> +
>>> +        Writing to this file only has meaning when Autonomous Selection is
>>> +        enabled.
>>> +
>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>> +
>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>> +Date:        October 2024
>>> +Contact:    linux-pm@vger.kernel.org
>>> +Description:    Energy performance preference
>>> +
>>> +        Read/write an 8-bit integer from/to this file. This file
>>> +        represents a range of values from 0 (performance preference) to
>>> +        0xFF (energy efficiency preference) that influences the rate of
>>> +        performance increase/decrease and the result of the hardware's
>>> +        energy efficiency and performance optimization policies.
>>> +
>>> +        Writing to this file only has meaning when Autonomous Selection is
>>> +        enabled.
>>> +
>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>> +
>>>      What:        /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>>    Date:        August 2008
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 2b8708475ac7..b435e1751d0d 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -792,10 +792,151 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>>          return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>>    }
>>> +
>>> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>>> +{
>>> +    u64 val;
>>> +    int ret;
>>> +
>>> +    ret = cppc_get_auto_sel(policy->cpu, &val);
>>> +
>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>> +    if (ret == -EOPNOTSUPP)
>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return sysfs_emit(buf, "%lld\n", val);
>>> +}
>>> +
>>> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>> +                 const char *buf, size_t count)
>>> +{
>>> +    unsigned long val;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul(buf, 0, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (val > 1)
>>> +        return -EINVAL;
>>> +
>>> +    ret = cppc_set_auto_sel(policy->cpu, val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return count;
>>> +}
>>> +
>>> +#define AUTO_ACT_WINDOW_SIG_BIT_SIZE    (7)
>>> +#define AUTO_ACT_WINDOW_EXP_BIT_SIZE    (3)
>>> +#define AUTO_ACT_WINDOW_MAX_SIG    ((1 << AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
>>> +#define AUTO_ACT_WINDOW_MAX_EXP    ((1 << AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
>>> +/* AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>>> +#define AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>>
>> Maybe this would be better to place these macros in include/acpi/cppc_acpi.h
>> (with a CPPC_XXX prefix)
> 
> Will move them, Thanks.
> 
>>
>>> +
>>> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>>> +{
>>> +    int sig, exp;
>>> +    u64 val;
>>> +    int ret;
>>> +
>>> +    ret = cppc_get_auto_act_window(policy->cpu, &val);
>>> +
>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>> +    if (ret == -EOPNOTSUPP)
>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    sig = val & AUTO_ACT_WINDOW_MAX_SIG;
>>> +    exp = (val >> AUTO_ACT_WINDOW_SIG_BIT_SIZE) & AUTO_ACT_WINDOW_MAX_EXP;
>>> +
>>> +    return sysfs_emit(buf, "%lld\n", sig * int_pow(10, exp));
>>> +}
>>> +
>>> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>>> +                     const char *buf, size_t count)
>>> +{
>>> +    unsigned long usec;
>>> +    int digits = 0;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul(buf, 0, &usec);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (usec > AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, AUTO_ACT_WINDOW_MAX_EXP))
>>> +        return -EINVAL;
>>> +
>>> +    while (usec > AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
>>> +        usec /= 10;
>>> +        digits += 1;
>>> +    }
>>> +
>>> +    if (usec > AUTO_ACT_WINDOW_MAX_SIG)
>>> +        usec = AUTO_ACT_WINDOW_MAX_SIG;
>>> +
>>> +    ret = cppc_set_auto_act_window(policy->cpu,
>>> +                       (digits << AUTO_ACT_WINDOW_SIG_BIT_SIZE) + usec);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return count;
>>> +}

Also I tested the logic and it was working correctly for me.

>>> +
>>> +static ssize_t show_energy_perf(struct cpufreq_policy *policy, char *buf)
>>> +{
>>> +    u64 val;
>>> +    int ret;
>>> +
>>> +    ret = cppc_get_epp_perf(policy->cpu, &val);
>>> +
>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>> +    if (ret == -EOPNOTSUPP)
>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return sysfs_emit(buf, "%lld\n", val);
>>> +}
>>> +
>>> +#define ENERGY_PERF_MAX    (0xFF)
>>
>> Same comment to move to include/acpi/cppc_acpi.h
>>
>>> +
>>> +static ssize_t store_energy_perf(struct cpufreq_policy *policy,
>>> +                 const char *buf, size_t count)
>>> +{
>>> +    unsigned long val;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul(buf, 0, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (val > ENERGY_PERF_MAX)
>>> +        return -EINVAL;
>>> +
>>> +    ret = cppc_set_epp(policy->cpu, val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return count;
>>> +}
>>> +
>>>    cpufreq_freq_attr_ro(freqdomain_cpus);
>>> +cpufreq_freq_attr_rw(auto_select);
>>> +cpufreq_freq_attr_rw(auto_act_window);
>>> +cpufreq_freq_attr_rw(energy_perf);
>>
>> It might be better from a user PoV to hide the following entries:
>> - auto_act_window
>> - energy_perf
>> if auto_select is not available or disabled.
> 
> Users might like to modify the value of auto_act_window and energy_perf
> before turning on auto_select. So I think it is freer for users to read and
> write them no matter what auto_select is. What do you think?

Autonomous selection is not the most common case for the CPPC cpufreq drivers,
so these new files might bring questions to people currently using it.

On the other side, making these files visible only when 'auto_select' is enabled
will require additional logic in the code (while the current implementation is
quite clear).

I think Rafael or Viresh should take the decision. So it might be better to
directly ping them,

Regards,
Pierre

> 
>>
>> ------
>>
>> Also just for reference, in ACPI 6.5, s8.4.6.1.2.3 Desired Performance Register
>> """
>> When Autonomous Selection is enabled, it is not necessary for OSPM to assess processor workload performance
>> demand and convey a corresponding performance delivery request to the platform via the Desired Register. If the
>> Desired Performance Register exists, OSPM may provide an explicit performance requirement hint to the platform by
>> writing a non-zero value.
>> """
>>
>> So it seems it still makes sense to have cpufreq requesting a certain performance
>> level even though autonomous selection is enabled.
> 
> We did struggle with this. This solves our doubts. Thanks!
> 
>>
> 

