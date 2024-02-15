Return-Path: <linux-acpi+bounces-3570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6A856F1C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7151B1C21EF5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF513B2AC;
	Thu, 15 Feb 2024 21:11:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A7135A66
	for <linux-acpi@vger.kernel.org>; Thu, 15 Feb 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031513; cv=none; b=TxvIftqeznDyFD+azjreaVDVfB3olQcQJbLmlyi7aP2CVDxnPjY82lkGMO1Rx7Yscbzd9RJaL/fmdf84Y3PgvsPpf+1BF+aQRbpP1vm6FUJ23rA38qKLy5uQ2jPgWCc9LrNVSDm/HPP8RjDezl7oFO+jFDJ2VbppEPiiWm5ETUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031513; c=relaxed/simple;
	bh=AxAezGuSAUXPpY69F5FEAjQlOYPygMo/5y2D9xgl3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLe4x5TJHRJ1d9HhbujvVsX5olnbpAuXIAkbC23zhljnF5LgMHU7aA07MIPovmNKvfczYIP0OCqkehXDybnzKi9fzum8WAOER0B1wNkXoanRKxSYbVi0kTupbOOdKiLoaT/rNuSDQWLbuugpphqCIdD85QQcVB88B1eyMKp6Y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj1I-00015I-GG; Thu, 15 Feb 2024 22:11:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj1F-000xJX-QX; Thu, 15 Feb 2024 22:11:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj1F-005eTy-2N;
	Thu, 15 Feb 2024 22:11:45 +0100
Date: Thu, 15 Feb 2024 22:11:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Morse <james.morse@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
Message-ID: <r2cobeovsufkoryiszm56gu2pwgevjxcoceg5am6j7va4r7su3@7arj7wav2d5q>
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
 <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local>
 <ix7bttqx32bv4hajg7szijtosi5vn43nxduun3fwevccjqrjhh@qrbjvcsuddoi>
 <tfmuzubr5p57qyv2pye72yzs6fjdyxubcqkmhih7ndddqcifgu@y4psjmr4rbz6>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzjeeyy22vwxd6i7"
Content-Disposition: inline
In-Reply-To: <tfmuzubr5p57qyv2pye72yzs6fjdyxubcqkmhih7ndddqcifgu@y4psjmr4rbz6>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org


--lzjeeyy22vwxd6i7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 10, 2024 at 09:34:53AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Dec 18, 2023 at 09:47:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Nov 22, 2023 at 06:49:13PM +0100, Borislav Petkov wrote:
> > > On Wed, Nov 22, 2023 at 04:25:30PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > The .remove() callback for a platform driver returns an int which=
 makes
> > > > > many driver authors wrongly assume it's possible to do error hand=
ling by
> > > > > returning an error code. However the value returned is ignored (a=
part
> > > > > from emitting a warning) and this typically results in resource l=
eaks.
> > > > >
> > > > > To improve here there is a quest to make the remove callback retu=
rn
> > > > > void. In the first step of this quest all drivers are converted to
> > > > > .remove_new(), which already returns void. Eventually after all d=
rivers
> > > > > are converted, .remove_new() will be renamed to .remove().
> > > > >
> > > > > Instead of returning an error code, emit a better error message t=
han the
> > > > > core. Apart from the improved error message this patch has no eff=
ects
> > > > > for the driver.
> > > > >
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
> > > > > ---
> > > > > Hello,
> > > > >
> > > > > I tried to improve this driver before, see
> > > > >
> > > > >         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c=
1L6vTi_qEeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
> > > > >         https://lore.kernel.org/linux-arm-kernel/20221219221439.1=
681770-1-u.kleine-koenig@pengutronix.de
> > > > >         https://lore.kernel.org/linux-arm-kernel/20221220154447.1=
2341-1-u.kleine-koenig@pengutronix.de
> > > > >
> > > > > but this didn't result in any patch being applied.
> > > > >
> > > > > I think it's inarguable that there is a problem that wants to be =
fixed.
> > > > > My tries to fix this problem fixxled out, so here comes a minimal=
 change
> > > > > that just points out the problem and otherwise makes ghes_remove()
> > > > > return void without further side effects to allow me to continue =
my
> > > > > quest to make platform_driver remove callbacks return no error.
> > > >=20
> > > > Tony, Boris, any objections against this patch?
> > >=20
> > > SDEI is James. Moving him to To:
> >=20
> > I wonder if you had a chance to look at this patch.
> >=20
> > It doesn't change anything for the SDEI driver, the only effect is to
> > have one driver less using platform_driver's remove function.
> >=20
> > Would be great if that patch made it in.
>=20
> I guess it's to late for 6.8-rc1, but I wonder if this patch is still on
> your radar?

I'm a frustrated about this patch. It already missed two merge windows
while it's (IMHO) easy to understand that it doesn't change anything
relevant for the driver. (There is a resource leak in this driver, the
only difference my patch makes here is that it's more visible than
before that the leak is there.)

What must happen to make this patch go in?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lzjeeyy22vwxd6i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOfhAACgkQj4D7WH0S
/k5STgf/XD+evX6tiDarCBo4B6bDMUkoq6NWIhofNEjGhm6Y6f8scUhNuBk52W6X
G8plYx+ZoqAoSZbuD1GIadLMD9ZzmPd3i9QE6PDJG1NtaXP656iW5ZHIcGrVA8pY
5R898uSPtxhT578aL1dr6NT+gBeb05zyuY1+Qk6tnd7O9JlFDUCOfM3rEwbKUHns
XfoK+XaA9xQYQ+leE/SqgyIDkEiaGtH6o3fZ5tmYJNqh+wVfkfD1MQU6/aYIVVDg
zyKtAk0lQAFY7QpjbwNxFpP628NM6Iu08oYlQdFbtNg/XbXj///mkJ9gA2u2KMO7
IHl3Kapc2Dl1FB+TAxkvLx1iHjhRqw==
=+ZNO
-----END PGP SIGNATURE-----

--lzjeeyy22vwxd6i7--

