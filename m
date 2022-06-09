Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5B54577D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiFIWfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 18:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbiFIWfQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 18:35:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D052232DBE;
        Thu,  9 Jun 2022 15:35:14 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D06496601752;
        Thu,  9 Jun 2022 23:35:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654814112;
        bh=+qnj272CW1aNAw+M+Z/uxXPUnZIVeOy+1u+55rk64D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkBzKocG4muefR/X7QGwlbdB48vI9qWOqEaTu+tDZsQfY2mKFVW1Zt3sT8y16RT9S
         L2SPvRJcCrRoVKDxHe/LcajsH7ej3OfO6Cko9aqUpCW37+4jde6MSvo/5n4gcKkE3l
         eyNzDRtWgZveIIykcFBU6Y7rY55KkRZOeCoOp2eBvllUUXZb7fwxJzRolOT8vdWvh9
         Mm+vHJqnHS8/ZG1bb/yQC61tE1Ua16CsINoYxWowYEvWy3fiHlsIMB9mEyu8dOCU+M
         tWtvJ3zi64j9mhYRZCctsN4MPdswYI7GINZi6DHBlLi5K3BVMaagoC20YpPhzqHiGE
         eWB9n9q6J61Uw==
Received: by mercury (Postfix, from userid 1000)
        id 7E82C10605B9; Fri, 10 Jun 2022 00:35:10 +0200 (CEST)
Date:   Fri, 10 Jun 2022 00:35:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v1 1/1] Support power control driver for BlueField SoCs.
Message-ID: <20220609223510.64f5ucmuglnh4ebz@mercury.elektranox.org>
References: <20220418174450.4304-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5pknlgrafxnq4qw"
Content-Disposition: inline
In-Reply-To: <20220418174450.4304-1-asmaa@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--w5pknlgrafxnq4qw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please find review feedback inline,

On Mon, Apr 18, 2022 at 01:44:50PM -0400, Asmaa Mnebhi wrote:
> This patch supports handling 2 BlueField power states controlled by GPIO =
interrupts:
> 1) chip reset and
> 2) low power mode
>=20
> This driver is dependent and should be loaded after the gpio-mlxbf2.c dri=
ver,
> which is the gpio and interrupt controller.
>=20
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/power/reset/Kconfig     |   6 ++
>  drivers/power/reset/Makefile    |   1 +
>  drivers/power/reset/pwr-mlxbf.c | 100 ++++++++++++++++++++++++++++++++
>  3 files changed, 107 insertions(+)
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
> index 000000000000..30b3ba13be75
> --- /dev/null
> +++ b/drivers/power/reset/pwr-mlxbf.c
> @@ -0,0 +1,100 @@
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
> +static int
> +pwr_mlxbf_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct acpi_device *adev;
> +	struct pwr_mlxbf *priv;
> +	const char *hid;
> +	int irq, err;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(struct pwr_mlxbf), GFP_KERNEL);

priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);

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
> +	irq =3D acpi_dev_gpio_irq_get(ACPI_COMPANION(&pdev->dev), 0);
> +	if (irq =3D=3D -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (irq < 0) {
> +		dev_err(&pdev->dev, "Error getting %s irq.\n", priv->hid);
> +		return -ENXIO;
> +	}

if (irq < 0)
    return dev_err_probe(&pdev->dev, irq, "Error getting %s irq.\n", priv->=
hid);

> +	INIT_WORK(&priv->send_work, pwr_mlxbf_send_work);

err =3D devm_work_autocancel(dev, &priv->send_work, pwr_mlxbf_send_work);
if (err)
    return err;

Otherwise LGTM,

-- Sebastian

> +	err =3D devm_request_irq(&pdev->dev, irq, pwr_mlxbf_irq, 0, hid, priv);
> +	if (err)
> +		dev_err(&pdev->dev, "Failed request of %s irq\n", priv->hid);
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

--w5pknlgrafxnq4qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKidZcACgkQ2O7X88g7
+pp+Ag/+Nuhd7gVyVs74n35Id5aUGx9WXYzPif2YzfQX2vtnksU7ZV0vKU1z4H05
Ov5qv25Spvwot+EUsgrc8Q+qi8J4wikGCmKmm7aYKzzLa+OHWyK8JmJp8xlmkePz
T9CInFoJWwrLadUIWDtUyrI5wR7UXj8EQfuH1i+wJBdYH7TxzYOPycaRg7tlsHu2
uvdRraMDEg6f7+5YkTV9dULb4ci/lDYXJ23DnmhrpwbtgupEVJarXswNKbNAeDjU
k4S8ZMI3hpgiI1E11GRU53v7Gh4xZrUdMzJFMqICWzJufp5iywcy6X6qzgdWAn9h
TpwvMQbAyVgZHfhrDvSqG2lCPG4GorMiQnOkYmeLEHP7mAYQweU31SdKUW86iSb2
8ZuVJ5wvzw57EcT4VRtf5r2bXkBD5aoA7ouEnOeQLrIftDxL4vl8ShU6+e0sCI2a
iqWjUywV5/doZJQEk9zR0sGAxJXez65MmAuxP7cpgJsGIg0EEgHtbn8ywg4EfBj+
K1OJUJRdzSAQJizM1rKkL6rUnPFyX2GuM8hwyaqfQ//tAwDzDOg9cV47Tau0iAQ3
VJ2xV8OU8/q1tRZPoVKtLVZXV6GZ+KzTxLgS0YlC56mVKmTLUE2UfKfZRhO1GDCY
wPLr05aoHyQlh4QChIeJI7nXxgUZO6Apy0+qyjbeR7DYVZJf2gQ=
=Msk1
-----END PGP SIGNATURE-----

--w5pknlgrafxnq4qw--
