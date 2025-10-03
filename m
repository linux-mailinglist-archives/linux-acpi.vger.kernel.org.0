Return-Path: <linux-acpi+bounces-17581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C111ABB7D83
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804393A35C4
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F942DC760;
	Fri,  3 Oct 2025 18:05:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F112D47FE;
	Fri,  3 Oct 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514714; cv=none; b=UR9vKkiEKyH5ANUJMtdgmCXwqQexVdvj/ydENfcFpma3KfuCN49/dDNp5+i/0c2Cqa4yTcK4e86bufIuasPSreaqmFzcSkwWZauR4MBlzWTgbIMTInDlM8mnBibAM4CSNaPMy0Ig9vXbkvFtoY9+/BjMuz84IyRkHGFMn/cFIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514714; c=relaxed/simple;
	bh=vdeeye+X5OLl0dOd3r2je7XelpSqQyryFOZv1n/SK+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KglqlQXOLp41X62Xd/5LC+RFuBa+30CGuIRYOi6U69O4bFN+6/LilN6NpCPIyWC668vY/E6Cszs/gbSrHeylqvHiSmL7GGBXE/WBqCS6dqnNTKkhBbEysE9wu7PPcMBOB44IL1g9x0Dc/2IDffD0kVQwIx3R4oH+fmyYr2gIveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987EA1596;
	Fri,  3 Oct 2025 11:05:00 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B9F3F5A1;
	Fri,  3 Oct 2025 11:05:03 -0700 (PDT)
Message-ID: <db5bff88-44d5-49ff-9460-f04e6e878bb1@arm.com>
Date: Fri, 3 Oct 2025 19:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/29] arm_mpam: Probe and reset the rest of the
 features
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
 Danilo Krummrich <dakr@kernel.org>, Zeng Heng <zengheng4@huawei.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-22-james.morse@arm.com>
 <20250912140702.00000a5a@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912140702.00000a5a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:07, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:01 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> MPAM supports more features than are going to be exposed to resctrl.
>> For partid other than 0, the reset values of these controls isn't
>> known.
>>
>> Discover the rest of the features so they can be reset to avoid any
>> side effects when resctrl is in use.
>>
>> PARTID narrowing allows MSC/RIS to support less configuration space than
>> is usable. If this feature is found on a class of device we are likely
>> to use, then reduce the partid_max to make it usable. This allows us
>> to map a PARTID to itself.

> A few trivial things inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> @@ -667,10 +676,35 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>  	struct mpam_msc *msc = ris->vmsc->msc;
>>  	struct device *dev = &msc->pdev->dev;
>>  	struct mpam_props *props = &ris->props;
>> +	struct mpam_class *class = ris->vmsc->comp->class;
>>  
>>  	lockdep_assert_held(&msc->probe_lock);
>>  	lockdep_assert_held(&msc->part_sel_lock);
>>  
>> +	/* Cache Capacity Partitioning */
>> +	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
>> +		u32 ccap_features = mpam_read_partsel_reg(msc, CCAP_IDR);
>> +
>> +		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
>> +		if (props->cmax_wd &&
>> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM, ccap_features))
>> +			mpam_set_feature(mpam_feat_cmax_softlim, props);
>> +
>> +		if (props->cmax_wd &&
>> +		    !FIELD_GET(MPAMF_CCAP_IDR_NO_CMAX, ccap_features))
>> +			mpam_set_feature(mpam_feat_cmax_cmax, props);
>> +
>> +		if (props->cmax_wd &&
>> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CMIN, ccap_features))
>> +			mpam_set_feature(mpam_feat_cmax_cmin, props);
>> +
>> +		props->cassoc_wd = FIELD_GET(MPAMF_CCAP_IDR_CASSOC_WD, ccap_features);
>> +

> Trivial but blank line here feels inconsistent with local style. I'd drop it.

Sure,


>> +		if (props->cassoc_wd &&
>> +		    FIELD_GET(MPAMF_CCAP_IDR_HAS_CASSOC, ccap_features))
>> +			mpam_set_feature(mpam_feat_cmax_cassoc, props);
>> +	}
>> +
> 
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 17570d9aae9b..326ba9114d70 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -136,25 +136,34 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>>   * When we compact the supported features, we don't care what they are.
>>   * Storing them as a bitmap makes life easy.
>>   */
>> -typedef u16 mpam_features_t;
>> +typedef u32 mpam_features_t;

> This is strengthening my view that this should just be a DECLARE_BITMAP(MPAM_FEATURE_LAST)
> in the appropriate places.

I don't think this list is going to grow much. But sure.

Most stuff can be churned out, but this makes an utter mess of exposing the value to
debugfs.., I do need that exposed as "why didn't resctrl do what I wanted" is a very
common question - and being able to see what the hardware supports really helps.

Looks like exposing the first 'ulong' is the simplest - it kicks the can this creates
down the road. I experimented with u32_array - but its no better.


Thanks,

James

