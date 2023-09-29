Return-Path: <linux-acpi+bounces-289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C67B3592
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B6B1B286FB5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C3BE79
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 14:33:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8494122F
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 13:48:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE65DB
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 06:48:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qmDqb-0003x9-CW; Fri, 29 Sep 2023 15:48:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qmDqa-009pKl-AB; Fri, 29 Sep 2023 15:48:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qmDqa-005wF3-0o; Fri, 29 Sep 2023 15:48:00 +0200
Date: Fri, 29 Sep 2023 15:47:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 48/94]
 drivers/thermal/amlogic_thermal.c:303:16: error: void value not ignored as
 it ought to be
Message-ID: <20230929134757.5ztol37eqttvr4wo@pengutronix.de>
References: <202309291214.Hjn3gJ94-lkp@intel.com>
 <CAJZ5v0gGissufTrvCa+z5i=kPMDM+-RKoQfOHW41zf7o2=z4SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5m4qeuiyxuq2nm4"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gGissufTrvCa+z5i=kPMDM+-RKoQfOHW41zf7o2=z4SQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--h5m4qeuiyxuq2nm4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 12:37:03PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 29, 2023 at 6:21=E2=80=AFAM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
=2Egit bleeding-edge
> > head:   2cff74feed4a2a3a1c220e0ee2838b85b08d4999
> > commit: 88af8b66ffedcad8c5a1522f6a9c02bf8129a951 [48/94] thermal: amlog=
ic: Convert to platform remove callback returning void
> > config: arm-randconfig-004-20230929 (https://download.01.org/0day-ci/ar=
chive/20230929/202309291214.Hjn3gJ94-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230929/202309291214.Hjn3gJ94-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/thermal/amlogic_thermal.c: In function 'amlogic_thermal_susp=
end':
> > >> drivers/thermal/amlogic_thermal.c:303:16: error: void value not igno=
red as it ought to be
> >      303 |         return amlogic_thermal_disable(data);
> >          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> amlogic_thermal_disable() should not be modified by this commit -
> fixed up in the tree.

Thanks for choosing an option that hides that embarrassing build
failure. :-)

IMHO

https://lore.kernel.org/all/20230929061305.2351953-1-u.kleine-koenig@pengut=
ronix.de

is the nicer fix because with that amlogic_thermal_remove() would ignore
the return value of amlogic_thermal_disable(). On top of your current
tree that would be:

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_th=
ermal.c
index 5877cde25b79..562f63b7bf27 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -167,13 +167,11 @@ static int amlogic_thermal_enable(struct amlogic_ther=
mal *data)
 	return 0;
 }
=20
-static int amlogic_thermal_disable(struct amlogic_thermal *data)
+static void amlogic_thermal_disable(struct amlogic_thermal *data)
 {
 	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
 			   TSENSOR_CFG_REG1_ENABLE, 0);
 	clk_disable_unprepare(data->clk);
-
-	return 0;
 }
=20
 static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *t=
emp)
@@ -302,7 +300,9 @@ static int __maybe_unused amlogic_thermal_suspend(struc=
t device *dev)
 {
 	struct amlogic_thermal *data =3D dev_get_drvdata(dev);
=20
-	return amlogic_thermal_disable(data);
+	amlogic_thermal_disable(data);
+
+	return 0;
 }
=20
 static int __maybe_unused amlogic_thermal_resume(struct device *dev)

But I won't argue further and consider the case closed.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h5m4qeuiyxuq2nm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUW1YwACgkQj4D7WH0S
/k5fBwf8DU6ytLGBe3UCbC4aCs+KSO9KKMjRB2/wRBIg/wcF8uSiGYXVEdxaqiTT
OuDnFPRnlI0rxYff524ZBxgQCD8XFBR0qZYCs9Nd1aWYDfYNS3EDPxIJ7Zl1srjO
OppgV0rQILZZ4I3+1WfxqaeQbdvQszrPIrdOS8gGdRvFkmxo/nMx9zrtDp7Xl0XO
xeywc1J736A6+rSm7D56a7TzY/xwuqDT9f6IBqYskBCufGm3FEgbxjrV6hzXr4Bc
7MNU1kNZivh7TPMweQSUrmzoZRECWLA5I8w2Gt6GwTFgpNsEEce+26Cjq2qTipUI
vzeYqecdnuRzTESFNswd4PClJC0biA==
=oV9Q
-----END PGP SIGNATURE-----

--h5m4qeuiyxuq2nm4--

