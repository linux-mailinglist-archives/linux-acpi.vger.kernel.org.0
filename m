Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9D3E379A
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Aug 2021 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhHGXk3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Aug 2021 19:40:29 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:61380 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhHGXk2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Aug 2021 19:40:28 -0400
X-Greylist: delayed 2067 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2021 19:40:28 EDT
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 177N5gh7095297
        for <linux-acpi@vger.kernel.org>; Sun, 8 Aug 2021 02:05:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1628377537; x=1630969537;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ehVNo9Zi6sdRJRX9bB3/TWxcekSmcVgfmBxE6YPsI3w=;
        b=Vn8KLoierPuHI8MW2ysbxFsNs0R1/d7q+WCPqL0FP1hL8/Wqy1DjHIOGF1iDgnEp
        ip068onKSeeJlurh58tuPFvFS6/SIMVfsQlkL4Bji7odXo3patdPYge8BN14Zna/
        86JUWEuMBm7gNd1Cjex5BiqQdjZb+oBkuVtlt4W3SzAszGa3subTJozdpBOkcDZP
        MIHpEk2dDINwVznQgyddcp8awdY24WmL07t3hiZI+CfyDczQWfX1COnljU/g/eH1
        gxZcOO9ulb2C1V7eqTmtM4YSTSlF1g5f6LVE0Drv0KKMz+ptdpYNS/ke4hG9dvxx
        2GtZ2CqaGS26bodX1D0t2w==;
X-AuditID: 8b5b014d-b84f570000005d46-b6-610f11c161ba
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id A6.94.23878.1C11F016; Sun,  8 Aug 2021 02:05:37 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 08 Aug 2021 02:05:34 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
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
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2] memblock: make memblock_find_in_range method private
Organization: FORTH
In-Reply-To: <20210802063737.22733-1-rppt@kernel.org>
References: <20210802063737.22733-1-rppt@kernel.org>
Message-ID: <d0965f23c7ffb6b46a5b033fe242fc25@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH++559jwPy8GzseQJU7qZ5+nZzAruc1ZaavJoCnbnZWdXuMsn
        RiFyY3LU6TkaoPxspoQ848doBR4329puDbgGbOxCiFBHt7NyHYqFCxTbEHZhEBvXHf+97v15
        3+fz+uNDYVKDMJnKydNw6jxlrpwQ4ZXv1K191i1JUD4XHFgPDRYzAY45noS6S04cwtZ5AqZa
        qxDctZ5B0OwdFkL95AIB1/gZIehMFgImmtoRfPFtEpjPtWDw92A/CZ237hHQ1v0ZAtuYXwgj
        XQ0ElNscCH43Lwjhu3AJAfoWHQaeWheCq12XhdDZMCAEX69RAMGRKgzK+ATor+4VwNCPPiGU
        urwkeC1OAdy4oCXAbqvFoO9TNwYlN1MhYh0TvrqOnS2twdlSXxvOmpvMiB3xX8fYyWAQZ923
        PQTbd3aaZDv5AMnaL21kbe3lBGsLfU6y94eHSfbKxTmc1X/Zi9imgTfZnkYzeYA5LHr5KJeb
        U8ipN287IlLVG8j8XzKLrn1jwLTIsa0CURRDv8j45gsrkIiS0j8gZtZvxCpQ3GKeyhhc5SjK
        YlrCDNTfwaOM0cDU/tyDljiF0TkMsT5Or2OK9WOxnKA3MM0+d6wvo9cys6ZubKlfvILhJ5+K
        ciK9jwkOm8goJ9CJTChwXRjluMW7v45eie2RLrpdqKzGlhx2MaG6B4Ilt2eYB3OjZNT/iUW2
        N8r1SMIvM+WXmfLLTI0Ia0e0svAFRc77BYoPjqs1KkW22oZi/4P2d6Df7PcUHiSgkAcxFCaX
        iS0X45VS8VHlx59w6uNZ6hO5XIEHraJweZJYrNBnSelspYb7iOPyOfX/UwEVl6wV1PNPG8mX
        DFpTsPGQzP39TsmmO6tP2ncv6M4VzVc57696bHTs8qm+vYcOjpdmqsxZ0LohObjj6hrvdq1f
        I/mnLPHRG5E9zh0tt1wZoeffSlOlNuklJfFTp/l/WwfzxR++W5OW8soNa2Bkxhx5eHJ3w3RN
        +t1NCfuO+eP3q/plzZX6mYk/u3em3JwOPVp/Xl8k+Utr+urE3qSuY18nD7auxL0R0dsZ40+u
        TpcoTX7f0EQ483RwaOjIH6fSqJQ9Z19bk/X6rnLXe2EnFbKczwxtXoFryrYatyQGHk5VR/J0
        /Nbtgx0yWx3nuC05iGUECouyO6zpjx/+abojfGCcaps707OyWI4XqJRbNmLqAuV/e64RJK4D
        AAA=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Στις 2021-08-02 09:37, Mike Rapoport έγραψε:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are a lot of uses of memblock_find_in_range() along with
