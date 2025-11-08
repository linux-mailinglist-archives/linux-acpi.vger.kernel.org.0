Return-Path: <linux-acpi+bounces-18683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663AC42743
	for <lists+linux-acpi@lfdr.de>; Sat, 08 Nov 2025 05:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49FA44E18F0
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Nov 2025 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178E285CB3;
	Sat,  8 Nov 2025 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKrx+32v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uLbvyqag"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6A2D063A
	for <linux-acpi@vger.kernel.org>; Sat,  8 Nov 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577708; cv=none; b=chkNfsWfZEb1uzjSJuO8wsO1oamRC/2A2sPjlNghHjH7dwIic6pC27+L2KcEbjPcz42z3YG8MXdwH2sJbOfrMAx2UsI+gdgSl1GVmrHu1ItoaCsltjqkDfu8tWhBJvUKGJlmKvHqYaGh1QX8bYGzBUp+7f3vbqUwp9sAwXvqO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577708; c=relaxed/simple;
	bh=fztmZ2NtnDGZ0i3RuA8+1RQoxH1Z4Y3n9GPoa8qnJj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAzt3qs/L4PAK/0DN6beMnNSnWAhC3c/1kIclzIfu+hpG61yStTjqWcOrAxXkUf0XrvgCAAabppEsqWQrVRKdicrB77hpp6mB2gbAQoFjKWBNFb2QcUt9uE4HLsWiLtgIJ3sc0kAPQym3ZhPcydqKfPh9fNk3vLfsfqOYRZzdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKrx+32v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uLbvyqag; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762577705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPnyFv8U6G66adg5n2qIg2Qs8rioO43BmGrTfO9DwVw=;
	b=RKrx+32vaaeIW1WquxE9Cf3Y80lPh337l5u71BGte3Rj5UhRc9hzdWPWDxLD19xJCexCgt
	06UJSb742+C/dSXWy6/CCcop/W0JgeQq1TL4pkCjo68YP6b0MUTg27Va4Xjbl86wSWtMYU
	Of7tilbXJDMRSRoL9ynSCmkEVgmO7mM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-mOE90QzbPYyI5pfRKKenIg-1; Fri, 07 Nov 2025 23:55:03 -0500
X-MC-Unique: mOE90QzbPYyI5pfRKKenIg-1
X-Mimecast-MFC-AGG-ID: mOE90QzbPYyI5pfRKKenIg_1762577703
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2952cb6f51bso35313325ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 20:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762577702; x=1763182502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPnyFv8U6G66adg5n2qIg2Qs8rioO43BmGrTfO9DwVw=;
        b=uLbvyqagyJBLJVQ7hW2oQDtx1ys7RiMZ3M9TmNXhq/DuXLlpgMalWTNQw/ueIsXsEW
         3hrhy56Q1nA4nQBfu/T1wUBprifJQCNcN5UwGta7oMr3eSAkzSvnWUHoTKULBMUwtP6P
         LqqgTWnXgwS06mHN7I2WtaT5Z0SJMyFa1vyCYAJh/0afYr8AO+r6DjcLqOflag17PP3y
         VlUBcV1ynD+rKmPTQdUZ/HeoZ3HxlERKh9X9P7yBnS+Up//xE/Me1JFMiUtqvD2BNz+i
         2y+TnhlT3wmRKhgpTVAsGpq3ROaPOdZQZhdN2gr9R0V95GvO4pJg7u5klm6tXkjI3vMs
         A1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762577702; x=1763182502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPnyFv8U6G66adg5n2qIg2Qs8rioO43BmGrTfO9DwVw=;
        b=luLxlvVE66hEerJvH9hhgU1acwdTn+fACudIQBINEW4sdNv9St+sOZ37bqMmWKRgF1
         +NQpDFv/YgadkP9GaA9vLtY+XMu+TEVs1v58i2D4kpTfM0QUqqna8UZnktuGoq5riYxd
         3wY51JEi/U00q6GOIEFvTD0nuPoC9biIYVCG3kgiwT5TrdFmdnHTU/xGc7rkYsSngBBO
         ofzZ36cyKULMcNpgMq8BS5OP5eXDKKDFYog3fDqftiaMYAztElCbNIWg8xpsns99S5xG
         B07At3jIuOCtTvy0uqHyqWgzPbCbXte66j4dJ4pqP7IeolPnAwpkydtvXz1uKt2W9b91
         nSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxmBXvSwqp5+E9SKgMQoM+ieGNvHF8MeIDEIO2OSJu3JUwkvLj7UjjTzK17I1aymXfFjumpn/4hLSP@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGuHPsfY14+sWRVrAaIYjWO0gG5MAnN5NRMkkYqqSa7j+EKLw
	ZVw4YKnqWVxO6dTdi3ditpMICC7SL1bZwR6YAdeS2vtHZeB/HWIzWQKWujxnXiInzeMs2cU2NUx
	+fykuGbr8+KQyYE1RRZxPFYfSWSV/KUJfXIX+9Hg2wAaP7qZPtY55G2nflztsztw=
