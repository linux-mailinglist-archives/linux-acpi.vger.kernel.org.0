Return-Path: <linux-acpi+bounces-18086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810EDBFC153
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9556A62514C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2534D4CD;
	Wed, 22 Oct 2025 12:58:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362F34CFC4;
	Wed, 22 Oct 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137928; cv=none; b=ahRu4IOzwYC4hTesemkhiQhwlpaGPW6sfkdGEBIY5AzSBzdModXjigbsXKd9lHvTN5lrWLLJg4NszXoZcnoBgHPtsf1LyPSeAl+QdZr0qWlsrCEbpLBB1xCSIKLullQD5Nyvj9hTLg2uWxpP1TwezNdQfdhrrkhzg2w6xqzFD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137928; c=relaxed/simple;
	bh=l/bVXGTOuH/P3gATCnbv+Ywy5GgZCkt/pyPSy5TEh6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdSWeklJvfeUqWBDcI2yxvoaw52MoyXjzKalyCHg8hDxuAi6GxyujzUSEy4sK8xoytp0BHf5nLJdB2Nz4FjeeInyCLh0PMbl0kzCiUeZTAuvPa12Bu1VbITPW0ufnm86VQSa40Fym4KHLdZ1eJQP+KdPpxHIhX+mlArvkLIAUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C7E1063;
	Wed, 22 Oct 2025 05:58:37 -0700 (PDT)
Received: from [172.27.251.126] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A177C3F59E;
	Wed, 22 Oct 2025 05:58:38 -0700 (PDT)
Message-ID: <50a8cc38-810b-4bea-9a73-2463a6160b9f@arm.com>
Date: Wed, 22 Oct 2025 07:58:36 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a cache_id
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-5-james.morse@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251017185645.26604-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is largely looking pretty solid, but..


On 10/17/25 1:56 PM, James Morse wrote:
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> 
> The driver needs to know which CPUs are associated with the cache.
> The CPUs may not all be online, so cacheinfo does not have the
> information.
> 
> Add a helper to pull this information out of the PPTT.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>   * Removed stray cleanup useage in preference for acpi_get_pptt().
>   * Removed WARN_ON_ONCE() for symmetry with other helpers.
>   * Dropped restriction on unified caches.
> 
> Changes since v1:
>   * Added punctuation to the commit message.
>   * Removed a comment about an alternative implementaion.
>   * Made the loop continue with a warning if a CPU is missing from the PPTT.
> 
> Changes since RFC:
>   * acpi_count_levels() now returns a value.
>   * Converted the table-get stuff to use Jonathan's cleanup helper.
>   * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>   drivers/acpi/pptt.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  6 +++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 50c8f2a3c927..2f86f58699a6 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -985,3 +985,67 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>   
>   	return -ENOENT;
>   }
> +
> +/**
> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
> + *					   specified cache
> + * @cache_id: The id field of the cache
> + * @cpus: Where to build the cpumask
> + *
> + * Determine which CPUs are below this cache in the PPTT. This allows the property
> + * to be found even if the CPUs are offline.
> + *
> + * The PPTT table must be rev 3 or later,
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
> + * Otherwise returns 0 and sets the cpus in the provided cpumask.
> + */
> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
> +{
> +	int level, cpu;
> +	u32 acpi_cpu_id;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_table_header *table;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +
> +	cpumask_clear(cpus);
> +
> +	table = acpi_get_pptt();
> +	if (!table)
> +		return -ENOENT;
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			continue;
> +
> +		/* Start at 1 for L1 */
> +		level = 1;
> +		cache = acpi_find_any_type_cache_node(table, acpi_cpu_id, level,
> +						      &cpu_node);
> +		while (cache) {
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache, sizeof(*cache));

Is the core acpi definition in actbl2.h correct? Shouldn't it be 
something along the lines of:

struct acpi_pptt_cache_v1 {
  struct acpi_subtable_header header;
  u16 reservedd;
  u32 flags;
  u32 next_level_of_cache;
  u32 size;
  u32 number_of_sets;
  u8 associativity;
  u8 attributes;
  u16 lines_size;
  u32 cache_id;
}


Then that solves the detection of the additional field problem correctly 
because the length (24 vs 28) of the subtable then tells you which 
version your dealing with. (and goes back to why much of this is coded 
to use ACPI_ADD_PTR rather than structure+ logic.)


Thanks,






> +			if (!cache)
> +				continue;
> +
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache, sizeof(*cache));
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id)
> +				cpumask_set_cpu(cpu, cpus);
> +
> +			level++;
> +			cache = acpi_find_any_type_cache_node(table, acpi_cpu_id,
> +							      level, &cpu_node);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index be074bdfd4d1..a9dbacabdf89 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1543,6 +1543,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>   void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>   int find_acpi_cache_level_from_id(u32 cache_id);
> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1570,6 +1571,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
>   {
>   	return -ENOENT;
>   }
> +static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
> +						      cpumask_t *cpus)
> +{
> +	return -ENOENT;
> +}
>   #endif
>   
>   void acpi_arch_init(void);


