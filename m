Return-Path: <linux-acpi+bounces-10770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0DA17601
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1204A1632E5
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 02:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1114D2A2;
	Tue, 21 Jan 2025 02:42:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EEDDC1;
	Tue, 21 Jan 2025 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737427375; cv=none; b=Ial/14f21Qb3/ZIvZ2R2sP9RmRPg4aS+Gfq74313aXe6a2X2XvcJnsHR1jil/nxkpX3OjkxULp1dNb4DFEIJUi4AFXwK/aq7tVIULfJnOedzSAm5TKQSAn9n9Rvq6yKzkWpZv1ny0PyfJdBfRRnzZPrMf76rplINasnzn0+kc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737427375; c=relaxed/simple;
	bh=OMpGOF52bvWfrOjNisUs1HPTL0D/Q1uTGpG2nKnY3l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HATp/vFJSTw5ueFh5BYY6UnUIqnNTTtbRbLZWbZuSjYodfKw1XaJpuyNjX4SDo//tp48Xgtb6qUFzDQFLS2olpXDvIhPKpZZAVZlPZc9XcxQDa0bDDTc9fHALx+0/X9WkqdeL8ndLMdiubWCe+D9dAvtkrxW1g+dvcuYapqGYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YcWj81JNcz20pHN;
	Tue, 21 Jan 2025 10:43:08 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C764140114;
	Tue, 21 Jan 2025 10:42:43 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 10:42:42 +0800
Message-ID: <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
Date: Tue, 21 Jan 2025 10:42:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Mario Limonciello <mario.limonciello@amd.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Russell Haley <yumpusamongus@gmail.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <srinivas.pandruvada@linux.intel.com>
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/21 1:44, Mario Limonciello wrote:

> On 1/20/2025 08:49, Pierre Gondois wrote:
>>
>>
>> On 1/20/25 04:15, zhenglifeng (A) wrote:
>>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>>
>>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I noticed something here just as a user casually browsing the mailing list.
>>>>>>
>>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>>>>> driver.
>>>>>>>
>>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>>> ---
>>>>>>>    .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++++++ +++++++
>>>>>>>    2 files changed, 163 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/ Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>>>>            This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>>>>            drivers are in use.
>>>>>>
>>>>>> [...snip...]
>>>>>>
>>>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>>> +Date:        October 2024
>>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>>> +Description:    Energy performance preference
>>>>>>> +
>>>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>>>> +        represents a range of values from 0 (performance preference) to
>>>>>>> +        0xFF (energy efficiency preference) that influences the rate of
>>>>>>> +        performance increase/decrease and the result of the hardware's
>>>>>>> +        energy efficiency and performance optimization policies.
>>>>>>> +
>>>>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>>>>> +        enabled.
>>>>>>> +
>>>>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>>>>
>>>>>> In intel_pstate driver, there is file with near-identical semantics:
>>>>>>
>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>>>
>>>>>> It also accepts a few string arguments and converts them to integers.
>>>>>>
>>>>>> Perhaps the same name should be used, and the semantics made exactly
>>>>>> identical, and then it could be documented as present for either
>>>>>> cppc_cpufreq OR intel_pstate?
>>>>>>
>>>>>> I think would be more elegant if userspace tooling could Just Work with
>>>>>> either driver.
>>>>>>
>>>>>> One might object that the frequency selection behavior that results from
>>>>>> any particular value of the register itself might be different, but they
>>>>>> are *already* different between Intel's P and E-cores in the same CPU
>>>>>> package. (Ugh.)
>>>>>
>>>>> Yes, I should use the same name. Thanks.
>>>>>
>>>>> As for accepting string arguments and converting them to integers, I don't
>>>>> think it is necessary. It'll be a litte confused if someone writes a raw
>>>>> value and reads a string I think. I prefer to let users freely set this
>>>>> value.
>>>>>
>>>>> In addition, there are many differences between the implementations of
>>>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>>>> amd-pstate...). It is really difficult to explain all this differences in
>>>>> this document. So I'll leave it to be documented as present for
>>>>> cppc_cpufreq only.
>>>>
>>>> At least the interface to userspace I think we should do the best we can to be the same between all the drivers if possible.
>>>>
>>>> For example; I've got a patch that I may bring up in a future kernel cycle that adds raw integer writes to amd-pstates energy_performance_profile to behave the same way intel-pstate does.
>>>
>>> I agree that it's better to keep this interface consistent across different
>>> drivers. But in my opinion, the implementation of intel_pstate
>>> energy_performance_preference is not really nice. Someone may write a raw
>>> value but read a string, or read strings for some values and read raw
>>> values for some other values. It is inconsistent. It may be better to use
>>> some other implementation, such as seperating the operations of r/w strings
>>> and raw values into two files.
>>
>> I agree it would be better to be sure of the type to expect when reading the
>> energy_performance_preference file. The epp values in the range 0-255 with 0
>> being the performance value for all interfaces.
>>
>> In the current epp strings, it seems there is a big gap between the PERFORMANCE
>> and the BALANCE_PERFORMANCE strings. Maybe it would be good to complete it:
>> EPP_PERFORMANCE        0x00
>> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
>> EPP_BALANCE        0x80      // new state
>> EPP_BALANCE_POWERSAVE    0xC0
>> EPP_POWERSAVE        0xFF
>>
>> NIT: The mapping seems to be slightly different for intel_pstate and amd-pstate
>> currently:
>> drivers/cpufreq/amd-pstate.c
>> #define AMD_CPPC_EPP_PERFORMANCE        0x00
>> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
>> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
>> #define AMD_CPPC_EPP_POWERSAVE            0xFF
>>
>> arch/x86/include/asm/msr-index.h
>> #define HWP_EPP_PERFORMANCE        0x00
>> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
>> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------ Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
>> #define HWP_EPP_POWERSAVE        0xFF
>>
>>>
>>> I think it's better to consult Rafael and Viresh about how this should
>>> evolve.
>>
>> Yes indeed
> 
> Maybe it's best to discuss what the goal of raw EPP number writes is to decide what to do with it.
> 
> IE in intel-pstate is it for userspace to be able to actually utilize something besides the strings all the time?  Or is it just for debugging to find better values for strings in the future?
> 
> If the former maybe we're better off splitting to 'energy_performance_preference' and 'energy_performance_preference_int'.
> 
> If the latter maybe we're better off putting the integer writes and reads into debugfs instead and making 'energy_performance_preference' return -EINVAL while a non-predefined value is in use.

I think it's the former. 

I added the author of the patch that allows raw energy performance
preference value in intel_pstate to ask about what the goal is and if this
would be ok to do the modification mentioned above.

To see the patch from https://lore.kernel.org/all/20200626183401.1495090-3-srinivas.pandruvada@linux.intel.com/

Anyway, the purpose of this patch is to allow users write and read raw EPP
number. So maybe I can just rename the file to
'energy_performance_preference_int'?

