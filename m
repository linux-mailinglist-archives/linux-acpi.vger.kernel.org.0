Return-Path: <linux-acpi+bounces-17629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFABBE8FA
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69FFF3491D6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1D2D8DA6;
	Mon,  6 Oct 2025 15:56:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A7296BA9;
	Mon,  6 Oct 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766203; cv=none; b=B9R7W0/XAEED/SoQYBmTSPxilmHGvgkro24yYvmkXERwL+/7exL8jxgfFx/U00hQU00sfDaDtOr61Ef2LUD0AXm8uJaLDGEHzEwOvS2Q5mXRD/t+C7vtYwk8j9yM+UW6Hs9FOjjrOxe1BdxGn5W7JdqhhXetKegD7wDcag5NYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766203; c=relaxed/simple;
	bh=mq4o+Iek00n4Z74NDlPOsqkGaxioXduQbo3moJx9Oyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMCUtlNBYn87vKmCRNL0a8IPMW7coXpjgpdjfcYD7pBOsBTgT0WBMk1ZQPZBkVHr6qrhJ6cgfyVvpLcDMdN+FUKW7t4t6nJTXBW1m1YaWynMtNphPgX630F8uUN2OT9EdcSC/IQ8bpUALR72OB0u48P/sysjPbQdm/7rlDB65bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87DE1515;
	Mon,  6 Oct 2025 08:56:32 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33D23F738;
	Mon,  6 Oct 2025 08:56:35 -0700 (PDT)
Message-ID: <0db211ba-d1b0-4394-b765-009192e67565@arm.com>
Date: Mon, 6 Oct 2025 16:56:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/29] arm_mpam: Add helpers to allocate monitors
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-23-james.morse@arm.com>
 <20250912141123.000068e2@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912141123.000068e2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:11, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:02 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> MPAM's MSC support a number of monitors, each of which supports
>> bandwidth counters, or cache-storage-utilisation counters. To use
>> a counter, a monitor needs to be configured. Add helpers to allocate
>> and free CSU or MBWU monitors.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> 
> One minor requested change inline that will probably otherwise get picked
> up by someone's cleanup script
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 326ba9114d70..81c4c2bfea3d 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h

>> +static inline int mpam_alloc_mbwu_mon(struct mpam_class *class)
>> +{
>> +	struct mpam_props *cprops = &class->props;
>> +
>> +	if (!mpam_has_feature(mpam_feat_msmon_mbwu, cprops))
>> +		return -EOPNOTSUPP;
>> +
>> +	return ida_alloc_range(&class->ida_mbwu_mon, 0,
>> +			       cprops->num_mbwu_mon - 1, GFP_KERNEL);
> 
> ida_alloc_max() - which is just a wrapper that sets the minimum to 0
> but none the less perhaps conveys things slightly better.

Sure - I didn't spot that when I did this.


Thanks,

James

