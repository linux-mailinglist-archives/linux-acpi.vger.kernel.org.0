Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C73EB6BA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Aug 2021 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhHMOcy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Aug 2021 10:32:54 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:11854
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231683AbhHMOcx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Aug 2021 10:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJLLQCzCgi9+w4JfNy8RhOJhmerlseQww9sCb/X3I95Wad5pGbafzwbMg5mnSDYYAOgOa5kYaD6ZJEQUL8C0d3yChElQ7KXxh0JgiYS/ptc0pRl5qBeaRoxGPMuimFYQrFPomjwJ55H9tCD/uvalBamX6hzzNXl7/rKkUpodynzrxLGTzMo65zOhzGYHXvQRvX6U94wvNSUU02egJ8C5h1FQC5vPcxlQr4It6n2TDuT4HvDPih2lX+VhkKDd3P9VVIUlAWqP+/WqaaYkZMn0tcQ1H3UM/u5A98G37qXGugy0FbkNyf1ONMX4O3HTKb47623WUJm6/V3oWHQCfY+cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsEAe5VCfLYqxkeRKSmFejZu+04sLq9S/e0MZfTZ1lM=;
 b=O1m0XvlDdRabjGb21eaM/QReGGqVF7u+ptoW/LY83XCaKtJrhS34lHtjds4xA7XAiemQSWk9+PnEFcgyQj7mSldhxwQgLkiJnFNT1EpRgQhw7774ZJpkl2JRL8cVLI4/Q4RtFGltmVXZXNB+HEn7NTeAzPexmueI67aDbUObj/4YN6Gx26/Ibwb8O04AFch+AVuzcJh13m6XE31F9DemIQ/eziUd4b7COjeSHlE8/JB81s8tZfZc4bvisV+iBeTfiAgfk7XWw1rbemB88GtplQH/e2DZoVp+YLedsVCHLcgo9G0e45Pe0iNxNuCrnBPvqZyrb6rYsUEr7wRrhptS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsEAe5VCfLYqxkeRKSmFejZu+04sLq9S/e0MZfTZ1lM=;
 b=Gn2U0xoMg3lNDYFsmO8quXg9gqzBpj4cwwnd80HJS1TANTLKNLiQtT5vodFFY+17leiYcJXNxiyiEpaXxczDHzXZjC361+ucPiT1m2rb31sYCdjNvhcu987eqaZtqQHcgF+4eifjJxs0nN1F7JoZt9wiuZjm0lQ+7xmE3EL6qK5gwP/NtVWnMuK/DizBq6L9RgojHn90dvJSaWFRC9eJ070ylM8JiBEGzWSl5V9zTukoGFsLXqCYwvu6FEuAiZqJtYqi1oymw0cahjlPOle9DRFUfxRcZ02OiZnDa2+ePR1tX00a16kygWarJmggfHOq2JDwXqZgFebJBckm6XpRVQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 14:32:25 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f%6]) with mapi id 15.20.4415.018; Fri, 13 Aug 2021
 14:32:25 +0000
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
Thread-Index: AQHXj4RFqEwJ+TxolE6RFm/HH+1hB6twAdMQgAAMkwCAAAnzYIABXPiAgAADExA=
Date:   Fri, 13 Aug 2021 14:32:25 +0000
Message-ID: <CH2PR12MB38954677254F4243A9067E9ED7FA9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
 <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
 <CH2PR12MB3895CB35E6EA17908979D631D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRZ4palCFBFdR/7D@smile.fi.intel.com>