> memblock_reserve() from the times memblock allocation APIs did not 
> exist.
> 
> memblock_find_in_range() is the very core of memblock allocations, so 
> any
> future changes to its internal behaviour would mandate updates of all 
> the
> users outside memblock.
> 
> Replace the calls to memblock_find_in_range() with an equivalent calls 
> to
> memblock_phys_alloc() and memblock_phys_alloc_range() and make
> memblock_find_in_range() private method of memblock.
> 
> This simplifies the callers, ensures that (unlikely) errors in
> memblock_reserve() are handled and improves maintainability of
> memblock_find_in_range().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2: don't change error message in arm::reserve_crashkernel(), per 
> Russell
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
>  		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
>  		if (crash_max > lowmem_max)
>  			crash_max = lowmem_max;
> -		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
> -						    crash_size, CRASH_ALIGN);
> +
> +		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +						       CRASH_ALIGN, crash_max);
>  		if (!crash_base) {
>  			pr_err("crashkernel reservation failed - No suitable area 
> found.\n");
>  			return;
>  		}
>  	} else {
> +		unsigned long long crash_max = crash_base + crash_size;
>  		unsigned long long start;
> 
> -		start = memblock_find_in_range(crash_base,
> -					       crash_base + crash_size,
> -					       crash_size, SECTION_SIZE);
> +		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
> +						  crash_base, crash_max);
>  		if (start != crash_base) {
>  			pr_err("crashkernel reservation failed - memory is in use.\n");
>  			return;
>  		}
>  	}
> 
> -	ret = memblock_reserve(crash_base, crash_size);
> -	if (ret < 0) {
> -		pr_warn("crashkernel reservation failed - memory is in use 
> (0x%lx)\n",
> -			(unsigned long)crash_base);
> -		return;
> -	}
> -
>  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System
> RAM: %ldMB)\n",
>  		(unsigned long)(crash_size >> 20),
>  		(unsigned long)(crash_base >> 20),
> diff --git a/arch/arm64/kvm/hyp/reserved_mem.c
> b/arch/arm64/kvm/hyp/reserved_mem.c
> index d654921dd09b..578670e3f608 100644
> --- a/arch/arm64/kvm/hyp/reserved_mem.c
> +++ b/arch/arm64/kvm/hyp/reserved_mem.c
> @@ -92,12 +92,10 @@ void __init kvm_hyp_reserve(void)
>  	 * this is unmapped from the host stage-2, and fallback to PAGE_SIZE.
>  	 */
>  	hyp_mem_size = hyp_mem_pages << PAGE_SHIFT;
> -	hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
> -					      ALIGN(hyp_mem_size, PMD_SIZE),
> -					      PMD_SIZE);
> +	hyp_mem_base = memblock_phys_alloc(ALIGN(hyp_mem_size, PMD_SIZE),
> +					   PMD_SIZE);
>  	if (!hyp_mem_base)
> -		hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
> -						      hyp_mem_size, PAGE_SIZE);
> +		hyp_mem_base = memblock_phys_alloc(hyp_mem_size, PAGE_SIZE);
>  	else
>  		hyp_mem_size = ALIGN(hyp_mem_size, PMD_SIZE);
> 
> @@ -105,7 +103,6 @@ void __init kvm_hyp_reserve(void)
>  		kvm_err("Failed to reserve hyp memory\n");
>  		return;
>  	}
> -	memblock_reserve(hyp_mem_base, hyp_mem_size);
> 
>  	kvm_info("Reserved %lld MiB at 0x%llx\n", hyp_mem_size >> 20,
>  		 hyp_mem_base);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8490ed2917ff..d566478a06dd 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -74,6 +74,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> +	unsigned long crash_max = arm64_dma_phys_limit;
>  	int ret;
> 
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -84,33 +85,18 @@ static void __init reserve_crashkernel(void)
> 
>  	crash_size = PAGE_ALIGN(crash_size);
> 
> -	if (crash_base == 0) {
> -		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
> -				crash_size, SZ_2M);
> -		if (crash_base == 0) {
> -			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -				crash_size);
> -			return;
> -		}
> -	} else {
> -		/* User specifies base address explicitly. */
> -		if (!memblock_is_region_memory(crash_base, crash_size)) {
> -			pr_warn("cannot reserve crashkernel: region is not memory\n");
> -			return;
> -		}
> +	/* User specifies base address explicitly. */
> +	if (crash_base)
> +		crash_max = crash_base + crash_size;
> 
> -		if (memblock_is_region_reserved(crash_base, crash_size)) {
> -			pr_warn("cannot reserve crashkernel: region overlaps reserved 
> memory\n");
> -			return;
> -		}
> -
> -		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> -			pr_warn("cannot reserve crashkernel: base address is not 2MB 
> aligned\n");
> -			return;
> -		}
> +	/* Current arm64 boot protocol requires 2MB alignment */
> +	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +					       crash_base, crash_max);
> +	if (!crash_base) {
> +		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> +			crash_size);
> +		return;
>  	}
> -	memblock_reserve(crash_base, crash_size);
> 
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 23a140327a0b..f979adfd4fc2 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -452,8 +452,9 @@ static void __init mips_parse_crashkernel(void)
>  		return;
> 
>  	if (crash_base <= 0) {
> -		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_MAX,
> -							crash_size, CRASH_ALIGN);
> +		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +						       CRASH_ALIGN,
> +						       CRASH_ADDR_MAX);
>  		if (!crash_base) {
>  			pr_warn("crashkernel reservation failed - No suitable area 
> found.\n");
>  			return;
> @@ -461,8 +462,9 @@ static void __init mips_parse_crashkernel(void)
>  	} else {
>  		unsigned long long start;
> 
> -		start = memblock_find_in_range(crash_base, crash_base + crash_size,
> -						crash_size, 1);
> +		start = memblock_phys_alloc_range(crash_size, 1,
> +						  crash_base,
> +						  crash_base + crash_size);
>  		if (start != crash_base) {
>  			pr_warn("Invalid memory region reserved for crash kernel\n");
>  			return;
> @@ -656,10 +658,6 @@ static void __init arch_mem_init(char **cmdline_p)
>  	mips_reserve_vmcore();
> 
>  	mips_parse_crashkernel();
> -#ifdef CONFIG_KEXEC
> -	if (crashk_res.start != crashk_res.end)
> -		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
> -#endif
>  	device_tree_init();
> 
>  	/*
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a14bf3910eec..88649337c568 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -812,38 +812,22 @@ static void __init reserve_crashkernel(void)
> 
>  	crash_size = PAGE_ALIGN(crash_size);
> 
> -	if (crash_base == 0) {
> -		/*
> -		 * Current riscv boot protocol requires 2MB alignment for
> -		 * RV64 and 4MB alignment for RV32 (hugepage size)
> -		 */
> -		crash_base = memblock_find_in_range(search_start, search_end,
> -						    crash_size, PMD_SIZE);
> -
> -		if (crash_base == 0) {
> -			pr_warn("crashkernel: couldn't allocate %lldKB\n",
> -				crash_size >> 10);
> -			return;
> -		}
> -	} else {
> -		/* User specifies base address explicitly. */
> -		if (!memblock_is_region_memory(crash_base, crash_size)) {
> -			pr_warn("crashkernel: requested region is not memory\n");
> -			return;
> -		}
> -
> -		if (memblock_is_region_reserved(crash_base, crash_size)) {
> -			pr_warn("crashkernel: requested region is reserved\n");
> -			return;
> -		}
> -
> +	if (crash_base) {
> +		search_start = crash_base;
> +		search_end = crash_base + crash_size;
> +	}
> 
> -		if (!IS_ALIGNED(crash_base, PMD_SIZE)) {
> -			pr_warn("crashkernel: requested region is misaligned\n");
> -			return;
> -		}
> +	/*
> +	 * Current riscv boot protocol requires 2MB alignment for
> +	 * RV64 and 4MB alignment for RV32 (hugepage size)
> +	 */
> +	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> +					       search_start, search_end);
> +	if (crash_base == 0) {
> +		pr_warn("crashkernel: couldn't allocate %lldKB\n",
> +			crash_size >> 10);
> +		return;
>  	}
> -	memblock_reserve(crash_base, crash_size);
> 
>  	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);

For the riscv part:

Acked-by: Nick Kossifidis <mick@ics.forth.gr>
