Return-Path: <linux-acpi+bounces-6014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C958D0FA3
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 23:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C73F1C21AB7
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CD139D10;
	Mon, 27 May 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ysFvJeHv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3D1CAA9;
	Mon, 27 May 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716846224; cv=none; b=e3J0gaqzXHQ7DAj/TLXKA8Dda8D/HJ1Yu/2mbiPNkCb0OTRnBamGVvkDCyl6l1773+HCnGRTHeDgeCdH2U29uuQkQF1YBp9YOzGl6W2F0CMt6tC8CzIehx1T4ZZrzV1ELEaEPjYzm6ZotGYOtNea0F6REQwpFATWi6FRF/zije4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716846224; c=relaxed/simple;
	bh=X+zXPmKQ0RClHtqVt1YiZe8llIi3tJ+EFNRQseL7MmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNsh9/MatG32yMFn5sKYhVhCGHUZO1zt16X0bSRqLxqZcEo2JbeZYt7ukT0A8bPsvXadGELgCntaprSQisxhJnCOacoZ/MIWjQ5XT6T88kNffbxPUY1zAP185jGxC7+FLyi1f/k/fbRXp1w0hqmv+wNfr6gsSZVf5mBf78gxxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ysFvJeHv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716846219;
	bh=X+zXPmKQ0RClHtqVt1YiZe8llIi3tJ+EFNRQseL7MmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ysFvJeHvEZUEL1zQ4L9o2KjHFi3RmNLQlApUFlI/HOghuGEqI+ypOz6xxndG3TiOW
	 tT251UkuG0dR64KopDi+/s/WVJDddUR2zRXo0cJ9QERIL66PCg1Wwd6/IDpNYYKDhQ
	 S46dHYuh+LC+F5b0CzrguELIrGgJC18IscGf+mLB9JQVyYU0wexxGd3/5FFhuwJRvZ
	 kzPhdlX+ptKuGsknjf95Ss5KhWlFjENk2XBRZlTqFQFTkYr2K0ENTWm0KQezSC3E31
	 IAKwB+3Md9qyOTuOvWSiy/zt0fMTAdknqEmCtliOpopUBpqI65c0F7ty+Z4mW0DLES
	 plWy2nelJDY6g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A15E53780480;
	Mon, 27 May 2024 21:43:39 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 13F0310612B3; Mon, 27 May 2024 23:43:39 +0200 (CEST)
Date: Mon, 27 May 2024 23:43:39 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH] ACPI: AC: Properly notify powermanagement core about
 changes
Message-ID: <r5x24fxz5cbyd4laoteq577toqfblfmy4btn4c6o6rrl7godeu@4fgsimcubzrd>
References: <20240526-acpi-ac-changed-v1-1-f4b5997753bb@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocxnujsdr2oxrri5"
Content-Disposition: inline
In-Reply-To: <20240526-acpi-ac-changed-v1-1-f4b5997753bb@weissschuh.net>


--ocxnujsdr2oxrri5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 26, 2024 at 11:40:01PM +0200, Thomas Wei=DFschuh wrote:
> The powermanagement core does various actions when a power-supply changes.
> It calls into notifiers, LED triggers, other power supplies and emits an =
uevent.
>=20
> To make sure that all these actions happen properly call power_supply_cha=
nged().
>=20
> Reported-by: Rajas Paranjpe <paranjperajas@gmail.com>
> Closes: https://github.com/MrChromebox/firmware/issues/420#issuecomment-2=
132251318
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/acpi/ac.c  | 4 ++--
>  drivers/acpi/sbs.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 2d4a35e6dd18..09a87fa222c7 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -145,7 +145,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 ev=
ent, void *data)
>  						  dev_name(&adev->dev), event,
>  						  (u32) ac->state);
>  		acpi_notifier_call_chain(adev, event, (u32) ac->state);
> -		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> +		power_supply_changed(ac->charger);
>  	}
>  }
> =20
> @@ -268,7 +268,7 @@ static int acpi_ac_resume(struct device *dev)
>  	if (acpi_ac_get_state(ac))
>  		return 0;
>  	if (old_state !=3D ac->state)
> -		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> +		power_supply_changed(ac->charger);
> =20
>  	return 0;
>  }
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 94e3c000df2e..dc8164b182dc 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -610,7 +610,7 @@ static void acpi_sbs_callback(void *context)
>  	if (sbs->charger_exists) {
>  		acpi_ac_get_present(sbs);
>  		if (sbs->charger_present !=3D saved_charger_state)
> -			kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHANGE);
> +			power_supply_changed(sbs->charger);
>  	}
> =20
>  	if (sbs->manager_present) {
> @@ -622,7 +622,7 @@ static void acpi_sbs_callback(void *context)
>  			acpi_battery_read(bat);
>  			if (saved_battery_state =3D=3D bat->present)
>  				continue;
> -			kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
> +			power_supply_changed(bat->bat);
>  		}
>  	}
>  }
>=20
> ---
> base-commit: 6fbf71854e2ddea7c99397772fbbb3783bfe15b5
> change-id: 20240526-acpi-ac-changed-a08c6941ae51
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--ocxnujsdr2oxrri5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZU/ooACgkQ2O7X88g7
+ppSEw//cGUjBMrRvbVbNEw4zn0y5P/uJwp8Gdhfa2WuF9iKNPAIAP4BuoQVSroi
CfeN0uAe7VOXj6DHrAZLzRx2JyCRqfbA4xV0dOa1NMLwZBMBcAHhI/zE/Uyb/Ajh
x9y/W36z/k34ciEHYGA7fHLhbFvSyQzDEgDE2ivByhMlMZMxSpRsovjc34eeUaty
2IB17/Vqmdu+LK0MYuTitnolNHKxxJBoAeGeIpuUCKUlmaKNj1RjpR10P1yoXHpH
SYsYwbqUNCSPUL1zoYooQg+/w65Sm8vAdNN2rWSaM7F0Jw7jo/eqVWHOgI8Lk6bD
LLjE2+DzMWmO2KwmE03seN2Hc6vhqC1PgSEw8rI18Cl40lk/IIFmf89uO1s5FIfk
cbp6Qc8AknlhvTNw3+GSV/C1602N17hRJ/viL9xWtWZtGG0L34rc2fy9pOaIfwtM
5FoenJR0ZBGFbROrFgCZEork98KL8wERj973YnyQ0pb4QtUv20tRDc+s4cBSHuSe
1pPPk9MNCTnS5vdKzYGjOBKQKwOCXqQR415K5ltYca//MqZrrqq6+7rFAL2fYAR+
eYl7w0Ree1/TJmCaTi/IUZv7JpOHZBIP+21544X3FwKSYis3Uwaij9HNf3dNFEoD
m5jZHKUv90AO3yKugzuUioTTvhBtd0XMzWWClJcYwTmOyQUvOdE=
=6hnM
-----END PGP SIGNATURE-----

--ocxnujsdr2oxrri5--