X-Gm-Gg: ASbGncslg/NJK9E6U9hYzxcfOngSr21pzA/ODDpyFP7sFoKyatiOOhxfH6873NYs/DN
	W2jTmvbier2VxC5/tR/CpCS9E4bq9dA/P3yZEhfH3XMmlQxTXwUYGME/ZdOUFepXUUmKF4sKLwJ
	/QOVAeZLwM9EfCRQf5NIDaSttJyZndMaIbXxhi5UwOKAl0wvm3And60KhkHEeaty8supc+maLxs
	OP34G4Sw5TiJTNZeIDllBkaHz61rmd/SmX1DSinp9W0kCXeh4eHV7FEHRvLk0lsW3xkO1H4XaRu
	DgiPLqItHw/RJHzdA/KzdClwVV5ElHqADZJcnG/7BW3tlYei5TLrmOT4ANNa/kPTPyzV7B99lfz
	zdZuiPYULgWJJVZvJVhjAA8bQzBwLU0AUNqTNY/U=
X-Received: by 2002:a17:902:ecc5:b0:295:565b:c691 with SMTP id d9443c01a7336-297e5629152mr20796565ad.17.1762577702538;
        Fri, 07 Nov 2025 20:55:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGya/hov+kDTTbyz8MZCYFlylL8RVAqfShmc9QBbP+PajCzXW2szwcwQFDnifPj4C/Lm/ZDIw==
X-Received: by 2002:a17:902:ecc5:b0:295:565b:c691 with SMTP id d9443c01a7336-297e5629152mr20795995ad.17.1762577702044;
        Fri, 07 Nov 2025 20:55:02 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c31d86esm4320142a91.8.2025.11.07.20.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 20:55:01 -0800 (PST)
Message-ID: <04f4c2f6-19ff-413f-96fb-86432d53830e@redhat.com>
Date: Sat, 8 Nov 2025 14:54:48 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-4-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-4-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/7/25 10:34 PM, Ben Horgan wrote:
> In actbl2.h, struct acpi_pptt_cache describes the fields in the original
> cache type structure. In PPTT table version 3 a new field was added at the
> end, cache_id. This is described in struct acpi_pptt_cache_v1. Introduce
> the new, acpi_pptt_cache_v1_full to contain both these structures. Update
> the existing code to use this new struct. This simplifies the code, removes
> a non-standard use of ACPI_ADD_PTR and allows using the length in the
> header to check if the cache_id is valid.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> New patch
> ---
>   drivers/acpi/pptt.c | 104 ++++++++++++++++++++++++--------------------
>   1 file changed, 58 insertions(+), 46 deletions(-)
> 

