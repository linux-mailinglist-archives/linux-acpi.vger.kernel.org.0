Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF774F33E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jul 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGKPXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jul 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKPXn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2023 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF56120
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689088978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hR8o5w/Hx4dMIcWhqSVmnIxH5BFRWJkuE4F/mZRv5R0=;
        b=Bu5+vqDeTbPPcZgy/jefEUhb4JSCRtMC2CpOqIecWq0v0MRfn/Hwt428a/cWasPuWDVzrk
        /Qo49ei1pRPtpD9+Eklk4vrKyAMCPP5GkY5i0gaXC+wcZtEpfnYews/idtyKrwHrR9JBdu
        844UWCRgIrq5OG3fcZHrcJeeF1Rrgh4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-GXHy-1HeNSuXTjVmIq79_g-1; Tue, 11 Jul 2023 11:21:14 -0400
X-MC-Unique: GXHy-1HeNSuXTjVmIq79_g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso35075855e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 08:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088864; x=1691680864;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hR8o5w/Hx4dMIcWhqSVmnIxH5BFRWJkuE4F/mZRv5R0=;
        b=k/UudUC5ocXHMCHSgU4t2FZBeV0PtozDYfguDBW1vBZdLXPTA0+7wNTzdBdIPAX5Nz
         02uXYnnvOY6xxo4l1fFLxK1rlAvgJTWTX5sjavwmQqgcefbBMMlvQ3IB5HTqAJGRvpdh
         vEHBteJWTtYVbsmt6YyqiKxEc/BKMgsXaLdMta7zF++n8BkikKpiFuFfE/k2mUgGwTH0
         siP0dbH12OP7pBlNTdPWipM7l7zJcJow5XIDtuic8vBGQTbGAUmgfUTbYcqtdSEDy0RH
         nry0KZQN/SvaCZ17Ycvfb2yBqX9pW7ntYLZrdoHv4PoVxP2XsGNdnGr3GIogqqVcCpok
         XiMg==
X-Gm-Message-State: ABy/qLayXx5I1el+SLyluvJCytyKbVRZMwPaGQnjGH734XAu/psNK1gB
        S/fbVJo2ikxjTwkJfoiivTRH2bU+1ALqW9g4wZEYvxvWAbFTpi8XIJQzzODcl40nimueMu9Q441
        mYBZrED4E/nygLc8dQOBw4g==
X-Received: by 2002:a05:600c:3659:b0:3fb:ffca:b6b8 with SMTP id y25-20020a05600c365900b003fbffcab6b8mr10769696wmq.41.1689088864171;
        Tue, 11 Jul 2023 08:21:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFa8FePMOcFtsaR5lyUM9Zkhx4gUcfLsSekgoJaLPVs+fd3+XRakBj3NxEJhRdLG4yh8Eojkw==
X-Received: by 2002:a05:600c:3659:b0:3fb:ffca:b6b8 with SMTP id y25-20020a05600c365900b003fbffcab6b8mr10769677wmq.41.1689088863833;
        Tue, 11 Jul 2023 08:21:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d? (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de. [2003:cb:c745:4000:13ad:ed64:37e6:115d])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c0b5800b003fc01189b0dsm2774139wmr.42.2023.07.11.08.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 08:21:03 -0700 (PDT)
Message-ID: <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
Date:   Tue, 11 Jul 2023 17:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
 <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
 <87edleplkn.fsf@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
