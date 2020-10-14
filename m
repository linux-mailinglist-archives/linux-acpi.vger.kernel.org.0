Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170128E0C3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgJNMy5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 08:54:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:41092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgJNMy4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 08:54:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38632AEDA;
        Wed, 14 Oct 2020 12:54:55 +0000 (UTC)
Message-ID: <1c436e677b948c3242ed60839b72e36868c51334.camel@suse.de>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Wed, 14 Oct 2020 14:54:52 +0200
In-Reply-To: <CAMj1kXHhcB85Uc4wbv7zWkSKACnd05Hj-JRKm_R5OgDB1bkHNg@mail.gmail.com>
References: <20201010093153.30177-1-ardb@kernel.org>
         <20201012092821.GB9844@gaia>
         <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
         <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
         <20201012112453.GD9844@gaia>
         <CAMj1kXEmAxytDjcAgpGpCqWcEuO0HijLVuTZcz-vywW=a74mmA@mail.gmail.com>
         <20201012154954.GB6493@gaia>
         <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
         <20201012162238.GC6493@gaia>
         <CAMj1kXFpbVUjOHWEcyzzUR2q7SEWpkiQi3nB+OCLySDHhYY+Fw@mail.gmail.com>
         <20201012165933.GD6493@gaia>
         <bd0015dd37df6397767bda2ab8cdff7f805ee4f4.camel@suse.de>
         <CAMj1kXHhcB85Uc4wbv7zWkSKACnd05Hj-JRKm_R5OgDB1bkHNg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HghmYOWVBA/x9qTLND7R"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-HghmYOWVBA/x9qTLND7R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-14 at 14:44 +0200, Ard Biesheuvel wrote:
> On Tue, 13 Oct 2020 at 16:42, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Mon, 2020-10-12 at 17:59 +0100, Catalin Marinas wrote:
> > > On Mon, Oct 12, 2020 at 06:35:37PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 12 Oct 2020 at 18:22, Catalin Marinas <catalin.marinas@arm.=
com> wrote:
> > > > > On Mon, Oct 12, 2020 at 05:55:45PM +0200, Ard Biesheuvel wrote:
> > > > > > On Mon, 12 Oct 2020 at 17:50, Catalin Marinas <catalin.marinas@=
arm.com> wrote:
> > > > > > > > > On Mon, Oct 12, 2020 at 12:43:05PM +0200, Ard Biesheuvel =
wrote:
> > > > > > > > > > Also, could someone give an executive summary of why it=
 matters where
> > > > > > > > > > the crashkernel is loaded? As far as I can tell, reserv=
e_crashkernel()
> > > > > > > > > > only allocates memory for the kernel's executable image=
 itself, which
> > > > > > > > > > can usually be loaded anywhere in memory. I could see h=
ow a
> > > > > > > > > > crashkernel might need some DMA'able memory if it needs=
 to use the
> > > > > > > > > > hardware, but I don't think that is what is going on he=
re.
> > > > > [...]
> > > > > > > However, the crashkernel=3D... range is meant for sufficientl=
y large
> > > > > > > reservation to be able to run the kdump kernel, not just load=
 the image.
> > > > > >=20
> > > > > > Sure. But I was referring to the requirement that it is loaded =
low in
> > > > > > memory. Unless I am misunderstanding something, all we need for=
 the
> > > > > > crashkernel to be able to operate is some ZONE_DMA memory in ca=
se it
> > > > > > is needed by the hardware, and beyond that, it could happily li=
ve
> > > > > > anywhere in memory.
> > > > >=20
> > > > > Yes, the crash kernel doesn't need to be loaded in the low memory=
. But
> > > > > some low memory needs to end up in its perceived System RAM. That=
's what
> > > > > Chen is trying to do with this series:
> > > > >=20
> > > > > https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-1-c=
henzhou10@huawei.com/
> > > > >=20
> > > > > It reserves the normal crashkernel memory at some high address ra=
nge
> > > > > with a small block (currently proposed as 256MB similar to x86) i=
n the
> > > > > "low" range.
> > > > >=20
> > > > > This "low" range for arm64 currently means below 1GB but it's onl=
y RPi4
> > > > > that needs it this low, all other platforms are fine with the ful=
l low
> > > > > 32-bit range.
> > > > >=20
> > > > > If it's not doable in a nice way, we'll just leave with this perm=
anent
> > > > > 1GB ZONE_DMA and hope we won't get platforms requiring an even sm=
aller
> > > > > one. There's also the option of ignoring kdump on RPi4, make ZONE=
_DMA
> > > > > depend on !CRASH_DUMP and the "low" reservations can use the full=
 32-bit
> > > > > range since the kdump kernel won't need <30-bit addresses.
> > > >=20
> > > > Are you aware of any reason why we cannot defer the call to
> > > > reserve_crashkernel() to the start of bootmem_init()? That way, we
> > > > have access to the unflattened DT as well as the IORT, and so we ca=
n
> > > > tweak the zone limits based on the h/w description, but before
> > > > allocating the crashkernel.
> > >=20
> > > Not really, as long as memblock_reserve/alloc() still works.
> >=20
> > I had a look at this myself, and IIUC we're free to call reserve_crashk=
ernel()
> > anytime as long as it's before memblock_free_all().
> >=20
> > So, should I add a patch in my series taking care of that? or you'd rat=
her take
> > care of it yourselves?
> >=20
>=20
> Would you mind adopting this patch, and insert it into your series
> where appropriate? (after dropping the Documentation/ change, and
> moving the prototype declaration into linux/acpi_iort.h?) Then, you
> can also include moving the reserve_crashkernel() into bootmem_init().

Yes, I'll take care of it.


--=-HghmYOWVBA/x9qTLND7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+G9RwACgkQlfZmHno8
x/585Af/dHIOSaTQOaR4OjiHc3K9rzqBvSISwiGCqNwQ4bICWdaMk9dTm7tJsiDQ
9c8S6KhzNiNPFuX4LUsUym+dVkAVVanvOI3EDf8dhl6IzxouQmUhIP6oVY8wqOVF
cRN8A/YQecs/GMkI5dx573TYispHsQr1mfTMDopquAYDELwDWV4Z4eYRf6EO3ScD
VVjvdl4a3Zg1AmI/pKWaVBlunC4NVUIcya2DJzRJ9Lq743Fcmfq4OXGunnq7j+Tb
NQJKoqgQzOGBgxPa4ZOcONOJnKG4XYcg+leMJo2Y9b6+5+9OJ6SvOLbRbWYzCgue
aOnb3kRr3HM0pVI00+QOnY+jJyqBng==
=TPqR
-----END PGP SIGNATURE-----

--=-HghmYOWVBA/x9qTLND7R--

