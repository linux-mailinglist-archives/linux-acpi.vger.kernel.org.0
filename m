Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F833EA80F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhHLPzB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 11:55:01 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:57569
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238351AbhHLPy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 11:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crMRmZ+4n5c4lgCpl0Dx/G6/9O7fwoeGCCAB2OUrgGiVsIHR/mYsJCrKEAWfjjMUptah66QEgaKc9O/Y/fNET29JOvG5DRgUkxI2fp5ReMY4lZ4yftK7b9rKi4XegqJtkIszXvcOiVAl1MU1I4uXphhUNl+BtjdErZ+1vtA2RrPYmNDJkhSaWAVQt8N0HC3KyY/tqS+fuXC02B+gKM4cWMNX63nnAaXeCpWvOaUEXKPDtH7oMA/G/AZFY8lG+AnqpGtCcb9TOkX14FfssssFdrmt4M67IpONu32AmMEbE1whUVnjxoDAVKAke3sq2QfrymECdvsSQoj9v2y93rXTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTUQWAGyzMCrYMcCjPmi4bSXsP6IP1xzWAbT7KnfXDQ=;
 b=DKnzapm9/xIh3X0WnIPpsxBqbWZHuhZBG3oyVrxqLeYwklBLZ7C/GmuYoQtTAkP0SsBmFE9p34GRzFh48/hlNmyaTtZHNuqMJOg3ttOkhNymkrbrnWzk0FhR2q4To9bm7qbrywkh1Vma6Xi1zaNurfSuGkX3GXdp8lH33R0U7k0CQ2qJ7eWa6CtU8nGQEwL9z6GODuiZvTCP+2bIK20yt8hMXJXUdOVLfSVnANxYTk6Vj6yPe5EL3V9nCIfow9W9HsrTV3wO68jAxZYQDit7Jz7f8z1BDUkRmkoTd7X11KYg6fbmWNyRHPDraoWkv++Xkcsjm0ursRryn4qF3o8ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTUQWAGyzMCrYMcCjPmi4bSXsP6IP1xzWAbT7KnfXDQ=;
 b=rklN+Oc711cq9Vc9KkS5vm4G1K1huMOC9znDpIrdu2ew688JqdWF5cxxtHx45OU8NjECJATdQe4r56U/Gf3wwhuPEGn2j4iCoUV2xxrjY2ufgteMStQxLQcEXrIhmVqqNy/9xazyxZQvCcpGcp4e5c2ObJGH0gh4uMCiUqydMbF7qg0UxFVSIcD12+ZD8+s2JxSg8vykjGPE/ekMD2ia55U3qWIKUaiDRGYCkT0+YErdmjBItffEKnKX7QmP0Lb4zTzfoESIkFe1lnK4MEITlC8ggu+vheyh1WJernn/OzlmqSxWILz5BLublld/Sz8acVhRaaSiGZVF4qYHSYGdjw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 12 Aug
 2021 15:54:27 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::9473:20a9:50d1:4b1f%6]) with mapi id 15.20.4415.018; Thu, 12 Aug 2021
 15:54:27 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     David Thompson <davthompson@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
Thread-Topic: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet
 driver
