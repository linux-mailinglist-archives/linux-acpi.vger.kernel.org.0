Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6329AB2E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438983AbgJ0LvE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 07:51:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393622AbgJ0LvD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 07:51:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21D65AAB2;
        Tue, 27 Oct 2020 11:51:02 +0000 (UTC)
Message-ID: <d2b6693aefe6d2cad03432366c48e05cb5c8d3a3.camel@suse.de>
Subject: Re: [PATCH v4 0/7] arm64: Default to 32-bit wide ZONE_DMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jeremy Linton <jeremy.linton@arm.com>, robh+dt@kernel.org,
        catalin.marinas@arm.com, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 27 Oct 2020 12:50:53 +0100
In-Reply-To: <9bccc5ef-9457-044b-7193-d002a395e461@arm.com>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
         <9bccc5ef-9457-044b-7193-d002a395e461@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7KtHL8JmijrZUDdO/9dK"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-7KtHL8JmijrZUDdO/9dK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-23 at 14:05 -0500, Jeremy Linton wrote:
> Hi,
>=20
> On 10/21/20 7:34 AM, Nicolas Saenz Julienne wrote:
> > Using two distinct DMA zones turned out to be problematic. Here's an
> > attempt go back to a saner default.
> >=20
> > I tested this on both a RPi4 and QEMU.
>=20
> I've tested this in ACPI mode on the rpi4 (4+8G with/without the 3G=20
> limiter) as well, with Ard's IORT patch. Nothing seems to have regressed.
>=20
> Thanks,
>=20
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!


--=-7KtHL8JmijrZUDdO/9dK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+YCZ0ACgkQlfZmHno8
x/7nHAf+NsPBIeE87IsQQDXb+Yj9HG4BT9qoFjLz6YOJ82f2k6RHxorkNMBGv/Kn
mh1U2wjHbKJvDKSHIM/qsvcbSI8ZKQyqQBLYXintA5koBEw88a1UA3OXCqbs35Eu
5s4sHfoPVAAM8OE9b7+sKTNBFXBLngmBotO0Tt9dAXrTEPNLfPu9pXt22zGb2gCy
34Sv2032HmUGXMX3Dd1eEKPsfqYqHDsBMXmYsh1GrV5/xIJ2ClpD3yM7xjQ/PNtI
c2VffRjFikj/PUTf8I1HPDOeSwX101QkV3Uq9TatMWsLwQYv9Y5EM8Gz8XPPCDF3
CDY5pxiYqZdowQMQ53hVr9yjOjogdQ==
=XjDo
-----END PGP SIGNATURE-----

--=-7KtHL8JmijrZUDdO/9dK--

