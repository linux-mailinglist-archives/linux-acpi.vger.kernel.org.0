Return-Path: <linux-acpi+bounces-17731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6BBCE049
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 736A7500771
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EC22FC88A;
	Fri, 10 Oct 2025 16:55:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F32FC86A;
	Fri, 10 Oct 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115358; cv=none; b=tjzJElYc4w5n3ZIo0i4So5U3GGx8sqoSS/UzVrd6S2xuIRMtME9JVKKd3VHQvLHIhEqpQB6+K+m7L7V6Ig+dQ5izWpYC9foVM9DgzGUViWoNCv1DRezGGU1WeXgqCtaMmECs7SzgbZv6+91R52dLmN8Rkk29PDpnvD8fS9RGb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115358; c=relaxed/simple;
	bh=vuANaRfbGijBB4B6o46b1wsf0pMKRuoPPlTY4pYdgWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojTyFeF44UA0XdtHKDJKabOukPIJ2voS0GPWZmpTg54Ftiqyxr96KnVNY6KumTp6ghoOm4/yYYXcAaVhV6fWfNNVymPjxh0wpYtEoj7sa6mKqjnEe6+4/RyENGAm2Xl/Lq+90Crxkp5mHmW95/YYrsS/wr+vSZ4AC0xybTKgdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04812153B;
	Fri, 10 Oct 2025 09:55:49 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FEA73F66E;
	Fri, 10 Oct 2025 09:55:51 -0700 (PDT)
Message-ID: <7dbd9fd8-762b-405b-bb4e-f6adb60c8d80@arm.com>
Date: Fri, 10 Oct 2025 17:55:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a cache_id
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
 <20250910204309.20751-5-james.morse@arm.com>
 <094cc278-d488-4d22-a1f4-73616f4b99d5@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <094cc278-d488-4d22-a1f4-73616f4b99d5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 02/10/2025 06:03, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>
>> The driver needs to know which CPUs are associated with the cache.
>> The CPUs may not all be online, so cacheinfo does not have the
>> information.
>>
>> Add a helper to pull this information out of the PPTT.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index c5f2a51d280b..c379a9952b00 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -966,3 +966,62 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>> +/**
>> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
>> + *                       specified cache
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
>> +    u32 acpi_cpu_id;
>> +    int level, cpu, num_levels;
>> +    struct acpi_pptt_cache *cache;
>> +    struct acpi_pptt_cache_v1 *cache_v1;
>> +    struct acpi_pptt_processor *cpu_node;
>> +    struct acpi_table_header *table __free(acpi_table) =
>> acpi_get_table_ret(ACPI_SIG_PPTT, 0);
>> +
>> +    cpumask_clear(cpus);
>> +
>> +    if (IS_ERR(table))
>> +        return -ENOENT;
>> +
>> +    if (table->revision < 3)
>> +        return -ENOENT;
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +        cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +        if (WARN_ON_ONCE(!cpu_node))
>> +            continue;
>> +        num_levels = acpi_count_levels(table, cpu_node, NULL);
>> +
>> +        /* Start at 1 for L1 */
>> +        for (level = 1; level <= num_levels; level++) {
>> +            cache = acpi_find_cache_node(table, acpi_cpu_id,
>> +                             ACPI_PPTT_CACHE_TYPE_UNIFIED,
>> +                             level, &cpu_node);
>> +            if (!cache)
>> +                continue;
>> +
>> +            cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
>> +                        cache,
>> +                        sizeof(struct acpi_pptt_cache));
>> +
>> +            if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
>> +                cache_v1->cache_id == cache_id)
>> +                cpumask_set_cpu(cpu, cpus);
> 
> This function is almost identical to find_acpi_cache_level_from_id() defined in patch #3.

Yes - there is already a lot of repetition in this file.

I'd previously suggested to Jeremy L to ahve a walker with callbacks, but he felt that
made it harder to read.
Jonathan suggested a for_each_acpi_pptt_entry() helper:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=pptt/for_each_pptt_entry/v0&id=353ceeba3d39c6b6a10eeb1a59c49649cdf719d8

I'm avoiding including that here as its ~30 patches already!


> To reduce code size and complexity, it's better to define a common helper to server both
> of the two functions.
> 
> e.g. define a helper acpi_pptt_get_level_cpumask_from_cache_id(u32 cache_id, int *lvl,
> cpu_mask_t *cpus)
> 
> This helper has the same code body to traverse the cache levels for all CPUs as
> find_acpi_cache_level_from_id() and acpi_pptt_get_cpumask_from_cache_id(). The major
> difference is here:
> 
> +            if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +                cache_v1->cache_id == cache_id) {
> +                if (cpus)
> +                    cpumask_set_cpu(cpu, cpus);
> +                if ((level) {
> +                    *lvl = level;
> +                    return 0;
> +                }
> 
> Then simplify the two callers as follows:
> int find_acpi_cache_level_from_id(u32 cache_id)
> {
>     int level;
>     int err = acpi_pptt_get_level_cpumask_from_cache_id(cache_id, &level, NULL);
>     if (err)
>         return err;
> 
>     return level;
> }
> 
> int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
> {
>     return acpi_pptt_get_level_cpumask_from_cache_id(cache_id, NULL, cpus);
> }
> 

You've combined two functions that both walk the table (there are quiet a few more in this
file) - but they look for very different things. Your common helper is going to be much
more complex than either of these standalone.

I think Jonathan's for-each helper is the best path forward, that reduces the boiler plate
leaving the relevant differences.



Thanks,

James

