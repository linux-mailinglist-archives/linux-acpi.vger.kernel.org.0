Return-Path: <linux-acpi+bounces-10799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF487A1A810
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4551166BC9
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3761420DD;
	Thu, 23 Jan 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UplbQNzn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5E13FD83;
	Thu, 23 Jan 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650785; cv=none; b=rlfBUgGcEUvLQ1AA7evCgiHLrFTZtfoD+1jajzZnaMDXNp1sjsEQZEGoyEYK97rDIFAmpmedMh+yRAZm0Wz17CPPsmlpZMxr+Yx+2rWZjmHOSAZicd+xngy34YtsW5rmHftsD788uVgp8qg3o8marUGJnDTLAk5YrHDPAtZCArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650785; c=relaxed/simple;
	bh=83LnnZxOTTSzxbdjJ3YOvtN7jBXax83Q2g3OhaEF5Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2IzKjuA2hU9hP+m9UxlIRtnF3Vz0EBB6ZYy9zGLp1hMPBkJ3Fm4nPPm2ddH0TPyV3NC7b8hcwV9oKCwNcfT553bZiy+JK0Zth97H2Cw0YmH7+4gNVTmAnzNVxbgCJiGt9XZVwradTb8AVsvErReAPw1+2vw75cLS0bG+7yPfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UplbQNzn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737650785; x=1769186785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=83LnnZxOTTSzxbdjJ3YOvtN7jBXax83Q2g3OhaEF5Po=;
  b=UplbQNznVykV6j1kSdaaVScCfLE6ECf0MjoFVCDaFhX8PZ/D8+thQIA2
   R6CDqi8DzNqlopm8tLXa4uBjyB4ulUe9iMH9nwrfsmw5OCJbIgRsSDDn7
   o8JWuEA8JW4T/JGvdQkccJGURlJzEm1YfzBfxmZlOgktuzRWV4fo0bLd3
   7LapnFDagy8QR0TEfkGCro5xKd0sU51QHhS4E8faOzLjuqCyOK/eSVPZj
   x7DyuyJRwcMPBKD4M9VN/4UbDhwg82oNhy5c5rVKqbSupoQk7u7eViJXy
   vvNoC6yWK/E0DY1CuCCK9mAcXB4ihRzUKHJvH27v3wxzLViB5rNEk6OoE
   A==;
X-CSE-ConnectionGUID: hBn/IKPLSX6/KAnrxy24jA==
X-CSE-MsgGUID: RUGdc5osRL6GSA+z7KNYGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41831099"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="41831099"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:46:24 -0800
X-CSE-ConnectionGUID: ZCqobIFJRWSUuNBHeTd6Ag==
X-CSE-MsgGUID: /pcg9mEXQHibgZshJEQoZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112644709"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO [10.125.110.212]) ([10.125.110.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:46:21 -0800
Message-ID: <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
Date: Thu, 23 Jan 2025 08:46:20 -0800
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
 Pierre Gondois <pierre.gondois@arm.com>,
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
 <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
 <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
 <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
