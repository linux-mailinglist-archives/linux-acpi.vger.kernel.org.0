Return-Path: <linux-acpi+bounces-17575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B053FBB7D3E
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3453A9923
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040E2D0619;
	Fri,  3 Oct 2025 18:03:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF26381BA;
	Fri,  3 Oct 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514591; cv=none; b=VIUSBzVTAMno97siLA11u3XX6X7OCagoYCX0Rut6RZghUJbJL+YuRz0wZtG6oP/9STph6kOJaCpJwOEfDgbQqM6sXzrFnhVNoPJWlY1xq5iE0Uitp5l82pagvWrpOusvtHU/D7lj9YDcEQb0JsqS4qbEoh1y+Tk85Ep+/dob++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514591; c=relaxed/simple;
	bh=NzOZFoOo39BU5THsII2KcMlEt5dHTMN9MnWqAXsgTwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJE3my0xeLVJWv6pKWrGMxKqLfpVukIR/TY4BLA7eCptP9lu7axpI9p5cv0gfnjLMkF7l0Y3/A35f9gUzksC5iDXzM6EyyBKQInNgvNMf0WbtwckkSVQgF6B9UI1IbE5DiWbLNoLl5H2cTifecsaGZoY17fsgHwbU0pYvV91MhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE671596;
	Fri,  3 Oct 2025 11:02:57 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BAC33F5A1;
	Fri,  3 Oct 2025 11:02:59 -0700 (PDT)
Message-ID: <f7ed02a0-dd52-49af-a1f6-58801dacf4a6@arm.com>
Date: Fri, 3 Oct 2025 19:02:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-19-james.morse@arm.com>
 <aMQ6xODb+QRWdblG@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMQ6xODb+QRWdblG@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 12/09/2025 16:22, Dave Martin wrote:
> On Wed, Sep 10, 2025 at 08:42:58PM +0000, James Morse wrote:
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever
>> signalled, attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
> 
> Nit: MPAMF_ESR?  (Casual readers may confuse it with ESR_ELx.

Sure, fixed.


> Formally, there is no MPAM "ESR" register, though people familiar with
> the spec will of course know what you're referring to.)
> 
>> The work to disable MPAM after an error needs to happen at process
>> context as it takes mutex. It also unregisters the interrupts, meaning
>> it can't be done from the threaded part of a threaded interrupt.
>> Instead, mpam_disable() gets scheduled.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that
>> can access the MSC.
>>
>> Once the IRQ is requested, the mpam_disable() path can be called
>> asynchronously, which will walk structures sized by max_partid. Ensure
>> this size is fixed before the interrupt is requested.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index a9d3c4b09976..e7e4afc1ea95 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -166,6 +169,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>>  	return (idr_high << 32) | idr_low;
>>  }
>>  
>> +static void mpam_msc_zero_esr(struct mpam_msc *msc)

> Nit: Maybe clear_esr?  (The fact that setting the ERRCODE and OVRWR
> fields to zero clears the interrupt and prepares for unambiguous
> reporting of the next error is more of an implementation detail.
> It doesn't matter what the rest of the register is set to.)

If you think that name is clearer - sure,


>> +{
>> +	__mpam_write_reg(msc, MPAMF_ESR, 0);
>> +	if (msc->has_extd_esr)
> 
> This deasserts the interrupt (if level-sensitive) and enables the MSC
> to report further errors.  If we are unlucky and error occurs now,
> won't we splat the newly HW-generated RIS field by:
> 
>> +		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
> 
> ...?  If so, we will diagnose the wrong RIS when we pump the new error
> from MPAMF_ESR.  I think the correct interpretation of the spec may be
> that:
> 
>  a) software should treat fields in MPAMF_ESR[63:32] as vaild only if
>     ERRCODE is nonzero, and
> 
>  b) software should never write to MPAMF_ESR[63:32] while ERRCODE is
>     zero.
> 
> Does this look right?  Should the fields be cleared in the opposite
> order?
> 
> Or alternatively, is it actually necessary to clear MPAMF_ESR[63:32]
> at all?
> 
> (The spec seems a bit vague on what software is supposed to do with
> this register to ensure correctness...)

Yeah - I don't think there was much intention here beyond making the RIS
available for the first error. As none of these errors can really be handled,
I don't think a second error value matters too much.

I've reordered it as you suggest, and added a block comment to explain the
problem:
-----%<-----
	u64 esr_low = __mpam_read_reg(msc, MPAMF_ESR);
	if (!esr_low)
		return;

	/*
	 * Clearing the high/low bits of MPAMF_ESR can not be atomic.
	 * Clear the top half first, so that the pending error bits in the
	 * lower half prevent hardware from updating either half of the
	 * register.
	 */
	if (msc->has_extd_esr)
		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
	__mpam_write_reg(msc, MPAMF_ESR, 0);
