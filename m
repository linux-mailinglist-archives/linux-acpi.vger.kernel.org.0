Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940276C7E08
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCXM2z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCXM20 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 08:28:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE63A97
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 05:28:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgWO-00057H-Nj; Fri, 24 Mar 2023 13:27:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgWN-006Nb6-5U; Fri, 24 Mar 2023 13:27:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgWM-007blL-2o; Fri, 24 Mar 2023 13:27:50 +0100
Date:   Fri, 24 Mar 2023 13:27:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre Asselin <pa@panix.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Subject: Re: [Regression] acpi: laptop panics early in boot
Message-ID: <20230324122749.oqmkcc3ckaotkeye@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
 <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
 <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
 <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
 <20230307200843.yxhvnb23tpecjjng@pengutronix.de>
 <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
 <CAJZ5v0haCTNn+MYA2wSNhC_MzWiyH7uBYQ3F__OgL4OuubRRUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bfdgtpvzimwjkmdp"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0haCTNn+MYA2wSNhC_MzWiyH7uBYQ3F__OgL4OuubRRUg@mail.gmail.com>
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


--bfdgtpvzimwjkmdp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

On Fri, Mar 24, 2023 at 01:12:35PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 23, 2023 at 10:22=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Pierre,
> >
> > On Tue, Mar 07, 2023 at 09:08:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Mar 07, 2023 at 02:31:49PM -0500, Pierre Asselin wrote:
> > > > > Maybe the following patch helps (on top of v6.3-rc1):
> > > > >
> > > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > > > index 9531dd0fef50..a5a8f82981ce 100644
> > > > > --- a/drivers/acpi/bus.c
> > > > > +++ b/drivers/acpi/bus.c
> > > > > @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handl=
e, u32
> > > > > type, void *data)
> > > > >   if (!adev)
> > > > >           goto err;
> > > > >
> > > > > - if (adev->dev.driver) {
> > > > > + if (device_is_bound(&adev->dev)) {
> > > > >           struct acpi_driver *driver =3D to_acpi_driver(adev->dev=
=2Edriver);
> > > > >
> > > > >           if (driver && driver->ops.notify &&
> > > > >
> > > >
> > > > It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
> > > > not qualified to evaluate.
> > >
> > > Thanks for your prompt test feedback.
> > >
> > > The locked variant could look as follows:
> > >
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 9531dd0fef50..fddca263ac40 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -518,13 +518,15 @@ static void acpi_bus_notify(acpi_handle handle,=
 u32 type, void *data)
> > >       if (!adev)
> > >               goto err;
> > >
> > > -     if (adev->dev.driver) {
> > > +     device_lock(&adev->dev);
> > > +     if (device_is_bound(&adev->dev)) {
> > >               struct acpi_driver *driver =3D to_acpi_driver(adev->dev=
=2Edriver);
> > >
> > >               if (driver && driver->ops.notify &&
> > >                   (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
> > >                       driver->ops.notify(adev, type);
> > >       }
> > > +     device_unlock(&adev->dev);
> > >
> > >       if (!hotplug_event) {
> > >               acpi_put_acpi_dev(adev);
> > >
> > > Pierre: If you want to test that, I suggest to also enable
> > > PROVE_LOCKING.
> > >
> > > Rafael: I don't know if this would work and I hope you're able to jud=
ge
> > > this better than I do. The change without the lock is for sure better
> > > than the status quo.
> > >
> > > I did a similar conversion as the blamed commit for pci that got
> > > reverted for similiar reasons. See
> > > 68da4e0eaaab421f228eac57cbe7505b136464af. (Added Bjorn and Robert to
> > > Cc:) I think the pci code suffers from a similar race even after
> > > reverting my change. If someone is able to find the right fix for one=
 of
> > > them, that might be transferable to the other?!
> >
> > This mail didn't make it into the archive on lore.kernel.org. Did
> > someone receive it?
>=20
> I have received it.

I bounced it to the list and Pierre. This was enough to make it appear
in the archive on lore.kernel.org. If you got it yesterday, that was my
bounce.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bfdgtpvzimwjkmdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdl0QACgkQj4D7WH0S
/k4TvggAjH83z4sby84iLNjtfetkT70BzLkdpRslRRFs/UQFV7pbc3cfY+IXierg
IQGEz939gCVlRkhUYEV0ifWUmyRY/IHqSUSr6q327JhsfU3KQnoJxUL3w2zztPXE
y+H1HQlTlOwAS8k7uHBlXPhEPy41XAgtvjHjeQaycsmFPwMIwpJFM9cwitqAfVqy
khmtGeY16o98kDYKr58EHHnvUIlHfNdk0yUZR1o10PTdJPVEQDy5lN5txYUD6gxS
Ddr8Q1SKwnGPkn/SR4diXybDHHRfrwDE5RvzgyWAkBW2ssVzt062ic9Dz8R/mXO+
LlqYv8IQTJfroACZnUUH7YZzmXoAJQ==
=8tnN
-----END PGP SIGNATURE-----

--bfdgtpvzimwjkmdp--
