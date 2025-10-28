Return-Path: <linux-acpi+bounces-18296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09925C160A8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 18:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E8414E8155
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2832BF43;
	Tue, 28 Oct 2025 17:04:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE313D51E;
	Tue, 28 Oct 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671099; cv=none; b=HC9f+8vZ6nObEytKlKUItq3vuZmF8TJm0tX7sJNKnaF+/lwQWT97l+LPiXxi6/6imyA3oKLey93E84XzIZdLhxKL1kcMDjWZIpZ9agkLTyMoka7RO8SfZ8dyqJL38Eg1vAjpMsVe5D5FHSWuC+YZ/nHdGYLH6vEqrYCcet/k4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671099; c=relaxed/simple;
	bh=OT+5A1kQwZizv6hxo2CJYKqoOrcvSA1bK0diOAcRiAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NieG0W+LFtGT9N0ykvn1S8jnuSxA1XVy4q13Ep/eSBCmQgnZ4X7PzQGr6Nh/7w1EvKsjCaNKDrCTxD+Xu5+NEICCJIE298OEzYkTpwCJoAJdOfi+DshQnR8ls1FKsXjECaMwhVhNJ16xpHFRYORFV8xguVuUr9GyHR7mQ6FVKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3CDB168F;
	Tue, 28 Oct 2025 10:04:47 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5E763F673;
	Tue, 28 Oct 2025 10:04:49 -0700 (PDT)
Message-ID: <4d77f16c-eeb7-40bc-ac37-2639308f8484@arm.com>
Date: Tue, 28 Oct 2025 17:04:47 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor
 overflow handling
To: Zeng Heng <zengheng4@huawei.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
 rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251022133913.629859-1-zengheng4@huawei.com>
 <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
 <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zeng,

On 10/25/25 09:45, Zeng Heng wrote:
> Hi Ben,
> 
> On 2025/10/23 0:17, Ben Horgan wrote:
>>>
>>> Also fix the handling of overflow amount calculation. There's no need to
>>> subtract mbwu_state->prev_val when calculating overflow_val.
>>
>> Why not? Isn't this the pre-overflow part that we are missing from the
>> running count?
>>
> 
> The MSMON_MBWU register accumulates counts monotonically forward and
> would not automatically cleared to zero on overflow.
> 
> The overflow portion is exactly what mpam_msmon_overflow_val() computes,
> there is no need to additionally subtract mbwu_state->prev_val.

Yes, I now see you are correct. The 'correction' ends up holding
(counter size) * (number of overflows) and the current value of the
counter plus this gives you the bandwidth use up until now.

> 
>>>
>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>> ---
>>>   drivers/resctrl/mpam_devices.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>>> mpam_devices.c
>>> index 0dd048279e02..06f3ec9887d2 100644
>>> --- a/drivers/resctrl/mpam_devices.c
>>> +++ b/drivers/resctrl/mpam_devices.c
>>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>>       clean_msmon_ctl_val(&cur_ctl);
>>>       gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>>       config_mismatch = cur_flt != flt_val ||
>>> -              cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>>> +             (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>>> +             (ctl_val | MSMON_CFG_x_CTL_EN);
>>
>> This only considers 31 bit counters. I would expect any change here to
>> consider all lengths of counter. Also, as the overflow bit is no longer
>> reset due to the config mismatch it needs to be reset somewhere else.
> 
> Yes, overflow bit needs to be cleared somewhere. I try to point out in
> the next patch mail.

I had misunderstood before but the current code in the series doesn't
make use of overflow bit and just relies on prev_val > now. Using
overflow status does give us a bit more lee-way for overflowing so is a
useful enhancement.

> 
> Best Regards,
> Zeng Heng
> 
> 
Thanks,

Ben


