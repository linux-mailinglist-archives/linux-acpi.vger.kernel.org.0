Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002BA3DDBA9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhHBO4c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 10:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhHBO4b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 10:56:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42FE760F9E;
        Mon,  2 Aug 2021 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916182;
        bh=KsE+lIG2EnoZ7ZovXs4XjVtdiZlJ/+tn9HBYRxJuidY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gwR+eIFMtIjEpPzhPvJxYWKdWFNHEnKyBoY5Wl4rT2xqtkUPmde1/edUJA7Lhf0VZ
         tJwfHA++0GOoAcixHFC0WceeV2WkcFqw+Ej1ONeSS2Mpy0oGt9UybdHBgKPUi7z2XO
         +43nLcRL2nyva6zvewC7Dcw1Enrj1BHBRMO8mMFUxOThtTpuJ/KVC3JIwVebQL9xje
         6utOOg1BTvfSm9BcRZYUhyF3431gzi+5UORpg1kKR5OqfSvgkJ2BPJjmp2Q0e+G4Cm
         PbR2L0yHVgWOitGr4Fb5j8ymK6/inYLALLj8XZkP0hrlSPJdHOABCgmKidQraFWUH1
         /YIClQ2DBdqfA==
Received: by mail-lf1-f49.google.com with SMTP id h14so34190365lfv.7;
        Mon, 02 Aug 2021 07:56:22 -0700 (PDT)
X-Gm-Message-State: AOAM530hqHw787ZJqnNmvz+PjdxAWhfP5vGCrIOpVu6emEKS2DeSYOic
        3oaebGuXRs14RHkoDCfeZp2ByyPh06C97/OFdA==
X-Google-Smtp-Source: ABdhPJyJrEyjrOdrITCgsnEo8nW14bmCCMANnitM9MlIaaaRSPL7c9xkbdvH/F1rz4v6F2CGNtlg/gwTvFgM5e8wgaI=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr20049107edt.194.1627916169555;
 Mon, 02 Aug 2021 07:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210802063737.22733-1-rppt@kernel.org>
In-Reply-To: <20210802063737.22733-1-rppt@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Aug 2021 08:55:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+i17C=+9bg=XPattuHe+M8NE3B29+FCg4p3-bPDgSaKw@mail.gmail.com>
Message-ID: <CAL_Jsq+i17C=+9bg=XPattuHe+M8NE3B29+FCg4p3-bPDgSaKw@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: make memblock_find_in_range method private
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <lenb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 2, 2021 at 12:37 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> There are a lot of uses of memblock_find_in_range() along with
> memblock_reserve() from the times memblock allocation APIs did not exist.
>
> memblock_find_in_range() is the very core of memblock allocations, so any
> future changes to its internal behaviour would mandate updates of all the
> users outside memblock.
>
> Replace the calls to memblock_find_in_range() with an equivalent calls to
> memblock_phys_alloc() and memblock_phys_alloc_range() and make
> memblock_find_in_range() private method of memblock.
>
> This simplifies the callers, ensures that (unlikely) errors in
> memblock_reserve() are handled and improves maintainability of
> memblock_find_in_range().
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2: don't change error message in arm::reserve_crashkernel(), per Russell
> v1: https://lore.kernel.org/lkml/20210730104039.7047-1-rppt@kernel.org
>
>  arch/arm/kernel/setup.c           | 18 +++++--------
>  arch/arm64/kvm/hyp/reserved_mem.c |  9 +++----
>  arch/arm64/mm/init.c              | 36 ++++++++-----------------
>  arch/mips/kernel/setup.c          | 14 +++++-----
>  arch/riscv/mm/init.c              | 44 ++++++++++---------------------
>  arch/s390/kernel/setup.c          | 10 ++++---
>  arch/x86/kernel/aperture_64.c     |  5 ++--
>  arch/x86/mm/init.c                | 21 +++++++++------
>  arch/x86/mm/numa.c                |  5 ++--
>  arch/x86/mm/numa_emulation.c      |  5 ++--
>  arch/x86/realmode/init.c          |  2 +-
>  drivers/acpi/tables.c             |  5 ++--
>  drivers/base/arch_numa.c          |  5 +---
>  drivers/of/of_reserved_mem.c      | 12 ++++++---
>  include/linux/memblock.h          |  2 --
>  mm/memblock.c                     |  2 +-
>  16 files changed, 78 insertions(+), 117 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f97eb2371672..67f5421b2af7 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1012,31 +1012,25 @@ static void __init reserve_crashkernel(void)
>                 unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
>                 if (crash_max > lowmem_max)
>                         crash_max = lowmem_max;
> -               crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
> -                                                   crash_size, CRASH_ALIGN);
> +
> +               crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +                                                      CRASH_ALIGN, crash_max);
>                 if (!crash_base) {
>                         pr_err("crashkernel reservation failed - No suitable area found.\n");
>                         return;
>                 }
>         } else {
> +               unsigned long long crash_max = crash_base + crash_size;
>                 unsigned long long start;
>
> -               start = memblock_find_in_range(crash_base,
> -                                              crash_base + crash_size,
> -                                              crash_size, SECTION_SIZE);
> +               start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
> +                                                 crash_base, crash_max);
>                 if (start != crash_base) {

If this is true and start is non-zero, then you need an
memblock_free(). However, since the range is equal to the size, then
that can never happen and just checking !start is sufficient.

>                         pr_err("crashkernel reservation failed - memory is in use.\n");
>                         return;
>                 }
>         }
>
> -       ret = memblock_reserve(crash_base, crash_size);
> -       if (ret < 0) {
> -               pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
> -                       (unsigned long)crash_base);
> -               return;
> -       }
> -
>         pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
>                 (unsigned long)(crash_size >> 20),
>                 (unsigned long)(crash_base >> 20),
> diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
> index d654921dd09b..578670e3f608 100644
> --- a/arch/arm64/kvm/hyp/reserved_mem.c
> +++ b/arch/arm64/kvm/hyp/reserved_mem.c
> @@ -92,12 +92,10 @@ void __init kvm_hyp_reserve(void)
>          * this is unmapped from the host stage-2, and fallback to PAGE_SIZE.
>          */
>         hyp_mem_size = hyp_mem_pages << PAGE_SHIFT;
> -       hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
> -                                             ALIGN(hyp_mem_size, PMD_SIZE),
> -                                             PMD_SIZE);
> +       hyp_mem_base = memblock_phys_alloc(ALIGN(hyp_mem_size, PMD_SIZE),
> +                                          PMD_SIZE);
>         if (!hyp_mem_base)
> -               hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
> -                                                     hyp_mem_size, PAGE_SIZE);
> +               hyp_mem_base = memblock_phys_alloc(hyp_mem_size, PAGE_SIZE);
>         else
>                 hyp_mem_size = ALIGN(hyp_mem_size, PMD_SIZE);
>
> @@ -105,7 +103,6 @@ void __init kvm_hyp_reserve(void)
>                 kvm_err("Failed to reserve hyp memory\n");
>                 return;
>         }
> -       memblock_reserve(hyp_mem_base, hyp_mem_size);
>
>         kvm_info("Reserved %lld MiB at 0x%llx\n", hyp_mem_size >> 20,
>                  hyp_mem_base);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8490ed2917ff..d566478a06dd 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -74,6 +74,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>         unsigned long long crash_base, crash_size;
> +       unsigned long crash_max = arm64_dma_phys_limit;

