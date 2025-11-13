Return-Path: <linux-acpi+bounces-18869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D238C590E0
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDE6424678
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7C2F2914;
	Thu, 13 Nov 2025 16:43:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538B35BDBD;
	Thu, 13 Nov 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052222; cv=none; b=awfgBAZCC0IdLgmOyx9NL4vvbcMtKysIeB/bJG2D78KT7kd5X/x5DnMsf7XzfpiDHZsbSlrTlVEzcnUE9K10vlA7nJ4J1ZNbIWuut6hlSa8O71Jq4oAd4ht5gM7DnKnR/ovwmbR8isc6fKetwtGLJeLToVlyWztLvVaQOaRtG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052222; c=relaxed/simple;
	bh=GHQOpJYa5/IyTTpclv+sW3rljuGZIDmlDGPYC9RvjRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYAoC8q+TBkrhLhXvgOIaGPx8ap977iKu8VogxOxHB1MWCREsY/rdY+0sb5xf200Ku4+Acg2nSesGzme5lZGsUgkC2kfqqPSOdQDfOoscDwYeeeA9t7cf7qrmiyoIMACQO9crjZK2v88zm9ZQQBCG+yN1gtX1uuw2HXG8W672dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D6412FC;
	Thu, 13 Nov 2025 08:43:31 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405C93F63F;
	Thu, 13 Nov 2025 08:43:34 -0800 (PST)
Message-ID: <0b4e74a8-6a8a-429d-92a7-35df8ef04e9c@arm.com>
Date: Thu, 13 Nov 2025 16:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-15-ben.horgan@arm.com>
 <90c483a2-a7e0-4c87-a3da-8643bec63879@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <90c483a2-a7e0-4c87-a3da-8643bec63879@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/13/25 03:50, Fenghua Yu wrote:
> Hi, Ben and James,
> 
> On 11/7/25 04:34, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
> [SNIP]
> 
>> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
>> +                           u8 ris_idx)
>> +{
>> +    int err;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    if (!test_bit(ris_idx, &msc->ris_idxs)) {
>> +        err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
>> +                         0, 0);
>> +        if (err)
>> +            return ERR_PTR(err);
>> +    }
>> +
>> +    list_for_each_entry(ris, &msc->ris, msc_list) {
>> +        if (ris->ris_idx == ris_idx)
>> +            return ris;
>> +    }
>> +
>> +    return ERR_PTR(-ENOENT);
>> +}
>> +
>>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   {
>>       u64 idr;
>> +    u16 partid_max;
>> +    u8 ris_idx, pmg_max;
>> +    struct mpam_msc_ris *ris;
>>       struct device *dev = &msc->pdev->dev;
>>         lockdep_assert_held(&msc->probe_lock);
>> @@ -464,6 +564,40 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>           return -EIO;
>>       }
>>   +    /* Grab an IDR value to find out how many RIS there are */
>> +    mutex_lock(&msc->part_sel_lock);
>> +    idr = mpam_msc_read_idr(msc);
>> +    mutex_unlock(&msc->part_sel_lock);
>> +
>> +    msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>> +
>> +    /* Use these values so partid/pmg always starts with a valid
>> value */
>> +    msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>> +    msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>> +
>> +    for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>> +        mutex_lock(&msc->part_sel_lock);
>> +        __mpam_part_sel(ris_idx, 0, msc);
>> +        idr = mpam_msc_read_idr(msc);
>> +        mutex_unlock(&msc->part_sel_lock);
>> +
>> +        partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>> +        pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>> +        msc->partid_max = min(msc->partid_max, partid_max);
>> +        msc->pmg_max = min(msc->pmg_max, pmg_max);
>> +
>> +        mutex_lock(&mpam_list_lock);
>> +        ris = mpam_get_or_create_ris(msc, ris_idx);
>> +        mutex_unlock(&mpam_list_lock);
>> +        if (IS_ERR(ris))
>> +            return PTR_ERR(ris);
> 
> It's better to destroy ris's that were previously created before this
> failed ris? Otherwise, there is a memory leak for those allocated ris's?

This should be handled by mpam_disable() which is run on probe failure.

> 
> Thanks.
> 
> -Fenghua


Thanks,

Ben


