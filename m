Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDD54FA55
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jun 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382629AbiFQPeh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jun 2022 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiFQPeg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jun 2022 11:34:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54A250;
        Fri, 17 Jun 2022 08:34:34 -0700 (PDT)
Received: from mercury (unknown [37.80.217.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 488F0660179B;
        Fri, 17 Jun 2022 16:34:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655480073;
        bh=yevQpyEUzohMcD6mHqop32H2OXnpO9pMQJJqnK/GP9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2rzY24u6QcciRxPIifY0juEf6D9dUgwRjzXIBl6y4hLgdzC3PMcMEG4ZvsUMAJAT
         4kOBgOl/Dj3vtqD78loy1GXqNyqPH12GH0KAM8NpullgLDnvKmtFSKI8pEMyMqqcMh
         iySvUgkCyfkHaJHY4rAMc8PA9iHxTD3E14jnq3XGzucURDV2HQWXcSpaRmxMgTMqcX
         1jPTktEy6cFulI4S79k9Xypaq59XO5dTaxKp3QbrQUMJ4Zojbo3xGSKmCu+rN0woN5
         5ddsd9Jifx8jmfc5O2HEIbZEJYAwKBkheFZ9X/kmfs+Z1DPyUr2fNp2qkVzgU/FzeV
         EzKCEv6mr+YGw==
Received: by mercury (Postfix, from userid 1000)
        id 78EA2106031F; Fri, 17 Jun 2022 17:34:30 +0200 (CEST)
Date:   Fri, 17 Jun 2022 17:34:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Support power control driver for BlueField SoCs.
Message-ID: <20220617153430.xqxkrj3bgw4crbwj@mercury.elektranox.org>
References: <20220614141911.6169-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76hfxrctsi2pepps"
Content-Disposition: inline
In-Reply-To: <20220614141911.6169-1-asmaa@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--76hfxrctsi2pepps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 14, 2022 at 10:19:11AM -0400, Asmaa Mnebhi wrote:
> This patch supports handling 2 BlueField power states controlled by GPIO =
interrupts:
> 1) chip reset and
> 2) low power mode
>=20
> This driver is dependent and should be loaded after the gpio-mlxbf2.c dri=
ver,
> which is the gpio and interrupt controller.
>=20
> Changes made since v1 patch:
> - use dev_err_probe
> - use devm_work_autocancel
> - fix sizeof() in devm_kzalloc
>=20
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---

Thanks, I queued this into power-supply's for-next branch. I
modified the commit message a bit. Please follow the common
style (e.g. Changes are documented below ---, patch subject
should be prefixed with the subsystem).

-- Sebastian

>  drivers/power/reset/Kconfig     |  6 ++
>  drivers/power/reset/Makefile    |  1 +
>  drivers/power/reset/pwr-mlxbf.c | 97 +++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 drivers/power/reset/pwr-mlxbf.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 4b563db3ab3e..a8c46ba5878f 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -297,4 +297,10 @@ config NVMEM_REBOOT_MODE
>  	  then the bootloader can read it and take different
>  	  action according to the mode.
> =20
> +config POWER_MLXBF
> +	tristate "Mellanox BlueField power handling driver"
> +	depends on (GPIO_MLXBF2 && ACPI)
> +	help
> +	  This driver supports reset or low power mode handling for Mellanox Bl=
ueField.
> +
>  endif
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index f606a2f60539..0a39424fc558 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
> +obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-ml=
xbf.c
> new file mode 100644
> index 000000000000..c1f9987834a2
> --- /dev/null
> +++ b/drivers/power/reset/pwr-mlxbf.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +
> +/*
> + *  Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/reboot.h>
> +#include <linux/types.h>
> +
> +const char *rst_pwr_hid =3D "MLNXBF24";
> +const char *low_pwr_hid =3D "MLNXBF29";
> +
> +struct pwr_mlxbf {
> +	struct work_struct send_work;
> +	const char *hid;
> +};
> +
> +static void pwr_mlxbf_send_work(struct work_struct *work)
> +{
> +	acpi_bus_generate_netlink_event("button/power.*", "Power Button", 0x80,=
 1);
> +}
> +
> +static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
> +{
> +	struct pwr_mlxbf *priv =3D ptr;
> +
> +	if (!strncmp(priv->hid, rst_pwr_hid, 8))
> +		emergency_restart();
> +
> +	if (!strncmp(priv->hid, low_pwr_hid, 8))
> +		schedule_work(&priv->send_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pwr_mlxbf_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct acpi_device *adev;
> +	struct pwr_mlxbf *priv;
> +	const char *hid;
> +	int irq, err;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	adev =3D ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENXIO;
> +
> +	hid =3D acpi_device_hid(adev);
> +	priv->hid =3D hid;
> +
> +	irq =3D acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv->hid);
> +
> +	err =3D devm_work_autocancel(dev, &priv->send_work, pwr_mlxbf_send_work=
);
> +	if (err)
> +		return err;
> +
> +	err =3D devm_request_irq(dev, irq, pwr_mlxbf_irq, 0, hid, priv);
> +	if (err)
> +		dev_err(dev, "Failed request of %s irq\n", priv->hid);
> +
> +	return err;
> +}
> +
> +static const struct acpi_device_id __maybe_unused pwr_mlxbf_acpi_match[]=
 =3D {
> +	{ "MLNXBF24", 0 },
> +	{ "MLNXBF29", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, pwr_mlxbf_acpi_match);
> +
> +static struct platform_driver pwr_mlxbf_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwr_mlxbf",
> +		.acpi_match_table =3D pwr_mlxbf_acpi_match,
> +	},
> +	.probe    =3D pwr_mlxbf_probe,
> +};
> +
> +module_platform_driver(pwr_mlxbf_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField power driver");
> +MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> --=20
> 2.30.1
>=20

--76hfxrctsi2pepps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKsnwYACgkQ2O7X88g7
+pqjSw//Xe0XI2D12gDtvhYOENv5/GMD41w7QELufONYtPCDdJDECahDsDfuMY5F
4OQI8blECjf6S9uha2Rkxj32KQtihV56npYGNACoJ5WJHBtiy8KJVP5NdyiXNbJQ
csMyKcff76HvzZZRvO12YvIXmc7X72OidjOORlUiWhzu/qoW6NvvckmKZulSXgd4
Kh6Fn4K59sf62BaI7tVWmnyDyTPY7Qk9ZE0W0J+V4iIxA4bYPIKjVMu3m8jv0XGK
pGnZSMFqUQGb0ejJF/flQ6dOV056fQ/MjQTCoqHXqi+PUWz8lV4g8288N4lGkjwG
2ugd1GN4JoUw5bsAAUKQNLM95OoiZCdVSLJYDLXus0e8EUfpGIXMFj6ZHtEyPkNw
WXsvFZi9FFR3cKo7WwaA78zjTqryQNEfd2uphbsubRB5FMwXfqtdPYp7bZLML0cP
2enwU2rjv3PwXWgwcqb067uTA+h0nx32MWrsp+Zcqp4nawXDioLL7fAZltWPfx7k
qQZ0BdvYMIcHtq0vzFPHQLnagyjE8veJcogUHrDElwb0iORVOmKM7ZL7SEBgnEZB
948TXmC/EtVpvbWy7MpFxQycms1oC1zyBDH81NHtjGf2kbUFntRfpAds85olIMm4
CGwEILgO1VdECiBmrYkBK/yCN/QnLCJBGrHkUKrD7UoTiGBM6Io=
=V3Zw
-----END PGP SIGNATURE-----

--76hfxrctsi2pepps--
