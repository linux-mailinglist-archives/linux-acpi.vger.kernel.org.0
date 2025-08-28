Return-Path: <linux-acpi+bounces-16154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F09B3A511
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EC89884D3
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF13258EDB;
	Thu, 28 Aug 2025 15:58:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C550A258EC9;
	Thu, 28 Aug 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396709; cv=none; b=XJn/3Z66XfWLq80rxJLQqwNqZmCjFqYz/kJnqnv4cVBW4I2LX6GCfKX4yMV39fZ/dBX5eRUS7JRf35i6DOmHnwt3Aos048DExo1FzNI5601lgWgnX+6IFktMwyqol/JAe6Tko8cMxgP5vKE+Aq45nxXac9F7yBBSGUamdTOlDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396709; c=relaxed/simple;
	bh=NrbZvEIKNT4VmJu9MDU0+OiupMqdTCllle3ZHFAZgWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMbPE+yOoHuXoWS5j+bMDuZhoBNvexxRfhH/vnktSrdJKzl4vxSWuAEXL983b8YVVd/70/kYdTBCVlb6G50tFaxMNrIpFzNjwbFkgNWaibkJbVfl36AbAu35YD97WYkb01cNvbb3+wrWTpucAHpstKUg9xBsfT5rbjR0DIRfOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88942A31;
	Thu, 28 Aug 2025 08:58:18 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42E43F694;
	Thu, 28 Aug 2025 08:58:18 -0700 (PDT)
Message-ID: <2e4c3c00-b248-421e-8ff1-d24b7b03be1a@arm.com>
Date: Thu, 28 Aug 2025 16:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-7-james.morse@arm.com>
 <aK7ju2caTjqf1+VN@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK7ju2caTjqf1+VN@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 11:53, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:47PM +0000, James Morse wrote:
>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>
>> The driver needs to know which CPUs are associated with the cache,
>> the CPUs may not all be online, so cacheinfo does not have the
>> information.
> 
> Nit: cacheinfo lacking the information is not a consequence of the
> driver needing it.
> 
> Maybe split the sentence:
> 
> -> "[...] associated with the cache. The CPUs may not [...]"

Sure,


>> Add a helper to pull this information out of the PPTT.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 660457644a5b..cb93a9a7f9b6 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -971,3 +971,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>>  
>>  	return -ENOENT;
>>  }
>> +
>> +/**
>> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
>> + *					   specified cache
>> + * @cache_id: The id field of the unified cache
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
>> +	/*
>> +	 * If we found the cache first, we'd still need to walk from each cpu.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +		if (!cpu_node)
>> +			return 0;
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
>> +
>> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
>> +			    cache_v1->cache_id == cache_id)
>> +				cpumask_set_cpu(cpu, cpus);

> Again, it feels like we are repeating the same walk multiple times to
> determine how deep the table is (on which point the table is self-
> describing anyway), and then again to derive some static property, and
> then we are then doing all of that work multiple times to derive
> different static properties, etc.
> 
> Can we not just walk over the tables once and stash the derived
> properties somewhere?

That is possible - but its a more invasive change to the PPTT parsing code.
Before the introduction of the leaf flag, the search for a processor also included a
search to check if the discovered node was a leaf.

I think this is trading time - walking over the table multiple times, against the memory
you'd need to de-serialise the tree to find the necessary properties quickly. I think the
reason Jeremy L went this way was because there may never be another request into this
code, so being ready with a quick answer was a waste of memory.

MPAM doesn't change this - all these things are done up front during driver probing, and
the values are cached by the driver.


> I'm still getting my head around this parsing code, so I'm not saying
> that the approach is incorrect here -- just wondering whether there is
> a way to make it simpler.

It's walked at boot, and on cpu-hotplug. Neither are particularly performance critical.

I agree that as platforms get bigger, there will be a tipping point ... I don't think
anyone has complained yet!


Thanks,

James

