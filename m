Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8954FAA0
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jun 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383163AbiFQPnj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jun 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383160AbiFQPni (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jun 2022 11:43:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8460101F8;
        Fri, 17 Jun 2022 08:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxPayn7NlB4sivPhebvtgW1jZo0+4HHvh+vMzSUwDwAa1O90e4fF+emwDu+RmgLYO58A2ajdT3h+/dFQuNV7fnY710eftjMI2IywdlvyiJfmuJeCRVX/kNKuRjvf8eeasa67rhfALi/ynHMuE+Mi/3RG3FzCPnQxRra5N/oTCafksop47UmoIpTgR0GmDpNy8d5vhybW8st9Bpn7YbUT7lRIUlZ2V+upzM0dje5keFsOBc6ZCyswEm5Tc9RQMI8jihvBjZb4lp7O+V1rgpYsc3u989hNi9i6PXGptnna6B8TAz5tSqrDn7RasQoYMfZHcsm3fR9m/y8XMOH+MBdw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7c3k4xkogcFH/zyc6zdk96hBUexfeIyplI49EnbkqQ=;
 b=n8YBY25PiyamASHh1pJVtdUnRrFSnwXje5voAmjjQInAl5paGAVnuvh/ZAx8K2VcTUKy+Rzf/5DC+G4FSIMMTHKTJVzE0HA2Kq/61N7wqa6lbNXsPphKDo6QIRIPcm2BiDdTukpsDzLY//9Swio5UpOMmE8ICt2NJOVfkuoiVd9Rww965g4PP5QoNZoPPm61xPsn+3LhzT6sZa78sOr1XSHpPVbZPNfUD19DT6Remi6ML9oGOlMEu1VWYAOYRe5OLJkrl00l5UGbiMyb5kfLiY0rcorDiscIk52QX+YuOvl2gDPTXTvlYsDDa9KYq3y9rmCuInAz7kcIqWBOzryiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7c3k4xkogcFH/zyc6zdk96hBUexfeIyplI49EnbkqQ=;
 b=qlYXZL+j6EbAm+Q5u+QQl/BH/zO1Dm+hz6Hwgx54lnFrTvHpd9TEbB/wuCuzkdJfT7Kr0uduQ/vkn97cuXN3KAmpDM4PJ7Mhdib+E0G70QRcYepcgtHYxIp2sudosArcooPOJD3AjlaX90dnDBCD4uhITitck9E055/oBhqcr6ZETi6e4Ch7UneNLctKZD/2I/8qKgeMpXavemSgMKvCD8dcWi39t+KeFjym21pJV8my7HjpgB1PZ8xgAGecQNz4KU5jLrbaGFHrsF+G74BiyVRXX9lNmTYUahh5csgKxjyUH6hIS81FybbUA+DXwxZwz5hWxv1o99+YpyLxZdSy2g==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 15:43:34 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b%5]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 15:43:34 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Support power control driver for BlueField SoCs.
Thread-Topic: [PATCH v2 1/1] Support power control driver for BlueField SoCs.
Thread-Index: AQHYf/m+rOTcQpJLSkGBLcah41SCwK1Tv4UAgAACcFA=
Date:   Fri, 17 Jun 2022 15:43:34 +0000
Message-ID: <CH2PR12MB38953C2F324B67C67925AA84D7AF9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220614141911.6169-1-asmaa@nvidia.com>
 <20220617153430.xqxkrj3bgw4crbwj@mercury.elektranox.org>