Two nitpicks below. LGTM in either way.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 1027ca3566b1..1ed2099c0d1a 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,11 @@
>   #include <linux/cacheinfo.h>
>   #include <acpi/processor.h>
>   
> +struct acpi_pptt_cache_v1_full {
> +	struct acpi_pptt_cache		f;
> +	struct acpi_pptt_cache_v1	extra;
> +} __packed;
> +
>   static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>   							u32 pptt_ref)
>   {
> @@ -50,10 +55,24 @@ static struct acpi_pptt_processor *fetch_pptt_node(struct acpi_table_header *tab
>   	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
>   }
>   
> -static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_hdr,
> -						u32 pptt_ref)
> +static struct acpi_pptt_cache_v1_full *fetch_pptt_cache(struct acpi_table_header *table_hdr,
> +							u32 pptt_ref)
>   {
> -	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
> +	return (struct acpi_pptt_cache_v1_full *)fetch_pptt_subtable(table_hdr, pptt_ref);
> +}
> +
> +#define ACPI_PPTT_CACHE_V1_LEN sizeof(struct acpi_pptt_cache_v1_full)
> +
> +/*
> + * From PPTT table version 3, a new field cache_id was added at the end of
> + * the cache type structure.  We now use struct acpi_pptt_cache_v1_full,
> + * containing the cache_id, everywhere but must check validity before accessing
> + * the cache_id.
> + */
> +static bool acpi_pptt_cache_id_is_valid(struct acpi_pptt_cache_v1_full *cache)
> +{
> +	return (cache->f.header.length >= ACPI_PPTT_CACHE_V1_LEN &&
> +		cache->f.flags & ACPI_PPTT_CACHE_ID_VALID);
>   }
>   

This function is nice fit to 'inline'. Besides, I'm not sure if we can just
use sizeof(*cache) instead of ACPI_PPTT_CACHE_V1_LEN, which is used for once
in pptt.c

