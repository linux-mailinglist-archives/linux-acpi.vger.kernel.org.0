Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00313D2369
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhGVL6V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 07:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231738AbhGVL6V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626957535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ox6Ssi5cZmujphBmyOGCSc0Pr+tFXQyTb9VfR4BHKU=;
        b=P86rJ3b7CiWJhtFwUDpPaH7qM3OFMJnMiPlZwJJgL3zvXZ/sCp+xypIrLsmNDL+gf9zDdF
        FcJo1OzkqL3AmmKxBVmXssJDKttib+slcIIVGanXBtLbwF5b5ZSwutOHkKExhhUxGaUYEp
        f2e7bodnOfpfczcc2HDFg9OEOd+iVk8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-4vG-nneUNEGG9qmkvvNO_A-1; Thu, 22 Jul 2021 08:38:54 -0400
X-MC-Unique: 4vG-nneUNEGG9qmkvvNO_A-1
Received: by mail-lj1-f199.google.com with SMTP id e20-20020a05651c04d4b029019a4da37b65so2529837lji.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jul 2021 05:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ox6Ssi5cZmujphBmyOGCSc0Pr+tFXQyTb9VfR4BHKU=;
        b=JUiT5AmDDxXHWZmBBtE5iM02ItH/P/eG6+7y8RrlQ1Ry2AM02kLZqtu96nGgORdWkQ
         /1rPa2NrnpAowmrSeMeR7p7ul0rEdkMhC978ta1PGjn8T2P6sT6xSyGTiQzCTwUJr1Rs
         SJOn69c0uZJLsuw228/I7bgM6xk8ZkvUUe0MPg964TzIQRQmg5VREzvxSvo05RDAlCDP
         E6AQJXI8g7APpEbo5HTZ8q+Fv0ZDzHMylel+E6GI2a6ybh3n/3Kl9k5TFrvfO1rPmN3U
         7eN+iQckb3kVSWxJsa1jRNGNraNTVR1/CDKcb5W7DUMWk4s6PaYGQsoD4amW+Z/ZomYA
         madQ==
X-Gm-Message-State: AOAM5303+5akawHZoW0zttBSe7JeqzlKE1pqi1Ly0JnK15OHrvCCj1J/
        AIk/U17tkGYI9YIxhG8YNZTl43338KGtOoOBA/4bGTqlao/NnjpkhskP9FikZlZwtBXGSxgfFL1
        wZzc4UhxZzmPZH3v2Hy3Wl53D5PQJv4QE1kmN5w==
X-Received: by 2002:a2e:7e09:: with SMTP id z9mr34318983ljc.340.1626957532734;
        Thu, 22 Jul 2021 05:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfDFo9b+m3QM4Uc00wOlS7MLMJfESLBsXgw6oBUVkOGYnSKJXDERHiEJctw8L5DF9XKDED3EoZOB3WdTBy3gM=
X-Received: by 2002:a2e:7e09:: with SMTP id z9mr34318963ljc.340.1626957532421;
 Thu, 22 Jul 2021 05:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210629144415.GA28457@lpieralisi> <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
 <20210629163543.GA12361@arm.com> <20210630103715.GA12089@lpieralisi>
 <e548e72c-83a4-2366-dd57-3e746040fea9@arm.com> <CAMj1kXH=Q+WNgGsbApiq94z5OpJOnNLcFk_dyoVm_-VQunv3MA@mail.gmail.com>
 <20210630154923.GA16215@lpieralisi> <CAMj1kXHgPmJV6sPO8OWYj84Ncts00fzn+gJ=+xzcXYhCxvm-aA@mail.gmail.com>
 <20210705161715.GA19877@lpieralisi> <CAMj1kXHQKKnzJUEXMMzt3D1NUodeik8FZN1OTpD9zf8ZWrp6Lw@mail.gmail.com>
 <20210716162617.GA1403@lpieralisi>
