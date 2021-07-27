Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4033E3D729D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhG0KJ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 06:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236046AbhG0KJ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Jul 2021 06:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A07261505;
        Tue, 27 Jul 2021 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627380598;
        bh=+zy1KVbWis0NChMBKfluyJz7JK9D515lhSdSK/ke/+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t7n3yPt8S7MVD8eFNaGBVI96IMsiSIydToBVixNIxf65wZC0fy7w16/GjaJvGntXu
         uDvbYyStDycBSmR+ddAUsBuq4fD6TxoCcpUyT4iU4jKeO0OTpcKukAERHGiG+e36j4
         gqdQ2gy/o0O/L2kuA+d3Pz8yzT5csOmy1SnnogaUrtNnEAIp2WHArE2m29O1wNuD+Z
         wiitDNYmft04QIDypFSqKpxJWpkb7Ej5c1o2n6aYU7kNRSNc/IxXGGh2rVljAU0pYq
         NEpW0k5mkGzb3AmSvOKEvbHXSU8wxq9xsxnpn3gChHLHocv4btJ25CsOjVD30JKbAb
         HYErpTG86YZbA==
Received: by mail-oi1-f173.google.com with SMTP id y18so14528072oiv.3;
        Tue, 27 Jul 2021 03:09:58 -0700 (PDT)
X-Gm-Message-State: AOAM532NILfFf+1/Nj2w0A/SNnWtv2MiWciI4bl7CxbKl4w84ZhyW1pd
        HRskwqQyeneW02TImkPpwruNO+vlIRxuE+/eBuI=
X-Google-Smtp-Source: ABdhPJwyeqgdIKWCEcfUojgd3pxJQ/D9wO6LrHAsmq74Nbo0adkNQ2j8ZbLRrKhsmnT1v2pNHvv0ohObBqY4IB07/KY=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr14216558oib.33.1627380597962;
 Tue, 27 Jul 2021 03:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com> <20210727100645.GA7108@lpieralisi>
In-Reply-To: <20210727100645.GA7108@lpieralisi>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jul 2021 12:09:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwPXX9MxuF_cw1bq9v+qzH-M4-_ssES8WQq-YP3APthg@mail.gmail.com>
Message-ID: <CAMj1kXHwPXX9MxuF_cw1bq9v+qzH-M4-_ssES8WQq-YP3APthg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add memory semantics to acpi_os_map_memory()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 27 Jul 2021 at 12:06, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Jul 26, 2021 at 05:55:33PM +0200, Ard Biesheuvel wrote:
> > On Mon, 26 Jul 2021 at 12:00, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > The memory attributes attached to memory regions depend on architecture
> > > specific mappings.
> > >
> > > For some memory regions, the attributes specified by firmware (eg
> > > uncached) are not sufficient to determine how a memory region should be
> > > mapped by an OS (for instance a region that is define as uncached in
> > > firmware can be mapped as Normal or Device memory on arm64) and
> > > therefore the OS must be given control on how to map the region to match
> > > the expected mapping behaviour (eg if a mapping is requested with memory
> > > semantics, it must allow unaligned accesses).
> > >
> > > Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> > > them into two separate code paths:
> > >
> > > acpi_os_memmap() -> memory semantics
> > > acpi_os_ioremap() -> MMIO semantics
> > >
> > > The split allows the architectural implementation back-ends to detect
> > > the default memory attributes required by the mapping in question
> > > (ie the mapping API defines the semantics memory vs MMIO) and map the
> > > memory accordingly.
> > >
> > > Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > For the patch in general
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks !
>
> [...]
>
> > > -void __iomem __ref
> > > -*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> > > +static void __iomem __ref
> > > +*__acpi_os_map_iomem(acpi_physical_address phys, acpi_size size, bool memory)
> > >  {
> > >         struct acpi_ioremap *map;
> > >         void __iomem *virt;
> > > @@ -353,7 +356,7 @@ void __iomem __ref
> > >
> > >         pg_off = round_down(phys, PAGE_SIZE);
> > >         pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
> > > -       virt = acpi_map(phys, size);
> > > +       virt = acpi_map(phys, size, memory);
> > >         if (!virt) {
> > >                 mutex_unlock(&acpi_ioremap_lock);
> > >                 kfree(map);
> > > @@ -372,11 +375,17 @@ void __iomem __ref
> > >         mutex_unlock(&acpi_ioremap_lock);
> > >         return map->virt + (phys - map->phys);
> > >  }
> > > +
> > > +void __iomem __ref
> > > +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> >
> > I am aware that this just duplicated the prototype above, but I think
> > this should be
> >
> > void __iomem *__ref
> >
> > given that the __ref comes after the * in the prototype below.
>
> Yes I just moved/duplicated the prototype above but I believe this is
> consistent with include/acpi/acpi_io.h unless I have not understood
> what you meant ?
>
> It is probably worth changing it in both places to
>
> void __iomem *__ref
>
> ?
>
> I can do that with an additional patch.
>

Yes, as long as they are all mutually consistent. The __ref is not
part of the type at all, so it should not be between the void and the
*, even if the compiler appears to allow it.


> >
> > > +{
> > > +       return __acpi_os_map_iomem(phys, size, false);
> > > +}
> > >  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
> > >
> > >  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> > >  {
> > > -       return (void *)acpi_os_map_iomem(phys, size);
> > > +       return (void *)__acpi_os_map_iomem(phys, size, true);
> >
> > I think this should be (__force void *) to shut up sparse address
> > space warnings.
>
> Yes I can add that attribute in an additional patch and rebase this one
> on top of it.
>
> Thanks,
> Lorenzo
>
> >
> > >  }
> > >  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
> > >
> > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > index 027faa8883aa..a0212e67d6f4 100644
> > > --- a/include/acpi/acpi_io.h
> > > +++ b/include/acpi/acpi_io.h
> > > @@ -14,6 +14,14 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > >  }
> > >  #endif
> > >
> > > +#ifndef acpi_os_memmap
> > > +static inline void __iomem *acpi_os_memmap(acpi_physical_address phys,
> > > +                                           acpi_size size)
> > > +{
> > > +       return ioremap_cache(phys, size);
> > > +}
> > > +#endif
> > > +
> > >  extern bool acpi_permanent_mmap;
> > >
> > >  void __iomem __ref
> > > --
> > > 2.31.0
> > >
