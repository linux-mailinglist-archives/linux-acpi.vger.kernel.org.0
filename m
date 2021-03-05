Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70932EC66
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCENlC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 08:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCENkd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 08:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614951632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Us44kK8almkKYV1H4wnmYxtlb2pEgbBYf7YjCuA7KUs=;
        b=M0anrqweY3c20R2UOVnbVbrL/8khiHgnraQnwQwSVz0u4hZwHLarGjTvGh7/YLMAQPwhrg
        y71OEXZHlxCpnkWR/epehRBDLmHY9eWpHb/Va62iXJUnMJYGIq1HYYIRLbI4+fnWK+rOvr
        bocyrUd095QCzjMt7DFNgFszWsm9HCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-dpmasTY_MeeuFUIuDoyzHg-1; Fri, 05 Mar 2021 08:40:28 -0500
X-MC-Unique: dpmasTY_MeeuFUIuDoyzHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C5EF108BD15;
        Fri,  5 Mar 2021 13:40:26 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DA0919934;
        Fri,  5 Mar 2021 13:40:22 +0000 (UTC)
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Message-ID: <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
Date:   Fri, 5 Mar 2021 14:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>> The ibft table, for example, is mapped in via acpi_map() and kmap(). The
>> page for the ibft table is not reserved, so it can end up on the freelist.
> 
> You appear to be saying that it is not sufficient to kmap() a page in
> order to use it safely.  It is also necessary to reserve it upfront,
> for example with the help of memblock_reserve().  Is that correct?  If
> so, is there an alternative way to reserve a page frame?

If the memory is indicated by the BIOS/firmware as valid memory 
(!reserved) but contains actual tables that have to remain untouched 
what happens is:

1) Memblock thinks the memory should be given to the buddy, because it
    is valid memory and was not reserved by anyone (i.e., the bios, early
    allocations).

2) Memblock will expose the pages to the buddy, adding them to the free
    page list.

3) Anybody can allocate them, e.g., via alloc_pages().

The root issue is that pages that should not get exposed to the buddy as 
free pages get exposed to the buddy as free pages. We have to teach 
memblock that these pages are not actually to be used, but instead, area 
reserved.

> 
>>>
>>>> Use memblock_reserve() to reserve all the ACPI table pages.
>>> How is this going to help?
>> If the ibft table page is not reserved, it will end up on the freelist
>> and potentially be allocated before ibft_init() is called.
>>
>> I believe this is the call that causes the ibft table page (in this case
>> pfn=0xbe453) to end up on the freelist:
>>
>> memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000,
>> zone_end_pfn=100000
> 
> David, is commit 7fef431be9c9 related to this and if so, then how?
> 

Memory gets allocated and used in a different order, which seems to have 
exposed (yet another) latent BUG. The same could be reproduced via zone 
shuffling with a little luck.

-- 
Thanks,

David / dhildenb

