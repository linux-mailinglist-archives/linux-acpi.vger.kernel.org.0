Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F73EAB7B
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhHLUIR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 16:08:17 -0400
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:21984
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231384AbhHLUIR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 16:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOk/nlNmxszcVe0Nt2maw5EZ5V7ouRuhUlhfE4Edm5x3WcL4gerD+rHyv75jYuIgvMvO0nYilEyqQN1odXi2OnqzFhNm9rVB/wkzptdnzKEmw+qZVbm7+gKuNHeuYAu8w/pemtuX1id0AC7GbUUcTaRiD3Q4dGAAay2dY0nlKpEeHJe4D+uSef8tx3U3qthTx5EweiviFu4XyPXQgRFDwAKQCjcOEv9WwZpwQ57FKkN7OpFQUazQeRrFHs/etGrLYqCbz4e+X6/qZrFt+V2ZEl15q8NaxWuJVTw/WjLJlgQ/Hw8Ujlz3+p5kV5BbCHqn57PZ8AiVf0blKOaolFgSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6IbjwKudq0AyYNVqlQmedAn26vqIEH8KVjSw0MG6+U=;
 b=aB5pD0x4kBNHdRAjEtmdgj2I9PltJaR2JS3MbjmMrlTIG9jOsD4tKMdgdV5XbdHCP3QzmwJnyy8XR5reiT0EqowDZxd/AdAutZedlIS1ZE800ZQRzYllbrgcCcWrVtbN+S6LA6sFKOzky8APuBVAGOiE7wtSn+fe1ezRzQueQlHfoiV1u2CrSH8yVaeXdH8U3AFv+W6UBkB6Qx9pu+zP6h3yF6y7L5qgCHS0X9tS+EDVsAILrce/aFqaeQ0rVtXr74XYADhYutJ9vzi9NxfU7Y7HRsUQXJozj4ZQ25ADg/GXr0LtzqOuE3I5SXDjFa1vSYbgsUvxtSgYfXutvRrBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6IbjwKudq0AyYNVqlQmedAn26vqIEH8KVjSw0MG6+U=;
 b=ibt+f8iOv1WEA34EBVfVRwssOSIne2ZumotvE7+DbGkwzPe8knGspGRHzGZKNEJxWlFo95fNrNdeycpgrivUkkfr+6qXk2yYEHzR3Eu37zjWNOaOIZ+2ciX8+cNzNEeHd7u/14LBwtuGtjVv6S4zeHVldKxxyWt07rZwubdGreQ4mO/eg+vqyKEPl6pQjVvUOiPtjPIZLwt3SSui9yr0bTSufdVp22D50+qPgE3tnRRp2JeOCo58QXDIXygca5knLNZLRREgPbPZfxGd+alVQX4v4JhtVSMe87bO0KCFdvcq8cFtFlfJsJXHPuA21F1eZfshvk9zaB2z9m+srL46rQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 20:07:49 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f%6]) with mapi id 15.20.4415.018; Thu, 12 Aug 2021
 20:07:49 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Linux GPIO <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Thompson <davthompson@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
Thread-Topic: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet
 driver
Thread-Index: AQHXj4RFqEwJ+TxolE6RFm/HH+1hB6twAdMQgAAMkwCAAAnzYA==
Date:   Thu, 12 Aug 2021 20:07:49 +0000
Message-ID: <CH2PR12MB3895CB35E6EA17908979D631D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
 <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
