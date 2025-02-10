Return-Path: <linux-acpi+bounces-10960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E8A2F174
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A993A819C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DC2309B4;
	Mon, 10 Feb 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="dKayQUse"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49A23A572;
	Mon, 10 Feb 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201050; cv=pass; b=ijHsYJseXHcNXZEvEYV8/4MaCW6gXQ0TSOl4d9Sl3Ev86KJw4FvHOByACveBVfSueMMdyXn6BSntPuODA9uwmg0Ko4VgRXdsf3pMWqELR61ZU2E1WT2MVN1XOPRezYdrRCPOlOLiabbp+sqim7dTE/T03QPRH1rCa0z7ieTNb7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201050; c=relaxed/simple;
	bh=mAnTX1oV6+9cmQuzxoGQq/j6gj+4sI+StC2J/kkcuYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcvgkS2p2mLYIcOd6SNTx4a+nowB1C30scePAKFPIGl4ppSerrnyXxgD9zVQeb9Q/JqueG+oycy8eRPuKciAR3UvHrXlC8Yv+WvOpl85Inf8odCuql6crYUt7irVVDq76JGxVFxr+gTGiANuxCAnwgr0EmK3Z05jZCj0gIQ96jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=dKayQUse; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739201037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Usbg0N6HtrBHmHMGPG8OUjqFdBl6L8QynmRG8Rr5UJ6PdZn8X6j994JG4Pspc0qmTr43NYB2dw7PkiGtcWeWL6+me0uIhDifpZKVNShqIiP6b97dKdVr2tXmZT0AhOrzqPEXKn7kZX2TvWdcSXMqHiRFjVSFjBIwY/4mroKQ/FQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739201037; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sRwutcmLNiEbAA4LrUfqccfyltYi4XqJBCHDxz271Sg=; 
	b=lS3Vo4MjmcgaOct5fxHKxX2c1QfXOR1D7LqtocZamH3XVHQ/dJBA3XmVkTrN64QWQqIlNFMNttoaH+yoU68Msn+o6/e75/uUaHy98OQeoJ/dl4YBuyrl94JdRvLZABASGV1TFRgvkrUgWJ2skC3NWNTmm5HmosWYtBxkXZJZkuU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739201037;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sRwutcmLNiEbAA4LrUfqccfyltYi4XqJBCHDxz271Sg=;
	b=dKayQUseIlycVkT4AFMY3fzY8t+MZSNl0syBxXa9havAefQj1LSeajaSWwoYV/Ic
	GOLVW19awACXdcP1aQWugPWXx4+De7JvHa4Cqu6Sg+PqfIKtojtcCsJAtEVwNR0mW86
	0Chb8KpxYXNbX59MgC7azK+Dj+d+wTXpCM/xM7vA=
Received: by mx.zohomail.com with SMTPS id 1739201034012410.7883233381324;
	Mon, 10 Feb 2025 07:23:54 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 05A911808D9; Mon, 10 Feb 2025 16:23:51 +0100 (CET)
Date: Mon, 10 Feb 2025 16:23:50 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/4] ACPI: battery: Save and report battery capacity over
 suspend
Message-ID: <bzltxadthnef5c4xaidfcjuq7tt2h23znn76povptoxbb2iax6@xvuzfqbtomzb>
References: <20250208162210.3929473-1-superm1@kernel.org>
 <20250208162210.3929473-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ns2ue64hv7lbwve7"
Content-Disposition: inline
In-Reply-To: <20250208162210.3929473-3-superm1@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/232.373.49
X-ZohoMailClient: External


--ns2ue64hv7lbwve7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] ACPI: battery: Save and report battery capacity over
 suspend
MIME-Version: 1.0

Hi,

On Sat, Feb 08, 2025 at 10:22:08AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> To find out if a device is malfunctioning over suspend it's often
> interesting to know how much battery was lost.
>=20
> At the start of the suspend cycle cache the amount of battery.
> During resume, read the battery level again and if the battery
> has decreased report the difference to the suspend stats using
> pm_report_sleep_energy()
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

This code assumes, that there is only a single battery, but there
can be more than one battery supplying the system. For example
Thinkpads used to have an internal battery and a user swappable
one.

