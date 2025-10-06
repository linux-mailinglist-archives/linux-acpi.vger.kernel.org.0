Return-Path: <linux-acpi+bounces-17619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85109BBE6A3
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 867B74EF1B7
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D32D6603;
	Mon,  6 Oct 2025 14:57:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C72874FC;
	Mon,  6 Oct 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762646; cv=none; b=qKlOFn1JIofDZezCjJFlld5OfDTK1ZJI2M0ycaIE3UapaDbEYioSia662M4uf4EjtRd1Nv5rcufm1IBaf8s3hV5CN1uuAoDEC8MLeBGXq5BbRe1U53CQiBJgLWDPMpRIjHIpbj3NUGX0lf1+KqpGHbe36OxwAzQuwRlExGDZszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762646; c=relaxed/simple;
	bh=mq4o+Iek00n4Z74NDlPOsqkGaxioXduQbo3moJx9Oyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWx3eHdryIBN+IzZcM+lP8sfiuoAbJaoj5XKOTzJ4M8JiBdL4oQ+U5W7oRK4ha00T3Wf2uaqWLYhimCza0V03LUPJiceJakzsl4xt3ADihbjE/aMrC4Q+Sua7zhgRQpaASpaPPxwktx2yMVJ6PKqxAlQUbroTOORGl+MyalxAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B292E1515;
	Mon,  6 Oct 2025 07:57:14 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB30B3F66E;
	Mon,  6 Oct 2025 07:57:17 -0700 (PDT)
Message-ID: <2e5d3b5e-0d76-4594-8a65-9baa635cfcd8@arm.com>
Date: Mon, 6 Oct 2025 15:57:16 +0100
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

