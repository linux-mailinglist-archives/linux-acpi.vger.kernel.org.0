Return-Path: <linux-acpi+bounces-19114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94872C7039A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2B9E3C4CEB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5723B616;
	Wed, 19 Nov 2025 16:29:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF9274666;
	Wed, 19 Nov 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569787; cv=none; b=ApDzZO54JajJgd9vqZLUnSFdKgHV7lxscSNP4L9ZMe+Aye2Uwyck2O0lDFYyCxxnm7vStE7mHbg+xgixxuYGykCqZfw5c8UFggESGLSBx1lVYVhb4DLOSm09oXmrCZMZYKSmiwi+pSrwz2KZozcZxYMYDBuX1ipqJvUwWmITaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569787; c=relaxed/simple;
	bh=sSUjvWX+AW2NxsCyt/bd/Vnh3BVkDEepgfKNIknmwUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF79QGOOc0WVulNLhRrMW1052slGvDwY7/TABVIEssvlNnlg8yW0H3J5BezlLhRkzFp6Pq/XvYxECkOxXNhG/nuPX9B0NXIQFOXCBu8uygNLoEXW3itOP84ihgbrBqC68sDDymjAzdqhgL43ll3yQavZOhOIomOZQHFUE3KIO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99130FEC;
	Wed, 19 Nov 2025 08:29:36 -0800 (PST)
Received: from [172.27.42.169] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DEDB3F740;
	Wed, 19 Nov 2025 08:29:40 -0800 (PST)
Message-ID: <11fd2280-d251-4c34-9c52-3c854791f735@arm.com>
Date: Wed, 19 Nov 2025 10:29:39 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/34] ACPI / PPTT: Find cache level by cache-id
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-5-ben.horgan@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251117170014.4113754-5-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 10:59 AM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
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

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> ---
> Changes since v4:
> Initialise acpi_cpu_id at declaration
> Convert a for loop to do/while (Jonathan)
> Use new version of acpi_pptt_cache_v1_full
> 
> Changes since v3:
> Tags dropped due to rework
> Fallout/simplification from adding acpi_pptt_cache_v1_full
> Look for each cache type before incrementing level
> ---
>   drivers/acpi/pptt.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 53fde9bd8140..5b1e9e410204 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -932,3 +932,69 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>   				     entry->length);
>   	}
>   }
> +
> +/**
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
> +	int cpu;
> +	struct acpi_table_header *table;
> +
> +	table = acpi_get_pptt();
> +	if (!table)
> +		return -ENOENT;
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	for_each_possible_cpu(cpu) {
> +		bool empty;
> +		int level = 1;
> +		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		struct acpi_pptt_cache *cache;
> +		struct acpi_pptt_processor *cpu_node;
> +
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			continue;
> +
> +		do {
> +			int cache_type[] = {CACHE_TYPE_INST, CACHE_TYPE_DATA, CACHE_TYPE_UNIFIED};
> +
> +			empty = true;
> +			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
> +				struct acpi_pptt_cache_v1_full *cache_v1;
> +
> +				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
> +							     level, &cpu_node);
> +				if (!cache)
> +					continue;
> +
> +				empty = false;
> +
> +				cache_v1 = upgrade_pptt_cache(cache);
> +				if (cache_v1 && cache_v1->cache_id == cache_id)
> +					return level;
> +			}
> +			level++;
> +		} while (!empty);
> +	}
> +
> +	return -ENOENT;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4752ebd48132..be074bdfd4d1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1542,6 +1542,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
>   int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>   void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
> +int find_acpi_cache_level_from_id(u32 cache_id);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1565,6 +1566,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   }
>   static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>   						     cpumask_t *cpus) { }
> +static inline int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	return -ENOENT;
> +}
>   #endif
>   
>   void acpi_arch_init(void);


