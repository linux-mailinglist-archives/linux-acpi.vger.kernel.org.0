Return-Path: <linux-acpi+bounces-4797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF889D221
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 08:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261C51F22B56
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47C6A8D2;
	Tue,  9 Apr 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XQdrfIcv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC74C69
	for <linux-acpi@vger.kernel.org>; Tue,  9 Apr 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643083; cv=none; b=aZHKXK+5Iq9f5hKXCtuMgwMQ7ub94Eq4Zbgsgo6rjbtae0TvyoXFGXeKnCPC/W03v5CoxPXWXr4dKAUrlRFkTFIcMtUJczp1gtn/h4/aHyDdvhbSdd9tGsaIx/MZZQS2Umsk0AH9pzHnLueZTbSYXJQF/OKpPxjpAV+ybIEc2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643083; c=relaxed/simple;
	bh=FeGJhwdCRoYiR7gWBRDEHf6ksBD8EYGCjDCGZB1cG1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pyJ3nasdll7XmcnVheSkUmsmii/Gq/GzmsvLZTSSu6VtwRA7iPF7WARDDWI+wjXjS9sPkZOffu9IlBkPBdS3tAmcjN34phGPyeqlP6w/jAYEYsZDpgE5XKkYEOwixdJ9KBOqKvlgEq3GAlpzhHxzK6hqYSYz/iR3A9q9eG8wIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XQdrfIcv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22a96054726so4700485fac.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712643079; x=1713247879; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBHuIUhNOhdsdT4E1VbYuT6s0TqYlSkEpMfCY4cxP8I=;
        b=XQdrfIcvgoi1Dg2XP37+n/69SkHbOIy5Wy7USaOoJBxt/TAZCGDfAKmQTVTK1sMwFp
         ceIzBs41ST5tKLhTZFHVD3E9eX62ynm5bGXvP59HD9xOsrBjp9Pk/iZ1FmLXGpao2LxI
         RcKULfVcL+XPsNWgeSBUxa58maGN86N3wEQvgrFcjG8qYwYC4JPdkGgCd07ruh0G/5+B
         fMTQLkyd4OzjOF0N2S2WQGTAjojnESyOjaKoiFQzd8zpDzk2z50dt4OHb2E0HFGIGRpI
         G7oNFEdbX9U/Op+cbaS7+gVAqYPO99NHwVK9fwvZEqc5WxfjkFuR5FBBU7cbjw5NrEFr
         1r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643079; x=1713247879;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBHuIUhNOhdsdT4E1VbYuT6s0TqYlSkEpMfCY4cxP8I=;
        b=gBeEr1JHjpeA5oYOT42uqGhFdEet7uGirlJYVhVb/9d6d0gOdK2YQ4eS7162I+AbJS
         SJRkJKCFpf+pJKhrvQAVAb6h4MVLEMn/uRPFFIcmrIVtlC4Paurf/fJRAIeAczMMj3vP
         xicYn1l594Ae24TenGlApYFp04EU/nEgawmWqMYY5Xvbz7AaiCwrxcat6PkFzFZn2xTD
         2HAsG2/pNTrxBzyg4ymxjbj1O5uGtQ+1cVccmNqPMO5BTKSZsMVEpcFcOXq3NnJF0i5P
         JanIQN2Wkysl5rMaziTkDy/dwycbmw6ShmclnMtCE0I8waeALQ7y4HT3BVU1iPzjsnvb
         bkrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvUs/HanNERyWN8ka+aGZuB4Y9io5eGEajXQdnyOFOuLdBBHE4MzU4LBiQ3rVZAg0H3KIGqeOXnbONv5L3kLHE0FNpM4wm7Jze9Q==
X-Gm-Message-State: AOJu0Yw0hVseG7mBhaYsdWSFekRJM7aS+rjs647y+I9RJJlI9Hovai6q
	tj8ZpHovk5qlKLIMRVqlCxo5jpUqBPoMf9Bod0Tj73/e2qwomPDTmHPkZ3PsmBELmhEt4P+neo3
	PajhA1xHkayB1X1sFKxu21kq2VJIcnI7gIqKmRw==
X-Google-Smtp-Source: AGHT+IFvudyBofLrHAmCHcvrirjTPeOh/LfBkROqNxC8jYZnxveaUfivrBknhs9HXAiY/b7ilrHkQVPl/uePqbz67jU=
X-Received: by 2002:a05:6870:d286:b0:22a:7c81:1e2e with SMTP id
 d6-20020a056870d28600b0022a7c811e2emr12163359oae.16.1712643078963; Mon, 08
 Apr 2024 23:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240407123829.36474-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 9 Apr 2024 14:11:07 +0800
Message-ID: <CAEEQ3wnsOJXEMspM=A1jLkuLC-Ny5DA0_W-8ngE6n-jiJcDEnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo entirely with PPTT
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added committers of pptt.c. Could you give some comments? thanks.

