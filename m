Return-Path: <linux-acpi+bounces-9982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995CE9E6351
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 02:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42845283FDE
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312F57CAC;
	Fri,  6 Dec 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iMsYCXUb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AF819;
	Fri,  6 Dec 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447764; cv=pass; b=f5YKq63FgH0llD3bIlMXNietCbT3rqi3anDbZL53clyzhgsY62o1NO+X7xNaSR13oJDCAI/J1QugfLsutIFaB1OieQr1MGdfOaZvi/CxQUGCdxNGXRyRIzEA97y31GSjYqyOpvtbCiBW0UOa5d24YK+fgx2kAGesyTNUmsrljUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447764; c=relaxed/simple;
	bh=n7xPHKNpXo4NU1k/zzmACR/ukA/3mA2zWHP1F1rN+GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+hE2Zd04W/Pm59fV0noh3MXFFj1QE5/pNqU2nl3rcMbYibHGjeikPBmeiWCLR41pVTE4q2/AONePfD9Y128fd0IVj3Pw4knp+BX6tPQ0UPsOee85sDLVJa10QzJL2hbzAQ1Vl0QBTOJiwltvorJWHBFErIGQqAAN77FkivOd8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iMsYCXUb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733447748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R9c6U8Iqro0PGsYczs8XT8L0fXwVbB1bSUUSilpXhFhE984EokeHEW0+ulDTvzBLurlLUClAmss72p2c8KtyfPIrMNsHXA1bmstowPE+M//k51jtOrAaZO2notpm9+i0ueyMj4pDdpR8rDzMTYsW4oR7R9J3I3yeAimXqTbHbvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733447748; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kZcuEo4Lc51PbhoYBst+LDhEFSwNyHNPEHfbKuaCC4A=; 
	b=ZucGUpYaHQjj+XBHqyMZn0/4y9Ec0dodJCK5AkFtbVJuptd1BxdwC5RgQYTDVjNiIgWphVWo47ZmdYcp+rMnpKVnUzFXL2YADrOxKidRmAldqLyU1YCLRICZYzVRERCgGuUytAX0t2w78y7KGAGxfx2VcwbqZyvQNMrscaEf1LI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733447748;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kZcuEo4Lc51PbhoYBst+LDhEFSwNyHNPEHfbKuaCC4A=;
	b=iMsYCXUbC2TA6iJQKAilN3t4sLeWRBvRslEdJb1L0fTkpbvIe4JE/EEjtAseI9zz
	UyJECkWXp4FAwZPKXoCWK5ezZjsV9Q7IEjgTGc5ikBecQ0fyzpl0H8vaBT5yrFYdFfi
	BdvB3AxGSMRHraZmvUCqATdUVjoxJhUaQmonXw2s=
Received: by mx.zohomail.com with SMTPS id 1733447745829355.4627291873969;
	Thu, 5 Dec 2024 17:15:45 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 4E41410604B0; Fri, 06 Dec 2024 02:15:41 +0100 (CET)
Date: Fri, 6 Dec 2024 02:15:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 4/4] power: supply: cros_charge-control: implement a
 power supply extension
Message-ID: <ejhprrnx2dxxnoeolpijasl4pitgqkcuhv7a4sfeudcwiqztel@4uvm5cs3fkzp>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
 <20241205-power-supply-extensions-v5-4-f0f996db4347@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2y4ajrhfnjdrne7"
Content-Disposition: inline
In-Reply-To: <20241205-power-supply-extensions-v5-4-f0f996db4347@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.425.61
X-ZohoMailClient: External


--s2y4ajrhfnjdrne7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/4] power: supply: cros_charge-control: implement a
 power supply extension
MIME-Version: 1.0

Hi,

On Thu, Dec 05, 2024 at 09:46:38PM +0100, Thomas Wei=DFschuh wrote:
> Power supply extensions provide an easier mechanism to implement
> additional properties for existing power supplies.
> Use that instead of reimplementing the sysfs attributes manually.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

