Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5250927C12B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgI2JaC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 05:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgI2JaC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 05:30:02 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDC9208FE
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601371800;
        bh=qMz6dRBu3xkLlmzQHM9cqNVc+YCxlNKFzcDQQoCWO/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UQv3dVmmT8U/gdLlgDY9ISgc0E7BgAECsqrzx5sLjo43mM5nlMD88aScXu/0oaePT
         Qrnz1MKc2k28xa2IuMxjQlKmIPfh6i5j4uTMfp1yXCh+WiqJ/KVFtKeSVMmsxty9F5
         FhMSJjgz6pySHelT/QURWDnEH5oVwzqy6G12aBOc=
Received: by mail-oo1-f42.google.com with SMTP id c4so1103566oou.6
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 02:30:00 -0700 (PDT)
X-Gm-Message-State: AOAM531v8TwpiYX9A2c0MellF03wFQKi7qkLNc/D6UCxad8bevR98Vvl
        8o0iXQxHdimoVHK7NfnuO0CToMGmpg9C9VSyuYw=
X-Google-Smtp-Source: ABdhPJyY6uZlla3OzxkQ1DhZvy1VQBn/jIKVupdYVPaldzVzoy+bnpoNQ0/fgxcitRqWipl6JQ1y9ONgb+n9PHfeTrA=
X-Received: by 2002:a4a:4910:: with SMTP id z16mr3882473ooa.41.1601371799755;
 Tue, 29 Sep 2020 02:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200626155832.2323789-1-ardb@kernel.org> <20200626155832.2323789-2-ardb@kernel.org>
 <20200928170216.00006ff2@huawei.com> <CAMj1kXH1LZ15gzfW+7X5A4dMCD33DqNLnVrnLRo1zpw1Ekg+Lw@mail.gmail.com>
 <20200928181755.000019bf@huawei.com>
