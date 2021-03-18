Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715C3403DD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCRKuk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 06:50:40 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:37397 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCRKud (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 06:50:33 -0400
Received: by mail-oo1-f43.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so1320733oot.4;
        Thu, 18 Mar 2021 03:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIDk99AN54P9dz8S58q171UK8pRxtVWI+OQDCq00Bf8=;
        b=D2UD+xNNb0LAg7gankf8iPM1Y3ZH2hBmsav8KLUTrCx2lNHSum9MkG4dTXdGgagEj3
         qP3rg1wrZHWYkB0x/8fj0vBu9CEYXo6v5ZztEDCIzNrEByyxs0fhKcprJDxCaWLk6dv5
         786OiH0dyQiW61z5VfM4w486AHVlnKzNRhyadrELNxszivDIkmzW7+D+Rm9y3GEix8i8
         OjXRw3dQrMVyLZ0MI5F6R5A+3TG54CXyF/3jvVuhadvOeQXVIP0RtBqp3sncZBXnoB+d
         ccphNpSK/aXJ7KAfGgv6Pyf+DU7Ovit50rbh30V8AKYImiFMsqDNAFvo9P+F2rolRRMp
         fNaw==
X-Gm-Message-State: AOAM533P0WBWG32fGH5XGvmyWlXMKjy3qaZE7ogrF6PA+WqzLaei7AOu
        LuKe/T1S9Wd0svhIM9EMpBbxEDKHxUFgis7s5cintrHR
X-Google-Smtp-Source: ABdhPJwTd6HeBU2ayrPYmrRVxGXT3jB5gQBw5j7Vg9VHvG2IiLm117/01+DfUs79JlXfTQ4vduHKspvEmfqhRtXooaE=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr7100616oop.1.1616064633285;
 Thu, 18 Mar 2021 03:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com>
In-Reply-To: <YFMAdIVn2hpTHfBq@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 11:50:21 +0100
Message-ID: <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > > >
> > > > > > > There is some care that should be taken to make sure we get the order
> > > > > > > right, but I don't see a fundamental issue here.
> > > > >
> > > > > Me neither.
> > > > >
> > > > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > > > >
> > > > > Something like this.
> > > > >
> > > > > There is also the problem that memblock_reserve() needs to be called
> > > > > for all of the tables early enough, which will require some reordering
> > > > > of the early init code.
> > > > >
> > > > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > > > during KASLR setup.
> > > > >
> > > > > Right.
> > > >
> > > > I've looked at it a bit more and we do something like the patch below that
> > > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > >
> > > It looks to me that the code need not be duplicated (see below).
> > >
> > > > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > > > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > > > early_memremap() twice for no good reason.
> > >
> > > That'd be simply inefficient which is kind of acceptable to me to start with.
> > >
> > > And I changing the ACPICA code can be avoided at least initially, it
> > > by itself would be a good enough reason.
> > >
> > > > I believe the most effective way to deal with this would be to have a
> > > > function that does parsing, reservation and installs the tables supplied by
> > > > the firmware which can be called really early and then another function
> > > > that overrides tables if needed a some later point.
> > >
> > > I agree that this should be the direction to go into.
> >
> > So maybe something like the patch below?
> >
> > I'm not sure if acpi_boot_table_prepare() gets called early enough, though.
>
> To be 100% safe it should be called before e820__memblock_setup().

OK

> It is possible to call memblock_reserve() at any time, even before the actual
> memory is detected as long as all reservations fit into the static array
> that currently has 128 entries on x86.
>
> As e820__memblock_setup() essentially enables memblock allocations,
> theoretically the memory occupied by ACPI tables can be allocated even in
> x86::setup_arch() unless it is reserved before e820__memblock_setup().
>
> > Also this still may not play well with initrd-based table overrides. Erik, do
> > you have any insights here?
> >
> > And ia64 needs to be updated too.
>
> I think arm64 as well.

Right.

> > ---
> >  arch/x86/kernel/acpi/boot.c |   12 +++++++++---
> >  arch/x86/kernel/setup.c     |    3 +++
> >  drivers/acpi/tables.c       |   24 +++++++++++++++++++++---
> >  include/linux/acpi.h        |    9 +++++++--
> >  4 files changed, 40 insertions(+), 8 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/acpi/boot.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> > +++ linux-pm/arch/x86/kernel/acpi/boot.c
> > @@ -1541,7 +1541,7 @@ static const struct dmi_system_id acpi_d
> >   *   ...
> >   */
> >
> > -void __init acpi_boot_table_init(void)
> > +void __init acpi_boot_table_prepare(void)
> >  {
> >       dmi_check_system(acpi_dmi_table);
> >
> > @@ -1554,10 +1554,16 @@ void __init acpi_boot_table_init(void)
> >       /*
> >        * Initialize the ACPI boot-time table parser.
> >        */
> > -     if (acpi_table_init()) {
> > +     if (acpi_table_prepare())
> >               disable_acpi();
> > +}
> > +
> > +void __init acpi_boot_table_init(void)
> > +{
> > +     if (acpi_disabled)
> >               return;
> > -     }
> > +
> > +     acpi_table_init();
> >
> >       acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> >
> > Index: linux-pm/arch/x86/kernel/setup.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/setup.c
> > +++ linux-pm/arch/x86/kernel/setup.c
> > @@ -1070,6 +1070,9 @@ void __init setup_arch(char **cmdline_p)
> >       /* preallocate 4k for mptable mpc */
> >       e820__memblock_alloc_reserved_mpc_new();
> >
> > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > +     acpi_boot_table_prepare();
> > +
> >  #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
> >       setup_bios_corruption_check();
> >  #endif
> > Index: linux-pm/include/linux/acpi.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/acpi.h
> > +++ linux-pm/include/linux/acpi.h
> > @@ -222,11 +222,13 @@ void __iomem *__acpi_map_table(unsigned
> >  void __acpi_unmap_table(void __iomem *map, unsigned long size);
> >  int early_acpi_boot_init(void);
> >  int acpi_boot_init (void);
> > +void acpi_boot_table_prepare (void);
> >  void acpi_boot_table_init (void);
>
> Not related to this patch, but it feels to me like there are too many
> acpi_boot_something() :)

Well, there was one initially, but it has been split for a few times
due to ordering issues similar to the one at hand.

It could be cleaned up I suppose, though.
