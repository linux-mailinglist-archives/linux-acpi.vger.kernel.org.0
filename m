Return-Path: <linux-acpi+bounces-6534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6539490F8EA
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22B81F2316C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6D15A87D;
	Wed, 19 Jun 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wWVI2Z11"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E387710F;
	Wed, 19 Jun 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835869; cv=none; b=s0zLz/gz77tdlDH8eWdlycFR7mtMYCuZZ4sGVK/TCAsaxdtd6QMpApzg0q0UnMMflc6c+ymV/ffuChFS1/5hxxEjjMJoZxw+QQu32MZPP6ESzE7X6fyuTWx+/S07EIuP1HI4mwSZ5yk+Aeam03h3BS7IPKl5jP+C3TFvX6j6Ym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835869; c=relaxed/simple;
	bh=6qoR7wx5+/141oIi0i7N+IFE9mW5999/8254D8AHod4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtG5lW8ayhcl/tsd6aPwbx4xfXKz5q0G952LtYBi0DTyX9jDau/DtYy0HPPjVoxjb+bETorFGZ1/Zhgn3CwlGTIP+6D9ALYmn6KwGcmVeniSE8fEuT21P7BoRsyKvnNu/lIglPXZnArG/jEbrfXZnzyzEq8ClKNKo/n0oBScdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wWVI2Z11; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718835864;
	bh=6qoR7wx5+/141oIi0i7N+IFE9mW5999/8254D8AHod4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wWVI2Z11+XdhslxEJoEXjOzaT1tW7T+GA/RnumA3ALrL21g5C+panklfeQoPRpl3C
	 KBtwBihmW1xXa4LeQU2Y6c9wH0d70L/M3hFfP1vkUvhDrwEwOaryAnHr0gi3T0JKWA
	 XmrYLU+Ubps/dEjWEYk2iy0ag+nYUEAYjpVsfFr8qL/jaJMJ5usz4Hfk/6vvO+2q0L
	 3adugNV9T8efiHZT7GRk4GmD+PZ8W3Rw3JTuCm87PkPTPB2JHing5ocMbq+5ab6LvT
	 DYFm5gy2v+5BJpjo2HxyVy9AsregG4w5H/G4Y1CuA6NB9Q5rWIw0Wcrn/PYwpqXUOs
	 ttOqiJ/GyV2mQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B47C3782039;
	Wed, 19 Jun 2024 22:24:24 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 020351060B1F; Thu, 20 Jun 2024 00:24:23 +0200 (CEST)
Date: Thu, 20 Jun 2024 00:24:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Dustin Howett <dustin@howett.net>, 
	Stephen Horvath <s.horvath@outlook.com.au>, Rajas Paranjpe <paranjperajas@gmail.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v4 4/5] power: supply: add ChromeOS EC based charge
 control driver
Message-ID: <syoaiwmmxuz4ai6jomu42kvwocwozpzfbnjhvndlfqi6zkio4x@vrg6hle2httr>
References: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
 <20240616-cros_ec-charge-control-v4-4-74d649a9117d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ydx6bqhxcrb2jvj"
Content-Disposition: inline
In-Reply-To: <20240616-cros_ec-charge-control-v4-4-74d649a9117d@weissschuh.net>