In-Reply-To: <20200928181755.000019bf@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Sep 2020 11:29:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLVgAc0u9pSy0cKkmQXntdqjkkoM5wpdwLiwZfKOXKPA@mail.gmail.com>
Message-ID: <CAMj1kXGLVgAc0u9pSy0cKkmQXntdqjkkoM5wpdwLiwZfKOXKPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 28 Sep 2020 at 19:18, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Sep 2020 18:49:35 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Mon, 28 Sep 2020 at 18:02, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 26 Jun 2020 17:58:31 +0200
> > > Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > > AML uses SystemMemory opregions to allow AML handlers to access MMIO
> > > > registers of, e.g., GPIO controllers, or access reserved regions of
> > > > memory that are owned by the firmware.
> > > >
> > > > Currently, we also allow AML access to memory that is owned by the
> > > > kernel and mapped via the linear region, which does not seem to be
> > > > supported by a valid use case, and exposes the kernel's internal
> > > > state to AML methods that may be buggy and exploitable.
> > > >
> > > > On arm64, ACPI support requires booting in EFI mode, and so we can cross
> > > > reference the requested region against the EFI memory map, rather than
> > > > just do a minimal check on the first page. So let's only permit regions
> > > > to be remapped by the ACPI core if
> > > > - they don't appear in the EFI memory map at all (which is the case for
> > > >   most MMIO), or
> > > > - they are covered by a single region in the EFI memory map, which is not
> > > >   of a type that describes memory that is given to the kernel at boot.
> > > >
> > > > Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Hi Ard,
> > >
> > > Ran into a problem with this one. See below
> > >
> > > > ---
> > > >  arch/arm64/include/asm/acpi.h | 15 +----
> > > >  arch/arm64/kernel/acpi.c      | 66 ++++++++++++++++++++
> > > >  2 files changed, 67 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > > index a45366c3909b..bd68e1b7f29f 100644
> > > > --- a/arch/arm64/include/asm/acpi.h
> > > > +++ b/arch/arm64/include/asm/acpi.h
> > > > @@ -47,20 +47,7 @@
> > > >  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> > > >
> > > >  /* ACPI table mapping after acpi_permanent_mmap is set */
> > > > -static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > > -                                         acpi_size size)
> > > > -{
> > > > -     /* For normal memory we already have a cacheable mapping. */
> > > > -     if (memblock_is_map_memory(phys))
> > > > -             return (void __iomem *)__phys_to_virt(phys);
> > > > -
> > > > -     /*
> > > > -      * We should still honor the memory's attribute here because
> > > > -      * crash dump kernel possibly excludes some ACPI (reclaim)
> > > > -      * regions from memblock list.
> > > > -      */
> > > > -     return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
> > > > -}
> > > > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> > > >  #define acpi_os_ioremap acpi_os_ioremap
> > > >
> > > >  typedef u64 phys_cpuid_t;
> > > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > > index a7586a4db142..01b861e225b0 100644
> > > > --- a/arch/arm64/kernel/acpi.c
> > > > +++ b/arch/arm64/kernel/acpi.c
> > > > @@ -261,6 +261,72 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
> > > >       return __pgprot(PROT_DEVICE_nGnRnE);
> > > >  }
> > > >
> > > > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > > > +{
> > > > +     efi_memory_desc_t *md, *region = NULL;
> > > > +     pgprot_t prot;
> > > > +
> > > > +     if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> > > > +             return NULL;
> > > > +
> > > > +     for_each_efi_memory_desc(md) {
> > > > +             u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
> > > > +
> > > > +             if (phys < md->phys_addr || phys >= end)
> > > > +                     continue;
> > > > +
> > > > +             if (phys + size > end) {
> > > > +                     pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
> > > > +                     return NULL;
> > > > +             }
> > > > +             region = md;
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * It is fine for AML to remap regions that are not represented in the
> > > > +      * EFI memory map at all, as it only describes normal memory, and MMIO
> > > > +      * regions that require a virtual mapping to make them accessible to
> > > > +      * the EFI runtime services.
> > > > +      */
> > > > +     prot = __pgprot(PROT_DEVICE_nGnRnE);
> > > > +     if (region) {
> > > > +             switch (region->type) {
> > > > +             case EFI_LOADER_CODE:
> > > > +             case EFI_LOADER_DATA:
> > >
> > > Unfortunately this seems to have broken overriding of ACPI tables from an initrd.
> > > My particular test environment is qemu + EDK2.
> > >
> > > It only has obvious visible affect on tables that are used late in the boot such as PPTT
> > > as they get dropped before they are used.
> > >
> > > These are read after ACPICA is initialized and acpi_reallocate_root_table()
> > > has been called.  The back trace is:
> > >
> > > acpi_os_ioremap+0xfc/0x288
> > > acpi_os_map_iomem+0xc4/0x188
> > > acpi_os_map_memory+0x18/0x28
> > > acpi_tb_acquire_table+0x54/0x8c
> > > acpi_tb_validate_table+0x34/0x5c
> > > acpi_tb_validate_temp_table+0x34/0x40
> > > acpi_tb_verify_temp_table+0x48/0x250
> > > acpi_reallocate_root_table+0x12c/0x160
> > >
> > > Seems that the table is in a region of type EFI_LOADER_DATA.
> > >
> > > I don't really know enough about this area to be sure what the right fix is or
> > > even whether this is a kernel issue, or one that should be fixed elsewhere in
> > > the stack.
> > >
> > > For now I'm just carry a hack that treats EFI_LOADER_DATA in the same fashion as
> > > EFI_ACPI_RECLAIM_MEMORY below.
> > >
> > > What's the right way to fix this?
> > >
> >
> > Hi Jonathan,
> >
> > That is an excellent question.
> >
> > The purpose of this change is to ensure that firmware cannot
> > manipulate the internal state of the kernel. So as long as we can
> > ensure that this memory is not claimed by the kernel's memory
> > subsystem, we should be fine.
> >
> > Since this is an obvious debug feature, what we could do is reserve
> > this memory permanently in some way, and make the test take this into
> > account.
>
> Whilst it is a debug feature, I wonder if it gets shipped in production
> hardware.  If not, could be we cynical and just drop the check if the
> relevant config option is enabled?
>
> Perhaps just don't release the EFI_LOADER_DATA for other use? (if
> this option is enabled only)
>
> >
> > Do you have a full stack trace? How early does this run?
>
> For the place where it first occurs, ie the trace above, the acpi_reallocate_root_table() is
> the call from acpi_early_init() from start_kernel().
>
> We hit the table a lot during later calls though and hence would run into the
> same problem.
>

Could you try the patch below? Since the memory holding the tables is
already memblock_reserve()d, we can just mark it NOMAP, and permit r/o
remapping of NOMAP regions.

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a85174d05473..84da869c5ac4 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -298,8 +298,11 @@ void __iomem
*acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
                case EFI_BOOT_SERVICES_DATA:
                case EFI_CONVENTIONAL_MEMORY:
                case EFI_PERSISTENT_MEMORY:
-                       pr_warn(FW_BUG "requested region covers kernel
memory @ %pa\n", &phys);
-                       return NULL;
+                       if (memblock_is_map_memory(phys)) {
+                               pr_warn(FW_BUG "requested region
covers kernel memory @ %pa\n", &phys);
+                               return NULL;
+                       }
+                       fallthrough;

                case EFI_RUNTIME_SERVICES_CODE:
                        /*
@@ -388,3 +391,8 @@ int apei_claim_sea(struct pt_regs *regs)

        return err;
 }
+
+void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
+{
+       memblock_mark_nomap(addr, size);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1e4cdc6c7ae2..64ae25c59d55 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -958,7 +958,7 @@ void acpi_os_set_prepare_extended_sleep(int
(*func)(u8 sleep_state,
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
                                           u32 val_a, u32 val_b);

-#ifdef CONFIG_X86
+#ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
 static inline void arch_reserve_mem_area(acpi_physical_address addr,
