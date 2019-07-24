Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D72732D7
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2019 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfGXPfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jul 2019 11:35:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:24911 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfGXPfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jul 2019 11:35:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 08:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="345136302"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2019 08:35:23 -0700
Date:   Wed, 24 Jul 2019 09:32:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCHv2 1/2] hmat: Register memory-side cache after parsing
Message-ID: <20190724153228.GB5379@localhost.localdomain>
References: <20190515215444.22256-1-keith.busch@intel.com>
 <2816033.6i9P6v0dDn@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2816033.6i9P6v0dDn@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 13, 2019 at 01:27:05PM -0700, Rafael J. Wysocki wrote:
> On Wednesday, May 15, 2019 11:54:43 PM CEST Keith Busch wrote:
> > Instead of registering the hmat cache attributes in line with parsing
> > the table, save the attributes in the memory target and register them
> > after parsing completes. This will make it easier to register the
> > attributes later when hot add is supported.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> > v1 -> v2:
> > 
> >   Fixed multi-level caches, and no caches. v1 incorrectly assumed only a level
> >   1 always existed (Brice).
> > 
> >  drivers/acpi/hmat/hmat.c | 70 +++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 55 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> > index 96b7d39a97c6..bf23c9a27958 100644
> > --- a/drivers/acpi/hmat/hmat.c
> > +++ b/drivers/acpi/hmat/hmat.c
> > @@ -36,11 +36,17 @@ enum locality_types {
> >  
> >  static struct memory_locality *localities_types[4];
> >  
> > +struct target_cache {
> > +	struct list_head node;
> > +	struct node_cache_attrs cache_attrs;
> > +};
> > +
> >  struct memory_target {
> >  	struct list_head node;
> >  	unsigned int memory_pxm;
> >  	unsigned int processor_pxm;
> >  	struct node_hmem_attrs hmem_attrs;
> > +	struct list_head caches;
> >  };
> >  
> >  struct memory_initiator {
> > @@ -110,6 +116,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
> >  	target->memory_pxm = mem_pxm;
> >  	target->processor_pxm = PXM_INVAL;
> >  	list_add_tail(&target->node, &targets);
> > +	INIT_LIST_HEAD(&target->caches);
> >  }
> >  
> >  static __init const char *hmat_data_type(u8 type)
> > @@ -314,7 +321,8 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> >  				   const unsigned long end)
> >  {
> >  	struct acpi_hmat_cache *cache = (void *)header;
> > -	struct node_cache_attrs cache_attrs;
> > +	struct memory_target *target;
> > +	struct target_cache *tcache;
> >  	u32 attrs;
> >  
> >  	if (cache->header.length < sizeof(*cache)) {
> > @@ -328,37 +336,47 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> >  		cache->memory_PD, cache->cache_size, attrs,
> >  		cache->number_of_SMBIOShandles);
> >  
> > -	cache_attrs.size = cache->cache_size;
> > -	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> > -	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> > +	target = find_mem_target(cache->memory_PD);
> > +	if (!target)
> > +		return 0;
> > +
> > +	tcache = kzalloc(sizeof(*tcache), GFP_KERNEL);
> > +	if (!tcache) {
> > +		pr_notice_once("Failed to allocate HMAT cache info\n");
> > +		return 0;
> > +	}
> > +
> > +	tcache->cache_attrs.size = cache->cache_size;
> > +	tcache->cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> > +	tcache->cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> >  
> >  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
> >  	case ACPI_HMAT_CA_DIRECT_MAPPED:
> > -		cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> > +		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> >  		break;
> >  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> > -		cache_attrs.indexing = NODE_CACHE_INDEXED;
> > +		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
> >  		break;
> >  	case ACPI_HMAT_CA_NONE:
> >  	default:
> > -		cache_attrs.indexing = NODE_CACHE_OTHER;
> > +		tcache->cache_attrs.indexing = NODE_CACHE_OTHER;
> >  		break;
> >  	}
> >  
> >  	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
> >  	case ACPI_HMAT_CP_WB:
> > -		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> > +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> >  		break;
> >  	case ACPI_HMAT_CP_WT:
> > -		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> > +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> >  		break;
> >  	case ACPI_HMAT_CP_NONE:
> >  	default:
> > -		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> > +		tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> >  		break;
> >  	}
> > +	list_add_tail(&tcache->node, &target->caches);
> >  
> > -	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
> >  	return 0;
> >  }
> >  
> > @@ -577,20 +595,37 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
> >  	}
> >  }
> >  
> > +static __init void hmat_register_target_cache(struct memory_target *target)
> > +{
> > +	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> > +	struct target_cache *tcache;
> > +
> > +	list_for_each_entry(tcache, &target->caches, node)
> > +		node_add_cache(mem_nid, &tcache->cache_attrs);
> > +}
> > +
> >  static __init void hmat_register_target_perf(struct memory_target *target)
> >  {
> >  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> >  	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> >  }
> >  
> > +static __init void hmat_register_target(struct memory_target *target)
> > +{
> > +	if (!node_online(pxm_to_node(target->memory_pxm)))
> > +		return;
> > +
> > +	hmat_register_target_initiators(target);
> > +	hmat_register_target_cache(target);
> > +	hmat_register_target_perf(target);
> > +}
> > +
> >  static __init void hmat_register_targets(void)
> >  {
> >  	struct memory_target *target;
> >  
> > -	list_for_each_entry(target, &targets, node) {
> > -		hmat_register_target_initiators(target);
> > -		hmat_register_target_perf(target);
> > -	}
> > +	list_for_each_entry(target, &targets, node)
> > +		hmat_register_target(target);
> >  }
> >  
> >  static __init void hmat_free_structures(void)
> > @@ -598,8 +633,13 @@ static __init void hmat_free_structures(void)
> >  	struct memory_target *target, *tnext;
> >  	struct memory_locality *loc, *lnext;
> >  	struct memory_initiator *initiator, *inext;
> > +	struct target_cache *tcache, *cnext;
> >  
> >  	list_for_each_entry_safe(target, tnext, &targets, node) {
> > +		list_for_each_entry_safe(tcache, cnext, &target->caches, node) {
> > +			list_del(&tcache->node);
> > +			kfree(tcache);
> > +		}
> >  		list_del(&target->node);
> >  		kfree(target);
> >  	}
> > 
> 
> Not sure what to do with this patch and the next one in the series.
> 
> FWIW, they both are fine by me.
> 
> Also ISTR seeing them in a series from Dan. (?)

I see Dan provided a series for EFI specific purpose support, but I
didn't find anything else touching this part of the code. FWIW, Dan's
EFI series looks goot to me, and I can rebase the hot-add support this
series provides on top of that.
