Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794F60E666
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiJZRXr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiJZRXq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 13:23:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642AA23F7
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2022 10:23:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onk7z-0003zk-Fh; Wed, 26 Oct 2022 19:23:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onk7w-000Y3b-Pl; Wed, 26 Oct 2022 19:23:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onk7u-00Aryx-QM; Wed, 26 Oct 2022 19:23:38 +0200
Date:   Wed, 26 Oct 2022 19:23:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     James Morse <james.morse@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <20221026172335.6zdpe3iqyajgowrn@pengutronix.de>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idoesrj4k3fx7uel"
Content-Disposition: inline
In-Reply-To: <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
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


--idoesrj4k3fx7uel
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello James,

On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> Hi guys,
>=20
> On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K=EF=BF=BDnig wrot=
e:
> >> Returning an error value in a platform driver's remove callback result=
s in
> >> a generic error message being emitted by the driver core, but otherwis=
e it
> >> doesn't make a difference. The device goes away anyhow.
> >>
> >> So instead of triggering the generic platform error message, emit a mo=
re
> >> helpful message if a problem occurs and return 0 to suppress the gener=
ic
> >> message.
> >>
> >> This patch is a preparation for making platform remove callbacks return
> >> void.
> >=20
> > If that's the plan - I don't have anything against this patch.
> >=20
> >> Signed-off-by: Uwe Kleine-K=EF=BF=BDnig <u.kleine-koenig@pengutronix.d=
e>
> >> ---
> >> Hello,
> >>
> >> note that in the situations where the driver returned an error before
> >> and now emits a message, there is a resource leak. Someone who knows
> >> more about this driver and maybe even can test stuff, might want to
> >> address this. This might not only be about non-freed memory, the device
> >> disappears but it is kept in sdei_list and so might be used after being
> >> gone.
>=20
> > I'd need James' input on this. I guess we may ignore
> > sdei_event_disable() return value and continue anyway in agdi_remove(),
> > whether that's the right thing to do it is a different question.
>=20
> The unregister stuff is allowed to fail if the event is 'in progress' on =
another CPU.
> Given the handler panic()s the machine, if an event is in progress, the r=
esource leak
> isn't something worth worrying about. The real problem is that the handle=
r code may be
> free()d while another CPU is still executing it, which is only a problem =
for modules.
>=20
> As this thing can't be built as a module, and the handler panic()s the ma=
chine, I don't
> think there is going to be a problem here.

Is that an Ack?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--idoesrj4k3fx7uel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNZbRQACgkQwfwUeK3K
7AklUQf/SRwG8zgceKur8tZo26m9NURTsoZiER+Vq4N4g9tEqv7qmNDXkg6hlNUH
t+l0OUlgAX1xRg1JVRnM/GjM+Mld77MWw6qYydZUDruAyiLzICXMYM5GaUCskegO
B/LXpdxlskJlM++yLUtyG1FMWWChCScBiS8iU8D3zeZp3HLWIyGhSezwWrXqDuj3
VTQQIMOyvhVsBZvb7PMA8CpeopuZKZIzoctN4z64ABxMJyj5NeiBNNxjZUQtEePN
e2zhmqq3CnczapWhwLT8AZoSG2eC6oE15A7RV3u74szz+wxkU8sHuZvYzG22Hn7g
+TXcs7kphM150DB4DaB5KJW8nLG0Ow==
=zJwz
-----END PGP SIGNATURE-----

--idoesrj4k3fx7uel--
