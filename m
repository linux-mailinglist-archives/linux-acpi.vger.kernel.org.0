Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35E347993
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhCXN2V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 09:28:21 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39904 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhCXN2A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 09:28:00 -0400
Received: by mail-oi1-f172.google.com with SMTP id i81so19278578oif.6;
        Wed, 24 Mar 2021 06:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVtFOOqo3xe9yL6j51iSdtuw9qJvjjXH+Yk+HGXG5Qk=;
        b=ROAyGghdRf1TRH8n4xO+I4NJqC7+j+eR782Joe9pDwbNrEPiifrZ/WO1gqqurOr25p
         jxaYb7uE/di/VI9FgloIgZqVEUcaxD1cqO/fsAun1hMdkkSQPTXIn2aLyix04dFwf4Fi
         oJjCOTdq/RYNxYTSGPMe/0iM/IPRGkryQyIBMfYoR05pq1M1m79SWOvx7nyBUWptFIyj
         Fsqwee32bPNSMfBS3IwCf7PwzaZ2svR1hJvJJucH2hSstk1oR7KjcUyPnMpzIgf6dOjk
         8I40HkFQhfj7QxpD8q1gkVOCxYMaweN8JT2E6b7yO2BTIghFkyr6SEJmM/IWLkSNQ0a2
         d80A==
X-Gm-Message-State: AOAM533aGCvvf9kVrO8Q8XWKv7HZhpUarCvMAKUeFQTmTMiRn73zaN5l
        ZwgXk+Gcy8K9hBW1OxeRyzCxyljAZQE5ROeV3Xk=
X-Google-Smtp-Source: ABdhPJxNK5hjEsGMlbXlbQEYDPkCopm/stI0iNLO0Lfgz8LmA527ZlaJjLKeOTCi2tfxdoz7gP158xia1laxXRqMCE0=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr2312470oib.69.1616592479613;
 Wed, 24 Mar 2021 06:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
 <YFWxbzN92XcXNl95@linux.ibm.com> <4650320.31r3eYUQgx@kreacher> <YFr3KMhW0ajHzeH4@linux.ibm.com>
In-Reply-To: <YFr3KMhW0ajHzeH4@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 14:27:48 +0100
Message-ID: <CAJZ5v0gWWGx8dvtz2pnXcCoxz_Aswo8Yxp=vo-z=jYX1OzC3=Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: x86: Reserve memory occupied by ACPI tables
To:     Mike Rapoport <rppt@linux.ibm.com>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        x86 Maintainers <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 24, 2021 at 9:24 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Mar 23, 2021 at 08:26:52PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The following problem has been reported by George Kennedy:
> >
> >  Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
> >  in __free_pages_core()") the following use after free occurs
> >  intermittently when ACPI tables are accessed.
> >
> >  BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
> >  Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> >  CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
> >  Call Trace:
> >   dump_stack+0xf6/0x158
> >   print_address_description.constprop.9+0x41/0x60
> >   kasan_report.cold.14+0x7b/0xd4
> >   __asan_report_load_n_noabort+0xf/0x20
> >   ibft_init+0x134/0xc49
> >   do_one_initcall+0xc4/0x3e0
> >   kernel_init_freeable+0x5af/0x66b
> >   kernel_init+0x16/0x1d0
> >   ret_from_fork+0x22/0x30
> >
> >  ACPI tables mapped via kmap() do not have their mapped pages
> >  reserved and the pages can be "stolen" by the buddy allocator.
> >
> > Apparently, on the affected system, the ACPI table in question is
> > not located in "reserved" memory, like ACPI NVS or ACPI Data, that
> > will not be used by the buddy allocator, so the memory occupied by
> > that table has to be explicitly reserved to prevent the buddy
> > allocator from using it.
> >
> > In order to address this problem, rearrange the initialization of the
> > ACPI tables on x86 to locate the initial tables earlier and reserve
> > the memory occupied by them.
> >
> > The other architectures using ACPI should not be affected by this
> > change.
> >
> > Link: https://lore.kernel.org/linux-acpi/1614802160-29362-1-git-send-email-george.kennedy@oracle.com/
> > Reported-by: George Kennedy <george.kennedy@oracle.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> FWIW:
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thank you!

George, can you please try this patch on the affected system?

