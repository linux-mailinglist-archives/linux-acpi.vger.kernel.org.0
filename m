Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6D3D7293
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhG0KGy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 06:06:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236105AbhG0KGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Jul 2021 06:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F15D81FB;
        Tue, 27 Jul 2021 03:06:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586893F73D;
        Tue, 27 Jul 2021 03:06:51 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:06:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] ACPI: Add memory semantics to acpi_os_map_memory()
Message-ID: <20210727100645.GA7108@lpieralisi>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 26, 2021 at 05:55:33PM +0200, Ard Biesheuvel wrote:
> On Mon, 26 Jul 2021 at 12:00, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > The memory attributes attached to memory regions depend on architecture
> > specific mappings.
> >
> > For some memory regions, the attributes specified by firmware (eg
> > uncached) are not sufficient to determine how a memory region should be
> > mapped by an OS (for instance a region that is define as uncached in
> > firmware can be mapped as Normal or Device memory on arm64) and
> > therefore the OS must be given control on how to map the region to match
> > the expected mapping behaviour (eg if a mapping is requested with memory
> > semantics, it must allow unaligned accesses).
> >
> > Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> > them into two separate code paths:
> >
> > acpi_os_memmap() -> memory semantics
> > acpi_os_ioremap() -> MMIO semantics
> >
> > The split allows the architectural implementation back-ends to detect
> > the default memory attributes required by the mapping in question
> > (ie the mapping API defines the semantics memory vs MMIO) and map the
> > memory accordingly.
> >
> > Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> For the patch in general
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks !

[...]

> > -void __iomem __ref
> > -*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> > +static void __iomem __ref
> > +*__acpi_os_map_iomem(acpi_physical_address phys, acpi_size size, bool memory)
> >  {
> >         struct acpi_ioremap *map;
> >         void __iomem *virt;
> > @@ -353,7 +356,7 @@ void __iomem __ref
> >
> >         pg_off = round_down(phys, PAGE_SIZE);
> >         pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
> > -       virt = acpi_map(phys, size);
> > +       virt = acpi_map(phys, size, memory);
> >         if (!virt) {
> >                 mutex_unlock(&acpi_ioremap_lock);
> >                 kfree(map);
> > @@ -372,11 +375,17 @@ void __iomem __ref
> >         mutex_unlock(&acpi_ioremap_lock);
> >         return map->virt + (phys - map->phys);
> >  }
> > +
> > +void __iomem __ref
> > +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> 
> I am aware that this just duplicated the prototype above, but I think
> this should be
> 
> void __iomem *__ref
> 
> given that the __ref comes after the * in the prototype below.

Yes I just moved/duplicated the prototype above but I believe this is
consistent with include/acpi/acpi_io.h unless I have not understood
what you meant ?

It is probably worth changing it in both places to

void __iomem *__ref

?

I can do that with an additional patch.

> 
> > +{
> > +       return __acpi_os_map_iomem(phys, size, false);
> > +}
> >  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
> >
> >  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> >  {
> > -       return (void *)acpi_os_map_iomem(phys, size);
> > +       return (void *)__acpi_os_map_iomem(phys, size, true);
> 
> I think this should be (__force void *) to shut up sparse address
> space warnings.

Yes I can add that attribute in an additional patch and rebase this one
on top of it.

Thanks,
Lorenzo

> 
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
> >
> > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > index 027faa8883aa..a0212e67d6f4 100644
> > --- a/include/acpi/acpi_io.h
> > +++ b/include/acpi/acpi_io.h
> > @@ -14,6 +14,14 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> >  }
> >  #endif
> >
> > +#ifndef acpi_os_memmap
> > +static inline void __iomem *acpi_os_memmap(acpi_physical_address phys,
> > +                                           acpi_size size)
> > +{
> > +       return ioremap_cache(phys, size);
> > +}
> > +#endif
> > +
> >  extern bool acpi_permanent_mmap;
> >
> >  void __iomem __ref
> > --
> > 2.31.0
> >