In-Reply-To: <YRZ4palCFBFdR/7D@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04bc46b4-542d-4271-b691-08d95e672b7b
x-ms-traffictypediagnostic: CH2PR12MB4006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB400652150E1A762AFEFD06AAD7FA9@CH2PR12MB4006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZILXNXaQnPitZ6FhjxZFvNH9cYfSSEmse+jBq1zNWzSn2ZRoRCyubvTjmQ7Sgz7S1Bd5Y/gyfDLS2XHjEA2ikiHRf23VV4Y2lagf6u6PQ38JhJQI6dodvjTfAqZ1/KBNJ3Q6cdZD4DDIlT1MJjqbVPyK054pZ61Dy8zVdgvFfu9JpjWIQuwnyhx1ZwzfV7gBFnWhY9liACXBfte9UZ96SVgC9zB9iWZDUGMpDxqtzC2YqFvFSYUS+yP7Iki3XlgsHon9bMCbz8Tj6buAxCj6x56LVU2Af8BpfSL9i7bgg/Yw+6aZm2Haq+Rn+bgBZDyyaCIp7i1AqdlE30trJx9nFEu0yv2PJKKCM5gutnw4oX030PJePcZKaGnT/zAziWkTZjqTl9Dxi1dj1rR6kgpX8Hbxp2PZP6qM+zc7FAuEGVtZIeZMNURedsylOcHMn1Gmk6vikoW8g46zrKIp6c4A3UcUc5ln3CvcggAh14leyvZyo6NLFMhAHZg5X/JELFR4OjRtl1nU94U2kOBnfmOc23uzCHc3GvnYKabwKs/EIyL29AxnaQ3BN81d+oPB0UJp69CImL8ihAGgigRuxepqcZu2IWFymrK97xRXqJNzPTLjegeErhwRtjpeRVoIOeVQ5QY1oftpeqPbL3IELFrQ5d9UNdW14f7FEv+qOg5JW7xVVqnWXYaewyBo5Mo6LJs/gb5cSmDIF2rTjP6FyN+MIy0FWet4O5qL5eC72FnQgwu8v2QXnKC4TkT62Zva6h30Fzk0ScYBXXTHtcm3fTGxksFRGxy1m6nBAu6XFTCRHPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(316002)(2906002)(8676002)(53546011)(64756008)(5660300002)(55016002)(66476007)(66446008)(26005)(33656002)(8936002)(4326008)(6916009)(6506007)(52536014)(66946007)(9686003)(76116006)(54906003)(186003)(38070700005)(966005)(86362001)(7696005)(83380400001)(38100700002)(66556008)(122000001)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3Pxhz/ACjuoOPgWvlEWc/pRSAR37iSNh0U4T95NEnW1D8EVHXYs9sLKcqR8?=
 =?us-ascii?Q?hQIJNfw1TLOYBNvpKCb7lgRUyH/cOjCF5XqhZP1ao5j80SJ6JvWXTOGp/Tbu?=
 =?us-ascii?Q?8KLFGa5aTqBK46MTfBXMS6ONgQngoOpyMji8mG/7YA8Nfav5jldLJ5K5GCF+?=
 =?us-ascii?Q?9Ji9XmndYVK/hHhg6b/+F3+VAA3FZcql1MDEQvWpjSlB3LcYBExywuP4xmh4?=
 =?us-ascii?Q?InGJxITD8m6S4sxT1Xd4lUfKs3tuph3Q1N33QGv9iZB1gQwDhI+mwgz/H43P?=
 =?us-ascii?Q?Ha1eYJEkB+p0d51vchbEPTDcX+Tsi6wPaNUhqRIzLPqShdk8fbz1dGcUThjK?=
 =?us-ascii?Q?r50GyAjyqU3fVEQckap+SuCZfH4GT7LGI4J/36CSpOhAr+DS2HgfIPFh+AX6?=
 =?us-ascii?Q?ForaYE3FmU3dOl7IHzJuS7g6xDKYgpkdC/IRpxNbAnXjEjezOCiuwWgPcBlB?=
 =?us-ascii?Q?Cfu+cS/sUFB4g6/XPXeKAsK2VvXNbNTl/SSySAznAvwZaGnVjIc7OWQGu0n1?=
 =?us-ascii?Q?s3z+N005l6xQIMiysBqTPE9Dc9VCxCJDsy17n5d7TArR52ED/vKTAzVAXVvt?=
 =?us-ascii?Q?FY1OM9UioamvJbI4l/0QNKorLPwekFu0Tyeno/zuD4y4x77b2mIIzFsVMA59?=
 =?us-ascii?Q?+FmnmNBwIRXbPfaQzRwMrTE7QvCzTG4Phs/4yby3ncCB/Q8Vvs6DlWv6JyGH?=
 =?us-ascii?Q?tJpaMLa9faAuW9yn90MswBhgz0BGTP1ORF1sIka4f3I+cyXYCCatyYgy5NrF?=
 =?us-ascii?Q?Pd7uHlf6QV3jm3b+Wb6SYFK2q0PpxYYmNDdS62zESzKrWBkoKJ08p7QLYBT7?=
 =?us-ascii?Q?Xl5H/K+lzGIogJzxsJsvvCoqji5TgqrDTf7GX+gTtA+q1cuXTUuj6Ytp8nK4?=
 =?us-ascii?Q?+jw/Q7ckb35a+OFN+6bg7QbK4OGjd8g082ezPSdcjjjl65/3cpTdbuGJjyFr?=
 =?us-ascii?Q?r25QDT9E7zUiOFWtmaYFOxKOPPShGQgy1X/ljfmlKnONYytMWtWxMAe+74Ew?=
 =?us-ascii?Q?it19T/XaMrBS0wi5H6CWIKLjN3Lyl0wlP1cHno0Au49khK1cSNX2rJRzSELs?=
 =?us-ascii?Q?9XhbJ2SkA8gttQH63isi25AA7xYgx+ub63Zl14+5uqs0L7UxUCql2So/VPgN?=
 =?us-ascii?Q?wIGAQ6AeM3vQUUtJGEvzCFL8V8CpOBxrYSVemDM+XHfaC/eNrGhTRDtLxvHh?=
 =?us-ascii?Q?GcaEoNApYpS7qShmrpV9PiDHAdAEbmmm6NrWP30MKYdfz3dyJtgvThHpHMmN?=
 =?us-ascii?Q?L+J1LA7qj4txBTwNbiLROtMcCNSqnafbkvutoKaHMX/3iTTg3qe7/XV3bLiN?=
 =?us-ascii?Q?pA9GOMKlazDRlO2OPlGxYC+H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bc46b4-542d-4271-b691-08d95e672b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 14:32:25.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLAWlSPGd/x7FdroY2KY4rQaieoeLoyAcRjqic5B224Tyq6AJkUU0zWet9BLeWvtjgGwE3mGZ9UKnvgZdMpasA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, August 13, 2021 9:50 AM
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: Linux GPIO <linux-gpio@vger.kernel.org>; linux-acpi@vger.kernel.org; Ra=
fael J. Wysocki <rjw@rjwysocki.net>; Linus Walleij <linus.walleij@linaro.or=
g>; Bartosz Golaszewski <bgolaszewski@baylibre.com>; David Thompson <davtho=
mpson@nvidia.com>; Liming Sun <limings@nvidia.com>; David S. Miller <davem@=
davemloft.net>
Subject: Re: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet dri=
ver
Importance: High

