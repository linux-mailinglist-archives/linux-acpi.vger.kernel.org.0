Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD360C4B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGEUWd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 16:22:33 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:34108
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfGEUWd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 16:22:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwtaDnLSpoVm/Ctopqi/u0C36H9gRMkeOlboaGXujjHJrv4BcDS4ddI3ygOe1X4vuVHNuFwmTAej2ThzEhQy33CRVGS/T2WPabNuveDowXrZ6JOvW/qOSS0LwyL3bPI3bSf34hNqmf2UFLJ99uMjWZzv7BZQaATvsqV1UHETA988IX7/lNjukTOJylcthCWlc5KpJKOXF2kyxdjkomh0Df1wwq3rwjTzwdC5gb7Yi4pptYCdOCLOtIvnY/8SF0L0iw7ar2PirOkCYg9KTn1ShZXVMfJ6Dpinhfd3W/TO3TPHkqwmuBaRO0ZU6CI8d+93+DlouqQBJUMfvYp8j1LINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmQH2UmW3HGDUJpOpAFZVnRygo80FS0AF9+kdZJgz+g=;
 b=LsyjdsQ3aUY+AhKprljSE3nw71v7p+DjB61OlswIbwbdIP0iWVqN/ZY6TyVV7j1Z1LUjdHGYS+LYzqL9AWK74d71mxongb6s2aEO7Jy4pVp/5jump3M2wnkHIBr2NOSB/40TbJJoiRs5CYVobusNloRhZB0MO/fPoR5q8WWLvfb4uKVkIrO85mjMLIuB3yqoyTJLM6T1b6q2TObNrxcTWooMbut6cOWUmk8zJ5YhwgH5JxLpvEyWdN58TiEQFay+32NDpo9iQ0VksBQZ3qKkH1anpSXd7vM/dQnjmU+05Yl83pat9UZC6LgqaHOsfonLCzqfDYPyX73y1GM3+HL1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmQH2UmW3HGDUJpOpAFZVnRygo80FS0AF9+kdZJgz+g=;
 b=RBGBau7AC4kklFoyWMAD+ZCQw3j488FSTb61qjnnJ5aR9J0zaR2+VKen30dE/vuwW2ZNExnEFseee7EwTrfZqDLVImZpcqsToy6GmVkZDLnj0mb5U4J2+3QLZEeUD40Dqy6ssiG2Pfc0Pttbu11ONnyjf3NssclqOlW968XUqpc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Fri, 5 Jul 2019 20:22:28 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.007; Fri, 5 Jul 2019
 20:22:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [pm:linux-next 113/119] emac-phy.c:(.text+0x1d8): multiple
 definition of `acpi_sleep_state_supported'
Thread-Topic: [pm:linux-next 113/119] emac-phy.c:(.text+0x1d8): multiple
 definition of `acpi_sleep_state_supported'
Thread-Index: AQHVM2Xl1qDBK3+brUGHb/WNyMrIfaa8d5AQ
Date:   Fri, 5 Jul 2019 20:22:28 +0000
Message-ID: <PU1P153MB01691005C1BC8130CF34B399BFF50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <201907060301.FFmawuvI%lkp@intel.com>
In-Reply-To: <201907060301.FFmawuvI%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-05T20:22:26.9896775Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2dea293c-e1be-43ac-85a4-824ac3444ca8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e65f9d-cc8a-46b3-c5a4-08d701868074
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB0139F18655413076B430B037BFF50@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(8676002)(256004)(6506007)(81166006)(81156014)(966005)(478600001)(46003)(64756008)(8936002)(66556008)(66476007)(73956011)(76116006)(66946007)(5660300002)(7696005)(102836004)(52536014)(476003)(2906002)(53936002)(11346002)(6246003)(76176011)(229853002)(4326008)(6916009)(22452003)(186003)(6116002)(316002)(9686003)(71200400001)(71190400001)(8990500004)(54906003)(86362001)(6306002)(4744005)(55016002)(486006)(6436002)(74316002)(68736007)(33656002)(305945005)(7736002)(10290500003)(25786009)(10090500001)(14454004)(99286004)(66446008)(446003)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bz1vVtjc1XwJ9rc4riwrGPX314R5kLutQXlx9A+wG3q3ajeOeIM2EOEXw7RPWyX8vlQcq8ZZdSWr/Gvp4iHXqOzVv41pr4i25F3erTU90XABBFcPfgA/3ErBdmu/S6vny7HF6gnHvyGp6B2PU9hcR/i0H6ewNVTHEll7fWFiQApgtWh6mKXVlsoe4N+edBXRBwVj5u1iJVIgNXTtwRMjzLzSx5jNkUZ2QTxTZB+MrafVA47TKgQTxO/HGmC8eB459GzSA7YP+7gVHZJzC4m2eG/RnE2NNBN3iQNOK7/uor4jVCC0Ng3/LVvFeft5NOuCy/nKXpSf083QKBcypVx9k/znYPoo2t5RlSofAdtjaMSZl+Uk7LzZOC2aBpiA12NPg70+Hjg3+YucwSBG0lAI63EQg+5uaqeF7vsKYOWgJvU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e65f9d-cc8a-46b3-c5a4-08d701868074
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 20:22:28.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: kbuild test robot <lkp@intel.com>
> Sent: Friday, July 5, 2019 12:09 PM
...
> All errors (new ones prefixed by >>):
>=20
>    drivers/net/ethernet/qualcomm/emac/emac-phy.o: In function
> `acpi_sleep_state_supported':
> >> emac-phy.c:(.text+0x1d8): multiple definition of
> `acpi_sleep_state_supported'
>    drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first
> defined here
>    drivers/net/ethernet/qualcomm/emac/emac-sgmii.o: In function
> `acpi_sleep_state_supported':
>    emac-sgmii.c:(.text+0x548): multiple definition of
> `acpi_sleep_state_supported'
>    drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first
> defined here

Thank for reporting the issue!=20
I posted a fix just now: https://lkml.org/lkml/2019/7/5/630

Thanks,
-- Dexuan
