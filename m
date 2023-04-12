Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38506DF922
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Apr 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDLOzt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Apr 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjDLOzj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2023 10:55:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D4131
        for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2023 07:55:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbsW-0004p8-9j; Wed, 12 Apr 2023 16:55:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbsU-00AlGz-5Z; Wed, 12 Apr 2023 16:55:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbsT-00CcuF-6D; Wed, 12 Apr 2023 16:55:17 +0200
Date:   Wed, 12 Apr 2023 16:55:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes()
 return void
Message-ID: <20230412145517.6vozcdkhcg6xd5xh@pengutronix.de>
References: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
 <20221221182138.aqupmjom5kixvvsu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4nuwsjszo7xjvhmp"
Content-Disposition: inline
In-Reply-To: <20221221182138.aqupmjom5kixvvsu@pengutronix.de>
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


--4nuwsjszo7xjvhmp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

On Wed, Dec 21, 2022 at 07:21:38PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Dec 21, 2022 at 02:53:05PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 20, 2022 at 4:45 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > [...]
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index 066dc1f5c235..7d705930e21b 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct ghe=
s *ghes)
> > >                                  ghes_sdei_critical_callback);
> > >  }
> > >
> > > -static int apei_sdei_unregister_ghes(struct ghes *ghes)
> > > +static void apei_sdei_unregister_ghes(struct ghes *ghes)
> > >  {
> > > +       /*
> > > +        * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_regist=
er_ghes()
> > > +        * cannot have been called successfully. So ghes_remove() won=
't be
> > > +        * called because either ghes_probe() failed or the notify ty=
pe isn't
> > > +        * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
> > > +        * Note the if statement below is necessary to prevent a link=
er error as
> > > +        * the compiler has no chance to understand the above correla=
tion.
> > > +        */
> > >         if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
> > > -               return -EOPNOTSUPP;
> > > +               BUG();
> >=20
> > Well, you could just provide an empty stub for the !CONFIG_ARM_SDE_INTE=
RFACE.
> >=20
> > It would be cleaner and probably fewer lines of code too.
>=20
> It's you who cares for this code, but I'd prefer my option. If we assume
> the describing comment would have a similar length, we're saving 3 or
> four lines of code here but need 3 lines for the #if / #else / #endif
> plus the stub definition. And compared to my suggested solution we don't
> catch someone introducing a (bogus) call to apei_sdei_unregister_ghes()
> (or sdei_unregister_ghes()). And (again IMHO) two different
> implementations are harder to grasp than a single with an if.
>=20
> If you don't like the BUG, a plain return is in my eyes the next best
> option which is semantically equivalent to an empty stub.
>=20
> If you still like the stub better (or a return instead of the BUG), I
> can send a v3, just tell me your preference.

I work on changes that depend on a solution here. However you didn't
tell me your preference here. I'm unsure if this means that this
discussion fell through the cracks, or if it annoys you and you still
prefer the cpp #ifdef solution. A note from your side would be very
welcome.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4nuwsjszo7xjvhmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ2xlQACgkQj4D7WH0S
/k6XlQf/WYEprpxjjJUkhIn2+IVelpsJR3aE0CEiP1AioUfZ99DZUEtfVW62/K9g
QDjTX0JAAzF5lqt40irFYL2C0vUEBoTN6otvGlUf6NM9HTAucY8L1sM4eU7XIC0O
AwCTk1Q1+CleRbZSYFainvl1Ke9xKRTM4wzZxmKUkfvoP06sVf3YxDYI1SDhlhze
3/uijHtfrdULGc40fLWW88L+DTaPtB2pkFl7z/67Jq4FJiTTBAN7S6fxJEZ/P/Qv
UZSa6WnV3an0tfTqSJhn0ZrFpOTg2/FhHDrJmQ8IoQG4ErhUX6ay3mXDNGxo0oBI
GYfIDr5BGEGJ+jtysjsA/k/WJQGtMA==
=hGIY
-----END PGP SIGNATURE-----

--4nuwsjszo7xjvhmp--