In-Reply-To: <20220617153430.xqxkrj3bgw4crbwj@mercury.elektranox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd165e51-c431-471c-4a7c-08da5078235c
x-ms-traffictypediagnostic: BL1PR12MB5826:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5826D94510434BFD93682F8DD7AF9@BL1PR12MB5826.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1paKCyjr1SBY2JWdjxfiB3/IZ2fbxXVGkEYxV7Ed6zrOEaRK8bqH3lA8TZL532AHLl7FIpR9NXkNkE19ybL0M6I+nlYbJ7vI3hPgxWm2FaRIT1J0cb4MMTs6B5N1xdGKZl6g4WZsQ5UEmYRKspVQSTWe+8L6GchXsUQ9cAKKXI/zz8aMXUdG3Dd7+K6TR0Zo+3HUlERGfSVDRT5nlwUwgy138Ii86k+4damMFP9mH3cvv/1ulDSjeGiG81LmPRvEjKT/tBIRFHl0qi4oqsnSuL/CJQXmT5Akeb0AD+VOMnPUMNKdyC44FOg3UTqeq+iO84H6VPqfRVMRvD9t/PQrojHF+kZJDFYJ2rSa73SdtYPDw30Dwqykp6azwg/Z6wqW3D5zSCN4jvbIWieoJEgB3SU3+yX624WIuWaWXUu/+UEw4i5ZtOJ1B7d8+YBzB9w8/YQCNxZKhlwYRqSDywUeSaUpbd3TdHv7tuLfsEug+xUg5j04lkPXBXBwhoul/hn/wO57unOfXaclkLCeN2pUk3fEYIfNbTb9qDdwZTfU5ZHjXDrGNB6zK8/FFtkEMN8JFyv09EDSxZ0m/ESAmiD5eVC+xhUlIw/V0u1qM3XHO6spEoaOKvdXhnpZ38pasxdQg7ekQFP8ByYOGTy+oGZ3FW5r29w7S8CjiYjbTNgHQhqx90xZSO7xULeHUpOnXJbwMwSxf5ZcFheAG6Mmi/aFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(4636009)(366004)(71200400001)(5660300002)(498600001)(55016003)(33656002)(316002)(122000001)(83380400001)(8936002)(52536014)(53546011)(6916009)(26005)(7696005)(6506007)(86362001)(2906002)(76116006)(38070700005)(38100700002)(64756008)(9686003)(66946007)(66446008)(186003)(8676002)(4326008)(66556008)(66476007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETOKFxaGKTsfhuSHw/3kRLl9/2XBd9HxVdJ/0mndiXTGy0wnYsABOm5UZOej?=
 =?us-ascii?Q?8HpRIc5d0h7hubfkwNq/gY+sbKGdgcf3cUTxHHx136z3XgCVMWDEN5Ba0c51?=
 =?us-ascii?Q?3eEFp5+TH4glZF57yFs19JDupFg4CPqOT0kOy9xwWwwsvLfI+vwMP4vHXjy9?=
 =?us-ascii?Q?HkMZ8xVjSH4D6IhuL9ZXn0i+C9SXOgH/tCwFY7+Rt0CkRTfo3aHce9NGntVk?=
 =?us-ascii?Q?vRfw05Faisu4Z1LkoWwa3V15ZniabYVGe2pLBQgJuIpDjGteeXe7UGwT8NM0?=
 =?us-ascii?Q?Cp32rhtaeM/snQ0cqaJy0WC8CK+kwOOjOjijC2yDaHNm+HdhNaV7/EY/MuZ2?=
 =?us-ascii?Q?z3JEiRR0xrgUw3yZBCSiXs9oEc2zEaXPLOZPRSwM53voq0nLH/jH9UzMLGKZ?=
 =?us-ascii?Q?gXV+30dJ5gmgji/iiMfRd/QnMPZkCJ7Xfi7j6xpBbk3kX88b2LCjDqU04MGo?=
 =?us-ascii?Q?75PK6cT3/a9DsgdVm3GqSh4q3qFiiEdOwBKqZw+Y+KAX7a6fcXGZpz1tnr88?=
 =?us-ascii?Q?4FkZ25uKC1WkwQVz0IL9dRooShn7ji8mX/vc+hs1xIycTe1ngYcQjicWSUl7?=
 =?us-ascii?Q?wUbvDTqwZTSXCEQ7g67gKJkJ4HYY+AV3IYnnvDcekTY4ukAUyb0fbKAhd8a7?=
 =?us-ascii?Q?h/DHhVtYuzCy/B18bnEvnhYXswJ6Rh0ReeDMwoZ/nl6DanuZjp+9aqarYaLb?=
 =?us-ascii?Q?r6nNc4oz/Zo4FneXPf9qRgFA2HWh5ZWWzO7f5KhPm5A0NFZn30UO1u4363iY?=
 =?us-ascii?Q?gnTlnRx4shTl5GBXrPYiQMWFz5AYFhDz2cF/aHfzzgxvW1pgSkvXGpWjnNc3?=
 =?us-ascii?Q?1awyZ5VoUUc2C9B+/uC43nDAfDt+xOirOCYVapDQxvFYycHMfRq3nMpdBnDD?=
 =?us-ascii?Q?G2tVfhdoZJ+f1AX42eO4oh2xyY8pPsIREHt1OoVKzIb3NCYYExTcswF+Lx9Q?=
 =?us-ascii?Q?b2s/808+rJA9DkBAyf+PYshYKIFEETbjjScFS9aGNCLeoDpjD2j+FfPYXwT3?=
 =?us-ascii?Q?gcd88dO5BRl9LLVkBsPqUySg82MEaJaDuHUQ08I45QvYAbuocyZY+HNwq09E?=
 =?us-ascii?Q?fJm/8+9eo1zF1tb//BCvOUVVdnR69SlRHT8MjEbDGCc3V3wmbuhgEy8Cf7E5?=
 =?us-ascii?Q?SQRS70/8JQxhMSZvFiwtKy93X4l96HyQtpoHPKa58bMlP2Th6mc3QfwpARpy?=
 =?us-ascii?Q?o7Rbjqr31UqmWOBnzLlXZvam7Ftr3QIG2Pw231CgzV0wyi24h4BdcRm2t9qN?=
 =?us-ascii?Q?rIFJdE0R32iaaQlnT1esTROoedr3rTvVsOFfN2n+v5K18IeQVKvf2+3QdwdM?=
 =?us-ascii?Q?vZsRS8N7lDgh+AEYvR6ghkv4BOWKAoM1C5BJpTBtDm6q9aJQMKWOgW9XJOE+?=
 =?us-ascii?Q?SCEtVL+p43Aw/ovynwjGqwhL+VDhji2pwy5l6xa6ApaBTSRR3WCzawPLPM/C?=
 =?us-ascii?Q?oqCtUnS6d+K3DqgCMb7sz9v6MtmgsrSmVPCz8uHBL2e2Ho9wp+PRxecse08+?=
 =?us-ascii?Q?BtsByWffyMT4H1ZUEBkFsHbpizQDLqRRhTJ5BQt6VwjwPeZUkmXtpD0XhU4z?=
 =?us-ascii?Q?MOWo9d5bxaugDHyMi38pV5hkJr6WAOTHEG1unIdkTZeVFWnlv5kLNQLtFGsj?=
 =?us-ascii?Q?+zAHIuSr1yB1Z5STEnSp0t2dNKBKXcwR+APafqFB6lnaLTKLfCUl2CPnbg7+?=
 =?us-ascii?Q?Ni6a904PUTlSCNOXErTMUjpsJqLMEOGttqpQr0fuetTiQiel?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd165e51-c431-471c-4a7c-08da5078235c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 15:43:34.5582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05BSLv8b1wPnNy/kl+hrernx+gsOpGVjN3GYZzDaS6MF1eiucw9h5Vx343WDTUl63F5oCNnephWM9J8Qhci+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thank you Sebastian!

-----Original Message-----
From: Sebastian Reichel <sebastian.reichel@collabora.com>=20
Sent: Friday, June 17, 2022 11:35 AM
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Support power control driver for BlueField SoCs=
.

Hi,

On Tue, Jun 14, 2022 at 10:19:11AM -0400, Asmaa Mnebhi wrote:
> This patch supports handling 2 BlueField power states controlled by GPIO =
interrupts:
> 1) chip reset and
> 2) low power mode
>=20
> This driver is dependent and should be loaded after the gpio-mlxbf2.c=20
> driver, which is the gpio and interrupt controller.
>=20
> Changes made since v1 patch:
> - use dev_err_probe
> - use devm_work_autocancel
> - fix sizeof() in devm_kzalloc
>=20
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---

