Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983046969C2
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBNQgp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Feb 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBNQgg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2023 11:36:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E82CC75
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2023 08:36:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRyI7-0000pT-Ei; Tue, 14 Feb 2023 17:36:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRyI3-004vDK-LB; Tue, 14 Feb 2023 17:36:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pRyI4-003Wf6-4Q; Tue, 14 Feb 2023 17:36:24 +0100
Date:   Tue, 14 Feb 2023 17:36:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <20230214163623.j3hakvxk23rk26ha@pengutronix.de>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
 <20221026172335.6zdpe3iqyajgowrn@pengutronix.de>
 <20221219221819.uikp73gq3vs2t4k5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kx6zxa35srycbncx"
Content-Disposition: inline
In-Reply-To: <20221219221819.uikp73gq3vs2t4k5@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--kx6zxa35srycbncx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 19, 2022 at 11:18:19PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 26, 2022 at 07:23:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> > > On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > > > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K=EF=BF=BDnig =
wrote:
> > > >> Returning an error value in a platform driver's remove callback re=
sults in
> > > >> a generic error message being emitted by the driver core, but othe=
rwise it
> > > >> doesn't make a difference. The device goes away anyhow.
> > > >>
> > > >> So instead of triggering the generic platform error message, emit =
a more
> > > >> helpful message if a problem occurs and return 0 to suppress the g=
eneric
> > > >> message.
> > > >>
> > > >> This patch is a preparation for making platform remove callbacks r=
eturn
> > > >> void.
> > > >=20
> > > > If that's the plan - I don't have anything against this patch.
> > > >=20
> > > >> Signed-off-by: Uwe Kleine-K=EF=BF=BDnig <u.kleine-koenig@pengutron=
ix.de>
> > > >> ---
> > > >> Hello,
> > > >>
> > > >> note that in the situations where the driver returned an error bef=
ore
> > > >> and now emits a message, there is a resource leak. Someone who kno=
ws
> > > >> more about this driver and maybe even can test stuff, might want to
> > > >> address this. This might not only be about non-freed memory, the d=
evice
> > > >> disappears but it is kept in sdei_list and so might be used after =
being
> > > >> gone.
> > >=20
> > > > I'd need James' input on this. I guess we may ignore
> > > > sdei_event_disable() return value and continue anyway in agdi_remov=
e(),
> > > > whether that's the right thing to do it is a different question.
> > >=20
> > > The unregister stuff is allowed to fail if the event is 'in progress'=
 on another CPU.
> > > Given the handler panic()s the machine, if an event is in progress, t=
he resource leak
> > > isn't something worth worrying about. The real problem is that the ha=
ndler code may be
> > > free()d while another CPU is still executing it, which is only a prob=
lem for modules.
> > >=20
> > > As this thing can't be built as a module, and the handler panic()s th=
e machine, I don't
> > > think there is going to be a problem here.
> >=20
> > Is that an Ack?
>=20
> This patch wasn't applied anywhere (at least it didn't appear in next
> since October). Did it fell through the cracks? Is there anything
> missing?

gentle ping!

Working on making struct platform_driver::remove() return void, I'd like
to base another patch on top of this one. For that it would be great if
it entered the mainline ...

Thanks for considering,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kx6zxa35srycbncx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPruIQACgkQwfwUeK3K
7AlGEwf+OhSxh84blUpfs+x46weI3cXK0aRUnBAD8KgRzo18ydkLAQsXacrkgSDC
XuQg7WuQVEROIwhO6aV/Lwt/58jXnN3AYzvI4W4Y0mtyGA3cIVCn+JfJvLhKZOod
+yXzNSJdB+v9z7Tt9ShhMkWbktcN3YFlzB6TC4rVvMg96PLACoOZy2CUIJE8pBsb
a+XAzfYRou6lpENG5aWLktsePYAPMaT4qRWvM4LMQeBrqRsCUjygm5DZgwko9WK+
We1uYzhNnQ3IiumGYzNyzQSqXHMJI9KjElhwAs4q76pjeiG1Ar/RV6QjOBU7d2k4
BMPM1zyXHb0zTF9+wM6tO/cO4XEXVQ==
=4oY2
-----END PGP SIGNATURE-----

--kx6zxa35srycbncx--
