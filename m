Return-Path: <linux-acpi+bounces-17887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C381BEB437
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A761AA74F9
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB52FC01A;
	Fri, 17 Oct 2025 18:50:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36E86344;
	Fri, 17 Oct 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727056; cv=none; b=OKMe9QwEZAyLLiQDwfiRoWIg0ND5ts/KmGe6EWM0/tQynMQph+kFEO7wbbELtUVhG3XYJQ3alcAKNeTJIoKaAkJqVe6QVG4GZOZ1/0BmX80z9EA466oyY4rcHti060sTFXAagaPQ/wSWn89lYDF4QLMq7lPA7ieHvCzh2g6nujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727056; c=relaxed/simple;
	bh=lJVsa2IA0P3lCZxqp63ZMqEf1tszgUBL+5SEzPYsMJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV0QlKtMOVN7iW5wB7nYR4cNDEXYlrOwZbVfSv44OKC/OIlxXf7LfcZfub7vvcan+i7yLpzYiiaqbZZO0Tj+eey6bh/zj65PYyF04wiDcKYV3rX+cnuWmUwVwU/KR6z+PJZVjRusIQGAJzRDY2U/qkApvncxyJLGHUuqjDbjOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930301515;
	Fri, 17 Oct 2025 11:50:45 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E0B3F6A8;
	Fri, 17 Oct 2025 11:50:48 -0700 (PDT)
Message-ID: <72750912-ed50-4a1b-8c43-455a7bc9efc1@arm.com>
Date: Fri, 17 Oct 2025 19:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/29] arm_mpam: Reset MSC controls from cpu hp
 callbacks
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-16-james.morse@arm.com>
 <1f084a23-7211-4291-99b6-7f5192fb9096@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <1f084a23-7211-4291-99b6-7f5192fb9096@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 05/10/2025 21:43, Fenghua Yu wrote:
> Hi, James,
> 
> On 9/10/25 13:42, James Morse wrote:
>> When a CPU comes online, it may bring a newly accessible MSC with
>> it. Only the default partid has its value reset by hardware, and
>> even then the MSC might not have been reset since its config was
>> previously dirtyied. e.g. Kexec.
> 
> typo: s/dirtyied/dirtied/
> 
> 
>>
>> Any in-use partid must have its configuration restored, or reset.
>> In-use partids may be held in caches and evicted later.
>>
>> MSC are also reset when CPUs are taken offline to cover cases where
>> firmware doesn't reset the MSC over reboot using UEFI, or kexec
>> where there is no firmware involvement.
>>
>> If the configuration for a RIS has not been touched since it was
>> brought online, it does not need resetting again.
>>
>> To reset, write the maximum values for all discovered controls.
>>
>> CC: Rohit Mathew<Rohit.Mathew@arm.com>
>> Signed-off-by: James Morse<james.morse@arm.com>
> 
> Other than the minor comments,
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks,


> [SNIP]
>> +static void mpam_reset_ris(struct mpam_msc_ris *ris)
>> +{
>> +    u16 partid, partid_max;
>> +
>> +    mpam_assert_srcu_read_lock_held();
>> +
>> +    if (ris->in_reset_state)
>> +        return;
>> +
>> +    spin_lock(&partid_max_lock);
>> +    partid_max = mpam_partid_max;
>> +    spin_unlock(&partid_max_lock);
>> +    for (partid = 0; partid < partid_max; partid++)
> 
>  * Should partid_max be inclusive? So it's "partid < partid_max + 1" here?
> 
> MPAM spec says max PARTID is inclusive: "The range of valid PARTIDs is 0 to the maximum
> PARTID, inclusive. The maximum values of a PARTID implemented by different MSCs need not
> be the same".

Hmmm, if partid_max is 0 then this loop should run only once, so yet.


Thanks,

James

