Return-Path: <linux-acpi+bounces-17966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 072ABBF0906
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF5CD4F24B8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345C2ECEA7;
	Mon, 20 Oct 2025 10:34:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42724167A;
	Mon, 20 Oct 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956487; cv=none; b=IL44IIg78QK+pAJM/zpZweXkdPUutWu8UpNQA8u2d0qiGpXsiihcbJ1YshIRMYGcHmFtWU+Po9SQGTGVyeMx2htQ5yocMPleF02ncxCcFMsIjv8hhBlxY88Lkol+Y/QGB+Ae9qsqAeAQsBzF2qYkZImBGCuWEC0UMkHemTCTStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956487; c=relaxed/simple;
	bh=c2OU16wGnrVpMzoppH1IWuhNPGGBG4O+QaZbd3WqpPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHYjr1mOtoZSFJiwbxttV8+J9iei85bF+ZObk6BBAtra+ul7+NAysK/JZkJNai5bMRO0r4ZTaE3m78zeIq6tEzY/k6zjIlmMFTYAkkM9Ome5fKU5X2gzrekqwcHinK9y+nXkNiTgFKYHRl0oI9WDYV4otbgSvvRb+BJL75DT3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C2AC1063;
	Mon, 20 Oct 2025 03:34:37 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA783F63F;
	Mon, 20 Oct 2025 03:34:40 -0700 (PDT)
Message-ID: <baea7e2b-7f09-4054-a1fc-31cbd349e65e@arm.com>
Date: Mon, 20 Oct 2025 11:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] ACPI / PPTT: Find cache level by cache-id
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-4-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes sinec v2:
>  * Search all caches, not just unified caches. This removes the need to count
>    the caches first, but means a failure to find the table walks the table
>    three times for different cache types.
>  * Fixed return value of the no-acpi stub.
>  * Punctuation typo in a comment,
>  * Keep trying to parse the table even if a bogus CPU is encountered.
>  * Specified CPUs share caches with other CPUs.
> 
> Changes since v1:
>  * Droppeed the cleanup based table freeing, use acpi_get_pptt() instead.
>  * Removed a confusing comment.
>  * Clarified the kernel doc.
> 
> Changes since RFC:
>  * acpi_count_levels() now returns a value.
>  * Converted the table-get stuff to use Jonathan's cleanup helper.
>  * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>  drivers/acpi/pptt.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 +++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 63c3a344c075..50c8f2a3c927 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -350,6 +350,27 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>  	return found;
>  }
>  
> +static struct acpi_pptt_cache *
> +acpi_find_any_type_cache_node(struct acpi_table_header *table_hdr,
> +			      u32 acpi_cpu_id, unsigned int level,
> +			      struct acpi_pptt_processor **node)
> +{
> +	struct acpi_pptt_cache *cache;
> +
> +	cache = acpi_find_cache_node(table_hdr, acpi_cpu_id, CACHE_TYPE_UNIFIED,
> +				     level, node);
> +	if (cache)
> +		return cache;
> +
> +	cache = acpi_find_cache_node(table_hdr, acpi_cpu_id, CACHE_TYPE_DATA,
> +				     level, node);
> +	if (cache)
> +		return cache;
> +
> +	return acpi_find_cache_node(table_hdr, acpi_cpu_id, CACHE_TYPE_INST,
> +				    level, node);
> +}
> +
>  /**
>   * update_cache_properties() - Update cacheinfo for the given processor
>   * @this_leaf: Kernel cache info structure being updated
> @@ -903,3 +924,64 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>  				     entry->length);
>  	}
>  }
> +
> +/*
> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> + * @cache_id: The id field of the cache
> + *
> + * Determine the level relative to any CPU for the cache identified by
> + * cache_id. This allows the property to be found even if the CPUs are offline.
> + *
> + * The returned level can be used to group caches that are peers.
> + *
> + * The PPTT table must be rev 3 or later.
> + *
> + * If one CPU's L2 is shared with another CPU as L3, this function will return
> + * an unpredictable value.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, the revision isn't supported or
> + * the cache cannot be found.
> + * Otherwise returns a value which represents the level of the specified cache.
> + */
> +int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	int level, cpu;
> +	u32 acpi_cpu_id;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_table_header *table;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
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
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id)
> +				return level;
> +
> +			level++;

If there is more than one type of cache at a given level only one is
checked. For example, if there is an L1 data cache and an L1 instruction
cache then the L1 instruction cache will never be considered.

> +			cache = acpi_find_any_type_cache_node(table, acpi_cpu_id,
> +							      level, &cpu_node);
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
Thanks,

Ben


