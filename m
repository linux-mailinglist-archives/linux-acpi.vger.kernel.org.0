Return-Path: <linux-acpi+bounces-16545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B7B503A6
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D81891E4F
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0B36CE1C;
	Tue,  9 Sep 2025 16:57:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410F36CE03;
	Tue,  9 Sep 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437049; cv=none; b=VUqRLEYBcyFyAgYUhDqIbQ25PrYYmaIC2dgOdb02ANTHsFb+druxuQkDA6YSqjlGw/h8ajkN9PkHgKgybLLnFTU8ufJThGA3VVb2677Ic7dWue9TvEPSOuNcrdbG8oz7ZFDVZhPVqnR+rSIQGkdG/3JvJ3Yo6QnzXriBxk80i8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437049; c=relaxed/simple;
	bh=MptZddknP3bQOHd7Pnm8unAFcFfEZXW/Cqk09dZG014=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeCKP/oO074I/QZxVSWtFlpCV7pWgjLckKNX+oY5AjzOjdf5QUXI8epOOF/cW4AyOA2ezVVTXSkIA4vGi1RQ9bGULee73SJOPMaITs10MjyI21xaB1IwwrdI4P0JVQXnsB9UwT1fzHaNOT6hjUA4o7i+6OxRgJy4dnQJedeiAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8AB420E3;
	Tue,  9 Sep 2025 09:57:18 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92FA53F694;
	Tue,  9 Sep 2025 09:57:16 -0700 (PDT)
Message-ID: <9c65c518-b4a2-4ac0-bf5d-9bdb8741dcf6@arm.com>
Date: Tue, 9 Sep 2025 17:57:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] arm_mpam: Probe the hardware features resctrl
 supports
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-18-james.morse@arm.com>
 <17f4507c-c244-42ee-bea0-57ed22e0a05f@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <17f4507c-c244-42ee-bea0-57ed22e0a05f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/08/2025 14:44, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> Expand the probing support with the control and monitor types
>> we can use with resctrl.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 012e09e80300..290a04f8654f 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -102,7 +102,7 @@ static LLIST_HEAD(mpam_garbage);
>>  
>>  static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>>  {
>> -	WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
>> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);

> Update in the patch that introduced this line.

Yeah - this got ripped out.
Now that the size is in the ACPI table, I should never need to debug it being wrong!
(and the resulting translation fault will be enough to say something is wrong)


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index c6f087f9fa7d..9f6cd4a68cce 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -136,6 +136,56 @@ static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)

>> +/* Bits for mpam_features_t */
>> +enum mpam_device_features {
>> +	mpam_feat_ccap_part = 0,
>> +	mpam_feat_cpor_part,
>> +	mpam_feat_mbw_part,
>> +	mpam_feat_mbw_min,
>> +	mpam_feat_mbw_max,
>> +	mpam_feat_mbw_prop,
>> +	mpam_feat_msmon,
>> +	mpam_feat_msmon_csu,
>> +	mpam_feat_msmon_csu_capture,
>> +	mpam_feat_msmon_csu_hw_nrdy,
>> +	mpam_feat_msmon_mbwu,
>> +	mpam_feat_msmon_mbwu_capture,
>> +	mpam_feat_msmon_mbwu_rwbw,
>> +	mpam_feat_msmon_mbwu_hw_nrdy,
>> +	mpam_feat_msmon_capt,
>> +	MPAM_FEATURE_LAST,

> This isn't all the features or just the features supported by resctrl.
> Just add them all in this patch?

I'm having trouble parsing this ...

I needed somewhere to split the features up, as there are rather a lot. Those that resctrl
supports seemed like the logical spot.


>> +};
>> +static_assert(BITS_PER_TYPE(mpam_features_t) >= MPAM_FEATURE_LAST);
>> +#define MPAM_ALL_FEATURES      ((1 << MPAM_FEATURE_LAST) - 1)

> Unused?

Fixed, thanks!


Thanks,

James

