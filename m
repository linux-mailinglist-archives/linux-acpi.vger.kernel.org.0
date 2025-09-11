Return-Path: <linux-acpi+bounces-16681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C36B537B1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61D4168E15
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82234AB16;
	Thu, 11 Sep 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE3RHdmV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301D31E11F;
	Thu, 11 Sep 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604444; cv=none; b=ZUTdZGwRxlQUUnMNHbXUHOnZZ4rTSYCxKLvKzN+McCpWQ8/WnTyPMUW0kLtWZi5tvet46I6zggh6Kj329+bwQ086KJz6PNigY51NoWYToNcNLiBdVZ/u0XqzdHRvWqg8K3Ghgh66s8IkG6nR7n4PS82yWwysJC1h2We4umCC2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604444; c=relaxed/simple;
	bh=D3N+Ef/rke9QWrb1MoCvscwdGllgA6s5GKc7E8KKB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMDwf8yeTZm99HJ592qpMjQ1DenST/OwdXeFZ2INppyyjE1I3B6ScsjnEwI7hdu0Je5W+WpHhF/PbjdLGiLy+t/Dr/KZY56C7HwgwSzNiqCT4gyMpMQnu4MXfLvuE4rsVYSWWu36CXOc7nV7Py1xQHYJzvbLo6FWdtCJO0/cRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE3RHdmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D8C4CEF0;
	Thu, 11 Sep 2025 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757604444;
	bh=D3N+Ef/rke9QWrb1MoCvscwdGllgA6s5GKc7E8KKB3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YE3RHdmVcPlTSLUiknlySzD6Op20ejQ4WJXsNd7CO6lEOWWSZq+rQIVhSKo4S9ctX
	 IdHrlgIrjs6zJlPOObObXjCT2hdgZL5PuPFBJwq8IomHnY+1XprlZ/tbeA0BAOmstP
	 4TRXIHwPZjauYgX/VuZNH/RXVy24xZYOIRwYhAW6QQfratDCqH8/PONWHBTQCmh7kE
	 u1OB1VCksyinkaJMOx79rIw6pInh5+aEpOuRupxDxZWRfIUC6KIRVPzQfvSCdiNTCo
	 yBJlKfbWGFPdvWeMCO00pjcri9bBWzXGZWAdR8VNHXhkE7pMt9jfyJp4K1mF5Gig9k
	 f7GSK6pQfvL2Q==
Date: Thu, 11 Sep 2025 17:27:12 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/29] ACPI / PPTT: Find cache level by cache-id
Message-ID: <aMLqUCRHebgh8HqQ@lpieralisi>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910204309.20751-4-james.morse@arm.com>

On Wed, Sep 10, 2025 at 08:42:43PM +0000, James Morse wrote:
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
> ---
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
>  drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 ++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 7af7d62597df..c5f2a51d280b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -904,3 +904,65 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>  				     entry->length);
>  	}
>  }
> +
> +/*
> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> + * @cache_id: The id field of the unified cache
> + *
> + * Determine the level relative to any CPU for the unified cache identified by
> + * cache_id. This allows the property to be found even if the CPUs are offline.
> + *
> + * The returned level can be used to group unified caches that are peers.
> + *
> + * The PPTT table must be rev 3 or later,

* The PPTT table must be rev 3 or later.

> + *
> + * If one CPUs L2 is shared with another as L3, this function will return
> + * an unpredictable value.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, the revision isn't supported or
> + * the cache cannot be found.
> + * Otherwise returns a value which represents the level of the specified cache.
> + */
> +int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	u32 acpi_cpu_id;
> +	int level, cpu, num_levels;
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
> +			return -ENOENT;

Same comment as in another patch - don't think you want to stop parsing
here.

> +		num_levels = acpi_count_levels(table, cpu_node, NULL);
> +
> +		/* Start at 1 for L1 */
> +		for (level = 1; level <= num_levels; level++) {
> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
> +						     level, &cpu_node);
> +			if (!cache)
> +				continue;
> +
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache,
> +						sizeof(struct acpi_pptt_cache));
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id)
> +				return level;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f97a9ff678cc..5bdca5546697 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1542,6 +1542,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
> +int find_acpi_cache_level_from_id(u32 cache_id);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>  {
> @@ -1565,6 +1566,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  }
>  static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>  						     cpumask_t *cpus) { }
> +static inline int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	return -EINVAL;

return -ENOENT;

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> +}
>  #endif
>  
>  void acpi_arch_init(void);
> -- 
> 2.39.5
> 