Also it seems in almost all cases debugging this from userspace
by dropping a script in /usr/lib/systemd/system-sleep is good
enough, so I wonder if extending the kernel ABI makes sense at
all.

Greetings,

-- Sebastian

>  drivers/acpi/battery.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8af55..f21bfd02a26d1 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -124,6 +124,7 @@ struct acpi_battery {
>  	char oem_info[MAX_STRING_LENGTH];
>  	int state;
>  	int power_unit;
> +	int capacity_suspend;
>  	unsigned long flags;
>  };
> =20
> @@ -1011,9 +1012,6 @@ static int acpi_battery_update(struct acpi_battery =
*battery, bool resume)
>  		return 0;
>  	}
> =20
> -	if (resume)
> -		return 0;
> -
>  	if (!battery->update_time) {
>  		result =3D acpi_battery_get_info(battery);
>  		if (result)
> @@ -1032,6 +1030,14 @@ static int acpi_battery_update(struct acpi_battery=
 *battery, bool resume)
>  			return result;
>  	}
> =20
> +	if (resume) {
> +		if (battery->capacity_suspend > battery->capacity_now)
> +			pm_report_sleep_energy(battery->capacity_suspend - battery->capacity_=
now);
> +		else
> +			pm_report_sleep_energy(0);
> +		return 0;
> +	}
> +
>  	/*
>  	 * Wakeup the system if battery is critical low
>  	 * or lower than the alarm level
> @@ -1285,6 +1291,22 @@ static void acpi_battery_remove(struct acpi_device=
 *device)
>  }
> =20
>  /* this is needed to learn about changes made in suspended state */
> +static int acpi_battery_suspend(struct device *dev)
> +{
> +	struct acpi_battery *battery;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	battery =3D acpi_driver_data(to_acpi_device(dev));
> +	if (!battery)
> +		return -EINVAL;
> +
> +	battery->capacity_suspend =3D battery->capacity_now;
> +
> +	return 0;
> +}
> +
>  static int acpi_battery_resume(struct device *dev)
>  {
>  	struct acpi_battery *battery;
> @@ -1301,7 +1323,7 @@ static int acpi_battery_resume(struct device *dev)
>  	return 0;
>  }
> =20
> -static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resu=
me);
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, acpi_battery_suspend, a=
cpi_battery_resume);
> =20
>  static struct acpi_driver acpi_battery_driver =3D {
>  	.name =3D "battery",
> --=20
> 2.43.0
>=20
>=20

--ns2ue64hv7lbwve7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeqGfgACgkQ2O7X88g7
+poGmg//VR2z3IB6ktRbpIibDzPZzxXxyAG0COTvNBJ9q/WOlPBkWGMyP+6YIUk0
DTfLQUyHQzkcEpUoMieDoCDLr5b89CaKTMmoGd60sZzIK17AT/Qkk3M44PDNrtve
xdEkZ7MRdtQkTksonLPlDe7ZNXuGh9lgkb1c8D7vcRM6w1Q1B8X75Dw+4q/KYS5W
WsdBiU8HTdnrWjG70ZFDr0oqC9qQTQzklO0T5IztNBrsqTs6qhJ/zspHgjvVlVsG
RKk3PkuAxQIPAfHhIxRgnHLo6DYJpD9CpHZcYeW9/idHzdzcxotbTVZUDXLzdgE4
UUcH5Yg+91JVbUiVu6fx8qUZnzdwYvsUy1gNrSHVZPJOuOHjbEvZrv9tJmqYHH1n
B6pDmz8QzhIxBuhzJa2EjMkqsgOn7GerQ4xbtLTrLn90nlOUh8Maef8V2QC/FMLS
x+D0gpJY2auq7bFJaPVNHckXx6bvBwi2uC98ev7GlOH8GLvFORvxiadLNIVjMPUK
cSoXzVm0ai3nS5LBF+dNvl7xP8H8kpKaZO0K0JxQgVWq3nC+OCSm/o22bjz1Nq+/
q4h+tQ9JZMXzvvq4SfLuwsu8iRudmjpACgHm4bqLd1h9uO6EpIVpyl6fUjbLS+u3
1dErEuHDgoi6sb2Rtn4lNwz0xXXmkYqXdgdJ9QTEra5G6zazw4o=
=NdRQ
-----END PGP SIGNATURE-----

--ns2ue64hv7lbwve7--

