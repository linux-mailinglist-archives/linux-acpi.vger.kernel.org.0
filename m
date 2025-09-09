Return-Path: <linux-acpi+bounces-16546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6FB50396
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC34E3227
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F336207F;
	Tue,  9 Sep 2025 16:57:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0EA371EA6;
	Tue,  9 Sep 2025 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437055; cv=none; b=XLMVw+1XmXkOvS58lzCr+jxsXDJeb7BDt5PwljHVuM7lqMHIQylrG/zCz66OjKPwwm9HDAgzJ00VnwebFVcOJawFkhUJZT3fW1xAdQkYV0hiqqHAnR3AS+fEGb2ANSV/FsBfAbqnxZr5DABwiw/9fKKVNDlkdTqR9EX/IvlJ0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437055; c=relaxed/simple;
	bh=ln9VFRt7yyw3cu3AlJWX2zgOXdCM8GySL4/KhrfAA9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocE4LURd0rDKTumWMFNa1z8bhsPut5Q1wPR1htWJsk+pi5OfKMWwxhZYc8OUAVja0qkh2hJZj0aAglRHVcvSV/ugWjdYaG9YiZLLsL35rqqEEAxyiKzy5mshcyIwsZsHpwB3GKMO0Ye/DnyRxv5Mn8zluVqFOD3U9dzfhYP+wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1201815A1;
	Tue,  9 Sep 2025 09:57:25 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF853F694;
	Tue,  9 Sep 2025 09:57:27 -0700 (PDT)
Message-ID: <c4e6aff7-913f-41d4-b578-88e5d008ca9a@arm.com>
Date: Tue, 9 Sep 2025 17:57:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-17-james.morse@arm.com>
 <4c8da7b3-6235-4d0a-aeb1-81c8bdfd051a@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <4c8da7b3-6235-4d0a-aeb1-81c8bdfd051a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 28/08/2025 18:07, Fenghua Yu wrote:
> On 8/22/25 08:29, James Morse wrote:
>> The MSC MON_SEL register needs to be accessed from hardirq context by the
>> PMU drivers, making an irqsave spinlock the obvious lock to protect these
>> registers. On systems with SCMI mailboxes it must be able to sleep, meaning
>> a mutex must be used.
>>
>> Clearly these two can't exist at the same time.
>>
>> Add helpers for the MON_SEL locking. The outer lock must be taken in a
>> pre-emptible context before the inner lock can be taken. On systems with
>> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
>> will fail to be 'taken' if the caller is unable to sleep. This will allow
>> the PMU driver to fail without having to check the interface type of
>> each MSC.


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index a623f405ddd8..c6f087f9fa7d 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -68,10 +68,19 @@ struct mpam_msc {
>>         /*
>>        * mon_sel_lock protects access to the MSC hardware registers that are
>> -     * affeted by MPAMCFG_MON_SEL.
>> +     * affected by MPAMCFG_MON_SEL, and the mbwu_state.
>> +     * Both the 'inner' and 'outer' must be taken.
>> +     * For real MMIO MSC, the outer lock is unnecessary - but keeps the
>> +     * code common with:
>> +     * Firmware backed MSC need to sleep when accessing the MSC, which
>> +     * means some code-paths will always fail. For these MSC the outer
>> +     * lock is providing the protection, and the inner lock fails to
>> +     * be taken if the task is unable to sleep.
>> +     *
>>        * If needed, take msc->probe_lock first.
>>        */
>>       struct mutex        outer_mon_sel_lock;
>> +    bool            outer_lock_held;

> Is it better to define outer_lock_held at atomic_t?

Writes a protected by the outer lock, its just something to generate a warning for debug.
I can make it a READ_ONCE() if you're worried about torn values in the failure case.
(as its just for debug, I'm not worried about false-negatives)


>>       raw_spinlock_t        inner_mon_sel_lock;
>>       unsigned long        inner_mon_sel_flags;
>>   @@ -81,6 +90,52 @@ struct mpam_msc {
>>       struct mpam_garbage    garbage;
>>   };
>>   +static inline bool __must_check mpam_mon_sel_inner_lock(struct mpam_msc *msc)
>> +{
>> +    /*
>> +     * The outer lock may be taken by a CPU that then issues an IPI to run
>> +     * a helper that takes the inner lock. lockdep can't help us here.
>> +     */
>> +    WARN_ON_ONCE(!msc->outer_lock_held);
> 
> At this point, msc->outer_lock_held might not be true yet due to no memory barrier on it
> on this CPU.

The IPI machinery has this covered:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-gic.c#n838


> If it's atomic_t and it's set as true on another CPU by smp_store_release(),
> it's guaranteed to be visible as true on this CPU. Without atomic setting, we may see a
> false warning here and cause debug difficult.


Thanks,

James