In-Reply-To: <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b75735f-b10e-4f4f-f070-08d95dccdc2a
x-ms-traffictypediagnostic: CH2PR12MB4197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB419706CAA213D5B3C62298FED7F99@CH2PR12MB4197.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITmVWzKWuwtTq/feBv3eCmxdJ8KHy7Azn90jj1RMdM35gpIfuf5VQ+9IhFBvebSueH/LSwA8cGGnDfXkOz2vW+Z6ARCCSIagNaLACPFfAFRgI0LcPWDDwEntgfS7wn0/YqVDviII8mmlIq1+JcwdKN1K7fjEzqnnZEX57JRwJP6UYowH0l2S0RIdMc2L39CfWVbfBDNwkxXp+WxFOxjYd8aX5nAjTAHGDj7YmQ35G+lTohQu8hOl8/pHRXwcBb4hDr/lknE0nslXh+fW9UUAvqRGk5/zUNIii5mA4uqT9AK+yBdukDoPHcZU6RF2Ko0BkHsLBFdNGpRXvGlr6vqgHTo86UUUpyNPVDEeYbPA28EQ+GU8AHIbW919izSr6H0KRrTuji/Zt1BIqQXV2O4zI93ZmHIHKOtymEvBTw+4KFu6yRENGx1BqoZ6FJf5dpYCQ3IUqZ76EqfFU2jcq/2IBi4ltQpFYZHymBl9MEG5lAoIs7SIYR2cff++6UQjnmsreuv6pvR7A/UE6e/NiE5p1G26XsO4i2TJfDEgSiGlYx39vxROhUbpoelLR70DKURD8dsX8z5VIjtNYN4z4w99BVPAbALYXojd48/5Ibxh1GoZ4fu16vQGGbkQBZYrRHAh3E0YTVxsGWYr5QJIQtPmb7dB/0+gQingT5FxGQKTQuadeMHvfq3tWW5itKWrSMbCmvdT3rlcDSt2TNa68oOdmYccjDJsWjWGLWQAoZU4+KfOrwFbyh8YLdYI7MeB/mRU5/Tx0KIekYJmhBjjmZmIzYS3Jw5deBKcfya5BQ3eWgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(6506007)(52536014)(316002)(4326008)(478600001)(8676002)(54906003)(71200400001)(7696005)(6916009)(55016002)(5660300002)(33656002)(53546011)(9686003)(966005)(8936002)(76116006)(186003)(83380400001)(66446008)(26005)(66476007)(66556008)(66946007)(2906002)(38070700005)(64756008)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NGbxYLuurM7FKljUefvhz/ZWKfU8eyaJ5J6nqyTZqYPKV6G/qf1qnW3t6pZE?=
 =?us-ascii?Q?6vwr/oe+/qhJGYyMCy416Beb/JP6TPkiDoFkwwa0djs0uvm2TdvT2JFB2gMZ?=
 =?us-ascii?Q?3tXk/Gi4shOzxXx6rsWp+RniAtMOjM3RX4bqTjzTlURvXhX3KNhRXOKYsObS?=
 =?us-ascii?Q?64V7ApjP5qEbJyHcQEKZg4wiNKQDxgGJDUGg0KBYe+UWafqTCbmxGPwIkkMn?=
 =?us-ascii?Q?Gj17cuoJQlxciytrcvHKGB8gj0h5bRs0tt/51k4NF+S/+gJHqKMQ8SwfuRKu?=
 =?us-ascii?Q?LhecUJ5ziGVTtYjzLAJkYtWwbdCt86fjQQsxcVxtN3Kvgv4T4uFFYlwVEsrp?=
 =?us-ascii?Q?GD9Ly4SykK2YI2L5wpMk0CkUUE2bmCwNw24E4l3drsrKlmLZbuWJUEZGnIFj?=
 =?us-ascii?Q?Tmhx3GIiudIx92RLUnt/ilfkkHhtIqearP4cfMi164u62ck2Tv3gkcuAnoGN?=
 =?us-ascii?Q?WxMluB8CgGFEb+eUSPcxi2VeXjU/2hWuKLLVM2T7twhyJgyGfqnjd+Mj+u4P?=
 =?us-ascii?Q?m5//wl/g+yu6Q5i69BX4vlBXe3P+wZyyUcA9zo8H3f/q++BB7+wuAel4ckn/?=
 =?us-ascii?Q?9M3tOxj1845Mk/TbsEYy+9atC8DMznQ00gc2TG+XG0MR1yChkwXrPIix24x2?=
 =?us-ascii?Q?F5wUp//rQ7y+2/L3iWOk5OlDEsmaD2UsSNkUYk7CYGgrKjdm9XSb5AsF4UON?=
 =?us-ascii?Q?Hx+gjwu5CRxynxJa2jWjhLknCAulqzlZ5XE79gpu9Po9Ap5j+Gc3C5ygE03D?=
 =?us-ascii?Q?J3Bq7+vaag1HmG8J/DZ5w8mSmBoNScO7oR1TtJA4T+gRCwWHSAZZZliRdTHI?=
 =?us-ascii?Q?eqNulUyxlOCJijLTCFCUskBLYA2FqxvR+5FKReJof6jeHQb8jjDT/hdfna5R?=
 =?us-ascii?Q?H2cwC6Hma751OgHYi3grFqN/tp37/CnbiUwrzBKMIj2JWXZtkZUYgTSgMNw7?=
 =?us-ascii?Q?V8Fzv5LM9uGVpV/YAbpBxGvmfUkjPHM4dp3wIc8MmPRi29tJgaTmZUMgjKCz?=
 =?us-ascii?Q?vdEVa6gFmnl2enn2EFLqBuoZVy/mn14p8j9rQxdk4ZHTPfYe8USQnsDDtYsQ?=
 =?us-ascii?Q?fFknbwS9u2RxiRZi1zLwXt1/czvpChLBg1jLaO4C8q/bsLka1tfWrQ399OL3?=
 =?us-ascii?Q?WjV+2Dorc0YvWqjbSEb3Oz/fPUFrlvEa/zWgL0qyw/5yD9ar2GjQRfJR+iV0?=
 =?us-ascii?Q?fOLWHHMNKtOSSI7YixcodrpLNLA1qjPlXgAIBicN1ArRkHlM6NHd1/m7Gmvu?=
 =?us-ascii?Q?uIQUXR/xFLKofaAHN5dzTF2tJdZYojYzF/8Azh+0d9F7MtuGK80D54OwC2ik?=
 =?us-ascii?Q?e2ViAji+ACZ42wPv2FEiY9A+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b75735f-b10e-4f4f-f070-08d95dccdc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 20:07:49.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UB8jKsl4FQBkj1Do3DZ95yQ1D0U8uFkfiVefWTUIBTk7c8xjsOb8GHWpnrKtHGIVnAzFWeaTfJRJd+gjQPEd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Thursday, August 12, 2021 12:26 PM
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: Linux GPIO <linux-gpio@vger.kernel.org>; linux-acpi@vger.kernel.org; Ra=
fael J. Wysocki <rjw@rjwysocki.net>; Linus Walleij <linus.walleij@linaro.or=
g>; Bartosz Golaszewski <bgolaszewski@baylibre.com>; David Thompson <davtho=
mpson@nvidia.com>; Liming Sun <limings@nvidia.com>; David S. Miller <davem@=
davemloft.net>
Subject: Re: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet dri=
ver

