Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40E933C182
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Mar 2021 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCOQTq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Mar 2021 12:19:46 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45993 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCOQTl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Mar 2021 12:19:41 -0400
Received: by mail-ot1-f53.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so5412094otf.12;
        Mon, 15 Mar 2021 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhDXdT+Qk1yZgYcJ7G0DPhjw1AHmHsmXi9SEBVXA2Gw=;
        b=sB9fjvAT5QxOwnbpGLlYLH3URFQjwdGcY1prDpGFqeSi32XxFs0BseANS7mmwDycie
         tkouF52Bti1024vb9YQxqtqFJTx5VxfyoSvh7sC/O4M97wmsviXWJcuLYvlqY8Lg4HcQ
         N0MyLj+V29wuI48dyBGq/AHLABd8Luu2y9pSrZ52fIvxcVkyKDntVEonOkVvXGa2Ak6O
         uWJcXny4DXfUaj0a4020QfErzRUk84Yh63QT3ltKxr+j+rdxZ4OFnUNUo5qmD/LflXo/
         j7w+35FKHEn5PGHA0bXUinXbo0oUOz0A0ktmGQYiLXtLxdjlBX4dclgjCmmF4RinOXsI
         I3EA==
X-Gm-Message-State: AOAM531A7PeiQyrGCIzV9HaFrvbSvAypLtHKzma1z+aQach/oy2XduQP
        NnCa2K+ERdeEEzC07hxnl24GKFTft0so9fQXmhfl2dN9RTw=
X-Google-Smtp-Source: ABdhPJzHxsaszMe8pnfqRcU6lgYlCbAiR4iynVcVsvhI3THx7YrFgWZV0cy2S6yGRVehH46qz2UuFWnBzmQXvE9fkPE=
X-Received: by 2002:a9d:3422:: with SMTP id v31mr14622147otb.260.1615825180891;
 Mon, 15 Mar 2021 09:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com> <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com> <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
 <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com> <YEkgP0G94uQBGDa9@linux.ibm.com>
 <0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com> <CAJZ5v0jOpNJrOt5xn-1YkSB9Q15NZS2cxmsGKAU945YNbs+hOw@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
In-Reply-To: <YE5dJ6U3nPWsXY4D@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Mar 2021 17:19:29 +0100
Message-ID: <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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

On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > There is some care that should be taken to make sure we get the order
> > > > right, but I don't see a fundamental issue here.
> >
> > Me neither.
> >
> > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> >
> > Something like this.
> >
> > There is also the problem that memblock_reserve() needs to be called
> > for all of the tables early enough, which will require some reordering
> > of the early init code.
> >
> > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > table headers and reserves them, similarly to how we parse the tables
> > > > during KASLR setup.
> >
> > Right.
>
> I've looked at it a bit more and we do something like the patch below that
> nearly duplicates acpi_tb_parse_root_table() which is not very nice.

It looks to me that the code need not be duplicated (see below).

> Besides, reserving ACPI tables early and then calling acpi_table_init()
> (and acpi_tb_parse_root_table() again would mean doing the dance with
> early_memremap() twice for no good reason.

That'd be simply inefficient which is kind of acceptable to me to start with.

And I changing the ACPICA code can be avoided at least initially, it
by itself would be a good enough reason.

> I believe the most effective way to deal with this would be to have a
> function that does parsing, reservation and installs the tables supplied by
> the firmware which can be called really early and then another function
> that overrides tables if needed a some later point.

I agree that this should be the direction to go into.

However, it looks to me that something like the following could be
done to start with:

(a) Make __acpi_map_table() call memblock_reserve() in addition to
early_memremap().

My assumption here is that the memblock_reserve() will simply be
ignored if it is called too late.

(b) Introduce acpi_reserve_tables() as something like

void __init acpi_table_reserve(void)
{
        acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
}

Because initial_tables is passed to acpi_initialize_tables() above and
allow_resize is 0, the array used by it will simply get overwritten
when acpi_table_init() gets called.

(c) Make setup_arch() call acpi_table_reserve() like in the original
patch from George.

Would that work?

If so, I'll cut a patch along these lines.
