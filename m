Return-Path: <linux-acpi+bounces-17739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0BBD5095
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5423834B4A0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2B243969;
	Mon, 13 Oct 2025 16:29:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F1226CFE;
	Mon, 13 Oct 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372963; cv=none; b=tdKJ1iGuJudIcd/FL2e1QemhV5KD+hzN/VDZOf4Ivzkmn1mFucvF9HyQQtIEynAmNdwUH2HCuCfUq1Uyi0UxlLS76v+uhzA7bTwSKmex7rfkaYQfS8iDSkbfTnpy418Ev7FJLZVL4oU6B+7wrILxQ62HRaeMLXULYoQeVwB009g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372963; c=relaxed/simple;
	bh=JGb0RNZsz4c9Vqe8/pPlU1/B31S1U7K/MACGfqfsVCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB5CO7GhnvxQ2MhmQ2Q8U1wB/+YbT/RLYUke/FvK6uhgN0mypq2/1n/KYoKbTlAkMj7MH+BwZ9XmQ8uutPRcPI+BE6aJFKwxCZJSOozv9s0qcinJiiS/6cSbYv7HcezGgISx0ToElzWHAIsHPcjj/Zj8sAI+zw2OL26oTTYgTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594C0113E;
	Mon, 13 Oct 2025 09:29:12 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25ED93F738;
	Mon, 13 Oct 2025 09:29:15 -0700 (PDT)
Message-ID: <8c75d1a5-42f8-4adf-a1b1-74aa668b1a30@arm.com>
Date: Mon, 13 Oct 2025 17:29:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/29] arm_mpam: Track bandwidth counter state for
 overflow and power management
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-25-james.morse@arm.com>
 <53eddf53-a610-4420-9021-658fdf31aebe@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <53eddf53-a610-4420-9021-658fdf31aebe@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 16:55, Ben Horgan wrote:
> On 9/10/25 21:43, James Morse wrote:
>> Bandwidth counters need to run continuously to correctly reflect the
>> bandwidth.
>>
>> The value read may be lower than the previous value read in the case
>> of overflow and when the hardware is reset due to CPU hotplug.
>>
>> Add struct mbwu_state to track the bandwidth counter to allow overflow
>> and power management to be handled.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 1543c33c5d6a..eeb62ed94520 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -990,20 +992,32 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>>  		mpam_write_monsel_reg(msc, MBWU, 0);
>>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>> +
>> +		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
>> +		if (mbwu_state)
>> +			mbwu_state->prev_val = 0;

> What's the if condition doing here?

Yes, that looks like cruft....
It took the address of an array element - how could it be null?!


> The below could make more sense but I don't think you can get here if
> the allocation fails.

Heh ... only because __allocate_component_cfg() has lost the error value.
Without the outer/inner locking stuff, its feasible for  __allocate_component_cfg() to
return the error value directly.

With that fixed, and ignoring a bogus ctx->mon value - I agree you can't get a case where
this needs checking.


I think this was originally testing if the array had been allocated, and its been folded
wrongly at some point in the past. I assume I kept those bogus tests around as I saw it
blow up with nonsense num_mbwu_mon - which is something I'll retest.


>> +
>>  		break;
>>  	default:
>>  		return;
>>  	}
>>  }

>> @@ -2106,6 +2227,35 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>>  		return -ENOMEM;
>>  	init_garbage(comp->cfg);
>>  
>> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
>> +		if (!vmsc->props.num_mbwu_mon)
>> +			continue;
>> +
>> +		msc = vmsc->msc;
>> +		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
>> +			if (!ris->props.num_mbwu_mon)
>> +				continue;
>> +
>> +			mbwu_state = kcalloc(ris->props.num_mbwu_mon,
>> +					     sizeof(*ris->mbwu_state),
>> +					     GFP_KERNEL);
>> +			if (!mbwu_state) {
>> +				__destroy_component_cfg(comp);
>> +				err = -ENOMEM;
>> +				break;
>> +			}
>> +
>> +			if (mpam_mon_sel_lock(msc)) {
>> +				init_garbage(mbwu_state);
>> +				ris->mbwu_state = mbwu_state;
>> +				mpam_mon_sel_unlock(msc);
>> +			}
> 
> The if statement is confusing now that mpam_mon_sel_lock()
> unconditionally returns true.

Sure, but this and the __must_check means all the paths that use this must be able to
return an error.

This is a churn-or-not trade-off for the inclusion of the firmware-backed support.
I'd prefer it to be hard to add code-paths that are going to create a lot of work when
that comes - especially as folk are promising platforms that need this in the coming months.



Thanks,

James

