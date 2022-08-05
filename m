Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041BD58ABBC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Aug 2022 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiHENlf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Aug 2022 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHENle (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Aug 2022 09:41:34 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2044.outbound.protection.outlook.com [40.107.11.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FEDDF44
        for <linux-acpi@vger.kernel.org>; Fri,  5 Aug 2022 06:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUbm7/BIqdufKKvMsQFtJimoCi1OaCUyMh4SXirP991+npFZtdv/X28klWgoRP5DIuX0htdfvsbIWHpZeSD8obE0JiKbtj2QtGNreYeTwfm4miF/RQXWc0ujJOba4bz2gehVCn8vh24PvG0xJ5yKcd8l1uHGm9Euy4Q9z6NcA931KjKYkj8sR1ZF9aDXaYfdZDEwVsHKTtrXFfdcjw1B/8d1wflZB5WiKL5cRM1j4jlngfRTroK0J3M5/PcgIPYAPcd+xzjgeKrzzrW748sNReZ9OHT3f2INSC9d7LjORAiPmicD0wS1zoEyRAQGMyb5x3OgSNI/Qe0N3oEWaH33vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzG2nuyt5ZrU5N/a7RYOmeRzm1sx8Ab2gRsoYeJLJ1A=;
 b=QeXJOkUmZ+rBaXdY7WjSnQkykiQ7UsVSfU+QjLCMlxA1NZE6A9v3k1lUzNfqNgF2wVME37nEGilMdveuehwYO92LjV13/gixY7ceXJNyNvn5iGd1QoxWyhXHX6zpaeA32i2ow5dkyL/OQjzM1zktSUExXyc/wS/+C2iWQ1Kcalp2ZANEQmWHFberltP+75uUsIyiP6rAap8GrpMUM2qQkbhQoQRRta3oxWMYkBHoYMdH0hkUTH8N1j6vwN2rBh0glpqeebKnN9wx4VrVI0y4kB3WF2BL5s2U0offvIgYO0QBonzEbPRy23k2a4MMNiA9mSzLQefCjAinkytPy7nPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phabrix.com; dmarc=pass action=none header.from=phabrix.com;
 dkim=pass header.d=phabrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phabrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzG2nuyt5ZrU5N/a7RYOmeRzm1sx8Ab2gRsoYeJLJ1A=;
 b=nR9P4e6TaJOH9wss3XNA1glN6QRSxNrmehiprIqhRiMwpMuPvVe9GI9mPZj6vbB0VyiFeOYz/NHc3gTs+eNXLHQo354YqQKBrdW9QlRa29thrwuCZ+JSCXY6gZIWAOnRF5gSu/yKCgm0nmguQC5elPOD0ZJwAybJM5ziBAN78L4=
Received: from CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:179::5)
 by LO4P265MB6170.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 13:41:30 +0000
Received: from CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a58f:5b1b:89bd:4f62]) by CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a58f:5b1b:89bd:4f62%4]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 13:41:30 +0000
From:   Chris Pringle <Chris.Pringle@phabrix.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: MFD ASL for KEMPLD
Thread-Topic: MFD ASL for KEMPLD
Thread-Index: AdiozwPse+4XCDExTTOdRTDKAJ3e/w==
Date:   Fri, 5 Aug 2022 13:41:30 +0000
Message-ID: <CWXP265MB45086577824516B96F8DEB4CEB9E9@CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phabrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 892df1b5-6538-468c-ed37-08da76e83437
x-ms-traffictypediagnostic: LO4P265MB6170:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRiCIIE9UYvELRyLhHGKWjOL69x70mnnz82l0XX7ayh5t2+FpRFln4/eYeHxzAtci38hawyj9jkyRRnBlwqIErMBMpu20/ueyU5pWhUJtlcAj7ZO/SlAJYY/O/ayhFloQhKQv+6cVKfB+bSsc1nf8P59qaIJhWdRmkVE4kyI7lsffTIivQ3SGczTYBv7WnZf/2H9nZ3w2aJyTl56KyDg2AtOJyWYRkpDDWyyG3trFdyEeBataX6z2lPXvZ4LuM8+1pGiZnZEkqlIKXSuli6frwBp+gb9jYRnOpfGio2IzdeLi0QkYx0W+qMURB9XCsrHgX3O7g02dxVJHt+nZWP1QmsHT0jBqsnmQOU1nOJSamjU2oVfE1zS2YTOH16LR33wgHrhAFSW4zJyXzHyDJG83ROGv0BBUvPhgoDsZEndow9HEPYruIcwqn99FOo93IEXwhkVWxwVPB0XUX706A2/+rgmmuViSCPAMoHc4vk2bZ5FePEdsvTgnzRf9ppqLM0/hbXsnuZ2X2IrJjiURNmd5kEEbXeZ5N/m0c6lKPVj5aEj4zmbIm16ACkrvvLg7EGpatj7MMkG2nvRiZhoeb6evrsOAO6kN1qOvwoQdiAXN0yryddRIzNQ1VqvYXquuGKsL6DlNzxyEvjrV7lkKaYFoJPrY1mewEy7EHmOQqsTO7Z7NMfn3wfrpBzOSqM4u1Sqqiqh2fvwbUn9hNIu1dTRA8J+6IHGQtQEryuaytxeLAif+/KLMfRtozfPyGTqHAMZodwapht+eANU3bOcNjfbCLiseCJ6J/MN9yJdUvNxA6ntsEF2JGvlKseRqc1GTowU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39840400004)(376002)(136003)(8676002)(5660300002)(64756008)(66476007)(66446008)(66556008)(76116006)(316002)(66946007)(55016003)(122000001)(52536014)(6916009)(2906002)(3480700007)(8936002)(86362001)(38070700005)(33656002)(38100700002)(478600001)(71200400001)(41300700001)(6506007)(83380400001)(9686003)(7696005)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bs5/ZOaJ+2PKfWW7I1iqUQRfdqpiOAP2N00niUwY9n0sJJ/XdxX3ycE60CHJ?=
 =?us-ascii?Q?yKNsjEHRVJmQL6D2R/1lfOgrk7oK4B24i0qlGR8DBe/0GQe1MQQId703S4de?=
 =?us-ascii?Q?a3uG5BbPAcPrE1u96Myhek35t/U1KxS4QlpbRYs2O/gzkOinczS3zl7jb4hv?=
 =?us-ascii?Q?3UNbJl0+9ynZ6x3fceksSOjhCiRnMbhxQxpUnf6TGQLhWB+dGumWzapnZZBF?=
 =?us-ascii?Q?oZ7Ml5TmqYF30W/zeIVqCRUWhWNc9KE0O5ui/063Whl9n9e76fe4quxzK2Gc?=
 =?us-ascii?Q?ckl9g7kk4OxIIYnYpFASQLJxMTCBEsoHA/rMJoAz1otZecTAjH9115Nd+3KA?=
 =?us-ascii?Q?O9xYGkmcQ9zNsS7MBjbSTjbY+6GNyee/McPq9N7Z/gpd/wZ04atEavWmOh8C?=
 =?us-ascii?Q?JBHp1PNKO/H7ZtkLCv1riNW4vI3HeFD6gvdrlNTk6ebAxi3lWR7T4uOCdr3E?=
 =?us-ascii?Q?VO4fy6u20NT69/SEHh0klT7LgHsPL4e4Pnxd/yLsfKTSGUzrZJCjzWvCIIvc?=
 =?us-ascii?Q?/RVf6M5bnVmcTHrTTy5PUYL+iNVR8nDTFwTx2m2r3fNydkwlGfI/5yEJTQon?=
 =?us-ascii?Q?rtJCntjc45T3LCU6l3x6RsqdWzxqwMNb3yQWU4g/snF1CX2GyvkyDldo8pee?=
 =?us-ascii?Q?afw2KhL7PBkFJzwDR+UweTWhRfO5rCsbocLipidxoIOkJJ5UCVKUlwfrLMcU?=
 =?us-ascii?Q?4mWtDNSluJz2F0pHU2OSwFKKFe1aofR3oxI5Is76rJMsoG2I6r+xKKu6y6+G?=
 =?us-ascii?Q?cL7SgZK+4mgrxzovyYk7fIMwn0pWAKHki3ztaqU1HDlqQ/346QJ2L6R/06Jk?=
 =?us-ascii?Q?Dlg2dfh3TSkIi0otU5Fdwy6rs4pJZmJp5Xpge0YcD9ZZ1i37FxUWiHnMA/rD?=
 =?us-ascii?Q?42uBe3juUhYNAI3zgJF7AYBfwIRy4b7ZTRdnK4G33qSQGsA7d8R2NXR6EWlY?=
 =?us-ascii?Q?RM7YNdteOpM8mOcncTHory47MbW31hVGifWXH2wi1pY8n/vXyRrHAp2wJW45?=
 =?us-ascii?Q?XP+JJ+YP/BcDBSFChdu3il6sQSByykM8/7tMCced/svh1A8Z8o49HCRNrf/x?=
 =?us-ascii?Q?InwiOlIiAGDGqIH1IAlITOSvSjPQQERWMRQCLJxjG++AlPQ/bR1WcMmLrvlD?=
 =?us-ascii?Q?zSwQvY6izl6xUWV3hPzGuNbekWsSrgq8gxPhq3UWWWeyZqWw/21NmZWukmGm?=
 =?us-ascii?Q?5IekL/Qubb+JZnN6P8mBpft+EiT5vUS0nqFsr9f8cnM90q9gEVNWE3Ym1jVD?=
 =?us-ascii?Q?lMEJvomDWTPN59dvro87bXx0VAR1UHvihG5+coWeHV+cDdMpp2z3RwbG/nua?=
 =?us-ascii?Q?1dn/UJNHyJvrGpvNootREWwD7TFFxMnghedJSQkE69cJNOFVuNO0Svg8ugt2?=
 =?us-ascii?Q?L0I4MX6gXDVLyjOU9vFDX5/mn9yOuSIYXV0wZRCVA66u2tWQDs3L/5GYPPFj?=
 =?us-ascii?Q?2thbpe82ogDg9G4/UyBljFbYJj+Y2B4XKaAVwYMwhVo12+XkOb+1EhJJnd+5?=
 =?us-ascii?Q?WRWOmJopLPHvVBlUtxoMubN/Hvj0ZCfpDCzEyuhSm44hb6m19RzYlgM78WHh?=
 =?us-ascii?Q?vSf8Ui78ME4Fa0Zs1q+n2rm0YkBtwjs3cT9+TCud?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: phabrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 892df1b5-6538-468c-ed37-08da76e83437
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 13:41:30.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20a0d659-dc6e-4307-9c1e-97f93b0e3d90
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irFXvry4ZOkTRXZ8R5UZdJs1tYeBGJDECJ2kxTeNaik+8swRiQhWjJDsrqQoYDfDKILlDayUAf198+KoaVQXzpDYF9iMnfgBG9x0wrhtOjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Folks,

