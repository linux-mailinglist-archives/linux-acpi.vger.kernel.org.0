Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EAB6DFB45
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Apr 2023 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDLQZD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Apr 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDLQZC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2023 12:25:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468E359E
        for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2023 09:24:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdHE-0002hw-Rj; Wed, 12 Apr 2023 18:24:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdHA-00AmMu-U5; Wed, 12 Apr 2023 18:24:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmdHA-00Cemi-AC; Wed, 12 Apr 2023 18:24:52 +0200
Date:   Wed, 12 Apr 2023 18:24:52 +0200
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
Message-ID: <20230412162452.g7rjljqysbqxmspw@pengutronix.de>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
 <20221026172335.6zdpe3iqyajgowrn@pengutronix.de>
 <20221219221819.uikp73gq3vs2t4k5@pengutronix.de>
 <20230214163623.j3hakvxk23rk26ha@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vthdhdml2nwbxycy"
Content-Disposition: inline
In-Reply-To: <20230214163623.j3hakvxk23rk26ha@pengutronix.de>
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


--vthdhdml2nwbxycy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2023 at 05:36:23PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Dec 19, 2022 at 11:18:19PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 26, 2022 at 07:23:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> > > > On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > > > > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K=EF=BF=BDni=
g wrote:
> > > > >> Returning an error value in a platform driver's remove callback =
results in
> > > > >> a generic error message being emitted by the driver core, but ot=
herwise it
> > > > >> doesn't make a difference. The device goes away anyhow.
> > > > >>
> > > > >> So instead of triggering the generic platform error message, emi=
t a more
> > > > >> helpful message if a problem occurs and return 0 to suppress the=
 generic
> > > > >> message.
> > > > >>
> > > > >> This patch is a preparation for making platform remove callbacks=
 return
> > > > >> void.
> > > > >=20
> > > > > If that's the plan - I don't have anything against this patch.
> > > > >=20
> > > > >> Signed-off-by: Uwe Kleine-K=EF=BF=BDnig <u.kleine-koenig@pengutr=
onix.de>
> > > > >> ---
> > > > >> Hello,
> > > > >>
> > > > >> note that in the situations where the driver returned an error b=
efore
> > > > >> and now emits a message, there is a resource leak. Someone who k=
nows
> > > > >> more about this driver and maybe even can test stuff, might want=
 to
> > > > >> address this. This might not only be about non-freed memory, the=
 device
> > > > >> disappears but it is kept in sdei_list and so might be used afte=
r being
> > > > >> gone.
> > > >=20
> > > > > I'd need James' input on this. I guess we may ignore
> > > > > sdei_event_disable() return value and continue anyway in agdi_rem=
ove(),
> > > > > whether that's the right thing to do it is a different question.
> > > >=20
> > > > The unregister stuff is allowed to fail if the event is 'in progres=
s' on another CPU.
> > > > Given the handler panic()s the machine, if an event is in progress,=
 the resource leak
> > > > isn't something worth worrying about. The real problem is that the =
handler code may be
> > > > free()d while another CPU is still executing it, which is only a pr=
oblem for modules.
> > > >=20
> > > > As this thing can't be built as a module, and the handler panic()s =
the machine, I don't
> > > > think there is going to be a problem here.
> > >=20
> > > Is that an Ack?
> >=20
> > This patch wasn't applied anywhere (at least it didn't appear in next
> > since October). Did it fell through the cracks? Is there anything
> > missing?
>=20
> gentle ping!
>=20
> Working on making struct platform_driver::remove() return void, I'd like
> to base another patch on top of this one. For that it would be great if
> it entered the mainline ...

gentle ping ++

Would it help to resend?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vthdhdml2nwbxycy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ221MACgkQj4D7WH0S
/k4ndQf/aPPCVMwcr7EPrjXfKNYvM0xxhS2J7vUxgHSOPjUK7BnnMPZPaA48h8xU
G/AcxumI35vPAlIs/yMdHrBy9GmGP/up+FlDK7bMnxfLZQGU6aHit9GEZw2WQ0SK
0xwkcthxp0IX6JyzPq2fsI501V9DDjyFiRcaWzVKSlql63E7ZPTwUykJ8z7V+h1e
I+fl1032nzb5NyhSzVweBAG7RaO336MdNZ0GmCwEOzTY3ka+ji/W1w/7eSuufNQC
myEgSwtTPwHnfCfPRd2OOpbDZuyA4+CqfwmjEvhy3gIknAXGFQAmJFCa2AkAhehe
FpF5ztfoxqkMQflpqVDYHkej1uRCXQ==
=gZC6
-----END PGP SIGNATURE-----

--vthdhdml2nwbxycy--
