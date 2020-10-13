Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD728D080
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgJMOmj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 10:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbgJMOmj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 10:42:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 610BAB25A;
        Tue, 13 Oct 2020 14:42:38 +0000 (UTC)
Message-ID: <bd0015dd37df6397767bda2ab8cdff7f805ee4f4.camel@suse.de>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Date:   Tue, 13 Oct 2020 16:42:36 +0200
In-Reply-To: <20201012165933.GD6493@gaia>
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
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pm3BdrexsedI1mz9uuZ0"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-pm3BdrexsedI1mz9uuZ0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-12 at 17:59 +0100, Catalin Marinas wrote:
> On Mon, Oct 12, 2020 at 06:35:37PM +0200, Ard Biesheuvel wrote:
> > On Mon, 12 Oct 2020 at 18:22, Catalin Marinas <catalin.marinas@arm.com>=
 wrote:
> > > On Mon, Oct 12, 2020 at 05:55:45PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 12 Oct 2020 at 17:50, Catalin Marinas <catalin.marinas@arm.=
com> wrote:
> > > > > > > On Mon, Oct 12, 2020 at 12:43:05PM +0200, Ard Biesheuvel wrot=
e:
> > > > > > > > Also, could someone give an executive summary of why it mat=
ters where
> > > > > > > > the crashkernel is loaded? As far as I can tell, reserve_cr=
ashkernel()
> > > > > > > > only allocates memory for the kernel's executable image its=
elf, which
> > > > > > > > can usually be loaded anywhere in memory. I could see how a
> > > > > > > > crashkernel might need some DMA'able memory if it needs to =
use the
> > > > > > > > hardware, but I don't think that is what is going on here.
> > > [...]
> > > > > However, the crashkernel=3D... range is meant for sufficiently la=
rge
> > > > > reservation to be able to run the kdump kernel, not just load the=
 image.
> > > >=20
> > > > Sure. But I was referring to the requirement that it is loaded low =
in
> > > > memory. Unless I am misunderstanding something, all we need for the
> > > > crashkernel to be able to operate is some ZONE_DMA memory in case i=
t
> > > > is needed by the hardware, and beyond that, it could happily live
> > > > anywhere in memory.
> > >=20
> > > Yes, the crash kernel doesn't need to be loaded in the low memory. Bu=
t
> > > some low memory needs to end up in its perceived System RAM. That's w=
hat
> > > Chen is trying to do with this series:
> > >=20
> > > https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-1-chenz=
hou10@huawei.com/
> > >=20
> > > It reserves the normal crashkernel memory at some high address range
> > > with a small block (currently proposed as 256MB similar to x86) in th=
e
> > > "low" range.
> > >=20
> > > This "low" range for arm64 currently means below 1GB but it's only RP=
i4
> > > that needs it this low, all other platforms are fine with the full lo=
w
> > > 32-bit range.
> > >=20
> > > If it's not doable in a nice way, we'll just leave with this permanen=
t
> > > 1GB ZONE_DMA and hope we won't get platforms requiring an even smalle=
r
> > > one. There's also the option of ignoring kdump on RPi4, make ZONE_DMA
> > > depend on !CRASH_DUMP and the "low" reservations can use the full 32-=
bit
> > > range since the kdump kernel won't need <30-bit addresses.
> >=20
> > Are you aware of any reason why we cannot defer the call to
> > reserve_crashkernel() to the start of bootmem_init()? That way, we
> > have access to the unflattened DT as well as the IORT, and so we can
> > tweak the zone limits based on the h/w description, but before
> > allocating the crashkernel.
>=20
> Not really, as long as memblock_reserve/alloc() still works.

I had a look at this myself, and IIUC we're free to call reserve_crashkerne=
l()
anytime as long as it's before memblock_free_all().

So, should I add a patch in my series taking care of that? or you'd rather =
take
care of it yourselves?

Regards,
Nicolas


--=-pm3BdrexsedI1mz9uuZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+FvNwACgkQlfZmHno8
x/4cQgf+OsA/BTxNj7KzNzulBtW7ot2R8QSrVtjd4mY9+FAzXjPKZIHpwmd/BJ58
se2C4lITgQKVKG/BRQHtu9Dbtce6BqWL1Wz0JKUZynZ90wH4PcWkbOaIQBplp/BN
Ta24STLqsEIAgj72lushFhDUq8rT2z1WGMUc5CZPs/GlV7B6sjf8qMq0opLd1J8Y
gabfaFb++FNCLVw06My60l5XoFnr5iQE7WjuaoRFTjQaYmHjIL4t390YbIDcQbY1
B4ENLYxS8zOw2IotQAo3sSsKdF9GXOk93LPiI72ivZoczyjw4czQoMUEhnpGQE7m
FtuPhsczbNhi+Jb/wSn5yfWEdhnAgQ==
=LspN
-----END PGP SIGNATURE-----

--=-pm3BdrexsedI1mz9uuZ0--