I've been trying to use an ASL to help me add a bunch of I2C devices to my =
platform; to start with, I'd like to just add an I2C MUX, but have so far b=
een unable to get the kernel to add my I2C device. I suspect this might hav=
e something to do with the I2C adapter being under a MFD driver, but am hop=
ing I might be able to get a few pointers from here to help me get this wor=
king.

I've defined the following ASL:

#define I2C_SPEED 100000
#define ACPI_DT_NAMESPACE_HID "PRP0001"

DefinitionBlock ("example.aml", "SSDT", 5, "vendor", "board", 1)
{
	External (\_SB.PCI0.SBRG.CPLD, DeviceObj)

	Scope (\_SB.PCI0.SBRG.CPLD)
	{
		Device (MUX0)
		{
			Name (_HID, ACPI_DT_NAMESPACE_HID)
			Name (_DDN, "NXP PCA9546 I2C Mux")

			Name (_CRS, ResourceTemplate()
			{
				I2cSerialBus(0x77, ControllerInitiated, I2C_SPEED , AddressingMode7Bit,=
 "\\_SB.PCI0.SBRG.CPLD", 0x00, ResourceConsumer,,)
			})

			Name (_DSD, Package ()=20
			{
				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package ()=20
				{
					Package () { "compatible", "nxp,pca9546" },
				}
			})
		}
	}
}

