Return-Path: <linux-acpi+bounces-16595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC54B520BC
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DF3A8C45
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DA2D46B5;
	Wed, 10 Sep 2025 19:18:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1B29E115;
	Wed, 10 Sep 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531898; cv=none; b=psbJCugmTCLMn+nyXFq34THKHrRNDnwN03wwCy5OLTPnqFY20V5+kglcdnEmP4xcEOcE8/mdKCruvyWsodamxaktK8jRztcpuIzQYST4pqD9vFYB4T0CkcM6mf/hMZPLGXWp+8F3+9CUiy9NC2n5FdTuh6CiTBpwsfkuY7rDjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531898; c=relaxed/simple;
	bh=6ZhvNApiwNne/iED8kMddCkIdEPXUm1lKqU71yCipag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv+yETLYjw2apm+T/Sgs3nxU6WAmLa0glEDZVL59vQEtLfDffa779Lo7XZ7kckOiWjfqX6tHymFggKUqDvfVVKgrrmtmwNnmsqgBtj3k9gnpjZDFoDgWtAUa4vpZDWZ72P8VWmXMi7IJOYN0ICWFxEsNpwkLbQ+XJQpZJqBXXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6233B16F2;
	Wed, 10 Sep 2025 12:18:04 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71143F694;
	Wed, 10 Sep 2025 12:18:06 -0700 (PDT)
Message-ID: <cc3b3335-8474-404a-a424-adc070760a9f@arm.com>
Date: Wed, 10 Sep 2025 20:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
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
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-41-james.morse@arm.com> <aMGiE10e/MAlghGw@lpieralisi>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMGiE10e/MAlghGw@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 10/09/2025 17:06, Lorenzo Pieralisi wrote:
> On Fri, Aug 22, 2025 at 03:30:21PM +0000, James Morse wrote:
>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>
>> The driver needs to know which CPUs are associated with the cache,
>> the CPUs may not all be online, so cacheinfo does not have the
>> information.
>>
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
> 
> If for a possible cpu you don't get an acpi_pptt_processor node we return 0,
> is that correct ? Should not the loop continue ? Forgive me if that's a
> dumb question.

That looks like me throwing my hands up in the air and bailing out!
Yes, the loop continue-ing would be better as only possible CPUs that are missing a
PPTT description (...and cache hierarchy...) would be missing form the bitmap.

It's probably worth a WARN_ON_ONCE() too.

Thanks for spotting that!


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
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 30c10b1dcdb2..4ad08f5f1d83 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1555,6 +1555,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);

>> @@ -1582,6 +1583,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
>> +						      cpumask_t *cpus)
>> +{
>> +	return -EINVAL;
> 
> Nit: You might want the return value here to be coherent with what the function
> documentation states (ie return -ENOENT;)

Makes sense,


> Other than that:
> 
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>


Thanks!

James