On Thu, Aug 12, 2021 at 08:07:49PM +0000, Asmaa Mnebhi wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, August 12, 2021 12:26 PM On Thu, Aug 12, 2021 at=20
> 03:54:26PM +0000, Asmaa Mnebhi wrote:

> My first question, is it already firmware in the wild that does this?
> I.o.w. is there any time to amend it if needed?

> > Are you asking if it is possible to change the ACPI table's GPIO pin=20
> > on the fly at boot time in UEFI code?

I'm asking if there is any device with these tables on market?

Yes it is.

...


> > We have 1 image common to all our board types. The ACPI tables are=20
> > selected based on the board id. Some board types have PHY_INT pin=20
> > connected to GPIO pin 9 and other boards have it connected to GPIO=20
> > pin 12. So we have 2 ssdt.asl files:
>=20
> Okay (You may have one and actually choose it based on some [NVS]=20
> variable)
>=20
> Asmaa> Ok!
>=20
> > // first file: PHY_INT -> GPIO pin 12
> > Device(OOB) {
> >         Name(_HID, "MLNXBF17")
> >         Name(_UID, 0)
> >         Name(_CCA, 1)
> >         Name (_CRS, ResourceTemplate () {
> >            // OOB Ethernet
> >            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
> >            // mdio[9]
> >            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
> >            // gpio[0]
> >            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
> >            // OOB LLU
> >            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
> >            // OOB PLU
> >            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
> >            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) {=
 BF_RSH0_DEVICE_OOB_INT }
> >            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { =
BF_RSH0_DEVICE_OOB_LLU_INT }
> >            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) {=
 BF_RSH0_DEVICE_OOB_PLU_INT }
> >            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) {=20
> > BF_RSH0_DEVICE_YU_INT }
> >
> >            // GPIO PHY interrupt
> >            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , "=20
> > \\_SB.GPI0") {12}