Thread-Index: AQHXj4RFqEwJ+TxolE6RFm/HH+1hB6twAdMQ
Date:   Thu, 12 Aug 2021 15:54:26 +0000
Message-ID: <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
In-Reply-To: <YRUskkALrPLa2cSf@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3c64691-c1e7-430b-2a40-08d95da976a1
x-ms-traffictypediagnostic: CH2PR12MB4230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB423071C7B1CEDCD970017830D7F99@CH2PR12MB4230.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uI8hJC6Jot0VCOaq05s1tErj9fim7Zp0PnNmULI4+YgR5sKAVNxbSKXc6w+IRjwl9bYFwegA8TUEKctRgVL8t8HZ1/qoaA5K7mtih1Jwv65dElV1yRz6uZ9DKb9/kiFLV8XG3V8r+5izyGe6+aMng6Xw4alwYRXO/pWkbZe6UB4ozqbNwP8G6UxAjo20zCpcUR7ZmFZe9h5koUkkg+si/dYJDs8WAzK+umqu3hFAFRIaAna3lxfFbC33PSBnvJxiJOx8XoSz2drq1Hquav/1DdmrEfvIo4lY0ql4s2Qwle3P23F9FiXY+idWckeDk+IkVaVleg9e4fmuVai0JM66tnf3drD1s3SxXVeEjd+A+judxjriyu2zQoLiuqmZEm5vr7ng9N5qojWG4Pc6j+Snfe1CW32nyzl+nZSFkPy7iOazl+KTcJzPdSZx9h4SpFgNPnnfXCrlw8y5jAEfabQUi266EcsBf6TdZ7zV/jrbt7UlJazOrmlpyYBYcLZWf3kJTRWIJqnjjbKKXpgZajROheVFH/X7BuWgho0P8kxFFKpUKiptwblh2csInhJYjS4m3bDQoObp97MGs7N0nz+IHM94rh5gBI607q4Fb/6Gp4aFz2i+Wy0lYc8Bywl3iPuMed2m3iRV8aCtccXFayTyGrr6NyS4Fo3f15lbjfRPNS+qHVrZrKS/nRiY0AiP6sUiGtJKfSAXzlIVf10qM8bcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(55016002)(186003)(38100700002)(52536014)(7696005)(54906003)(8936002)(66946007)(66446008)(66476007)(76116006)(64756008)(478600001)(2906002)(66556008)(33656002)(38070700005)(53546011)(110136005)(86362001)(316002)(122000001)(6506007)(9686003)(5660300002)(83380400001)(8676002)(71200400001)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ujUYt3LZUF59eqxREJeUl8eggLOBdMDlIIPRwZqPT8+iAcPa4wjvHMsYfV2?=
 =?us-ascii?Q?ZnPQfuw4nGR2PDVg1kzcD5FzeBvX9Vv2GY0zl2/MFjqV42qAofE9O/f70xvp?=
 =?us-ascii?Q?AYWmBOWrBER9wqw1gymZfpUwymoAyDXgXIm68hg/0OafrOV8egTBQ6MsupMc?=
 =?us-ascii?Q?7ASNZTwQMjzrz7RczQQEJO//0Nhs6cDwqjCG19By+1CNz7NZkSUUxyV+/k87?=
 =?us-ascii?Q?+Q3/2bSWdxYAQZiMSUkT/gJDfoY8VMwQgbDvMVMrx8FmViPOOkAzDJb8rPf8?=
 =?us-ascii?Q?2OgEh0CMKUa0yijjwe29DEpOkkTus56eHbR8BXupe27klTBwGaykBGxKx4tv?=
 =?us-ascii?Q?ZvR9YEkElTs2fxTVfQ7h+g3uf2TTpx+mM5aOPQqSJK0XETxa5trbkA0MdfDf?=
 =?us-ascii?Q?FQ7QY33Ju7HCg9KGfIi98WinVCNfq31ffE63mBQivdQgErY/D/s+LCaDvBH3?=
 =?us-ascii?Q?juik226C+fn9+OYh20GNN083vDCqMMXKe2Yf2l/Bba+ApXAWVvcTGY+wm8Uk?=
 =?us-ascii?Q?EYRezsZNonO6PM4w6S0b/OT+YZTCta5B7H1l/aHrNT/PrFH4Apbe1QmuBrWM?=
 =?us-ascii?Q?onrnzYOxi8WJxzzLoSu0ifx65s36btVoeA5YW524LVkJNMUsRhImRLZcB6ex?=
 =?us-ascii?Q?CDfr17ZJ/NYrrtDQZZupJ7gOR5YW59DyUgV2CCrlj9BdfVkk9E8QSFPZmdOH?=
 =?us-ascii?Q?kGmDk6yp/dCInledHoksJqGCtAoNOYPqQC3LLusKauX8gHlgE6kkv8xNwHip?=
 =?us-ascii?Q?qBPKZCXK16BUmVURZysqyrp8ev93Lp5vyKIuJbk1iZY8cr6/6GE4Se+e5vrG?=
 =?us-ascii?Q?0riGI/IC53fhLR8jQ14ERGuyWSgSu9Xq2XFAt1E56WEG9M38v6g7vDGp2rTe?=
 =?us-ascii?Q?oyzPTOykJLqw5g1Gps2G0lVBJLoxJVM1kEYH797k0/+hNktaNv2iabeLQVwv?=
 =?us-ascii?Q?7PeSb3ujfPSwVxmCdv9xfXf3XRMzOk2GtkgNsTRvCkws6huZUI8zmWdt5LZ5?=
 =?us-ascii?Q?iQkfs6MPJolMFsoL/hMVUWXLiMO5Vh7bRCAeEpaDhV+SZFfM1gwxLC/dDE9S?=
 =?us-ascii?Q?gPBqbiHQjhq2fgSWH06b9e/Zqn5HvMLj9TBcewM2YUrFHFJntiMr7lcmdqO4?=
 =?us-ascii?Q?wEn4/RVgIm/XVwZrIX0XIrSteCzv9aNGPXzjhevr+KvyAPMxc6DR2BBXCSPZ?=
 =?us-ascii?Q?sZgXyw/6vjRx4QXMYwEfF3Rjt3KEcbyk3ruy4EgOqVRmiRZI4dNNZ9yi4Q3d?=
 =?us-ascii?Q?ImMLwu3K24csIZpQpHoBtcPUiqCzdfYz0ZqfmmQBEa+1wCw1bPyksHjjLV5p?=
 =?us-ascii?Q?KdoO10WJQn7erPRGYaNHunbp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c64691-c1e7-430b-2a40-08d95da976a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 15:54:26.7727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwTh/ugk9aOVAA0mCMu7GPS78kA64knus5+NnWB6OIeoeoMAdgy1JezcfiHMqUIie4KJ0wofrvx7C9wnmw0HzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

