Return-Path: <linux-acpi+bounces-12590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C66A77CEF
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EF1167516
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833AA204696;
	Tue,  1 Apr 2025 13:56:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331624501A;
	Tue,  1 Apr 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515779; cv=none; b=tJmXkMORLr5qi1gTLrBoWVJPyNM8wUQPmrph4siLX2il8uib3VdN+yxvBfwsqqZ9PhE4mTa8RK1+UMZ1Y87AADsRbyGOyND5/fr4V2rHYVAOQJB1KanwC7deQ26YdwsTHNNb4vOlgzF9vSD+jNtjC8kMmOuYAtWKyCclMIvRtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515779; c=relaxed/simple;
	bh=tjpdGmk7PsTYQICyO1o16SjzRJ5VUSgEoghI+wvraLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f0i6/jTyIrGrTtxy/UnO87pYFmNG0dnULD17L4mbGRfihBuhXtNualvIzvDeZ3Q2Ts3FczrNb2YP1w0x5+e3sufFRNEGxsboMtiLXId+ZPVxu6Ibk9nJE9ucY/spBfRTqx/MxQWe7NwTiC/rfbScV727SeC0rRbpALYCUDA5SjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZRqHp4HlwztRR6;
	Tue,  1 Apr 2025 21:54:46 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E1C7C180116;
	Tue,  1 Apr 2025 21:56:11 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Apr
 2025 21:56:11 +0800
Message-ID: <4a87269d-542e-4d4d-9c46-780f9eb55193@huawei.com>
Date: Tue, 1 Apr 2025 21:56:10 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <corbet@lwn.net>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sashal@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<bbasu@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
 <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
 <73fbf483-7afa-4cd2-84d1-6ace36549c53@huawei.com>
 <f0f1b31b-a0fc-4d21-8b79-c896833dae35@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <f0f1b31b-a0fc-4d21-8b79-c896833dae35@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Sorry for the delay.

On 2025/3/14 20:48, Sumit Gupta wrote:
> 
> 
>>>>
>>>> There seems to be some quite fundamental disagreement on how this
>>>> should be done, so I'm afraid I cannot do much about it ATM.
>>>>
>>>> Please agree on a common approach and come back to me when you are ready.
>>>>
>>>> Sending two concurrent patchsets under confusingly similar names again
>>>> and again isn't particularly helpful.
>>>>
>>>> Thanks!
>>>
>>> Hi Rafael,
>>>
>>> Thank you for looking into this.
>>>
>>> Hi Lifeng,
>>>
>>> As per the discussion, we can make the driver future extensible and
>>> also can optimize the register read/write access.
>>>
>>> I gave some thought and below is my proposal.
>>>
>>> 1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
>>>     to read/write a cpc register.
>>>
>>> 2) Pick my patches in [2]:
>>>     - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
>>>                  Also, update existing API's to read/write regs in batch.
>>>     - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
>>>       all CPU's in Auto mode and set registers with right values.
>>>       They can be updated after boot from sysfs to change hints to HW.
>>>       I can use the optimized API's from [1] where required in [2].
>>>
>>> Let me know if you are okay with this proposal.
>>> I can also send an updated patch series with all the patches combined?
>>>
>>> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>> [2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
>>>
>>> Regards,
>>> Sumit Gupta
>>>
>>
>> Hi Sumit,
>>
>> Over the past few days, I've been thinking about your proposal and
>> scenario.
>>
>> I think we both agree that PATCH 1-7 in [1] doesn't conflicts with [2], so
>> the rest of the discussion focuses on the differences between [2] and the
>> PATCH 8 in [1].
>>
>> We both tried to support autonomous selection mode in cppc_cpufreq but on
>> different ways. I think the differences between these two approaches can be
>> summarized into three questions:
>>
>> 1. Which sysfs files to expose? I think this is not a problem, we can keep
>> all of them.
>>
>> 2. Where to expose these sysfs files? I understand your willing to keep all
>> cpc registers together under acpi_cppc sysfs. But in my opinion, it is more
>> suitable to expose them under cppc_cpufreq_attr, for these reasons:
>>
>>    1) It may probably introduce concurrency and data consistency issues, as
>> I mentioned before.
>>
> 
> As explained in previous reply, this will be solved with the ifdef
> check to enable the attributes for only those CPUFREQ drivers which want
> to use the generic nodes.
>  e.g: '#ifdef CONFIG_ACPI_CPPC_CPUFREQ' for 'cppc_cpufreq'.
>            
> These CPC register read/write sysfs nodes are generic as per the ACPI
> specification and without any vendor specific logic.
> So, adding them in the lib file 'cppc_acpi.c'(CONFIG_ACPI_CPPC_LIB) will
> avoid code duplication if a different or new ACPI based CPUFREQ driver
> also wants to use them just by adding their macro check. Such ifdef check is also used in other places for attributes creation like below.
> So, don't look like a problem.
>  $ grep -A4 "acpi_cpufreq_attr\[" drivers/cpufreq/acpi-cpufreq.c
>  static struct freq_attr *acpi_cpufreq_attr[] = {
>     &freqdomain_cpus,
>  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>     &cpb,
>  #endif

So in the future, we will see:

static struct attribute *cppc_attrs[] = {
	...
#ifdef CONFIG_XXX
	&xxx.attr,
	&xxx.attr,
#endif
#ifdef CONFIG_XXX
	&xxx.attr,
#endif
#ifdef CONFIG_XXX
	&xxx.attr,
	...
};

I think you are making things more complicated.

> 
>>    2) The store functions call cpufreq_cpu_get() to get policy and update
>> the driver_data which is a cppc_cpudata. Only the driver_data in
>> cppc_cpufreq's policy is a cppc_cpudata! These operations are inappropriate
>> in cppc_acpi. This file currently provides interfaces for cpufreq drivers
>> to use. Reverse calls might mess up call relationships, break code
>> structures, and cause problems that are hard to pinpoint the root cause!
>>
> 
> If we don't want to update the cpufreq policy from 'cppc_acpi.c' and only update it from within the cpufreq,    then this could be one valid
> point to not add the write syfs nodes in 'cppc_acpi.c' lib file.
> 
> @Rafael, @Viresh : Do you have any comments on this?