Just a side note I forgot in previous reply: The tables themselves look goo=
d in my opinion.

> PullUp with Edge/Rise seems a bit awkward. Recently I have added a=20
> corresponding paragraph to the=20
> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-propertie=
s.html.
> But it's just to double check that you got the idea how your hardware=20
> works (maybe it uses open-drain or so and it's indeed the correct setting=
).
>=20
> > I forgot to cp/paste one more line from the ACPI tables. I have=20
> > created a DSD entry and named the gpio (although as you pointed=20
> > below, it is not really needed in this case):

> Name (_DSD, Package () {
>            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Prop=
erties for _DSD */,
>            Package ()
>            {
>               Package () { "phy-gpios", Package() {^OOB, 0, 0, 0 }},
>            }
>        })

Yes. in this case it's not needed. Only case when it might if you have a bu=
nch of platforms where a few GpioInt() resources are present and they have =
no mapping. This will help to figure out what resource is related to what I=
RQ line. Overall it's not bad decision to add one.

> The interrupt that we care about (which signals link up/link down=20
> events) is actually the shared HW irq BF_RSH0_DEVICE_YU_INT (edge=20
> triggered, active high whenever there is an i2c, mdio or gpio=20
> interrupt).  We get that interrupt value from the ACPI table as follows:
> priv->hw_phy_irq =3D platform_get_irq(pdev, MLXBF_GIGE_PHY_INT_N);

Wait, what you are telling is that the GpioInt() resource is a dup for one =
of
Interrupt() resource. Is it correct interpretation?

Yes GpioInt is not needed since the ACPI entry (from the above code snippet=
) defines the shared interrupt as:
           Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0=
_DEVICE_YU_INT }

> Although it is overkill, I only used "GpioInt (Edge, ActiveHigh,=20
> Exclusive, PullUp, \\_SB.GPI0") {12}" to retrieve the GPIO pin number=20
> (12 or 9) in mlxbf-gige.

Yes, but why do you need to know this pin in software?

I need to know this pin in software to be able to access the corresponding =
GPIO bits in the control registers. Each gpio register (there are more than=
 30 HW GPIO related registers) is a 32 bit register. Each bit in those regi=
sters corresponds to a different GPIO pin.
For example, in each of the following registers (which are used in mlxbf_gi=
ge_gpio.c), we only care about R/W to bit 9 or 12 (depending on the board):
MLXBF_GIGE_GPIO_CAUSE_OR_CLRCAUSE
MLXBF_GIGE_GPIO_CAUSE_OR_CAUSE_EVTEN0
MLXBF_GIGE_GPIO_CAUSE_FALL_EN
We don't want to modify any other bits since they are bound to other GPIO p=
ins which have specific HW functionalities.

> We could also have created a property (phy-gpio-pin) to pass the GPIO=20
> pin and that would enable us to remove all code related to "GpioInt"
> code in the acpi and mlxbf-gige driver. But I thought that properties=20
> are in general not the preferred approach?

