Return-Path: <linux-acpi+bounces-18598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDFAC3C943
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F9660742
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30C26F2AA;
	Thu,  6 Nov 2025 16:41:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E80329C41;
	Thu,  6 Nov 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447284; cv=none; b=g1oKV+Sk3e6QWTHIZUhFesmMq0Z3S+HJ5c9ikqMhPt3l7E8jJWwBwreZBT4tcswI+rY0I4rHLuIG03DGuJk8wKqsJuTw4Cx4R7sxG05JqkRwu72LKCo0XB+RzmGNQusU4RxCi8zyOMdkVz6AsD7i1VjdKHWzg0Njd5RkENtYpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447284; c=relaxed/simple;
	bh=4lFGiA8K/kfABjdnawuyfjQPak1ZBQeZWmw3ME/MyJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj2cZVMqdhsZzpTI1y9cRNs8fwisK8+X7vqqUl8qMtnLSGM/XEwsXMAryOHZAYYXYfSoFNW991iUjjRAqaCFYy9dwtl1m7bwaxOTD7WYmseonhqNHqH8yxiKLE+ScPELa6p9q1NhRxnnJrrYa4TquCvQGVfsUuF2Rm6XYWHQb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BDE153B;
	Thu,  6 Nov 2025 08:41:13 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB86F3F66E;
	Thu,  6 Nov 2025 08:41:16 -0800 (PST)
Message-ID: <9e2f912d-2a2e-49ed-b0ab-4286fe94e145@arm.com>
Date: Thu, 6 Nov 2025 16:41:15 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
To: Peter Newman <peternewman@google.com>, James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
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
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <CALPaoCjJXHD+HgFizzvNEvBorbUcJLTngLb7UJy-uMdybhCfrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

On 11/6/25 16:15, Peter Newman wrote:
> Hi Ben (and James),
> 
> On Fri, Oct 17, 2025 at 8:59 PM James Morse <james.morse@arm.com> wrote:
>>
>> From: Rohit Mathew <rohit.mathew@arm.com>
>>
>> Now that the larger counter sizes are probed, make use of them.
>>
>> Callers of mpam_msmon_read() may not know (or care!) about the different
>> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
>> driver pick the counter to use.
>>
>> Only 32bit accesses to the MSC are required to be supported by the
>> spec, but these registers are 64bits. The lower half may overflow
>> into the higher half between two 32bit reads. To avoid this, use
>> a helper that reads the top half multiple times to check for overflow.
>>
>> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
>> [morse: merged multiple patches from Rohit, added explicit counter selection ]
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> ---
>> Changes since v2:
>>  * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit counter
>>    selection.
>>  * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu and have
>>    the driver pick a supported counter size.
>>  * Rephrased commit message.
>>
>> Changes since v1:
>>  * Only clear OFLOW_STATUS_L on MBWU counters.
>>
>> Changes since RFC:
>>  * Commit message wrangling.
>>  * Refer to 31 bit counters as opposed to 32 bit (registers).
>> ---
>>  drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++-----
>>  1 file changed, 116 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index f4d07234ce10..c207a6d2832c 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -897,6 +897,48 @@ struct mon_read {
>>         int                             err;
>>  };
>>
>> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
>> +{
>> +       return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props) ||
>> +               mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
>> +}
>> +
>> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>> +{
>> +       int retry = 3;
>> +       u32 mbwu_l_low;
>> +       u64 mbwu_l_high1, mbwu_l_high2;
>> +
>> +       mpam_mon_sel_lock_held(msc);
>> +
>> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>> +
>> +       mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
>> +       do {
>> +               mbwu_l_high1 = mbwu_l_high2;
>> +               mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
>> +               mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
>> +
>> +               retry--;
>> +       } while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
>> +
>> +       if (mbwu_l_high1 == mbwu_l_high2)
>> +               return (mbwu_l_high1 << 32) | mbwu_l_low;
>> +       return MSMON___NRDY_L;
>> +}
>> +
>> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>> +{
>> +       mpam_mon_sel_lock_held(msc);
>> +
>> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>> +
>> +       __mpam_write_reg(msc, MSMON_MBWU_L, 0);
>> +       __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
>> +}
>> +
>>  static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>                                    u32 *flt_val)
>>  {
>> @@ -924,7 +966,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>                                                ctx->csu_exclude_clean);
>>
>>                 break;
>> -       case mpam_feat_msmon_mbwu:
>> +       case mpam_feat_msmon_mbwu_31counter:
>> +       case mpam_feat_msmon_mbwu_44counter:
>> +       case mpam_feat_msmon_mbwu_63counter:
>>                 *ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
>>
>>                 if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
>> @@ -946,7 +990,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>                 *ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
>>                 *flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
>>                 return;
>> -       case mpam_feat_msmon_mbwu:
>> +       case mpam_feat_msmon_mbwu_31counter:
>> +       case mpam_feat_msmon_mbwu_44counter:
>> +       case mpam_feat_msmon_mbwu_63counter:
>>                 *ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>>                 *flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
>>                 return;
>> @@ -959,6 +1005,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>>  static void clean_msmon_ctl_val(u32 *cur_ctl)
>>  {
>>         *cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
>> +
>> +       if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
>> +               *cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
>>  }
>>
>>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>> @@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>>                 mpam_write_monsel_reg(msc, CSU, 0);
>>                 mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>>                 break;
>> -       case mpam_feat_msmon_mbwu:
>> +       case mpam_feat_msmon_mbwu_44counter:
>> +       case mpam_feat_msmon_mbwu_63counter:
>> +               mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
>> +               fallthrough;
>> +       case mpam_feat_msmon_mbwu_31counter:
>>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>>                 mpam_write_monsel_reg(msc, MBWU, 0);
> 
> The fallthrough above seems to be problematic, assuming the MBWU=0
> being last for 31-bit was intentional. For long counters, this is
> zeroing the counter before updating the filter/control registers, but
> then clearing the 32-bit version of the counter. This fails to clear
> the NRDY bit on the long counter, which isn't cleared by software
> anywhere else.
> 
> From section 10.3.2 from the MPAM spec shared:
> 
>  "On a counting monitor, the NRDY bit remains set until it is reset by
> software writing it as 0 in the monitor register, or automatically
> after the monitor is captured in the capture register by a capture
> event"
> 
> If I update the 63-bit case to call
> mpam_msc_zero_mbwu_l(m->ris->vmsc->msc) after updating the
> control/filter registers (in addition to the other items I pointed in
> my last reply), I'm able to read MBWU counts from my hardware through
> mbm_total_bytes.
> 
> Thanks,
> -Peter

Thanks for the testing and flagging the problem. We should do the
configuration in the same order for all the monitors.

I'll change the case to:

	case mpam_feat_msmon_mbwu_31counter:
	case mpam_feat_msmon_mbwu_44counter:
	case mpam_feat_msmon_mbwu_63counter:
		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);

		if (m->type == mpam_feat_msmon_mbwu_31counter)
			mpam_write_monsel_reg(msc, MBWU, 0);
		else
			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);

		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
		break;

Thanks,

Ben


