Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD426C6954
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCWNQ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCWNQz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 09:16:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5889EB442
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2023 06:16:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfKoD-0006DB-1d; Thu, 23 Mar 2023 14:16:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfKoB-006A60-QI; Thu, 23 Mar 2023 14:16:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfKoB-007LDY-3Q; Thu, 23 Mar 2023 14:16:47 +0100
Date:   Thu, 23 Mar 2023 14:16:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Pierre Asselin <pa@panix.com>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Regression] acpi: laptop panics early in boot
Message-ID: <20230323131646.xp3m2qvb7wp2wsqb@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
 <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
 <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
 <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
 <47a90870-8a71-a28f-bd8a-032a69cda596@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jtnsbqy6se7cszif"
Content-Disposition: inline
In-Reply-To: <47a90870-8a71-a28f-bd8a-032a69cda596@leemhuis.info>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--jtnsbqy6se7cszif
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 01:31:37PM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 07.03.23 20:31, Pierre Asselin wrote:
> >> Maybe the following patch helps (on top of v6.3-rc1):
> >>
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index 9531dd0fef50..a5a8f82981ce 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32
> >> type, void *data)
> >>  	if (!adev)
> >>  		goto err;
> >>
> >> -	if (adev->dev.driver) {
> >> +	if (device_is_bound(&adev->dev)) {
> >>  		struct acpi_driver *driver =3D to_acpi_driver(adev->dev.driver);
> >>
> >>  		if (driver && driver->ops.notify &&
> >>
> >=20
> > It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
> > not qualified to evaluate.
>=20
> Uwe, what happens to this regression fix? It looks like it didn't make
> any progress towards mainline, but maybe I missed something in my brief
> search on lore.

If you missed something then so did I. From my POV the patch is not
known to lead to a correct handling, but for sure it's better than the
status quo.

I didn't create a proper patch because I thought someone might want to
do a deeper dive and check the logging. If that doesn't happen, I can
followup with a patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jtnsbqy6se7cszif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQcUT4ACgkQj4D7WH0S
/k4BrAf/eTy4iJinpXgEBmbkNhRYShxnyM6jIPwHt0SxA31/ay5SOAqotbXAOGPl
Cb7J4CxKuuxMXFk5rYPYW8G6+xzUdpvMvAKjJ9ykyu1u68FgTVDUehvkO8PyTIlU
iEiDBdt+1Kq51vTSHWLAWhSij1QAku/fXE9+lmLkoIcFP6n4K9fkAOj8HiZeTxNh
Nk4I2UXbZpYDUAGLAwbWYAXrUHzyhHqiLJKRnY/Qgs7gBB17ueYfsy9zk2pYolTj
i1jG3PXb2J09Vojg02DT2bHBiTb0YplQJ5QxSr/uvLoDmPlD/6oeTw3lUrP/X2US
NkloZFmHMRRtwIfXIrDWzN8zgWMWaA==
=f2gj
-----END PGP SIGNATURE-----

--jtnsbqy6se7cszif--
