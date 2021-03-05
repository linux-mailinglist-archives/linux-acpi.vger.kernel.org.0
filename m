Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC14732EC1F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCENaU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 08:30:20 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43002 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCENaT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 08:30:19 -0500
Received: by mail-oi1-f173.google.com with SMTP id l64so2469006oig.9;
        Fri, 05 Mar 2021 05:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NQ7Or3v5+8GN49zjQ5rWQuRInRqmqpTTu5Y5nSeheE=;
        b=ppsr0ZvsQQ797ApnVAhlIQ5nPBwlP/yx3Wd7ABdjd/Six4Q4oj39wwJzOMi2jmQOnA
         BVy56ipH2hTPtXn569W6xCMTOFEE6AWSApzhuUjww/IbT3G9SO5dqeTxAKxOX/ESc+4Q
         FSYjbSX/anBtLnV4Dzo+RIEHCyMyAg5cwZvVi6V56iV240JFw/ZhFxAMWm7ErwcvU1iE
         j6g7Wrcb5XCtp+8nRJNddsxQoVFq2o7n4vYX+fCNFoJvXzG8/W8Up37aaKHdxkMf+diw
         d5UEKhXKiZApa+5p/elSeJWFwfYhUC9XqWSVNlisPwlJGyb1PwrjUr9Rzsc4ztW70F9R
         VR0Q==
X-Gm-Message-State: AOAM531JKYHL7zCQHS3htckd423QtYq/geHtgU4YRZzFVTGKUXP3EBFN
        COD/QuFZiBXVtxbfbzgaDgCPjfgLodLL6OQpF4Q=
X-Google-Smtp-Source: ABdhPJyVd/WbLsE4stDwYELwiqB0BhSkc0oeszeVzB9M4BVWcGcPECtfNIkQa5Lt1G3D3RNFd+3hj2gfnrwXfyLiJto=
X-Received: by 2002:aca:e189:: with SMTP id y131mr7198566oig.71.1614951019003;
 Fri, 05 Mar 2021 05:30:19 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com> <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
In-Reply-To: <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 14:30:07 +0100
Message-ID: <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     George Kennedy <george.kennedy@oracle.com>,
        David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Mar 5, 2021 at 12:14 AM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Hello Rafael,
>
> On 3/4/2021 7:14 AM, Rafael J. Wysocki wrote:
> > On Thu, Mar 4, 2021 at 2:22 AM George Kennedy <george.kennedy@oracle.com> wrote:
> >> Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
> >> in __free_pages_core()") the following use after free occurs
> >> intermittently when acpi tables are accessed.
> >>
> >> BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
> >> Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> >> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
> >> Call Trace:
> >>   dump_stack+0xf6/0x158
> >>   print_address_description.constprop.9+0x41/0x60
> >>   kasan_report.cold.14+0x7b/0xd4
> >>   __asan_report_load_n_noabort+0xf/0x20
> >>   ibft_init+0x134/0xc49
> >>   do_one_initcall+0xc4/0x3e0
> >>   kernel_init_freeable+0x5af/0x66b
> >>   kernel_init+0x16/0x1d0
> >>   ret_from_fork+0x22/0x30
> >>
> >> ACPI tables mapped via kmap() do not have their mapped pages
> >> reserved and the pages can be "stolen" by the buddy allocator.
> >>
> > What do you mean by this?
>>
> The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> page for the ibft table is not reserved, so it can end up on the freelist.

You appear to be saying that it is not sufficient to kmap() a page in
order to use it safely.  It is also necessary to reserve it upfront,
for example with the help of memblock_reserve().  Is that correct?  If
so, is there an alternative way to reserve a page frame?

> >
> >> Use memblock_reserve() to reserve all the ACPI table pages.
> > How is this going to help?
> If the ibft table page is not reserved, it will end up on the freelist
> and potentially be allocated before ibft_init() is called.
>
> I believe this is the call that causes the ibft table page (in this case
> pfn=0xbe453) to end up on the freelist:
>
> memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000,
> zone_end_pfn=100000

David, is commit 7fef431be9c9 related to this and if so, then how?

> [    0.477319]  memmap_init_range+0x33b/0x4e2
> [    0.479053]  memmap_init_zone+0x1e0/0x243
> [    0.485276]  free_area_init_node+0xa4e/0xac5
> [    0.498242]  free_area_init+0xf4a/0x107a
> [    0.509958]  zone_sizes_init+0xd9/0x111
> [    0.511731]  paging_init+0x4a/0x4c
> [    0.512417]  setup_arch+0x14f8/0x1758
> [    0.519193]  start_kernel+0x6c/0x46f
> [    0.519921]  x86_64_start_reservations+0x37/0x39
> [    0.520847]  x86_64_start_kernel+0x7b/0x7e
> [    0.521666]  secondary_startup_64_no_verify+0xb0/0xbb
>
> >
> >> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> >> ---
> >>   arch/x86/kernel/setup.c        | 3 +--
> >>   drivers/acpi/acpica/tbinstal.c | 4 ++++
> >>   2 files changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index d883176..97deea3 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
> >>          cleanup_highmap();
> >>
> >>          memblock_set_current_limit(ISA_END_ADDRESS);
> >> +       acpi_boot_table_init();
> > This cannot be moved before the acpi_table_upgrade() invocation AFAICS.
> >
> > Why exactly do you want to move it?
>
> Want to make sure there are slots for memblock_reserve() to be able to
> reserve the page.

Well, that may not require reordering the initialization this way.

> >>          e820__memblock_setup();
> >>
> >>          /*
> >> @@ -1139,8 +1140,6 @@ void __init setup_arch(char **cmdline_p)
> >>          /*
> >>           * Parse the ACPI tables for possible boot-time SMP configuration.
> >>           */
> >> -       acpi_boot_table_init();
> >> -
> >>          early_acpi_boot_init();
> >>
> >>          initmem_init();
> >> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> >> index 8d1e5b5..4e32b22 100644
> >> --- a/drivers/acpi/acpica/tbinstal.c
> >> +++ b/drivers/acpi/acpica/tbinstal.c
> >> @@ -8,6 +8,7 @@
> >>    *****************************************************************************/
> >>
> >>   #include <acpi/acpi.h>
> >> +#include <linux/memblock.h>
> >>   #include "accommon.h"
> >>   #include "actables.h"
> >>
> >> @@ -58,6 +59,9 @@
> >>                                        new_table_desc->flags,
> >>                                        new_table_desc->pointer);
> >>
> >> +       memblock_reserve(new_table_desc->address,
> >> +                        PAGE_ALIGN(new_table_desc->pointer->length));
> >> +
> > Why do you want to do this here in the first place?
>
> If there is a better place to do it, I can move the memblock_reserve()
> there. The memblock_reserve() cannot be done from the ibft code - it's
> too late - the ibft table page has already ended up on the freelist by
> the time ibft_init() is called.

I see.

> >
> > Things like that cannot be done in the ACPICA code in general.
>
> Can you recommend a better place to do the memblock_reserve() from?

Maybe.  I need to understand the problem better, though.

Thanks!
