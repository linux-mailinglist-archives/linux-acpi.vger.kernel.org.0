Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C363E834E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Aug 2021 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhHJS4J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Aug 2021 14:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhHJS4J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Aug 2021 14:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3CE160EC0;
        Tue, 10 Aug 2021 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628621746;
        bh=F5kTOFRnzjAJrBKXolCjL+dzW0Enob7L6Qo6a9N/FIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnF0CNC25E4oa/W7CwgBWzcyamvcXR62RJwDP1+hoIvOaCnu6u6aaG77F5mBgJCO6
         4/bGSTge8ClhoeunKJAzJ948hRgjQhIptS3R43yp9ARM8MtNPwXNGLvI8CiIj/L11a
         aS+QzDaj3VIGg6EaJg5/UnzPR69tHjLIu96HzU6VtDhhLT47ayOMpo93dX53xzQyCA
         0uiuaEGSP5AXuhVpYg5Gv491i3avovaTEBaFIzzGVCIjksQJmFkaS+f4ZtRb2qSNYM
         6NrahHn7t/d0xhmc6bQ/nDGDJevaDydcqBRpnmxTlLIiwMsiULeezD+vRbWUP3bIvk
         61vSADYEw+Xnw==
Date:   Tue, 10 Aug 2021 21:55:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        x86@kernel.org, Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3] memblock: make memblock_find_in_range method private
Message-ID: <YRLLpImNhZaLzs3z@kernel.org>
References: <20210803064218.6611-1-rppt@kernel.org>
 <20210809190641.GA1176508@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809190641.GA1176508@roeck-us.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 09, 2021 at 12:06:41PM -0700, Guenter Roeck wrote:
