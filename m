Return-Path: <linux-acpi+bounces-17509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D47BB4CAA
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2B7323B34
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF9274B26;
	Thu,  2 Oct 2025 18:02:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67698272E72;
	Thu,  2 Oct 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428165; cv=none; b=IvRz6SRlp7Ifgmsfy3KUzk/cI+Xh65lRKiANh3f/AbO9rkFr4YbBIfqTtgasjZhMibQ0sglTt8ydpS+r1vM2edOSYrKuBqj0apaxj7OJTC97iK/1kQZRv2ldOgvbIbTdeNmKqBXgBoPHS4Vaksq1nAlpDqwu3mS5YBlp0hRFLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428165; c=relaxed/simple;
	bh=2XMk+weJGMycjD144IE/HRpb9mVgXqLy9DWcBEUr8hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpMLIEyKR7hYyaxZruCTmDJzaooxsD9LRtUJtZg928Z/n2+OXBvaHES7MYhAhz5GLnPEAun+DaN0qW5K/9Dltlwe2+xXkvN2eW6Zg3FphiYGP4S1klnaYiEnnAt5Z2XKBfQ+0venvIO81CRBn7N1zuRSgMtGhHMVGzi2Gxu9Z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F8601FCD;
	Thu,  2 Oct 2025 11:02:34 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7B0C3F66E;
	Thu,  2 Oct 2025 11:02:37 -0700 (PDT)
Message-ID: <c94e9d28-c678-4397-aad4-b17ee6ba179c@arm.com>
Date: Thu, 2 Oct 2025 19:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/29] arm_mpam: Extend reset logic to allow devices to
 be reset any time
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-18-james.morse@arm.com>
 <1249c061-dde7-4966-9c8c-2fa958fad37b@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <1249c061-dde7-4966-9c8c-2fa958fad37b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 25/09/2025 08:16, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> cpuhp callbacks aren't the only time the MSC configuration may need to
>> be reset. Resctrl has an API call to reset a class.
>> If an MPAM error interrupt arrives it indicates the driver has
>> misprogrammed an MSC. The safest thing to do is reset all the MSCs
>> and disable MPAM.
>>
>> Add a helper to reset RIS via their class. Call this from mpam_disable(),
>> which can be scheduled from the error interrupt handler.


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index e7faf453b5d7..a9d3c4b09976 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>>   @@ -1340,8 +1338,56 @@ static void mpam_enable_once(void)
>>              mpam_partid_max + 1, mpam_pmg_max + 1);
>>   }
>>   +static void mpam_reset_component_locked(struct mpam_component *comp)
>> +{
>> +    struct mpam_msc *msc;
>> +    struct mpam_vmsc *vmsc;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    lockdep_assert_cpus_held();
>> +
>> +    guard(srcu)(&mpam_srcu);
>> +   
> 
> Nested locks on mpam_srcu in this call chain:
> 
> mpam_disable() -> mpam_reset_class() -> mpam_reset_class_locked() -> mpam_component_locked()

These are allowed to nest like this.


> There are redundant locks on mpam_srcu in mpam_disabled(), mpam_reset_class_locked(), and
> mpam_reset_component_locked().
> 
> It's better to guard mpam_srcu only in the top function mpam_disable() for simpler logic
> and lower overhead.

These things don't block, so there no real overhead. Shuffling them around to avoid the
harmless nesting would likely complicate the flow, not simplify it.

In the reset case you point at here, the resctrl code would need to take the srcu lock
before calling it - which is exposing the innards of what that function does.



>> list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
>> +                 srcu_read_lock_held(&mpam_srcu)) {
>> +        msc = vmsc->msc;
>> +
>> +        list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
>> +                     srcu_read_lock_held(&mpam_srcu)) {
>> +            if (!ris->in_reset_state)
>> +                mpam_touch_msc(msc, mpam_reset_ris, ris);
>> +            ris->in_reset_state = true;
>> +        }
>> +    }
>> +}


>> +/*
>> + * Called in response to an error IRQ.
>> + * All of MPAMs errors indicate a software bug, restore any modified
>> + * controls to their reset values.
>> + */
>>   void mpam_disable(struct work_struct *ignored)
>>   {
>> +    int idx;
>> +    struct mpam_class *class;
>>       struct mpam_msc *msc, *tmp;
>>         mutex_lock(&mpam_cpuhp_state_lock);
>> @@ -1351,6 +1397,12 @@ void mpam_disable(struct work_struct *ignored)
>>       }
>>       mutex_unlock(&mpam_cpuhp_state_lock);
>>   +    idx = srcu_read_lock(&mpam_srcu);

> It's better to change to guard(srcu)(&mpam_srcu);

For this one - absolutely not.
The guard() thing allows the toolchain to decide when to drop the lock. Further down in
this same function is an attempt to free the memory that got deferred. Guess what happens
if you call synchronize_srcu() while still in an srcu read side section....


>> +    list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>> +                 srcu_read_lock_held(&mpam_srcu))
>> +        mpam_reset_class(class);
>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +
>>       mutex_lock(&mpam_list_lock);
>>       list_for_each_entry_safe(msc, tmp, &mpam_all_msc, all_msc_list)
>>           mpam_msc_destroy(msc);


Thanks,

James

