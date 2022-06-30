Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C5561AFE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jun 2022 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiF3NIZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jun 2022 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiF3NIZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2022 09:08:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7376D11B
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2022 06:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uiozba7N8sjJ2Q6mPFH4zx6d7p8viwAYyKbskZmGE+k2ZNFFv1XbzPJm+XkT/DL+3vCxgz7hEWrskMjLWH8HFRumWg6rkoObkALB9+iqsuig4Up3U9HbVly1rqqzyM/n+EI44MXxf5Zu71oVdT+OOXLr/Xv8YEZyC6BvHXIUMrPFTaihcV7TMFZy826iot1erwoxYSTOSCYfNmUCrWMSStqqHgbUzeYTA4Wvs5Kxt8f5m0PKCfHwPgzVgwe0Jdv+NGX1im8C+bjh2FbmkrKzJ47z6vsKzwqnPUmclOU94O938Q3/yOy+cO1Bx5cVZA+vYQPKV3ogv1tics2AEBN+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV3YF9Jo9BIta02tprfxPtpc3+E5FWQS/woypXk4Oq4=;
 b=XnfItXadqIybD8MG/ht7yODOl1G+y5hsb2hrmIH4UiOxmBBLpR95UzS4RAYb4DD72dJco1F4OGml9R1qAUnB7roRf69Bsjea0cIKc/wA/fx/0p1lRbUQbCBtXJhIQbhHtBZ1FpQ7X5d407UNLze/+7fAdTfh+4JjCUXxRL53Kqi5rNgLzAp5hWTiT5A12UJO4dzIIugZ8va25btR/8GA+YFpZMNId6/TDjnVz9ugtEsq9XP/3KdlGgwwrtN5heTA8mK3FY3DKp8omZ513YVAQDTczxwhp/t/XzOZ+jCDDbEXwYjk2pBrBBpjy8DbEP+1g4oFI+hYMFWyoKLiWKjQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV3YF9Jo9BIta02tprfxPtpc3+E5FWQS/woypXk4Oq4=;
 b=lVhkn2TXm+slpFsNflAn8nQ9J3gh1TOP9Luoj3ciSsFbdZQSyGS67eYi7i/zYXhG9yKPTDC8xvmPiY9pCPEVkt8HNtAQAea9Sx/zq8OO0E72TLkjzRuwPNMA3UmE9NhYgYZRJTEAOyXm90Gr4tQT6s13lkS68C4shLx4vn19rbQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4834.namprd12.prod.outlook.com (2603:10b6:a03:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 13:08:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 13:08:20 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Topic: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Index: AQHYhujxQSq7iG8/RkKTJTkz+FPUz61clsAAgABnMQCAACZqYIAJtRPwgAEFC4CAABiNYA==
Date:   Thu, 30 Jun 2022 13:08:20 +0000
Message-ID: <MN0PR12MB6101D25A2ADDB9AD10AC238CE2BA9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
 <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com> <YrRrwqc69MgpA9kl@kroah.com>
 <MN0PR12MB61012088C50712D48968327CE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
 <MN0PR12MB6101DA54A802A06CDD0618E5E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJZ5v0hsJki1nmpdCe+4tHh2atmPNT_=13ErWD00jiGytDapVg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsJki1nmpdCe+4tHh2atmPNT_=13ErWD00jiGytDapVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-30T13:08:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9851fb44-c0a7-484b-ad46-84ff18b475dd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-30T13:08:22Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3a69892a-0ca8-4a9b-a9b7-4962bbf892f5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da389632-53a5-44aa-4811-08da5a999b4b
x-ms-traffictypediagnostic: BY5PR12MB4834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7wIadl+P29qDmTSJCZppr0cuWJyqR8ApgXHZEU+PEJ8X0NdTbACHDJGADaFVGdn9Q9gE5BbFxEbIfIUFRLX4aGgalD/FJnbn/08mZA8QtlX0PG4JAinud45IGvllfMMmxCjBKLevalwlnM5aKqvkAp7HB/HhuRC+ZhylCdriuMJXz6dbc8VqsNxKzr60p+xqsxwkwyM71SCoB41/+iT2Pu/ZWOOJ614IGojQ32LZ+GXA9SkNDRSWNgn9IjLyu3+nk7Hxv3Mzheo0SQdedYNhhBtYfp/I8jUSzGOJm5q2DoQvjz2T5UA3qFKsFiqFGfTlkYVW+H2wy7DGhPcBhajAHLavsmUhWbxdyguiEpaN9HPvzkXdiwMn+7h7hmDTk9+urSeAPXyschsUsN5P05WPOfBFd1+6wVK/kO8/H0M2Tu9PR6Lz+q9KTsA1au6A47/57HynS9Mpa3aqmXve3d0j3SORWufMXGIPCTM9JTnqlJ2N2yZd9p+wCVfPMOKPxeAsqcbaZyZ4XigpiZPgrRmdgbHdPeNBb6647FlBedY2RnR0bv6YzYuXCe1hFNEif2WQxhXtPu4PPVlCqo6az7I06GcocGl6FvuxNRxHX37MRefmcrnuG/wivaaoNveXvX3CZSOSslBTk9/meAHLsZWrNdh8btD923t/pc9+VbTVCEA7Ns/rgoclqfZstJucedJgJkG4cv1shE0XgH5vCvpAfhH6PYaM1zgt4zJ/jxT39tFtnEsSdL7QCOi3wuSreInstcXQoA7i3fxwBGFJQsx28EB5ZGa8CfGjJKTgDJJQJog/6och9k3AhWuz7pSeCLjhLdMIyc0cHFSdkzn4KeAsXm5eAs/PKEgRYCsJAot+C1rDduLyGoNiKgHn+p7UmCbE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(5660300002)(33656002)(38070700005)(6916009)(55016003)(53546011)(7696005)(9686003)(2906002)(38100700002)(186003)(316002)(54906003)(83380400001)(66946007)(66476007)(41300700001)(966005)(66446008)(122000001)(45080400002)(76116006)(8676002)(6506007)(52536014)(478600001)(86362001)(4326008)(66556008)(8936002)(71200400001)(64756008)(26005)(26953001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OW1wNUqo1APRyAWbsf2J2BwBMHp/Xt9fCnyiDNVKpUJqYFTO47Eh/MXzi9yp?=
 =?us-ascii?Q?zdL4M9bmgnqjjygItzA5FqxYKTlIjPngVImZ9+cAXPyZHpBkm9OApaPatRxE?=
 =?us-ascii?Q?15elizl/jON7sS6bObKBf/TjCwgKORoy88Bw1nnO+NvaOQdcyGigfePXGI5i?=
 =?us-ascii?Q?uj0rj+nr8izaY3S4HzJw4wEuYmt16Dcx2Rsd3RJ8bcnFhH0VLfFCaeSpAmKF?=
 =?us-ascii?Q?OxWb1CA7Aa6qUd2V61z2jcpEEkFnVanjBqjcQOgrZIkLnIx7ktEIBhPcwdok?=
 =?us-ascii?Q?zxQazwSzH5J+MWfahx24Ev8kg4EBhPsejwhOGQlG33RLY7nGjXN6Lvsjejgn?=
 =?us-ascii?Q?/H8P1Uph1uh9Z0kfHzsGpRXVRcHEXvPI1rBe7gz1nv5QAHcwT3SzOqNHPi9g?=
 =?us-ascii?Q?fZT7vOPSaw4PjxOdFf3X7ZhwJo+PjajnH5T0QICr8pCW+rEE+YzGFpD3tQ8I?=
 =?us-ascii?Q?rIdFYU9eL3+46aDPOJQ0OnAqz6lsV/Oq7gfBac4cp/A5Vn+4rqstQomotJpJ?=
 =?us-ascii?Q?MkOoHYhkX2mGPdaWpbYcAff5G6s+WVYuCbzxFrcG3lHWdrfbUwFwQnUpiKHt?=
 =?us-ascii?Q?W8K3EYZAZOgd65tHEnYpBEczE/vSvrNP483vBBZedcktLqDQxbBIeqADx5db?=
 =?us-ascii?Q?Cm4Q/iAzj/wiDxXgiJ+ZzQvE/D7zkCFWNOQjEGO9ncbhOS5Ybe0oZlNb7G6E?=
 =?us-ascii?Q?FO1muUeaWdmRjy1j3qhJ1tXR1dsOE4jsgw+FaJBOe1K7xO0MSkeGJc2xNjdC?=
 =?us-ascii?Q?AnKugM0D08Cp0ke0+qQjXXMyPQhBCwwa9s7V+3llK83+9X0xgPF0tDVfid2x?=
 =?us-ascii?Q?o2ezaXNICaUzGNnPMU0YKgzoEGhae9/ur08xojwB7T0B60f2Zt4phqq5J17b?=
 =?us-ascii?Q?YKKqgHi3uBkSq/2/i3wzg/Dlp3LEmBUUoVfrVv/URmEwK3f/9TtR8ty0QgB9?=
 =?us-ascii?Q?VfJBMKCIyVLUs79XRN98SEmT3Mrc/31nALB1qhcjq3u/9Zi4VnkqOb8LLlAS?=
 =?us-ascii?Q?cBG/yQfm82fUiSkIit6xY03V4gnlbA77K3qcL0co6y+lErh9NjJNyuhXRU04?=
 =?us-ascii?Q?afKI+ifogu8PJSzCRS57/Wi2DebU2xa6nrbLXRYnNl1k+uYVVkrrdzrZzSCz?=
 =?us-ascii?Q?eOIZyB0DIEnCNfD3rrW5c2c/lU+1PqqJXpzRpGJ4Ul6N+sm2rJkzWe1NLGBh?=
 =?us-ascii?Q?+7jApfYJ9p9pGpsrTqGjFV0Rjds2+T+DtrFh2AC8zSJyhNosJArHY43eVIoX?=
 =?us-ascii?Q?RRLkikfWzlnQk0G0j7fxmiMUillcgOwQ82550Al7Ic2BMIwzRE6op4ad/WAB?=
 =?us-ascii?Q?BHncIUvb6x9XpxxaqKMQD3WqjdpCjVwQMmMNyKEx4XBqqkfWiCwyymgSlwgh?=
 =?us-ascii?Q?YK+V3DAm992n8O7xCRCwkuQaHJNoOwwAkgcmbd/yu7r3zmKZsUCFSAsZCTJC?=
 =?us-ascii?Q?nvLgC/TVXCsI66bAd5E+w60noyvecPyUFonfE4txBBlHrI/vnfFegTOTd2dm?=
 =?us-ascii?Q?8zhBU7uXSazeTfqATVxzbPN5yFSIpAjtGmBYRNFD6CaSJh9JlFiMiAcifvV1?=
 =?us-ascii?Q?7eJqekBNB42f4qwWO90=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da389632-53a5-44aa-4811-08da5a999b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 13:08:20.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KYl+rgHbSezW1x09Krq+Utr+MSUNEaNfHfjX6arUtTQsvchBc8LIQ3pF/WF5dHexPPnM2P+gX89ben7ZQ7NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]



> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Thursday, June 30, 2022 06:40
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> <rjw@rjwysocki.net>; linux-acpi <linux-acpi@vger.kernel.org>;
> regressions@lists.linux.dev; Greg KH <gregkh@linuxfoundation.org>;
> rui.zhang@intel.com
> Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regard=
less
> of the query flag"" is causing regressions
>=20
> On Wed, Jun 29, 2022 at 10:12 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Thursday, June 23, 2022 08:34
> > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> > > > <rjw@rjwysocki.net>; linux-acpi <linux-acpi@vger.kernel.org>;
> > > > regressions@lists.linux.dev; Thorsten Leemhuis (regressions address=
)
> > > > <regressions@leemhuis.info>
> > > > Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC
> regardless
> > > > of the query flag"" is causing regressions
> > > >
> > > > On Thu, Jun 23, 2022 at 07:24:34AM -0500, Mario Limonciello wrote:
> > > > > On 6/23/22 05:06, Hans de Goede wrote:
> > > > > > Hi Rafael, Mario,
> > > > > >
> > > > > > Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities =
to
> the
> > > > > > _OSC regardless of the query flag"") is causing the issues fixe=
d
> > > > > > by the reverted commit to show up again, see:
> > > > > >
> > > > > >
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> > > >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=3D05%7C01%7Cm
> > > >
> > >
> ario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C3d
> > > >
> > >
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7CU
> > > >
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > > >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DKxmNvCfdm
> > > > qvk5gXteXUDXHVTK45yEt%2BUYO4vaBbLXis%3D&amp;reserved=3D0
> > > > > >
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> > > >
> illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=3D05%7C01%7C
> > > >
> > >
> mario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C
> > > >
> > >
> 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7
> > > >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > > >
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DpZRqAG3
> > > >
> %2Bg0QevLOGZ8m9PNxcmkmh58soT2dSLg%2B6qWc%3D&amp;reserved=3D0
> > > > > >
> > > > > > both of which have comments from the reporters that
> > > > > > the error message is back again; and presumably also
> > > > > > that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> > > > > > again.
> > > > > >
> > > > > > Can you please take a look and see if we can come up with
> > > > > > something which fixes both the re-surfaced issue, as well
> > > > > > as the issue which the revert tries to address ?
> > > > > >
> > > > >
> > > > >
> > > > > Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn=
't
> > > > backport
> > > > > to the stable trees it popped back up again?
> > > > >
> > > >
> > > > It is only in 5.18, no stable releases that I can see.
> > >
> > > I think that should probably come back to stable along with everythin=
g
> this
> > > revert went back to, but before doing that perhaps we can get someone
> > > affected to confirm cherry-picking it helps.
> >
> > Users have reported to the Kernel Bugzilla that just picking that patch=
 didn't
> > help.  At it's core it "seems" to me the firmware masks CPPC support in=
 the
> _OSC
> > and previously that was actually ignored.  Since the final SSDT with th=
e
> PR0._CPC
> > is loaded dynamically based on whether CPPC was supported this runtime
> error
> > happens.
> >
> > As multiple people have been duplicated into that bug let's work throug=
h
> some
> > ideas on it there.  To start out I've left a suggestion in there for us=
ers to
> have a
> > try with.
>=20
> Honestly, at this point I'm inclined to revert the commit in question.

Isn't that just trading a regression for a regression?
