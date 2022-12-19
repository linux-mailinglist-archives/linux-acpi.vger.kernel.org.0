Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1173651576
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Dec 2022 23:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLSWS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Dec 2022 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWS3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2022 17:18:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C36559
        for <linux-acpi@vger.kernel.org>; Mon, 19 Dec 2022 14:18:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7OSm-0006Er-CN; Mon, 19 Dec 2022 23:18:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7OSi-000Qzi-Qj; Mon, 19 Dec 2022 23:18:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7OSh-006RD3-VS; Mon, 19 Dec 2022 23:18:19 +0100
Date:   Mon, 19 Dec 2022 23:18:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <20221219221819.uikp73gq3vs2t4k5@pengutronix.de>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
 <20221026172335.6zdpe3iqyajgowrn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thalst4awndxaudb"
Content-Disposition: inline
In-Reply-To: <20221026172335.6zdpe3iqyajgowrn@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--thalst4awndxaudb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 26, 2022 at 07:23:35PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> > On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K=EF=BF=BDnig wr=
ote:
> > >> Returning an error value in a platform driver's remove callback resu=
lts in
> > >> a generic error message being emitted by the driver core, but otherw=
ise it
> > >> doesn't make a difference. The device goes away anyhow.
> > >>
> > >> So instead of triggering the generic platform error message, emit a =
more
> > >> helpful message if a problem occurs and return 0 to suppress the gen=
eric
> > >> message.
> > >>
> > >> This patch is a preparation for making platform remove callbacks ret=
urn
> > >> void.
> > >=20
> > > If that's the plan - I don't have anything against this patch.
> > >=20
> > >> Signed-off-by: Uwe Kleine-K=EF=BF=BDnig <u.kleine-koenig@pengutronix=
=2Ede>
> > >> ---
> > >> Hello,
> > >>
> > >> note that in the situations where the driver returned an error before
> > >> and now emits a message, there is a resource leak. Someone who knows
> > >> more about this driver and maybe even can test stuff, might want to
> > >> address this. This might not only be about non-freed memory, the dev=
ice
> > >> disappears but it is kept in sdei_list and so might be used after be=
ing
> > >> gone.
> >=20
> > > I'd need James' input on this. I guess we may ignore
> > > sdei_event_disable() return value and continue anyway in agdi_remove(=
),
> > > whether that's the right thing to do it is a different question.
> >=20
> > The unregister stuff is allowed to fail if the event is 'in progress' o=
n another CPU.
> > Given the handler panic()s the machine, if an event is in progress, the=
 resource leak
> > isn't something worth worrying about. The real problem is that the hand=
ler code may be
> > free()d while another CPU is still executing it, which is only a proble=
m for modules.
> >=20
> > As this thing can't be built as a module, and the handler panic()s the =
machine, I don't
> > think there is going to be a problem here.
>=20
> Is that an Ack?

This patch wasn't applied anywhere (at least it didn't appear in next
since October). Did it fell through the cracks? Is there anything
missing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--thalst4awndxaudb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOg4ygACgkQwfwUeK3K
7AmV9gf/TMJ0U8TdG6oRoVAG5XtThVYXxaXwjkDMEO9/KFrQCOqLh+a90SYatvYH
swwFI/VhK+KTAhBk/eAia+Sqw6hozIl6xDeinF0SVwH7n+O2dBOBUecH30ozha6d
FENsH88qT1FLpLAQJbjZg2k/25XG5KYhiHOKzDLjTtGmqKbDUPg0nA5IceD8JrKR
Zw3sjxo+GCKIwWVm0oU+ifvLQuUgvpgkP7Ce6suqQU4EaQ3Zeky8kEpDaYqe5tKH
nyt2FqVn+rSmgXn6qSnjSpr2o3sNsNY+3UX7T8aO91E3Aeu38ut38JaE8jsDCYZJ
S2j0DFKhNe7iL1xeVndfy2UFsNSxQg==
=AZiq
-----END PGP SIGNATURE-----

--thalst4awndxaudb--
