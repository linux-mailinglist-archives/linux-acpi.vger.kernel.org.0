Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157E142CDF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfFLRAZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 13:00:25 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:28647
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbfFLRAZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 13:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M7bIqrRFaN/ypIuny2cZ65mUwUXP5pD1bS/1lCrMfg=;
 b=hcyeS2Z212aHt+i1Ak787LNyKLhoj1+pvB2H64MmYqC2oULYKvTCVTAae1qoUKJfKhW+mUO1y6Kq7CrSrFQ50dk2SfAn8A4eJsRt9MPbiO4p/2NhJP6C/N+3I4nPidRfBcpTU+VkodCKh//rXub4lzkbv/nNLOunFp1OxHjYirg=
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.56.27) by
 VI1PR04MB5696.eurprd04.prod.outlook.com (20.178.126.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 17:00:21 +0000
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86]) by VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86%7]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 17:00:21 +0000
From:   Udit Kumar <udit.kumar@nxp.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [EXT] RE: Help on named object in kernel 
Thread-Topic: [EXT] RE: Help on named object in kernel 
Thread-Index: AdUhB80T6nszZCo6R5C7RlLTfZjWmQANR+SwAAB47sA=
Date:   Wed, 12 Jun 2019 17:00:21 +0000
Message-ID: <VI1PR04MB4640AB33D6542BF6180461C091EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
References: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=udit.kumar@nxp.com; 
x-originating-ip: [106.215.111.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45216123-8db6-48a3-646e-08d6ef577483
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5696;
x-ms-traffictypediagnostic: VI1PR04MB5696:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5696603DCAA8EF30F7916C9091EC0@VI1PR04MB5696.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(13464003)(4743002)(478600001)(33656002)(55016002)(6306002)(256004)(9686003)(6436002)(316002)(66066001)(44832011)(64756008)(66556008)(6116002)(76116006)(73956011)(3846002)(66476007)(11346002)(446003)(66946007)(476003)(66446008)(486006)(71200400001)(71190400001)(229853002)(14454004)(966005)(186003)(52536014)(6246003)(78486014)(5660300002)(110136005)(86362001)(54906003)(26005)(53936002)(8936002)(68736007)(81166006)(76176011)(81156014)(99286004)(74316002)(25786009)(7696005)(6506007)(53546011)(102836004)(8676002)(4326008)(305945005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5696;H:VI1PR04MB4640.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L73MilTAJx+POBrRgnHWMW79XPnIT+Ya1oMfNxAC+komGBoJ5bWaNZm2NK4XOKDolCN0EgiMwPCBNC6SfTgwnKOxsVe3CJrdanqFmqjKN1auNKqnYaJ2KFBQvA8Q2lBpBTe/DULAr3io2Oyqgxz6V1IqHTW1kGDdGNuS1yqRP86Whc9eSvOxuucUw3+xqbDhwztiuC9ukHbU0Ae/jiVKb0dxRPuoC7U2suqlhLorAMU7XeWn5Nsr5O0PHsrUgPX55MQTxP8+jG6rthqp3g7YzQkexYAwt9QuzUT6irtGx5alMwnnhyPiwswk29Q6I2852PtKO0L32SsG6IE836ODonJjUVM7qpiVl+3uQlLfjSZBCmwZKgN1f87jaz9gBhvkFjZXHTCYiWsLt0rUX2QeYEdaviIt3UNd0/2JO5Uxzmw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45216123-8db6-48a3-646e-08d6ef577483
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 17:00:21.3796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udit.kumar@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5696
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Eric=20

> -----Original Message-----
> From: Schmauss, Erik <erik.schmauss@intel.com>
> Sent: Wednesday, June 12, 2019 10:07 PM
> To: Udit Kumar <udit.kumar@nxp.com>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>
> Cc: lenb@kernel.org; Rafael J. Wysocki <rafael@kernel.org>
> Subject: [EXT] RE: Help on named object in kernel
>=20
> Caution: EXT Email
>=20
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Udit Kumar
> > Sent: Wednesday, June 12, 2019 4:48 AM
> > To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
> > Cc: lenb@kernel.org; Rafael J. Wysocki <rafael@kernel.org>
> > Subject: Help on named object in kernel
> >
> > Dear ACPI experts,
> > I need your help on defining named objected in ACPI under _CRS.
> > In my firmware, I have defined two addresses for my device using
> > Memory32Fixed and QwordMemory under _CRS.
> > These  two addresses are 32-bit and 64-bit long respectively.
> > For Memory32Fixed, I gave DescriptorName name as REG0 and for
> > QwordMemory I gave DescriptorName as SATA.
>=20
> Could you give us the ASL for the code snippet that you're talking about?

Below is actual ASL=20

Scope(_SB)
{
  Device(SAT0) {
    Name(_HID, "NXP0004")
    Name(_CCA, 1)
    Name(_UID, 0)
    Name(_CRS, ResourceTemplate() {
      Memory32Fixed(ReadWrite, SATA0_BASE, SATA_LEN, REG0)
      Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive)
       {
         SATA0_IT_1, SATA0_IT_2, SATA0_IT_3
       }
    QwordMemory (
      ResourceConsumer,
      PosDecode,         // _DEC
      MinFixed,          // _MIF
      MaxFixed,          // _MAF
      NonCacheable,      // _MEM
      ReadWrite,         // _RW
      0,                 // _GRA
      0x700100520,       // _MIN MinAddress
      0x700100523,       // _MAX MaxAddress
      0,                 // _TRA
      0x4,               // _LEN
        ,               //ResourceSourceIndex,
        ,               //ResourceSource,
        SATA,           //DescriptorName
      ,)
    })
  }
=20
Driver code is=20
https://elixir.bootlin.com/linux/latest/source/drivers/ata/ahci_qoriq.c#L26=
7=20

For time being I changed=20
platform_get_resource_byname to=20
res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);=20

for sure sata-err will fail, when I added few prints in platform_get_resour=
ce_byname to print each resource's name and start .=20
I got below=20
[    3.013921] Udit res 3200000 name NXP0004:00
[    3.018190] Udit res 10 name NXP0004:00
[    3.022016] Udit res 11 name NXP0004:00
[    3.025842] Udit res 12 name NXP0004:00
[    3.029668] Udit res 700100520 name NXP0004:00

I am looking help on two here
1) how DescriptorName can be associated with resource name=20
2) is there any way to use resource name just as string=20

Many Thanks
Udit

> Erik
> >
> > In Linux, all of resource of this device is added under its name (NXP00=
03:00).
> > Reading r-> name for all resource of this device is giving name as NXP0=
003:00.
> > So I am not able to use existing OS driver using call
> > platform_get_resource_byname, I have to use platform_get_resource API
> > with index to get above addresses.
> >
> > Could you help me, if there is way to use named resource in acpi.
> > Fyi, I am on kernel 4.14.122
> >
> > Many Thanks
> > Udit
