Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120932E0B30
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Dec 2020 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLVN4d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Dec 2020 08:56:33 -0500
Received: from mail-dm6nam11on2135.outbound.protection.outlook.com ([40.107.223.135]:46304
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbgLVN4c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Dec 2020 08:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOsRiHSGvlKLuXP4ZoOBdDJvlx5+jjqEgWyeD+5S9b7F6hTKnBBNIUxZFTm+1LL1O6XNlVaCed0oVgJue1HRVa2NRtwNNTzyS2jrIBQNi6VsVnmXXmce6F5m/VQN5px8hPBzN4qcrbV+2///Xhe9UntcNhu31+HZVssl7vNQPz79mpN+i6GIaq9iS9R0CiJoR0Zj3IuswpAhzhUz5y9PjCGsHXEJeOTgymOWOY/lIs3zNfCr5eLhIdMeKdXD/7RYuo6hxmBNvn0Sqev+0bJqbIj4Rni7O4vC9Ap44RGAf50p66WDwrY4H35WGXo7SiV0r91ze7Xfx8FWlDBWfPqABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBQEZrgR/d9pSzKhS6dU/iZ80XdvP7sDJM6gerH/AhQ=;
 b=MoazBxdBPH8QV0Dfh8e4c7/PQ8t7t3IIXfSUM2B8j0LqyaWkJ4Q8fEUC9BdYrCT0SeXR+is7h8AuByPYzPn5ZergtY3TxyYexpcp9v56YOzZ553PUMoWprs9ylcFVIp9vk7KeLm6Yat8RR3BXd1qU/ZiH6XfuLl03USIlCIjORjLT+f9oVw/0NynfuG5zMqin9nNicFWUzSLhcEkmBTzqE6gzuwdgZrKimxV3VNcDWeQtOf+p+99Ilekaz8QYMmw5eRSikVkD8WPEEUyaN5IJIrwRQz9w93e5JiEKggulXpLKwA6U9JNbMSNclotMtXKlH75nL0yTy6Rk/zvzFc/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBQEZrgR/d9pSzKhS6dU/iZ80XdvP7sDJM6gerH/AhQ=;
 b=TWgxlqK/+XIcuQ+HmnCCvJ1akt70+ii50ow6V/vq/GNrv1qe54vNZOQtRq3BqlLMp6zjkbFekTJP35vAjKOGp8Xkoc0YfR95Fj4jyyyUhEptahtD+f+hvTw3N66lDJ7tyJphZ5nhAfzHqrqjnDD23tPdYrKkFbRkXqQVZNRgvEE=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1834.namprd21.prod.outlook.com (2603:10b6:302:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.4; Tue, 22 Dec
 2020 13:55:44 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 13:55:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
Thread-Topic: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW1POBokf/7OWH4kanDnc/vUp1qaoDKa/A
Date:   Tue, 22 Dec 2020 13:55:44 +0000
Message-ID: <MW2PR2101MB1052E61BEB80F14896EEFA79D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201218040826.57203-1-decui@microsoft.com>
In-Reply-To: <20201218040826.57203-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-22T13:55:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86b9b0ba-9f0e-4826-8f90-1a3393d863df;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 075f2e31-4757-41e6-26a0-08d8a681472b
x-ms-traffictypediagnostic: MW2PR2101MB1834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB183434938A2034AB5DEF9513D7DF9@MW2PR2101MB1834.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hl9U2ohLwgxGfFz2m2lyvKrGA/vZmfQHfk1UEKFM1ZfQGN7kIbZxwECjyNLue2YGknbkd451+IXXetI3GTj4TXcBugkWN6yl9xUs1lbKougMJfPzBJ0iBQQKMJ5AiUeMQq0aXSsgdTLRCVbSPDyU+mins/L+M1ooYh3YasyppsnDXOYPeC9gr+1kRNN1LGJv5qCDkhqsQ0mjMt612X32rnbQ3yaVbADwUekCK98SV+N0S3o6mRfuR3+bEuK7g3NVUML56n8W4WmM5V7x3fcMMbugSOz1DRWJqvHJcarTAPNgfTutyQuFFv9mpxv4mnPbvwXh4xVP9Z3ycxO0IU11carkiNBOJ4J1PRy7sTPzCc/6r7qsW0DNks/o7JJ9TpbvcG8l0rFepop27zTJ6/1Tpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6506007)(5660300002)(33656002)(8676002)(52536014)(478600001)(26005)(10290500003)(316002)(186003)(8990500004)(110136005)(54906003)(86362001)(71200400001)(107886003)(76116006)(8936002)(66556008)(4326008)(66946007)(66476007)(55016002)(9686003)(2906002)(64756008)(66446008)(7696005)(82950400001)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LbBQS80olQaaEqVfPgPRkMeE8ecUP0a2nsEfRiuzi62zBXv+OSENWxmJqjNV?=
 =?us-ascii?Q?Ksv14TfPcg6q33F7/tpxAQKgs+Z+ryWzc5ZL4x2LWQGZmYBDKLdRDGALVTVv?=
 =?us-ascii?Q?tw2PHrNrc3NWpEqAmA2eG+CuBrh5GcMt9I6JM5XPBMGVKlqJN30WY0dTaMpG?=
 =?us-ascii?Q?6eIqhQUMMMmGZYYNsu5XTjprJdymJPQB4iJPUWDW6k1d6KkxRMVtOsS8abxs?=
 =?us-ascii?Q?UlqVlsPFBfgE++hc5eykJNfbAlL/yAnnS2ilFyHEqoiMUexbcOd9Rl8vUNKL?=
 =?us-ascii?Q?rmEBF1q/71FZHFTp9YSTGUIfjlTQW53a95wQpAiW4kVAfP846fZnS85WpPFk?=
 =?us-ascii?Q?z8N85qIma1l1aVAF3iZ8jIspnmJ+eK1sD7bI/5hmSYeE1ffqwwiBnfbczg3H?=
 =?us-ascii?Q?tmlqa/qjBr87T5GQUFMMkDszSU1CkYrHgPgtCK8JqeTVPiXhG8Kl6uy/kJQm?=
 =?us-ascii?Q?nqkn2fUQI0EomDaRnE4QFUkX8OaKtObE9+7zRSIQDUIL9yQa5TFnPDB+6EiM?=
 =?us-ascii?Q?gv/SF1nLZNYspSQiZhxMQMAJfjQC0aTf/joFp3Ks0aaG3z3yNjlj/bLNi0MF?=
 =?us-ascii?Q?rN6j5+I3NXyPoF3UFaaBM91iGDud5l2NYH34y+SrQe+LjQ7b3zBZtzVK468+?=
 =?us-ascii?Q?6t5ttkXX7CXorwhofFhc3vx3joIJcBTzpKviufj3lyrMawON2ZrmMWb+V9nC?=
 =?us-ascii?Q?ysyb9rxe99C6O2GdknR05GDqEku5KHvsnxaPnSDbQ3vvjnuGMfKIPfeA9oC9?=
 =?us-ascii?Q?Q/y869yAKXY2gRnbzsFaG4XwChDrv4X1c5Ot/SW2GTKxobSGeQ/dTGNgI/Wd?=
 =?us-ascii?Q?6neyi4e2j7JQXSN4uBmoLX2ti2O9TP7YC/WWQ9ll1Q4RPOUPd2zY8XxE6mcS?=
 =?us-ascii?Q?S/8l+XFlrp/63xKPxPqjjRT+wHVAQiuT2u5ehM3pkZg7iCQfyf/41OC379wi?=
 =?us-ascii?Q?vhoP2GcIYm+A34GDdYcOlUKsf8ISMJkHDKTo7J0sy3w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075f2e31-4757-41e6-26a0-08d8a681472b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 13:55:44.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8sHT+Sd5atsdDR1/aBewnZJhZlSBcw+LkBxRBgNLIXXfwCjwmKEbVqz/fHuYNLD99ihDs4IvAQGR+Cd0BkCwpkt+90jbfUH1UzP6SbBvmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1834
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, December 17, 2020 8:=
08 PM
>=20
> Linux VM on Hyper-V crashes with the latest mainline:
>=20
> [    4.069624] detected buffer overflow in strcpy
> [    4.077733] kernel BUG at lib/string.c:1149!
> ..
> [    4.085819] RIP: 0010:fortify_panic+0xf/0x11
> ...
> [    4.085819] Call Trace:
> [    4.085819]  acpi_device_add.cold.15+0xf2/0xfb
> [    4.085819]  acpi_add_single_object+0x2a6/0x690
> [    4.085819]  acpi_bus_check_add+0xc6/0x280
> [    4.085819]  acpi_ns_walk_namespace+0xda/0x1aa
> [    4.085819]  acpi_walk_namespace+0x9a/0xc2
> [    4.085819]  acpi_bus_scan+0x78/0x90
> [    4.085819]  acpi_scan_init+0xfa/0x248
> [    4.085819]  acpi_init+0x2c1/0x321
> [    4.085819]  do_one_initcall+0x44/0x1d0
> [    4.085819]  kernel_init_freeable+0x1ab/0x1f4
>=20
> This is because of the recent buffer overflow detection in the
> commit 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fort=
ified string
> functions")
>=20
> Here acpi_device_bus_id->bus_id can only hold 14 characters, while the
> the acpi_device_hid(device) returns a 22-char string
> "HYPER_V_GEN_COUNTER_V1".
>=20
> Per ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID), if the ID is a
> string, it must be of the form AAA#### or NNNN####, i.e. 7 chars or 8
> chars.
>=20
> The field bus_id in struct acpi_device_bus_id was originally defined as
> char bus_id[9], and later was enlarged to char bus_id[15] in 2007 in the
> commit bb0958544f3c ("ACPI: use more understandable bus_id for ACPI devic=
es")
>=20
> It looks like so far an ID string of >=3D15 chars is only seen in the gue=
st
> BIOS/firmware by Hyper-V, and AFAIK the ID string "HYPER_V_GEN_COUNTER_V1=
"
> is never used by Linux VM on Hyper-V, so let's just truncate the string t=
o
> fix the panic.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/acpi/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a1b226eb2ce2..b801442b6b1b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -674,7 +674,8 @@ int acpi_device_add(struct acpi_device *device,
>  	}
>  	if (!found) {
>  		acpi_device_bus_id =3D new_bus_id;
> -		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
> +		strlcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
> +			sizeof(acpi_device_bus_id->bus_id));
>  		acpi_device_bus_id->instance_no =3D 0;
>  		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>  	}
> --
> 2.19.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
