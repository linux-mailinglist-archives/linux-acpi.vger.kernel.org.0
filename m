Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726506AE604
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCGQLI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 11:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCGQKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 11:10:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60352124
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 08:10:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZZtG-0002t0-6n; Tue, 07 Mar 2023 17:10:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZZtD-002WkP-F0; Tue, 07 Mar 2023 17:10:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZZtC-0032sF-Q2; Tue, 07 Mar 2023 17:10:10 +0100
Date:   Tue, 7 Mar 2023 17:10:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pierre Asselin <pa@panix.com>
Cc:     linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Regression] acpi: laptop panics early in boot
Message-ID: <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
 <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2fesy5b7onob64s"
Content-Disposition: inline
In-Reply-To: <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--x2fesy5b7onob64s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 09:25:09AM -0500, Pierre Asselin wrote:
>=20
> 5.19: good.
> 5.19+Uwe's patch: bad.
>=20
> Slightly different traceback,
> https://www.panix.com/~pa/linux-6.1.12-crash/boot-failure-5.19-patched.jpg

Maybe the following patch helps (on top of v6.3-rc1):

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9531dd0fef50..a5a8f82981ce 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 typ=
e, void *data)
 	if (!adev)
 		goto err;
=20
-	if (adev->dev.driver) {
+	if (device_is_bound(&adev->dev)) {
 		struct acpi_driver *driver =3D to_acpi_driver(adev->dev.driver);
=20
 		if (driver && driver->ops.notify &&

This might be broken because usually you have to hold the device lock
and this isn't given here I think.

On the other hand, I don't know if you could just grab the lock here.
You'd probably have to hold it while calling driver->ops.notify which
might or might not be safe. I think there was a race already before
commit d6fb6ee1820c ("ACPI: bus: Drop driver member of struct
acpi_device"), it just wasn't hit that reliably. (Consider the state
before d6fb6ee1820c and the device being unbound just between
acpi_bus_notify()'s driver =3D adev->driver; and the call to
driver->ops.notify. So conceptually it was necessary already before
d6fb6ee1820c to hold the device lock?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x2fesy5b7onob64s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQHYdIACgkQwfwUeK3K
7AkT+Af9H5p6PIP3kSwQFlIpp63IUwRsyoSyHLAcyQDsR09ImT8wWUyfYDTxJefD
TNG8Jp9Vu0PA4VVFINuFxdkbutHSOPQDTH8woe4D1QP0gLTbi5c1C6uGS23AvwV1
aD05wU72r7nTICWCtduK0ovFAtnHKvARfVRryjqnSBQEcBV0qUd5Q5oFrl2/vVhz
CLANpLUXnP+wCj0gvvDo4IIDuU83FldRcY26NABVzpXyFtn8yfgJxo61fxOgopPC
HWuzvYCk5Uf711NcCOivoVuBqZfb7amQcwAhzJ26KdDFHGIKfwAI/ala9azrefgH
CpAgTkr/VQdD16v01zVPoHdzOoERkw==
=xlcn
-----END PGP SIGNATURE-----

--x2fesy5b7onob64s--