I think updating cpufreq policy from 'cppc_acpi.c' should be forbidden.

> 
>>    3) Difficult to extend. Different cpufreq drivers may have different
>> processing logic when reading from and writing to these CPC registers.
>> Limiting all sysfs here makes it difficult for each cpufreq driver to
>> extend. I think this is why there are only read-only interfaces under
>> cppc_attrs before.
>>
> 
> We are updating the CPC registers as per the generic ACPI specification.
> So, any ACPI based CPUFREQ driver can use these generic nodes to
> read/write reg's until they have a vendor specific requirement or
> implementation.
> As explained above, If someone wants to update in different way and use
> their own CPUFREQ driver then these generic attributes won't be created
> due to the CPUFREQ driver macro check.
> I think AMD and Intel are doing more than just reading/updating the registers. That's why they needed their driver specific implementations.
> 
>> Adding a 'ifdef' is not a good way to solve these problems. Defining this
>> config does not necessarily mean that the cpufreq driver is cppc_cpufreq.
>>
> 
> It means that only.
>  ./drivers/cpufreq/Makefile:obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o

Compile this file does not mean that the cpufreq driver is cppc_cpufreq.
Driver registration may fail, and the actually loaded driver may be
another. It'll be dangerous to expose these sysfs files for users to update
registers' value in this case.

> 
>> 3. Is it necessary to add a new driver instance? [1] exposed the sysfs
>> files to support users dynamically change the auto selection mode of each
>> policy. Each policy can be operated seperately. It seems to me that if you
>> want to boot all CPUs in auto mode, it should be sufficient to set all
>> relevant registers to the correct values at boot time. I can't see why the
>> new instance is necessary unless you explain it further. Could you explain
>> more about why you add a new instance starting from answer these questions:
>>
>> For a specific CPU, what is the difference between using the two instances
>> when auto_sel is 1? And what is the difference when auto_sel is 0?
>>
> 
> Explained this in previous reply. Let me elaborate more.
> 
> For hundred's of CPU's, we don't need to explicitly set multiple sysfs
> after boot to enable and configure Auto mode with right params. That's why an easy option is to pass boot argument or module param for enabling
> and configuration.
> A separate instance 'cppc_cpufreq_epp' of the 'cppc_cpufreq' driver is
> added because policy min/max need to be updated to the min/max_perf
> and not nominal/lowest nonlinear perf which is done by the default
> init hook. Min_perf value can be lower than lowest nonlinear perf and Max_perf can be higher than nominal perf.
> If some CPU is booted with epp instance and later the auto mode is disabled or min/max_perf is changed from sysfs then also the policy
> min/max need to be updated accordingly.
> 
> Another is that in Autonomous mode the freq selection and setting is
> done by HW. So, cpufreq_driver->target() hook is not needed.
> These are few reasons which I am aware of as of now.
> I think in future there can be more. Having a separate instance
> reflecting a HW based Autonomous frequency selection will make it easy
> for any future changes.

So CPUs will act totally differently under these two instance. But what if
I want part of the CPUs in HW mode and others in SW mode? Should I boot on
HW mode and set some policies' auto_set to false or the other way? It seems
like the effects of theses two approaches are completely different. In my
opinion, this new instance is more like a completely different driver than
cppc_cpufreq.

> 
>> If it turns out that the new instance is necessary, I think we can reach a
>> common approach by adding this new cpufreq driver instance and place the
>> attributes in 'cppc_cpufreq_epp_attr', like amd-pstate did.
>>
>> What do you think?
> 
> I initially thought about this but there was a problem.
> What if we boot with non-epp instance which doesn't have these attributes and later want to enable Auto mode for few CPU's from sysfs.

That's the problem. CPUs can be set to Auto mode with or without this new
instance. So what's the point of it?

> 
> 
> Best Regards,
> Sumit Gupta


