Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B176C8085
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCXO5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjCXO5e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 10:57:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDBAF0B
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 07:57:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfir2-0002Eo-G7; Fri, 24 Mar 2023 15:57:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfir0-006PLU-5C; Fri, 24 Mar 2023 15:57:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfiqz-007e2N-1o; Fri, 24 Mar 2023 15:57:17 +0100
Date:   Fri, 24 Mar 2023 15:57:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de,
        acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Make check to install handler more obviously
 correct
Message-ID: <20230324145716.irqgescu3pvnjobt@pengutronix.de>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
 <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
 <20230324143849.2y4rdnes3irhw2b2@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icdv5bytu7kohzlb"
Content-Disposition: inline
In-Reply-To: <20230324143849.2y4rdnes3irhw2b2@bogus>
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


--icdv5bytu7kohzlb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 02:38:49PM +0000, Sudeep Holla wrote:
> On Fri, Mar 24, 2023 at 11:59:38AM +0100, Uwe Kleine-K=F6nig wrote:
> >
> > My motivation isn't big enough to even read that. If the usual kernel
> > workflow doesn't work for ACPICA, let's drop the patch.
>=20
> :(, but ACPICA is reused on other OSes and hence the need to be a separate
> project. It is very similar to the way DTC changes are done elsewhere and
> imported into the kernel.

Feel free to pick up my patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--icdv5bytu7kohzlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQduksACgkQj4D7WH0S
/k5iEAf/WFpLa/DLOX6wun2sCZzWLLazByHJx6+oUS7i3vD8dcSylkI8SYrDtmju
XUqNM1mX0TfJX0U8WY66OoaJhMIXnAzRr+qhqOP1SbuP6JOU1NuuoC2wKIHzohCK
TNmzoOPa84bhhBio4A4QF9P6Eqd64WAGhOCsE0uR33ml3QoFvv6eAd2Tt2uOGScv
aU/I9Dhln5l7xLt6gcMFtWXosYY+6V8g7IOIAecja8WrWg2duzbNVkT8PMN+mSoS
gjMnp/vxQCa+NyXHTN1ja8k6IMaIjm20s4OZCLJJwHQ60KLPFubIRS0aG3n3VAIz
ScLkmf/rehsF6mmgb9oZ7bZZQKAFrA==
=aiOU
-----END PGP SIGNATURE-----

--icdv5bytu7kohzlb--