> > ---
> >  arch/x86/kernel/acpi/boot.c |   25 ++++++++++++-------------
> >  arch/x86/kernel/setup.c     |    8 +++-----
> >  drivers/acpi/tables.c       |   42 +++++++++++++++++++++++++++++++++++++++---
> >  include/linux/acpi.h        |    9 ++++++++-
> >  4 files changed, 62 insertions(+), 22 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/acpi/boot.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> > +++ linux-pm/arch/x86/kernel/acpi/boot.c
> > @@ -1554,10 +1554,18 @@ void __init acpi_boot_table_init(void)
> >       /*
> >        * Initialize the ACPI boot-time table parser.
> >        */
> > -     if (acpi_table_init()) {
> > +     if (acpi_locate_initial_tables())
> >               disable_acpi();
> > -             return;
> > -     }
> > +     else
> > +             acpi_reserve_initial_tables();
> > +}
> > +
> > +int __init early_acpi_boot_init(void)
> > +{
> > +     if (acpi_disabled)
> > +             return 1;
> > +
> > +     acpi_table_init_complete();
> >
> >       acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> >
> > @@ -1570,18 +1578,9 @@ void __init acpi_boot_table_init(void)
> >               } else {
> >                       printk(KERN_WARNING PREFIX "Disabling ACPI support\n");
> >                       disable_acpi();
> > -                     return;
> > +                     return 1;
> >               }
> >       }
> > -}
> > -
> > -int __init early_acpi_boot_init(void)
> > -{
> > -     /*
> > -      * If acpi_disabled, bail out
> > -      */
> > -     if (acpi_disabled)
> > -             return 1;
> >
> >       /*
> >        * Process the Multiple APIC Description Table (MADT), if present
> > Index: linux-pm/arch/x86/kernel/setup.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/setup.c
> > +++ linux-pm/arch/x86/kernel/setup.c
> > @@ -1045,6 +1045,9 @@ void __init setup_arch(char **cmdline_p)
> >
> >       cleanup_highmap();
> >
> > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > +     acpi_boot_table_init();
> > +
> >       memblock_set_current_limit(ISA_END_ADDRESS);
> >       e820__memblock_setup();
> >
> > @@ -1136,11 +1139,6 @@ void __init setup_arch(char **cmdline_p)
> >
> >       early_platform_quirks();
> >
> > -     /*
> > -      * Parse the ACPI tables for possible boot-time SMP configuration.
> > -      */
> > -     acpi_boot_table_init();
> > -
> >       early_acpi_boot_init();
> >
> >       initmem_init();
> > Index: linux-pm/include/linux/acpi.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/acpi.h
> > +++ linux-pm/include/linux/acpi.h
> > @@ -222,10 +222,14 @@ void __iomem *__acpi_map_table(unsigned
> >  void __acpi_unmap_table(void __iomem *map, unsigned long size);
> >  int early_acpi_boot_init(void);
> >  int acpi_boot_init (void);
> > +void acpi_boot_table_prepare (void);
> >  void acpi_boot_table_init (void);
> >  int acpi_mps_check (void);
> >  int acpi_numa_init (void);
> >
> > +int acpi_locate_initial_tables (void);
> > +void acpi_reserve_initial_tables (void);
> > +void acpi_table_init_complete (void);
> >  int acpi_table_init (void);
> >  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
> >  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
> > @@ -814,9 +818,12 @@ static inline int acpi_boot_init(void)
> >       return 0;
> >  }
> >
> > +static inline void acpi_boot_table_prepare(void)
> > +{
> > +}
> > +
> >  static inline void acpi_boot_table_init(void)
> >  {
> > -     return;
> >  }
> >
> >  static inline int acpi_mps_check(void)
> > Index: linux-pm/drivers/acpi/tables.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/tables.c
> > +++ linux-pm/drivers/acpi/tables.c
> > @@ -780,7 +780,7 @@ acpi_status acpi_os_table_override(struc
> >  }
> >
> >  /*
> > - * acpi_table_init()
> > + * acpi_locate_initial_tables()
> >   *
> >   * find RSDP, find and checksum SDT/XSDT.
> >   * checksum all tables, print SDT/XSDT
> > @@ -788,7 +788,7 @@ acpi_status acpi_os_table_override(struc
> >   * result: sdt_entry[] is initialized
> >   */
> >
> > -int __init acpi_table_init(void)
> > +int __init acpi_locate_initial_tables(void)
> >  {
> >       acpi_status status;
> >
> > @@ -803,9 +803,45 @@ int __init acpi_table_init(void)
> >       status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
> >       if (ACPI_FAILURE(status))
> >               return -EINVAL;
> > -     acpi_table_initrd_scan();
> >
> > +     return 0;
> > +}
> > +
> > +void __init acpi_reserve_initial_tables(void)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < ACPI_MAX_TABLES; i++) {
> > +             struct acpi_table_desc *table_desc = &initial_tables[i];
> > +             u64 start = table_desc->address;
> > +             u64 size = table_desc->length;
> > +
> > +             if (!start || !size)
> > +                     break;
> > +
> > +             pr_info("Reserving %4s table memory at [mem 0x%llx-0x%llx]\n",
> > +                     table_desc->signature.ascii, start, start + size - 1);
> > +
> > +             memblock_reserve(start, size);
> > +     }
> > +}
> > +
> > +void __init acpi_table_init_complete(void)
> > +{
> > +     acpi_table_initrd_scan();
> >       check_multiple_madt();
> > +}
> > +
> > +int __init acpi_table_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = acpi_locate_initial_tables();
> > +     if (ret)
> > +             return ret;
> > +
> > +     acpi_table_init_complete();
> > +
> >       return 0;
> >  }
> >
> >
> >
> >
>
> --
> Sincerely yours,
> Mike.
