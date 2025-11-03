Return-Path: <linux-acpi+bounces-18417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3985C29FD9
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 04:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8285C3A7D17
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C01EB5DB;
	Mon,  3 Nov 2025 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="MFjKhlNh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DDEEA8;
	Mon,  3 Nov 2025 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141633; cv=none; b=YfOuBOEOjaCIWV5tHxlP/p5KLhmRz/Y4rTQDBgmpW14bcszc85b1wfGJE/F1DjIRB6byHNJ/qjOXsleaULSLsGNnb6tYhBTBnAw5sV2scjV0Cg8/Q8dyIFeyC9L0siICWLIg413eXuHue6Ldyhb1THPXLNgjLkEiiSgPW3PHpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141633; c=relaxed/simple;
	bh=L6Su2ukM9UOYRRVdX5DrBoLGnbapqAFdQuetSaq8vb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rNDpH/5tTqUhTmvENCATOxMfjJ2tXQ/lLuwQHlk55YvUDNoP5lzEFqHzYqrtZ1NwjR6F4oFSN/i/uvenq5mTuurU3YjyeVglA24xjmqABmF6DO9m3rAZCZ1ltxwXPOl3OQCZEvAuvWOAPv8lopI3CfaBq+FkEKf7m35TJiV16v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=MFjKhlNh; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0rpIOldGaRZqux6IkfxvDrJ9iXhiz25va/SIekALyO4=;
	b=MFjKhlNhh/5/RBFE9MVUU6tsM6zHmptB2deGf3AyAlf3opd53Q4QDzhqUwNkbIkvhyn1IVoln
	WgIhnIslqfzwbiQQwhIWLicTnsxOwmIzXuWXAMgqWaAkxO9WR6kIM/pATG8PmUKG3qV7N2ggk3T
	LHKLqzfGj2QplFROV1RpDIU=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d0HY74cWyz1cyNp;
	Mon,  3 Nov 2025 11:45:31 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id CE76D1A0188;
	Mon,  3 Nov 2025 11:47:05 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 11:47:03 +0800
Message-ID: <f4518f80-8e17-e622-fbe6-e20a7d1c85fc@huawei.com>
Date: Mon, 3 Nov 2025 11:47:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64/mpam: Clean MBWU monitor overflow bit
Content-Language: en-US
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251029075655.3284280-1-zengheng4@huawei.com>
 <b0ea1879-9e77-4eb3-8312-ce27d73cc1f4@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <b0ea1879-9e77-4eb3-8312-ce27d73cc1f4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/10/30 17:52, Ben Horgan wrote:
> Hi Zeng,
> 
> On 10/29/25 07:56, Zeng Heng wrote:
>> The MSMON_MBWU register accumulates counts monotonically forward and
>> would not automatically cleared to zero on overflow. The overflow portion
>> is exactly what mpam_msmon_overflow_val() computes, there is no need to
>> additionally subtract mbwu_state->prev_val.
>>
>> Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
>> MSMON_MBWU register must first be read to prevent it from being
>> inadvertently cleared by the write operation.
>>
>> Finally, use the overflow bit instead of relying on counter wrap-around
>> to determine whether an overflow has occurred, that avoids the case where
>> a wrap-around (now > prev_val) is overlooked. So with this, prev_val no
>> longer has any use and remove it.
>>
>> CC: Ben Horgan <ben.horgan@arm.com>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/resctrl/mpam_devices.c  | 22 +++++++++++++++++-----
>>   drivers/resctrl/mpam_internal.h |  3 ---
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 0dd048279e02..db4cec710091 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1039,7 +1039,6 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>>
>>   		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
>> -		mbwu_state->prev_val = 0;
>>
>>   		break;
>>   	default:
>> @@ -1062,6 +1061,16 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
>>   	}
>>   }
>>
>> +static bool read_msmon_mbwu_is_overflow(struct mpam_msc *msc)
>> +{
>> +	u32 ctl;
>> +
>> +	ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>> +	return ctl & (MSMON_CFG_x_CTL_OFLOW_STATUS |
>> +		      MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L) ?
>> +		      true : false;
>> +}
>> +
>>   /* Call with MSC lock held */
>>   static void __ris_msmon_read(void *arg)
>>   {
>> @@ -1069,6 +1078,7 @@ static void __ris_msmon_read(void *arg)
>>   	bool config_mismatch;
>>   	struct mon_read *m = arg;
>>   	u64 now, overflow_val = 0;
>> +	bool mbwu_overflow = false;
>>   	struct mon_cfg *ctx = m->ctx;
>>   	bool reset_on_next_read = false;
>>   	struct mpam_msc_ris *ris = m->ris;
>> @@ -1091,6 +1101,7 @@ static void __ris_msmon_read(void *arg)
>>   			reset_on_next_read = mbwu_state->reset_on_next_read;
>>   			mbwu_state->reset_on_next_read = false;
>>   		}
>> +		mbwu_overflow = read_msmon_mbwu_is_overflow(msc);
>>   	}
>>
>>   	/*
>> @@ -1103,8 +1114,10 @@ static void __ris_msmon_read(void *arg)
>>   	config_mismatch = cur_flt != flt_val ||
>>   			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>>
>> -	if (config_mismatch || reset_on_next_read)
>> +	if (config_mismatch || reset_on_next_read) {
>>   		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>> +		mbwu_overflow = false;
>> +	}
>>
>>   	switch (m->type) {
>>   	case mpam_feat_msmon_csu:
>> @@ -1138,10 +1151,9 @@ static void __ris_msmon_read(void *arg)
>>   		mbwu_state = &ris->mbwu_state[ctx->mon];
>>
>>   		/* Add any pre-overflow value to the mbwu_state->val */
>> -		if (mbwu_state->prev_val > now)
>> -			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
> 
> This all looks fine for overflow, but what we've been forgetting about
> is the power management. As James mentioned in his commit message, the
> prev_val is after now check is doing double duty. If an msc is powered
> down and reset then we lose the count. Hence, to keep an accurate count,
> we should be considering this case too.
> 


Regarding CPU power management and CPU on-/off-line scenarios, this
should and already has been handled by mpam_save_mbwu_state():

1. Freezes the current MSMON_MBWU counter into the
mbwu_state->correction;
2. Clears the MSMON_MBWU counter;

After the CPU is powered back on, the total bandwidth traffic is
MSMON_MBWU(the `now` variable) + correction.

So the above solution also covers CPU power-down scenarios, and no
additional code is needed to adapt to this case.

If I've missed anything, thanks in advance to point it out.


Best Regards,
Zeng Heng








