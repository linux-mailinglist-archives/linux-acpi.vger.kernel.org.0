Return-Path: <linux-acpi+bounces-10814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82618A1B7EC
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 15:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59783188F0EB
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AF139597;
	Fri, 24 Jan 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvvGmNDr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2670830;
	Fri, 24 Jan 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729176; cv=none; b=uBXTPMFTaWF3Oq8koUxx6vr7g+KVZ7+IDlLBuBbs2cdCb/XjPuc5xALjHFBD9Qfi+a5MD7lglvUXLiGUELQgsKmtzK41mkTLH0/vEeeukWQIaQeWaiNxoQ1u2XcLBvyclqmtymQ5g4des514hvTOoEzZmdCCZhFor9rgcVvZEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729176; c=relaxed/simple;
	bh=+JbLpkbGsSwDjTkUPccI/1tcnT/roa8ukaZkXQw/ATs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwvTDi/2BpO2/gMt5diP6y+ALc70oH+8l4S9vHLQsWNQJsuFEtNu6Vc1D0+ox0OgyUJ4lrhW4OwpLneOXZGclpgu/6eG+UcYq3HRcfNYZbBHhAxQgCup/Lsp3rwhhsvI/8V8N34+cSaeLJgkLBWj0wx3F4NUDgBekLPQ42ZlXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvvGmNDr; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso3077587276.2;
        Fri, 24 Jan 2025 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729173; x=1738333973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkzDlTBYKkZbEkhXovf2VM05UFWZ4XBkvbz/h4bW6as=;
        b=NvvGmNDrTz4B8Rr2eq6J+pq6tJkOz0C87OyQQUIyYaiiBKJBSnMpkNlMgjqiINwTi3
         esT34Sql8hqGTTR99WO7NN4X0ebI0M5JXifl3sS3KjuZAp4bGRY1W/Ag9LIYJBcAprH8
         svE41d0kF7UxEqoiQNhaRrZcuEhH/lnWbgxiP8txnNuVD5+BKV/5rnS1i81KGNyrEBfR
         LfZnXV4G8qObg/Zz5vJDiPWWOg7u4pVysxKDoNHB9iufHccKJaMJty/K/fsFAZIfIdqK
         ez58OLA0TaOj798MunGT6Y2H5vebO6Z1yiShuFz7S/IUgAvhxTn3dW7YFIzHGLTVI4iQ
         hrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729173; x=1738333973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkzDlTBYKkZbEkhXovf2VM05UFWZ4XBkvbz/h4bW6as=;
        b=BP7CHXpND/wNciJTa2yPC2KVuIRr/qaw4v8A9Gu4Z34DlWbDZDPKIwtgTdGh8WOH9l
         tgpddXH2AhsQ/2W58+oTY4b5izYtPamhAce/SOovKxKb7atvewVLkT/2abdw1aR4KE3W
         eysoodfnuW/o2MMd4rkQ1auG3FyNX3FkFJ6AIudAn8lcflFZI+jMQNiSdldfu03FExG2
         Nh7vfY231gP18JfKZfudUSX1tvyj43ScMQ0AYTe400vOtDW022TC5xws26pc3nFUMC3E
         9QDupOyvjeVvMh++MHDD32otp0AkZJpfs76hsKXyD2blqh3hueUX7a083Mqk+bqPeSM8
         nfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7K1bRHa+XHX9Id+T5oJ0kOdydAUMjBc5tAGSv/zmX6D/I+QX2VQrutDEC29QcixaWvD7XywzPYC4dQfM2@vger.kernel.org, AJvYcCXHFZeSiEtT5cfpeV52Br5Qb8cnak4Db8Q2V/Pw6skoDTG9V66Bo/Vd8oKEZo7JjvOpwe4/zTh/quU=@vger.kernel.org, AJvYcCXzhsByXvKM8il9FYekauw8/a5Ne714OLifiD1w/a6QHtaK0z9CZhP7EOYlh6kCWSDi++5dhqIHTAsp@vger.kernel.org
X-Gm-Message-State: AOJu0YytRZCWYVRlYwSj2mAzoQtbO65hkhpk02/Ts6+8td9Rjh33fJNN
	VD3J+8Z8nT6Fox4tMGxSzQ14q68TZoBHtKU7QlZmAQyBXXL7jyjzYgcnFhlW
X-Gm-Gg: ASbGnctxerIdZy5hXi5MewE1ozC2NjRGAbITG07Ou16be53mluxTBXP2oZx2qbZuSWh
	vF5DuyPR0G/r3yfGwvOG01eGz67RRIZUixX1psi9URbM1fauZjqYP66s13eQyrJSVBdjjyJCPB8
	NEnNW82e2vNl91YD4ZcCCkwtwRy5251uEAR+yW6hMkJfHYvAh/QlSmwx1arirZAnBL8z9FkVHpL
	Ct631jvUAa7MnbQuvaqo6HooKAs0QSc90kLQqV43S0z6WYm4jTvwEBGVgKwkv+rh07d3VIV//J9
	24DgYybkWWweN6lDxtZy
