Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8600139F4CB
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhFHLUy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231330AbhFHLUx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 07:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623151140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
        b=NCgNublPpUc65Nv9VMJ1ZXh7G8ulTDOg+GeMHxs5AdLA5wdvFcVbC1riX+BPiVNsB1FrsM
        bnC+0xwjq5QRyorxATrmLJeJ+9atPcJONYGUkeK4ty51NCsaD10GHwoNsQYLa0rZLMLaHb
        stXbO8E4RkU/aCKdNnYhnSeQhE4W4a0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-jnG1ebBAPCet392cIzOEkw-1; Tue, 08 Jun 2021 07:18:58 -0400
X-MC-Unique: jnG1ebBAPCet392cIzOEkw-1
Received: by mail-wr1-f71.google.com with SMTP id u5-20020adf9e050000b029010df603f280so9294423wre.18
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
        b=B36uHV1KNHvZrFdpG0VxBsotaprYl8T1ylnT9U/F4wbftbU2VN9p4XpPZ11FVLBpTO
         ZcXcyn/uwZHQiTnNz2M4gZlU1q6YjDsBXkYQIdgvDwF/Bh2wzocgl+PlDuEoD54uRTy5
         Ijl5XB7dg/Wm4y3tQWRkT0d3oZX71plkxnWajj18ZU8q5gwFwOgqFOPVMoiqt/ntejLd
         DWI3idZ5uVhgI02fsrIpfidXLLfrChmgywka5KmsOXcmw6Rq1VcggPzkUA2SCR+xgYrr
         +02jaicPQjriY4XCACZcXR8s7E+eqFGBwaG5boOeK1gEveQNk67gyn7GFv95ediS8UML
         viAw==
X-Gm-Message-State: AOAM530AN11bRIc0hN7MfHWfmTVtZXwyZvadGE4rK9j+HvRwrxvTyjQW
        nTg+ntVlsKafUFbP4Rf6HLZFvHKNJrG/tD2NUvw9Yf5mPVdNNuPuSxRg3fzJyr1Vclkfbt7AMcb
        nJ6OFutz5NC1YCO+MVQrhxQ==
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061226wrl.255.1623151137733;
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrB9z1bqXKLNgH1xZgLenFDxAm/18wrzcUUIce09tn+BporQC3UeSbXcvGrkz4TceLSHiMMw==
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061199wrl.255.1623151137577;
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id u2sm19236473wrn.38.2021.06.08.04.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Date:   Tue, 8 Jun 2021 13:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87y2bkehky.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08.06.21 13:11, Michael Ellerman wrote:
> David Hildenbrand <david@redhat.com> writes:
>> There is only a single user remaining. We can simply try to offline all
>> online nodes - which is fast, because we usually span pages and can skip
>> such nodes right away.
> 
> That makes me slightly nervous, because our big powerpc boxes tend to
> trip on these scaling issues before others.
> 
> But the spanned pages check is just:
> 
> void try_offline_node(int nid)
> {
> 	pg_data_t *pgdat = NODE_DATA(nid);
>          ...
> 	if (pgdat->node_spanned_pages)
> 		return;
> 
> So I guess that's pretty cheap, and it's only O(nodes), which should
> never get that big.

Exactly. And if it does turn out to be a problem, we can walk all memory 
blocks before removing them, collecting the nid(s).

-- 
Thanks,

David / dhildenb

