Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99383D5F14
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jul 2021 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhGZPQp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Jul 2021 11:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237459AbhGZPPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jul 2021 11:15:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C890A6108B;
        Mon, 26 Jul 2021 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627314945;
        bh=llO7j+UYXFsFMGBP2Lr/phtn9B//6nPGyDgjSbRlY04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPTCKa8I0cjzgvmONZeN6PppfX+OowPyjg4RadHLiH+yFgnEge5sjLCoWkJlwEHPC
         Fe/Hj93b68vv0V5PRbPCsdQ1Cs5Xsws5EWoBald+Qx69bNw9YRlfq05K/LFzwxWR2C
         +D8XY/7YCmczRW7+avKsrggGDPLZ3lJToHGcglC3b0aSjh67M12nqSPqNfco8/a5Vz
         2jdOLeMN9JyVt3b5P42RvHrqVBdLaFgRr0CUkmjl8q5k8NObN/vAhYkzYfJAytF6TX
         QZ6Akd8pGTgYGjiWnqysaifPhEF9learIDKmz7m+1MmOta9wdgPQQqtPvQk1+EmadC
         7RWsJh8uQV+Nw==
Received: by mail-oi1-f180.google.com with SMTP id t128so11440230oig.1;
        Mon, 26 Jul 2021 08:55:45 -0700 (PDT)
X-Gm-Message-State: AOAM530cUuxkoiW96k5t3F4eSztXM4UCWCvgMXgZKIxXLQDY0HKNhbDB
        ap1HJR0nrIcnYhZWV0awOv632TLCvrckAWvbkqQ=
X-Google-Smtp-Source: ABdhPJzsnZRK2dUpbW/8bb75AEj5Bo85v5fsReYlqOBZKeEw6dZnYT0cB96unuFOEhR4KREO34Mdu1Pb20xk9W0547s=
X-Received: by 2002:aca:4c49:: with SMTP id z70mr11433310oia.174.1627314945217;
 Mon, 26 Jul 2021 08:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Jul 2021 17:55:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com>
Message-ID: <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com>
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

On Mon, 26 Jul 2021 at 12:00, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> The memory attributes attached to memory regions depend on architecture
> specific mappings.
>
> For some memory regions, the attributes specified by firmware (eg
> uncached) are not sufficient to determine how a memory region should be
> mapped by an OS (for instance a region that is define as uncached in
> firmware can be mapped as Normal or Device memory on arm64) and
> therefore the OS must be given control on how to map the region to match
> the expected mapping behaviour (eg if a mapping is requested with memory
> semantics, it must allow unaligned accesses).
>
> Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> them into two separate code paths:
>
> acpi_os_memmap() -> memory semantics
> acpi_os_ioremap() -> MMIO semantics
>
> The split allows the architectural implementation back-ends to detect
> the default memory attributes required by the mapping in question
> (ie the mapping API defines the semantics memory vs MMIO) and map the
> memory accordingly.
>
> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

For the patch in general

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Couple of nits/questions below

