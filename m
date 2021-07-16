Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68A3CB759
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGPM2Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 08:28:16 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:43684
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237729AbhGPM2P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 08:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2IrKzTy13wpcINrIuQcIDN5wfGxU4emnZsF4w4ceeBlA+hIJS+jQasEmngi068X3ewLMwFI4vaUTeCE5nvMSplBswMJdu7TgvS4aSxNp9D4+oTs3iXC5226oQpEZ9V7RQIbCx9pOkI6BkQXns3Stw9qcpQ1a+WpQmV6MQ1G9gNQiaDQCKt8+tzPoKTitPauFCi5h1m8yq66TiZe6ed6ALMterqfY+Tx7g+P9klgob8duPRF91PP4al5Lo3WN8Vvr2NOqp/4oMl+x9vA24jTYOuv4lguPMtgwGOddq5u1qmZ5jfz0WErZcItbvZeCr7395Er87XnLiUFw0YMBEvrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zogzqIOY5JrKSu+fMvyydXHKCgRgNUnp+uHIaCjdDD0=;
 b=nnVWrAgtpUV8IIVDovcCnqDNl9odmcf+gTzBIuTX+V6MXo3316yMZoLx6gBpb6cGJG98WaZ0MnVaoDfBkQ/NsiHZXu59kiBpE+alSMsbGVgRJqLJwlFjqrlrxpFx2af4H9hBTTsQNdcS+R0wq2j8NsrMLj91GGdkKtB8FHKBfb6w/vbaTLWjNvcPljeGN6Enk5LaYimU8A4BTYAE4N7i9uViFwAFF4/0jKkqlEAxwZf1yWNkuIYCNR4zAi7pCdsTuHibTaxabGJUj/1I17actDjocj84P2nFXfHXT7pdKjTBfgleT5Ze9SSzASRMwl5w5oCzMjy3w+Bb4cYjYZx3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zogzqIOY5JrKSu+fMvyydXHKCgRgNUnp+uHIaCjdDD0=;
 b=jmAncQAoaNZMgjzrRRkPp4Uvbk0U66igFIrF8oR8871Saw5kYKMVufX5gxiFXQMX4ZbSaZ7SeaOxFBIucOVjTE/djbvuClLaGOCq+epJ0AFuYg9q30CUlxccegA62q5TIJAR3BTvpi5i3S3mROR5ZhO0EvvIJe1xAznoQVboEM0=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 12:25:18 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 12:25:18 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frieder Schrempf <frieder@fris.de>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
Thread-Topic: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
Thread-Index: AQHXbeiY39Bsp5+m60WenA6VsK7ZBKtFhwiAgAATdgCAAAPZ0A==
Date:   Fri, 16 Jul 2021 12:25:18 +0000
Message-ID: <SA0PR12MB451080F1208ED9E104879F1EE2119@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20210630194606.530-1-mario.limonciello@amd.com>
 <704855e5-fad4-a002-a16a-1f3fbddbf5f0@fris.de>
 <CAJZ5v0hSZcNf4Cy3fSA4jRjw1J5r5T36NOs9yCTiRksFLmjzFA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hSZcNf4Cy3fSA4jRjw1J5r5T36NOs9yCTiRksFLmjzFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-16T12:25:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53f3dbb5-c71d-4fc4-9c62-9f4507cf1b02;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dd6900a-0d5d-4522-e443-08d94854c5e1
