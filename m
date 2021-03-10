Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFA33473D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 19:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhCJSzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 13:55:10 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39043 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhCJSyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 13:54:49 -0500
Received: by mail-oi1-f174.google.com with SMTP id u62so4455213oib.6;
        Wed, 10 Mar 2021 10:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yI9WZUfKzeFXei1YXkcImkDxr5rdsjk8eOoNhkhpnLU=;
        b=LblxuwQI2Buo65HmXT2ezIx5w5ks00D2o6QW/8JLLvsXfKGVW9e2eAOe3DY6+LiY6E
         nRIGTN0otq51bbT6B135q3Yla2tlXUObd6ZdPLBEMRPkZ6nfewQjidh/NysE2wRyfyH6
         2DX00K6ojjNNV5k3foK+DTev+c7fBQOiGc8gbgknYPTnetEw677jozGMXOoKgEs3q2DT
         TmVqen8bE+4cTtBOA3JgLQqpk41z7FdhJlchnh3hgnR4rV04Vx8vXzOPnS1Rkb1mHIpR
         CXgCBbK9v9rj6onP2jo51NbAj78w2VXsjKSBVpWNKJkXbXwvxABfNhL5m8qy62crKr3h
         ckvA==
X-Gm-Message-State: AOAM533MjJ/8z8rjZGaL/vGVfZtP7lJN6wRsh0Q08lGFgEy3OJVtxVuf
        TXTFnfH8WvbWUYq6IPsXtvYY6AdpfK1wYVZxKMY=
X-Google-Smtp-Source: ABdhPJzh95SXQnaDjeDEkO8P2oaLdGnLRCY8jdxe/Zagwkyd7SGOwXj64Ymf8vKjv2+wcOUQ7lbRiVKjU7a6RHEfz8U=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr3515610oia.157.1615402488779;
 Wed, 10 Mar 2021 10:54:48 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com> <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com> <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Mar 2021 19:54:37 +0100
Message-ID: <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 7:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 5, 2021 at 2:40 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > >> The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> > >> page for the ibft table is not reserved, so it can end up on the freelist.
> > >
> > > You appear to be saying that it is not sufficient to kmap() a page in
> > > order to use it safely.  It is also necessary to reserve it upfront,
> > > for example with the help of memblock_reserve().  Is that correct?  If
> > > so, is there an alternative way to reserve a page frame?
> >
> > If the memory is indicated by the BIOS/firmware as valid memory
> > (!reserved) but contains actual tables that have to remain untouched
> > what happens is:
> >
> > 1) Memblock thinks the memory should be given to the buddy, because it
> >     is valid memory and was not reserved by anyone (i.e., the bios, early
> >     allocations).
> >
> > 2) Memblock will expose the pages to the buddy, adding them to the free
> >     page list.
> >
> > 3) Anybody can allocate them, e.g., via alloc_pages().
> >
> > The root issue is that pages that should not get exposed to the buddy as
> > free pages get exposed to the buddy as free pages. We have to teach
> > memblock that these pages are not actually to be used, but instead, area
> > reserved.
> >
> > >
> > >>>
> > >>>> Use memblock_reserve() to reserve all the ACPI table pages.
> > >>> How is this going to help?
> > >> If the ibft table page is not reserved, it will end up on the freelist
> > >> and potentially be allocated before ibft_init() is called.
> > >>
> > >> I believe this is the call that causes the ibft table page (in this case
> > >> pfn=0xbe453) to end up on the freelist:
> > >>
> > >> memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000,
> > >> zone_end_pfn=100000
> > >
> > > David, is commit 7fef431be9c9 related to this and if so, then how?
> > >
> >
> > Memory gets allocated and used in a different order, which seems to have
> > exposed (yet another) latent BUG.
>
> Well, you can call it that, or you can say that things worked under
> certain assumptions regarding the memory allocation order which are
> not met any more.
>
> > The same could be reproduced via zone shuffling with a little luck.
>
> But nobody does that in practice.
>
> This would be relatively straightforward to address if ACPICA was not
> involved in it, but unfortunately that's not the case.
>
> Changing this part of ACPICA is risky, because such changes may affect
> other OSes using it, so that requires some serious consideration.
> Alternatively, the previous memory allocation order in Linux could be
> restored.

Of course, long-term this needs to be addressed in the ACPI
initialization code, because it clearly is not robust enough, but in
the meantime there's practical breakage observable in the field, so
what can be done about that?
