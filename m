Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888CA20572A
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgFWQ1D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jun 2020 12:27:03 -0400
Received: from foss.arm.com ([217.140.110.172]:32820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFWQ1D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jun 2020 12:27:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6711C1F1;
        Tue, 23 Jun 2020 09:27:02 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.55.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35ECA3F73C;
        Tue, 23 Jun 2020 09:27:01 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:26:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, sudeep.holla@arm.com,
        kernel-hardening@lists.openwall.com,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC PATCH v2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
Message-ID: <20200623162655.GA22650@red-moon.cambridge.arm.com>
References: <20200623093755.1534006-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623093755.1534006-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 23, 2020 at 11:37:55AM +0200, Ard Biesheuvel wrote:
> AML uses SystemMemory opregions to allow AML handlers to access MMIO
> registers of, e.g., GPIO controllers, or access reserved regions of
> memory that are owned by the firmware.
> 
> Currently, we also allow AML access to memory that is owned by the
> kernel and mapped via the linear region, which does not seem to be
> supported by a valid use case, and exposes the kernel's internal
> state to AML methods that may be buggy and exploitable.
> 
> On arm64, ACPI support requires booting in EFI mode, and so we can cross
> reference the requested region against the EFI memory map, rather than
> just do a minimal check on the first page. So let's only permit regions
> to be remapped by the ACPI core if
> - they don't appear in the EFI memory map at all (which is the case for
>   most MMIO), or
> - they are covered by a single region in the EFI memory map, which is not
>   of a type that describes memory that is given to the kernel at boot.
> 
> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: do a more elaborate check on the region, against the EFI memory map
> 
>  arch/arm64/include/asm/acpi.h | 15 +---
>  arch/arm64/kernel/acpi.c      | 72 ++++++++++++++++++++
>  2 files changed, 73 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index a45366c3909b..bd68e1b7f29f 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -47,20 +47,7 @@
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>  
>  /* ACPI table mapping after acpi_permanent_mmap is set */
> -static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> -					    acpi_size size)
> -{
> -	/* For normal memory we already have a cacheable mapping. */
> -	if (memblock_is_map_memory(phys))
> -		return (void __iomem *)__phys_to_virt(phys);
> -
> -	/*
> -	 * We should still honor the memory's attribute here because
> -	 * crash dump kernel possibly excludes some ACPI (reclaim)
> -	 * regions from memblock list.
> -	 */
> -	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
> -}
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
>  #define acpi_os_ioremap acpi_os_ioremap
>  
>  typedef u64 phys_cpuid_t;
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index a7586a4db142..4696f765d1ac 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -261,6 +261,78 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>  	return __pgprot(PROT_DEVICE_nGnRnE);
>  }
>  
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +{
> +	efi_memory_desc_t *md, *region = NULL;
> +	pgprot_t prot;
> +
> +	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> +		return NULL;
> +
> +	for_each_efi_memory_desc(md) {
> +		u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
> +
> +		if (phys < md->phys_addr || phys >= end)
> +			continue;
> +
> +		if (phys + size > end) {
> +			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
> +			return NULL;
> +		}
> +		region = md;
> +		break;
> +	}
> +
> +	/*
> +	 * It is fine for AML to remap regions that are not represented in the
> +	 * EFI memory map at all, as it only describes normal memory, and MMIO
> +	 * regions that require a virtual mapping to make them accessible to
> +	 * the EFI runtime services.
> +	 */
> +	prot = __pgprot(PROT_DEVICE_nGnRnE);
> +	if (region) {
> +		switch (region->type) {
> +		case EFI_LOADER_CODE:
> +		case EFI_LOADER_DATA:
> +		case EFI_BOOT_SERVICES_CODE:
> +		case EFI_BOOT_SERVICES_DATA:
> +		case EFI_CONVENTIONAL_MEMORY:
> +		case EFI_PERSISTENT_MEMORY:
> +			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> +			return NULL;
> +
> +		case EFI_ACPI_RECLAIM_MEMORY:
> +			/*
> +			 * ACPI reclaim memory is used to pass firmware tables
> +			 * and other data that is intended for consumption by
> +			 * the OS only, which may decide it wants to reclaim
> +			 * that memory and use it for something else. We never
> +			 * do that, but we add it to the linear map anyway, and
> +			 * so we must use the existing mapping.
> +			 */
> +			return (void __iomem *)__phys_to_virt(phys);

For my own understanding - we have to keep this mapping (given the
current kernel code and tables handling) which means that this patch
mitigates (correctly) the issue but can't solve it in its entirety.

> +		case EFI_RUNTIME_SERVICES_CODE:
> +			/*
> +			 * This would be unusual, but not problematic per se,
> +			 * as long as we take care not to create a writable
> +			 * mapping for executable code.
> +			 */
> +			prot = PAGE_KERNEL_RO;

Nit: IIUC this tweaks the current behaviour (so it is probably better
to move this change to another patch).

Other than that the patch is sound and probably the best we could
do to harden the code, goes without saying - it requires testing.

Thanks for putting it together.

Lorenzo

> +			break;
> +
> +		default:
> +			if (region->attribute & EFI_MEMORY_WB)
> +				prot = PAGE_KERNEL;
> +			else if (region->attribute & EFI_MEMORY_WT)
> +				prot = __pgprot(PROT_NORMAL_WT);
> +			else if (region->attribute & EFI_MEMORY_WC)
> +				prot = __pgprot(PROT_NORMAL_NC);
> +		}
> +	}
> +	return __ioremap(phys, size, prot);
> +}
> +
>  /*
>   * Claim Synchronous External Aborts as a firmware first notification.
>   *
> -- 
> 2.27.0
> 
