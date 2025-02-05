Return-Path: <linux-acpi+bounces-10897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF8A2841B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 07:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E4118813D0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E3C221D9F;
	Wed,  5 Feb 2025 06:13:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC521D5B2;
	Wed,  5 Feb 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736003; cv=none; b=u54BTjpU9e2cjeQ7GIa8EyT8hnC6SA3WiEGijG6wAaLCyxqAOHXf/9bS+4s+5R9NbaeS6tBcRhp7XkOKUf7kbp4AES7DQBHzSGA6k1LTaaZRQdoEfogS2caaQk5a/2f9jGgIqv9jFQ93zOpMq26/9KOk/fhUL6wCdb5HaRRmqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736003; c=relaxed/simple;
	bh=p10IvJqFqcFd2UYdA7sFGlvIhojWB/exVMZMRq2vW8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dNY0TwncQ7Js0jmQhVFHloKCIU8hL756wetDPSd1EZ0Sh28jch3dUeIXCXniFc579NBFaLzL2gjTaPiwP2vGgTUklMgXD4bQgVcXCqVhGS2kGxaiJP/Uni2WSpPLXhvxE7oOG5TxF7uLhHFtutVz7XZiGREMenikOSL0ffegbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YnqZk6npBz11TS4;
	Wed,  5 Feb 2025 14:09:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C1F2C1800E6;
	Wed,  5 Feb 2025 14:13:15 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Feb
 2025 14:13:14 +0800
Message-ID: <be69bd58-e5f0-4b4c-8eaf-37eefaef4f90@huawei.com>
Date: Wed, 5 Feb 2025 14:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Russell Haley <yumpusamongus@gmail.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
 <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
 <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
 <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
 <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
 <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
 <9f5f8181-7d0e-415d-b473-0e3c6601ccc3@amd.com>
 <0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com>
 <bf3d232eef124080eb0482ff1b43c17739a1c50b.camel@linux.intel.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <bf3d232eef124080eb0482ff1b43c17739a1c50b.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello,

Sorry for my delay due to the recent holiday.

On 2025/1/24 22:18, srinivas pandruvada wrote:

