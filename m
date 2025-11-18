Return-Path: <linux-acpi+bounces-19020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF1C6A20A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E8304F8A0F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1043590C0;
	Tue, 18 Nov 2025 14:40:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828E8F5B;
	Tue, 18 Nov 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476826; cv=none; b=IAK/2IY7gg72GDT+5/Oqe4+sqxms+i85N7U1Xc/8NvZtlxKiE4BCuvgd7A5b0aLcAWTcd8p9WDBJgmecd4sawhXJ0U5I8uSJ47m4qfq0595AJ6lMp4oju9bvUu/psnvcg9QvDrRbLRfGUOFIY6t+9lFhwPugp/u6qZ2i8UUngAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476826; c=relaxed/simple;
	bh=l8wrXMGM50CT1plOkwPmy71d0FV6WzKlbguXItCKABc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5lCgGvYhiihayLh1Dn/+ngV16P2gb7iy9vlBAcYKaHiNpzVPj7SUo4xc0tbwDF9j+J/iVR8mPG2M9EOTuUm54lQhUi9QoGeQup1zSjWO73wrxxxpA4RNXcbK4tljSbQcRqzvfxzwPu9NIdl5OmJO/jGkPjNQm7nsL7v8Nqw0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9nM734sVzHnH53;
	Tue, 18 Nov 2025 22:39:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 64D701402F3;
	Tue, 18 Nov 2025 22:40:18 +0800 (CST)
Received: from localhost (10.48.149.77) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Nov
 2025 14:40:16 +0000
Date: Tue, 18 Nov 2025 14:40:13 +0000
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
Subject: Re: [PATCH v5 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to
 use pptt cache as one structure
Message-ID: <20251118144013.000050c2@huawei.com>
In-Reply-To: <20251117170014.4113754-4-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
	<20251117170014.4113754-4-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 16:59:42 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> In actbl2.h, acpi_pptt_cache describes the fields in the original
> Cache Type Structure. In PPTT table version 3 a new field was added at the
> end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
> including all v1 fields it just includes this one.
> 
> In lieu of this being fixed in acpica, introduce acpi_pptt_cache_v1_full to
> contain all the fields of the Cache Type Structure . Update the existing
> code to use this new struct. This simplifies the code and removes a
> non-standard use of ACPI_ADD_PTR.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Hi Ben,

I'd like the change to land in ACPICA but if it doesn't this might need
a future rework to avoid long term duplication.  For now with the __packed
marking and a few formatting niggles (see inline) tidied up.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

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
>  drivers/acpi/pptt.c | 47 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 2856254e29d7..53fde9bd8140 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,25 @@
>  #include <linux/cacheinfo.h>
>  #include <acpi/processor.h>
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
>  static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>  							u32 pptt_ref)
>  {
> @@ -56,6 +75,18 @@ static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_
>  	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
>  }
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
>  static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
>  							   struct acpi_pptt_processor *node,
>  							   int resource)
> @@ -111,7 +142,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>  	if (res->type != ACPI_PPTT_TYPE_CACHE)
>  		return 0;
>  
> -	cache = (struct acpi_pptt_cache *) res;
> +	cache = (struct acpi_pptt_cache *)res;

Unrelated change..

>  	while (cache) {
>  		local_level++;
>  
> @@ -355,7 +386,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   * @this_leaf: Kernel cache info structure being updated
>   * @found_cache: The PPTT node describing this cache instance
>   * @cpu_node: A unique reference to describe this cache instance
> - * @revision: The revision of the PPTT table
>   *
>   * The ACPI spec implies that the fields in the cache structures are used to
>   * extend and correct the information probed from the hardware. Lets only
> @@ -365,10 +395,9 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   */
>  static void update_cache_properties(struct cacheinfo *this_leaf,
>  				    struct acpi_pptt_cache *found_cache,
> -				    struct acpi_pptt_processor *cpu_node,
> -				    u8 revision)
> +				    struct acpi_pptt_processor *cpu_node)
>  {
> -	struct acpi_pptt_cache_v1* found_cache_v1;
> +	struct acpi_pptt_cache_v1_full *found_cache_v1;
>  
>  	this_leaf->fw_token = cpu_node;
>  	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> @@ -418,9 +447,8 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>  	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>  		this_leaf->type = CACHE_TYPE_UNIFIED;
>  
> -	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
> -		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> -	                                      found_cache, sizeof(struct acpi_pptt_cache));
> +	found_cache_v1 =  upgrade_pptt_cache(found_cache);

extra space after =

> +	if (found_cache_v1) {
>  		this_leaf->id = found_cache_v1->cache_id;
>  		this_leaf->attributes |= CACHE_ID;
>  	}
> @@ -445,8 +473,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>  		pr_debug("found = %p %p\n", found_cache, cpu_node);
>  		if (found_cache)
>  			update_cache_properties(this_leaf, found_cache,
> -						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> -						table->revision);
> +						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)));
>  
>  		index++;
>  	}


