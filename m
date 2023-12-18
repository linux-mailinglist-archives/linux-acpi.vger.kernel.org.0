Return-Path: <linux-acpi+bounces-2536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155B817C3C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169CE28399A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F5760B8;
	Mon, 18 Dec 2023 20:47:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202C768EF
	for <linux-acpi@vger.kernel.org>; Mon, 18 Dec 2023 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKW7-0000k4-Od; Mon, 18 Dec 2023 21:47:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKW6-00GmSz-TM; Mon, 18 Dec 2023 21:47:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKW6-005XIO-Jp; Mon, 18 Dec 2023 21:47:10 +0100
Date: Mon, 18 Dec 2023 21:47:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Morse <james.morse@arm.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
Message-ID: <ix7bttqx32bv4hajg7szijtosi5vn43nxduun3fwevccjqrjhh@qrbjvcsuddoi>
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
 <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sl7bo56xclzfjeu"
Content-Disposition: inline
In-Reply-To: <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org


--6sl7bo56xclzfjeu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello James,

On Wed, Nov 22, 2023 at 06:49:13PM +0100, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 04:25:30PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > >
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drive=
rs
> > > are converted, .remove_new() will be renamed to .remove().
> > >
> > > Instead of returning an error code, emit a better error message than =
the
> > > core. Apart from the improved error message this patch has no effects
> > > for the driver.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >
> > > I tried to improve this driver before, see
> > >
> > >         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c1L6v=
Ti_qEeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
> > >         https://lore.kernel.org/linux-arm-kernel/20221219221439.16817=
70-1-u.kleine-koenig@pengutronix.de
> > >         https://lore.kernel.org/linux-arm-kernel/20221220154447.12341=
-1-u.kleine-koenig@pengutronix.de
> > >
> > > but this didn't result in any patch being applied.
> > >
> > > I think it's inarguable that there is a problem that wants to be fixe=
d.
> > > My tries to fix this problem fixxled out, so here comes a minimal cha=
nge
> > > that just points out the problem and otherwise makes ghes_remove()
> > > return void without further side effects to allow me to continue my
> > > quest to make platform_driver remove callbacks return no error.
> >=20
> > Tony, Boris, any objections against this patch?
>=20
> SDEI is James. Moving him to To:

I wonder if you had a chance to look at this patch.

It doesn't change anything for the SDEI driver, the only effect is to
have one driver less using platform_driver's remove function.

Would be great if that patch made it in.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6sl7bo56xclzfjeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWAr80ACgkQj4D7WH0S
/k4OhAf5AadQpwI2HtEFz6y9K8mmvY8TtP52pXuOARGUN6HXlyuzv5Bh3/4mBt9y
DEj+ei/IfoC3vag9gKXO2dSpSb7+ia4rmvvNw+d5ie8MZZ+J45VZ+9BUYq3pih23
Z5k5x5haEbyJ78S683H7sT/zFBlrkIb3LI2FTjNpknPAfLUsDWb1Rc4LDnjS3qkj
hllUkU+3DDjZeOC+yPxbQs2lPVKHKDPhQFHLKnRAYdYibhxll0pWmRTYpANWc1D7
Hq93fvzIDIvJ0zTRBsha/j2erLt/hPqSP3xOW3itxLr3tc+Ey26UQQb75fnu4Ys9
keRo52eJ1QTJciPRXMXyEi7TNhQlHg==
=cKq4
-----END PGP SIGNATURE-----

--6sl7bo56xclzfjeu--

