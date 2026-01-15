Return-Path: <linux-acpi+bounces-20381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB97D24813
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F33C3012764
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1125397AAA;
	Thu, 15 Jan 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sWEDDI3o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A636D507;
	Thu, 15 Jan 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480369; cv=none; b=TwDBoMIkg/PPjo5UPZ2sZlYkxI9D5mEY7ulhy6XJmHYv+uMotelXYK3rnN70Fo4EODiPm8T9HBlFps+ALQDSYGOkMgRlM0+z5j3F5jCccpgmDvZtzeO5m1AfztL0bgrhGRyo3m5QbdTBFqjkBwKXw8fk+IXjLeLWzYZagciKWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480369; c=relaxed/simple;
	bh=qM3ack70Dp4/06hOyaIehHJ+0/Zax0TbmaCqfMwt6oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YCwXgHyU3OEvxa/wkUYQS9OV7xqWXwuZyWdBcbPaxE4eMt2dfjjZYgU1GHBE0Mq7AEWt4xSZJNFrlFIVYa81nhtCeimAMmSue8qTD2nYrJdClveC+Z+PazJnVLAKEtyao8KTL8zGVFhSjY5UYnzXXS9u0exUNxs59gEcrZoJPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sWEDDI3o; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ODPddeF010lfuUEUkRqhVe8w5VlmaVFHJmKvQxtERpA=;
	b=sWEDDI3okoWq4IynNrjDPJVVw/BrNyVxPNePW6AsTlEaQVRY7052BBsV89prrjI5k/m0bV38t
	8yTRZWr6YX3TFV5BzE14JqVrgAA1GbJyPqT0Q1s79f0jV974tUSJYHSISwDHxnOlq/Uw3Ae2wBj
	mYhB0UDTZp3av1PwjJGZVA0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dsMjN25pXzcb45;
	Thu, 15 Jan 2026 20:28:56 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id DD30940538;
	Thu, 15 Jan 2026 20:32:42 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 20:32:41 +0800
Message-ID: <27750fe9-8b0e-4687-bc5f-21e4ec38bf66@huawei.com>
Date: Thu, 15 Jan 2026 20:32:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<ray.huang@amd.com>, <corbet@lwn.net>, <robert.moore@intel.com>,
	<lenb@kernel.org>, <acpica-devel@lists.linux.dev>,
	<mario.limonciello@amd.com>, <rdunlap@infradead.org>,
	<linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<zhanjie9@hisilicon.com>, <ionela.voinescu@arm.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <nhartman@nvidia.com>,
	<bbasu@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
 <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
 <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Hello Pierre,

On 2026/1/12 19:44, Pierre Gondois wrote:
> Hello Sumit,
> 
> On 1/9/26 15:37, Sumit Gupta wrote:
>>
>> On 08/01/26 22:16, Pierre Gondois wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello Sumit, Lifeng,
>>>
>>> On 12/23/25 13:13, Sumit Gupta wrote:
>>>> When autonomous selection (auto_sel) is enabled, the hardware controls
>>>> performance within min_perf/max_perf register bounds making the
>>>> scaling_min/max_freq effectively read-only.
>>>
>>> If auto_sel is set, the governor associated to the policy will have no
>>> actual control.
>>>
>>> E.g.:
>>> If the schedutil governor is used, attempts to set the
>>> frequency based on CPU utilization will be periodically
>>> sent, but they will have no effect.
>>>
>>> The same thing will happen for the ondemand, performance,
>>> powersave, userspace, etc. governors. They can only work if
>>> frequency requests are taken into account.
>>>
>>> ------------
>>>
>>> This looks like the intel_pstate governor handling where it is possible
>>> not to have .target() or .target_index() callback and the hardware is in
>>> charge (IIUC).
>>> For this case, only 2 governor seem available: performance and powersave.
>>>

As you mentioned in [2], 'it still makes sense to have cpufreq requesting a
certain performance level even though autonomous selection is enabled'. So I
think it's OK to have a governor when auto_selection is enabled.

[2] https://lore.kernel.org/all/9f46991d-98c3-41f5-8133-6612b397e33a@arm.com/