Content-Language: en-US
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/20/25 18:42, zhenglifeng (A) wrote:
> On 2025/1/21 1:44, Mario Limonciello wrote:
>
>> On 1/20/2025 08:49, Pierre Gondois wrote:
>>>
>>> On 1/20/25 04:15, zhenglifeng (A) wrote:
>>>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>>>
>>>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I noticed something here just as a user casually browsing the mailing list.
>>>>>>>
>>>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>>>>>> driver.
>>>>>>>>
>>>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>>>> ---
>>>>>>>>     .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>>>>     drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++++++ +++++++
>>>>>>>>     2 files changed, 163 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/ Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>>>>>             This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>>>>>             drivers are in use.
>>>>>>> [...snip...]
>>>>>>>
>>>>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>>>> +Date:        October 2024
>>>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>>>> +Description:    Energy performance preference
>>>>>>>> +
>>>>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>>>>> +        represents a range of values from 0 (performance preference) to
>>>>>>>> +        0xFF (energy efficiency preference) that influences the rate of
>>>>>>>> +        performance increase/decrease and the result of the hardware's
>>>>>>>> +        energy efficiency and performance optimization policies.
>>>>>>>> +
>>>>>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>>>>>> +        enabled.
>>>>>>>> +
>>>>>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>>>>> In intel_pstate driver, there is file with near-identical semantics:
>>>>>>>
>>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>>>>
>>>>>>> It also accepts a few string arguments and converts them to integers.
>>>>>>>
>>>>>>> Perhaps the same name should be used, and the semantics made exactly
>>>>>>> identical, and then it could be documented as present for either
>>>>>>> cppc_cpufreq OR intel_pstate?
>>>>>>>
>>>>>>> I think would be more elegant if userspace tooling could Just Work with
>>>>>>> either driver.
>>>>>>>
>>>>>>> One might object that the frequency selection behavior that results from
>>>>>>> any particular value of the register itself might be different, but they
>>>>>>> are *already* different between Intel's P and E-cores in the same CPU
>>>>>>> package. (Ugh.)
>>>>>> Yes, I should use the same name. Thanks.
>>>>>>
>>>>>> As for accepting string arguments and converting them to integers, I don't
>>>>>> think it is necessary. It'll be a litte confused if someone writes a raw
>>>>>> value and reads a string I think. I prefer to let users freely set this
>>>>>> value.
>>>>>>
>>>>>> In addition, there are many differences between the implementations of
>>>>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>>>>> amd-pstate...). It is really difficult to explain all this differences in
>>>>>> this document. So I'll leave it to be documented as present for
>>>>>> cppc_cpufreq only.
>>>>> At least the interface to userspace I think we should do the best we can to be the same between all the drivers if possible.
>>>>>
>>>>> For example; I've got a patch that I may bring up in a future kernel cycle that adds raw integer writes to amd-pstates energy_performance_profile to behave the same way intel-pstate does.
>>>> I agree that it's better to keep this interface consistent across different
>>>> drivers. But in my opinion, the implementation of intel_pstate
>>>> energy_performance_preference is not really nice. Someone may write a raw
>>>> value but read a string, or read strings for some values and read raw
>>>> values for some other values. It is inconsistent. It may be better to use
>>>> some other implementation, such as seperating the operations of r/w strings
>>>> and raw values into two files.
>>> I agree it would be better to be sure of the type to expect when reading the
>>> energy_performance_preference file. The epp values in the range 0-255 with 0
>>> being the performance value for all interfaces.
>>>
>>> In the current epp strings, it seems there is a big gap between the PERFORMANCE
>>> and the BALANCE_PERFORMANCE strings. Maybe it would be good to complete it:
>>> EPP_PERFORMANCE        0x00
>>> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
>>> EPP_BALANCE        0x80      // new state
>>> EPP_BALANCE_POWERSAVE    0xC0
>>> EPP_POWERSAVE        0xFF
>>>
>>> NIT: The mapping seems to be slightly different for intel_pstate and amd-pstate
>>> currently:
>>> drivers/cpufreq/amd-pstate.c
>>> #define AMD_CPPC_EPP_PERFORMANCE        0x00
>>> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
>>> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
>>> #define AMD_CPPC_EPP_POWERSAVE            0xFF
>>>
>>> arch/x86/include/asm/msr-index.h
>>> #define HWP_EPP_PERFORMANCE        0x00
>>> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
>>> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------ Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
>>> #define HWP_EPP_POWERSAVE        0xFF
>>>
>>>> I think it's better to consult Rafael and Viresh about how this should
>>>> evolve.
>>> Yes indeed
>> Maybe it's best to discuss what the goal of raw EPP number writes is to decide what to do with it.
>>
>> IE in intel-pstate is it for userspace to be able to actually utilize something besides the strings all the time?  Or is it just for debugging to find better values for strings in the future?
>>
>> If the former maybe we're better off splitting to 'energy_performance_preference' and 'energy_performance_preference_int'.
>>
>> If the latter maybe we're better off putting the integer writes and reads into debugfs instead and making 'energy_performance_preference' return -EINVAL while a non-predefined value is in use.

In Intel case EPP values can be different based on processor. In some 
case they they end up sharing the same CPU model. So strings are not 
suitable for all cases. Also there is different preference of EPP 
between Chrome systems and non chrome distro. For example Chrome has 
some resource manager which can change and same on Intel distros with LPMD.


Thanks,

Srinivas


> I think it's the former.
>
> I added the author of the patch that allows raw energy performance
> preference value in intel_pstate to ask about what the goal is and if this
> would be ok to do the modification mentioned above.
>
> To see the patch from https://lore.kernel.org/all/20200626183401.1495090-3-srinivas.pandruvada@linux.intel.com/
>
> Anyway, the purpose of this patch is to allow users write and read raw EPP
> number. So maybe I can just rename the file to
> 'energy_performance_preference_int'?
>