x-ms-traffictypediagnostic: SN6PR12MB2686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26869FBD78CC951CE015B7EAE2119@SN6PR12MB2686.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHxJS+E2aYaUSfpRnFTE9HKTvbIQJ5hPpc4Xf3W1T+AK2Ix33UBWQ/LVrotWNadlJPZU1Gcu9IsiVieiOLiwnATbOL10nIEAxPX1bnVHUXNLO4v/j6Giy0/XfTo5LwIx/49fCFrIQtwjA3W0XF6D5inQHlYb2iGfmL4MRwaw8kGvMFfAcd+NvcvORJI9Acy+kc1E7eFIcWZLBscNanKtBJJIiIPOylG68ajH+abz8JoEQCLbz3fTuuXY/AtzLnvZOyzM9R/5YtrlbraK/IfkMzYdFKJ++QmaloIAUflhjAJUQEpvLl+JDsOLf/1hhitgD2ON2CpjBPxN6gockjDSfth2C8SvbLQW1QIp44+KIQq2f1yzkv8NswIzO3N06HWkc9TdC84dHBKOZUIu3p2yYncPMd1ZUaNjnre2rM7txiijtiIB1IPP0EhqE5mcqXxjEJyi+7cWGINsE91dxW4FqGJzHzbbmR/xvPJznlUU5qgteHUTZetx/fQFMDsIVz8bhYSMS9KIchOMt29Eiw1gA/qNqbyeYSdqVh2UQ6lawACs6KI3PMuM7+P2NerDZwDQJYUjzzy5oMsEh3Rh9ISIJmVdT/lrhXhc75h9BhBH9zGOA/N7d9troGFvZpdt859RcQ8oOMY/JkL8Gs+u7fA8dPWpJUvGk57AjWhgdDYoRMwwrpCb9JQDPnluRoaA7Av0tTpksS3TkhSKH7aVKTaVhOJLcFRRiOPEI6NhWyTCvJ5j2eMDn3QjOkxmJohASZFGTVPshnezR0MqMqRRa6mxT6dBFbUT/9At+ofcwP3BYRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(45080400002)(86362001)(110136005)(4326008)(316002)(122000001)(54906003)(66946007)(52536014)(55016002)(76116006)(38100700002)(71200400001)(9686003)(66476007)(2906002)(6506007)(66446008)(5660300002)(7696005)(66556008)(508600001)(8676002)(33656002)(64756008)(966005)(8936002)(186003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HKCv0HLoauyB98NWxOlvhLq++s3GVnCSfwQpimTGOR5X7S17v+MLu7VLOTe?=
 =?us-ascii?Q?W9GYMghhWC02TRqguQ5UdxMqrs5afUHyBpOFr7DArkNvb0inZLkTGLebsRE0?=
 =?us-ascii?Q?xY3u7vfqB8aKTwI6ZKc/fDnZhiQQGZhsCZekpqxpum3FvmZUzVipTLqhKD4z?=
 =?us-ascii?Q?8RwpIv+h8WM8+Bd+W5QnapHF6acbopftiSXabgbw8jvMVapZo0nyyoxZHfDt?=
 =?us-ascii?Q?UhwPl3wpWlRsqyHBdZsEol8CqOeqDkzb6WU4t5CxNdAWSIHr8c7ycpM6wmlu?=
 =?us-ascii?Q?pPvrjSUMe8jyWyMa8N52Lpxb3E796x6CQN8KEjKdURhQLblngbxGao9Tz4uG?=
 =?us-ascii?Q?JdsuwPzASbSHeZ/bUbd1xylKKtX8sgev4DD6i9Sr0CiOZ8ZpCvBxGGe+69Qy?=
 =?us-ascii?Q?T9/AXNG4NF9fCMVKyzjeT7rV9lELQqOwFeS3cgHL0RdtaeVIv3bCfBg6gBTS?=
 =?us-ascii?Q?ooVPMU3mep/A/AYqaGt7fLd7cw3ASfrPTMPfgGC9pT0L53QiY6SfnjHIp81h?=
 =?us-ascii?Q?5VEG3aI78v1CHL2IIEB48tFXyJ33iJnkQ8SEK7GkDrC7WYC+FlYxRw4IsBel?=
 =?us-ascii?Q?XUfKuT/PsPLHmrEPq0N2i5BgMUu6b59cVwIDHMl0+9tcmD8hhPoK0g1QCqIT?=
 =?us-ascii?Q?9MnpZPDutO0o9UuNTNJNeG0gNGcrg0uiv1mAQiI4LmQZp/tvdbT5eFBQSe+v?=
 =?us-ascii?Q?NgBywLwLONzMs37UyEHiQK7qeOwSm91D+vP+tHCXE3S3yMK1PiImzPfXJtLV?=
 =?us-ascii?Q?C/XuInbl4T8LTA5dLNh/qcPQU61Fs5ANDkj8SkXmFxLWW0VHbmMrsML3A+hX?=
 =?us-ascii?Q?3AYrabOfhmufmMpH417ITo6UmoSjMaDzMRGnGaFVd9HIw3Mg5jg4dWFGU4Fb?=
 =?us-ascii?Q?th3GAqWQQwaJwgjefATsbm1lkP1YKPcdIdDYTtM1YM4ZpspKZ3SxYSiopy4m?=
 =?us-ascii?Q?DmKSZ5q8AIVtnmXQiFPHYk/eeVHyajjCaNnbByPCu9Kev7WCw6V3D4l1asrc?=
 =?us-ascii?Q?s/at+pN//AYlUpcrXOTp4hVGLOBMMWn/dMsWtCWKkdbEgsk6wmFiyPTZtu8Y?=
 =?us-ascii?Q?HHbQCKTGmd4G75rlZkLdKF4CwhUgZWyaMkShXjkD19sJCcQ1eNn6qtLpIpS/?=
 =?us-ascii?Q?YCpkcyhY2EwNr2RuFUYiJeWI2uvhHZOdvbjDo6I8e9emedte8RS3fC2yBpKL?=
 =?us-ascii?Q?o6snu9rDS6CkzKR7h3wH/FON6LZOsKqJ9i9YuRwkUIiwCi2j+vXduZevbhAG?=
 =?us-ascii?Q?jW5RiLSqMJVNV/y/oN8uCyJq5NvX1AusnHwkocyXfAT8bporobzGA7qcz1L3?=
 =?us-ascii?Q?fB0OFDiOb08gjJMr0Ut9dQkHik+NRkrMg6ljwOythDXiegwCXkKoekQeCulV?=
 =?us-ascii?Q?kN0G7gMGEU4D2UhR+KpOqj40LtGx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd6900a-0d5d-4522-e443-08d94854c5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 12:25:18.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjmkLBv7oI9kX6Af6yvBQyUgK9JXqX/K1HtPeh2s0h8w/xqw3Pto+A6mUHFeNzO9kQjy7UwT6KV3610jYwo45g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

> > > These events only occur when the EC GPE is inadvertently set as a wak=
eup
> > > source. Originally the EC GPE was only set as a wakeup source when us=
ing
> > > the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM=
:
> > > Set up EC GPE for system wakeup from drivers that need it") but durin=
g
> > > testing a reporter discovered that this was not enough for their ASUS
> > > Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
> > > Marking the EC GPE for wakeup universally resolved this for that
> > > reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC =
GPE
> > > for system wakeup").
> > >
> > > However this behavior has lead to a number of problems:
> > >
> > > * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> > > sometimes the power button event doesn't work.
> > > * On HP 635 G7 detaching or attaching AC during suspend will cause
> > > the system not to wakeup
> > > * On Asus vivobook to prevent detaching AC causing resume problems
> > > * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> > > * On HP ENVY x360  to prevent detaching AC causing resume problems
> > >
> > > As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-
> 8550U
> > > that don't use intel-vbtn or intel-hid avoid these problems by only
> > > universally marking the EC GPE wakesource on non-AMD systems.
> > >
> > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-
> pm%2Fcover%2F5997740.FPbUVk04hV%40kreacher%2F%2322825489&amp;dat
> a=3D04%7C01%7Cmario.limonciello%40amd.com%7Cc2ced5bd6bbb4e62e9ac08d
> 948525197%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63762034
> 0670859712%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DoUsKS5mjAa
> rc%2FhnnY%2FILZWWzUbvdBQHlH1MAcusHSIw%3D&amp;reserved=3D0
> > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1230&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> Cc2ced5bd6bbb4e62e9ac08d948525197%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637620340670859712%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=3DKKUiOSeAQEkFjN9X8y8k3sC3J3s48faaNLzklPO12as%3D&amp;
> reserved=3D0
> > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1629&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> Cc2ced5bd6bbb4e62e9ac08d948525197%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637620340670859712%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=3DkDGTIkQMh%2FGG4OhssvukJ7xJ7Ld6j6bl1TXRvpS58%2Fk%3D
> &amp;reserved=3D0
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > As this seems to fix quite some issues for the AMD systems, is there an=
y
> > reason why this is not tagged as fix for stable? Are there any plans fo=
r
> > backporting?
>=20

There's a number of other patches in other subsystems besides this one that=
 are
needed for successful S0i3 on AMD systems that land in 5.14 but are not sta=
ble
candidates at this time.  Perhaps after 5.14 is out and has been well teste=
d it will
make sense to send the whole remaining series back to stable.

> If you need it in stable kernels, please send a request to
> stable@vger.kernel.org to include it.
