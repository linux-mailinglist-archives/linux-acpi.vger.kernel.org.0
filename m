Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010D3424AF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFLLsZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 07:48:25 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:6018
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfFLLsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 07:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCSwASorKE9Xv3pKtKqHBwsvgKaomSygARuHhnoHHUU=;
 b=qLKGCgeTJFnF9jKq2aChIQ9Ar+oZxyFVtyDFMItZTbFP0KLJZ9vPSqw73nToz3Tke/DDqKPS9IxDfprqo7kwPa4k9gnQ6xphuJ+orxzh5h/8ACD/GjQo/sQW8zv66HqUx/yYvF0W8M92K9CSyIbmMUHYOgkzP9b6X3Ss3H140BQ=
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.56.27) by
 VI1PR04MB5439.eurprd04.prod.outlook.com (20.178.121.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 11:48:21 +0000
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86]) by VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86%7]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 11:48:21 +0000
From:   Udit Kumar <udit.kumar@nxp.com>
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Help on named object in kernel 
Thread-Topic: Help on named object in kernel 
Thread-Index: AdUhB80T6nszZCo6R5C7RlLTfZjWmQ==
Date:   Wed, 12 Jun 2019 11:48:21 +0000
Message-ID: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=udit.kumar@nxp.com; 
x-originating-ip: [92.120.1.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99f414a0-9ccc-4213-05d9-08d6ef2bde98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5439;
x-ms-traffictypediagnostic: VI1PR04MB5439:
x-microsoft-antispam-prvs: <VI1PR04MB5439D7A95E3AE57A859B117491EC0@VI1PR04MB5439.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(4744005)(7736002)(66446008)(25786009)(316002)(33656002)(6916009)(4326008)(52536014)(4743002)(305945005)(44832011)(8936002)(66556008)(64756008)(68736007)(53936002)(71200400001)(73956011)(76116006)(5660300002)(66476007)(66946007)(71190400001)(54906003)(99286004)(66066001)(81156014)(8676002)(9686003)(6116002)(55016002)(6506007)(3846002)(478600001)(74316002)(102836004)(413944005)(476003)(26005)(486006)(86362001)(6436002)(2906002)(186003)(256004)(14454004)(7696005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5439;H:VI1PR04MB4640.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JANrk3+8DCx/XCFf0b93i+OMgzgmvP9WxwUzlIln/Iw5VVpplD87Sm94XgRxhGc9mDBRq/aFBoJDYusUdMHZBb/J6B+z7l8l3Hj5fpCcmFx0waRvKz38Bpzqq9kzJRya8doT8jdiRGud8KmUSp31/bumP7vHTnD7+zfey5DE0B9bfIbFIWDNPipCaLu/I0GjxjZySsDsDfOCsgH0mhYDS6MVyIM3Y8FJoA0k5Ndv2OvbyxmKvGqc4IKqEaqE/XPIsndY5DszLXOnzWWMeuE6bNCBS+bLh1fOpA9DjL/3KQzHJsamhpSBAcQfY0ZUQiIOkq6RbbcGVZmSwpTiO2Ox8dmTnIJVsDrUu5o5LGQIB8NLJHvoyqQQ6RXw30wek2aunXSkXc1ZGrW0EUD6C9hTbkkqn0X9Q01/LrawgFMt2WE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f414a0-9ccc-4213-05d9-08d6ef2bde98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 11:48:21.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udit.kumar@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5439
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear ACPI experts,=20
I need your help on defining named objected in ACPI under _CRS.=20
In my firmware, I have defined two addresses for my device using=20
Memory32Fixed and QwordMemory under _CRS. =20
These  two addresses are 32-bit and 64-bit long respectively.=20
For Memory32Fixed, I gave DescriptorName name as REG0
and for QwordMemory I gave DescriptorName as SATA.

In Linux, all of resource of this device is added under its name=20
(NXP0003:00).  Reading r-> name for all resource of this device=20
is giving name as NXP0003:00.=20
So I am not able to use existing OS driver using call=20
platform_get_resource_byname, I have to use platform_get_resource
API with index to get above addresses.

Could you help me, if there is way to use named resource in acpi.
Fyi, I am on kernel 4.14.122

Many Thanks=20
Udit=20
