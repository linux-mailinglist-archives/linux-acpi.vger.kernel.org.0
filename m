Return-Path: <linux-acpi+bounces-17717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83BBCDFD4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B881D5479C0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4B2F8BEE;
	Fri, 10 Oct 2025 16:53:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD62FB99D;
	Fri, 10 Oct 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115209; cv=none; b=WKNe4xx0MhIKld3FPwm04LMBkOmm6vOuRydcvE/k4UFJ/1jOWv/9dA86+K/MnUjuoZlfEB6RylJ78Su4sTn0/2YllDtjdd1Zelb/xrL3k3oWYATcLXvcSF/YVppNXW6YaB/v7Gi/9eYpHqAN6VymQ4K7elq7N9WlpWfsOwkSA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115209; c=relaxed/simple;
	bh=OLzINQnM3CK/H4My4nDZ44YiZjxfmY4mZ0yqqdG5lx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u00xeEUavgkeaz9JwmnucDMLOseRxkup+0CuRtlrWuMp9H+1AbJCDMafCOdML1DlrKkP3aHX+ypNTS/ByZrDLRWUTh3jHCJimLv7h4rKe8pC0Kx4dJ/eRXcVeqC+nqdbwC3AqeDbc6dI30+wNlV1WoMTNqG8x1KoxUcwwhjYAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9EE1596;
	Fri, 10 Oct 2025 09:53:19 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3073F66E;
	Fri, 10 Oct 2025 09:53:21 -0700 (PDT)
Message-ID: <31f11369-c6ef-4a6b-a36e-973128d8f0fd@arm.com>
Date: Fri, 10 Oct 2025 17:53:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-28-james.morse@arm.com>
 <20250912143302.00004d0e@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912143302.00004d0e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:33, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:07 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> resctrl expects to reset the bandwidth counters when the filesystem
>> is mounted.
>>
>> To allow this, add a helper that clears the saved mbwu state. Instead
>> of cross calling to each CPU that can access the component MSC to
>> write to the counter, set a flag that causes it to be zero'd on the
>> the next read. This is easily done by forcing a configuration update.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>

> Minor comments inline.


>> @@ -1245,6 +1257,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>>  	return err;
>>  }
>>  
>> +void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>> +{
>> +	int idx;
>> +	struct mpam_msc *msc;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +
>> +	if (!mpam_is_enabled())
>> +		return;
>> +
>> +	idx = srcu_read_lock(&mpam_srcu);
> 
> Maybe guard() though it doesn't add that much here.

'Fixed' already based on your other feedback.


>> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> 
> Reason not to use _srcu variants?

Typo - I'd switched it all to srcu because of the pcc thing's need to sleep, but didn't
fix all these properly.



>> +		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
>> +			continue;
>> +
>> +		msc = vmsc->msc;
>> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
>> +			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
>> +				continue;
>> +
>> +			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
>> +				continue;
>> +
>> +			ris->mbwu_state[ctx->mon].correction = 0;
>> +			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
>> +			mpam_mon_sel_unlock(msc);
>> +		}
>> +	}
>> +	srcu_read_unlock(&mpam_srcu, idx);
>> +}
>> +
>>  static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>>  {
>>  	u32 num_words, msb;
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index c190826dfbda..7cbcafe8294a 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -223,10 +223,12 @@ struct mon_cfg {
>>  
>>  /*
>>   * Changes to enabled and cfg are protected by the msc->lock.
>> - * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
>> + * Changes to reset_on_next_read, prev_val and correction are protected by the
>> + * msc's mon_sel_lock.

> Getting close to the point where a list of one per line would reduce churn.
> If you anticipate adding more to this in future I'd definitely consider it.
> e.g.
>  * msc's mon_sel_lcok protects:
>  * - reset_on_next_read
>  * - prev_val
>  * - correction
>  */

It doesn't get expanded further, this is the last patch of the driver. But this is easier
to read, so I'll do that.


Thanks,

James

