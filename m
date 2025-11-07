Return-Path: <linux-acpi+bounces-18624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A27C3F965
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34F5A34CBA0
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412E2E0B59;
	Fri,  7 Nov 2025 10:53:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A02609D0;
	Fri,  7 Nov 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512821; cv=none; b=ZnOVaXWcF3weotjvb5xmQMOLQW2YkHd972VV4QBR1NSe60XrWfmTmK+gEx2udpj1TVW3on3zoCVSWHs+B6xj3Bkp1DAI/oONb0kaRP0/jqxWl+/oA38PY0XAdW14UTk64iK/ERCHzf0nKcQOylglC4Eqqr7M3Tcusk7tYC/V2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512821; c=relaxed/simple;
	bh=7S0v8C7HaNdoKjB2EHEdHUbn37mqS+AXGOrkda5uF2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyX1O3sUK6dIQIphLvAxXSNkrxJmG4f+WsZQn96NFYiphPcK60V3YWg/hdp8uFew30LXPHrn31fu5UQqoLzQbpxY4q67k/lZZ/hYcgM8aAMrQsT04hx44HuJv1SdpaOAC3RiV5d75LzZCFTlsWtk4QtzcDvG6e7iy/PjEY0PxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B101516;
	Fri,  7 Nov 2025 02:53:30 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CEE33F63F;
	Fri,  7 Nov 2025 02:53:33 -0800 (PST)
Message-ID: <1b8875ab-39ee-4a9c-9f99-0a8f6b80a2ca@arm.com>
Date: Fri, 7 Nov 2025 10:53:32 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
To: Peter Newman <peternewman@google.com>
Cc: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-27-james.morse@arm.com>
 <CALPaoCjJXHD+HgFizzvNEvBorbUcJLTngLb7UJy-uMdybhCfrg@mail.gmail.com>
 <9e2f912d-2a2e-49ed-b0ab-4286fe94e145@arm.com>
 <CALPaoCg7ZeQOgkeaPQ6ERKtaJqQ_n3xQUrK=qxi01CnuTjL4PA@mail.gmail.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <CALPaoCg7ZeQOgkeaPQ6ERKtaJqQ_n3xQUrK=qxi01CnuTjL4PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

