Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7D3346F0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhCJSjg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 13:39:36 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34307 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhCJSjb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 13:39:31 -0500
Received: by mail-ot1-f48.google.com with SMTP id n23so11747737otq.1;
        Wed, 10 Mar 2021 10:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fS2Rs0egi9/dzY8lzXOv5M8g0qkVn2nZhboXlniji4=;
        b=Gifb7RzYF9tf+Qg1T1JmKWjQ5w7/vbJJKZXCCV/7nZRU589K4GdWaLwUIolNr4kArQ
         ZUy1G84thQlo+53hfvoSV8IC8M0RH5fU38XpKd1BvCSJEqQgYjSN+Hd2AjAp1c0CFcni
         KSIZSjgViEnxjX49vtmBWnA0wybYY8xhPjLDK/o/qnmmU8nOGRqti4oWm2B/aR5sC4c5
         vSlZ1h44crdXtTJxPl9KB91SRm4M3QPy0RSKB4LE/WQH+i2hWiSj7RzRMscPeymwp6bV
         z0bQYyxod/cFClHgE3TCfus7dmrZkP/vnRKPKjO1v34VQhZQDlm198Gwz6ENqgSTu//k
         4ejw==
X-Gm-Message-State: AOAM530IBpFX7lNvO4YQSmrVgClDAKGrs5GVKWLmN4UDI66E8/kz9WwQ
        eR2wozn6IpKRlLPBGmDkK39A6TxlanJRcNEqW5k=
X-Google-Smtp-Source: ABdhPJyNnowA3UdYmDLgEbI2ZC3/0qrXeOLKMJ5/W3Sg9JfW6MSjEGfB3zvWlj0/f7kBRVdOU5PiR57melYh5UWQbp8=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3707877otr.321.1615401570893;
 Wed, 10 Mar 2021 10:39:30 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com> <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
In-Reply-To: <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Mar 2021 19:39:19 +0100
Message-ID: <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 5, 2021 at 2:40 PM David Hildenbrand <david@redhat.com> wrote:
>
> >> The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> >> page for the ibft table is not reserved, so it can end up on the freelist.
> >
> > You appear to be saying that it is not sufficient to kmap() a page in
> > order to use it safely.  It is also necessary to reserve it upfront,
> > for example with the help of memblock_reserve().  Is that correct?  If
> > so, is there an alternative way to reserve a page frame?
>
> If the memory is indicated by the BIOS/firmware as valid memory
> (!reserved) but contains actual tables that have to remain untouched
> what happens is:
>
> 1) Memblock thinks the memory should be given to the buddy, because it
>     is valid memory and was not reserved by anyone (i.e., the bios, early
>     allocations).
>
> 2) Memblock will expose the pages to the buddy, adding them to the free
>     page list.
>
> 3) Anybody can allocate them, e.g., via alloc_pages().
>
> The root issue is that pages that should not get exposed to the buddy as
> free pages get exposed to the buddy as free pages. We have to teach
> memblock that these pages are not actually to be used, but instead, area
> reserved.
>
> >
> >>>
> >>>> Use memblock_reserve() to reserve all the ACPI table pages.
> >>> How is this going to help?
> >> If the ibft table page is not reserved, it will end up on the freelist
> >> and potentially be allocated before ibft_init() is called.
> >>
> >> I believe this is the call that causes the ibft table page (in this case
> >> pfn=0xbe453) to end up on the freelist:
> >>
> >> memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000,
> >> zone_end_pfn=100000
> >
> > David, is commit 7fef431be9c9 related to this and if so, then how?
> >
>
> Memory gets allocated and used in a different order, which seems to have
> exposed (yet another) latent BUG.

Well, you can call it that, or you can say that things worked under
certain assumptions regarding the memory allocation order which are
not met any more.

> The same could be reproduced via zone shuffling with a little luck.

But nobody does that in practice.

This would be relatively straightforward to address if ACPICA was not
involved in it, but unfortunately that's not the case.

Changing this part of ACPICA is risky, because such changes may affect
other OSes using it, so that requires some serious consideration.
Alternatively, the previous memory allocation order in Linux could be
restored.
