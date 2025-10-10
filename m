Return-Path: <linux-acpi+bounces-17730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA3BCE019
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871FC1A66406
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECF2FC877;
	Fri, 10 Oct 2025 16:55:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802262FC86A;
	Fri, 10 Oct 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115344; cv=none; b=dO+pZHDUkxu4H7CZ+hIBB0urEJfgC/kxJugb6NGJQNVFqyf7CJ++oGFe7qdu94dnKn35jx5GcCmOLTx3PlJ27a4lSMbJYxNPNw6JONU9w2q69rhaIxD+bhuzGEYV6gwVYdUgIUoSzgadR/b2z5UON71PdginqMhGLvrAYXpgCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115344; c=relaxed/simple;
	bh=GqLrmoCjWa73cuD1cOm3HiFFK2PSjXd4yR1iL6z3tUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2f1kSOs0e9vpE1c/yTjvPzzv62z2GrWi+rq0axlYoaYfl46ZBVONWrhFrVI0jxmoW99WgA2vMCuJpXy4h9VN6ez9V2Cz7jXtszI2AD8x0H34o4dtYN5wttpNvSmJJlhDA83qbGMARoayw1NwLo1Aqzo6dVO2LMDu200lngY3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A61153B;
	Fri, 10 Oct 2025 09:55:34 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04CF53F66E;
	Fri, 10 Oct 2025 09:55:36 -0700 (PDT)
Message-ID: <9ad2f065-cd13-4b9f-8b56-baa1794f0410@arm.com>
Date: Fri, 10 Oct 2025 17:55:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/29] ACPI / PPTT: Find cache level by cache-id
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
 <20250910204309.20751-4-james.morse@arm.com>
 <5607ff12-1445-433a-b9f7-fffe20076be3@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5607ff12-1445-433a-b9f7-fffe20076be3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 02/10/2025 05:30, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> The MPAM table identifies caches by id. The MPAM driver also wants to know
>> the cache level to determine if the platform is of the shape that can be
>> managed via resctrl. Cacheinfo has this information, but only for CPUs that
>> are online.
>>
>> Waiting for all CPUs to come online is a problem for platforms where
>> CPUs are brought online late by user-space.
>>
>> Add a helper that walks every possible cache, until it finds the one
>> identified by cache-id, then return the level.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Other than minor comment issues as follows,
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks,


>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 7af7d62597df..c5f2a51d280b 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -904,3 +904,65 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t
>> *cpus)
>>                        entry->length);
>>       }
>>   }
>> +
>> +/*
>> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
>> + * @cache_id: The id field of the unified cache
>> + *
>> + * Determine the level relative to any CPU for the unified cache identified by
>> + * cache_id. This allows the property to be found even if the CPUs are offline.
>> + *
>> + * The returned level can be used to group unified caches that are peers.
>> + *
>> + * The PPTT table must be rev 3 or later,

> s/,/./

Yup, already fixed. (I need to clean my glasses more often!)


>> + *
>> + * If one CPUs L2 is shared with another as L3, this function will return
> 
> This comment is not clear. Maybe it's better to say:
> 
> + * If one CPU's L2 is shared with another CPU as L3, this function will return

Sure,


>> + * an unpredictable value.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, the revision isn't supported or
>> + * the cache cannot be found.
>> + * Otherwise returns a value which represents the level of the specified cache.
>> + */


Thanks,

James