-----%<-----

We should probably go bother the architects to find out if we can modify
the high bits like this safely.



>> +}

>> @@ -895,6 +920,13 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>>  	}
>>  }
>>  
>> +static void _enable_percpu_irq(void *_irq)
>> +{
>> +	int *irq = _irq;
>> +
>> +	enable_percpu_irq(*irq, IRQ_TYPE_NONE);

> Can the type vary?  (Maybe this makes no sense on GIC-based systems --
> IRQ_TYPE_NONE (or "0") seems overwhelmingly common.)
> 
> (Just my lack of familiarity takling, here.)

PPI can be edge or level - but the irqchip doesn't need to know at this point, and
specifying NONE tells it to use what it already knows. The irqchip already got told
what firmware table said when the interrupt was registered. I believe the GIC knows
its a PPI from the intid, they live in a magic range.


> [...]
> 
>> +static int __setup_ppi(struct mpam_msc *msc)
>> +{
>> +	int cpu;
>> +	struct device *dev = &msc->pdev->dev;
>> +
>> +	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
>> +	if (!msc->error_dev_id)
>> +		return -ENOMEM;
>> +
>> +	for_each_cpu(cpu, &msc->accessibility) {
>> +		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
>> +
>> +		if (empty) {
>> +			dev_err_once(dev, "MSC shares PPI with %s!\n",
>> +				     dev_name(&empty->pdev->dev));
>> +			return -EBUSY;
>> +		}
>> +		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
>> +	}

> How are PPIs supposed to work?

You take the interrupt on the corresponding CPU, and the irqchip gives you the
corresponding percpu pointer. That is what is being setup here.


> An individual MSC that is affine to multiple CPUs has no way to
> distinguish which CPU an error relates to, and no CPU-specific (or even
> RIS-specific) ESR.

For deeper caches this is certainly a problem. But for things close in to the CPU, they
may well know which CPU this transaction came from. The MSC may even be part of the
CPU.


> So, won't such an interrupt be pointlessly take the interrupt on all
> CPUs, which would all fight over the reported event?

It ought to be only one, but nothing requires this.


> Have you encountered any platforms wired up this way?  The spec
> recommends not to do this, but does not provide any rationale...
> 
> The spec only mentions PPIs in the context of being affine to a single
> CPU (PE).

> It's not clear to me that any other use of PPIs makes
> sense (?)

The PPI problem also exists the other way round. If your MSC is not globally accessible,
you can't wire its interrupts up to an SPI, otherwise linux can route the interrupt to
CPUs that can't access the MSC.

The only tool you have to get out of this is to use a PPI.

This came up multiple times with RAS when the caches signalled errors and it really needed
to go to the local CPUs, not a random CPU in a remote package.

It's my assumption that folk will build platforms the same shape, and reach for PPI again.


> If we really have to cope with this, maybe it would make sense to pick
> a single CPU in the affinity set (though we might have to move it
> around if the unlucky CPU is offlined).

Unfortunately PPI are a totally separate set of wiring with a reserved intid range (or
two!) and their own registers in the GICR. It isn't possible to pretend they're a regular
interrupt taken on a particular CPU.

A choice that can be made here is to assume no-one will ever(?) use these, and drop
support. I don't know of a platform that is using PPI - but I can't say no-one is.


> 
> [...]
> 
>> +static char *mpam_errcode_names[16] = {
>> +	[0] = "No error",
>> +	[1] = "PARTID_SEL_Range",
>> +	[2] = "Req_PARTID_Range",
>> +	[3] = "MSMONCFG_ID_RANGE",
>> +	[4] = "Req_PMG_Range",
>> +	[5] = "Monitor_Range",
>> +	[6] = "intPARTID_Range",
>> +	[7] = "Unexpected_INTERNAL",
>> +	[8] = "Undefined_RIS_PART_SEL",
>> +	[9] = "RIS_No_Control",
>> +	[10] = "Undefined_RIS_MON_SEL",
>> +	[11] = "RIS_No_Monitor",
>> +	[12 ... 15] = "Reserved"
>> +};
>> +
>> +static int mpam_enable_msc_ecr(void *_msc)
>> +{
>> +	struct mpam_msc *msc = _msc;
>> +
>> +	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>> +
>> +	return 0;
>> +}
> 
> This could also be a switch () { case 0: return "foo";
> case 1: return "bar"; ... }, without the explicit table.  This would
> avoid having to think about the ERRCODE field growing.  (There are some
> RES0 bits looming over it.)
> 
> (This also tends to avoid the extra pointer table in .rodata, which
> might be of interest if this were a hot path.)

Given they added new fields to the end of the list, I'm not worried about it becoming sparse.


Thanks,

James

