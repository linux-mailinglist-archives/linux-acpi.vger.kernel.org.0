Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B00344C76
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 17:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCVQ6D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 12:58:03 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39487 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhCVQ5j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 12:57:39 -0400
Received: by mail-ot1-f54.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so16627822ote.6;
        Mon, 22 Mar 2021 09:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83NWJNS5IfkRY8uZgeuY59TwUa5zRy9EPOl1w3UC3QY=;
        b=jeT9/RnxEKPb/8yqBTWOfvyrUOHAiba+7bhNXJSGyNjf3iiWXIjMPVW90ZyasJePcG
         0ZcNJSBgINnls3qb1VMn0zJu1cCg+GbRRtHRUd63Z+hb2JECGjVKTPrW1nYjnTNmmnao
         ARXCE03OWRCLQW3oFjvuHpVGOcY9LtIkNlTQlFlDmP545fRM0ATFWZghopNxM3Jxa29H
         6+uIQS4mk+jDq3691GEmWM8/W0tcwjZzvYUhowBX6jJ82N5fEmM1XZM6Eq3Fx8L4s6s7
         MluTheTbpoJIvWD/l0chs0A6lT98JmpIC/Utphz+KxQWOZKOOo/7O7SqGzMb0I2d31ZB
         lG6A==
X-Gm-Message-State: AOAM530GfOLprk+vE5Uz4EostLRt9YWPcv/+8jEeIauxy86yHw5mi1xb
        0cetm6Vgzdx5o24PzwCjiIXIEFEtoJbsTgCvb8Y=
X-Google-Smtp-Source: ABdhPJyhnA/+oYMcscd/h9+EcNHB25LvbW75G4JNL2BfBnGBms87P/FZLeg1MsH8Ia7MemQWrMg1KmzgpL8/ti+AZWo=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr685011otr.321.1616432258283;
 Mon, 22 Mar 2021 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com> <YFWxbzN92XcXNl95@linux.ibm.com>
In-Reply-To: <YFWxbzN92XcXNl95@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 17:57:27 +0100
Message-ID: <CAJZ5v0jEeBxtaAz+w2SZdAud077FJBR+AfkyEYR-eM7gY4050g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
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

On Sat, Mar 20, 2021 at 9:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 18, 2021 at 04:22:37PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 18, 2021 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > > On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > > > > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > > > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > There is some care that should be taken to make sure we get the order
> > > > > > > > > > right, but I don't see a fundamental issue here.
> > > > > > > >
> > > > > > > > Me neither.
> > > > > > > >
> > > > > > > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > > > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > > > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > > > > > > >
> > > > > > > > Something like this.
> > > > > > > >
> > > > > > > > There is also the problem that memblock_reserve() needs to be called
> > > > > > > > for all of the tables early enough, which will require some reordering
> > > > > > > > of the early init code.
> > > > > > > >
> > > > > > > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > > > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > > > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > > > > > > during KASLR setup.
> > > > > > > >
> > > > > > > > Right.
> > > > > > >
> > > > > > > I've looked at it a bit more and we do something like the patch below that
> > > > > > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > > > > >
> > > > > > It looks to me that the code need not be duplicated (see below).
> > > > > >
> > > > > > > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > > > > > > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > > > > > > early_memremap() twice for no good reason.
> > > > > >
> > > > > > That'd be simply inefficient which is kind of acceptable to me to start with.
> > > > > >
> > > > > > And I changing the ACPICA code can be avoided at least initially, it
> > > > > > by itself would be a good enough reason.
> > > > > >
> > > > > > > I believe the most effective way to deal with this would be to have a
> > > > > > > function that does parsing, reservation and installs the tables supplied by
> > > > > > > the firmware which can be called really early and then another function
> > > > > > > that overrides tables if needed a some later point.
> > > > > >
> > > > > > I agree that this should be the direction to go into.
> > > > >
> > > > > So maybe something like the patch below?
> > > > >
> > > > > I'm not sure if acpi_boot_table_prepare() gets called early enough, though.
> > > >
> > > > To be 100% safe it should be called before e820__memblock_setup().
> > >
> > > OK
> >
> > Well, that said, reserve_bios_regions() doesn't seem to have concerns
> > like this and I'm not sure why ACPI tables should be reserved before
> > this runs.  That applies to efi_reserve_boot_services() too.
> >
> > I can put the new call before e820__memblock_alloc_reserved_mpc_new(),
> > but I'm not sure why to put it before efi_reserve_boot_services(),
> > say?
>
> The general idea is to reserve all the memory used by the firmware before
> memblock allocations are possible, i.e. before e820__memblock_setup().
> Currently this is not the case, but it does not make it more correct.

I see.

> Theoretically, it is possible that reserve_bios_regions() will cause a
> memory allocation and the allocated memory will be exactly at the area
> where ACPI tables reside.
>
> In practice I believe this is very unlikely, but who knows.
>
> Another advantage of having ACPI tables handy by the time we do the memory
> detection is that we will be able to SRAT earlier and simplify NUMA
> initialization.

OK, fair enough.