In-Reply-To: <20210716162617.GA1403@lpieralisi>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Thu, 22 Jul 2021 14:38:16 +0200
Message-ID: <CA+tGwnmu-uL1v3vWO1yzH1i1ru6+EbVdEKnGOifoS6fLuTTGoQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOKdjCBGQUlMOiBUZXN0IHJlcG9ydCBmb3Iga2VybmVsIDUuMTMuMC1yYzcgKGFybQ==?=
        =?UTF-8?B?LW5leHQsIDhhYjliMWE5KQ==?=
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        skt-results-master@redhat.com, Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, lv.zheng@intel.com,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2021 at 6:26 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jul 16, 2021 at 06:16:01PM +0200, Ard Biesheuvel wrote:
> > On Mon, 5 Jul 2021 at 18:17, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Wed, Jun 30, 2021 at 08:18:22PM +0200, Ard Biesheuvel wrote:
> > >
> > > [...]
> > >
> > > > > In current code, even if the BERT were mapped with acpi_os_map_iomem()
> > > > > this would change nothing since it's acpi_os_ioremap() that runs the
> > > > > rule (backed up by EFI memory map region info).
> > > > >
> > > >
> > > > Indeed. So the fact that acpi_os_map_memory() is backed by
> > > > acpi_os_ioremap() is something we should fix. So they should both
> > > > consult the EFI memory map, but have different fallback defaults if
> > > > the region is not annotated correctly.
> > >
> > > Put together patch below even though I am not really satisfied, a tad
> > > intrusive and duplicate code in generic/arch backends, compile tested
> > > only; overall this IO vs memory mapping distinction is a bit too fuzzy
> > > for my taste - there is legacy unfortunately to consider though.
> > >
> >
> > I'd say that this does not look unreasonable at all. Is there any way
> > we could get this tested on actual hw?
>
> Sure, I was meant to follow-up and was caught up in something else,
> sorry.
>
> I will clean up the log, push it out in a branch on Monday, CKI
> should pick it up. I will also think about other possible testing
> options.
>

Hi,

thanks for the patience with the testing, the stress-ng test couldn't
deal with a new glibc version and had to be fixed and this week
has just been crazy.

I managed to do 2 runs of the updated tree with the stress-ng test
and it didn't hit the problem. Given how unreliably it reproduces it
doesn't mean all that much. I still have one more run pending and
can submit more if needed.

However, we ran into a panic with this tree on a completely
different machine:

https://gitlab.com/-/snippets/2152899/raw/main/snippetfile1.txt

The machine also hit a hardware error during LTP:

https://gitlab.com/-/snippets/2152899/raw/main/snippetfile2.txt

I'm not sure if the cause of these is the HW/firmware of they are
related to any changes in the tree but I'm sending them over as
they contain acpi in the call traces.

Veronika