> On Tue, Aug 03, 2021 at 09:42:18AM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > There are a lot of uses of memblock_find_in_range() along with
> > memblock_reserve() from the times memblock allocation APIs did not exist.
> > 
> > memblock_find_in_range() is the very core of memblock allocations, so any
> > future changes to its internal behaviour would mandate updates of all the
> > users outside memblock.
> > 
> > Replace the calls to memblock_find_in_range() with an equivalent calls to
> > memblock_phys_alloc() and memblock_phys_alloc_range() and make
> > memblock_find_in_range() private method of memblock.
> > 
> > This simplifies the callers, ensures that (unlikely) errors in
> > memblock_reserve() are handled and improves maintainability of
> > memblock_find_in_range().
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I see a number of crashes in next-20210806 when booting x86 images from efi.
> 
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi: SMBIOS=0x1fbcc000 ACPI=0x1fbfa000 ACPI 2.0=0x1fbfa014 MEMATTR=0x1f25f018
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [    0.000000] last_pfn = 0x1ff50 max_arch_pfn = 0x400000000
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000000] Kernel panic - not syncing: alloc_low_pages: can not alloc memory
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc4-next-20210806 #1
> [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [    0.000000] Call Trace:
> [    0.000000]  ? dump_stack_lvl+0x57/0x7d
> [    0.000000]  ? panic+0xfc/0x2c6
> [    0.000000]  ? alloc_low_pages+0x117/0x156
> [    0.000000]  ? phys_pmd_init+0x234/0x342
> [    0.000000]  ? phys_pud_init+0x171/0x337
> [    0.000000]  ? __kernel_physical_mapping_init+0xec/0x276
> [    0.000000]  ? init_memory_mapping+0x1ea/0x2aa
> [    0.000000]  ? init_range_memory_mapping+0xdf/0x12e
> [    0.000000]  ? init_mem_mapping+0x1e9/0x26f
> [    0.000000]  ? setup_arch+0x5ff/0xb6d
> [    0.000000]  ? start_kernel+0x71/0x6b4
> [    0.000000]  ? secondary_startup_64_no_verify+0xc2/0xcb
> 
> Bisect points to this patch. Reverting it fixes the problem. Key seems to
> be the amount of memory configured in qemu; the problem is not seen if
> there is 1G or more of memory, but it is seen with all test boots with
> 512M or 256M of memory. It is also seen with almost all 32-bit efi boots.
> 
> The problem is not seen when booting without efi.

It looks like this change uncovered a problem in
x86::memory_map_top_down(). 

The allocation in alloc_low_pages() is limited by min_pfn_mapped and
max_pfn_mapped. The min_pfn_mapped is updated at every iteration of the
loop in memory_map_top_down, but there is another loop in
init_range_memory_mapping() that maps several regions below the current
min_pfn_mapped without updating this variable.

The memory layout in qemu with 256M of RAM and EFI enabled, causes
exhaustion of the memory limited by min_pfn_mapped and max_pfn_mapped
before min_pfn_mapped is updated.

Before this commit there was unconditional "reservation" of 2M in the end
of the memory that moved the initial min_pfn_mapped below the memory
reserved by EFI. The addition of check for xen_domain() removed this
reservation for !XEN and made alloc_low_pages() use the range already busy
with EFI data.

The patch below moves the update of min_pfn_mapped near the update of
max_pfn_mapped so that every time a new range is mapped both limits will be
updated accordingly.

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1152a29ce109..be279f6e5a0a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1,3 +1,4 @@
+#define DEBUG
 #include <linux/gfp.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
@@ -485,6 +486,7 @@ static void add_pfn_range_mapped(unsigned long start_pfn, unsigned long end_pfn)
 	nr_pfn_mapped = clean_sort_range(pfn_mapped, E820_MAX_ENTRIES);
 
 	max_pfn_mapped = max(max_pfn_mapped, end_pfn);
+	min_pfn_mapped = min(min_pfn_mapped, start_pfn);
 
 	if (start_pfn < (1UL<<(32-PAGE_SHIFT)))
 		max_low_pfn_mapped = max(max_low_pfn_mapped,
@@ -643,7 +645,6 @@ static void __init memory_map_top_down(unsigned long map_start,
 		mapped_ram_size += init_range_memory_mapping(start,
 							last_start);
 		last_start = start;
-		min_pfn_mapped = last_start >> PAGE_SHIFT;
 		if (mapped_ram_size >= step_size)
 			step_size = get_new_step_size(step_size);
 	}
 

> Guenter
> 
> ---
> Bisect log:
> 
> # bad: [da454ebf578f6c542ba9f5b3ddb98db3ede109c1] Add linux-next specific files for 20210809
> # good: [36a21d51725af2ce0700c6ebcb6b9594aac658a6] Linux 5.14-rc5
> git bisect start 'HEAD' 'v5.14-rc5'
> # good: [d22fda64bea5f33000e31e5b7e4ba876bca37436] Merge remote-tracking branch 'crypto/master'
> git bisect good d22fda64bea5f33000e31e5b7e4ba876bca37436
> # good: [b084da3a98fad27a39ed5ca64106b86df0417851] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
> git bisect good b084da3a98fad27a39ed5ca64106b86df0417851
> # good: [a5383d1f57190a33c6afc25c62b9907d84ba2bc6] Merge remote-tracking branch 'staging/staging-next'
> git bisect good a5383d1f57190a33c6afc25c62b9907d84ba2bc6
> # good: [a439da3e6abeb054f4e6b0d37814e762b7340196] Merge remote-tracking branch 'seccomp/for-next/seccomp'
> git bisect good a439da3e6abeb054f4e6b0d37814e762b7340196
> # bad: [9801f3c0890c7b992b45a5c2afcb16c5cdc8388e] mm/idle_page_tracking: Make PG_idle reusable
> git bisect bad 9801f3c0890c7b992b45a5c2afcb16c5cdc8388e
> # good: [b4f7f4a9b542836683308d48ffdd18471c6f3e76] lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix
> git bisect good b4f7f4a9b542836683308d48ffdd18471c6f3e76
> # good: [e30842a48c36f094271eea0984bb861b49c49c87] mm/vmscan: add 'else' to remove check_pending label
> git bisect good e30842a48c36f094271eea0984bb861b49c49c87
> # bad: [65300b20a21214fb2043419d4e5da1d9947c6e15] mm/madvise: add MADV_WILLNEED to process_madvise()
> git bisect bad 65300b20a21214fb2043419d4e5da1d9947c6e15
> # bad: [7348da7a8c244d1a755bc5838b04cb9b1b6ee06c] memblock: make memblock_find_in_range method private
> git bisect bad 7348da7a8c244d1a755bc5838b04cb9b1b6ee06c
> # good: [98f8c467fe2ba8e553b450b2a3294d69f1f2027f] mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix
> git bisect good 98f8c467fe2ba8e553b450b2a3294d69f1f2027f
> # good: [760ded422ebe4f8899905b752d8378c44f2a78f3] mm/memplicy: add page allocation function for MPOL_PREFERRED_MANY policy
> git bisect good 760ded422ebe4f8899905b752d8378c44f2a78f3
> # good: [fbfa0492d9639b67119d3d94b7a6a3f85e064260] mm/mempolicy: advertise new MPOL_PREFERRED_MANY
> git bisect good fbfa0492d9639b67119d3d94b7a6a3f85e064260
> # good: [ff6d5759a871883aeea38309fb16d91666179328] mm/mempolicy: unify the create() func for bind/interleave/prefer-many policies
> git bisect good ff6d5759a871883aeea38309fb16d91666179328
> # first bad commit: [7348da7a8c244d1a755bc5838b04cb9b1b6ee06c] memblock: make memblock_find_in_range method private

-- 
Sincerely yours,
Mike.