> On Fri, 2025-01-24 at 11:53 +0800, zhenglifeng (A) wrote:
>> On 2025/1/24 1:05, Mario Limonciello wrote:
>>
>>> On 1/23/2025 10:46, Srinivas Pandruvada wrote:
>>>>
>>>> On 1/20/25 18:42, zhenglifeng (A) wrote:
>>>>> On 2025/1/21 1:44, Mario Limonciello wrote:
>>>>>
>>>>>> On 1/20/2025 08:49, Pierre Gondois wrote:
>>>>>>>
>>>>>>> On 1/20/25 04:15, zhenglifeng (A) wrote:
>>>>>>>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>>>>>>>
>>>>>>>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>>>>>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>>>>>>>
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> I noticed something here just as a user casually
>>>>>>>>>>> browsing the mailing list.
>>>>>>>>>>>
>>>>>>>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>>>>>>>> Add sysfs interfaces for CPPC autonomous
>>>>>>>>>>>> selection in the cppc_cpufreq
>>>>>>>>>>>> driver.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Lifeng Zheng
>>>>>>>>>>>> <zhenglifeng1@huawei.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     .../ABI/testing/sysfs-devices-system-cpu     
>>>>>>>>>>>> |  54 +++++++++
>>>>>>>>>>>>     drivers/cpufreq/cppc_cpufreq.c               
>>>>>>>>>>>> | 109 +++++++ ++++ +++++++
>>>>>>>>>>>>     2 files changed, 163 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-
>>>>>>>>>>>> devices-system-cpu b/
>>>>>>>>>>>> Documentation/ABI/testing/sysfs-devices-system-
>>>>>>>>>>>> cpu
>>>>>>>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-
>>>>>>>>>>>> system-cpu
>>>>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-
>>>>>>>>>>>> system-cpu
>>>>>>>>>>>> @@ -268,6 +268,60 @@ Description:    Discover
>>>>>>>>>>>> CPUs in the same CPU frequency coordination
>>>>>>>>>>>> domain
>>>>>>>>>>>>             This file is only present if the
>>>>>>>>>>>> acpi-cpufreq or the cppc-cpufreq
>>>>>>>>>>>>             drivers are in use.
>>>>>>>>>>> [...snip...]
>>>>>>>>>>>
>>>>>>>>>>>> +What:       
>>>>>>>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>>>>>>>> +Date:        October 2024
>>>>>>>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>>>>>>>> +Description:    Energy performance preference
>>>>>>>>>>>> +
>>>>>>>>>>>> +        Read/write an 8-bit integer from/to this
>>>>>>>>>>>> file. This file
>>>>>>>>>>>> +        represents a range of values from 0
>>>>>>>>>>>> (performance preference) to
>>>>>>>>>>>> +        0xFF (energy efficiency preference) that
>>>>>>>>>>>> influences the rate of
>>>>>>>>>>>> +        performance increase/decrease and the
>>>>>>>>>>>> result of the hardware's
>>>>>>>>>>>> +        energy efficiency and performance
>>>>>>>>>>>> optimization policies.
>>>>>>>>>>>> +
>>>>>>>>>>>> +        Writing to this file only has meaning
>>>>>>>>>>>> when Autonomous Selection is
>>>>>>>>>>>> +        enabled.
>>>>>>>>>>>> +
>>>>>>>>>>>> +        This file only presents if the cppc-
>>>>>>>>>>>> cpufreq driver is in use.
>>>>>>>>>>> In intel_pstate driver, there is file with near-
>>>>>>>>>>> identical semantics:
>>>>>>>>>>>
>>>>>>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_perform
>>>>>>>>>>> ance_preference
>>>>>>>>>>>
>>>>>>>>>>> It also accepts a few string arguments and converts
>>>>>>>>>>> them to integers.
>>>>>>>>>>>
>>>>>>>>>>> Perhaps the same name should be used, and the
>>>>>>>>>>> semantics made exactly
>>>>>>>>>>> identical, and then it could be documented as
>>>>>>>>>>> present for either
>>>>>>>>>>> cppc_cpufreq OR intel_pstate?
>>>>>>>>>>>
>>>>>>>>>>> I think would be more elegant if userspace tooling
>>>>>>>>>>> could Just Work with
>>>>>>>>>>> either driver.
>>>>>>>>>>>
>>>>>>>>>>> One might object that the frequency selection
>>>>>>>>>>> behavior that results from
>>>>>>>>>>> any particular value of the register itself might
>>>>>>>>>>> be different, but they
>>>>>>>>>>> are *already* different between Intel's P and E-
>>>>>>>>>>> cores in the same CPU
>>>>>>>>>>> package. (Ugh.)
>>>>>>>>>> Yes, I should use the same name. Thanks.
>>>>>>>>>>
>>>>>>>>>> As for accepting string arguments and converting them
>>>>>>>>>> to integers, I don't
>>>>>>>>>> think it is necessary. It'll be a litte confused if
>>>>>>>>>> someone writes a raw
>>>>>>>>>> value and reads a string I think. I prefer to let
>>>>>>>>>> users freely set this
>>>>>>>>>> value.
>>>>>>>>>>
>>>>>>>>>> In addition, there are many differences between the
>>>>>>>>>> implementations of
>>>>>>>>>> energy_performance_preference in intel_pstate and
>>>>>>>>>> cppc_cpufreq (and
>>>>>>>>>> amd-pstate...). It is really difficult to explain all
>>>>>>>>>> this differences in
>>>>>>>>>> this document. So I'll leave it to be documented as
>>>>>>>>>> present for
>>>>>>>>>> cppc_cpufreq only.
>>>>>>>>> At least the interface to userspace I think we should
>>>>>>>>> do the best we can to be the same between all the
>>>>>>>>> drivers if possible.
>>>>>>>>>
>>>>>>>>> For example; I've got a patch that I may bring up in a
>>>>>>>>> future kernel cycle that adds raw integer writes to
>>>>>>>>> amd-pstates energy_performance_profile to behave the
>>>>>>>>> same way intel-pstate does.
>>>>>>>> I agree that it's better to keep this interface
>>>>>>>> consistent across different
>>>>>>>> drivers. But in my opinion, the implementation of
>>>>>>>> intel_pstate
>>>>>>>> energy_performance_preference is not really nice. Someone
>>>>>>>> may write a raw
>>>>>>>> value but read a string, or read strings for some values
>>>>>>>> and read raw
>>>>>>>> values for some other values. It is inconsistent. It may
>>>>>>>> be better to use
>>>>>>>> some other implementation, such as seperating the
>>>>>>>> operations of r/w strings
>>>>>>>> and raw values into two files.
>>>>>>> I agree it would be better to be sure of the type to expect
>>>>>>> when reading the
>>>>>>> energy_performance_preference file. The epp values in the
>>>>>>> range 0-255 with 0
>>>>>>> being the performance value for all interfaces.
>>>>>>>
>>>>>>> In the current epp strings, it seems there is a big gap
>>>>>>> between the PERFORMANCE
>>>>>>> and the BALANCE_PERFORMANCE strings. Maybe it would be good
>>>>>>> to complete it:
>>>>>>> EPP_PERFORMANCE        0x00
>>>>>>> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
>>>>>>> EPP_BALANCE        0x80      // new state
>>>>>>> EPP_BALANCE_POWERSAVE    0xC0
>>>>>>> EPP_POWERSAVE        0xFF
>>>>>>>
>>>>>>> NIT: The mapping seems to be slightly different for
>>>>>>> intel_pstate and amd-pstate
>>>>>>> currently:
>>>>>>> drivers/cpufreq/amd-pstate.c
>>>>>>> #define AMD_CPPC_EPP_PERFORMANCE        0x00
>>>>>>> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
>>>>>>> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
>>>>>>> #define AMD_CPPC_EPP_POWERSAVE            0xFF
>>>>>>>
>>>>>>> arch/x86/include/asm/msr-index.h
>>>>>>> #define HWP_EPP_PERFORMANCE        0x00
>>>>>>> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
>>>>>>> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------
>>>>>>> Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
>>>>>>> #define HWP_EPP_POWERSAVE        0xFF
>>>>>>>
>>>>>>>> I think it's better to consult Rafael and Viresh about
>>>>>>>> how this should
>>>>>>>> evolve.
>>>>>>> Yes indeed
>>>>>> Maybe it's best to discuss what the goal of raw EPP number
>>>>>> writes is to decide what to do with it.
>>>>>>
>>>>>> IE in intel-pstate is it for userspace to be able to actually
>>>>>> utilize something besides the strings all the time?  Or is it
>>>>>> just for debugging to find better values for strings in the
>>>>>> future?
>>>>>>
>>>>>> If the former maybe we're better off splitting to
>>>>>> 'energy_performance_preference' and
>>>>>> 'energy_performance_preference_int'.
>>>>>>
>>>>>> If the latter maybe we're better off putting the integer
>>>>>> writes and reads into debugfs instead and making
>>>>>> 'energy_performance_preference' return -EINVAL while a non-
>>>>>> predefined value is in use.
>>>>
>>>> In Intel case EPP values can be different based on processor. In
>>>> some case they they end up sharing the same CPU model. So strings
>>>> are not suitable for all cases. Also there is different
>>>> preference of EPP between Chrome systems and non chrome distro.
>>>> For example Chrome has some resource manager which can change and
>>>> same on Intel distros with LPMD.
>>>>
>>>
>>> Thanks for confirming it is intentional and changing it would break
>>> existing userspace.
>>>
>>> And FWIW even in Windows there are more than 4 situational values
>>> used like we have in Linux today.
>>>
>>> As the status quo is there I personally feel that we should do the
>>> exact same for other implementation of
>>> energy_performance_preference.
>>
>> I still don't think this implementation is nice, for the following
>> reasons:
>>
>> 1. Users may write raw value but read string. It's odd.
>>
>> 2. Sometimes a raw value is read and sometimes a character string is
>> read.
>> The userspace tool needs to adapt this.
>>
>> 3. Reading and writing EPP strings is not really general in driver.
>> It is
>> more reasonable to use the userspace tool to implement it.
>>
>> In order not to break existing userspace, I'll rename the file to
>> 'energy_performance_preference_int' or
>> 'energy_performance_preference_val'
>> in cppc_cpufreq and only support reading and writing raw value. As
>> for
>> accepting string arguments, it's not necessary for cppc_cpufreq for
>> now.
>> It's easy to add this feature but hard to remove, so I'll leave it to
>> the
>> future if it is really needed.
>>
>> As for amd-pstate and intel_pstate, you can decide how
>> energy_performance_preference should evolve. But I strongly recommend
>> splitting it.
> 
> No. User space can deal with this already. 

