Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E228D33479A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 20:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCJTLO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 14:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhCJTKz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Mar 2021 14:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615403455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=my3I/Vyc00Xzj/W/fB+4uCbRyz46ViZsY10XYMSRH38=;
        b=DjgF/9U02YEaCtHp//7iWj0Wi5ji88kyZ4X9p1Q1M+L4Ww0Y1MwfMKwUqeLSPlMZg6t3Sk
        TumZ1MeqzICV6ixhSAA7gdjmo3+A7svtXY1TcSmZx5l8xXQUGArWwgmobsyoQzqKA9qPSM
        KCaU6uh1J0OfFkkmkY2O5ELhnbm8e6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-DUzzdPhzMyestMQGjlZj4Q-1; Wed, 10 Mar 2021 14:10:51 -0500
X-MC-Unique: DUzzdPhzMyestMQGjlZj4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901BC881D73;
        Wed, 10 Mar 2021 19:10:47 +0000 (UTC)
Received: from [10.36.112.107] (ovpn-112-107.ams2.redhat.com [10.36.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB60A5D9DB;
        Wed, 10 Mar 2021 19:10:43 +0000 (UTC)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
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
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
 <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Message-ID: <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com>
Date:   Wed, 10 Mar 2021 20:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>>> Memory gets allocated and used in a different order, which seems to have
>>> exposed (yet another) latent BUG.
>>
>> Well, you can call it that, or you can say that things worked under
>> certain assumptions regarding the memory allocation order which are
>> not met any more.
>>
>>> The same could be reproduced via zone shuffling with a little luck.
>>
>> But nobody does that in practice.
>>

Dan will most certainly object. And I don't know what makes you speak in 
absolute words here.

>> This would be relatively straightforward to address if ACPICA was not
>> involved in it, but unfortunately that's not the case.
>>
>> Changing this part of ACPICA is risky, because such changes may affect
>> other OSes using it, so that requires some serious consideration.
>> Alternatively, the previous memory allocation order in Linux could be
>> restored.
> 
> Of course, long-term this needs to be addressed in the ACPI
> initialization code, because it clearly is not robust enough, but in
> the meantime there's practical breakage observable in the field, so
> what can be done about that?

*joke* enable zone shuffling.

No seriously, fix the latent BUG. What again is problematic about 
excluding these pages from the page allcoator, for example, via 
memblock_reserve()?

@Mike?

-- 
Thanks,

David / dhildenb