On Thu, Aug 12, 2021 at 03:54:26PM +0000, Asmaa Mnebhi wrote:
> Hi Andy,

Thanks for prompt response!
My first question, is it already firmware in the wild that does this?
I.o.w. is there any time to amend it if needed?

Asmaa> Are you asking if it is possible to change the ACPI table's GPIO pin=
 on the fly at boot time in UEFI code?

> We have 1 image common to all our board types. The ACPI tables are=20
> selected based on the board id. Some board types have PHY_INT pin=20
> connected to GPIO pin 9 and other boards have it connected to GPIO pin=20
> 12. So we have 2 ssdt.asl files:

Okay (You may have one and actually choose it based on some [NVS] variable)

Asmaa> Ok!

> // first file: PHY_INT -> GPIO pin 12
> Device(OOB) {
>         Name(_HID, "MLNXBF17")
>         Name(_UID, 0)
>         Name(_CCA, 1)
>         Name (_CRS, ResourceTemplate () {
>            // OOB Ethernet
>            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
>            // mdio[9]
>            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
>            // gpio[0]
>            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
>            // OOB LLU
>            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
>            // OOB PLU
>            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { B=
F_RSH0_DEVICE_OOB_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF=
_RSH0_DEVICE_OOB_LLU_INT }
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { B=
F_RSH0_DEVICE_OOB_PLU_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RS=
H0_DEVICE_YU_INT }
>  =20
>            // GPIO PHY interrupt
>            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , "=20
> \\_SB.GPI0") {12}

PullUp with Edge/Rise seems a bit awkward. Recently I have added a correspo=
nding paragraph to the https://www.kernel.org/doc/html/latest/firmware-guid=
e/acpi/gpio-properties.html.
But it's just to double check that you got the idea how your hardware works=
 (maybe it uses open-drain or so and it's indeed the correct setting).

Asmaa> I forgot to cp/paste one more line from the ACPI tables. I have crea=
ted a DSD entry and named the gpio (although as you pointed below, it is no=
t really needed in this case):
Name (_DSD, Package () {
           ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Proper=
ties for _DSD */,
           Package ()
           {
              Package () { "phy-gpios", Package() {^OOB, 0, 0, 0 }},
           }
       })

The interrupt that we care about (which signals link up/link down events) i=
s actually the shared HW irq BF_RSH0_DEVICE_YU_INT (edge triggered, active =
high whenever there is an i2c, mdio or gpio interrupt).=20
We get that interrupt value from the ACPI table as follows:
priv->hw_phy_irq =3D platform_get_irq(pdev, MLXBF_GIGE_PHY_INT_N);

Although it is overkill, I only used "GpioInt (Edge, ActiveHigh, Exclusive,=
 PullUp, \\_SB.GPI0") {12}" to retrieve the GPIO pin number (12 or 9) in ml=
xbf-gige.=20
We could also have created a property (phy-gpio-pin) to pass the GPIO pin a=
nd that would enable us to remove all code related to "GpioInt" code in the=
 acpi and mlxbf-gige driver. But I thought that properties are in general n=
ot the preferred approach?

So whenever that shared interrupt is triggered, this routine is executed ml=
xbf_gige_gpio_handler:
ret =3D devm_request_irq(dev, priv->hw_phy_irq, mlxbf_gige_gpio_handler,
                                IRQF_ONESHOT | IRQF_SHARED, "mlxbf_gige_phy=
", priv);
It checks whether the interrupt is for GPIO pin 9 or 12 (depending on the b=
oard). If it is, it clears the interrupt accordingly and triggers the gener=
ic phy_interrupt routine (in phy.c)
phy_interrupt is registered via phy_connect_direct.

What I have seen here is a regular GpioInt() resource with a single pin.

Asmaa> Yes we only use one GPIO pin.

As far as I can see in the code it has the flaw that it actually will use t=
he last GpioInt() resource available in _CRS.

Besides that, why do you need to know the pin name and can't simply request=
 an IRQ as every other driver does (the exception is only yours in the enti=
re kernel)? The acpi_dev_gpio_irq_get() call can get Linux vIRQ for you sam=
e way you have got it for Interrupt() resources via platform_get_irq().

To understand better this piece, can you point out to the GPIO driver code,=
 which implements the driver for _SB.GPI0 in the kernel?

>         }) // Name(_CRS)
>=20
> // Second file: PHY_INT -> GPIO pin 9
> Device(OOB) {
>         Name(_HID, "MLNXBF17")
>         Name(_UID, 0)
>         Name(_CCA, 1)
>         Name (_CRS, ResourceTemplate () {
>            // OOB Ethernet
>            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
>            // mdio[9]
>            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
>            // gpio[0]
>            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
>            // OOB LLU
>            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
>            // OOB PLU
>            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { B=
F_RSH0_DEVICE_OOB_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF=
_RSH0_DEVICE_OOB_LLU_INT }
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { B=
F_RSH0_DEVICE_OOB_PLU_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) {=20
> BF_RSH0_DEVICE_YU_INT }
>  =20
>            // GPIO PHY interrupt
>            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " \\_SB.GPI0")=
 {9}
>         }) // Name(_CRS)
>=20
> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, August 12, 2021 10:14 AM
> To: Linux GPIO <linux-gpio@vger.kernel.org>;=20
> linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>;=20
> Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski=20
> <bgolaszewski@baylibre.com>
> Cc: David Thompson <davthompson@nvidia.com>; Asmaa Mnebhi=20
> <asmaa@nvidia.com>; Liming Sun <limings@nvidia.com>; David S. Miller=20
> <davem@davemloft.net>
> Subject: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet=20
> driver
>=20
> Hi!
>=20
> From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> Recently the=20
> drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> caught my eye.
>=20
> Looking into the code I see that it looks like misunderstanding of how AC=
PI works with GPIOs. First of all, I would like to inform that this code ha=
s been properly reviewed neither by GPIO nor by ACPI maintainers. Second, b=
efore going it to the real conclusions (and potential revert of this), I wo=
uld like to see the real ACPI tables for this and some explanations from th=
e authors of the driver about GPIO usage here (from hw and sw perspectives)=
.
>=20
> It makes sense to discuss ASAP, otherwise I would really want to revert i=
t.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--
With Best Regards,
Andy Shevchenko