Properties make sense when there is no standard ACPI approach or it lacks o=
f some information. As far as I can tell here the properties is better, but=
 I would like to understand first the need for this information in the firs=
t place (see above comment).

Ok. Please see my reply above.

> So whenever that shared interrupt is triggered, this routine is executed =
mlxbf_gige_gpio_handler:
> ret =3D devm_request_irq(dev, priv->hw_phy_irq, mlxbf_gige_gpio_handler,
>                                 IRQF_ONESHOT | IRQF_SHARED,=20
> "mlxbf_gige_phy", priv); It checks whether the interrupt is for GPIO=20
> pin 9 or 12 (depending on the board). If it is, it clears the interrupt a=
ccordingly and triggers the generic phy_interrupt routine (in phy.c) phy_in=
terrupt is registered via phy_connect_direct.

This sounds strange to me. What you are telling is that there is no hw regi=
ster from which you may retrieve this information? So it's a workaround of =
silicon bug?

Yes. There is no register where I can retrieve this information : ( . This =
is why firmware decides that at boot time based on the board id.
And that is a good idea, I will share this proposal with the HW team as thi=
s will make the code a lot cleaner for future generations.

> What I have seen here is a regular GpioInt() resource with a single pin.
>=20
> Asmaa> Yes we only use one GPIO pin.
>=20
> As far as I can see in the code it has the flaw that it actually will use=
 the last GpioInt() resource available in _CRS.
>=20
> Besides that, why do you need to know the pin name and can't simply reque=
st an IRQ as every other driver does (the exception is only yours in the en=
tire kernel)? The acpi_dev_gpio_irq_get() call can get Linux vIRQ for you s=
ame way you have got it for Interrupt() resources via platform_get_irq().

> To understand better this piece, can you point out to the GPIO driver=20
> code, which implements the driver for _SB.GPI0 in the kernel?

Any comments on this? Do you have a GPIO driver available?

Yes please see below:
The gpio driver is gpio-mlxbf2.c

Here is the ACPI table for it:

Device(GPI0) {
        Name(_HID, "MLNXBF22")
        Name(_UID, Zero)
        Name(_CCA, 1)
        Name(_CRS, ResourceTemplate() {
          // for gpio[0] yu block
          Memory32Fixed(ReadWrite, 0x0280c000, 0x00000100)
        })
  }

Device(GPI1) {
        Name(_HID, "MLNXBF22")
        Name(_UID, 1)
        Name(_CCA, 1)
        Name(_CRS, ResourceTemplate() {
          // for gpio[1] yu block
          Memory32Fixed(ReadWrite, 0x0280c100, 0x00000100)
        })
      }
       =20

Device(GPI2) {
        Name(_HID, "MLNXBF22")
        Name(_UID, 2)
        Name(_CCA, 1)
        Name(_CRS, ResourceTemplate() {
          // for gpio[2] yu block
          Memory32Fixed(ReadWrite, 0x0280c200, 0x00000100)
        })
        Name(_DSD, Package() {
          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package() {
            Package () { "npins", 6 }, // Number of GPIO pins on gpio block=
 2
          }
        })
      }

> >         }) // Name(_CRS)

> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, August 12, 2021 10:14 AM

> > From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> > Recently the=20
> > drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> > caught my eye.
> >=20
> > Looking into the code I see that it looks like misunderstanding of=20
> > how ACPI works with GPIOs. First of all, I would like to inform that=20
> > this code has been properly reviewed neither by GPIO nor by ACPI=20
> > maintainers. Second, before going it to the real conclusions (and=20
> > potential revert of this), I would like to see the real ACPI tables=20
> > for this and some explanations from the authors of the driver about=20
> > GPIO usage here (from hw and sw perspectives).  It makes sense to=20
> > discuss ASAP, otherwise I would really want to revert it.

--
With Best Regards,
Andy Shevchenko


