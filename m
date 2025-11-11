Return-Path: <linux-acpi+bounces-18770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C30C4CAB7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3E3934F274
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CB2EC0B4;
	Tue, 11 Nov 2025 09:30:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376C2EBBA8;
	Tue, 11 Nov 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853445; cv=none; b=ImkFVkOH8nYxBz2ZDAG03KG2qYsSA5jFCDghiA4SuTs4SxKQSWBt+pLNJVUrae8CvVixIryAH7hlCnUQwe6pkeYfyMR8ub5KA8iHN3MhSVIJs5jBxrBRz9AJma+ilFXpqezDHqBezSwh/iXNzoLSIKuf7smGVjvsdQApxfGfzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853445; c=relaxed/simple;
	bh=6BWMhUaGJXcm2r6RkdFwVAQjXyKFudVYkHAINi3qE5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWYqRRa9+DLaGCSk0Q5YZ7G5PY2y9rZNI3Dzil9aP6YTXiWJ2nF8ZInhmClOlppdP45xyXAW1qxEeU83DKzg4UVYLfL1c8+ow07d0jkRZJpkt63EMSOeZonwvrFeLef2fTdfKOAVRMdYVAhfKvyNzLcMCaWPF6OmrxUg/HY2OCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD9F2F;
	Tue, 11 Nov 2025 01:30:28 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B9D3F66E;
	Tue, 11 Nov 2025 01:30:31 -0800 (PST)
Message-ID: <58e6a323-5c14-4c64-acb5-84bb8679404a@arm.com>
Date: Tue, 11 Nov 2025 09:30:29 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
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
 <7d0c73d3-1943-469f-813a-eba1dac38d4a@redhat.com>
 <33f9822a-fbb5-47e1-ab5c-97b30511a97f@redhat.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <33f9822a-fbb5-47e1-ab5c-97b30511a97f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 11/10/25 23:26, Gavin Shan wrote:
> Hi Ben,
> 
> On 11/9/25 10:43 AM, Gavin Shan wrote:
>> On 11/7/25 10:34 PM, Ben Horgan wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> CPUs can generate traffic with a range of PARTID and PMG values,
>>> but each MSC may also have its own maximum size for these fields.
>>> Before MPAM can be used, the driver needs to probe each RIS on
>>> each MSC, to find the system-wide smallest value that can be used.
>>> The limits from requestors (e.g. CPUs) also need taking into account.
>>>
>>> While doing this, RIS entries that firmware didn't describe are created
>>> under MPAM_CLASS_UNKNOWN.
>>>
>>> This adds the low level MSC write accessors.
>>>
>>> While we're here, implement the mpam_register_requestor() call
>>> for the arch code to register the CPU limits. Future callers of this
>>> will tell us about the SMMU and ITS.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> Tested-by: Peter Newman <peternewman@google.com>
>>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>>> ---
>>> Changes since v3:
>>>  From Jonathan:
>>> Stray comma in printk
>>> Unnecessary braces
>>> ---
>>>   drivers/resctrl/mpam_devices.c  | 148 +++++++++++++++++++++++++++++++-
>>>   drivers/resctrl/mpam_internal.h |   6 ++
>>>   include/linux/arm_mpam.h        |  14 +++
>>>   3 files changed, 167 insertions(+), 1 deletion(-)
[...]
>>>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>>   {
>>>       u64 idr;
>>> +    u16 partid_max;
>>> +    u8 ris_idx, pmg_max;
>>> +    struct mpam_msc_ris *ris;
>>>       struct device *dev = &msc->pdev->dev;
>>>       lockdep_assert_held(&msc->probe_lock);
>>> @@ -464,6 +564,40 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>>           return -EIO;
>>>       }
>>> +    /* Grab an IDR value to find out how many RIS there are */
>>> +    mutex_lock(&msc->part_sel_lock);
>>> +    idr = mpam_msc_read_idr(msc);
>>> +    mutex_unlock(&msc->part_sel_lock);
>>> +
>>> +    msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>>> +
>>> +    /* Use these values so partid/pmg always starts with a valid
>>> value */
>>> +    msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>>> +    msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>>> +
>>> +    for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>>> +        mutex_lock(&msc->part_sel_lock);
>>> +        __mpam_part_sel(ris_idx, 0, msc);
>>> +        idr = mpam_msc_read_idr(msc);
>>> +        mutex_unlock(&msc->part_sel_lock);
>>> +
>>> +        partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>>> +        pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>>> +        msc->partid_max = min(msc->partid_max, partid_max);
>>> +        msc->pmg_max = min(msc->pmg_max, pmg_max);
>>> +
>>> +        mutex_lock(&mpam_list_lock);
>>> +        ris = mpam_get_or_create_ris(msc, ris_idx);
>>> +        mutex_unlock(&mpam_list_lock);
>>> +        if (IS_ERR(ris))
>>> +            return PTR_ERR(ris);
>>> +    }
>>> +
>>> +    spin_lock(&partid_max_lock);
>>> +    mpam_partid_max = min(mpam_partid_max, msc->partid_max);
>>> +    mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
>>> +    spin_unlock(&partid_max_lock);
>>> +
> 
> mpam_register_requestor() could be used here to avoid the capacities
> (maximal PARTIDs and PMGs) are unexpectedly lowered.
> 

I agree that this is somewhat surprising that without a requestor the
driver supports 1 PARTID and 1 PMG, but it is intentional behaviour. The
driver is only intended to be fully functional when a requestor
(external to this base driver) registers itself and I don't want to add
a dual meaning to this registration. This will be more obvious once the
rest of the mpam support is added.

Thanks,

Ben


