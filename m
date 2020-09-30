Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6127F096
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgI3RdC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 13:33:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2933 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgI3RdB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 13:33:01 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 39BD6143B61A661FC7AA;
        Wed, 30 Sep 2020 18:33:00 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 30 Sep
 2020 18:33:00 +0100
Date:   Wed, 30 Sep 2020 18:32:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] arm64: permit ACPI core to map kernel memory used for
 table overrides
Message-ID: <20200930183259.00004582@huawei.com>
In-Reply-To: <20200929132522.18067-1-ardb@kernel.org>
References: <20200929132522.18067-1-ardb@kernel.org>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 29 Sep 2020 15:25:22 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> Jonathan reports that the strict policy for memory mapped by the
> ACPI core breaks the use case of passing ACPI table overrides via
> initramfs. This is due to the fact that the memory type used for
> loading the initramfs in memory is not recognized as a memory type
> that is typically used by firmware to pass firmware tables.
> 
> Since the purpose of the strict policy is to ensure that no AML or
> other ACPI code can manipulate any memory that is used by the kernel
> to keep its internal state or the state of user tasks, we can relax
> the permission check, and allow mappings of memory that is reserved
> and marked as NOMAP via memblock, and therefore not covered by the
> linear mapping to begin with.
> 

My over enthusiastic filters went and swept this one away so I missed it.
Catalin, thanks for pointing it out!

Anyhow, retested and still looks good.   Slightly tighter check makes
sense.

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
> Fixes: 325f5585ec36 ("arm64/acpi: disallow writeable AML opregion mapping for EFI code regions")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++--
>  include/linux/acpi.h     |  2 +-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index a85174d05473..cada0b816c8a 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -298,8 +298,21 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  		case EFI_BOOT_SERVICES_DATA:
>  		case EFI_CONVENTIONAL_MEMORY:
>  		case EFI_PERSISTENT_MEMORY:
> -			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> -			return NULL;
> +			if (memblock_is_map_memory(phys) ||
> +			    !memblock_is_region_memory(phys, size)) {
> +				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> +				return NULL;
> +			}
> +			/*
> +			 * Mapping kernel memory is permitted if the region in
> +			 * question is covered by a single memblock with the
> +			 * NOMAP attribute set: this enables the use of ACPI
> +			 * table overrides passed via initramfs, which are
> +			 * reserved in memory using arch_reserve_mem_area()
> +			 * below. As this particular use case only requires
> +			 * read access, fall through to the R/O mapping case.
> +			 */
> +			fallthrough;
>  
>  		case EFI_RUNTIME_SERVICES_CODE:
>  			/*
> @@ -388,3 +401,8 @@ int apei_claim_sea(struct pt_regs *regs)
>  
>  	return err;
>  }
> +
> +void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
> +{
> +	memblock_mark_nomap(addr, size);
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1e4cdc6c7ae2..64ae25c59d55 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -958,7 +958,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
>  
> -#ifdef CONFIG_X86
> +#ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
>  static inline void arch_reserve_mem_area(acpi_physical_address addr,

