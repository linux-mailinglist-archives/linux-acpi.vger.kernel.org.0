Return-Path: <linux-acpi+bounces-10758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7009A16594
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 04:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206CC1884F46
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FD527450;
	Mon, 20 Jan 2025 03:15:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014AB641;
	Mon, 20 Jan 2025 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342935; cv=none; b=BuycJ713hb2aNKTFoyUIYyqjR1MN+qej20fNBnMClmR0nURUjn0ErNx/8pWa7NqMxSmTgJcFxwpK3i+xuppr9Jn4+U6PkMECnaf48W2m/oLRaceYNyzonXanEsy1izMlvEjk0w2sYyhgRhgm/jfhZD7V7rbe/gbjmvy3mS/0a34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342935; c=relaxed/simple;
	bh=qwUUNjDHTBEo9eddLfnKwuShyPehHmQwFQV5Bk1cI68=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qL1GHO1Wd7SbvMUAqN1fCF+v2IgnB2/DoZufCDfq3yQH40rPJO3UdPAqgSEH33CObV1/wx40/A5BNobpVi48FleqAvAdP0f+OAd2WenzbKx0HWiaBdyAz4Of0Kq1CQkNTMrmEtRAqc1EoYsVtWBPum+BzLSB80fMUxAMnY4bwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YbwRj0C71z1JHg5;
	Mon, 20 Jan 2025 11:14:25 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E918B1A0188;
	Mon, 20 Jan 2025 11:15:22 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Jan
 2025 11:15:21 +0800
Message-ID: <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
Date: Mon, 20 Jan 2025 11:15:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Mario Limonciello <mario.limonciello@amd.com>, Russell Haley
	<yumpusamongus@gmail.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/17 22:30, Mario Limonciello wrote:

> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>> On 2025/1/16 19:39, Russell Haley wrote:
>>
>>> Hello,
>>>
>>> I noticed something here just as a user casually browsing the mailing list.
>>>
>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>> driver.
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>>>>   2 files changed, 163 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU frequency coordination domain
>>>>           This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>>           drivers are in use.
>>>>   
>>>
>>> [...snip...]
>>>
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
>>>
>>> In intel_pstate driver, there is file with near-identical semantics:
>>>
>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>
>>> It also accepts a few string arguments and converts them to integers.
>>>
>>> Perhaps the same name should be used, and the semantics made exactly
>>> identical, and then it could be documented as present for either
>>> cppc_cpufreq OR intel_pstate?
>>>
>>> I think would be more elegant if userspace tooling could Just Work with
>>> either driver.
>>>
>>> One might object that the frequency selection behavior that results from
>>> any particular value of the register itself might be different, but they
>>> are *already* different between Intel's P and E-cores in the same CPU
>>> package. (Ugh.)
>>
>> Yes, I should use the same name. Thanks.
>>
>> As for accepting string arguments and converting them to integers, I don't
>> think it is necessary. It'll be a litte confused if someone writes a raw
>> value and reads a string I think. I prefer to let users freely set this
>> value.
>>
>> In addition, there are many differences between the implementations of
>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>> amd-pstate...). It is really difficult to explain all this differences in
>> this document. So I'll leave it to be documented as present for
>> cppc_cpufreq only.
> 
> At least the interface to userspace I think we should do the best we can to be the same between all the drivers if possible.
> 
> For example; I've got a patch that I may bring up in a future kernel cycle that adds raw integer writes to amd-pstates energy_performance_profile to behave the same way intel-pstate does.

I agree that it's better to keep this interface consistent across different
drivers. But in my opinion, the implementation of intel_pstate
energy_performance_preference is not really nice. Someone may write a raw
value but read a string, or read strings for some values and read raw
values for some other values. It is inconsistent. It may be better to use
some other implementation, such as seperating the operations of r/w strings
and raw values into two files.

I think it's better to consult Rafael and Viresh about how this should
evolve.

> 
>>
>>>
>>> -- 
>>> Thanks,
>>> Russell
>>>
>>>
>>>
>>
> 


