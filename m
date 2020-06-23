Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F65205742
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgFWQcj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jun 2020 12:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFWQcj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jun 2020 12:32:39 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EBE20780
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2020 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592929958;
        bh=/3evFAwZpZFU3dLUN/cI7LQ/8m7HRKlC+XGBgEmTpQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RzsqA05NDHHXRVCLj7nwheeq860zgxEBrzzUHd1FDEnOFIXAGQV1v9+ODyQVvgFVo
         rIuOXmLOj1tSktq0WJFsdK/EpV4EZVPcnPNBGuTbjHYr7D/Zr02YaGskRCExx0MGLt
         uGY/KNxcffHP26v/Io9tvsAAFdUwTRknKo6tge64=
Received: by mail-ot1-f43.google.com with SMTP id k15so17235257otp.8
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2020 09:32:37 -0700 (PDT)
X-Gm-Message-State: AOAM530RljB+OMCEln/BMuPKTccJSVMRIN5rb3PPQQrsz8KY4irNZqpE
        8SaWBHY99r3ymh+79cCWw0APf14mEizr0WScPIQ=
X-Google-Smtp-Source: ABdhPJyI8htVk9ZwsMKUCMDaYBDD/SPtvyhwclzWmwKAPzdFLtRYQFrE1BgGUSSTuU1gdaNhZWzEOgp0+HLyF1EIB5I=
X-Received: by 2002:a4a:6812:: with SMTP id p18mr19526893ooc.45.1592929957216;
 Tue, 23 Jun 2020 09:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200623093755.1534006-1-ardb@kernel.org> <20200623162655.GA22650@red-moon.cambridge.arm.com>
