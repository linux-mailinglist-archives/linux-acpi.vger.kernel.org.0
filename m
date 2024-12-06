Return-Path: <linux-acpi+bounces-9979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511A9E627E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 01:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1000628393C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B81E871;
	Fri,  6 Dec 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="O4e4t5jz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CDBE46;
	Fri,  6 Dec 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446274; cv=pass; b=pM/FfI3To6WQdr73r1hgB6PEFHPWsRpSZqx6oZFDkGo4LQlq/5m+tUaR6pgV8Am9smTsgzcNppKLCz+pRqvVhZP/mAfqmGDZePW6X71vP21q9WU8fghCt6u49lun4QpSwTn5Vm8omxkqTwdWJIPa8ZgTNVdw1vWEa8U3j/+E/yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446274; c=relaxed/simple;
	bh=0vuc1ot7po0pTPhZ8XizidPqvBDqgivsSOGg6k1ViW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3iS219TiYKz4fDgwhB/Fh5k+l8nbVZ1IvVVMpgB53hkDb8KIQrDBl12+itqC2FtI+YIfZfMFUBjlJj5Ggep9CHNAFi1BEJOsKIagWEuQpVC/Ghawm1slpISfR/BXqNVuwrWqtX76cUst3EMO6wFSUp9VglRqSH46dyENMdBqiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=O4e4t5jz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733446259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FTEPkgWt5theEaJhaIQ0Zcx2coD3HA1BwmW28EjwvoioD9EGleAuoYnsxrWA1uihHluFFgCtYCgUL/zyW4v2IGHIwIrzWRyWSp8Evvy2tWJ5EWtrY5DL4HcAfW6bTH24vQQXdsHriuUqDJp5kg8zoMyMmdbuXy/gQ4mMCG3et9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733446259; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zr4ckYF8n1QIsz+yI8VPDPEhhMlAZtVoa8ioCrUMcMk=; 
	b=Gwdoa10FCiSZNYJOyhATmycxwtYKktjDBGk1xC3k9Iorp++ZoABrab11+//JGTqqOKLtpELS/9UV0v8dmW0ZoNsjABm8Kv2+maeG35NljA1D2a8/tqcyOrT+SBjnypCbxd35EmmXp/bFQ/5V5I6BUxqD10MK4E4CWXBEqTjrAjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733446259;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=zr4ckYF8n1QIsz+yI8VPDPEhhMlAZtVoa8ioCrUMcMk=;
	b=O4e4t5jzERrQGeLoGtgMsqZ+M/cRUZ0OSLgYulzrJo+vsFheq2Pz2aEa1Tblg7ke
	HOQv64c4Vx/7Kyn5jksYVsrOHLdBYycZTjUkwpRenWZmUJhvcIC92geVA3qbZ9ppbYd
	uRLQ12RFfPYe9NyzK6tmjN6rGldw+KcP5Nu1Cpyc=
Received: by mx.zohomail.com with SMTPS id 1733446257589438.50251727226885;
	Thu, 5 Dec 2024 16:50:57 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 6DADB10604B0; Fri, 06 Dec 2024 01:50:53 +0100 (CET)
Date: Fri, 6 Dec 2024 01:50:53 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/4] power: supply: test-power: implement a power
 supply extension
Message-ID: <foytwrb2sihficgrlcmxclnzm6mmpxqyjrfdkzardx3mkivmvg@b3hfby3fw2fm>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
 <20241205-power-supply-extensions-v5-3-f0f996db4347@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6heirp7h7ua6hpv"
Content-Disposition: inline
In-Reply-To: <20241205-power-supply-extensions-v5-3-f0f996db4347@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.425.61
X-ZohoMailClient: External


--a6heirp7h7ua6hpv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/4] power: supply: test-power: implement a power
 supply extension
MIME-Version: 1.0

Hi,

On Thu, Dec 05, 2024 at 09:46:37PM +0100, Thomas Wei=DFschuh wrote:
> Allow easy testing of the new power supply extension functionality.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

This looks good to me apart from the function / variable names. For
example power_supply_ext_get_property() looks like a function from
the power-supply core and not from the test driver :)

I suggest replacing 'power_supply_ext_' prefixes with 'test_power_ext_'
and 'struct power_supply_ext power_supply_ext' with
'struct power_supply_ext test_power_ext'.

Greetings,

-- Sebastian

