Return-Path: <linux-acpi+bounces-17140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF76B8A84A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395455861EF
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB431E0ED;
	Fri, 19 Sep 2025 16:11:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96EE31DDA4;
	Fri, 19 Sep 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298268; cv=none; b=Rt82toR/ekKnVkwXd8ElEjb0OLGiLiXMSWw2o6IIxW62+Io7BE3hmW9qY7EYSEIVUitc8aO5ZU9oplb0GZIW7RsPXGetcBWYiz5UxfNAyJIrfIF3Y5cN2hqBX0Cl8cKM8GldNPh+sBazWBAGvNhdKBnqJ8xbLy/SPQlHNHdPG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298268; c=relaxed/simple;
	bh=ldrrKQvGttJzr+6AlPlEkwsAbBzrUGjgSum6lf1cfbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAku6E2vW8p5irAoIhQC5JksgJqEsDDqv7fzXqPpVAW+P9Au3RFhsNCY9mHRNi95evttXss8SfmALDVXY83HjLaFWYnfK7alQJc3DDGTX+r3jmrhkksnz0GN0Bo99bjFQGIuBxScN4Q1k6Qf0QcCwI/mwPCnaVS5KcJb6PcmxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C261F1D14;
	Fri, 19 Sep 2025 09:10:57 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E143F66E;
	Fri, 19 Sep 2025 09:11:00 -0700 (PDT)
Message-ID: <7fe33c0b-affb-4e30-a3fd-24e4c2013654@arm.com>
Date: Fri, 19 Sep 2025 17:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a cache_id
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
 <20250910204309.20751-5-james.morse@arm.com>
 <20250911120614.00001e92@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911120614.00001e92@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 12:06, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:44 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>
>> The driver needs to know which CPUs are associated with the cache.
>> The CPUs may not all be online, so cacheinfo does not have the
>> information.
>>
>> Add a helper to pull this information out of the PPTT.

> Why for this case does it makes sense to not just use acpi_get_pptt()?
> 
> Also you don't introduce the acpi_get_table_reg() helper until patch 6.

I missed fixing this one up. That's done now.


>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index c5f2a51d280b..c379a9952b00 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -966,3 +966,62 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>>  
>>  	return -ENOENT;
>>  }
>> +
>> +/**
>> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
>> + *					   specified cache
>> + * @cache_id: The id field of the unified cache
> 
> Similar comment to previous patch. If we are going to make this unified only
> can we reflect that in the function name.  I worry this will get reused
> and that restriction will surprise.

I agree - the unified restriction turns out only to be of interest to archaeologists.
I've ripped it out.



>> + * @cpus: Where to build the cpumask
>> + *
>> + * Determine which CPUs are below this cache in the PPTT. This allows the property
>> + * to be found even if the CPUs are offline.
>> + *
>> + * The PPTT table must be rev 3 or later,
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
>> + * Otherwise returns 0 and sets the cpus in the provided cpumask.
>> + */
>> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>> +{
>> +	u32 acpi_cpu_id;
>> +	int level, cpu, num_levels;
>> +	struct acpi_pptt_cache *cache;
>> +	struct acpi_pptt_cache_v1 *cache_v1;
>> +	struct acpi_pptt_processor *cpu_node;
>> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);
>> +
>> +	cpumask_clear(cpus);
>> +
>> +	if (IS_ERR(table))
>> +		return -ENOENT;
>> +
>> +	if (table->revision < 3)
>> +		return -ENOENT;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +		if (WARN_ON_ONCE(!cpu_node))
>> +			continue;

I'm not sure why this one is a WARN_ON_ONCE() and the other isn't - both mean the PPTT
table is missing CPUs, but this looks like leftover debug. I'll drop it.


>> +		num_levels = acpi_count_levels(table, cpu_node, NULL);
>> +
>> +		/* Start at 1 for L1 */
>> +		for (level = 1; level <= num_levels; level++) {
>> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
>> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
>> +						     level, &cpu_node);
>> +			if (!cache)
>> +				continue;
>> +
>> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
>> +						cache,
>> +						sizeof(struct acpi_pptt_cache));
> 
> sizeof(*cache) makes more sense to me.

Yup, I've done that in the previous one It's not otherwise done in this file - lets see if
someone cares strongly the other way.


>> +
>> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
>> +			    cache_v1->cache_id == cache_id)
>> +				cpumask_set_cpu(cpu, cpus);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}

Thanks,

James

