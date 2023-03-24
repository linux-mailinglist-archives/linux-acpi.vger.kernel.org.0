Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1846C7E0D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 13:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCXMad (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 08:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCXMaJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 08:30:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C021AC
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 05:30:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgYY-0005Go-Kw; Fri, 24 Mar 2023 13:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgYX-006NbZ-WD; Fri, 24 Mar 2023 13:30:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfgYX-007ble-6O; Fri, 24 Mar 2023 13:30:05 +0100
Date:   Fri, 24 Mar 2023 13:30:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Pierre Asselin <pa@panix.com>,
        kernel@pengutronix.de, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: bus: Only call notify for a completely bound ACPI
 device
Message-ID: <20230324123004.sw7m3ui4gfxdbgdn@pengutronix.de>
References: <20230324090955.462581-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzemhd24phxcsp37"
Content-Disposition: inline
In-Reply-To: <20230324090955.462581-1-u.kleine-koenig@pengutronix.de>
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


--wzemhd24phxcsp37
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 24, 2023 at 10:09:55AM +0100, Uwe Kleine-K=F6nig wrote:
> Commit d6fb6ee1820c ("ACPI: bus: Drop driver member of struct
> acpi_device") removed acpi_device::driver in favour of struct
> acpi_device::dev.driver.
>=20
> However there is a problem: While the two pointers are equivalent after
> the device is completely probed, there is a small time frame where
> acpi_device::dev->driver is already set but acpi_device::driver wasn't.
>=20
> The function acpi_bus_notify() used to have a check for
> acpi_device::driver that was changed to a check for adev->dev.driver in
> Commit d6fb6ee1820c.
>=20
> Pierre Asselin reports that starting with above change his laptop
> crashed during boot when on AC power. That's because acpi_bus_notify()
> is called in that small time frame (triggered by acpi_ac_add()) which
> results in a call to acpi_ac_notify while this function isn't ready yet.
>=20
> So in acpi_bus_notify() check for the device being bound (which becomes
> true only after the acpi probe call succeeds) instead of for
> acpi_device::dev.driver.
>=20
> Note that usually you have to hold the device lock to call
> device_is_bound(). I don't think this is the case here, so there likely
> is a race condition. The problem might be that the driver unbinds after
> the check but before adev->dev.driver is evaluated. However this race
> already existed before commit d6fb6ee1820c, so the change here is a net
> improvement even though it might not result in a completely correct
> handling.
>=20
> A similar check in the acpi sysfs code is also converted. This is less
> critical as it happens in code that is run when a sysfs file is
> accessed. That shouldn't happen for a device that isn't bound.
>=20
> Fixes: d6fb6ee1820c ("ACPI: bus: Drop driver member of struct acpi_device=
")
> Reported-by: Pierre Asselin <pa@panix.com>
> Link: https://lore.kernel.org/linux-acpi/9f6cba7a8a57e5a687c934e8e406e28c=
=2Esquirrel@mail.panix.com
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9531dd0fef50..a5a8f82981ce 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 t=
ype, void *data)
>  	if (!adev)
>  		goto err;
> =20
> -	if (adev->dev.driver) {
> +	if (device_is_bound(&adev->dev)) {
>  		struct acpi_driver *driver =3D to_acpi_driver(adev->dev.driver);
> =20
>  		if (driver && driver->ops.notify &&
>=20

there is a hunk that I failed to add to the commit:

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 0fbfbaa8d8e3..2ee756d68052 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -376,7 +376,7 @@ eject_store(struct device *d, struct device_attribute *=
attr,
 		return -EINVAL;
=20
 	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
-	    && !d->driver)
+	    && !device_is_bound(d))
 		return -ENODEV;
=20
 	status =3D acpi_get_type(acpi_device->handle, &not_used);

Rafael sait in the thread where Pierre reported the problem that he has
a different fix in mind. So I guess it's not worth to send a v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wzemhd24phxcsp37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQdl8sACgkQj4D7WH0S
/k7tkAgAoK1kNmAnDoFqBUNsupZGUL5ah/pcuqZRHyi9t1q84MEd5cI+Ps+taqtx
Hlb/udfW/Bs4O5fOB7QHchIugSDCdVPRdm9Lk+YpJtVKTu6fylKAOD7lVXHZ1xob
pXiL2Gh/YBIxi0Pv8awcw7vXJBioAZE3wc0AXIRfgIh4s8y87Zad3VRgXxs52Txp
SNEKD0UI1WatSJi18ZnWaV1C2UQjExXZhps4U+vIbM+5wu/auOTBsK/btHvZNj3t
FKP5wvCM4/1a/gobK2X/FR/xG691nLCK4hCJTSWqz07beWlx2PZm1kcZvI5oEGxT
B4Qb8kzpJFjYD/xf0RlmHtBQPtvaQQ==
=b8gr
-----END PGP SIGNATURE-----

--wzemhd24phxcsp37--