> Thanks for having a look !
> Lorenzo
>
> > > -- >8 --
> > > Subject: [PATCH] ACPI: Add memory semantics to acpi_os_map_memory()
> > >
> > > Some platforms require memory semantics requested by the mapping function
> > > to be translated into architectural specific memory attributes so that
> > > the mapping is effectively implementing what is expected from it in
> > > terms of allowed access patterns (eg unaligned access).
> > >
> > > Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> > > them into two separate code paths that allow the architectural
> > > back-end to detect the default memory attributes required by
> > > the mapping in question.
> > >
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > ---
> > >  arch/arm64/include/asm/acpi.h |  3 +++
> > >  arch/arm64/kernel/acpi.c      | 16 ++++++++++++++--
> > >  drivers/acpi/osl.c            | 23 ++++++++++++++++-------
> > >  include/acpi/acpi_io.h        |  8 ++++++++
> > >  4 files changed, 41 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > index bd68e1b7f29f..7535dc7cc5aa 100644
> > > --- a/arch/arm64/include/asm/acpi.h
> > > +++ b/arch/arm64/include/asm/acpi.h
> > > @@ -50,6 +50,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> > >  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> > >  #define acpi_os_ioremap acpi_os_ioremap
> > >
> > > +void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size);
> > > +#define acpi_os_memmap acpi_os_memmap
> > > +
> > >  typedef u64 phys_cpuid_t;
> > >  #define PHYS_CPUID_INVALID INVALID_HWID
> > >
> > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > index cada0b816c8a..4c04fb40dc86 100644
> > > --- a/arch/arm64/kernel/acpi.c
> > > +++ b/arch/arm64/kernel/acpi.c
> > > @@ -261,7 +261,8 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
> > >         return __pgprot(PROT_DEVICE_nGnRnE);
> > >  }
> > >
> > > -void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > > +static void __iomem *__acpi_os_ioremap(acpi_physical_address phys,
> > > +                                      acpi_size size, bool memory)
> > >  {
> > >         efi_memory_desc_t *md, *region = NULL;
> > >         pgprot_t prot;
> > > @@ -289,7 +290,8 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > >          * regions that require a virtual mapping to make them accessible to
> > >          * the EFI runtime services.
> > >          */
> > > -       prot = __pgprot(PROT_DEVICE_nGnRnE);
> > > +       prot = memory ? __pgprot(PROT_NORMAL_NC) :
> > > +                       __pgprot(PROT_DEVICE_nGnRnE);
> > >         if (region) {
> > >                 switch (region->type) {
> > >                 case EFI_LOADER_CODE:
> > > @@ -349,6 +351,16 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > >         return __ioremap(phys, size, prot);
> > >  }
> > >
> > > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > > +{
> > > +       return __acpi_os_ioremap(phys, size, false);
> > > +}
> > > +
> > > +void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size)
> > > +{
> > > +       return __acpi_os_ioremap(phys, size, true);
> > > +}
> > > +
> > >  /*
> > >   * Claim Synchronous External Aborts as a firmware first notification.
> > >   *
> > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > index 327e1b4eb6b0..01dd115689bf 100644
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -284,7 +284,8 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
> > >  #define should_use_kmap(pfn)   page_is_ram(pfn)
> > >  #endif
> > >
> > > -static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
> > > +static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz,
> > > +                             bool memory)
> > >  {
> > >         unsigned long pfn;
> > >
> > > @@ -294,7 +295,8 @@ static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
> > >                         return NULL;
> > >                 return (void __iomem __force *)kmap(pfn_to_page(pfn));
> > >         } else
> > > -               return acpi_os_ioremap(pg_off, pg_sz);
> > > +               return memory ? acpi_os_memmap(pg_off, pg_sz) :
> > > +                               acpi_os_ioremap(pg_off, pg_sz);
> > >  }
> > >
> > >  static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
> > > @@ -309,9 +311,10 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
> > >  }
> > >
> > >  /**
> > > - * acpi_os_map_iomem - Get a virtual address for a given physical address range.
> > > + * __acpi_os_map_iomem - Get a virtual address for a given physical address range.
> > >   * @phys: Start of the physical address range to map.
> > >   * @size: Size of the physical address range to map.
> > > + * @memory: true if remapping memory, false if IO
> > >   *
> > >   * Look up the given physical address range in the list of existing ACPI memory
> > >   * mappings.  If found, get a reference to it and return a pointer to it (its
> > > @@ -321,8 +324,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
> > >   * During early init (when acpi_permanent_mmap has not been set yet) this
> > >   * routine simply calls __acpi_map_table() to get the job done.
> > >   */
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
> > > +{
> > > +       return __acpi_os_map_iomem(phys, size, false);
> > > +}
> > >  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
> > >
> > >  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> > >  {
> > > -       return (void *)acpi_os_map_iomem(phys, size);
> > > +       return (void *)__acpi_os_map_iomem(phys, size, true);
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
> > > 2.29.1
> > >
>

