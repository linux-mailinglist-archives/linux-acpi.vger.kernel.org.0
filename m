Return-Path: <linux-acpi+bounces-11487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A7A45BA2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D153A82E8
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FF226D0E;
	Wed, 26 Feb 2025 10:22:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594421324D;
	Wed, 26 Feb 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565371; cv=none; b=juv3i0kk8vfZWStJ6oWTP0hdiDMvOKWlXyX2qP84Eb+ozIQfvldv70KA7A70QlHk6W85Vns8nQ2VULtm5ipm+EKw4ViYx7tbssElIjFiMC7WHnwAhrj3soL54S7C2GM+/8zi1b728rJrM6WceZK3tOWAR0FaXQKgjhR5D0Nf3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565371; c=relaxed/simple;
	bh=S8bkmRF4hFy5oAR0L+B0tr5ao+COGAqRwbPx36g9o2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i/NhwyofFfeXYb1UjheaNcrhNvkja+LD08+KftXskFSLL1cql9ajO4+ENAzQFTtXGatidacmg3tu9c0JObfBY9HzzbW0/yLkOrP4ZNCg/Z08W5fdJTIXJpLMNGrW0sO0ElXGNS14+vxjpxLSBbLMARx1dsNCL0MW/gWNFKe+Dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z2r6B18P3z2CpfZ;
	Wed, 26 Feb 2025 18:18:42 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D33A4140109;
	Wed, 26 Feb 2025 18:22:45 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Feb
 2025 18:22:45 +0800
Message-ID: <73fbf483-7afa-4cd2-84d1-6ace36549c53@huawei.com>
Date: Wed, 26 Feb 2025 18:22:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<sashal@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
 <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/2/21 21:14, Sumit Gupta wrote:
> 
> 
> On 19/02/25 00:53, Rafael J. Wysocki wrote:
>>
>> There seems to be some quite fundamental disagreement on how this
>> should be done, so I'm afraid I cannot do much about it ATM.
>>
>> Please agree on a common approach and come back to me when you are ready.
>>
>> Sending two concurrent patchsets under confusingly similar names again
>> and again isn't particularly helpful.
>>
>> Thanks!
> 
> Hi Rafael,
> 
> Thank you for looking into this.
> 
> Hi Lifeng,
> 
> As per the discussion, we can make the driver future extensible and
> also can optimize the register read/write access.
> 
> I gave some thought and below is my proposal.
> 
> 1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
>    to read/write a cpc register.
> 
> 2) Pick my patches in [2]:
>    - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
>                 Also, update existing API's to read/write regs in batch.
>    - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
>      all CPU's in Auto mode and set registers with right values.
>      They can be updated after boot from sysfs to change hints to HW.
>      I can use the optimized API's from [1] where required in [2].
> 
> Let me know if you are okay with this proposal.
> I can also send an updated patch series with all the patches combined?
> 
> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> [2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
> 
> Regards,
> Sumit Gupta
> 

Hi Sumit,

Over the past few days, I've been thinking about your proposal and
scenario.

I think we both agree that PATCH 1-7 in [1] doesn't conflicts with [2], so
the rest of the discussion focuses on the differences between [2] and the
PATCH 8 in [1].

We both tried to support autonomous selection mode in cppc_cpufreq but on
different ways. I think the differences between these two approaches can be
summarized into three questions:

1. Which sysfs files to expose? I think this is not a problem, we can keep
all of them.

2. Where to expose these sysfs files? I understand your willing to keep all
cpc registers together under acpi_cppc sysfs. But in my opinion, it is more
suitable to expose them under cppc_cpufreq_attr, for these reasons:

  1) It may probably introduce concurrency and data consistency issues, as 
I mentioned before.

  2) The store functions call cpufreq_cpu_get() to get policy and update
the driver_data which is a cppc_cpudata. Only the driver_data in 
cppc_cpufreq's policy is a cppc_cpudata! These operations are inappropriate
in cppc_acpi. This file currently provides interfaces for cpufreq drivers
to use. Reverse calls might mess up call relationships, break code
structures, and cause problems that are hard to pinpoint the root cause!

  3) Difficult to extend. Different cpufreq drivers may have different
processing logic when reading from and writing to these CPC registers.
Limiting all sysfs here makes it difficult for each cpufreq driver to
extend. I think this is why there are only read-only interfaces under
cppc_attrs before.

Adding a 'ifdef' is not a good way to solve these problems. Defining this
config does not necessarily mean that the cpufreq driver is cppc_cpufreq.

3. Is it necessary to add a new driver instance? [1] exposed the sysfs
files to support users dynamically change the auto selection mode of each
policy. Each policy can be operated seperately. It seems to me that if you
want to boot all CPUs in auto mode, it should be sufficient to set all
relevant registers to the correct values at boot time. I can't see why the
new instance is necessary unless you explain it further. Could you explain
more about why you add a new instance starting from answer these questions:

For a specific CPU, what is the difference between using the two instances
when auto_sel is 1? And what is the difference when auto_sel is 0?

If it turns out that the new instance is necessary, I think we can reach a
common approach by adding this new cpufreq driver instance and place the
attributes in 'cppc_cpufreq_epp_attr', like amd-pstate did.

What do you think?

Regards,
Lifeng