>  drivers/power/supply/test_power.c | 111 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 111 insertions(+)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 442ceb7795e1d84e34da2801d228d53fb67e08d9..1e15d3d192ef4040839aa9740=
b06f5ab78b6b6d3 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -37,6 +37,7 @@ static int battery_charge_counter	=3D -1000;
>  static int battery_current		=3D -1600;
>  static enum power_supply_charge_behaviour battery_charge_behaviour =3D
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +static bool battery_hook;
> =20
>  static bool module_initialized;
> =20
> @@ -238,6 +239,85 @@ static const struct power_supply_config test_power_c=
onfigs[] =3D {
>  	},
>  };
> =20
> +static int power_supply_ext_manufacture_year =3D 1234;
> +static int power_supply_ext_temp_max =3D 1000;
> +static const enum power_supply_property power_supply_ext_props[] =3D {
> +	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +};
> +
> +static int power_supply_ext_get_property(struct power_supply *psy,
> +					 const struct power_supply_ext *ext,
> +					 void *ext_data,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> +		val->intval =3D power_supply_ext_manufacture_year;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		val->intval =3D power_supply_ext_temp_max;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int power_supply_ext_set_property(struct power_supply *psy,
> +					 const struct power_supply_ext *ext,
> +					 void *ext_data,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> +		power_supply_ext_manufacture_year =3D val->intval;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		power_supply_ext_temp_max =3D val->intval;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int power_supply_ext_property_is_writeable(struct power_supply *p=
sy,
> +						  const struct power_supply_ext *ext,
> +						  void *ext_data,
> +						  enum power_supply_property psp)
> +{
> +	return true;
> +}
> +
> +static const struct power_supply_ext power_supply_ext =3D {
> +	.properties =3D power_supply_ext_props,
> +	.num_properties =3D ARRAY_SIZE(power_supply_ext_props),
> +	.get_property =3D power_supply_ext_get_property,
> +	.set_property =3D power_supply_ext_set_property,
> +	.property_is_writeable =3D power_supply_ext_property_is_writeable,
> +};
> +
> +static void test_battery_configure_battery_hook(bool enable)
> +{
> +	struct power_supply *psy;
> +
> +	psy =3D test_power_supplies[TEST_BATTERY];
> +
> +	if (enable) {
> +		if (power_supply_register_extension(psy, &power_supply_ext, NULL)) {
> +			pr_err("registering battery extension failed\n");
> +			return;
> +		}
> +	} else {
> +		power_supply_unregister_extension(psy, &power_supply_ext);
> +	}
> +
> +	battery_hook =3D enable;
> +}
> +
>  static int __init test_power_init(void)
>  {
>  	int i;
> @@ -258,6 +338,8 @@ static int __init test_power_init(void)
>  		}
>  	}
> =20
> +	test_battery_configure_battery_hook(true);
> +
>  	module_initialized =3D true;
>  	return 0;
>  failed:
> @@ -524,6 +606,26 @@ static int param_set_battery_current(const char *key,
> =20
>  #define param_get_battery_current param_get_int
> =20
> +static int param_set_battery_hook(const char *key,
> +				  const struct kernel_param *kp)
> +{
> +	bool old_battery_hook;
> +	int ret;
> +
> +	old_battery_hook =3D battery_hook;
> +
> +	ret =3D param_set_bool(key, kp);
> +	if (ret)
> +		return ret;
> +
> +	if (old_battery_hook !=3D battery_hook)
> +		test_battery_configure_battery_hook(battery_hook);
> +
> +	return 0;
> +}
> +
> +#define param_get_battery_hook param_get_bool
> +
>  static const struct kernel_param_ops param_ops_ac_online =3D {
>  	.set =3D param_set_ac_online,
>  	.get =3D param_get_ac_online,
> @@ -574,6 +676,11 @@ static const struct kernel_param_ops param_ops_batte=
ry_current =3D {
>  	.get =3D param_get_battery_current,
>  };
> =20
> +static const struct kernel_param_ops param_ops_battery_hook =3D {
> +	.set =3D param_set_battery_hook,
> +	.get =3D param_get_battery_hook,
> +};
> +
>  #define param_check_ac_online(name, p) __param_check(name, p, void);
>  #define param_check_usb_online(name, p) __param_check(name, p, void);
>  #define param_check_battery_status(name, p) __param_check(name, p, void);
> @@ -584,6 +691,7 @@ static const struct kernel_param_ops param_ops_batter=
y_current =3D {
>  #define param_check_battery_voltage(name, p) __param_check(name, p, void=
);
>  #define param_check_battery_charge_counter(name, p) __param_check(name, =
p, void);
>  #define param_check_battery_current(name, p) __param_check(name, p, void=
);
> +#define param_check_battery_hook(name, p) __param_check(name, p, void);
> =20
> =20
>  module_param(ac_online, ac_online, 0644);
> @@ -621,6 +729,9 @@ MODULE_PARM_DESC(battery_charge_counter,
>  module_param(battery_current, battery_current, 0644);
>  MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
> =20
> +module_param(battery_hook, battery_hook, 0644);
> +MODULE_PARM_DESC(battery_hook, "battery hook");
> +
>  MODULE_DESCRIPTION("Power supply driver for testing");
>  MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
>  MODULE_LICENSE("GPL");
>=20
> --=20
> 2.47.1
>=20

--a6heirp7h7ua6hpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdSSmUACgkQ2O7X88g7
+pqg0w//VcvsU3luUpvulZLhzlLOhQ3/lkZyAKA5qFrvOUt89msQnq0fTEELlNbs
iyIB2n6Nm4leI1Uv1+h/sGYzXcKosn2hZMkj92EkDBvROXTpa+4wYwEzG+w14Otu
L0pnkG8KkK5JWMXYBQ4KjC4lceWaw6Ymc3WwFGr7CvcKMZYIdw6/54urCMlon6nj
PpJwvPeqT5QkHOQU1oRmHHgVeVbCmktnBDwwhKD3SX0cPu6jmdtM47yZtKPZvMNL
j9TF+lWPjhx2WR9D9w/qsvo+Hb7NkRKmy1icNpRLyGPasCxwMOYCniNvIUaWaIzW
CMeNIdyD6mfB2xZRmd5yL9cQVAMaeCqQr4WefLllL/r6Izhnl8njGsuM4d75t7Ys
Qkl1PA4eZOzPasFIxcwtBvghOSQstVGDY22vpcbJTaHxJP1bRDZv5INqHX/lNTmT
FWZk2f6+pAQil5O0RMGOpRQxYSE7TnmVoMGCs3/pyy+qWQgkxNmXeafrXlsN41hX
FINVhUa/m3XFe1GTvhXMswlpQR5qXSqiHZKuBJ0g0NmPLXnzitZNhMsWrennjyM8
MrGlhz1Hb1hyruvNTaIgHlIjt9NWOozyflhCOzn8DnIMlTsDaYGautTbEuZaeSkz
jaGQlm8GtHyQ0pYV+Y0J9vRFYWPLxyZ7e0gnXZgjU8THYbDxkDQ=
=6lbs
-----END PGP SIGNATURE-----

--a6heirp7h7ua6hpv--