--6ydx6bqhxcrb2jvj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 16, 2024 at 09:03:32PM GMT, Thomas Wei=DFschuh wrote:
> The ChromeOS Embedded Controller implements a command to control charge
> thresholds and behaviour.
>=20
> Use it to implement the standard Linux charge_control_start_threshold,
> charge_control_end_threshold and charge_behaviour sysfs UAPIs.
>=20
> The driver is designed to be probed via the cros_ec mfd device.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  MAINTAINERS                                |   6 +
>  drivers/power/supply/Kconfig               |  12 ++
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/cros_charge-control.c | 335 +++++++++++++++++++++++=
++++++
>  4 files changed, 354 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4e6aad46668..8101cd0df305 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5135,6 +5135,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>  F:	sound/soc/codecs/cros_ec_codec.*
> =20
> +CHROMEOS EC CHARGE CONTROL
> +M:	Thomas Wei=DFschuh <thomas@weissschuh.net>
> +S:	Maintained
> +F:	drivers/power/supply/cros_charge-control.c
> +
>  CHROMEOS EC HARDWARE MONITORING
>  M:	Thomas Wei=DFschuh <thomas@weissschuh.net>
>  L:	chrome-platform@lists.linux.dev
> @@ -5148,6 +5153,7 @@ M:	Benson Leung <bleung@chromium.org>
>  R:	Guenter Roeck <groeck@chromium.org>
>  L:	chrome-platform@lists.linux.dev
>  S:	Maintained
> +F:	drivers/power/supply/cros_charge-control.c
>  F:	drivers/power/supply/cros_usbpd-charger.c
>  N:	cros_ec
>  N:	cros-ec
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..f6321a42aa53 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -860,6 +860,18 @@ config CHARGER_CROS_PCHG
>  	  the peripheral charge ports from the EC and converts that into
>  	  power_supply properties.
> =20
> +config CHARGER_CROS_CONTROL
> +	tristate "ChromeOS EC based charge control"
> +	depends on MFD_CROS_EC_DEV
> +	depends on ACPI_BATTERY
> +	default MFD_CROS_EC_DEV
> +	help
> +	  Say Y here to enable ChromeOS EC based battery charge control.
> +	  This driver can manage charge thresholds and behaviour.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called cros_charge-control.
> +
>  config CHARGER_SC2731
>  	tristate "Spreadtrum SC2731 charger driver"
>  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..31ca6653a564 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_CHARGER_CROS_CONTROL)	+=3D cros_charge-control.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_CROS_PCHG)	+=3D cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/s=
upply/cros_charge-control.c
> new file mode 100644
> index 000000000000..e1317a6f23ca
> --- /dev/null
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  ChromeOS EC driver for charge control
> + *
> + *  Copyright (C) 2024 Thomas Wei=DFschuh <linux@weissschuh.net>
> + */
> +#include <acpi/battery.h>
> +#include <linux/container_of.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#define DRV_NAME	"cros-charge-control"
> +
> +#define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_=
AUTO)             | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)   | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
> +
> +enum CROS_CHCTL_ATTR {
> +	CROS_CHCTL_ATTR_START_THRESHOLD,
> +	CROS_CHCTL_ATTR_END_THRESHOLD,
> +	CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR,
> +
> +	_CROS_CHCTL_ATTR_COUNT,
> +};
> +
> +/*
> + * Semantics of data *returned* from the EC API and Linux sysfs differ
> + * slightly, also the v1 API can not return any data.
> + * To match the expected sysfs API, data is never read back from the EC =
but
> + * cached in the driver.
> + *
> + * Changes to the EC bypassing the driver will not be reflected in sysfs.
> + * Any change to "charge_behaviour" will synchronize the EC with the dri=
ver state.
> + */
> +
> +struct cros_chctl_priv {
> +	struct cros_ec_device *cros_ec;
> +	struct acpi_battery_hook battery_hook;
> +	struct power_supply *hooked_battery;
> +	u8 cmd_version;
> +
> +	/* The callbacks need to access this priv structure.
> +	 * As neither the struct device nor power_supply are under the drivers
> +	 * control, embed the attributes within priv to use with container_of().
> +	 */
> +	struct device_attribute device_attrs[_CROS_CHCTL_ATTR_COUNT];
> +	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
> +	struct attribute_group group;
> +
> +	enum power_supply_charge_behaviour current_behaviour;
> +	u8 current_start_threshold, current_end_threshold;
> +};
> +
> +static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cro=
s_ec,
> +					      u8 cmd_version, struct ec_params_charge_control *req)
> +{
> +	static const u8 outsizes[] =3D {
> +		[1] =3D offsetof(struct ec_params_charge_control, cmd),
> +		[2] =3D sizeof(struct ec_params_charge_control),
> +		[3] =3D sizeof(struct ec_params_charge_control),
> +	};
> +
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_charge_control req;
> +			struct ec_response_charge_control resp;
> +		} __packed data;
> +	} __packed buf =3D {
> +		.msg =3D {
> +			.command =3D EC_CMD_CHARGE_CONTROL,
> +			.version =3D cmd_version,
> +			.insize  =3D 0,
> +			.outsize =3D outsizes[cmd_version],
> +		},
> +		.data.req =3D *req,
> +	};
> +
> +	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> +}
> +
> +static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
> +{
> +	struct ec_params_charge_control req =3D { };
> +
> +	req.cmd =3D EC_CHARGE_CONTROL_CMD_SET;
> +
> +	switch (priv->current_behaviour) {
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +		req.mode =3D CHARGE_CONTROL_NORMAL;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		req.mode =3D CHARGE_CONTROL_IDLE;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> +		req.mode =3D CHARGE_CONTROL_DISCHARGE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (priv->current_behaviour =3D=3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO &&
> +	    !(priv->current_start_threshold =3D=3D 0 && priv->current_end_thres=
hold =3D=3D 100)) {
> +		req.sustain_soc.lower =3D priv->current_start_threshold;
> +		req.sustain_soc.upper =3D priv->current_end_threshold;
> +	} else {
> +		/* Disable charging limits */
> +		req.sustain_soc.lower =3D -1;
> +		req.sustain_soc.upper =3D -1;
> +	}
> +
> +	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_vers=
ion, &req);
> +}
> +
> +static struct cros_chctl_priv *cros_chctl_attr_to_priv(struct attribute =
*attr,
> +						       enum CROS_CHCTL_ATTR idx)
> +{
> +	struct device_attribute *dev_attr =3D container_of(attr, struct device_=
attribute, attr);
> +
> +	return container_of(dev_attr, struct cros_chctl_priv, device_attrs[idx]=
);
> +}
> +
> +static ssize_t cros_chctl_store_threshold(struct device *dev, struct cro=
s_chctl_priv *priv,
> +					  int is_end_threshold, const char *buf, size_t count)
> +{
> +	int ret, val;
> +
> +	ret =3D kstrtoint(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +	if (val < 0 || val > 100)
> +		return -EINVAL;
> +
> +	if (is_end_threshold) {
> +		if (val <=3D priv->current_start_threshold)
> +			return -EINVAL;
> +		priv->current_end_threshold =3D val;
> +	} else {
> +		if (val >=3D priv->current_end_threshold)
> +			return -EINVAL;
> +		priv->current_start_threshold =3D val;
> +	}
> +
> +	if (priv->current_behaviour =3D=3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
> +		ret =3D cros_chctl_configure_ec(priv);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_start_threshold_show(struct device *dev,
> +						   struct device_attribute *attr,
> +						   char *buf)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_START_THRESHOLD);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_thresh=
old);
> +}
> +
> +static ssize_t charge_control_start_threshold_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_START_THRESHOLD);
> +
> +	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev, str=
uct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_END_THRESHOLD);
> +
> +	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshol=
d);
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev, st=
ruct device_attribute *attr,
> +						  const char *buf, size_t count)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_END_THRESHOLD);
> +
> +	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
> +}
> +
> +static ssize_t charge_behaviour_show(struct device *dev, struct device_a=
ttribute *attr, char *buf)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
> +
> +	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVI=
OURS,
> +						  priv->current_behaviour, buf);
> +}
> +
> +static ssize_t charge_behaviour_store(struct device *dev, struct device_=
attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(&attr->attr,
> +							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
> +	enum power_supply_charge_behaviour behaviour;
> +	int ret;
> +
> +	behaviour =3D power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEH=
AVIOURS, buf);
> +	if (behaviour < 0)
> +		return behaviour;
> +
> +	priv->current_behaviour =3D behaviour;
> +
> +	ret =3D cros_chctl_configure_ec(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct at=
tribute *attr, int n)
> +{
> +	struct cros_chctl_priv *priv =3D cros_chctl_attr_to_priv(attr, n);
> +
> +	if (priv->cmd_version < 2) {
> +		if (n =3D=3D CROS_CHCTL_ATTR_START_THRESHOLD)
> +			return 0;
> +		if (n =3D=3D CROS_CHCTL_ATTR_END_THRESHOLD)
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static int cros_chctl_add_battery(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
> +{
> +	struct cros_chctl_priv *priv =3D container_of(hook, struct cros_chctl_p=
riv, battery_hook);
> +
> +	if (priv->hooked_battery)
> +		return 0;
> +
> +	priv->hooked_battery =3D battery;
> +	return device_add_group(&battery->dev, &priv->group);
> +}
> +
> +static int cros_chctl_remove_battery(struct power_supply *battery, struc=
t acpi_battery_hook *hook)
> +{
> +	struct cros_chctl_priv *priv =3D container_of(hook, struct cros_chctl_p=
riv, battery_hook);
> +
> +	if (priv->hooked_battery =3D=3D battery) {
> +		device_remove_group(&battery->dev, &priv->group);
> +		priv->hooked_battery =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_chctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
> +	struct cros_chctl_priv *priv;
> +	size_t i;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret =3D cros_ec_get_cmd_versions(cros_ec, EC_CMD_CHARGE_CONTROL);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret & EC_VER_MASK(3))
> +		priv->cmd_version =3D 3;
> +	else if (ret & EC_VER_MASK(2))
> +		priv->cmd_version =3D 2;
> +	else if (ret & EC_VER_MASK(1))
> +		priv->cmd_version =3D 1;
> +	else
> +		return -ENODEV;
> +
> +	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
> +
> +	priv->cros_ec =3D cros_ec;
> +	priv->device_attrs[CROS_CHCTL_ATTR_START_THRESHOLD] =3D
> +		(struct device_attribute)__ATTR_RW(charge_control_start_threshold);
> +	priv->device_attrs[CROS_CHCTL_ATTR_END_THRESHOLD] =3D
> +		(struct device_attribute)__ATTR_RW(charge_control_end_threshold);
> +	priv->device_attrs[CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR] =3D
> +		(struct device_attribute)__ATTR_RW(charge_behaviour);
> +	for (i =3D 0; i < _CROS_CHCTL_ATTR_COUNT; i++) {
> +		sysfs_attr_init(&priv->device_attrs[i].attr);
> +		priv->attributes[i] =3D &priv->device_attrs[i].attr;
> +	}
> +	priv->attributes[_CROS_CHCTL_ATTR_COUNT] =3D NULL;
> +	priv->group.is_visible =3D cros_chtl_attr_is_visible;
> +	priv->group.attrs =3D priv->attributes;
> +
> +	priv->battery_hook.name =3D dev_name(dev),
> +	priv->battery_hook.add_battery =3D cros_chctl_add_battery,
> +	priv->battery_hook.remove_battery =3D cros_chctl_remove_battery,
> +
> +	priv->current_behaviour =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +	priv->current_start_threshold =3D 0;
> +	priv->current_end_threshold =3D 100;
> +
> +	/* Bring EC into well-known state */
> +	ret =3D cros_chctl_configure_ec(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_battery_hook_register(dev, &priv->battery_hook);
> +}
> +
> +static const struct platform_device_id cros_chctl_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +static struct platform_driver cros_chctl_driver =3D {
> +	.driver.name	=3D DRV_NAME,
> +	.probe		=3D cros_chctl_probe,
> +	.id_table	=3D cros_chctl_id,
> +};
> +module_platform_driver(cros_chctl_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_chctl_id);
> +MODULE_DESCRIPTION("ChromeOS EC charge control");
> +MODULE_AUTHOR("Thomas Wei=DFschuh <linux@weissschuh.net>");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.45.2
>=20

--6ydx6bqhxcrb2jvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZzWpEACgkQ2O7X88g7
+ppYPxAApxa6KLaMdhjBFKdB/YmB/MwsP22bhc7NfMFR97BXkvtG9cf6xacsYXwQ
QqNa8lc07dJtfG344ZmZWR75xmFclc96bjmadfeE59fC7moElY6pQ+eaZYxw9uNH
Nk7CrawUIOV3FTebfbY7GkufQ0gdM1d4fV7Ttcqufe1LxqB902inET3a46WedC+1
9gMyZEV9gqw6uZ5PnWsN0JBnHNSlweT1/2wWSSaA/YMafcliDOVYwSG77owg5QCK
wwz8qjD31zHvElt8yY5ZZYWarBLnwFa/jfdz6wIEEStio5y+GQd5PdAAef+fvyQb
x4voDrZkuVb1ir/5V8ywgo6EC0ZLcgSt6wxQIqwgkQ0WP0k93EgADahGbFM7v5+s
v/KAAm5gknSPlaVrnxEPvelnOdxym4VZPI1MTv57cAyEkN23+Ad7+0Ym4LAFBy07
JrbncpnejTh/zWTw5SgGZEpzL0go20tqO6VARGKXJA2cb5R6c9B5YPxHLkvwL5qr
Hjao8qdxXYkJzGfi5gP8LwhrT1QziWiyIUCLgdHZYvJ2RKEWj4NYzrHGzUPkNWC9
yF/Qc+NlLePCh8OUKvhbvGM9Zid1lfYUwEWA/aaUht1fPaE14QxSaueQBOZX4gZ/
Bv3xgeC0uHqZIaU/OY+hTEh/LbcepubIgrfDlm6QZ1GP2C9X498=
=Da5t
-----END PGP SIGNATURE-----

--6ydx6bqhxcrb2jvj--

