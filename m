Return-Path: <linux-acpi+bounces-10763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F656A16EC7
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B01165827
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24A1E3DEB;
	Mon, 20 Jan 2025 14:49:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C01E3DE4;
	Mon, 20 Jan 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384596; cv=none; b=kAsEpfh7svkf7yqYxTp5cv0HWDtO5A3wKsmLuiUWt5vXGBlC/5oQldaEAsb1fhWCD64rARH7MlNpCCFycxuHhdXc8SxdE3eV3B0Ypg0WMpJqjiqcC2DD1hINvIvnoeGKqBCZl0uLyJBQZLbLrYu31xVgUoT23Z5DBrZO8NSJhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384596; c=relaxed/simple;
	bh=Lz4XZCsWuH3FfKd8cbIPejJRiC2dpV7ujU8RZWqZtLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUQ0tszdg9pp6kUo4UgFZ4ePG4sypOe0hltLdXE5HKBTNfT9lhTj+ThZ6ZIzMiyho1A99rai6tAwiP2BR1dFxw0Ez+ChN/XetrPaYCue+xOrgaHbqVVrLc/f/G4sU01eYn337Tl4LZKc1+s0m52F4U/XqG/HQR6fih7tylMLU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF56D1063;
	Mon, 20 Jan 2025 06:50:21 -0800 (PST)
Received: from [10.57.94.139] (unknown [10.57.94.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB173F740;
	Mon, 20 Jan 2025 06:49:49 -0800 (PST)
Message-ID: <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
Date: Mon, 20 Jan 2025 15:49:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Russell Haley <yumpusamongus@gmail.com>, rafael@kernel.org, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
 <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/20/25 04:15, zhenglifeng (A) wrote:
> On 2025/1/17 22:30, Mario Limonciello wrote:
> 
>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>
>>>> Hello,
>>>>
>>>> I noticed something here just as a user casually browsing the mailing list.
>>>>
>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>>> driver.
>>>>>
>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>> ---
>>>>>    .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>>>>>    2 files changed, 163 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>>            This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>>            drivers are in use.
>>>>>    
>>>>
>>>> [...snip...]
>>>>
>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>> +Date:        October 2024
>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>> +Description:    Energy performance preference
>>>>> +
>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>> +        represents a range of values from 0 (performance preference) to
>>>>> +        0xFF (energy efficiency preference) that influences the rate of
>>>>> +        performance increase/decrease and the result of the hardware's
>>>>> +        energy efficiency and performance optimization policies.
>>>>> +
>>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>>> +        enabled.
>>>>> +
>>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>>
>>>> In intel_pstate driver, there is file with near-identical semantics:
>>>>
>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>
>>>> It also accepts a few string arguments and converts them to integers.
>>>>
>>>> Perhaps the same name should be used, and the semantics made exactly
>>>> identical, and then it could be documented as present for either
>>>> cppc_cpufreq OR intel_pstate?
>>>>
>>>> I think would be more elegant if userspace tooling could Just Work with
>>>> either driver.
>>>>
>>>> One might object that the frequency selection behavior that results from
>>>> any particular value of the register itself might be different, but they
>>>> are *already* different between Intel's P and E-cores in the same CPU
>>>> package. (Ugh.)
>>>
>>> Yes, I should use the same name. Thanks.
>>>
>>> As for accepting string arguments and converting them to integers, I don't
>>> think it is necessary. It'll be a litte confused if someone writes a raw
>>> value and reads a string I think. I prefer to let users freely set this
>>> value.
>>>
>>> In addition, there are many differences between the implementations of
>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>> amd-pstate...). It is really difficult to explain all this differences in
>>> this document. So I'll leave it to be documented as present for
>>> cppc_cpufreq only.
>>
>> At least the interface to userspace I think we should do the best we can to be the same between all the drivers if possible.
>>
>> For example; I've got a patch that I may bring up in a future kernel cycle that adds raw integer writes to amd-pstates energy_performance_profile to behave the same way intel-pstate does.
> 
> I agree that it's better to keep this interface consistent across different
> drivers. But in my opinion, the implementation of intel_pstate
> energy_performance_preference is not really nice. Someone may write a raw
> value but read a string, or read strings for some values and read raw
> values for some other values. It is inconsistent. It may be better to use
> some other implementation, such as seperating the operations of r/w strings
> and raw values into two files.

I agree it would be better to be sure of the type to expect when reading the
energy_performance_preference file. The epp values in the range 0-255 with 0
being the performance value for all interfaces.

In the current epp strings, it seems there is a big gap between the PERFORMANCE
and the BALANCE_PERFORMANCE strings. Maybe it would be good to complete it:
EPP_PERFORMANCE		0x00
EPP_BALANCE_PERFORMANCE	0x40      // state value changed
EPP_BALANCE		0x80      // new state
EPP_BALANCE_POWERSAVE	0xC0
EPP_POWERSAVE		0xFF

NIT: The mapping seems to be slightly different for intel_pstate and amd-pstate
currently:
drivers/cpufreq/amd-pstate.c
#define AMD_CPPC_EPP_PERFORMANCE		0x00
#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
#define AMD_CPPC_EPP_POWERSAVE			0xFF

arch/x86/include/asm/msr-index.h
#define HWP_EPP_PERFORMANCE		0x00
#define HWP_EPP_BALANCE_PERFORMANCE	0x80
#define HWP_EPP_BALANCE_POWERSAVE	0xC0   <------ Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
#define HWP_EPP_POWERSAVE		0xFF

> 
> I think it's better to consult Rafael and Viresh about how this should
> evolve.

Yes indeed