On Sun, Apr 7, 2024 at 8:39=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> When the type and level information of this_leaf cannot be obtained
> from arch, cacheinfo is completely filled in with the content of PPTT.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/acpi/pptt.c | 135 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 124 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index a35dd0e41c27..6c54fc8e3039 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,9 @@
>  #include <linux/cacheinfo.h>
>  #include <acpi/processor.h>
>
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache, struct acpi_tabl=
e_header *table,
> +                        int cpu, int level, int *index);
> +
>  static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_tabl=
e_header *table_hdr,
>                                                         u32 pptt_ref)
>  {
> @@ -77,6 +80,18 @@ static inline bool acpi_pptt_match_type(int table_type=
, int type)
>                 table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type);
>  }
>
> +static inline u32 get_cache_id(struct acpi_pptt_cache *cache)
> +{
> +       struct acpi_pptt_cache_v1 *cache_v1;
> +
> +       if (cache->flags & ACPI_PPTT_CACHE_ID_VALID) {
> +               cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +                                       cache, sizeof(struct acpi_pptt_ca=
che));
> +               return cache_v1->cache_id;
> +       }
> +       return 0;
> +}
> +
>  /**
>   * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cach=
e
>   * @table_hdr: Pointer to the head of the PPTT table
> @@ -104,7 +119,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                                          unsigned int *split_levels,
>                                          struct acpi_subtable_header *res=
,
>                                          struct acpi_pptt_cache **found,
> -                                        unsigned int level, int type)
> +                                        unsigned int level, int type, in=
t cpu, int *index)
>  {
>         struct acpi_pptt_cache *cache;
>
> @@ -125,7 +140,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                      acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CA=
CHE_TYPE_INSTR)))
>                         *split_levels =3D local_level;
>
> -               if (local_level =3D=3D level &&
> +               if (level && local_level =3D=3D level &&
>                     acpi_pptt_match_type(cache->attributes, type)) {
>                         if (*found !=3D NULL && cache !=3D *found)
>                                 pr_warn("Found duplicate cache level/type=
 unable to determine uniqueness\n");
> @@ -137,7 +152,9 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                          * to verify that we don't find a duplicate
>                          * cache node.
>                          */
> -               }
> +               } else
> +                       acpi_fill_cacheinfo(cache, table_hdr, cpu, local_=
level, index);
> +
>                 cache =3D fetch_pptt_cache(table_hdr, cache->next_level_o=
f_cache);
>         }
>         return local_level;
> @@ -147,7 +164,7 @@ static struct acpi_pptt_cache *
>  acpi_find_cache_level(struct acpi_table_header *table_hdr,
>                       struct acpi_pptt_processor *cpu_node,
>                       unsigned int *starting_level, unsigned int *split_l=
evels,
> -                     unsigned int level, int type)
> +                     unsigned int level, int type, int cpu, int *index)
>  {
>         struct acpi_subtable_header *res;
>         unsigned int number_of_levels =3D *starting_level;
> @@ -161,7 +178,8 @@ acpi_find_cache_level(struct acpi_table_header *table=
_hdr,
>
>                 local_level =3D acpi_pptt_walk_cache(table_hdr, *starting=
_level,
>                                                    split_levels, res, &re=
t,
> -                                                  level, type);
> +                                                  level, type, cpu, inde=
x);
> +
>                 /*
>                  * we are looking for the max depth. Since its potentiall=
y
>                  * possible for a given node to have resources with diffe=
ring
> @@ -197,7 +215,7 @@ static void acpi_count_levels(struct acpi_table_heade=
r *table_hdr,
>                               unsigned int *levels, unsigned int *split_l=
evels)
>  {
>         do {
> -               acpi_find_cache_level(table_hdr, cpu_node, levels, split_=
levels, 0, 0);
> +               acpi_find_cache_level(table_hdr, cpu_node, levels, split_=
levels, 0, 0, 0, NULL);
>                 cpu_node =3D fetch_pptt_node(table_hdr, cpu_node->parent)=
;
>         } while (cpu_node);
>  }
> @@ -316,6 +334,7 @@ static u8 acpi_cache_type(enum cache_type type)
>  }
>
>  static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_he=
ader *table_hdr,
> +                                                   int cpu,
>                                                     u32 acpi_cpu_id,
>                                                     enum cache_type type,
>                                                     unsigned int level,
> @@ -325,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(s=
truct acpi_table_header *ta
>         struct acpi_pptt_cache *found =3D NULL;
>         struct acpi_pptt_processor *cpu_node;
>         u8 acpi_type =3D acpi_cache_type(type);
> +       int index =3D 0;
>
>         pr_debug("Looking for CPU %d's level %u cache type %d\n",
>                  acpi_cpu_id, level, acpi_type);
> @@ -333,7 +353,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(s=
truct acpi_table_header *ta
>
>         while (cpu_node && !found) {
>                 found =3D acpi_find_cache_level(table_hdr, cpu_node,
> -                                             &total_levels, NULL, level,=
 acpi_type);
> +                                             &total_levels, NULL, level,=
 acpi_type, cpu, &index);
>                 *node =3D cpu_node;
>                 cpu_node =3D fetch_pptt_node(table_hdr, cpu_node->parent)=
;
>         }
> @@ -406,8 +426,14 @@ static void update_cache_properties(struct cacheinfo=
 *this_leaf,
>          * specified in PPTT.
>          */
>         if (this_leaf->type =3D=3D CACHE_TYPE_NOCACHE &&
> -           found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
> -               this_leaf->type =3D CACHE_TYPE_UNIFIED;
> +           found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) {
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_DATA))
> +                       this_leaf->type =3D CACHE_TYPE_DATA;
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_INSTR))
> +                       this_leaf->type =3D CACHE_TYPE_INST;
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_UNIFIED))
> +                       this_leaf->type =3D CACHE_TYPE_UNIFIED;
> +       }
>
>         if (revision >=3D 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_V=
ALID)) {
>                 found_cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_v1=
,
> @@ -417,19 +443,106 @@ static void update_cache_properties(struct cachein=
fo *this_leaf,
>         }
>  }
>
> +static bool cache_is_filled_id(struct acpi_pptt_cache *cache, int cpu)
> +{
> +       u32 id =3D get_cache_id(cache);
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +       struct cacheinfo *this_leaf;
> +       int index =3D 0;
> +
> +       while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +               this_leaf =3D this_cpu_ci->info_list + index;
> +               if (this_leaf->id =3D=3D id)
> +                       return true;
> +               index++;
> +       }
> +       return false;
> +}
> +
> +static bool cache_is_filled_content(struct acpi_pptt_cache *cache,
> +                                   struct acpi_table_header *table,
> +                                   int cpu, int level, u8 revision)
> +{
> +       struct acpi_pptt_processor *cpu_node;
> +       struct cacheinfo *this_leaf, *tleaf;
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +       struct cacheinfo tmp_leaf =3D {0};
> +       int index =3D 0;
> +
> +       cpu_node =3D acpi_find_processor_node(table, get_acpi_id_for_cpu(=
cpu));
> +       tleaf =3D &tmp_leaf;
> +       tleaf->level =3D level;
> +
> +       while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +               this_leaf =3D this_cpu_ci->info_list + index;
> +               update_cache_properties(tleaf, cache,
> +                                       ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu=
_node, table)),
> +                                       revision);
> +               if (!memcmp(this_leaf, tleaf, sizeof(struct cacheinfo)))
> +                       return true;
> +               index++;
> +       }
> +       return false;
> +}
> +
> +static bool cache_is_filled(struct acpi_pptt_cache *cache, struct acpi_t=
able_header *table,
> +                                  int cpu, int level)
> +{
> +       u8 revision =3D table->revision;
> +
> +       /*
> +        * If revision >=3D 3, compare the cacheid directly,
> +        * otherwise compare the entire contents of the cache.
> +        */
> +       if (revision >=3D 3)
> +               return cache_is_filled_id(cache, cpu);
> +       else
> +               return cache_is_filled_content(cache, table, cpu, level, =
revision);
> +}
> +
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache,
> +                               struct acpi_table_header *table,
> +                               int cpu, int level, int *index)
> +{
> +       struct cacheinfo *this_leaf;
> +       struct acpi_pptt_processor *cpu_node;
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +
> +       if (!index)
> +               return;
> +
> +       cpu_node =3D acpi_find_processor_node(table, get_acpi_id_for_cpu(=
cpu));
> +       this_leaf =3D this_cpu_ci->info_list + *index;
> +       if (this_leaf) {
> +               this_leaf->level =3D level;
> +               if (cache_is_filled(cache, table, cpu, level))
> +                       return;
> +               update_cache_properties(this_leaf, cache,
> +                                       ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu=
_node,
> +                                                       table)),
> +                                       table->revision);
> +               *index +=3D 1;
> +       }
> +}
> +
>  static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>                                  unsigned int cpu)
>  {
>         struct acpi_pptt_cache *found_cache;
>         struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>         u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> -       struct cacheinfo *this_leaf;
> +       struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
>         unsigned int index =3D 0;
>         struct acpi_pptt_processor *cpu_node =3D NULL;
>
> +       if (!this_leaf->type && !this_leaf->level) {
> +               acpi_find_cache_node(table, acpi_cpu_id, cpu, 0, 0, &cpu_=
node);
> +               return;
> +       }
> +
>         while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
>                 this_leaf =3D this_cpu_ci->info_list + index;
> -               found_cache =3D acpi_find_cache_node(table, acpi_cpu_id,
> +               found_cache =3D acpi_find_cache_node(table, acpi_cpu_id, =
cpu,
>                                                    this_leaf->type,
>                                                    this_leaf->level,
>                                                    &cpu_node);
> --
> 2.20.1
>

Thanks,
Yunhui