In-Reply-To: <87edleplkn.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11.07.23 16:30, Aneesh Kumar K.V wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 16.06.23 00:00, Vishal Verma wrote:
>>> With DAX memory regions originating from CXL memory expanders or
>>> NVDIMMs, the kmem driver may be hot-adding huge amounts of system memory
>>> on a system without enough 'regular' main memory to support the memmap
>>> for it. To avoid this, ensure that all kmem managed hotplugged memory is
>>> added with the MHP_MEMMAP_ON_MEMORY flag to place the memmap on the
>>> new memory region being hot added.
>>>
>>> To do this, call add_memory() in chunks of memory_block_size_bytes() as
>>> that is a requirement for memmap_on_memory. Additionally, Use the
>>> mhp_flag to force the memmap_on_memory checks regardless of the
>>> respective module parameter setting.
>>>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Huang Ying <ying.huang@intel.com>
>>> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>>> ---
>>>    drivers/dax/kmem.c | 49 ++++++++++++++++++++++++++++++++++++-------------
>>>    1 file changed, 36 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>> index 7b36db6f1cbd..0751346193ef 100644
>>> --- a/drivers/dax/kmem.c
>>> +++ b/drivers/dax/kmem.c
>>> @@ -12,6 +12,7 @@
>>>    #include <linux/mm.h>
>>>    #include <linux/mman.h>
>>>    #include <linux/memory-tiers.h>
>>> +#include <linux/memory_hotplug.h>
>>>    #include "dax-private.h"
>>>    #include "bus.h"
>>>
>>> @@ -105,6 +106,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>    	data->mgid = rc;
>>>
>>>    	for (i = 0; i < dev_dax->nr_range; i++) {
>>> +		u64 cur_start, cur_len, remaining;
>>>    		struct resource *res;
>>>    		struct range range;
>>>
>>> @@ -137,21 +139,42 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>    		res->flags = IORESOURCE_SYSTEM_RAM;
>>>
>>>    		/*
>>> -		 * Ensure that future kexec'd kernels will not treat
>>> -		 * this as RAM automatically.
>>> +		 * Add memory in chunks of memory_block_size_bytes() so that
>>> +		 * it is considered for MHP_MEMMAP_ON_MEMORY
>>> +		 * @range has already been aligned to memory_block_size_bytes(),
>>> +		 * so the following loop will always break it down cleanly.
>>>    		 */
>>> -		rc = add_memory_driver_managed(data->mgid, range.start,
>>> -				range_len(&range), kmem_name, MHP_NID_IS_MGID);
>>> +		cur_start = range.start;
>>> +		cur_len = memory_block_size_bytes();
>>> +		remaining = range_len(&range);
>>> +		while (remaining) {
>>> +			mhp_t mhp_flags = MHP_NID_IS_MGID;
>>>
>>> -		if (rc) {
>>> -			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>>> -					i, range.start, range.end);
>>> -			remove_resource(res);
>>> -			kfree(res);
>>> -			data->res[i] = NULL;
>>> -			if (mapped)
>>> -				continue;
>>> -			goto err_request_mem;
>>> +			if (mhp_supports_memmap_on_memory(cur_len,
>>> +							  MHP_MEMMAP_ON_MEMORY))
>>> +				mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>>> +			/*
>>> +			 * Ensure that future kexec'd kernels will not treat
>>> +			 * this as RAM automatically.
>>> +			 */
>>> +			rc = add_memory_driver_managed(data->mgid, cur_start,
>>> +						       cur_len, kmem_name,
>>> +						       mhp_flags);
>>> +
>>> +			if (rc) {
>>> +				dev_warn(dev,
>>> +					 "mapping%d: %#llx-%#llx memory add failed\n",
>>> +					 i, cur_start, cur_start + cur_len - 1);
>>> +				remove_resource(res);
>>> +				kfree(res);
>>> +				data->res[i] = NULL;
>>> +				if (mapped)
>>> +					continue;
>>> +				goto err_request_mem;
>>> +			}
>>> +
>>> +			cur_start += cur_len;
>>> +			remaining -= cur_len;
>>>    		}
>>>    		mapped++;
>>>    	}
>>>
>>
>> Maybe the better alternative is teach
>> add_memory_resource()/try_remove_memory() to do that internally.
>>
>> In the add_memory_resource() case, it might be a loop around that
>> memmap_on_memory + arch_add_memory code path (well, and the error path
>> also needs adjustment):
>>
>> 	/*
>> 	 * Self hosted memmap array
>> 	 */
>> 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>> 		if (!mhp_supports_memmap_on_memory(size)) {
>> 			ret = -EINVAL;
>> 			goto error;
>> 		}
>> 		mhp_altmap.free = PHYS_PFN(size);
>> 		mhp_altmap.base_pfn = PHYS_PFN(start);
>> 		params.altmap = &mhp_altmap;
>> 	}
>>
>> 	/* call arch's memory hotadd */
>> 	ret = arch_add_memory(nid, start, size, &params);
>> 	if (ret < 0)
>> 		goto error;
>>
>>
>> Note that we want to handle that on a per memory-block basis, because we
>> don't want the vmemmap of memory block #2 to end up on memory block #1.
>> It all gets messy with memory onlining/offlining etc otherwise ...
>>
> 
> I tried to implement this inside add_memory_driver_managed() and also
> within dax/kmem. IMHO doing the error handling inside dax/kmem is
> better. Here is how it looks:
> 
> 1. If any blocks got added before (mapped > 0) we loop through all successful request_mem_regions
> 2. For each succesful request_mem_regions if any blocks got added, we
> keep the resource. If none got added, we will kfree the resource
> 

Doing this unconditional splitting outside of 
add_memory_driver_managed() is undesirable for at least two reasons

1) You end up always creating individual entries in the resource tree
    (/proc/iomem) even if MHP_MEMMAP_ON_MEMORY is not effective.
2) As we call arch_add_memory() in memory block granularity (e.g., 128
    MiB on x86), we might not make use of large PUDs (e.g., 1 GiB) in the
    identify mapping -- even if MHP_MEMMAP_ON_MEMORY is not effective.

While you could sense for support and do the split based on that, it 
will be beneficial for other users (especially DIMMs) if we do that 
internally -- where we already know if MHP_MEMMAP_ON_MEMORY can be 
effective or not.

In general, we avoid placing important kernel data-structures on slow 
memory. That's one of the reasons why PMEM decided to mostly always use 
ZONE_MOVABLE such that exactly what this patch does would not happen. So 
I'm wondering if there would be demand for an additional toggle.

Because even with memmap_on_memory enabled in general, you might not 
want to do that for dax/kmem.

IMHO, this patch should be dropped from your ppc64 series, as it's an 
independent change that might be valuable for other architectures as well.

-- 
Cheers,

David / dhildenb

