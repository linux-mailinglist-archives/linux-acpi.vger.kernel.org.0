Return-Path: <linux-acpi+bounces-8449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73630987A37
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6361F25BF9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC617C9E7;
	Thu, 26 Sep 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Wa3BLzB4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2C17A938;
	Thu, 26 Sep 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727383956; cv=none; b=Ge+Zq+Z6H4ASVBAFcOzO+SujscXM+gWHchc9GYvivCKct7dOJW8pvB9BuTyAHvl5MH9KbS8yQAoqcckTafV0evsctAaDWk6AwrMSDJMPsSLcGlPdETQkhg0WiEw9EyVcLNaSQBVzBrVh+cWwSrYI6YXg1cx4o2QGnmIkwf4V67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727383956; c=relaxed/simple;
	bh=2quMK0yMCIuSgqe96zZ3SWNSss/+1orOAKmEa2WwBUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLH47eMh7X2jCLT8aEiCab8eCCTBokqe5pxwqyiOqqoZa120cIAXlW5OhjtWkX/QnDf2NlahufIWks/xK1KtBrusgVl2WTcVv/8Xu1arKj8cL0L9iH/nDoJNOpF5Sv/Q1voZVTbVjCtRFCZ1x79mLXmBjDXmDMouT3amnL2mjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Wa3BLzB4; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 092E21C00B3; Thu, 26 Sep 2024 22:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1727383951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMhMO4FPAfkTMbs7d+Q6qQGCH4J/LL74pLoTL/dsHXk=;
	b=Wa3BLzB4o4dVII2QzveLiXz4zSP/g0dP+29Hv03JOb431wnwMVoDjsURy3KZ5KsFw1+aVA
	JWmPiUEvmqGpuOf03pbtWRsaHs79bmIa0durkcAm4+rIGW6g+POd4Bybq79Q42VScfo6SU
	gnu6sR707pE3Qw0m33Mh4joEgIeLsCs=
Date: Thu, 26 Sep 2024 22:52:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
Message-ID: <ZvXJjU7gpAchSqiy@amd.ucw.cz>
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
 <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jb5XaZHlj7qzygoz"
Content-Disposition: inline
In-Reply-To: <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>


--jb5XaZHlj7qzygoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > When I press power button, it starts producing some noise (hdd
> > spinning up), but power light goes pulsating, not on, and I stare at
> > black screen.
>=20
> No beep?

No beep. And no beep when I tried booting with RAM removed.

> > I removed everything, let it sit for a while, but behaviour was the
> > same. I'm now letting machine "cool" with everything removed,
> > but... It seems EC is very confused.
> >
> > Should I try removing CMOS battery?
>=20
> It probably won't help. Last time I had something like that, it was
> the EFI variables being messed up and messing up the boot as a result.
> That's all in flash.

EFI variables. Ouch. But those really should be later in the boot.

> The CMOS battery these days tends to really just be for maintaining
> the real-time clock.
>=20
> But if it's easy to get at, it won't hurt to try either.

I thought it was under RAM cover, but it is not.

> > Is there some magic combination I can hold during boot?
>=20
> I don't see anything  about keys during power-on in
>=20
>   https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/0a60739_04.=
pdf
>=20
> but you can try the usual suspects (hold ESC / Fn / etc during power-on).
>=20
> But that lenovo pdf says
>  1. Make sure that every connector is connected tightly and correctly.
>  2. DIMM.
>  3. System board.
>=20
> for your symptoms.
>=20
> That said, my first suspicion would be a dead harddisk, just because
> they happen and you hear noise (but it migth just be the disk getting
> power on its own, and making noise even with a dead system board).

I suspect it is disk spinning up on its own. Confused bios and
harddisk dying at the same time seems like a lot of coincidence. (And
it dies before initializing RAM, normally disk is way after that).

I have spinning rust which is easy to reach, plus SSD which is not. I
removed HDD, and now only reaction on power button is that power LED
starts blinking.

Nothing else, no CPU fan, nothing. No beeps with removed
RAMs. I'd expect BIOS to initialize RAM, and then to access EFI
variables. AFAICT it does not get there. So either hardware died, or
EC is very confused and fails to boot main CPU.

Not sure how EC keeps its state (not from CMOS battery -- right?) so I
guess I should leave it without power for several hours hoping it
clears the fault...?

Best regards (and thanks for help),
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--jb5XaZHlj7qzygoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvXJjQAKCRAw5/Bqldv6
8vZfAJsHyENTc9pKYkhV0AMdn0b2pOtxoACgiy1airpdlLOe3b0cCOKdSKVbqs8=
=E/Hs
-----END PGP SIGNATURE-----

--jb5XaZHlj7qzygoz--

