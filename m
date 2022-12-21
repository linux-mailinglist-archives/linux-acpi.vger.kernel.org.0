Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9565360E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiLUSVt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Dec 2022 13:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLUSVp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 13:21:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2C26D9
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 10:21:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p83io-0001EC-7o; Wed, 21 Dec 2022 19:21:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p83il-000qbn-Mu; Wed, 21 Dec 2022 19:21:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p83il-006vV4-05; Wed, 21 Dec 2022 19:21:39 +0100
Date:   Wed, 21 Dec 2022 19:21:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes()
 return void
Message-ID: <20221221182138.aqupmjom5kixvvsu@pengutronix.de>
References: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3y4vh7uq6xvw6ep"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
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


--c3y4vh7uq6xvw6ep
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

On Wed, Dec 21, 2022 at 02:53:05PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 20, 2022 at 4:45 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > [...]
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 066dc1f5c235..7d705930e21b 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct ghes =
*ghes)
> >                                  ghes_sdei_critical_callback);
> >  }
> >
> > -static int apei_sdei_unregister_ghes(struct ghes *ghes)
> > +static void apei_sdei_unregister_ghes(struct ghes *ghes)
> >  {
> > +       /*
> > +        * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_register=
_ghes()
> > +        * cannot have been called successfully. So ghes_remove() won't=
 be
> > +        * called because either ghes_probe() failed or the notify type=
 isn't
> > +        * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
> > +        * Note the if statement below is necessary to prevent a linker=
 error as
> > +        * the compiler has no chance to understand the above correlati=
on.
> > +        */
> >         if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
> > -               return -EOPNOTSUPP;
> > +               BUG();
>=20
> Well, you could just provide an empty stub for the !CONFIG_ARM_SDE_INTERF=
ACE.
>=20
> It would be cleaner and probably fewer lines of code too.

It's you who cares for this code, but I'd prefer my option. If we assume
the describing comment would have a similar length, we're saving 3 or
four lines of code here but need 3 lines for the #if / #else / #endif
plus the stub definition. And compared to my suggested solution we don't
catch someone introducing a (bogus) call to apei_sdei_unregister_ghes()
(or sdei_unregister_ghes()). And (again IMHO) two different
implementations are harder to grasp than a single with an if.

If you don't like the BUG, a plain return is in my eyes the next best
option which is semantically equivalent to an empty stub.

If you still like the stub better (or a return instead of the BUG), I
can send a v3, just tell me your preference.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c3y4vh7uq6xvw6ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOjTq8ACgkQwfwUeK3K
7AlKtQf/faihfeySoCzD2OfAysmFnjN3bnJ4K+M1QNgnIGACHesFi6Ucu9pUfH+H
aey50K7tra2f/J2zCxag1mwLgeKRnn2ypevPpHk/nD88VoYHDZGBJTMlv0itmbnv
7DKU6KB1mSQGzOrQlo3/43Mr4C7LKnRUnvfu2pazBquwETK1NWoYA6BKMgxQvBjO
An/nbOhuByAmhgnZxxENO9a1NK/kbVt1Kq035f7S62T/XHX7AHCQXjb6NEtM+9IM
fyg/qMb8aye9gGDGlv1Xqex67trNKK/bcNmHiVi/AKJ8WH/lT2nzilGUS9M8FRX1
7Ks2Q+va0oqEWhcsbKisQWVdL1KllA==
=BhSh
-----END PGP SIGNATURE-----

--c3y4vh7uq6xvw6ep--
