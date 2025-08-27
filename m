Return-Path: <linux-acpi+bounces-16105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E454B38054
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406EA363A7A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D134A32F;
	Wed, 27 Aug 2025 10:51:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD029A33E;
	Wed, 27 Aug 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291867; cv=none; b=LSAeUifq4Yr/Rebpbam/k07SuLjxpzCX+1/EHZHN3uEBCWDo1/Jb5syiyACYT8ONad4Ats71scheI4udB9udKDvSqo3b+a75qIZRUcKk9Y11dRERDm7ywXwlIFyCsSC6IFRHGMPgVifA1kSpQjxRT6aKZJCMmRhymFM/e+Khihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291867; c=relaxed/simple;
	bh=xGhFfyWh4KX+AimhvcHJiy92QfbQuckwtomVxT/PI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L19H43lHl0iOKFXd3nc88+KEAAKBIl29zofXzMkh0lS6goQ4wBV8xmiQYTU75JouO6J3DwJgam9DB8MrZcJwknsPb4kbx64rV0QWhdi/KWcI/PNepRCb1A/kjoMNi89e1/PfPD9ZgN2GOfVk2FooARWEgcjbMDabxUxzBWINP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9951688;
	Wed, 27 Aug 2025 03:50:56 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646113F738;
	Wed, 27 Aug 2025 03:50:59 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:50:56 +0100
From: Dave Martin <Dave.Martin@arm.com>
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
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 05/33] ACPI / PPTT: Find cache level by cache-id
Message-ID: <aK7jEMqM/FoB4ABW@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-6-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-6-james.morse@arm.com>

Hi,

On Fri, Aug 22, 2025 at 03:29:46PM +0000, James Morse wrote:
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
> Add a cleanup based free-ing mechanism for acpi_get_table().

Does this mean that the early secondaries must be spread out across the
whole topology so that everything can be probed?

(i.e., a random subset is no good?)

If so, is this documented somewhere, such as in booting.rst?


Maybe this is not a new requirement -- it's not an area that I'm very
familiar with.


> 
> CC: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * acpi_count_levels() now returns a value.
>  * Converted the table-get stuff to use Jonathan's cleanup helper.
>  * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>  drivers/acpi/pptt.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h | 17 ++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 8f9b9508acba..660457644a5b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -907,3 +907,67 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>  					  ACPI_PPTT_ACPI_IDENTICAL);
>  }
> +
> +/**
> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> + * @cache_id: The id field of the unified cache
> + *
> + * Determine the level relative to any CPU for the unified cache identified by
> + * cache_id. This allows the property to be found even if the CPUs are offline.
> + *
> + * The returned level can be used to group unified caches that are peers.
> + *
> + * The PPTT table must be rev 3 or later,
> + *
> + * If one CPUs L2 is shared with another as L3, this function will return
> + * an unpredictable value.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.

Nit: doesn't exist or its revision is too old.

> + * Otherwise returns a value which represents the level of the specified cache.
> + */
> +int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	u32 acpi_cpu_id;
> +	int level, cpu, num_levels;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);

acpi_get_pptt() ? (See comment on patch 3.)

Comments there also suggest that the acpi_put_table() may be
unnecessary, at least on some paths.

I haven't tried to understand the ins and outs of this.

> +
> +	if (IS_ERR(table))
> +		return PTR_ERR(table);
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	/*
> +	 * If we found the cache first, we'd still need to walk from each CPU
> +	 * to find the level...
> +	 */

^ Possibly confusing comment?  The cache id is the starting point for
calling this function.  Is there a world in which we are at this point
without first having found the cache node?

(If the comment is just a restatement of part of the kerneldoc
description, maybe just drop it.)

> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			return -ENOENT;
> +		num_levels = acpi_count_levels(table, cpu_node, NULL);

Is the initial call to acpi_count_levels() really needed here?

It feels a bit like we end up enumerating the whole topology two or
three times here; once to count how many levels there are, and then
again to examine the nodes, and once more inside acpi_find_cache_node().

Why can't we just walk until we run out of levels?


I may be missing some details of how these functions interact -- if
this is only run at probe time, compact, well-factored code is
more important than making things as fast as possible.

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
> index f97a9ff678cc..30c10b1dcdb2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h

[...]

> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>  void acpi_table_init_complete (void);
>  int acpi_table_init (void);
>  
> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> +{
> +	struct acpi_table_header *table;
> +	int status = acpi_get_table(signature, instance, &table);
> +
> +	if (ACPI_FAILURE(status))
> +		return ERR_PTR(-ENOENT);
> +	return table;
> +}

This feels like something that ought to exist already.  If not, why
not?  If so, are there open-coded versions of this spread around the
ACPI tree that should be ported to use it?

[...]

Cheers
---Dave

