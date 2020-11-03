Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A122A4C20
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCRAh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 12:00:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:37958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgKCRAh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 12:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9FF7AC97;
        Tue,  3 Nov 2020 17:00:35 +0000 (UTC)
Message-ID: <0fc240575aad6a538fdc282e419411a615ba93f3.camel@suse.de>
Subject: Re: [PATCH v5 0/7] arm64: Default to 32-bit wide ZONE_DMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     robh+dt@kernel.org, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 03 Nov 2020 18:00:33 +0100
In-Reply-To: <20201030181134.GE23196@gaia>
References: <20201029172550.3523-1-nsaenzjulienne@suse.de>
         <20201030181134.GE23196@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-e4mvEaSQmsP7NUXAJ5iB"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-e4mvEaSQmsP7NUXAJ5iB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-30 at 18:11 +0000, Catalin Marinas wrote:
> On Thu, Oct 29, 2020 at 06:25:43PM +0100, Nicolas Saenz Julienne wrote:
> > Ard Biesheuvel (1):
> >   arm64: mm: Set ZONE_DMA size based on early IORT scan
> >=20
> > Nicolas Saenz Julienne (6):
> >   arm64: mm: Move reserve_crashkernel() into mem_init()
> >   arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
> >   of/address: Introduce of_dma_get_max_cpu_address()
> >   of: unittest: Add test for of_dma_get_max_cpu_address()
> >   arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
> >   mm: Remove examples from enum zone_type comment
>=20
> Thanks for putting this together. I had a minor comment but the patches
> look fine to me. We still need an ack from Rob on the DT patch and I can
> queue the series for 5.11.

I'm preparing a v6 unifying both functions as you suggested.

> Could you please also test the patch below on top of this series? It's
> the removal of the implied DMA offset in the max_zone_phys()
> calculation.

Yes, happily. Comments below.

> --------------------------8<-----------------------------
> From 3ae252d888be4984a612236124f5b099e804c745 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Fri, 30 Oct 2020 18:07:34 +0000
> Subject: [PATCH] arm64: Ignore any DMA offsets in the max_zone_phys()
>  calculation
>=20
> Currently, the kernel assumes that if RAM starts above 32-bit (or
> zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
> such constrained devices have a hardwired DMA offset. In practice, we
> haven't noticed any such hardware so let's assume that we can expand
> ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
> ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
> zone_bits.
>=20
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/init.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 095540667f0f..362160e16fb2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -175,14 +175,21 @@ static void __init reserve_elfcorehdr(void)
>  #endif /* CONFIG_CRASH_DUMP */
> =20
>  /*
> - * Return the maximum physical address for a zone with a given address s=
ize
> - * limit. It currently assumes that for memory starting above 4G, 32-bit
> - * devices will use a DMA offset.
> + * Return the maximum physical address for a zone accessible by the give=
n bits
> + * limit. If the DRAM starts above 32-bit, expand the zone to the maximu=
m
> + * available memory, otherwise cap it at 32-bit.
>   */
>  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
> -	phys_addr_t offset =3D memblock_start_of_DRAM() & GENMASK_ULL(63, zone_=
bits);
> -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> +	phys_addr_t zone_mask =3D (1ULL << zone_bits) - 1;

Maybe use DMA_BIT_MASK(), instead of the manual calculation?

> +	phys_addr_t phys_start =3D memblock_start_of_DRAM();
> +
> +	if (!(phys_start & U32_MAX))

I'd suggest using 'bigger than' instead of masks. Just to cover ourselves
against memory starting at odd locations. Also it'll behaves properly when
phys_start is zero (this breaks things on RPi4).

> +		zone_mask =3D PHYS_ADDR_MAX;
> +	else if (!(phys_start & zone_mask))
> +		zone_mask =3D U32_MAX;
> +
> +	return min(zone_mask + 1, memblock_end_of_DRAM());

This + 1 isn't going to play well when zone_mask is PHYS_ADDR_MAX.

Regards,
Nicolas


--=-e4mvEaSQmsP7NUXAJ5iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+hjLEACgkQlfZmHno8
x/5wjggAjwdWMN+H9Cj7ukCCZxIw/mZ7tdk+jtxD8++ocqSv/BLWzfPJhliE31of
ShuRaGhx2UpgX/fny9Ng9cEMWPdjYb6wpyI7EEm2As3R8aWDXwEFh1bu6PkdPyLu
VBm0BkVSUY5Iu9fQYym1yA1KukGrzijxEW7+QFIUwrm1Bdralpg+67WLbOWUxmdI
SGlntSKWlUcfRXCg+/XzLFfODu+htiXHSSBW1zMWx/OsNPHb6Mupfrtdogqv65UP
aQpkzoqyZBlC9ueBXHtWUiDEv7EUdosKbia5mxa7i9apZ5ZPSy/OkGkY9mZq3evn
XiCaUCaYMdiZx1RCUE2VRr9HqZnuEQ==
=QpfN
-----END PGP SIGNATURE-----

--=-e4mvEaSQmsP7NUXAJ5iB--