Thanks, I queued this into power-supply's for-next branch. I modified the c=
ommit message a bit. Please follow the common style (e.g. Changes are docum=
ented below ---, patch subject should be prefixed with the subsystem).

-- Sebastian

>  drivers/power/reset/Kconfig     |  6 ++
>  drivers/power/reset/Makefile    |  1 +
>  drivers/power/reset/pwr-mlxbf.c | 97=20
> +++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 drivers/power/reset/pwr-mlxbf.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig=20
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
> diff --git a/drivers/power/reset/Makefile=20
> b/drivers/power/reset/Makefile index f606a2f60539..0a39424fc558 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
> +obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> diff --git a/drivers/power/reset/pwr-mlxbf.c=20
> b/drivers/power/reset/pwr-mlxbf.c new file mode 100644 index=20
> 000000000000..c1f9987834a2
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
> +const char *rst_pwr_hid =3D "MLNXBF24"; const char *low_pwr_hid =3D=20
> +"MLNXBF29";
> +
> +struct pwr_mlxbf {
> +	struct work_struct send_work;
> +	const char *hid;
> +};
> +
> +static void pwr_mlxbf_send_work(struct work_struct *work) {
> +	acpi_bus_generate_netlink_event("button/power.*", "Power Button",=20
> +0x80, 1); }
> +
> +static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr) {
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
> +static int pwr_mlxbf_probe(struct platform_device *pdev) {
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
> +		return dev_err_probe(dev, irq, "Error getting %s irq.\n",=20
> +priv->hid);
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
> +MODULE_DESCRIPTION("Mellanox BlueField power driver");=20
> +MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");=20
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.30.1
>=20
