Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF75B6E6
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfGAIdu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 04:33:50 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4068 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbfGAIdu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 04:33:50 -0400
X-IronPort-AV: E=Sophos;i="5.63,438,1557180000"; 
   d="scan'208";a="389828722"
Received: from unknown (HELO [193.50.110.202]) ([193.50.110.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA; 01 Jul 2019 10:33:47 +0200
Subject: Re: [PATCHv2 1/2] hmat: Register memory-side cache after parsing
To:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20190515215444.22256-1-keith.busch@intel.com>
From:   Brice Goglin <Brice.Goglin@inria.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a53c087-8210-b344-ef70-06e90c1a88b8@inria.fr>
Date:   Mon, 1 Jul 2019 10:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190515215444.22256-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Le 15/05/2019 à 23:54, Keith Busch a écrit :
> Instead of registering the hmat cache attributes in line with parsing
> the table, save the attributes in the memory target and register them
> after parsing completes. This will make it easier to register the
> attributes later when hot add is supported.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>


Sorry for the delay, I finally manage these two patches, they work fine
(tested with a fake HMAT saying that a kmem-hotplug NVDIMM node is local
to 2 initiators among 4 total, and saying that there are 2 memory-side
caches in front of that NVDIMM node).

Tested-by: Brice Goglin <Brice.Goglin@inria.fr>


> ---
> v1 -> v2:
>
>   Fixed multi-level caches, and no caches. v1 incorrectly assumed only a level
>   1 always existed (Brice).
>
>  drivers/acpi/hmat/hmat.c | 70 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 96b7d39a97c6..bf23c9a27958 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -36,11 +36,17 @@ enum locality_types {
>  
>  static struct memory_locality *localities_types[4];
>  
> +struct target_cache {
> +	struct list_head node;
> +	struct node_cache_attrs cache_attrs;
> +};
> +
>  struct memory_target {
>  	struct list_head node;
>  	unsigned int memory_pxm;
>  	unsigned int processor_pxm;
>  	struct node_hmem_attrs hmem_attrs;
> +	struct list_head caches;
>  };
>  
>  struct memory_initiator {
> @@ -110,6 +116,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
>  	target->memory_pxm = mem_pxm;
>  	target->processor_pxm = PXM_INVAL;
>  	list_add_tail(&target->node, &targets);
> +	INIT_LIST_HEAD(&target->caches);
>  }
>  
>  static __init const char *hmat_data_type(u8 type)
> @@ -314,7 +321,8 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  				   const unsigned long end)
>  {
>  	struct acpi_hmat_cache *cache = (void *)header;
> -	struct node_cache_attrs cache_attrs;
> +	struct memory_target *target;
> +	struct target_cache *tcache;
>  	u32 attrs;
>  
>  	if (cache->header.length < sizeof(*cache)) {
> @@ -328,37 +336,47 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  		cache->memory_PD, cache->cache_size, attrs,
>  		cache->number_of_SMBIOShandles);
>  
> -	cache_attrs.size = cache->cache_size;
> -	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> -	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> +	target = find_mem_target(cache->memory_PD);
> +	if (!target)
> +		return 0;
> +
> +	tcache = kzalloc(sizeof(*tcache), GFP_KERNEL);
> +	if (!tcache) {
> +		pr_notice_once("Failed to allocate HMAT cache info\n");
> +		return 0;
> +	}
> +
> +	tcache->cache_attrs.size = cache->cache_size;
> +	tcache->cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> +	tcache->cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
>  
>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
> -		cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> +		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>  		break;
>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> -		cache_attrs.indexing = NODE_CACHE_INDEXED;
> +		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
>  		break;
>  	case ACPI_HMAT_CA_NONE:
>  	default:
> -		cache_attrs.indexing = NODE_CACHE_OTHER;
> +		tcache->cache_attrs.indexing = NODE_CACHE_OTHER;
>  		break;
>  	}
>  
>  	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
>  	case ACPI_HMAT_CP_WB:
> -		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
>  		break;
>  	case ACPI_HMAT_CP_WT:
> -		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
>  		break;
>  	case ACPI_HMAT_CP_NONE:
>  	default:
> -		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
>  		break;
>  	}
> +	list_add_tail(&tcache->node, &target->caches);
>  
> -	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
>  	return 0;
>  }
>  
> @@ -577,20 +595,37 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>  	}
>  }
>  
> +static __init void hmat_register_target_cache(struct memory_target *target)
> +{
> +	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> +	struct target_cache *tcache;
> +
> +	list_for_each_entry(tcache, &target->caches, node)
> +		node_add_cache(mem_nid, &tcache->cache_attrs);
> +}
> +
>  static __init void hmat_register_target_perf(struct memory_target *target)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
>  	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>  
> +static __init void hmat_register_target(struct memory_target *target)
> +{
> +	if (!node_online(pxm_to_node(target->memory_pxm)))
> +		return;
> +
> +	hmat_register_target_initiators(target);
> +	hmat_register_target_cache(target);
> +	hmat_register_target_perf(target);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>  	struct memory_target *target;
>  
> -	list_for_each_entry(target, &targets, node) {
> -		hmat_register_target_initiators(target);
> -		hmat_register_target_perf(target);
> -	}
> +	list_for_each_entry(target, &targets, node)
> +		hmat_register_target(target);
>  }
>  
>  static __init void hmat_free_structures(void)
> @@ -598,8 +633,13 @@ static __init void hmat_free_structures(void)
>  	struct memory_target *target, *tnext;
>  	struct memory_locality *loc, *lnext;
>  	struct memory_initiator *initiator, *inext;
> +	struct target_cache *tcache, *cnext;
>  
>  	list_for_each_entry_safe(target, tnext, &targets, node) {
> +		list_for_each_entry_safe(tcache, cnext, &target->caches, node) {
> +			list_del(&tcache->node);
> +			kfree(tcache);
> +		}
>  		list_del(&target->node);
>  		kfree(target);
>  	}
