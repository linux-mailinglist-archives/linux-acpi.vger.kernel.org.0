Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5970443344
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 17:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKBQn5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhKBQn4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 12:43:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE5C061714;
        Tue,  2 Nov 2021 09:41:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7A07F1F44D9D
Received: by earth.universe (Postfix, from userid 1000)
        id C75243C0F95; Tue,  2 Nov 2021 17:41:17 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:41:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
Message-ID: <20211102164117.pnbpvephlh4wgrwb@earth.universe>
References: <20211031152522.3911-1-hdegoede@redhat.com>
 <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
 <20211102132352.yqazgy2njnbthujb@earth.universe>
 <e74947c4-74c8-a17e-f4cb-752a79851954@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trige6lnttlhwn57"
Content-Disposition: inline
In-Reply-To: <e74947c4-74c8-a17e-f4cb-752a79851954@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--trige6lnttlhwn57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Nov 02, 2021 at 03:12:51PM +0100, Hans de Goede wrote:
> Hi Sebastian,
>=20
> On 11/2/21 14:23, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sun, Oct 31, 2021 at 09:34:46PM +0200, Andy Shevchenko wrote:
> >> On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wr=
ote:
> >>>
> >>> When registering the IRQ handler fails, do not just return the error =
code,
> >>> this will free the devm_kzalloc()-ed data struct while leaving the qu=
eued
> >>> work queued and the registered power_supply registered with both of t=
hem
> >>> now pointing to free-ed memory, resulting in various kernel crashes
> >>> soon afterwards.
> >>>
> >>> Instead properly tear-down things on IRQ handler register errors.
> >>
> >> FWIW,
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >=20
> > Thanks, queued.
>=20
> Thank you, note these 2 patches (for the bq25980 driver) are also
> pure bug-fixes, I posted them as part of a larger series, but
> in hindsight I should have probably posted them separately:
>=20
> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-4-hdego=
ede@redhat.com/
> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-5-hdego=
ede@redhat.com/
>=20
> It would be good if you can pick these 2 up too
> (I'll respin the rest of the series to address various
> review comments without them then).
> Let me know if you want me to resend these 2 as a stand alone
> series.

Thanks for the pointer, I queued both of them. I had to slightly
rebase, since your base did not include 172d0ccea55c. I have not
yet reviewed the remaining patchset, but considering there are more
patches to bq25890 a rebase would be ncie.

Greetings,

-- Sebastian

--trige6lnttlhwn57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGBaiYACgkQ2O7X88g7
+prPEw/7BK4/d6vHO+t3ZgIuXcTgzREZot5nMRhqnKe5slPDJ32aTn8tdWwIOn0p
WA6tL0645Ktvkfx/DmDlEnwU9hJq0Bg4EUH8Fo8wrd9DyNtkt/vvtx5NVcEa+W3K
Lvtawc0+skeicsoOtJP/6qKgbWtZa+RsrCeYzjx9kJm9iqgzFCQH4gzgF+1THcNh
93EG+EmmZbVHprwvYWXFKroBk5quvT3/1yaiuvgUqSUWgpGSPUpszYDb/K79u0US
1oKyHXzPS6z9ColrkSwvfxXn8jvfTCPROlJnyhljjkpsxWY2ro6zU58e4zf7mqY+
OTUr2wbMb7CGhILuj43A+IaPqm4dzBZ5B2zH18spqI3Ogm44x+5PJlDAOGAjRoR6
P+jsS7aI7+QY3zLVNF1hs/quowAsOwPhaojOumcbp3XtPQhv4HP2vW5B5ndjQNEW
Ps2c6pKho+MwPSNJAbXGc4BQxAXmLmshfLzTbjoEmiuMbsrPNekauhN5lnrZMqoz
4xDqy1LEM7evf2p4GXgbfKBtTDZWi7dGJ9gmn8uDCjZXZtO8Rr7NEFOnbCI1hhbz
HAcjSIgVacBP4wfp3ULGTN3cUbPJNZOcOOxFau5gOmXBMlMz8nt8QdpFxoRmyXOT
G8ROJ4Pki8DXcrPde3eHzt0bVljTWzDhJwuF6dFpe5/nXIVzpLU=
=w4zN
-----END PGP SIGNATURE-----

--trige6lnttlhwn57--
