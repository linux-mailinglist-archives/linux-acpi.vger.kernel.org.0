Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03DD6C7CF1
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCXLAY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 07:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCXLAX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 07:00:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96C244A6
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 04:00:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pff95-0002EU-MN; Fri, 24 Mar 2023 11:59:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pff91-006MVr-R6; Fri, 24 Mar 2023 11:59:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pff91-007aB1-3G; Fri, 24 Mar 2023 11:59:39 +0100
Date:   Fri, 24 Mar 2023 11:59:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de,
        acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Make check to install handler more obviously
 correct
Message-ID: <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6obh4u7kdvvmvoef"
Content-Disposition: inline
In-Reply-To: <20230324095329.3oat5nuqhuqqycsr@bogus>
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


--6obh4u7kdvvmvoef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 09:53:29AM +0000, Sudeep Holla wrote:
> On Fri, Mar 24, 2023 at 08:58:54AM +0100, Uwe Kleine-K=F6nig wrote:
> > The loop
> >=20
> > 	for (i =3D 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
> > 		if (handler_type & (i + 1)) {
> > 			...
> > 		}
> > 	}
> >=20
> > looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES =3D=3D 2 yo=
u can
> > see that the two least significant bits are checked. Still replace
> >=20
> > 	i + 1
> >=20
> > by
> >=20
> > 	1 << i
> >=20
> > which shouldn't make a relevant difference to compiler and compiled
> > code, but is easier to understand for a human code reader.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> You need to submit this to ACPICA project first.
> Documentation/driver-api/acpi/linuxized-acpica.rst explains the process.
> Refer [1] for details for similar suggestion by Rafael.

My motivation isn't big enough to even read that. If the usual kernel
workflow doesn't work for ACPICA, let's drop the patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6obh4u7kdvvmvoef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdgpkACgkQj4D7WH0S
/k7gkQgAp3/vWYTAeTxJdQBeEcQRLdOX0d0ON7QnL/VDoCTGQ1owOjd1/8/p9Xeg
PvpCIH0KcUGqiKCTrKXKPWaSAlfWZpk3CrwDgY2XxYOVVV5tzepEzrACvI2gxIIn
XjhemOYqnJ6varurw2UdgbTjpxQGGBAu5fswmo+gYchBqsnGqL/b23dH9n2IS4Ru
6Ng16VbiinNydejRKn9FWTH+p1/FCsO4qUIopwJPNrQaM1XW6VyeLW5QOA1fJ3zy
lskkWBSzT9iMsp6gDbLMo2v8IunYcuZi6Tz/rp4B/JmBfIkdR/UE3+rx6I901rCc
MEm0487K3lXqudOj8ZiDwn0I17Nc4Q==
=Ii3L
-----END PGP SIGNATURE-----

--6obh4u7kdvvmvoef--
