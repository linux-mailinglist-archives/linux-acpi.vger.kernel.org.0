Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F66ADA6D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 10:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCGJdQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 04:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCGJdP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 04:33:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5021B76E
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 01:33:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZTh2-0007l7-0d; Tue, 07 Mar 2023 10:33:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZTgz-002RxZ-P9; Tue, 07 Mar 2023 10:33:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZTgy-002wzY-QJ; Tue, 07 Mar 2023 10:33:08 +0100
Date:   Tue, 7 Mar 2023 10:33:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pierre Asselin <pa@panix.com>
Cc:     linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Regression] acpi: laptop panics early in boot
Message-ID: <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xwoizhnk7z6op77"
Content-Disposition: inline
In-Reply-To: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
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


--5xwoizhnk7z6op77
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> Problem is still present in 6.3-rc1 .  Bisecting, the first bad commit
> is d6fb6ee1820c .

There is a small timeframe where the (now deleted) struct
acpi_device::driver is different from acpi_device::dev->driver. That's
because the latter is assigned to in drivers/base/dd.c's really_probe()
before the acpi probe function is called, while the former is assigned
only later.

So acpi_drv->ops.add(acpi_dev) is called with the driver set while that
was not true before d6fb6ee1820c.

To test if this is the culprit, can you please try a 5.19 kernel plus
the following patch?:

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e2db1bdd9dd2..657a2520a3e1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1022,6 +1022,8 @@ static int acpi_device_probe(struct device *dev)
 	struct acpi_driver *acpi_drv =3D to_acpi_driver(dev->driver);
 	int ret;
=20
+	acpi_dev->driver =3D acpi_drv;
+
 	if (acpi_dev->handler && !acpi_is_pnp_device(acpi_dev))
 		return -EINVAL;
=20
@@ -1032,8 +1034,6 @@ static int acpi_device_probe(struct device *dev)
 	if (ret)
 		return ret;
=20
-	acpi_dev->driver =3D acpi_drv;
-
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
=20

If the above patch breaks 5.19 that's the trail we have to follow. That
this is timing-related is strange though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5xwoizhnk7z6op77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQHBNEACgkQwfwUeK3K
7AmcAwf/cgXNS274mBJJlX1uA2cv9j3AFPcMGzLPZ6dKO06ergAcVpboCOiEZ/xG
OSu/i+awxSCld8dlaiIgmRqjWKL1UGGZz0rcY6h1UucqyS5o5TLaO9bpks3DFUi5
RZ0wjCB9SEdxoJu7p+LlpC3EJr/17k57U86szOpzXi3V9W1K424w3eS30AEkzw6U
W81vmf2Asaya3Qv3DVgcG9yqIIOf8fmJiNQJ9n1p6BkyH/TivkQ7QynXjgiTXoFX
wNJgeA2FT+/K5ZHUGiE3kPCmIhyLA3QkeASg89co+UyCVh//0OsYK7C6Uq0hHeze
PZ7K79UigClZ9YdZWZvKhnoVYtatvA==
=H4CK
-----END PGP SIGNATURE-----

--5xwoizhnk7z6op77--
