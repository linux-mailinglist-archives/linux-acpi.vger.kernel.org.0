Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78539F4AD
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHLN5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:13:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFHLN5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 07:13:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fznct061wz9sW7;
        Tue,  8 Jun 2021 21:11:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623150723;
        bh=h1pjcx14WED8GV61yyvX+o5nh/QO2vDigglGzaBUaPo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qaYxKhntxn9domJfTp/b7vZheGgvSG04qAi3oPZszcrG9xJ8L8BtLeFBDdkNbhfRZ
         X8AJHokX7Us9uk+OIikdyp8VwCVfcmpt0jHbXBsbfQ+HEwfgLRBxW3k7uXH4jT5QAg
         8xQpuppzCCGEv/fkG3Q1MEqEdqwDa3GgrXCwBwQ3bGGeK2M1OuWRxuc0qtkEr1keBz
         fDJQZ6qLeVUxjcpDY8AtdZZU3JvH1MC5Y3w/lLqHwiFCGx13AS18HU2Ir33OkNpg2k
         8GyFRxa0K5NYJybxWne97z3ZMcKKDCCW4J0WeaoO69Q+XrReDs4uvXduZSTclQX4ku
         hnEBus8PGkG1w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
In-Reply-To: <20210607195430.48228-6-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com>
Date:   Tue, 08 Jun 2021 21:11:57 +1000
Message-ID: <87y2bkehky.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> There is only a single user remaining. We can simply try to offline all
> online nodes - which is fast, because we usually span pages and can skip
> such nodes right away.

That makes me slightly nervous, because our big powerpc boxes tend to
trip on these scaling issues before others.

But the spanned pages check is just:

void try_offline_node(int nid)
{
	pg_data_t *pgdat = NODE_DATA(nid);
        ...
	if (pgdat->node_spanned_pages)
		return;

So I guess that's pretty cheap, and it's only O(nodes), which should
never get that big.

> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Scott Cheloha <cheloha@linux.ibm.com>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-acpi@vger.kernel.org
> Cc: nvdimm@lists.linux.dev
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../platforms/pseries/hotplug-memory.c        |  9 ++++-----
>  drivers/acpi/acpi_memhotplug.c                |  7 +------
>  drivers/dax/kmem.c                            |  3 +--
>  drivers/virtio/virtio_mem.c                   |  4 ++--
>  include/linux/memory_hotplug.h                | 10 +++++-----
>  mm/memory_hotplug.c                           | 20 +++++++++----------
>  6 files changed, 23 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..4a9232ddbefe 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -286,7 +286,7 @@ static int pseries_remove_memblock(unsigned long base, unsigned long memblock_si
>  {
>  	unsigned long block_sz, start_pfn;
>  	int sections_per_block;
> -	int i, nid;
> +	int i;
>  
>  	start_pfn = base >> PAGE_SHIFT;
>  
> @@ -297,10 +297,9 @@ static int pseries_remove_memblock(unsigned long base, unsigned long memblock_si
>  
>  	block_sz = pseries_memory_block_size();
>  	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> -	nid = memory_add_physaddr_to_nid(base);
>  
>  	for (i = 0; i < sections_per_block; i++) {
> -		__remove_memory(nid, base, MIN_MEMORY_BLOCK_SIZE);
> +		__remove_memory(base, MIN_MEMORY_BLOCK_SIZE);
>  		base += MIN_MEMORY_BLOCK_SIZE;
>  	}
>  
> @@ -386,7 +385,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  
>  	block_sz = pseries_memory_block_size();
>  
> -	__remove_memory(mem_block->nid, lmb->base_addr, block_sz);
> +	__remove_memory(lmb->base_addr, block_sz);
>  	put_device(&mem_block->dev);
>  
>  	/* Update memory regions for memory remove */
> @@ -638,7 +637,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  
>  	rc = dlpar_online_lmb(lmb);
>  	if (rc) {
> -		__remove_memory(nid, lmb->base_addr, block_sz);
> +		__remove_memory(lmb->base_addr, block_sz);
>  		invalidate_lmb_associativity_index(lmb);
>  	} else {
>  		lmb->flags |= DRCONF_MEM_ASSIGNED;


Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