> ---
>  arch/arm64/include/asm/acpi.h |  3 +++
>  arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
>  drivers/acpi/osl.c            | 23 ++++++++++++++++-------
>  include/acpi/acpi_io.h        |  8 ++++++++
>  4 files changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f..7535dc7cc5aa 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -50,6 +50,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
>  #define acpi_os_ioremap acpi_os_ioremap
>
> +void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size);
> +#define acpi_os_memmap acpi_os_memmap
> +
>  typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HWID
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index f3851724fe35..1c9c2f7a1c04 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -273,7 +273,8 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>         return __pgprot(PROT_DEVICE_nGnRnE);
>  }
>
> -void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +static void __iomem *__acpi_os_ioremap(acpi_physical_address phys,
> +                                      acpi_size size, bool memory)
>  {
>         efi_memory_desc_t *md, *region = NULL;
>         pgprot_t prot;
> @@ -299,9 +300,11 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>          * It is fine for AML to remap regions that are not represented in the
>          * EFI memory map at all, as it only describes normal memory, and MMIO
>          * regions that require a virtual mapping to make them accessible to
> -        * the EFI runtime services.
> +        * the EFI runtime services. Determine the region default
> +        * attributes by checking the requested memory semantics.
>          */
> -       prot = __pgprot(PROT_DEVICE_nGnRnE);
> +       prot = memory ? __pgprot(PROT_NORMAL_NC) :
> +                       __pgprot(PROT_DEVICE_nGnRnE);
>         if (region) {
>                 switch (region->type) {
>                 case EFI_LOADER_CODE:
> @@ -361,6 +364,16 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>         return __ioremap(phys, size, prot);
>  }
>
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +{
> +       return __acpi_os_ioremap(phys, size, false);
> +}
> +
> +void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size)
> +{
> +       return __acpi_os_ioremap(phys, size, true);
> +}
> +
>  /*
>   * Claim Synchronous External Aborts as a firmware first notification.
>   *
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45e33..6db62f3a390e 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -284,7 +284,8 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
>  #define should_use_kmap(pfn)   page_is_ram(pfn)
>  #endif
>
> -static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
> +static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz,
> +                             bool memory)
>  {
>         unsigned long pfn;
>
> @@ -294,7 +295,8 @@ static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
>                         return NULL;
>                 return (void __iomem __force *)kmap(pfn_to_page(pfn));
>         } else
> -               return acpi_os_ioremap(pg_off, pg_sz);
> +               return memory ? acpi_os_memmap(pg_off, pg_sz) :
> +                               acpi_os_ioremap(pg_off, pg_sz);
>  }
>
>  static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
> @@ -309,9 +311,10 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
>  }
>
>  /**
> - * acpi_os_map_iomem - Get a virtual address for a given physical address range.
> + * __acpi_os_map_iomem - Get a virtual address for a given physical address range.
>   * @phys: Start of the physical address range to map.
>   * @size: Size of the physical address range to map.
> + * @memory: true if remapping memory, false if IO
>   *
>   * Look up the given physical address range in the list of existing ACPI memory
>   * mappings.  If found, get a reference to it and return a pointer to it (its
> @@ -321,8 +324,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
>   * During early init (when acpi_permanent_mmap has not been set yet) this
>   * routine simply calls __acpi_map_table() to get the job done.
>   */
> -void __iomem __ref
> -*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> +static void __iomem __ref
> +*__acpi_os_map_iomem(acpi_physical_address phys, acpi_size size, bool memory)
>  {
>         struct acpi_ioremap *map;
>         void __iomem *virt;
> @@ -353,7 +356,7 @@ void __iomem __ref
>
>         pg_off = round_down(phys, PAGE_SIZE);
>         pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
> -       virt = acpi_map(phys, size);
> +       virt = acpi_map(phys, size, memory);
>         if (!virt) {
>                 mutex_unlock(&acpi_ioremap_lock);
>                 kfree(map);
> @@ -372,11 +375,17 @@ void __iomem __ref
>         mutex_unlock(&acpi_ioremap_lock);
>         return map->virt + (phys - map->phys);
>  }
> +
> +void __iomem __ref
> +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)

I am aware that this just duplicated the prototype above, but I think
this should be

void __iomem *__ref

given that the __ref comes after the * in the prototype below.

> +{
> +       return __acpi_os_map_iomem(phys, size, false);
> +}
>  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
>
>  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
>  {
> -       return (void *)acpi_os_map_iomem(phys, size);
> +       return (void *)__acpi_os_map_iomem(phys, size, true);

I think this should be (__force void *) to shut up sparse address
space warnings.

>  }
>  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
>
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index 027faa8883aa..a0212e67d6f4 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -14,6 +14,14 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  }
>  #endif
>
> +#ifndef acpi_os_memmap
> +static inline void __iomem *acpi_os_memmap(acpi_physical_address phys,
> +                                           acpi_size size)
> +{
> +       return ioremap_cache(phys, size);
> +}
> +#endif
> +
>  extern bool acpi_permanent_mmap;
>
>  void __iomem __ref
> --
> 2.31.0
>
