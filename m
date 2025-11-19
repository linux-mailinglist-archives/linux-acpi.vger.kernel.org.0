Return-Path: <linux-acpi+bounces-19112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E9C70346
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9B70361416
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8734D4D2;
	Wed, 19 Nov 2025 16:25:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF82BE632;
	Wed, 19 Nov 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569544; cv=none; b=Dip7cMEosGqmS6RmFqhiRIqOGGFG5FyssmcyCSiU2QhgjrFMgrX+V2tIBuxssjbAchyMvrY2Z+PSbi8XRpp4I4W+O7OyTzQlSD4YlVyIBjRqAPzWB6u8zAdpLuOMZihw6aKGq799Ie8qJ9zPpyJS+sx0mGihpyAKpauG/mqrZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569544; c=relaxed/simple;
	bh=Ga0lixxhrYPZE4SSZzD+XzBKaMqZs4tC/kSZx/TQHXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTGYVwdDVjeb95vC096vvF/HnHrlMEqCbuN4SLdpMUItJRDzMXDSvYYuLOjZ+52WLKm4vqT1em7LivC9ZvJ92A9GyqjBIcjC8mUmIP0DXte1ddKUyuzT5EaPbfXrFNpgSHWh9ki9UCTtXICEhGcRJb8gRJsIXrMPJTuaRB88j8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B4BFEC;
	Wed, 19 Nov 2025 08:25:34 -0800 (PST)
Received: from [172.27.42.169] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BFC43F740;
	Wed, 19 Nov 2025 08:25:38 -0800 (PST)
Message-ID: <e08b021c-5db9-49a8-b95d-0b3f957fedca@arm.com>
Date: Wed, 19 Nov 2025 10:25:37 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/34] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
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
 <20251117170014.4113754-3-ben.horgan@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251117170014.4113754-3-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 10:59 AM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
> 
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
> 
> Get rid of the levels parameter, which has no remaining purpose.
> 
> Fix acpi_get_cache_info() to match.

Sure,

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>>
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> s/starting_level/current_level/ (Jonathan)
> ---
>   drivers/acpi/pptt.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index b8248c0092fe..2856254e29d7 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -177,14 +177,14 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   }
>   
>   /**
> - * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
> - * levels and split cache levels (data/instruction).
> + * acpi_count_levels() - Given a PPTT table, and a CPU node, count the
> + * total number of levels and split cache levels (data/instruction).
>    * @table_hdr: Pointer to the head of the PPTT table
>    * @cpu_node: processor node we wish to count caches for
> - * @levels: Number of levels if success.
>    * @split_levels:	Number of split cache levels (data/instruction) if
>    *			success. Can by NULL.
>    *
> + * Return: number of levels.
>    * Given a processor node containing a processing unit, walk into it and count
>    * how many levels exist solely for it, and then walk up each level until we hit
>    * the root node (ignore the package level because it may be possible to have
> @@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>    * split cache levels (data/instruction) that exist at each level on the way
>    * up.
>    */
> -static void acpi_count_levels(struct acpi_table_header *table_hdr,
> -			      struct acpi_pptt_processor *cpu_node,
> -			      unsigned int *levels, unsigned int *split_levels)
> +static int acpi_count_levels(struct acpi_table_header *table_hdr,
> +			     struct acpi_pptt_processor *cpu_node,
> +			     unsigned int *split_levels)
>   {
> +	int current_level = 0;
> +
>   	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, &current_level, split_levels, 0, 0);
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	} while (cpu_node);
> +
> +	return current_level;
>   }
>   
>   /**
> @@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>   	if (!cpu_node)
>   		return -ENOENT;
>   
> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
>   
>   	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>   		 *levels, split_levels ? *split_levels : -1);


