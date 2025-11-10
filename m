Return-Path: <linux-acpi+bounces-18734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EEC47D04
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A363188D4FC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED520277016;
	Mon, 10 Nov 2025 16:02:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6A274B35;
	Mon, 10 Nov 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790547; cv=none; b=b2cIgdgVpkxFqYQLLYpNOdHal0HTREhsmvdiwdswYbnhNbUoqtccfWIdCRrVEN8Am41ooJgp5Gv9OaN8Xxb6bf+n/yZ8RbOWM+t9+JpQjFXZXNVhPm9JCmOnTTmpfSYlFZmIBntv4RYokTmu9Fprel1s/Ik+aQhmzgVZGlOj3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790547; c=relaxed/simple;
	bh=xHY7+8k/4eXNUxPO00Ti1z04MrM/y7weYnCC8wx8yqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWkLZZVArMUg7VgcyszD0g9/dXzw9ji/I0dFKHM7Vfun9W1XVutR2ldRdQFesCkUO4HsURmhgr/lzUKv1HtL6sZi/TJouBeP1FAFYpPbzIsR6rdDJ2fvOoDHnwDDlGX73TDPbsWkpl0Q95ZAnesizEF8SSw7FCqvhjuojOgoLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4vYW71dQzJ46YC;
	Tue, 11 Nov 2025 00:01:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 704A31402FF;
	Tue, 11 Nov 2025 00:02:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:02:20 +0000
Date: Mon, 10 Nov 2025 16:02:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
Subject: Re: [PATCH 04/33] ACPI / PPTT: Find cache level by cache-id
Message-ID: <20251110160218.00001d65@huawei.com>
In-Reply-To: <20251107123450.664001-5-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-5-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:21 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

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
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

A few things inline.

> ---
> Changes since v3:
> Tags dropped due to rework
> Fallout/simplification from adding acpi_pptt_cache_v1_full
> Look for each cache type before incrementing level
> ---
>  drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 ++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 1ed2099c0d1a..71841c106020 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -918,3 +918,66 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>  				     entry->length);
>  	}
>  }
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
> +		bool not_empty = true;
> +		u32 acpi_cpu_id;
> +		struct acpi_pptt_cache_v1_full *cache;
> +		struct acpi_pptt_processor *cpu_node;
> +
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);

Might as well combine this one with declaration.

> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			continue;
> +
> +		for (int level = 1; not_empty; level++) {

This smells very much like a while loop rather than a for loop. Make
it a do/while and you can avoid the somewhat nasty setting not_empty = true
just to get in for first iteration.

		int level = 1;
		do {
			int cache_type[] = { CACHE_TYPE_INST, CACHE_TYPE_DATA, CACHE_TYPE_UNIFIED };

			not_empty = false;
			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
							     level, &cpu_node);
				if (!cache)
					continue;

				not_empty = true;

				if (acpi_pptt_cache_id_is_valid(cache) &&
				    cache->extra.cache_id == cache_id)
					return level;
			}
		} while (not_empty);

Maybe flip sense of that bool to be empty and !empty for the test.


> +			int cache_type[] = {CACHE_TYPE_INST, CACHE_TYPE_DATA, CACHE_TYPE_UNIFIED};
> +
> +			not_empty = false;
> +			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
> +				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
> +							     level, &cpu_node);
> +				if (!cache)
> +					continue;
> +
> +				not_empty = true;
> +
> +				if (acpi_pptt_cache_id_is_valid(cache) &&
> +				    cache->extra.cache_id == cache_id)
> +					return level;
> +			}
> +		}
> +	}
> +
> +	return -ENOENT;
> +}



