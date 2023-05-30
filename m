Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C571578F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 May 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjE3HtO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 May 2023 03:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjE3Hst (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2023 03:48:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F7193
        for <linux-acpi@vger.kernel.org>; Tue, 30 May 2023 00:48:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3u4a-00035d-UP; Tue, 30 May 2023 09:47:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3u4Z-003oxg-Tn; Tue, 30 May 2023 09:47:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3u4Z-009OgM-2D; Tue, 30 May 2023 09:47:15 +0200
Date:   Tue, 30 May 2023 09:47:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes()
 return void
Message-ID: <20230530074714.bvxe44ofo2tr2pvr@pengutronix.de>
References: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0inEMEQ1NJwjNboDokL_35-yG8o6QwVb5po2qKW8LRLWA@mail.gmail.com>
 <20221221182138.aqupmjom5kixvvsu@pengutronix.de>
 <20230412145517.6vozcdkhcg6xd5xh@pengutronix.de>
 <CAJZ5v0hswyNQoY9GPuPaj61a3xHbNE+Xhd+7K-JekKRzTPDbfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2pgkxovml7zdsibq"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hswyNQoY9GPuPaj61a3xHbNE+Xhd+7K-JekKRzTPDbfQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--2pgkxovml7zdsibq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 12, 2023 at 08:33:15PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 12, 2023 at 4:55=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Dec 21, 2022 at 07:21:38PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Dec 21, 2022 at 02:53:05PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 20, 2022 at 4:45 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > [...]
> > > > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > > > index 066dc1f5c235..7d705930e21b 100644
> > > > > --- a/drivers/acpi/apei/ghes.c
> > > > > +++ b/drivers/acpi/apei/ghes.c
> > > > > @@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct=
 ghes *ghes)
> > > > >                                  ghes_sdei_critical_callback);
> > > > >  }
> > > > >
> > > > > -static int apei_sdei_unregister_ghes(struct ghes *ghes)
> > > > > +static void apei_sdei_unregister_ghes(struct ghes *ghes)
> > > > >  {
> > > > > +       /*
> > > > > +        * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_re=
gister_ghes()
> > > > > +        * cannot have been called successfully. So ghes_remove()=
 won't be
> > > > > +        * called because either ghes_probe() failed or the notif=
y type isn't
> > > > > +        * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
> > > > > +        * Note the if statement below is necessary to prevent a =
linker error as
> > > > > +        * the compiler has no chance to understand the above cor=
relation.
> > > > > +        */
> > > > >         if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
> > > > > -               return -EOPNOTSUPP;
> > > > > +               BUG();
> > > >
> > > > Well, you could just provide an empty stub for the !CONFIG_ARM_SDE_=
INTERFACE.
> > > >
> > > > It would be cleaner and probably fewer lines of code too.
> > >
> > > It's you who cares for this code, but I'd prefer my option. If we ass=
ume
> > > the describing comment would have a similar length, we're saving 3 or
> > > four lines of code here but need 3 lines for the #if / #else / #endif
> > > plus the stub definition. And compared to my suggested solution we do=
n't
> > > catch someone introducing a (bogus) call to apei_sdei_unregister_ghes=
()
> > > (or sdei_unregister_ghes()). And (again IMHO) two different
> > > implementations are harder to grasp than a single with an if.
> > >
> > > If you don't like the BUG, a plain return is in my eyes the next best
> > > option which is semantically equivalent to an empty stub.
> > >
> > > If you still like the stub better (or a return instead of the BUG), I
> > > can send a v3, just tell me your preference.
> >
> > I work on changes that depend on a solution here. However you didn't
> > tell me your preference here. I'm unsure if this means that this
> > discussion fell through the cracks, or if it annoys you and you still
> > prefer the cpp #ifdef solution. A note from your side would be very
> > welcome.
>=20
> Well, every time I see BUG() in the code I wonder if crashing the
> kernel really is the best thing one can do should the execution reach
> that point.
>=20
> In any case, it's not my opinion that matters the most regarding
> APEI/GHES, so I would like Tony/Boris/James to speak up here.

hmm, they didn't speak up so this patch is stalled. I added them to
"To:" (instead of Cc: before) in this mail, let's see if that helps.

Can you please state your preferred solution that I can properly prepare
this driver for the conversion of the remove callback?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2pgkxovml7zdsibq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR1qgIACgkQj4D7WH0S
/k58Iwf/cAYq0Cdh4N5ya0CfEc7/ZzSJ+5FIry6RtaSkoJut6Ezy62KZimZ/6c1y
Za42cXW2bLlfNe1k/1DzjRAAehM1h8OkHyyvhIor9eMCL4Wro+NLeND0vPreeshr
48mGqxp8+hnpUywDn4ltF6TT3kDpOO547jDteqVHG7Lb2i9WgtM2TyRHXNQAzNYE
3Sqw7+FSR1CtF/anPaN5DYSV+CAR/4r2HrESQe4pZME/XqgsrHtIzXQX5Qm8hXaj
QgvgDXXpQJ5OggZ5ecZw6dMdQWpEEmFTjjWupYezVLJLkz0DTcuBGgGFjOB7AxzL
KqBggz7F5977s76y+K5EGDyLP7pCog==
=xt0w
-----END PGP SIGNATURE-----

--2pgkxovml7zdsibq--
