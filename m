Return-Path: <linux-acpi+bounces-8486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0C989B56
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45919282098
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680815445B;
	Mon, 30 Sep 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="VFSzaAWB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798C15885E;
	Mon, 30 Sep 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681044; cv=none; b=lUv3AIAUMj0BBVUnjZWYIutTfmGA5Mp/n5tyLN7FDzzSffcq7Qn8pyrx2UdPCHjy2WJU4LPSJZAZnLafadcqfJp2HpPF0xrE9t5I5Ak0b9Q846xMHOHXDP2Zn/5ARsjvSl2U2PwwX8b04CMDPSoEgy8GTsTpnsQrtTIJqPb/Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681044; c=relaxed/simple;
	bh=JpKTLpJo8P+AyLwY7j4yk6vXuoRv/W8hPmtPqHq/oQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZyVHUm3v6uWQsWZc0A8fXz63ms3FcVS6X+tjgflLxUGXnsXorFEVULVTg7bZKw0Qkva4pzkqPQvlbcJMKX4+vL5sr3gSvBhoe1YZooIl7whHEgaPe7lY9Qi29jnln1+/zlzFodfx06KAfIeBtiwda/7883RFuUCrV2gbv/zj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=VFSzaAWB; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 033B11C00AB; Mon, 30 Sep 2024 09:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1727681040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5a+pI3NT34/nschdoQzgwKFZPtAUXiwycrtgYl3IIxw=;
	b=VFSzaAWBZllUygn+v+vJUKFjgbH/W2Mc3kIMS1tXUKZyAgU89qUD+v7FlZ8qXsF2i++wnx
	UzL/lheI+1tB73dAmdkhsIPRL7mSMNsgmqocs//CdjP2tZEUTpdAhAbTQt0fk3bG32AMAF
	Nag90tNxR4lPVnIS8Ilfk3t2r8Cb3r0=
Date: Mon, 30 Sep 2024 09:23:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
Message-ID: <ZvpSD127BexmugnX@duo.ucw.cz>
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
 <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
 <ZvXJjU7gpAchSqiy@amd.ucw.cz>
 <alpine.DEB.2.21.2409290048590.21893@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DgAm/oe8dVO+VxBL"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2409290048590.21893@angie.orcam.me.uk>


--DgAm/oe8dVO+VxBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > When I press power button, it starts producing some noise (hdd
> > > > spinning up), but power light goes pulsating, not on, and I stare at
> > > > black screen.
> > >=20
> > > No beep?
> >=20
> > No beep. And no beep when I tried booting with RAM removed.
>=20
>  According to:=20
> <https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/x220_x220i_x=
220tablet_x220itablet_ug_en.pdf>
> pulsating power-on LED indicates the sleep mode:
>=20
> "The power switch stays lit whenever the computer is on, blinks when the=
=20
> computer is in sleep (standby) mode, and is off when the computer is
> off."

So... I disconnected CMOS battery and now I have two different
blinking patterns. I googled a bit, and it seems it is symptom of some
PROM failing. So likely Linux had nothing to do with this, and sorry
for the noise.

I have X230 now. Suspend/resume works without bricking it with
(different?) 6.12-rc0. I hate the keyboard, and X230 came with bad
battery and won't charge X220's battery (bad Lenovo!!), so I got
another X220. If this one dies with blinking LED, I'll certainly let
the world know.

Best regards (and thanks for all the help),
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--DgAm/oe8dVO+VxBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvpSDwAKCRAw5/Bqldv6
8rT3AKC2MQxjqs4m5rTEocTImKdXaKcwFQCfT9j0eXbpXelnvOcyZis/M5l764s=
=FkOn
-----END PGP SIGNATURE-----

--DgAm/oe8dVO+VxBL--

