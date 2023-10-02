Return-Path: <linux-acpi+bounces-339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1367B57EE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 906F42833D0
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E471DA22
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:34:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83B1D533
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB5AC433CA;
	Mon,  2 Oct 2023 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696261994;
	bh=d7kdXeS2XgWDqTgJUWuMbIoo6AzaLC2wc3/Kdd1R24U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKuKC7ToslGewIB1E4B6Zp55A4P9lDO3N2oH4ZgjzLFX1qF7Pqq/rmA52UZGU/hxw
	 wgteGokL7ljquUyoO23Ka0P/hLOFqrhS5DKWcbnUI3O4j3x5+w0MRc7YS0vC96qp/K
	 JJcQgpbpD0n1BivlR1Xpja70KHN36qN4cLAHysxRplKXJiIYjyof7WUfF64RMDosVS
	 QBGbgwcnFKehcxRaisPxUSqXlltOcdW/Yy948Sue6qzikSosZxgc0TdiuLuJLxDNQe
	 fJUeZl46sWHcBGdUHsSKicJrQ5jxF9azvtsvZBObAJTLcd5PhjF6ZDU7V21lkjdY+W
	 UmK2mqRG6b8Eg==
Date: Mon, 2 Oct 2023 16:53:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 -next 1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with
 MMIO remapping
Message-ID: <20231002-thicket-roundup-4c4bab71ea94@spud>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-2-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SYLSRPBlP6/+v9ud"
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-2-sunilvl@ventanamicro.com>


--SYLSRPBlP6/+v9ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:30:12PM +0530, Sunil V L wrote:
> Enhance the acpi_os_ioremap() to support opregions in MMIO space. Also,
> have strict checks using EFI memory map to allow remapping the RAM similar
> to arm64.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks for resending this. If you respin, I think it would be worth
mentioning here that you are aligning things with arm64.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheer,
Conor.

> ---
>  arch/riscv/Kconfig       |  1 +
>  arch/riscv/kernel/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..ac039cf8af7a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,6 +39,7 @@ config RISCV
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_VDSO_DATA
> +	select ARCH_KEEP_MEMBLOCK
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>  	select ARCH_STACKWALK
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 56cb2c986c48..e619edc8b0cc 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -14,9 +14,10 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/io.h>
> +#include <linux/memblock.h>
>  #include <linux/pci.h>
> -#include <linux/efi.h>
> =20
>  int acpi_noirq =3D 1;		/* skip ACPI IRQ initialization */
>  int acpi_disabled =3D 1;
> @@ -217,7 +218,89 @@ void __init __acpi_unmap_table(void __iomem *map, un=
signed long size)
> =20
>  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  {
> -	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
> +	efi_memory_desc_t *md, *region =3D NULL;
> +	pgprot_t prot;
> +
> +	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> +		return NULL;
> +
> +	for_each_efi_memory_desc(md) {
> +		u64 end =3D md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
> +
> +		if (phys < md->phys_addr || phys >=3D end)
> +			continue;
> +
> +		if (phys + size > end) {
> +			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n=
");
> +			return NULL;
> +		}
> +		region =3D md;
> +		break;
> +	}
> +
> +	/*
> +	 * It is fine for AML to remap regions that are not represented in the
> +	 * EFI memory map at all, as it only describes normal memory, and MMIO
> +	 * regions that require a virtual mapping to make them accessible to
> +	 * the EFI runtime services.
> +	 */
> +	prot =3D PAGE_KERNEL_IO;
> +	if (region) {
> +		switch (region->type) {
> +		case EFI_LOADER_CODE:
> +		case EFI_LOADER_DATA:
> +		case EFI_BOOT_SERVICES_CODE:
> +		case EFI_BOOT_SERVICES_DATA:
> +		case EFI_CONVENTIONAL_MEMORY:
> +		case EFI_PERSISTENT_MEMORY:
> +			if (memblock_is_map_memory(phys) ||
> +			    !memblock_is_region_memory(phys, size)) {
> +				pr_warn(FW_BUG "requested region covers kernel memory\n");
> +				return NULL;
> +			}
> +
> +			/*
> +			 * Mapping kernel memory is permitted if the region in
> +			 * question is covered by a single memblock with the
> +			 * NOMAP attribute set: this enables the use of ACPI
> +			 * table overrides passed via initramfs.
> +			 * This particular use case only requires read access.
> +			 */
> +			fallthrough;
> +
> +		case EFI_RUNTIME_SERVICES_CODE:
> +			/*
> +			 * This would be unusual, but not problematic per se,
> +			 * as long as we take care not to create a writable
> +			 * mapping for executable code.
> +			 */
> +			prot =3D PAGE_KERNEL_RO;
> +			break;
> +
> +		case EFI_ACPI_RECLAIM_MEMORY:
> +			/*
> +			 * ACPI reclaim memory is used to pass firmware tables
> +			 * and other data that is intended for consumption by
> +			 * the OS only, which may decide it wants to reclaim
> +			 * that memory and use it for something else. We never
> +			 * do that, but we usually add it to the linear map
> +			 * anyway, in which case we should use the existing
> +			 * mapping.
> +			 */
> +			if (memblock_is_map_memory(phys))
> +				return (void __iomem *)__va(phys);
> +			fallthrough;
> +
> +		default:
> +			if (region->attribute & EFI_MEMORY_WB)
> +				prot =3D PAGE_KERNEL;
> +			else if ((region->attribute & EFI_MEMORY_WC) ||
> +				 (region->attribute & EFI_MEMORY_WT))
> +				prot =3D pgprot_writecombine(PAGE_KERNEL);
> +		}
> +	}
> +
> +	return ioremap_prot(phys, size, pgprot_val(prot));
>  }
> =20
>  #ifdef CONFIG_PCI
> --=20
> 2.39.2
>=20

--SYLSRPBlP6/+v9ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrnZAAKCRB4tDGHoIJi
0rnYAQD9/jYl/+fphuw2h0kiG9Z1LspiEKosmOGizXnCtmN9WgEA9fDieegSDRMf
Ar9Gc2GJDI6iGkOl3hmvkGnqUCm6NQM=
=rHWi
-----END PGP SIGNATURE-----

--SYLSRPBlP6/+v9ud--