I know that. What I mean is that user space had to do more to adapt this
"sometims value sometimes string" situation. This could have been avoided.

> Atleast this has one
> interface. If you split you need to keep them consistent. You can write
> a raw value  to new attribute and then can read a string from the other
> attribute, which means different.

I won't do any change in amd-pstate and intel_pstate because it involves
too much. I'll only add a new file in cppc_cpufreq for reading and writing
EPP raw value.

> 
> This is not the only place where strings and raw values can be written
> in sysfs. Also true for energy_perf_bias.
> 
> 
> Thanks,
> Srinivas
> 
> 
> 
>>
>> Regards,
>>
>> Lifeng
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Srinivas
>>>>
>>>>
>>>>> I think it's the former.
>>>>>
>>>>> I added the author of the patch that allows raw energy
>>>>> performance
>>>>> preference value in intel_pstate to ask about what the goal is
>>>>> and if this
>>>>> would be ok to do the modification mentioned above.
>>>>>
>>>>> To see the patch from
>>>>> https://lore.kernel.org/ all/20200626183401.1495090-3-srinivas.pandruvada@linux.intel.c
>>>>> om/
>>>>>
>>>>> Anyway, the purpose of this patch is to allow users write and
>>>>> read raw EPP
>>>>> number. So maybe I can just rename the file to
>>>>> 'energy_performance_preference_int'?
>>>>>
>>>
>>
> 
> 