We have 1 image common to all our board types. The ACPI tables are selected=
 based on the board id. Some board types have PHY_INT pin connected to GPIO=
 pin 9 and other boards have it connected to GPIO pin 12. So we have 2 ssdt=
.asl files:

// first file: PHY_INT -> GPIO pin 12
Device(OOB) {
        Name(_HID, "MLNXBF17")
        Name(_UID, 0)
        Name(_CCA, 1)
        Name (_CRS, ResourceTemplate () {
           // OOB Ethernet
           Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
           // mdio[9]
           Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
           // gpio[0]
           Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
           // OOB LLU
           Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
           // OOB PLU
           Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_=
RSH0_DEVICE_OOB_INT }
           Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF_R=
SH0_DEVICE_OOB_LLU_INT }
           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_=
RSH0_DEVICE_OOB_PLU_INT }
           Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0=
_DEVICE_YU_INT }
 =20
           // GPIO PHY interrupt
           GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " \\_SB.GPI0") {=
12}
        }) // Name(_CRS)

// Second file: PHY_INT -> GPIO pin 9
Device(OOB) {
        Name(_HID, "MLNXBF17")
        Name(_UID, 0)
        Name(_CCA, 1)
        Name (_CRS, ResourceTemplate () {
           // OOB Ethernet
           Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
           // mdio[9]
           Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
           // gpio[0]
           Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
           // OOB LLU
           Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
           // OOB PLU
           Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_=
RSH0_DEVICE_OOB_INT }
           Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF_R=
SH0_DEVICE_OOB_LLU_INT }
           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_=
RSH0_DEVICE_OOB_PLU_INT }
           Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0=
_DEVICE_YU_INT }
 =20
           // GPIO PHY interrupt
           GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " \\_SB.GPI0") {=
9}
        }) // Name(_CRS)

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Thursday, August 12, 2021 10:14 AM
To: Linux GPIO <linux-gpio@vger.kernel.org>; linux-acpi@vger.kernel.org; Ra=
fael J. Wysocki <rjw@rjwysocki.net>; Linus Walleij <linus.walleij@linaro.or=
g>; Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: David Thompson <davthompson@nvidia.com>; Asmaa Mnebhi <asmaa@nvidia.com=
>; Liming Sun <limings@nvidia.com>; David S. Miller <davem@davemloft.net>
Subject: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver

Hi!

From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
caught my eye.

Looking into the code I see that it looks like misunderstanding of how ACPI=
 works with GPIOs. First of all, I would like to inform that this code has =
been properly reviewed neither by GPIO nor by ACPI maintainers. Second, bef=
ore going it to the real conclusions (and potential revert of this), I woul=
d like to see the real ACPI tables for this and some explanations from the =
authors of the driver about GPIO usage here (from hw and sw perspectives).

It makes sense to discuss ASAP, otherwise I would really want to revert it.

--
With Best Regards,
Andy Shevchenko