LGTM.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/cros_charge-control.c | 217 ++++++++++++-----------=
------
>  1 file changed, 88 insertions(+), 129 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/s=
upply/cros_charge-control.c
> index 17c53591ce197d08d97c94d3d4359a282026dd7d..7f914a65f88f8ea57bf01c334=
d25d9b8ebaa2de7 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -18,13 +18,6 @@
>  					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)   | \
>  					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
> =20
> -enum CROS_CHCTL_ATTR {
> -	CROS_CHCTL_ATTR_START_THRESHOLD,
> -	CROS_CHCTL_ATTR_END_THRESHOLD,
> -	CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR,
> -	_CROS_CHCTL_ATTR_COUNT
> -};
> -
>  /*
>   * Semantics of data *returned* from the EC API and Linux sysfs differ
>   * slightly, also the v1 API can not return any data.
> @@ -41,13 +34,7 @@ struct cros_chctl_priv {
>  	struct power_supply *hooked_battery;
>  	u8 cmd_version;
> =20
> -	/* The callbacks need to access this priv structure.
> -	 * As neither the struct device nor power_supply are under the drivers
> -	 * control, embed the attributes within priv to use with container_of().
> -	 */
> -	struct device_attribute device_attrs[_CROS_CHCTL_ATTR_COUNT];
> -	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
> -	struct attribute_group group;
> +	const struct power_supply_ext *psy_ext;
> =20
>  	enum power_supply_charge_behaviour current_behaviour;
>  	u8 current_start_threshold, current_end_threshold;
> @@ -114,124 +101,104 @@ static int cros_chctl_configure_ec(struct cros_ch=
ctl_priv *priv)
>  	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_vers=
ion, &req);
>  }
> =20
> -static struct cros_chctl_priv *cros_chctl_attr_to_priv(struct attribute =
*attr,
> -						       enum CROS_CHCTL_ATTR idx)
> -{
> -	struct device_attribute *dev_attr =3D container_of(attr, struct device_=
attribute, attr);
> -
> -	return container_of(dev_attr, struct cros_chctl_priv, device_attrs[idx]=
);
> -}
> +static const enum power_supply_property cros_chctl_psy_ext_props[] =3D {
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR, /* has to be first for cros_chctl_p=
sy_ext_v1 */
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> =20
> -static ssize_t cros_chctl_store_threshold(struct device *dev, struct cro=
s_chctl_priv *priv,
> -					  int is_end_threshold, const char *buf, size_t count)
> +static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
> +				       const struct power_supply_ext *ext,
> +				       void *data,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
>  {
> -	int ret, val;
> +	struct cros_chctl_priv *priv =3D data;
> =20
> -	ret =3D kstrtoint(buf, 10, &val);
> -	if (ret < 0)
> -		return ret;
> -	if (val < 0 || val > 100)
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		val->intval =3D priv->current_start_threshold;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		val->intval =3D priv->current_end_threshold;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		val->intval =3D priv->current_behaviour;
> +		return 0;
> +	default:
>  		return -EINVAL;
> -
> -	if (is_end_threshold) {
> -		if (val <=3D priv->current_start_threshold)
> -			return -EINVAL;
> -		priv->current_end_threshold =3D val;
> -	} else {
> -		if (val >=3D priv->current_end_threshold)
> -			return -EINVAL;
> -		priv->current_start_threshold =3D val;
>  	}
> -
> -	if (priv->current_behaviour =3D=3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
> -		ret =3D cros_chctl_configure_ec(priv);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return count;
> -}
> -
> -static ssize_t charge_control_start_threshold_show(struct device *dev,
> -						   struct device_attribute *attr,
> -						   char *buf)
> -{
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_START_THRESHOLD);
> -
> -	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_thresh=
old);
> -}
> -
> -static ssize_t charge_control_start_threshold_store(struct device *dev,
> -						    struct device_attribute *attr,
> -						    const char *buf, size_t count)
> -{
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_START_THRESHOLD);
> -
> -	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
> -}
> -
> -static ssize_t charge_control_end_threshold_show(struct device *dev, str=
uct device_attribute *attr,
> -						 char *buf)
> -{
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_END_THRESHOLD);
> -
> -	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshol=
d);
> -}
> -
> -static ssize_t charge_control_end_threshold_store(struct device *dev, st=
ruct device_attribute *attr,
> -						  const char *buf, size_t count)
> -{
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_END_THRESHOLD);
> -
> -	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
>  }
> =20
> -static ssize_t charge_behaviour_show(struct device *dev, struct device_a=
ttribute *attr, char *buf)
> -{
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
> -
> -	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVI=
OURS,
> -						  priv->current_behaviour, buf);
> -}
> =20
> -static ssize_t charge_behaviour_store(struct device *dev, struct device_=
attribute *attr,
> -				      const char *buf, size_t count)
> +static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
> +				       const struct power_supply_ext *ext,
> +				       void *data,
> +				       enum power_supply_property psp,
> +				       const union power_supply_propval *val)
>  {
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> -							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
> +	struct cros_chctl_priv *priv =3D data;
>  	int ret;
> =20
> -	ret =3D power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOUR=
S, buf);
> -	if (ret < 0)
> -		return ret;
> -
> -	priv->current_behaviour =3D ret;
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		if (val->intval < 0 || val->intval > 100)
> +			return -EINVAL;
> =20
> -	ret =3D cros_chctl_configure_ec(priv);
> -	if (ret < 0)
> -		return ret;
> +		if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
> +			if (val->intval <=3D priv->current_start_threshold)
> +				return -EINVAL;
> +			priv->current_end_threshold =3D val->intval;
> +		} else {
> +			if (val->intval >=3D priv->current_end_threshold)
> +				return -EINVAL;
> +			priv->current_start_threshold =3D val->intval;
> +		}
> +
> +		if (priv->current_behaviour =3D=3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)=
 {
> +			ret =3D cros_chctl_configure_ec(priv);
> +			if (ret < 0)
> +				return ret;
> +		}
> =20
> -	return count;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		priv->current_behaviour =3D val->intval;
> +		ret =3D cros_chctl_configure_ec(priv);
> +		if (ret < 0)
> +			return ret;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
>  }
> =20
> -static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct at=
tribute *attr, int n)
> +static int cros_chctl_psy_prop_is_writeable(struct power_supply *psy,
> +					    const struct power_supply_ext *ext,
> +					    void *data,
> +					    enum power_supply_property psp)
>  {
> -	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(attr, n);
> +	return true;
> +}
> =20
> -	if (priv->cmd_version < 2) {
> -		if (n =3D=3D CROS_CHCTL_ATTR_START_THRESHOLD)
> -			return 0;
> -		if (n =3D=3D CROS_CHCTL_ATTR_END_THRESHOLD)
> -			return 0;
> -	}
> +static const struct power_supply_ext cros_chctl_psy_ext =3D {
> +	.properties =3D cros_chctl_psy_ext_props,
> +	.num_properties =3D ARRAY_SIZE(cros_chctl_psy_ext_props),
> +	.charge_behaviours =3D EC_CHARGE_CONTROL_BEHAVIOURS,
> +	.get_property =3D cros_chctl_psy_ext_get_prop,
> +	.set_property =3D cros_chctl_psy_ext_set_prop,
> +	.property_is_writeable =3D cros_chctl_psy_prop_is_writeable,
> +};
> =20
> -	return attr->mode;
> -}
> +static const struct power_supply_ext cros_chctl_psy_ext_v1 =3D {
> +	.properties =3D cros_chctl_psy_ext_props,
> +	.num_properties =3D 1,
> +	.charge_behaviours =3D EC_CHARGE_CONTROL_BEHAVIOURS,
> +	.get_property =3D cros_chctl_psy_ext_get_prop,
> +	.set_property =3D cros_chctl_psy_ext_set_prop,
> +	.property_is_writeable =3D cros_chctl_psy_prop_is_writeable,
> +};
> =20
>  static int cros_chctl_add_battery(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
>  {
> @@ -241,7 +208,7 @@ static int cros_chctl_add_battery(struct power_supply=
 *battery, struct acpi_batt
>  		return 0;
> =20
>  	priv->hooked_battery =3D battery;
> -	return device_add_group(&battery->dev, &priv->group);
> +	return power_supply_register_extension(battery, priv->psy_ext, priv);
>  }
> =20
>  static int cros_chctl_remove_battery(struct power_supply *battery, struc=
t acpi_battery_hook *hook)
> @@ -249,7 +216,7 @@ static int cros_chctl_remove_battery(struct power_sup=
ply *battery, struct acpi_b
>  	struct cros_chctl_priv *priv =3D container_of(hook, struct cros_chctl_p=
riv, battery_hook);
> =20
>  	if (priv->hooked_battery =3D=3D battery) {
> -		device_remove_group(&battery->dev, &priv->group);
> +		power_supply_unregister_extension(battery, priv->psy_ext);
>  		priv->hooked_battery =3D NULL;
>  	}
> =20
> @@ -275,7 +242,6 @@ static int cros_chctl_probe(struct platform_device *p=
dev)
>  	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
>  	struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
>  	struct cros_chctl_priv *priv;
> -	size_t i;
>  	int ret;
> =20
>  	ret =3D cros_chctl_fwk_charge_control_versions(cros_ec);
> @@ -305,18 +271,11 @@ static int cros_chctl_probe(struct platform_device =
*pdev)
>  	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
> =20
>  	priv->cros_ec =3D cros_ec;
> -	priv->device_attrs[CROS_CHCTL_ATTR_START_THRESHOLD] =3D
> -		(struct device_attribute)__ATTR_RW(charge_control_start_threshold);
> -	priv->device_attrs[CROS_CHCTL_ATTR_END_THRESHOLD] =3D
> -		(struct device_attribute)__ATTR_RW(charge_control_end_threshold);
> -	priv->device_attrs[CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR] =3D
> -		(struct device_attribute)__ATTR_RW(charge_behaviour);
> -	for (i =3D 0; i < _CROS_CHCTL_ATTR_COUNT; i++) {
> -		sysfs_attr_init(&priv->device_attrs[i].attr);
> -		priv->attributes[i] =3D &priv->device_attrs[i].attr;
> -	}
> -	priv->group.is_visible =3D cros_chtl_attr_is_visible;
> -	priv->group.attrs =3D priv->attributes;
> +
> +	if (priv->cmd_version =3D=3D 1)
> +		priv->psy_ext =3D &cros_chctl_psy_ext_v1;
> +	else
> +		priv->psy_ext =3D &cros_chctl_psy_ext;
> =20
>  	priv->battery_hook.name =3D dev_name(dev);
>  	priv->battery_hook.add_battery =3D cros_chctl_add_battery;
>=20
> --=20
> 2.47.1
>=20
>=20

--s2y4ajrhfnjdrne7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdSUDYACgkQ2O7X88g7
+pqS6xAAnBvKA8WuzieFvVxz50imDYB+JgRQKUF0pFdAPPCxNUxnmErFOhaqkPPW
an1p8OA3t7FAxiObBoU05AaOx2ndIN/S4KFe2mMpR1DIWp8K/t2skGoKOLl0X24A
y7Sm5Xw1QH00VAhNzaIIJHgh34LNLynirHFF64uSosOj+mw2xVMC8SilxJB14RJc
uf+XHfnx4tvW6003KpGndVa6CCu/gPYdDM7eQKmtKOUCV5GWgQ+5PAOfqdc9sYVX
ub+9J+0wX2JQhAd6kd/M+PVMDthjGZnnQ72GCR6rPbPa9ZGdhd9Xxqw0f4i/1cyy
5m+SHhj1RrbGYkUUamD6AJOYZv+4rDgGiSVVxOYgKpWGdoZE1zmrRo6Da6zVJgv3
H6+ONFN7Q1+pLfmUwAA8xAd3ixFT7rQp+Rx4MV5CWr+KGmTWaDi12U81sLZrsR2N
F8H9t3cJDRYbyzh6yFKdY59BIPkc02bgXeiU+F4pY3BpYGX2LkaRjBmf4OvLRLku
RAiFs7BrOnIkL/OBe1Tv4cvgjGmv7NUdhtdbVAtuXaWJLaP6P0kemsCEq5GOO8gr
kd32krd3+hIoN1eGT5oDhSmLFhMAHvlEITPUj1pF7UGYGSaqOKmZ0NqgdWlZ9eZS
vKBTvNhRwxnPVoPEAeymx8LXjfLIwoh9wwBTzNVu3OK39x2sGGM=
=CZZ4
-----END PGP SIGNATURE-----

--s2y4ajrhfnjdrne7--

