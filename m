Return-Path: <linux-acpi+bounces-16588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B3B51CF9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0420188F257
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970632CF8D;
	Wed, 10 Sep 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfb4T/+p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A027FD76;
	Wed, 10 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520415; cv=none; b=p9sOFCX+Jv34EWVzvy06bkDHZ5yBC3SmhwskTK92di9iJ0ZE0BEI3RLnxGTRCfbTYH9R9cwIV7hiC2gt7IK85r4RABCBIQ88IGtGrLiBZdjsGJ6dk41N03No9HkUavwxk2zbF8nGDK1/4NrkHeP1zOE157XrnYHcMbhftTADVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520415; c=relaxed/simple;
	bh=0ooNVu3F20yZdC3hfz1jJzemZmywCH1k+H09byp5PdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7NTisjF+Kog9filt+c83HUKbPADhQNVpPboKpVSCTNWP6SKmk43ewKkTNi3wafVbNpD9OY5rxHVEEIYgWqZyCLVvQB3dCOmZciJuAzbesL7eb0asm/ypfxXXBZLFqX0G3GsBcJ9PK4UhLWzc71apD6yJ1Z1fdMjv6Y2c3flMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfb4T/+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C1C4CEEB;
	Wed, 10 Sep 2025 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757520414;
	bh=0ooNVu3F20yZdC3hfz1jJzemZmywCH1k+H09byp5PdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pfb4T/+pssSgLi25U86efr3/B4u8s7pNigHOOiiLtRRI81hz0MHI1cOhYcjBAf+J6
	 NEQ8VFloRbZfcBAfRtu0dm/peHdta2U5lPjsu/a5blQ13OtnYD4E7/7BbrM6d3VBHy
	 Z5/q26Y8QaqWxlMkepl6s5KH1sj60bzhbbBnlp0LA91vdYN5+CidsLQkg9WhIht54e
	 FzNCELDzFQB8KCr801OtkRvNkpqW/XWdIeYU3RUuNTOhZGcOz8Xu3ZJX9ckVGYHYl8
	 mWm0xD4dqt+Fk9HE6J713KbBf4aBp+nm5k9VPBJVjO65kx5LINJz+GAP29Ew0ZSIh4
	 0TqnDD/GEYfsQ==
Date: Wed, 10 Sep 2025 18:06:43 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
Message-ID: <aMGiE10e/MAlghGw@lpieralisi>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-41-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-41-james.morse@arm.com>

On Fri, Aug 22, 2025 at 03:30:21PM +0000, James Morse wrote:
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> 
> The driver needs to know which CPUs are associated with the cache,
> the CPUs may not all be online, so cacheinfo does not have the
> information.
> 
> Add a helper to pull this information out of the PPTT.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Changes since RFC:
>  * acpi_count_levels() now returns a value.
>  * Converted the table-get stuff to use Jonathan's cleanup helper.
>  * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>  drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  6 +++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 660457644a5b..cb93a9a7f9b6 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -971,3 +971,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>  
>  	return -ENOENT;
>  }
> +
> +/**
> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
> + *					   specified cache
> + * @cache_id: The id field of the unified cache
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
> +	u32 acpi_cpu_id;
> +	int level, cpu, num_levels;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);
> +
> +	cpumask_clear(cpus);
> +
> +	if (IS_ERR(table))
> +		return -ENOENT;
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	/*
> +	 * If we found the cache first, we'd still need to walk from each cpu.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			return 0;

If for a possible cpu you don't get an acpi_pptt_processor node we return 0,
is that correct ? Should not the loop continue ? Forgive me if that's a
dumb question.

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
> +				cpumask_set_cpu(cpu, cpus);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 30c10b1dcdb2..4ad08f5f1d83 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1555,6 +1555,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>  int find_acpi_cache_level_from_id(u32 cache_id);
> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>  {
> @@ -1582,6 +1583,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
>  {
>  	return -EINVAL;
>  }
> +static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
> +						      cpumask_t *cpus)
> +{
> +	return -EINVAL;

Nit: You might want the return value here to be coherent with what the function
documentation states (ie return -ENOENT;)

Other than that:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> +}
>  #endif
>  
>  void acpi_arch_init(void);
> -- 
> 2.20.1
> 

