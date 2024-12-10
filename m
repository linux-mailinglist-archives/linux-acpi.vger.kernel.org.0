Return-Path: <linux-acpi+bounces-10024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A739EA96D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AEA16A116
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CE22CBEF;
	Tue, 10 Dec 2024 07:20:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FC13B280;
	Tue, 10 Dec 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815250; cv=none; b=QYZFFiTWR0M090wXu6Uc9N7OMagwuIuYvBC0tcVAxRHZr1IrbPUorxJqMaIBBk1RnAIjL6IOlAT5gICxFvVO/LjfyFxntYfS/oYVvlSldWNLfHzbY4Y5sTeSyb7O3wFjPDSkwo9vI7S/cfNrU1lTkGEIgHZgWZLw7AZQjCIws38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815250; c=relaxed/simple;
	bh=4NlQbx3T63+OULWemSfy5ocPZ6KErYVuWVssn3kaxdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RS6lOF0d0SbA4BHCsCa4JES9pLCa4wDPHUhGKaHxszXnNKduk4C4gB6xGHqSRg6ou3utjEgqs0PVAHHu01bN/j68IJXamU/mlZHeRAWKnHdBxMW/O+nZmSeGK6V+X7urlnu+dferUKSQpj8ltOkJIwVh5yUaNfjjX3MEWy4nKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y6qps1Z15z21mVL;
	Tue, 10 Dec 2024 15:19:01 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D25C01A0188;
	Tue, 10 Dec 2024 15:20:44 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Dec
 2024 15:20:44 +0800
Message-ID: <522721da-1a5c-439c-96a8-d0300dd0f906@huawei.com>
Date: Tue, 10 Dec 2024 15:20:43 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>
References: <20241114084816.1128647-1-zhenglifeng1@huawei.com>
 <20241114084816.1128647-4-zhenglifeng1@huawei.com>
 <9f46991d-98c3-41f5-8133-6612b397e33a@arm.com>
 <fc7cbe88-64a3-4b65-ae37-3a1f50257f22@huawei.com>
 <43b4cdee-ba78-4421-bdc6-cefebe3eaf8b@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <43b4cdee-ba78-4421-bdc6-cefebe3eaf8b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello Rafael & Viresh

