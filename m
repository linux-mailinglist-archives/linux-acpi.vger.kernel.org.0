Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938EE4470B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfFMQ4p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 12:56:45 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:12426
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729958AbfFMBUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 21:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIMwPuMxjvdFYKCltTRO+0OJQY+jcG6AbvthDqfSWcE=;
 b=Nb2178YicKIY70yqwKhSNxrKPTPYDMFUbXsvKRsVoyQw7QbwP6wMjpxtfDdq+a4RGp6FKxvkesFqoQFadXFo9vaj1G//3wpwy/Non+QP4Zcr/CxuDWjiwDvjC+5J3FMl904BFKT9m+oR3er2HLIlBmKEeuEt1VNtSRlZeX+IIeM=
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.56.27) by
 VI1PR04MB5550.eurprd04.prod.outlook.com (20.178.122.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 01:20:32 +0000
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86]) by VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86%7]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 01:20:32 +0000
From:   Udit Kumar <udit.kumar@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [EXT] Re: Help on named object in kernel
Thread-Topic: [EXT] Re: Help on named object in kernel
Thread-Index: AdUhB80T6nszZCo6R5C7RlLTfZjWmQANR+SwAADe74AAEVBe0A==
Date:   Thu, 13 Jun 2019 01:20:32 +0000
Message-ID: <VI1PR04MB4640A3A1E8B369240C3FC72091EF0@VI1PR04MB4640.eurprd04.prod.outlook.com>
References: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
 <20190612170059.GA30299@e107155-lin>
In-Reply-To: <20190612170059.GA30299@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=udit.kumar@nxp.com; 
x-originating-ip: [106.215.111.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464aa7a1-89b9-4936-81e3-08d6ef9d5483
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5550;
x-ms-traffictypediagnostic: VI1PR04MB5550:
x-microsoft-antispam-prvs: <VI1PR04MB55504377AD4240B3FE0B718691EF0@VI1PR04MB5550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(13464003)(66476007)(66556008)(6116002)(229853002)(68736007)(76116006)(6246003)(3846002)(99286004)(64756008)(86362001)(66946007)(9686003)(14454004)(53936002)(478600001)(5660300002)(446003)(476003)(6436002)(11346002)(2906002)(44832011)(73956011)(66446008)(486006)(8936002)(14444005)(110136005)(76176011)(305945005)(316002)(78486014)(55016002)(102836004)(4326008)(25786009)(7696005)(26005)(74316002)(6506007)(71190400001)(53546011)(256004)(8676002)(71200400001)(54906003)(81156014)(186003)(66066001)(7736002)(52536014)(81166006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5550;H:VI1PR04MB4640.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I4wX8gj6778hqtfbb/m7/Ow3F+/t8QVjnw0qCB3MP4TANpJRFfOd5HRScA37I5SQGVQA3odzDl15yiRxKli1JV+Cbpzy6WhC9z6SQGOYJR3LI2ctiznWtnC+rhgZM/2IBSfTcC2Q3sCxGh0qHWJVfLQuRldQ2kcoNSbWU4TIZ4sbHk/Bek/MbiLKU/NqCbcJJO5JslFkx+cap2QlwLyAOF5lXdsufhbdWsgXl93padcjpFH/7DwTs7nsekOeCc9FBqnselHI+Y8kxA83FGuFIrDXtuPZjQC/r0A5SkSQuYS/AScDYsSxyHBPwASQoJnF7J1M8q73OoqvXXSgL6OkugCZqwPm69Ilj6Niy8V0L4BFZzl3KNWAJrD0TJojPu5GgXkycVeIqrvVXGonFOb+fZqvVLGdDoPFxZ8UHlXyMDU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464aa7a1-89b9-4936-81e3-08d6ef9d5483
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 01:20:32.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udit.kumar@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5550
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org>
> On Behalf Of Sudeep Holla
> Sent: Wednesday, June 12, 2019 10:31 PM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Udit Kumar <udit.kumar@nxp.com>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; lenb@kernel.org; Sudeep Holla
> <sudeep.holla@arm.com>; Rafael J. Wysocki <rafael@kernel.org>
> Subject: [EXT] Re: Help on named object in kernel
>=20
> Caution: EXT Email
>=20
> On Wed, Jun 12, 2019 at 04:37:09PM +0000, Schmauss, Erik wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Udit Kumar
> > > Sent: Wednesday, June 12, 2019 4:48 AM
> > > To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
> > > Cc: lenb@kernel.org; Rafael J. Wysocki <rafael@kernel.org>
> > > Subject: Help on named object in kernel
> > >
> > > Dear ACPI experts,
> > > I need your help on defining named objected in ACPI under _CRS.
> > > In my firmware, I have defined two addresses for my device using
> > > Memory32Fixed and QwordMemory under _CRS.
> > > These  two addresses are 32-bit and 64-bit long respectively.
> > > For Memory32Fixed, I gave DescriptorName name as REG0 and for
> > > QwordMemory I gave DescriptorName as SATA.
> >
> > Could you give us the ASL for the code snippet that you're talking abou=
t?
> >
>=20
> IIUC, something like below(a very rough example based on the description
> above):
>=20
>     Name (_CRS, ResourceTemplate (){
>       QwordMemory (
>         ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable,
>         ReadWrite, 0x0, 0x700100520, 0x700100523, 0x0, 4, , , "SATA",)
>       Memory32Fixed(ReadWrite, 0x3200000, 0x10000, "REG0")
>     }
>=20
> Basically 2 or more entries of Memory/Address Space Resource Descriptor
> which can be identified in OSPM by DescriptorName. IOW if a device has
> 2 sets of registers/memory/address space associated with it, instead of r=
elying
> on the order of declaration, identify them by the descriptor name provide=
d in
> ASL namespace.

Thanks Sudeep,=20
Shouldn't acpi frame work encapsulate descriptor name  while adding resourc=
e.
So that driver can rely on platform_get_resource_byname .=20
In such way, same driver could be used with device tree and acpi based syst=
ems.=20

I am not sure, if acpi_evaluate_xx sort of api would work for descriptor-na=
me , even if this does it will be limited to acpi only.
=20
> --
> Regards,
> Sudeep
