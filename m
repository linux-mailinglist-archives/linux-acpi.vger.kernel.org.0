Return-Path: <linux-acpi+bounces-2780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B086B829539
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 09:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42361B2515E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF936D6FA;
	Wed, 10 Jan 2024 08:35:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C979DD
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jan 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU35-00024d-2z; Wed, 10 Jan 2024 09:34:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU34-001f6V-6J; Wed, 10 Jan 2024 09:34:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNU34-006NMU-0L;
	Wed, 10 Jan 2024 09:34:54 +0100
Date: Wed, 10 Jan 2024 09:34:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Morse <james.morse@arm.com>
Cc: Tony Luck <tony.luck@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
Message-ID: <tfmuzubr5p57qyv2pye72yzs6fjdyxubcqkmhih7ndddqcifgu@y4psjmr4rbz6>
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
 <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local>
 <ix7bttqx32bv4hajg7szijtosi5vn43nxduun3fwevccjqrjhh@qrbjvcsuddoi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mitaikk2idkkpkxh"
Content-Disposition: inline
In-Reply-To: <ix7bttqx32bv4hajg7szijtosi5vn43nxduun3fwevccjqrjhh@qrbjvcsuddoi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org


--mitaikk2idkkpkxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 18, 2023 at 09:47:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Nov 22, 2023 at 06:49:13PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 22, 2023 at 04:25:30PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > The .remove() callback for a platform driver returns an int which m=
akes
> > > > many driver authors wrongly assume it's possible to do error handli=
ng by
> > > > returning an error code. However the value returned is ignored (apa=
rt
> > > > from emitting a warning) and this typically results in resource lea=
ks.
> > > >
> > > > To improve here there is a quest to make the remove callback return
> > > > void. In the first step of this quest all drivers are converted to
> > > > .remove_new(), which already returns void. Eventually after all dri=
vers
> > > > are converted, .remove_new() will be renamed to .remove().
> > > >
> > > > Instead of returning an error code, emit a better error message tha=
n the
> > > > core. Apart from the improved error message this patch has no effec=
ts
> > > > for the driver.
> > > >
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > > > ---
> > > > Hello,
> > > >
> > > > I tried to improve this driver before, see
> > > >
> > > >         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c1L=
6vTi_qEeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
> > > >         https://lore.kernel.org/linux-arm-kernel/20221219221439.168=
1770-1-u.kleine-koenig@pengutronix.de
> > > >         https://lore.kernel.org/linux-arm-kernel/20221220154447.123=
41-1-u.kleine-koenig@pengutronix.de
> > > >
> > > > but this didn't result in any patch being applied.
> > > >
> > > > I think it's inarguable that there is a problem that wants to be fi=
xed.
> > > > My tries to fix this problem fixxled out, so here comes a minimal c=
hange
> > > > that just points out the problem and otherwise makes ghes_remove()
> > > > return void without further side effects to allow me to continue my
> > > > quest to make platform_driver remove callbacks return no error.
> > >=20
> > > Tony, Boris, any objections against this patch?
> >=20
> > SDEI is James. Moving him to To:
>=20
> I wonder if you had a chance to look at this patch.
>=20
> It doesn't change anything for the SDEI driver, the only effect is to
> have one driver less using platform_driver's remove function.
>=20
> Would be great if that patch made it in.

I guess it's to late for 6.8-rc1, but I wonder if this patch is still on
your radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mitaikk2idkkpkxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWeVq0ACgkQj4D7WH0S
/k5XZgf+MF5f60w/cXU4CZFrg2ekaqqZ7PZnY5ucjPPx/7Hg7Wri0Y1JSzgfaNWC
yQlUEzzyTrq53kh/ZbDZ22mZKBsHvTcbU8qDyiLFr/xl10oTboE50nlWHpm9rdIY
iPoAuk29gzztE/JvyobGOJUK4qho+0UX8l2OCJhLbo6reGb9DCHhUNaD1FfmoZqS
mP05ZVGN8A5GDKzZ0wtB1AcNe62TiWHG6CmBOBL0k5IotHGLETl2CfF7TuMDNbh0
wa7OqTKp6Vwefj5tqHmp2noBqn/qEO9RC2f2j8tSPPlrD7sLpnhHei0YQFrPNKl7
ZJ9UdNEEE0DfVGpzT9FqDiKpCxELlA==
=PogG
-----END PGP SIGNATURE-----

--mitaikk2idkkpkxh--

