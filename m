Return-Path: <linux-acpi+bounces-18489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77988C314BA
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0BB189E3E2
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C12221FA0;
	Tue,  4 Nov 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="juiqD+5r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A43277C8D;
	Tue,  4 Nov 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264139; cv=none; b=c16JIdCnvLRdm8nRg0/eOP3f7GqRIqx+6q5k0oVFZPpEQkfTaTJGElq71muEWrA9POsfEnJAYrKgF8nSXKQT9fcc7Lhy5u1+xMQ19h4O+QggtmaBqfHRDQR8F3KAEWpXATK28BhSlwid0wk/aaFhao8WhoFQ46qJp6ihXQ+DDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264139; c=relaxed/simple;
	bh=tyy27PwGGsvcneRrPtNtZCqEyrjIhx92dquuwVOnPbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VRmRZ556r3c5NGDvOuQStg0r7MF5kw84uav7j5LGK+45ry7AynEZhmbRLwnpJNIcIsFi6C0L5P6FPbEsrukAiO5Dj4wlor+Nln47383bFf1dmaORxw06LVQ7V4Z89R6vwaS7n+mRQJQ5yPAc8kN074pj7l04i//nIh3TCX1Fejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=juiqD+5r; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HhgDFV3NXn/IRH8qXjdRXYahylPUabXUbstxozU3bK0=;
	b=juiqD+5rV0RJy9nL5jDwbDD+vWxjSfNoRfXvQQJVf00Ih5/L/8xPUq8UXXmrrCva3dMEBL/WI
	UhKAHGa8mMhBeZeeJgMhS7d4p3ZOOKFlGtLEf0gfhexs530LjVpByzGqb2f5qePfvb0zbBY6LHU
	sD3ai+GbhT8PPehn6vERIAw=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d18sQ1Hflz1T4G2;
	Tue,  4 Nov 2025 21:47:38 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 91792180080;
	Tue,  4 Nov 2025 21:48:50 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 21:48:48 +0800
Message-ID: <40e9934d-4d19-5cea-e21f-d287584b71f4@huawei.com>
Date: Tue, 4 Nov 2025 21:48:47 +0800
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
 <f4518f80-8e17-e622-fbe6-e20a7d1c85fc@huawei.com>
 <293395d7-5766-45df-a2e0-1542fecda5a7@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <293395d7-5766-45df-a2e0-1542fecda5a7@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/11/4 18:24, Ben Horgan wrote:
> Hi Zeng,
> 
> On 11/3/25 03:47, Zeng Heng wrote:
>> Hi Ben,
>>
>> On 2025/10/30 17:52, Ben Horgan wrote:
>>> Hi Zeng,
>>>
>>> On 10/29/25 07:56, Zeng Heng wrote:
>>>> The MSMON_MBWU register accumulates counts monotonically forward and
>>>> would not automatically cleared to zero on overflow. The overflow
>>>> portion
>>>> is exactly what mpam_msmon_overflow_val() computes, there is no need to
>>>> additionally subtract mbwu_state->prev_val.
>>>>
>>>> Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
>>>> MSMON_MBWU register must first be read to prevent it from being
>>>> inadvertently cleared by the write operation.
>>>>
>>>> Finally, use the overflow bit instead of relying on counter wrap-around
>>>> to determine whether an overflow has occurred, that avoids the case
>>>> where
>>>> a wrap-around (now > prev_val) is overlooked. So with this, prev_val no
>>>> longer has any use and remove it.
>>>>
>>>> CC: Ben Horgan <ben.horgan@arm.com>
>>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>>> ---
>>>>    drivers/resctrl/mpam_devices.c  | 22 +++++++++++++++++-----
>>>>    drivers/resctrl/mpam_internal.h |  3 ---
>>>>    2 files changed, 17 insertions(+), 8 deletions(-)
>>>
>>> This all looks fine for overflow, but what we've been forgetting about
>>> is the power management. As James mentioned in his commit message, the
>>> prev_val is after now check is doing double duty. If an msc is powered
>>> down and reset then we lose the count. Hence, to keep an accurate count,
>>> we should be considering this case too.
>>>
>>
>>
>> Regarding CPU power management and CPU on-/off-line scenarios, this
>> should and already has been handled by mpam_save_mbwu_state():
>>
>> 1. Freezes the current MSMON_MBWU counter into the
>> mbwu_state->correction;
>> 2. Clears the MSMON_MBWU counter;
>>
>> After the CPU is powered back on, the total bandwidth traffic is
>> MSMON_MBWU(the `now` variable) + correction.
>>
>> So the above solution also covers CPU power-down scenarios, and no
>> additional code is needed to adapt to this case.
>>
>> If I've missed anything, thanks in advance to point it out.
>>
> 
> No, I don't think you missed anything. You just didn't mention in your commit message
> that this is also fixing the power management case.
> 
> I'm going to post the next version of this series for James as he is otherwise engaged.
> I've taken your patch and adapted it to fit in with the order of patches.
> Does this look ok to you? The support for the long counters will be added later.
> 

Yes, I have reviewed the patch, and the related adaptations look good to
me.

> @@ -1016,6 +1025,9 @@ static void __ris_msmon_read(void *arg)
>          if (config_mismatch) {
>                  write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>                  overflow = false;
> +       } else if (overflow) {
> +               mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
> +                                     cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS);
>          }

Yes, the clear register operation is added here.



Best Regards,
Zeng Heng


