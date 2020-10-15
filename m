Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00928F5A0
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbgJOPPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 11:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgJOPPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 11:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFBECAB0E;
        Thu, 15 Oct 2020 15:15:10 +0000 (UTC)
Message-ID: <64bbecb547422272417feaff1aa6b3d8c3da1157.camel@suse.de>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Hanjun Guo <guohanjun@huawei.com>, robh+dt@kernel.org,
        catalin.marinas@arm.com, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Thu, 15 Oct 2020 17:15:09 +0200
In-Reply-To: <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-8-nsaenzjulienne@suse.de>
         <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rA4ctgOOrD1oldFe6ryS"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-rA4ctgOOrD1oldFe6ryS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 22:26 +0800, Hanjun Guo wrote:
> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >=20
> > We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> > incorporating masters that can address less than 32 bits of DMA, in
> > particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> > peripherals that can only address up to 1 GB (and its PCIe host
> > bridge can only access the bottom 3 GB)
> >=20
> > Instructing the DMA layer about these limitations is straight-forward,
> > even though we had to fix some issues regarding memory limits set in
> > the IORT for named components, and regarding the handling of ACPI _DMA
> > methods. However, the DMA layer also needs to be able to allocate
> > memory that is guaranteed to meet those DMA constraints, for bounce
> > buffering as well as allocating the backing for consistent mappings.
> >=20
> > This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> > it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> > problems with kdump, and potentially in other places where allocations
> > cannot cross zone boundaries. Therefore, we should avoid having two
> > separate DMA zones when possible.
> >=20
> > So let's do an early scan of the IORT, and only create the ZONE_DMA
> > if we encounter any devices that need it. This puts the burden on
> > the firmware to describe such limitations in the IORT, which may be
> > redundant (and less precise) if _DMA methods are also being provided.
> > However, it should be noted that this situation is highly unusual for
> > arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> > the _DMA method if implemented, and so we will not lose the ability to
> > perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> > it.
>=20
> Sorry, I'm still a little bit confused. With this patch, if we have
> a device which set the right _DMA method (DMA size >=3D 32), but with the
> wrong DMA size in IORT, we still have the ZONE_DMA created which
> is actually not needed?

Yes, that would be the case.

Regards,
Nicolas


--=-rA4ctgOOrD1oldFe6ryS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IZ30ACgkQlfZmHno8
x/4cJwf9FfM3BZ9/yE9L5jVNiTGCeMhHtWSqKvOj5ffnkuUmxE4Xm3qLk9INWqO3
5Wyvp86ggfOjlYEqSQTnWzA0XEarBU47BEcPaxcZCYHatFm45aGfPO6xiaedBjPK
qOAbpttbRtFI4XF9FVCBgZw1F1XTm5NN+OnQLTyI6b09rsm6m0oBR6XB2p9MNpLw
IXC+dLpvAA8J8LEb1veX6dXMYfqH6huFaws6Eg1VQFP+0unizIfDZMmbsV8goJqc
egGTR/9MrU+ta2kaweQjBo4q49KpyEXXnzTvTAV+29joccYcyHFKBrSuwQdZo76T
cLo7n6gtcREwAG4fkZD0tRUmqaELKQ==
=wbwJ
-----END PGP SIGNATURE-----

--=-rA4ctgOOrD1oldFe6ryS--

