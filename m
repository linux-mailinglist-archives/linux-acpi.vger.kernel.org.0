Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAD3377F2
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Mar 2021 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhCKPhG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Mar 2021 10:37:06 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40356 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhCKPgn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2021 10:36:43 -0500
Received: by mail-ot1-f44.google.com with SMTP id b8so1836559oti.7;
        Thu, 11 Mar 2021 07:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwY2wNfbKjFx3CHjkfJmwtEhpX43qQBYMFJEAlc1V6Y=;
        b=XXnKNKfBz/oGRjGobvylNzC/GU7wzusjw0SN8vvpKl6slnbhF2tlxk1zpi5kdCNjQq
         9BafInAw9PPFoVGTGmqMD+3ssh0OUOxFzBaVeoGTDUPbj7MAkuU2bSZkpGcnUtSbpodw
         xV6SRP3w2xRGimTW6YtXfkEg+tGi/xMpIqaIISFjyAZfxk/cXRb7ikTscP8xta2OhUGy
         JiN0tO1xIL3sSU8CpHFvZR5Ap05qZy5TygsSOniTLmWv46I6EKMzVgXsIhQYKmwFeDwl
         ZmnXWzMk/NmX1Vf6MLH3ZeFc69UJ9fWVjO5pP4ncKfkFIix1SLZfjSTTMYpAA3QIIEPu
         2uxg==
X-Gm-Message-State: AOAM530z+JKe7lt8y8YXjCrGEN79xDdBX5zQUluK/SdGUDKD3dFNWnVt
        ffjtT6D2w/cVl81Dz/R2HLDmdw7Mtnmtd3q/IJY=
X-Google-Smtp-Source: ABdhPJwUt9Q6ZZJCSQpdeTp+0T+zFZMHpiXszgp78Tff9vWJiX7Jv6h8C2PFGGBuNvCTnbBuhQIm8qTvykxW277eA5o=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr7541034otr.321.1615477002714;
 Thu, 11 Mar 2021 07:36:42 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com> <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com> <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
 <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com> <YEkgP0G94uQBGDa9@linux.ibm.com>
 <0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com>
In-Reply-To: <0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Mar 2021 16:36:31 +0100
Message-ID: <CAJZ5v0jOpNJrOt5xn-1YkSB9Q15NZS2cxmsGKAU945YNbs+hOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> >>>>> The same could be reproduced via zone shuffling with a little luck.
> >>>>
> >>>> But nobody does that in practice.
> >>>>
> >>
> >> Dan will most certainly object. And I don't know what makes you speak in
> >> absolute words here.
> >>
> >>>> This would be relatively straightforward to address if ACPICA was not
> >>>> involved in it, but unfortunately that's not the case.
> >>>>
> >>>> Changing this part of ACPICA is risky, because such changes may affect
> >>>> other OSes using it, so that requires some serious consideration.
> >>>> Alternatively, the previous memory allocation order in Linux could be
> >>>> restored.
> >>>
> >>> Of course, long-term this needs to be addressed in the ACPI
> >>> initialization code, because it clearly is not robust enough, but in
> >>> the meantime there's practical breakage observable in the field, so
> >>> what can be done about that?
> >>
> >> *joke* enable zone shuffling.
> >>
> >> No seriously, fix the latent BUG. What again is problematic about excluding
> >> these pages from the page allcoator, for example, via memblock_reserve()?
> >>
> >> @Mike?
> >
> > There is some care that should be taken to make sure we get the order
> > right, but I don't see a fundamental issue here.

Me neither.

> > If I understand correctly, Rafael's concern is about changing the parts of
> > ACPICA that should be OS agnostic, so I think we just need another place to
> > call memblock_reserve() rather than acpi_tb_install_table_with_override().

Something like this.

There is also the problem that memblock_reserve() needs to be called
for all of the tables early enough, which will require some reordering
of the early init code.

> > Since the reservation should be done early in x86::setup_arch() (and
> > probably in arm64::setup_arch()) we might just have a function that parses
> > table headers and reserves them, similarly to how we parse the tables
> > during KASLR setup.

Right.

>
> FWIW, something like below would hide our latent BUG again properly (lol).
> But I guess I don't have to express how ugly and wrong that is. Not to mention
> what happens if memblock decides to allocate that memory area earlier
> for some other user (including CMA, ...).

Fair enough.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..ec71b7c63dbe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1566,6 +1566,21 @@ void __free_pages_core(struct page *page, unsigned int order)
>
>          atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>
> +       /*
> +        * BUG ALERT: x86-64 ACPI code has latent BUGs where ACPI tables
> +        * that must not get allocated/modified will get exposed to the buddy
> +        * as free pages; anybody can allocate and use them once in the free
> +        * lists.
> +        *
> +        * Instead of fixing the BUG, revert the change to the
> +        * freeing/allocation order during boot that revealed it and cross
> +        * fingers that everything will be fine.
> +        */
> +       if (system_state < SYSTEM_RUNNING) {
> +               __free_pages_ok(page, order, FPI_NONE);
> +               return;
> +       }
> +
>          /*
>           * Bypass PCP and place fresh pages right to the tail, primarily
>           * relevant for memory onlining.
>
>
> --