On 11/7/25 10:30, Peter Newman wrote:
> Hi Ben
> 
> On Thu, Nov 6, 2025 at 5:41 PM Ben Horgan <ben.horgan@arm.com> wrote:
>>
>> Hi Peter,
>>
>> On 11/6/25 16:15, Peter Newman wrote:
>>> Hi Ben (and James),
>>>
>>> On Fri, Oct 17, 2025 at 8:59 PM James Morse <james.morse@arm.com> wrote:
>>>>
>>>> From: Rohit Mathew <rohit.mathew@arm.com>
>>>>
>>>> Now that the larger counter sizes are probed, make use of them.
>>>>
>>>> Callers of mpam_msmon_read() may not know (or care!) about the different
>>>> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
>>>> driver pick the counter to use.
>>>>
>>>> Only 32bit accesses to the MSC are required to be supported by the
>>>> spec, but these registers are 64bits. The lower half may overflow
>>>> into the higher half between two 32bit reads. To avoid this, use
>>>> a helper that reads the top half multiple times to check for overflow.
>>>>
>>>> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
>>>> [morse: merged multiple patches from Rohit, added explicit counter selection ]
>>>> Signed-off-by: James Morse <james.morse@arm.com>
>>>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>>>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>>>> ---
>>>> Changes since v2:
>>>>  * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit counter
>>>>    selection.
>>>>  * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu and have
>>>>    the driver pick a supported counter size.
>>>>  * Rephrased commit message.
>>>>
>>>> Changes since v1:
>>>>  * Only clear OFLOW_STATUS_L on MBWU counters.
>>>>
>>>> Changes since RFC:
>>>>  * Commit message wrangling.
>>>>  * Refer to 31 bit counters as opposed to 32 bit (registers).
>>>> ---
>>>>  drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++-----
>>>>  1 file changed, 116 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>>> index f4d07234ce10..c207a6d2832c 100644
>>>> --- a/drivers/resctrl/mpam_devices.c
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>> @@ -897,6 +897,48 @@ struct mon_read {
>>>>         int                             err;
>>>>  };
>>>>
>>>> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
>>>> +{
>>>> +       return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props) ||
>>>> +               mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
>>>> +}
>>>> +
>>>> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>>>> +{
>>>> +       int retry = 3;
>>>> +       u32 mbwu_l_low;
>>>> +       u64 mbwu_l_high1, mbwu_l_high2;
>>>> +
>>>> +       mpam_mon_sel_lock_held(msc);
>>>> +
>>>> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>>>> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>>>> +
>>>> +       mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
>>>> +       do {
>>>> +               mbwu_l_high1 = mbwu_l_high2;
>>>> +               mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
>>>> +               mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
>>>> +
>>>> +               retry--;
>>>> +       } while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
>>>> +
>>>> +       if (mbwu_l_high1 == mbwu_l_high2)
>>>> +               return (mbwu_l_high1 << 32) | mbwu_l_low;
>>>> +       return MSMON___NRDY_L;
>>>> +}
>>>> +
>>>> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>>>> +{
>>>> +       mpam_mon_sel_lock_held(msc);
>>>> +
>>>> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>>>> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>>>> +
>>>> +       __mpam_write_reg(msc, MSMON_MBWU_L, 0);
>>>> +       __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
>>>> +}
>>>> +
>>>>  static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>>>                                    u32 *flt_val)
>>>>  {
>>>> @@ -924,7 +966,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>>>                                                ctx->csu_exclude_clean);
>>>>
>>>>                 break;
>>>> -       case mpam_feat_msmon_mbwu:
>>>> +       case mpam_feat_msmon_mbwu_31counter:
>>>> +       case mpam_feat_msmon_mbwu_44counter:
>>>> +       case mpam_feat_msmon_mbwu_63counter:
>>>>                 *ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
>>>>
>>>>                 if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
>>>> @@ -946,7 +990,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>>>                 *ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
>>>>                 *flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
>>>>                 return;
>>>> -       case mpam_feat_msmon_mbwu:
>>>> +       case mpam_feat_msmon_mbwu_31counter:
>>>> +       case mpam_feat_msmon_mbwu_44counter:
>>>> +       case mpam_feat_msmon_mbwu_63counter:
>>>>                 *ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>>>>                 *flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
>>>>                 return;
>>>> @@ -959,6 +1005,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>>>  static void clean_msmon_ctl_val(u32 *cur_ctl)
>>>>  {
>>>>         *cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
>>>> +
>>>> +       if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
>>>> +               *cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
>>>>  }
>>>>
>>>>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>>>> @@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>>>>                 mpam_write_monsel_reg(msc, CSU, 0);
>>>>                 mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>>>>                 break;
>>>> -       case mpam_feat_msmon_mbwu:
>>>> +       case mpam_feat_msmon_mbwu_44counter:
>>>> +       case mpam_feat_msmon_mbwu_63counter:
>>>> +               mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
>>>> +               fallthrough;
>>>> +       case mpam_feat_msmon_mbwu_31counter:
>>>>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>>>>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>>>>                 mpam_write_monsel_reg(msc, MBWU, 0);
>>>
>>> The fallthrough above seems to be problematic, assuming the MBWU=0
>>> being last for 31-bit was intentional. For long counters, this is
>>> zeroing the counter before updating the filter/control registers, but
>>> then clearing the 32-bit version of the counter. This fails to clear
>>> the NRDY bit on the long counter, which isn't cleared by software
>>> anywhere else.
>>>
>>> From section 10.3.2 from the MPAM spec shared:
>>>
>>>  "On a counting monitor, the NRDY bit remains set until it is reset by
>>> software writing it as 0 in the monitor register, or automatically
>>> after the monitor is captured in the capture register by a capture
>>> event"
>>>
>>> If I update the 63-bit case to call
>>> mpam_msc_zero_mbwu_l(m->ris->vmsc->msc) after updating the
>>> control/filter registers (in addition to the other items I pointed in
>>> my last reply), I'm able to read MBWU counts from my hardware through
>>> mbm_total_bytes.
>>>
>>> Thanks,
>>> -Peter
>>
>> Thanks for the testing and flagging the problem. We should do the
>> configuration in the same order for all the monitors.
>>
>> I'll change the case to:
>>
>>         case mpam_feat_msmon_mbwu_31counter:
>>         case mpam_feat_msmon_mbwu_44counter:
>>         case mpam_feat_msmon_mbwu_63counter:
>>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>>
>>                 if (m->type == mpam_feat_msmon_mbwu_31counter)
>>                         mpam_write_monsel_reg(msc, MBWU, 0);
>>                 else
>>                         mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
>>
>>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>>                 break;
> 
> I tried this out but wasn't able to read the counters. I needed to
> move the MBWU[_L] write to the end. Writing the registers directly on
> the hardware I'm testing with, I confirmed that just flipping
> MBWU_CTL.EN sets NRDY:
> 
> MBWU_L=0x880
> MBWU_CTL=0x828
> 
>  / # mmio_read32 $((msc + MBWU_CTL))
> 0x80030042
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x03ecb2c0
> 0x00000000
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x03f70580
> 0x00000000
> 
> Clear MBWU_CTL.EN:
> 
>  / # mmio_write32 $((msc + MBWU_CTL)) 0x00030042
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x05004680
> 0x80000000
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x05004680
> 0x80000000
> 
> Clear NRDY and reenable MBWU_CTL.EN:
> 
>  / # mmio_write32 $((msc + MBWU_L)) 0; mmio_write32 $((msc + MBWU_L + 4)) 0
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x00000000
> 0x00000000
>  / # mmio_write32 $((msc + MBWU_CTL)) 0x80030042
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x001dee80
> 0x80000000
> 
> In fact, re-writing the same value back into MBWU_CTL.EN also sets NRDY:
> 
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x00253e00
> 0x00000000
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x00b1a6c0
> 0x00000000
>  / # mmio_write32 $((msc + MBWU_CTL)) 0x80030042
>  / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
> 0x018d1d40
> 0x80000000
> 
> Thanks,
> -Peter


Thank you very much for the quick testing and diagnosis. It does seeem
reasonable that the .EN flip would be considered a configuration change
and so indeed the writing NRDY (and the value) should happend after for
counting monitors (mbwu). I'll make this change now.

Thanks,

Ben