In-Reply-To: <20200623162655.GA22650@red-moon.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Jun 2020 18:32:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwnDGV=J7kdtzrPY9hT=Bp6XRCw85urK2MLXsZG3zdMw@mail.gmail.com>
Message-ID: <CAMj1kXEwnDGV=J7kdtzrPY9hT=Bp6XRCw85urK2MLXsZG3zdMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 23 Jun 2020 at 18:27, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Jun 23, 2020 at 11:37:55AM +0200, Ard Biesheuvel wrote:
> > AML uses SystemMemory opregions to allow AML handlers to access MMIO
> > registers of, e.g., GPIO controllers, or access reserved regions of
> > memory that are owned by the firmware.
> >
> > Currently, we also allow AML access to memory that is owned by the
> > kernel and mapped via the linear region, which does not seem to be
> > supported by a valid use case, and exposes the kernel's internal
> > state to AML methods that may be buggy and exploitable.
> >
> > On arm64, ACPI support requires booting in EFI mode, and so we can cross
> > reference the requested region against the EFI memory map, rather than
> > just do a minimal check on the first page. So let's only permit regions
> > to be remapped by the ACPI core if
> > - they don't appear in the EFI memory map at all (which is the case for
> >   most MMIO), or
> > - they are covered by a single region in the EFI memory map, which is not
> >   of a type that describes memory that is given to the kernel at boot.
> >
> > Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > v2: do a more elaborate check on the region, against the EFI memory map
> >
> >  arch/arm64/include/asm/acpi.h | 15 +---
> >  arch/arm64/kernel/acpi.c      | 72 ++++++++++++++++++++
> >  2 files changed, 73 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > index a45366c3909b..bd68e1b7f29f 100644
> > --- a/arch/arm64/include/asm/acpi.h
> > +++ b/arch/arm64/include/asm/acpi.h
> > @@ -47,20 +47,7 @@
> >  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> >
> >  /* ACPI table mapping after acpi_permanent_mmap is set */
> > -static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > -                                         acpi_size size)
> > -{
> > -     /* For normal memory we already have a cacheable mapping. */
> > -     if (memblock_is_map_memory(phys))
> > -             return (void __iomem *)__phys_to_virt(phys);
> > -
> > -     /*
> > -      * We should still honor the memory's attribute here because
> > -      * crash dump kernel possibly excludes some ACPI (reclaim)
> > -      * regions from memblock list.
> > -      */
> > -     return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
> > -}
> > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> >  #define acpi_os_ioremap acpi_os_ioremap
> >
> >  typedef u64 phys_cpuid_t;
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index a7586a4db142..4696f765d1ac 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -261,6 +261,78 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
> >       return __pgprot(PROT_DEVICE_nGnRnE);
> >  }
> >
> > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > +{
> > +     efi_memory_desc_t *md, *region = NULL;
> > +     pgprot_t prot;
> > +
> > +     if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> > +             return NULL;
> > +
> > +     for_each_efi_memory_desc(md) {
> > +             u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
> > +
> > +             if (phys < md->phys_addr || phys >= end)
> > +                     continue;
> > +
> > +             if (phys + size > end) {
> > +                     pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
> > +                     return NULL;
> > +             }
> > +             region = md;
> > +             break;
> > +     }
> > +
> > +     /*
> > +      * It is fine for AML to remap regions that are not represented in the
> > +      * EFI memory map at all, as it only describes normal memory, and MMIO
> > +      * regions that require a virtual mapping to make them accessible to
> > +      * the EFI runtime services.
> > +      */
> > +     prot = __pgprot(PROT_DEVICE_nGnRnE);
> > +     if (region) {
> > +             switch (region->type) {
> > +             case EFI_LOADER_CODE:
> > +             case EFI_LOADER_DATA:
> > +             case EFI_BOOT_SERVICES_CODE:
> > +             case EFI_BOOT_SERVICES_DATA:
> > +             case EFI_CONVENTIONAL_MEMORY:
> > +             case EFI_PERSISTENT_MEMORY:
> > +                     pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> > +                     return NULL;
> > +
> > +             case EFI_ACPI_RECLAIM_MEMORY:
> > +                     /*
> > +                      * ACPI reclaim memory is used to pass firmware tables
> > +                      * and other data that is intended for consumption by
> > +                      * the OS only, which may decide it wants to reclaim
> > +                      * that memory and use it for something else. We never
> > +                      * do that, but we add it to the linear map anyway, and
> > +                      * so we must use the existing mapping.
> > +                      */
> > +                     return (void __iomem *)__phys_to_virt(phys);
>
> For my own understanding - we have to keep this mapping (given the
> current kernel code and tables handling) which means that this patch
> mitigates (correctly) the issue but can't solve it in its entirety.
>

Yes. The ACPI core uses acpi_os_ioremap() to map all the ACPI tables
at boot, which are passed in ACPI reclaim memory, which is already
mapped in the linear region at this point.

Actually, come to think of it, this is probably incorrect for kexec,
as the kernel may not have mapped such regions in its linear map, so
we still need the memblock_is_map_memory() test here.

> > +             case EFI_RUNTIME_SERVICES_CODE:
> > +                     /*
> > +                      * This would be unusual, but not problematic per se,
> > +                      * as long as we take care not to create a writable
> > +                      * mapping for executable code.
> > +                      */
> > +                     prot = PAGE_KERNEL_RO;
>
> Nit: IIUC this tweaks the current behaviour (so it is probably better
> to move this change to another patch).
>

OK

> Other than that the patch is sound and probably the best we could
> do to harden the code, goes without saying - it requires testing.
>

Indeed. I will do some testing on the systems I have access to, and
hopefully, other will as well.


> Thanks for putting it together.
>
> Lorenzo
>
> > +                     break;
> > +
> > +             default:
> > +                     if (region->attribute & EFI_MEMORY_WB)
> > +                             prot = PAGE_KERNEL;
> > +                     else if (region->attribute & EFI_MEMORY_WT)
> > +                             prot = __pgprot(PROT_NORMAL_WT);
> > +                     else if (region->attribute & EFI_MEMORY_WC)
> > +                             prot = __pgprot(PROT_NORMAL_NC);
> > +             }
> > +     }
> > +     return __ioremap(phys, size, prot);
> > +}
> > +
> >  /*
> >   * Claim Synchronous External Aborts as a firmware first notification.
> >   *
> > --
> > 2.27.0
> >