On 2024/12/9 21:15, Pierre Gondois wrote:
> Hello Lifeng,
> 
> On 12/9/24 09:40, zhenglifeng (A) wrote:
>> Hello Pierre,
>>
>> On 2024/12/6 22:23, Pierre Gondois wrote:
>>> Hello Lifeng,
>>>
>>> On 11/14/24 09:48, Lifeng Zheng wrote:
>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>> driver.
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>>    .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++
>>>>    drivers/cpufreq/cppc_cpufreq.c                | 141 ++++++++++++++++++
>>>>    2 files changed, 195 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> index 206079d3bd5b..ba7b8ea613e5 100644
>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>            This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>            drivers are in use.
>>>>    +What:        /sys/devices/system/cpu/cpuX/cpufreq/auto_select
>>>> +Date:        October 2024
>>>> +Contact:    linux-pm@vger.kernel.org
>>>> +Description:    Autonomous selection enable
>>>> +
>>>> +        Read/write interface to control autonomous selection enable
>>>> +            Read returns autonomous selection status:
>>>> +                0: autonomous selection is disabled
>>>> +                1: autonomous selection is enabled
>>>> +
>>>> +            Write '1' to enable autonomous selection.
>>>> +            Write '0' to disable autonomous selection.
>>>> +
>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>> +
>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
>>>> +Date:        October 2024
>>>> +Contact:    linux-pm@vger.kernel.org
>>>> +Description:    Autonomous activity window
>>>> +
>>>> +        This file indicates a moving utilization sensitivity window to
>>>> +        the platform's autonomous selection policy.
>>>> +
>>>> +        Read/write an integer represents autonomous activity window (in
>>>> +        microseconds) from/to this file. The max value to write is
>>>> +        1270000000 but the max significand is 127. This means that if 128
>>>> +        is written to this file, 127 will be stored. If the value is
>>>> +        greater than 130, only the first two digits will be saved as
>>>> +        significand.
>>>> +
>>>> +        Writing a zero value to this file enable the platform to
>>>> +        determine an appropriate Activity Window depending on the workload.
>>>> +
>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>> +        enabled.
>>>> +
>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>> +
>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>> +Date:        October 2024
>>>> +Contact:    linux-pm@vger.kernel.org
>>>> +Description:    Energy performance preference
>>>> +
>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>> +        represents a range of values from 0 (performance preference) to
>>>> +        0xFF (energy efficiency preference) that influences the rate of
>>>> +        performance increase/decrease and the result of the hardware's
>>>> +        energy efficiency and performance optimization policies.
>>>> +
>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>> +        enabled.
>>>> +
>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>> +
>>>>      What:        /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>>>    Date:        August 2008
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 2b8708475ac7..b435e1751d0d 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -792,10 +792,151 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>>>          return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>>>    }
>>>> +
>>>> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>>>> +{
>>>> +    u64 val;
>>>> +    int ret;
>>>> +
>>>> +    ret = cppc_get_auto_sel(policy->cpu, &val);
>>>> +
>>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>>> +    if (ret == -EOPNOTSUPP)
>>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return sysfs_emit(buf, "%lld\n", val);
>>>> +}
>>>> +
>>>> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>>> +                 const char *buf, size_t count)
>>>> +{
>>>> +    unsigned long val;
>>>> +    int ret;
>>>> +
>>>> +    ret = kstrtoul(buf, 0, &val);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (val > 1)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = cppc_set_auto_sel(policy->cpu, val);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return count;
>>>> +}
>>>> +
>>>> +#define AUTO_ACT_WINDOW_SIG_BIT_SIZE    (7)
>>>> +#define AUTO_ACT_WINDOW_EXP_BIT_SIZE    (3)
>>>> +#define AUTO_ACT_WINDOW_MAX_SIG    ((1 << AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
>>>> +#define AUTO_ACT_WINDOW_MAX_EXP    ((1 << AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
>>>> +/* AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>>>> +#define AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>>>
>>> Maybe this would be better to place these macros in include/acpi/cppc_acpi.h
>>> (with a CPPC_XXX prefix)
>>
>> Will move them, Thanks.
>>
>>>
>>>> +
>>>> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>>>> +{
>>>> +    int sig, exp;
>>>> +    u64 val;
>>>> +    int ret;
>>>> +
>>>> +    ret = cppc_get_auto_act_window(policy->cpu, &val);
>>>> +
>>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>>> +    if (ret == -EOPNOTSUPP)
>>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    sig = val & AUTO_ACT_WINDOW_MAX_SIG;
>>>> +    exp = (val >> AUTO_ACT_WINDOW_SIG_BIT_SIZE) & AUTO_ACT_WINDOW_MAX_EXP;
>>>> +
>>>> +    return sysfs_emit(buf, "%lld\n", sig * int_pow(10, exp));
>>>> +}
>>>> +
>>>> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>>>> +                     const char *buf, size_t count)
>>>> +{
>>>> +    unsigned long usec;
>>>> +    int digits = 0;
>>>> +    int ret;
>>>> +
>>>> +    ret = kstrtoul(buf, 0, &usec);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (usec > AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, AUTO_ACT_WINDOW_MAX_EXP))
>>>> +        return -EINVAL;
>>>> +
>>>> +    while (usec > AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
>>>> +        usec /= 10;
>>>> +        digits += 1;
>>>> +    }
>>>> +
>>>> +    if (usec > AUTO_ACT_WINDOW_MAX_SIG)
>>>> +        usec = AUTO_ACT_WINDOW_MAX_SIG;
>>>> +
>>>> +    ret = cppc_set_auto_act_window(policy->cpu,
>>>> +                       (digits << AUTO_ACT_WINDOW_SIG_BIT_SIZE) + usec);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return count;
>>>> +}
> 
> Also I tested the logic and it was working correctly for me.
> 
>>>> +
>>>> +static ssize_t show_energy_perf(struct cpufreq_policy *policy, char *buf)
>>>> +{
>>>> +    u64 val;
>>>> +    int ret;
>>>> +
>>>> +    ret = cppc_get_epp_perf(policy->cpu, &val);
>>>> +
>>>> +    /* show "<unsupported>" when this register is not supported by cpc */
>>>> +    if (ret == -EOPNOTSUPP)
>>>> +        return sysfs_emit(buf, "%s\n", "<unsupported>");
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return sysfs_emit(buf, "%lld\n", val);
>>>> +}
>>>> +
>>>> +#define ENERGY_PERF_MAX    (0xFF)
>>>
>>> Same comment to move to include/acpi/cppc_acpi.h
>>>
>>>> +
>>>> +static ssize_t store_energy_perf(struct cpufreq_policy *policy,
>>>> +                 const char *buf, size_t count)
>>>> +{
>>>> +    unsigned long val;
>>>> +    int ret;
>>>> +
>>>> +    ret = kstrtoul(buf, 0, &val);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (val > ENERGY_PERF_MAX)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = cppc_set_epp(policy->cpu, val);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return count;
>>>> +}
>>>> +
>>>>    cpufreq_freq_attr_ro(freqdomain_cpus);
>>>> +cpufreq_freq_attr_rw(auto_select);
>>>> +cpufreq_freq_attr_rw(auto_act_window);
>>>> +cpufreq_freq_attr_rw(energy_perf);
>>>
>>> It might be better from a user PoV to hide the following entries:
>>> - auto_act_window
>>> - energy_perf
>>> if auto_select is not available or disabled.
>>
>> Users might like to modify the value of auto_act_window and energy_perf
>> before turning on auto_select. So I think it is freer for users to read and
>> write them no matter what auto_select is. What do you think?
> 
> Autonomous selection is not the most common case for the CPPC cpufreq drivers,
> so these new files might bring questions to people currently using it.
> 
> On the other side, making these files visible only when 'auto_select' is enabled
> will require additional logic in the code (while the current implementation is
> quite clear).
> 
> I think Rafael or Viresh should take the decision. So it might be better to
> directly ping them,
> 
> Regards,
> Pierre

Since Pierre and me have discussed about whether or not to show
auto_act_window and energy_perf when auto_select is disabled. It seems
like whether to show these two files has their own points. We'd like to
ask your advice and look forward to your reply!

Regards,
Lifeng

> 
>>
>>>
>>> ------
>>>
>>> Also just for reference, in ACPI 6.5, s8.4.6.1.2.3 Desired Performance Register
>>> """
>>> When Autonomous Selection is enabled, it is not necessary for OSPM to assess processor workload performance
>>> demand and convey a corresponding performance delivery request to the platform via the Desired Register. If the
>>> Desired Performance Register exists, OSPM may provide an explicit performance requirement hint to the platform by
>>> writing a non-zero value.
>>> """
>>>
>>> So it seems it still makes sense to have cpufreq requesting a certain performance
>>> level even though autonomous selection is enabled.
>>
>> We did struggle with this. This solves our doubts. Thanks!
>>
>>>
>>
> 


