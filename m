Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AE26C9DE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgIPTd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 15:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31783 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727589AbgIPTcF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 15:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600284687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H30dbXoNbzsTkPGiKpd2XjhJWXqjtA7dGp0dwpbyBQA=;
        b=Q2TAjVK1i1o+4f4DqEWRYey6mLyFuPShulyNtZBkiUUbfOiZk63wvoOdeg11Iya2uQTrWc
        d01hMvqoYOv8UiSuqQeR1EMd2EGC/9x1ZmySJymGhJ8fRmlWrWPmyRS3doUjSsdUFU1xAr
        DSMxEW/wKHFSRjEQ7WSm//CKRM/zYSo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-XF5SWKofOaKkx9rXMrO9cQ-1; Wed, 16 Sep 2020 15:31:25 -0400
X-MC-Unique: XF5SWKofOaKkx9rXMrO9cQ-1
Received: by mail-ej1-f71.google.com with SMTP id r14so3370001ejb.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2020 12:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=H30dbXoNbzsTkPGiKpd2XjhJWXqjtA7dGp0dwpbyBQA=;
        b=Tv81tIdAOg4BplxRS0B3JUmAe0XRq7ZcV1VRzGfQZrsAXfwhYDx45nZEEgd3oWwjPc
         pw6iUR7CsU/klI7eik58+P+AKzU4Yw4C72MgVnUUItyoGxs9QNZmyjr+LPs5tSDgrGzQ
         DMLYL5ij9mC8Dc1SnfObxOQhzbEBZPzziQegN0VPW4cpOoBRmK915UmeFoxGnZGfWf6p
         tp6LzyVcPuAmKETwIrxoncg1lQOOPtSHsAuCEvewsybsnphhoCEdLrLTEMrGe7Ours5c
         dQ/kkwDyJKo+lUlvD2YNLn+oGIsh+qA7r4yK2hh+sZ4+P7ruE3c4Lr0xmSia1ka1LWZb
         pYYg==
X-Gm-Message-State: AOAM5323vnJLHKU+Vgjt2YvsOWd8j5zIMiq7iW4P6MGijyqbTC2YqeKP
        daQdfS8mDgIe7P9iQyjeePOPpfEM8Gh0Do+a6bKHqBSbW7C9gZtlOhVro24sFDhRepLIf61S2vS
        c3WDCnAcwUcDxDogj/S9acg==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr30417833eds.366.1600284684124;
        Wed, 16 Sep 2020 12:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNf5C6IgWA4C90hz+1DV+boU+avbJN14GYmBM3jetRxVAOiNjdDaQK6JfCvz8qKCYsfBo/YA==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr30417797eds.366.1600284683833;
        Wed, 16 Sep 2020 12:31:23 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23c30.dip0.t-ipconnect.de. [79.242.60.48])
        by smtp.gmail.com with ESMTPSA id k25sm13202917ejk.3.2020.09.16.12.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 12:31:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling and undoing isolation
Date:   Wed, 16 Sep 2020 21:31:21 +0200
Message-Id: <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
References: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>, Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
In-Reply-To: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
To:     osalvador@suse.de
X-Mailer: iPhone Mail (17H35)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> Am 16.09.2020 um 20:50 schrieb osalvador@suse.de:
>=20
> =EF=BB=BFOn 2020-09-16 20:34, David Hildenbrand wrote:
>> When adding separate memory blocks via add_memory*() and onlining them
>> immediately, the metadata (especially the memmap) of the next block will b=
e
>> placed onto one of the just added+onlined block. This creates a chain
>> of unmovable allocations: If the last memory block cannot get
>> offlined+removed() so will all dependant ones. We directly have unmovable=

>> allocations all over the place.
>> This can be observed quite easily using virtio-mem, however, it can also
>> be observed when using DIMMs. The freshly onlined pages will usually be
>> placed to the head of the freelists, meaning they will be allocated next,=

>> turning the just-added memory usually immediately un-removable. The
>> fresh pages are cold, prefering to allocate others (that might be hot)
>> also feels to be the natural thing to do.
>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when=

>> adding separate, successive memory blocks, each memory block will have
>> unmovable allocations on them - for example gigantic pages will fail to
>> allocate.
>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
>> offlined+removed again (any kind of fragmentation with unmovable
>> allocations is possible), there are many scenarios (hotplugging a lot of
>> memory, running workload, hotunplug some memory/as much as possible) wher=
e
>> we can offline+remove quite a lot with this patchset.
>=20
> Hi David,
>=20

Hi Oscar.

> I did not read through the patchset yet, so sorry if the question is nonse=
nse, but is this not trying to fix the same issue the vmemmap patches did? [=
1]

Not nonesense at all. It only helps to some degree, though. It solves the de=
pendencies due to the memmap. However, it=E2=80=98s not completely ideal, es=
pecially for single memory blocks.

With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) y=
ou still have unmovable (vmemmap chunks) all over the physical address space=
. Consider the gigantic page example after hotplug. You directly fragmented a=
ll hotplugged memory.

Of course, there might be (less extreme) dependencies due page tables for th=
e identity mapping, extended struct pages and similar.

Having that said, there are other benefits when preferring other memory over=
 just hotplugged memory. Think about adding+onlining memory during boot (dim=
ms under QEMU, virtio-mem), once the system is up you will have most (all) o=
f that memory completely untouched.

So while vmemmap on hotplugged memory would tackle some part of the issue, t=
here are cases where this approach is better, and there are even benefits wh=
en combining both.

Thanks!

David

>=20
> I was about to give it a new respin now that thw hwpoison stuff has been s=
ettled.
>=20
> [1] https://patchwork.kernel.org/cover/11059175/
>=20