>>
> Thanks for pointing me to the first version, I forgot how your
> first implementation was.
> 
> 
>> In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
>> target*() hooks, using setpolicy() instead (similar to AMD pstate).
>> However, this approach doesn't allow per-CPU control: if we boot with the
>> EPP driver, we can't dynamically disable auto_sel for individual CPUs and
>> return to OS governor control (no target hook available). AMD and Intel
>> pstate drivers seem to set HW autonomous mode for all CPUs globally,
>> not per-CPU. So, changed it in v2.
>> [1] https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/
>>
> Ok right.
> This is something I don't really understand in the current intel/amd cpufreq
> drivers. FWIU:
> - the cpufreq drivers abstractions allow to access different hardware
> - the governor abstraction allows to switch between different algorithms
> to select the 'correct' frequency.
> 
> So IMO switching to autonomous selection should be done by switching
> to another governor and the 'auto_sel' file should not be accessible to users.
> 
> ------------
> 
> Being able to enable/disable the autonomous selection on a per-policy
> base seems a valid use-case. It also seems to fit the per-policy governor
> capabilities.

I'm OK with adding an auto-selection governor. It's better to keep this
governor only in cppc_cpufreq for now I think.

> However toggling the auto_sel on different CPUs inside the same policy
> seems inappropriate (this is is not what is done in  this patchset IIUC).
> 

I think Sumit means per-policy when he said per-CPU.

> 
>>
>>> ------------
>>>
>>> In our case, I think it is desired to unload the scaling governor
>>> currently in
>>> use if auto_sel is selected. Letting the rest of the system think it has
>>> control
>>> over the freq. selection seems incorrect.
>>> I am not sure what to replace it with:
>>> -
>>> There are no specific performance/powersave modes for CPPC.
>>> There is a range of values between 0-255
>>> -
>>> A firmware auto-selection governor could be created just for this case.
>>> Being able to switch between OS-driven and firmware driven freq. selection
>>> is not specific to CPPC (for the future).
>>> However I am not really able to say the implications of doing that.
>>>
>>> ------------
>>>
>>> I think it would be better to split your patchset in 2:
>>> 1. adding APIs for the CPPC spec.
>>> 2. using the APIs, especially for auto_sel
>>>
>>> 1. is likely to be straightforward as the APIs will still be used
>>> by the driver at some point.
>>> 2. is likely to bring more discussion.
>>>
>>
>> We discussed adding a hw_auto_sel governor as a second step, though the
>> approach may need refinement during implementation.
> 
> I didn't find in the thread adding a new governor was discussed in the
> threads, in case you have a direct link.
> 
>>
>> Deferred it (to second step) because adding a new governor requires
>> broader discussion.
>>
>> This issue already exists in current code - store_auto_select() enables
>> auto_sel without any governor awareness. These patches improve the
>> situation by:
>> - Updating scaling_min/max_freq when toggling auto_sel mode
>> - Syncing policy limits with actual HW min/max_perf bounds
>> - Making scaling_min/max_freq read-only in auto_sel mode
>>
>> Would it be acceptable to merge this as a first step, with the governor
>> handling as a follow-up?
>> If not and you prefer splitting, which grouping works better:
>>   A) Patches 1-8 then 9-11.
>>   B) "ACPI: CPPC *" patches then "cpufreq: CPPC *" patches.
>>
> If it's possible I would like to understand what the end result should
> look like. If ultimately enabling auto_sel implies switching governor
> I understand, but I didn't find the thread that discussed about that
> unfortunately.
> 
> 
>>
>>>
>>>> Enforce this by setting policy limits to min/max_perf bounds in
>>>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
>>>> to change performance limits in autonomous mode.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index b1f570d6de34..b3da263c18b0 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>>
>>>>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>>>   {
>>>> -     cpufreq_verify_within_cpu_limits(policy);
>>>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>>>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>>>> +     struct cpufreq_policy *cpu_policy;
>>>> +     struct cppc_cpudata *cpu_data;
>>>> +     struct cppc_perf_caps *caps;
>>>> +
>>>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
>>>> +     if (!cpu_policy)
>>>> +             return -ENODEV;
>>>> +
>>>> +     cpu_data = cpu_policy->driver_data;
>>>> +     caps = &cpu_data->perf_caps;
>>>> +
>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>>> +             u32 min_perf, max_perf;
>>>> +
>>>> +             /*
>>>> +              * Set policy limits to HW min/max_perf bounds. In autonomous
>>>> +              * mode, scaling_min/max_freq is effectively read-only.
>>>> +              */
>>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>>>> +                        caps->lowest_nonlinear_perf;
>>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
>>>> +
>>>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>>>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>>>
>>> policy->min/max values are overwritten, but the governor which is
>>> supposed to use them to select the most fitting frequency will be
>>> ignored by the firmware I think.
>>>
>>
>> Yes.
>>
>>>> +     } else {
>>>> +             cpufreq_verify_within_limits(policy, min_freq, max_freq);
>>>> +     }
>>>> +
>>>> +     cpufreq_cpu_put(cpu_policy);
>>>>       return 0;
>>>>   }
>>>>
> 


