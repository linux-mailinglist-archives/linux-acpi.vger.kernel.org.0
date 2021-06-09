Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39C3A10D3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhFIKHB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 06:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235927AbhFIKHB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 06:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623233106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHwERDV3Ik2w6kA7FU7L2RqGuM08Lzd2/FD6Wyr2HFk=;
        b=JZURtaSroKXVbV9oEJA8odheSETiD/feGshvORh/TDtHTyw8jMe047+yeP7I6Yoph/WhUI
        Oop9ox6VYzzKURis3iGLztgTSf19wraJErJeLqUUAe2qwKKEJ7O6LsLI5lpBvA4LUWx4ra
        RTwpkcX0BR8AUm0a5CBuECDMG0WRNiQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-T4J0GqQ0NZyHtinX5pdtvw-1; Wed, 09 Jun 2021 06:05:05 -0400
X-MC-Unique: T4J0GqQ0NZyHtinX5pdtvw-1
Received: by mail-wr1-f72.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so10581873wrq.10
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 03:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RHwERDV3Ik2w6kA7FU7L2RqGuM08Lzd2/FD6Wyr2HFk=;
        b=MqCRSGNiFzGXr1+iMEuhWV2FiBtpb7zsNhmj6D01nZzzZ9+mgxufEV5f+jeyM3jkvr
         EoF35pbUSkenC8vNv+lGGpPaL365SZOQA+YYQINqk9rES9TRML5AOxtgbuc9mMYzMFHc
         UOZ3xVRm9h+JY3sPb1MBPve4yxvBKSIJduG0bY/vUXaTxx53Ka/Fj6S2/S5GHubTYknw
         6SLA2m6E7vpWvm9gJX09QdQZk+N8uf9IqtBqXgxVPOHgPZYu5Up95OTvjbawGeGHXAWG
         7N7OQHfoyn1Qj+HsK1SajZrjeG2ufzgb9BHOpFO5goBQPb8CHYKcfID4is3vF8q6E0r1
         yoOg==
X-Gm-Message-State: AOAM53153vIr3ZYdhbBa7xYqYqL1dApSF3Kblr3FciAk1pK1hLO3948D
        gtgMOB712T1t9aOIFMLmJt1hSmt6ycJGyw9oJTd+a9N7BA5d4lzsP/CCdJb//5htjac0UrSinBr
        h57PzMGlzrcBHvkwbfa2CcA==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr26997709wrk.216.1623233103791;
        Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxisdlmQ9hbEJc7XyIIogfmbAP40COfOWXq53QTDVV5O2yA236wwdWl7PrbHqWMhmbVzLyEcw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr26997662wrk.216.1623233103520;
        Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id l31sm9209629wms.31.2021.06.09.03.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
From:   David Hildenbrand <david@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com> <87y2bkehky.fsf@mpe.ellerman.id.au>
 <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Organization: Red Hat
Message-ID: <fe3e8d93-4e69-84c5-3dd3-ab4aca3317ab@redhat.com>
Date:   Wed, 9 Jun 2021 12:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08.06.21 13:18, David Hildenbrand wrote:
> On 08.06.21 13:11, Michael Ellerman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> There is only a single user remaining. We can simply try to offline all
>>> online nodes - which is fast, because we usually span pages and can skip
>>> such nodes right away.
>>
>> That makes me slightly nervous, because our big powerpc boxes tend to
>> trip on these scaling issues before others.
>>
>> But the spanned pages check is just:
>>
>> void try_offline_node(int nid)
>> {
>> 	pg_data_t *pgdat = NODE_DATA(nid);
>>           ...
>> 	if (pgdat->node_spanned_pages)
>> 		return;
>>
>> So I guess that's pretty cheap, and it's only O(nodes), which should
>> never get that big.
> 
> Exactly. And if it does turn out to be a problem, we can walk all memory
> blocks before removing them, collecting the nid(s).
> 

I might just do the following on top:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 61bff8f3bfb1..bbc26fdac364 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2176,7 +2176,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
  static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
  {
         int ret = !is_memblock_offlined(mem);
+       int *nid = arg;
  
+       *nid = mem->nid;
         if (unlikely(ret)) {
                 phys_addr_t beginpa, endpa;
  
@@ -2271,10 +2273,10 @@ EXPORT_SYMBOL(try_offline_node);
  
  static int __ref try_remove_memory(u64 start, u64 size)
  {
-       int rc = 0, nid;
         struct vmem_altmap mhp_altmap = {};
         struct vmem_altmap *altmap = NULL;
         unsigned long nr_vmemmap_pages;
+       int rc = 0, nid = NUMA_NO_NODE;
  
         BUG_ON(check_hotplug_memory_range(start, size));
  
@@ -2282,8 +2284,12 @@ static int __ref try_remove_memory(u64 start, u64 size)
          * All memory blocks must be offlined before removing memory.  Check
          * whether all memory blocks in question are offline and return error
          * if this is not the case.
+        *
+        * While at it, determine the nid. Note that if we'd have mixed nodes,
+        * we'd only try to offline the last determined one -- which is good
+        * enough for the cases we care about.
          */
-       rc = walk_memory_blocks(start, size, NULL, check_memblock_offlined_cb);
+       rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
         if (rc)
                 return rc;
  
@@ -2332,7 +2338,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
  
         release_mem_region_adjustable(start, size);
  
-       for_each_online_node(nid)
+       if (nid != NUMA_NO_NODE)
                 try_offline_node(nid);
  
         mem_hotplug_done();



-- 
Thanks,

David / dhildenb

