Return-Path: <linux-acpi+bounces-19113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C1C703AF
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58C8A3C4792
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D262365A04;
	Wed, 19 Nov 2025 16:29:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD56327C0C;
	Wed, 19 Nov 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569742; cv=none; b=ivJ0iuM80hjUz6CGUtgrkyLMRX4tNlEuZf37mzMV8F8x6XDwKhU/MZUCaixc8721eLXWbCOacSmvU1RYcqzt+lNQ8/hTX2GS+TT69+bziFuzi9ljXYE3Lyc3yZbNE/OhKzDWSl8uqHJoVpnenX0QyLnuuTxz0s0gtx5P33GVO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569742; c=relaxed/simple;
	bh=CbPl1GcCTT9GBH1V91ksu+RqYmqIugRN1KAFeIcAw2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyPcouYBlFsSSPmiZsM3/mZQRkfYUcmNysCK4fqKX0oDyUFBanp+GEusR8k+lRs+c10ubIWI8kpFObngJtVjZdJurxlsTG/UwFH0B9MyJNBl16ku5hOqBHBV4i0JeFjT7Z0eLkqPcfCNjxQjDkHg5nSyRGpN5BG3K6YxyoDozVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D597AFEC;
	Wed, 19 Nov 2025 08:28:51 -0800 (PST)
Received: from [172.27.42.169] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9473F740;
	Wed, 19 Nov 2025 08:28:57 -0800 (PST)
Message-ID: <5926591f-81aa-4953-9d80-bc85d3ce754f@arm.com>
Date: Wed, 19 Nov 2025 10:28:57 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-4-ben.horgan@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251117170014.4113754-4-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 10:59 AM, Ben Horgan wrote:
> In actbl2.h, acpi_pptt_cache describes the fields in the original
> Cache Type Structure. In PPTT table version 3 a new field was added at the
> end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
> including all v1 fields it just includes this one.
> 
> In lieu of this being fixed in acpica, introduce acpi_pptt_cache_v1_full to
> contain all the fields of the Cache Type Structure . Update the existing
> code to use this new struct. This simplifies the code and removes a
> non-standard use of ACPI_ADD_PTR.

To me, reading the code its a lot clearer that there is a version 
difference in the subtable this way.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> I have opened a pull request to acpica to update acpi_pptt_cache_v1 to
> include all fields. https://github.com/acpica/acpica/pull/1059
> 
> Change since v4:
> Use fields directly in acpi_pptt_cache_v1_full
> Delay the casting
> 
> Changes since v3:
> New patch
> ---
>   drivers/acpi/pptt.c | 47 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 2856254e29d7..53fde9bd8140 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,25 @@
>   #include <linux/cacheinfo.h>
>   #include <acpi/processor.h>
>   
> +/*
> + * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
> + * only contains the cache_id field rather than all the fields of the
> + * Cache Type Structure. Use this alternative structure until it is
> + * resolved in acpica.
> + */
> +struct acpi_pptt_cache_v1_full {
> +	struct acpi_subtable_header header;
> +	u16 reserved;
> +	u32 flags;
> +	u32 next_level_of_cache;
> +	u32 size;
> +	u32 number_of_sets;
> +	u8 associativity;
> +	u8 attributes;
> +	u16 line_size;
> +	u32 cache_id;
> +};
> +
>   static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>   							u32 pptt_ref)
>   {
> @@ -56,6 +75,18 @@ static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_
>   	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
>   }
>   
> +static struct acpi_pptt_cache_v1_full *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
> +{
> +	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1_full))
> +		return NULL;
> +
> +	/* No use for v1 if the only additional field is invalid */
> +	if (!(cache->flags & ACPI_PPTT_CACHE_ID_VALID))
> +		return NULL;
> +
> +	return (struct acpi_pptt_cache_v1_full *)cache;
> +}
> +
>   static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
>   							   struct acpi_pptt_processor *node,
>   							   int resource)
> @@ -111,7 +142,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   	if (res->type != ACPI_PPTT_TYPE_CACHE)
>   		return 0;
>   
> -	cache = (struct acpi_pptt_cache *) res;
> +	cache = (struct acpi_pptt_cache *)res;
>   	while (cache) {
>   		local_level++;
>   
> @@ -355,7 +386,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>    * @this_leaf: Kernel cache info structure being updated
>    * @found_cache: The PPTT node describing this cache instance
>    * @cpu_node: A unique reference to describe this cache instance
> - * @revision: The revision of the PPTT table
>    *
>    * The ACPI spec implies that the fields in the cache structures are used to
>    * extend and correct the information probed from the hardware. Lets only
> @@ -365,10 +395,9 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>    */
>   static void update_cache_properties(struct cacheinfo *this_leaf,
>   				    struct acpi_pptt_cache *found_cache,
> -				    struct acpi_pptt_processor *cpu_node,
> -				    u8 revision)
> +				    struct acpi_pptt_processor *cpu_node)
>   {
> -	struct acpi_pptt_cache_v1* found_cache_v1;
> +	struct acpi_pptt_cache_v1_full *found_cache_v1;
>   
>   	this_leaf->fw_token = cpu_node;
>   	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> @@ -418,9 +447,8 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>   		this_leaf->type = CACHE_TYPE_UNIFIED;
>   
> -	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
> -		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> -	                                      found_cache, sizeof(struct acpi_pptt_cache));
> +	found_cache_v1 =  upgrade_pptt_cache(found_cache);
> +	if (found_cache_v1) {
>   		this_leaf->id = found_cache_v1->cache_id;
>   		this_leaf->attributes |= CACHE_ID;
>   	}
> @@ -445,8 +473,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>   		pr_debug("found = %p %p\n", found_cache, cpu_node);
>   		if (found_cache)
>   			update_cache_properties(this_leaf, found_cache,
> -						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> -						table->revision);
> +						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)));
>   
>   		index++;
>   	}