It all works out to the same size, but it doesn't make sense that
crash_base and crash_size are long long and crash_max is long.

>         int ret;
>
>         ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -84,33 +85,18 @@ static void __init reserve_crashkernel(void)
>
>         crash_size = PAGE_ALIGN(crash_size);
>
> -       if (crash_base == 0) {
> -               /* Current arm64 boot protocol requires 2MB alignment */
> -               crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
> -                               crash_size, SZ_2M);
> -               if (crash_base == 0) {
> -                       pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -                               crash_size);
> -                       return;
> -               }
> -       } else {
> -               /* User specifies base address explicitly. */
> -               if (!memblock_is_region_memory(crash_base, crash_size)) {
> -                       pr_warn("cannot reserve crashkernel: region is not memory\n");
> -                       return;
> -               }
> +       /* User specifies base address explicitly. */
> +       if (crash_base)
> +               crash_max = crash_base + crash_size;
>
> -               if (memblock_is_region_reserved(crash_base, crash_size)) {
> -                       pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
> -                       return;
> -               }
> -
> -               if (!IS_ALIGNED(crash_base, SZ_2M)) {
> -                       pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
> -                       return;

We've lost the alignment check.

Perhaps memblock_phys_alloc_range() should check that the start
matches the alignment. That would simplify the return handling as it
seems NULL is not the only error case.

> -               }
> +       /* Current arm64 boot protocol requires 2MB alignment */
> +       crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +                                              crash_base, crash_max);
> +       if (!crash_base) {
> +               pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> +                       crash_size);
> +               return;
>         }
> -       memblock_reserve(crash_base, crash_size);
>
>         pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>                 crash_base, crash_base + crash_size, crash_size >> 20);

[...]

> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 6534c92d0f83..31b5856010cb 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -28,7 +28,7 @@ void __init reserve_real_mode(void)
>         WARN_ON(slab_is_available());
>
>         /* Has to be under 1M so we can execute real-mode AP code. */
> -       mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
> +       mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
>         if (!mem)
>                 pr_info("No sub-1M memory is available for the trampoline\n");
>         else

Don't you need to drop the memblock_reserve() after this?
