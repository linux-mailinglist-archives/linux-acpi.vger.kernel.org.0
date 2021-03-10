Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3995334849
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 20:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhCJTrv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 14:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbhCJTrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Mar 2021 14:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615405668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15J7/6/60u4JfGCD3qHIlb5hU7kTjQauSUUO0B/9ZRI=;
        b=JHweXBPHGC71ZqsAZpUamZn9b+CC1nSzKi8qD+FGQISgkkOrzg+RGISzZNsv8h+II67rZu
        wCCZVf2PBgwgfnDUNtyIVffpNE2SK7Ee+fHfVUfbfNnRtR76+OBoapOjxBiQ0wbGZ3aweR
        MSTtAS1Fcd79NNB0rp7EA83ofiBDQQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-D_wRruRRMOKqBTFeObd7-A-1; Wed, 10 Mar 2021 14:47:44 -0500
X-MC-Unique: D_wRruRRMOKqBTFeObd7-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41D601019623;
        Wed, 10 Mar 2021 19:47:42 +0000 (UTC)
Received: from [10.36.112.107] (ovpn-112-107.ams2.redhat.com [10.36.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A415A59453;
        Wed, 10 Mar 2021 19:47:38 +0000 (UTC)
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
 <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
 <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com>
 <YEkgP0G94uQBGDa9@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Message-ID: <0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com>
Date:   Wed, 10 Mar 2021 20:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEkgP0G94uQBGDa9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>>>> The same could be reproduced via zone shuffling with a little luck.
>>>>
>>>> But nobody does that in practice.
>>>>
>>
>> Dan will most certainly object. And I don't know what makes you speak in
>> absolute words here.
>>
>>>> This would be relatively straightforward to address if ACPICA was not
>>>> involved in it, but unfortunately that's not the case.
>>>>
>>>> Changing this part of ACPICA is risky, because such changes may affect
>>>> other OSes using it, so that requires some serious consideration.
>>>> Alternatively, the previous memory allocation order in Linux could be
>>>> restored.
>>>
>>> Of course, long-term this needs to be addressed in the ACPI
>>> initialization code, because it clearly is not robust enough, but in
>>> the meantime there's practical breakage observable in the field, so
>>> what can be done about that?
>>
>> *joke* enable zone shuffling.
>>
>> No seriously, fix the latent BUG. What again is problematic about excluding
>> these pages from the page allcoator, for example, via memblock_reserve()?
>>
>> @Mike?
> 
> There is some care that should be taken to make sure we get the order
> right, but I don't see a fundamental issue here.
> 
> If I understand correctly, Rafael's concern is about changing the parts of
> ACPICA that should be OS agnostic, so I think we just need another place to
> call memblock_reserve() rather than acpi_tb_install_table_with_override().
> 
> Since the reservation should be done early in x86::setup_arch() (and
> probably in arm64::setup_arch()) we might just have a function that parses
> table headers and reserves them, similarly to how we parse the tables
> during KASLR setup.
> 

FWIW, something like below would hide our latent BUG again properly (lol).
But I guess I don't have to express how ugly and wrong that is. Not to mention
what happens if memblock decides to allocate that memory area earlier
for some other user (including CMA, ...).

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..ec71b7c63dbe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1566,6 +1566,21 @@ void __free_pages_core(struct page *page, unsigned int order)
  
         atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
  
+       /*
+        * BUG ALERT: x86-64 ACPI code has latent BUGs where ACPI tables
+        * that must not get allocated/modified will get exposed to the buddy
+        * as free pages; anybody can allocate and use them once in the free
+        * lists.
+        *
+        * Instead of fixing the BUG, revert the change to the
+        * freeing/allocation order during boot that revealed it and cross
+        * fingers that everything will be fine.
+        */
+       if (system_state < SYSTEM_RUNNING) {
+               __free_pages_ok(page, order, FPI_NONE);
+               return;
+       }
+
         /*
          * Bypass PCP and place fresh pages right to the tail, primarily
          * relevant for memory onlining.


-- 
Thanks,

David / dhildenb