>   static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
> @@ -103,30 +122,30 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   					 unsigned int local_level,
>   					 unsigned int *split_levels,
>   					 struct acpi_subtable_header *res,
> -					 struct acpi_pptt_cache **found,
> +					 struct acpi_pptt_cache_v1_full **found,
>   					 unsigned int level, int type)
>   {
> -	struct acpi_pptt_cache *cache;
> +	struct acpi_pptt_cache_v1_full *cache;
>   
>   	if (res->type != ACPI_PPTT_TYPE_CACHE)
>   		return 0;
>   
> -	cache = (struct acpi_pptt_cache *) res;
> +	cache = (struct acpi_pptt_cache_v1_full *)res;
>   	while (cache) {
>   		local_level++;
>   
> -		if (!(cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
> -			cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
> +		if (!(cache->f.flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
> +			cache = fetch_pptt_cache(table_hdr, cache->f.next_level_of_cache);
>   			continue;
>   		}
>   
>   		if (split_levels &&
> -		    (acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_DATA) ||
> -		     acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
> +		    (acpi_pptt_match_type(cache->f.attributes, ACPI_PPTT_CACHE_TYPE_DATA) ||
> +		     acpi_pptt_match_type(cache->f.attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
>   			*split_levels = local_level;
>   
>   		if (local_level == level &&
> -		    acpi_pptt_match_type(cache->attributes, type)) {
> +		    acpi_pptt_match_type(cache->f.attributes, type)) {
>   			if (*found != NULL && cache != *found)
>   				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
>   
> @@ -138,12 +157,12 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   			 * cache node.
>   			 */
>   		}
> -		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
> +		cache = fetch_pptt_cache(table_hdr, cache->f.next_level_of_cache);
>   	}
>   	return local_level;
>   }
>   
> -static struct acpi_pptt_cache *
> +static struct acpi_pptt_cache_v1_full *
>   acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   		      struct acpi_pptt_processor *cpu_node,
>   		      unsigned int *starting_level, unsigned int *split_levels,
> @@ -152,7 +171,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   	struct acpi_subtable_header *res;
>   	unsigned int number_of_levels = *starting_level;
>   	int resource = 0;
> -	struct acpi_pptt_cache *ret = NULL;
> +	struct acpi_pptt_cache_v1_full *ret = NULL;
>   	unsigned int local_level;
>   
>   	/* walk down from processor node */
> @@ -324,14 +343,14 @@ static u8 acpi_cache_type(enum cache_type type)
>   	}
>   }
>   
> -static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *table_hdr,
> -						    u32 acpi_cpu_id,
> -						    enum cache_type type,
> -						    unsigned int level,
> -						    struct acpi_pptt_processor **node)
> +static struct acpi_pptt_cache_v1_full *acpi_find_cache_node(struct acpi_table_header *table_hdr,
> +							    u32 acpi_cpu_id,
> +							    enum cache_type type,
> +							    unsigned int level,
> +							    struct acpi_pptt_processor **node)
>   {
>   	unsigned int total_levels = 0;
> -	struct acpi_pptt_cache *found = NULL;
> +	struct acpi_pptt_cache_v1_full *found = NULL;
>   	struct acpi_pptt_processor *cpu_node;
>   	u8 acpi_type = acpi_cache_type(type);
>   
> @@ -355,7 +374,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>    * @this_leaf: Kernel cache info structure being updated
>    * @found_cache: The PPTT node describing this cache instance
>    * @cpu_node: A unique reference to describe this cache instance
> - * @revision: The revision of the PPTT table
>    *
>    * The ACPI spec implies that the fields in the cache structures are used to
>    * extend and correct the information probed from the hardware. Lets only
> @@ -364,23 +382,20 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>    * Return: nothing. Side effect of updating the global cacheinfo
>    */
>   static void update_cache_properties(struct cacheinfo *this_leaf,
> -				    struct acpi_pptt_cache *found_cache,
> -				    struct acpi_pptt_processor *cpu_node,
> -				    u8 revision)
> +				    struct acpi_pptt_cache_v1_full *found_cache,
> +				    struct acpi_pptt_processor *cpu_node)
>   {
> -	struct acpi_pptt_cache_v1* found_cache_v1;
> -
>   	this_leaf->fw_token = cpu_node;
> -	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> -		this_leaf->size = found_cache->size;
> -	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
> -		this_leaf->coherency_line_size = found_cache->line_size;
> -	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
> -		this_leaf->number_of_sets = found_cache->number_of_sets;
> -	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
> -		this_leaf->ways_of_associativity = found_cache->associativity;
> -	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
> -		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
> +	if (found_cache->f.flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> +		this_leaf->size = found_cache->f.size;
> +	if (found_cache->f.flags & ACPI_PPTT_LINE_SIZE_VALID)
> +		this_leaf->coherency_line_size = found_cache->f.line_size;
> +	if (found_cache->f.flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
> +		this_leaf->number_of_sets = found_cache->f.number_of_sets;
> +	if (found_cache->f.flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
> +		this_leaf->ways_of_associativity = found_cache->f.associativity;
> +	if (found_cache->f.flags & ACPI_PPTT_WRITE_POLICY_VALID) {
> +		switch (found_cache->f.attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>   		case ACPI_PPTT_CACHE_POLICY_WT:
>   			this_leaf->attributes = CACHE_WRITE_THROUGH;
>   			break;
> @@ -389,8 +404,8 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   			break;
>   		}
>   	}
> -	if (found_cache->flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
> -		switch (found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
> +	if (found_cache->f.flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
> +		switch (found_cache->f.attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
>   		case ACPI_PPTT_CACHE_READ_ALLOCATE:
>   			this_leaf->attributes |= CACHE_READ_ALLOCATE;
>   			break;
> @@ -415,13 +430,11 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   	 * specified in PPTT.
>   	 */
>   	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
> +	    found_cache->f.flags & ACPI_PPTT_CACHE_TYPE_VALID)
>   		this_leaf->type = CACHE_TYPE_UNIFIED;
>   
> -	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
> -		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> -	                                      found_cache, sizeof(struct acpi_pptt_cache));
> -		this_leaf->id = found_cache_v1->cache_id;
> +	if (acpi_pptt_cache_id_is_valid(found_cache)) {
> +		this_leaf->id = found_cache->extra.cache_id;
>   		this_leaf->attributes |= CACHE_ID;
>   	}
>   }
> @@ -429,7 +442,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>   				 unsigned int cpu)
>   {
> -	struct acpi_pptt_cache *found_cache;
> +	struct acpi_pptt_cache_v1_full *found_cache;
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>   	struct cacheinfo *this_leaf;
> @@ -445,8 +458,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>   		pr_debug("found = %p %p\n", found_cache, cpu_node);
>   		if (found_cache)
>   			update_cache_properties(this_leaf, found_cache,
> -						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> -						table->revision);
> +						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)));
>   
>   		index++;
>   	}

Thanks,
Gavin