I'm able to load the corresponding aml by 'cat'ing into /sys/kernel/config/=
acpi/table/mytable/aml. This loads without any errors, and I can see my new=
 node appear in /sys:

root@694b71 [x86]:~# ls /sys/bus/acpi/devices/KEM0001\:00/
PRP0001:00/     modalias        physical_node/  physical_node2/ physical_no=
de4/ status          uevent
hid             path            physical_node1/ physical_node3/ power/     =
     subsystem/      uid
root@694b71 [x86]:~# ls /sys/bus/acpi/devices/KEM0001\:00/PRP0001\:00/
hid  modalias  path  power  subsystem  uevent

Unfortunately, it doesn't add the i2c device and the I2C address (0x77) rem=
ains unclaimed:
root@694b71 [x86]:~# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- 0c -- -- --=20
10: -- -- -- -- 14 15 16 -- 18 19 1a 1b -- 1d -- --=20
20: 20 -- -- 23 24 -- -- -- -- -- -- -- -- -- -- 2f=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- 44 45 46 -- -- -- 4a 4b -- 4d -- --=20
50: 50 51 -- -- -- 55 -- -- -- -- -- -- -- -- -- --=20
60: 60 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
70: -- -- -- -- -- -- -- 77                        =20

The I2C adapter is from drivers/i2c/busses/i2c-kempld.c, which is loaded by=
 drivers/mfd/kempld-core.c.=20

I can manually add the device (successfully) by echo'ing the appropriate li=
ne into i2c-1/new_device, but this isn't the approach I want to take for ad=
ding I2C devices to this platform, particularly as some of them will requir=
e a number of configuration elements that are normally set via a device tre=
e (on OF platforms).

Any thoughts on what I might be doing wrong here? Or what changes I might n=
eed to make to the existing drivers to make this work?

Thanks,
Chris