X-Google-Smtp-Source: AGHT+IFNO3aV79+rd0MaR7/XrShZfKB3YSCMhAgO/Hb7n6q0OrA6zuUF8q1jAX3DQ1Sp2NcdR+k9jg==
X-Received: by 2002:a05:6902:10cb:b0:e4e:891:c8cd with SMTP id 3f1490d57ef6-e57b1046904mr21064817276.14.1737729173277;
        Fri, 24 Jan 2025 06:32:53 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e583b865973sm358988276.39.2025.01.24.06.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 06:32:52 -0800 (PST)
Message-ID: <6a54f96b-28c9-4cbc-8c8f-a07a3a7048e5@gmail.com>
Date: Fri, 24 Jan 2025 08:32:51 -0600
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
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org, lenb@kernel.org,
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
 <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
 <9f5f8181-7d0e-415d-b473-0e3c6601ccc3@amd.com>
 <0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/25 9:53 PM, zhenglifeng (A) wrote:
> On 2025/1/24 1:05, Mario Limonciello wrote:
> 
>> On 1/23/2025 10:46, Srinivas Pandruvada wrote:
>>>
>>> On 1/20/25 18:42, zhenglifeng (A) wrote:
>>>> On 2025/1/21 1:44, Mario Limonciello wrote:
>>>>
>>>>> On 1/20/2025 08:49, Pierre Gondois wrote:
>>>>>>
>>>>>> On 1/20/25 04:15, zhenglifeng (A) wrote:
>>>>>>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>>>>>>
>>>>>>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>>>>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> I noticed something here just as a user casually browsing the mailing list.
>>>>>>>>>>
>>>>>>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>>>>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>>>>>>>>> driver.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>>>>>>> ---
>>>>>>>>>>>     .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>>>>>>>     drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++ ++++ +++++++
>>>>>>>>>>>     2 files changed, 163 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/ Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>>>>>>>>             This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>>>>>>>>             drivers are in use.
>>>>>>>>>> [...snip...]
>>>>>>>>>>
>>>>>>>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>>>>>>> +Date:        October 2024
>>>>>>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>>>>>>> +Description:    Energy performance preference
>>>>>>>>>>> +
>>>>>>>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>>>>>>>> +        represents a range of values from 0 (performance preference) to
>>>>>>>>>>> +        0xFF (energy efficiency preference) that influences the rate of
>>>>>>>>>>> +        performance increase/decrease and the result of the hardware's
>>>>>>>>>>> +        energy efficiency and performance optimization policies.
>>>>>>>>>>> +
>>>>>>>>>>> +        Writing to this file only has meaning when Autonomous Selection is
>>>>>>>>>>> +        enabled.
>>>>>>>>>>> +
>>>>>>>>>>> +        This file only presents if the cppc-cpufreq driver is in use.
>>>>>>>>>> In intel_pstate driver, there is file with near-identical semantics:
>>>>>>>>>>
>>>>>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>>>>>>>
>>>>>>>>>> It also accepts a few string arguments and converts them to integers.
>>>>>>>>>>
>>>>>>>>>> Perhaps the same name should be used, and the semantics made exactly
>>>>>>>>>> identical, and then it could be documented as present for either
>>>>>>>>>> cppc_cpufreq OR intel_pstate?
>>>>>>>>>>
>>>>>>>>>> I think would be more elegant if userspace tooling could Just Work with
>>>>>>>>>> either driver.
>>>>>>>>>>
>>>>>>>>>> One might object that the frequency selection behavior that results from
>>>>>>>>>> any particular value of the register itself might be different, but they
>>>>>>>>>> are *already* different between Intel's P and E-cores in the same CPU
>>>>>>>>>> package. (Ugh.)
>>>>>>>>> Yes, I should use the same name. Thanks.
>>>>>>>>>
>>>>>>>>> As for accepting string arguments and converting them to integers, I don't
>>>>>>>>> think it is necessary. It'll be a litte confused if someone writes a raw
>>>>>>>>> value and reads a string I think. I prefer to let users freely set this
>>>>>>>>> value.
>>>>>>>>>
>>>>>>>>> In addition, there are many differences between the implementations of
>>>>>>>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>>>>>>>> amd-pstate...). It is really difficult to explain all this differences in
>>>>>>>>> this document. So I'll leave it to be documented as present for
>>>>>>>>> cppc_cpufreq only.
>>>>>>>> At least the interface to userspace I think we should do the best we can to be the same between all the drivers if possible.
>>>>>>>>
>>>>>>>> For example; I've got a patch that I may bring up in a future kernel cycle that adds raw integer writes to amd-pstates energy_performance_profile to behave the same way intel-pstate does.
>>>>>>> I agree that it's better to keep this interface consistent across different
>>>>>>> drivers. But in my opinion, the implementation of intel_pstate
>>>>>>> energy_performance_preference is not really nice. Someone may write a raw
>>>>>>> value but read a string, or read strings for some values and read raw
>>>>>>> values for some other values. It is inconsistent. It may be better to use
>>>>>>> some other implementation, such as seperating the operations of r/w strings
>>>>>>> and raw values into two files.
>>>>>> I agree it would be better to be sure of the type to expect when reading the
>>>>>> energy_performance_preference file. The epp values in the range 0-255 with 0
>>>>>> being the performance value for all interfaces.
>>>>>>
>>>>>> In the current epp strings, it seems there is a big gap between the PERFORMANCE
>>>>>> and the BALANCE_PERFORMANCE strings. Maybe it would be good to complete it:
>>>>>> EPP_PERFORMANCE        0x00
>>>>>> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
>>>>>> EPP_BALANCE        0x80      // new state
>>>>>> EPP_BALANCE_POWERSAVE    0xC0
>>>>>> EPP_POWERSAVE        0xFF
>>>>>>
>>>>>> NIT: The mapping seems to be slightly different for intel_pstate and amd-pstate
>>>>>> currently:
>>>>>> drivers/cpufreq/amd-pstate.c
>>>>>> #define AMD_CPPC_EPP_PERFORMANCE        0x00
>>>>>> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
>>>>>> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
>>>>>> #define AMD_CPPC_EPP_POWERSAVE            0xFF
>>>>>>
>>>>>> arch/x86/include/asm/msr-index.h
>>>>>> #define HWP_EPP_PERFORMANCE        0x00
>>>>>> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
>>>>>> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------ Different from AMD_CPPC_EPP_BALANCE_POWERSAVE
>>>>>> #define HWP_EPP_POWERSAVE        0xFF
>>>>>>
>>>>>>> I think it's better to consult Rafael and Viresh about how this should
>>>>>>> evolve.
>>>>>> Yes indeed
>>>>> Maybe it's best to discuss what the goal of raw EPP number writes is to decide what to do with it.
>>>>>
>>>>> IE in intel-pstate is it for userspace to be able to actually utilize something besides the strings all the time?  Or is it just for debugging to find better values for strings in the future?
>>>>>
>>>>> If the former maybe we're better off splitting to 'energy_performance_preference' and 'energy_performance_preference_int'.
>>>>>
>>>>> If the latter maybe we're better off putting the integer writes and reads into debugfs instead and making 'energy_performance_preference' return -EINVAL while a non-predefined value is in use.
>>>
>>> In Intel case EPP values can be different based on processor. In some case they they end up sharing the same CPU model. So strings are not suitable for all cases. Also there is different preference of EPP between Chrome systems and non chrome distro. For example Chrome has some resource manager which can change and same on Intel distros with LPMD.
>>>
>>
>> Thanks for confirming it is intentional and changing it would break existing userspace.
>>
>> And FWIW even in Windows there are more than 4 situational values used like we have in Linux today.
>>
>> As the status quo is there I personally feel that we should do the exact same for other implementation of energy_performance_preference.
> 
> I still don't think this implementation is nice, for the following reasons:
> 
> 1. Users may write raw value but read string. It's odd.
> 
> 2. Sometimes a raw value is read and sometimes a character string is read.
> The userspace tool needs to adapt this.
> 
> 3. Reading and writing EPP strings is not really general in driver. It is
> more reasonable to use the userspace tool to implement it.
> 
> In order not to break existing userspace, I'll rename the file to
> 'energy_performance_preference_int' or 'energy_performance_preference_val'
> in cppc_cpufreq and only support reading and writing raw value. As for
> accepting string arguments, it's not necessary for cppc_cpufreq for now.
> It's easy to add this feature but hard to remove, so I'll leave it to the
> future if it is really needed.
> 
> As for amd-pstate and intel_pstate, you can decide how
> energy_performance_preference should evolve. But I strongly recommend
> splitting it.
> 
> Regards,
> 
> Lifeng

I agree that not being able to write-read-confirm a numeric value that
happens to match one of the strings is... ugly. I have seen cases of
userspace fighting with firmware for control of the EPP, and detecting
that's happening is difficult if there are *other* reasons you might not
get back what you just wrote.

However, the desktop userspace pretty much only uses the strings anyway,
and they serve to translate arbitrary non-linear hardware-specific
scales into something userspace can build policy on. They are somewhat
less magic than the raw values, although still, IMO, pretty magic.

The raw values don't have consistent interpretation other than that
higher numbers give monotonically increasing efficiency for that
specific core, and I use that wording particularly. Lower numbers may
not increase performance because of long-term power/thermal limits, and
on asymmetric-CPU machines, the same number may not mean the same thing
for different cores in the same CPU package.

Leaving it up to userspace means either you need machine-model-specific
golden images, manually tuned by a skilled administrator, or CPU model
checks and an out-of-tree hardware database that somehow everyone
collaborates on. That database would likely miss a lot of things that
aren't popular X86 CPUs less than 5 years old.

Thanks,

Russell
>>
> 


