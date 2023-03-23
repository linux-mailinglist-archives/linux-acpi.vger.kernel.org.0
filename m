Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720136C7240
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCWVWg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 17:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWVWg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 17:22:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF22CC70
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2023 14:22:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfSOD-0001nn-RV; Thu, 23 Mar 2023 22:22:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfSOA-006Eq4-TW; Thu, 23 Mar 2023 22:22:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfSOA-007RVl-2u; Thu, 23 Mar 2023 22:22:26 +0100
Date:   Thu, 23 Mar 2023 22:22:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pierre Asselin <pa@panix.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Subject: Re: [Regression] acpi: laptop panics early in boot
Message-ID: <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
 <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
 <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
 <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
 <20230307200843.yxhvnb23tpecjjng@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5k4ghwxe22skqfn"
Content-Disposition: inline
In-Reply-To: <20230307200843.yxhvnb23tpecjjng@pengutronix.de>
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


--u5k4ghwxe22skqfn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pierre,

On Tue, Mar 07, 2023 at 09:08:55PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Mar 07, 2023 at 02:31:49PM -0500, Pierre Asselin wrote:
> > > Maybe the following patch helps (on top of v6.3-rc1):
> > >
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 9531dd0fef50..a5a8f82981ce 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u=
32
> > > type, void *data)
> > >  	if (!adev)
> > >  		goto err;
> > >
> > > -	if (adev->dev.driver) {
> > > +	if (device_is_bound(&adev->dev)) {
> > >  		struct acpi_driver *driver =3D to_acpi_driver(adev->dev.driver);
> > >
> > >  		if (driver && driver->ops.notify &&
> > >
> >=20
> > It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
> > not qualified to evaluate.
>=20
> Thanks for your prompt test feedback.
>=20
> The locked variant could look as follows:
>=20
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9531dd0fef50..fddca263ac40 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -518,13 +518,15 @@ static void acpi_bus_notify(acpi_handle handle, u32=
 type, void *data)
>  	if (!adev)
>  		goto err;
> =20
> -	if (adev->dev.driver) {
> +	device_lock(&adev->dev);
> +	if (device_is_bound(&adev->dev)) {
>  		struct acpi_driver *driver =3D to_acpi_driver(adev->dev.driver);
> =20
>  		if (driver && driver->ops.notify &&
>  		    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
>  			driver->ops.notify(adev, type);
>  	}
> +	device_unlock(&adev->dev);
> =20
>  	if (!hotplug_event) {
>  		acpi_put_acpi_dev(adev);
>=20
> Pierre: If you want to test that, I suggest to also enable
> PROVE_LOCKING.
>=20
> Rafael: I don't know if this would work and I hope you're able to judge
> this better than I do. The change without the lock is for sure better
> than the status quo.
>=20
> I did a similar conversion as the blamed commit for pci that got
> reverted for similiar reasons. See
> 68da4e0eaaab421f228eac57cbe7505b136464af. (Added Bjorn and Robert to
> Cc:) I think the pci code suffers from a similar race even after
> reverting my change. If someone is able to find the right fix for one of
> them, that might be transferable to the other?!

This mail didn't make it into the archive on lore.kernel.org. Did
someone receive it? If not, that would explain why I didn't get any
feedback on it ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u5k4ghwxe22skqfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQcwwMACgkQj4D7WH0S
/k5XkAf/ZfasOzLyUM6ldekxbkJ7mwVaqCbHLlp0iQWcZWCkuHqJ8qFaU2S6L2Rh
6Fhi+ujxpp0pIX34so9t5CQtzWAoUrjOeEBAUuAjJ4d+Pc7vzGj6WzPefvzv3KmQ
k8wskb+daozDmkQn2tpNjSz7Miqb12nB1LvKgF8mxHVJjjx5jcLhZdN1an1o7u7v
wBGDKSKPrzOOjNIkCjEgtAZXcNiVmfgAbEyxKLFiiUk7+psigRFtXsT/aq38+aaO
JatZ1DWRu2T/KeqRmHc38Msu4057amaZuYt0wiCd5W++4nS2H4gmweVIpTdBqcYQ
1Ncx1QIpkwio+Z2YrxwYFyKB9l0Xuw==
=uwlA
-----END PGP SIGNATURE-----

--u5k4ghwxe22skqfn--
