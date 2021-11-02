Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC0442F0E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKBN0b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 09:26:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBN0a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 09:26:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id ABD4F1F44A21
Received: by earth.universe (Postfix, from userid 1000)
        id 1C9313C0F95; Tue,  2 Nov 2021 14:23:52 +0100 (CET)
Date:   Tue, 2 Nov 2021 14:23:52 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
Message-ID: <20211102132352.yqazgy2njnbthujb@earth.universe>
References: <20211031152522.3911-1-hdegoede@redhat.com>
 <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exju7zrkmgu2clvz"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--exju7zrkmgu2clvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 31, 2021 at 09:34:46PM +0200, Andy Shevchenko wrote:
> On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > When registering the IRQ handler fails, do not just return the error co=
de,
> > this will free the devm_kzalloc()-ed data struct while leaving the queu=
ed
> > work queued and the registered power_supply registered with both of them
> > now pointing to free-ed memory, resulting in various kernel crashes
> > soon afterwards.
> >
> > Instead properly tear-down things on IRQ handler register errors.
>=20
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks, queued.

-- Sebastian

> > Fixes: 703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a mod=
ule")
> > Cc: Andrew F. Davis <afd@ti.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > - Fix devm_kzalloc()-ed type in the commit message
> > ---
> >  drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power=
/supply/bq27xxx_battery_i2c.c
> > index 46f078350fd3..cf38cbfe13e9 100644
> > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > @@ -187,7 +187,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_cli=
ent *client,
> >                         dev_err(&client->dev,
> >                                 "Unable to register IRQ %d error %d\n",
> >                                 client->irq, ret);
> > -                       return ret;
> > +                       bq27xxx_battery_teardown(di);
> > +                       goto err_failed;
> >                 }
> >         }
> >
> > --
> > 2.31.1
> >
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--exju7zrkmgu2clvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGBO+EACgkQ2O7X88g7
+ppmxhAAil5Wgix3gYlBueXhIOuA/ZHpHFxnUZZQHnDlN6n+z3AZMj8quc0MrguB
kPyqTDIUl1mGIZCTWW3QrqJdMrP4+7NV432F15QKH5G1zMizcvE+K3IXoPvsWMq8
tyo4ADWcDDNEFE9F8zc2TrE7AextggLMu/fXVwTuBIYVOl9g1QzJKx+p4dghqBGR
McUpF5isE9APxjHIE36GvgS9nBeyrsylEZ3vS5Qo+Qz0LaMTYvEBzDrLnXD+3p/S
YGejrstEX1uEt+ulPIDRUU8C+BYlRyVke1EIX//l+OOHbJJE9oPb64KoTIlZIiDf
cCMqxWF+gKX0XOpVPRME7LuEdbUGDoVGKqaK1qo3vB2AI6g28M+aVFeSx4ot87FZ
ONjK7TXVl3KCmPcBe1alRlIxNnb2Aj5fXipIoaU6kM9VEEBMjtZFSzKoxi6vCV0E
e7VTHzOIQsVBu7IIeXoN3OmnZE0O4rYtUtfXLJHxDaS7LvfEyBZk4fRhsMCWSA6C
MKTSDx6J/f3wWGRNi+z2vFOrAcyLHiAMh6MHVemSTyWZKghhC9DOBuCJo0Bp/Vlb
3iplXb3YPbqQW9HgQzRyZpEpL4JdjxSdOdAW3j8mjpQYAUFoKTNy/Toq2/SecKhu
tjeQksvHh24hpfWwTZ8n5lVyBoUEALaNGHTTtkN+vmtWPL05aSA=
=/dC6
-----END PGP SIGNATURE-----

--exju7zrkmgu2clvz--
