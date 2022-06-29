Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86474560AEF
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiF2UM4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2UMz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 16:12:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9552657C
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 13:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQKOCACWhqpVpyKBdkvxln6569eCq1jl2Vaz46jk/XIwa/hOP8MPzwNrLNWAICc8VHY6W8lY4wZxIfPYPrQdjbKTPxCF6nFHnOnJ2nPhpHpdvoZfngqXAov8p4/ZH/zVmq2UqztIixFHOBSZ/g5WlrKw+Xz0yCABVuDtnMPzlfPe6A84gYbVQnoE3ApYxd9mR+8gegidxmsXpqLvttsTenMcHodmC1LkfQkU1dxlHlQggCLsaBV3G/JvrQWhQbQinW+YegQ1uxBIXSkCHT6VIwSTcL+drsu/nqTBnKz9wnbVBeQGFjLFMPisnTk817x83J72efjLmb02ibZSz2wPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv7ookk2pn2kVJ9wc0VllSh9b0fm6YP1XwOHoeKSTKE=;
 b=WWlKPjXY5Op/9WHekCSyQOw2cOur6bIj56O+MylGut7QFaQK3rzncT2IKSl1fPO+aAFEjRTvKf5qNMHcyu7j+olwiNR36s+/6h4sJOJlYWoYnxoGiEB1Y22gaKdNmT7IocSib3woS3o3Y4+ca9Xk9AExH3nPAm+GuzYeVXJ6y1ISRMew8jmlBJgAsH7FZ30pBt9+EPA3JRJJQmizVEQbv4PhpUUYtuyoTMjZnPYnSZfmW3reFMW+357RsKckDF2jZJenb2l1vUBbpD4DdOYNLZC5dsqcAKDGznMk1doGP/4N5ce0gGPYZ8+KhaSUGMcdMnBLraQ0c/xd/oiU3VAo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv7ookk2pn2kVJ9wc0VllSh9b0fm6YP1XwOHoeKSTKE=;
 b=pn1pY1jYU/urijROOnwpNJyyjXkeSwoypAHZMcBcHLXPIyZqvIGPho7SReUv43KjcGmUEdRFa3LPbTP0DaL8QuSphTVwVzS4QSPbkvKQkUp5+az68e7GL6YXyVDwf0YMrFiJLNGk1QCcP3W2jR0ZT1qAykCZMN5dG3Vhk8oaIiQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB2513.namprd12.prod.outlook.com (2603:10b6:207:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 20:12:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 20:12:48 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Topic: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Index: AQHYhujxQSq7iG8/RkKTJTkz+FPUz61clsAAgABnMQCAACZqYIAJtRPw
Date:   Wed, 29 Jun 2022 20:12:47 +0000
Message-ID: <MN0PR12MB6101DA54A802A06CDD0618E5E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
 <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com> <YrRrwqc69MgpA9kl@kroah.com>
 <MN0PR12MB61012088C50712D48968327CE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61012088C50712D48968327CE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-23T15:51:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=770b352e-f1e7-4fb6-94c7-afc99ed96465;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-29T20:12:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 039b3245-16f9-4b10-9057-393d2e25f715
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b97bcf4-ec03-4ff8-833f-08da5a0bbc83
x-ms-traffictypediagnostic: BL0PR12MB2513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpSjIuJHkA7/nuJ66Q+JtD63lhM8de6k8X0tySDG5zF2suIMpppBKFlf2d3CgwlizvWUeCa1teB0HnRRKSrdT6LWQ9AWystNI13K10M0AYkSnBn2xRNnxKp350WxY87lzHtq5ct2c8ozf5Wc/5fKmtf3w5fkAa1EDKtt42zih+IicWXaZboe+ZjU4CwWF+z72YCIIZFwR+1qKEYXDnsm8JqKYYnSiZhtDmD1EQavacZMbhPSEGSfnAWOHLZLIT4BiAAaHR3FVmEq48A/PFepg6AmiHpc1UfaYNPzmAx/0ZoGZDOd98eXS+j2UJamWS+cQ+fOehHzvqdwN0XFCoaBqUaOTZalGiMfUW9MBY7O7pEK6mQHWRXvdBwO2q/Bux6lZaw+Q/zHJcsA9ULwtt/lG2JvKXli6efh18H+8ygvgzBZOMexDoi2Yb9eyaUjHe7b3Ojm0hFmeADDsUHCOCwv2ugeqSX83/QdLwPPlNLoU09z3UJZ8xStcVS849tf+ybL27jkhwfQe55f78rdxetVKGhT/bYqArT3Fcf85oPpyxskA9wwaUIF3JZKx8zk1nYrxl4qjVP+Znhj/aYFSeKvHSY8zExKVcYjmiY0CqHD+csQqZvM7oPfsDPyYWx1ni4QNhObD7o2he7jIFCRhekqcbXKi8hj8TAfgpVP/BgQO3EcLS+1VaIXwrGtouIOSXCdT80gEga1NiaNMTh84Y6ZRL9UDOneAjElh62bToBX+FNUbbBcv6LHhCNMQLHNX1kNo4UBkOEjKSIKiafv54sibahAKZOD7v65m/sDactm9AbvxFpxNjX5CIDiJk6HWI1AWrxtJ+RHEyrMH+8I3yw/tM8/E8cYeHQjhTWEPmIeT08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(55016003)(6916009)(71200400001)(54906003)(2906002)(83380400001)(38070700005)(45080400002)(38100700002)(186003)(6506007)(316002)(7696005)(122000001)(966005)(478600001)(52536014)(4326008)(41300700001)(86362001)(66946007)(66556008)(66476007)(64756008)(76116006)(5660300002)(8676002)(66446008)(53546011)(8936002)(33656002)(26005)(9686003)(26953001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVZ4/XjV0RGuxcl3M0Oks2ZEA54oDcCFXJx8sBvuebyYVtqg56LgoHViAKWA?=
 =?us-ascii?Q?UUkLUsTQAF69U6O0wtbPHKK5HWln+bMUCOCafrzVfNS5i3ChUBRK1aKpYhBc?=
 =?us-ascii?Q?IfRPT49UeKBz78/3rmcxohoyxLvZYSvQsGEXQuodGQSn/Q4gA6HYnknU6KEg?=
 =?us-ascii?Q?w7D4zC2EGDescmOpgG3pzOCRqcTlRtYvF82f1a//N2T2spMyOnqsoEGVk7QW?=
 =?us-ascii?Q?7aF5Ysy7Ucu4iJnAdDbmpuPP09n3HMItdVBKDQ6p+mSYlz2EMqskIZ0h5IL1?=
 =?us-ascii?Q?7XLok94tePaEbDoo2kaIPIIS7ENYKaubE+OIUZoMJDztHUqgTsLXyfxw2kBF?=
 =?us-ascii?Q?zk9gMp1n+WZul7cVs2fCrmfmG9O0mnnabWYtRcgdkFo0jp5ETAPx0U8LJ4D0?=
 =?us-ascii?Q?RpMrqfNaXL3JkKizvxVJJMN8rAVYWFEXBVmc/g1tLsuvJ580DwqHuNyTz+h1?=
 =?us-ascii?Q?GDLT6gZ7gmKT3+VY/qQf9vDLIw3jNJGgO7VtLgAjThY5BJPfvPy0OWPgdLeC?=
 =?us-ascii?Q?764aK0t6q0aL/OBIf0eCnK9CHFIIeW3a9rIKbEA1774ImWSvbOIaGj5l+xRx?=
 =?us-ascii?Q?LWo8DcpgTF+K0vwBeMn9oN+G40ZXUo2k6isKXSljKZIBn5rvLddEWMepT3px?=
 =?us-ascii?Q?Lu+Zk9w+8/ZYShfkWmMJzoFINhMhESmTGGNpE7gJHhYzQQP9meYSy7smREpM?=
 =?us-ascii?Q?pzb9UdVEWgGSpZxx5gq+l7wvEEorDgk/1RkIimMubrIx/H4vr65/y/YlS+ZB?=
 =?us-ascii?Q?Xj3nMptUwNABIklZHHqwdljrWZLMp/E9hsB3RHAWjcsluHPv0HJlzQ4mwtGT?=
 =?us-ascii?Q?jw8FRKbJo/GHTflIMHvhtrW8m2QIohy/zTgCCpkJXqlfVIY6b67sASY01T0+?=
 =?us-ascii?Q?wb+0zeBGf3sfjMrcbzEDUm6dPO55uIV8L0fJWxdVjoE90GsN2nR1886kLdi9?=
 =?us-ascii?Q?5VkZCeAmSyoI2OTwT7m/pxRpx8vi7ouTxsjKNa8O5lEAkZcYE2h5XKtz1GRq?=
 =?us-ascii?Q?ghYl+LamfB+lhli8F0d+hFCKYcsCLl/QoDkrKB7U+6+yUMKD5TCrggSfMmDd?=
 =?us-ascii?Q?jHx4cQx879GvXMrCng11VL9cvaMddDMNe8zoOhw+01eBZw/I83yyW6eTnOmK?=
 =?us-ascii?Q?RIh0tXSdlt57nXzLVu9GUadofZeIlq6Tm2aQVtFbvBQZUZleWP1WJybFpUhd?=
 =?us-ascii?Q?YPjlsd5EXxcWUEsg+Y71bJEPCz+2HFjnHwoCVyrf8QEfNHKt4IKMd1q1UWRJ?=
 =?us-ascii?Q?Oj37+G5T+7M0r81GZF8vwqlGqlhZy4BByQY09NeTPDQAVlZH8yQwozkHyqrW?=
 =?us-ascii?Q?RDxOtFNUJJzAyKb4lzo/+gKv19dCmQLyQVB/90SQlA9Pm7YsFW26UC4HokYe?=
 =?us-ascii?Q?qdRHk+kkMDMhiWn9+SDfSnw6hhoHzDuGJUtC09ZbBywpOkNDmALxeLwZ8IhX?=
 =?us-ascii?Q?Wb5mjXiBKgaK9w3KTlpp0d+LPmCLctt7h/MuE2CvuiB67iVxTwc1BqJABlck?=
 =?us-ascii?Q?i8x1PlGf9jFWdw49+czWOHPa2k/qGrlnpRkwwwaEhybDWrd7sgz1MKpE1CAt?=
 =?us-ascii?Q?ULHl37tdmzh90rCfAeA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b97bcf4-ec03-4ff8-833f-08da5a0bbc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 20:12:47.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoHIhm/MEg+V4HqO5SbubX7vL1Nnqfk+UnYOB9S6lxDFsxVgoXzzC/2Uczh8scxzQrgYF3oEIPSLtfe5vI8ygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
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

> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, June 23, 2022 08:34
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> > <rjw@rjwysocki.net>; linux-acpi <linux-acpi@vger.kernel.org>;
> > regressions@lists.linux.dev; Thorsten Leemhuis (regressions address)
> > <regressions@leemhuis.info>
> > Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC rega=
rdless
> > of the query flag"" is causing regressions
> >
> > On Thu, Jun 23, 2022 at 07:24:34AM -0500, Mario Limonciello wrote:
> > > On 6/23/22 05:06, Hans de Goede wrote:
> > > > Hi Rafael, Mario,
> > > >
> > > > Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to t=
he
> > > > _OSC regardless of the query flag"") is causing the issues fixed
> > > > by the reverted commit to show up again, see:
> > > >
> > > >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> > illa.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=3D05%7C01%7Cm
> >
> ario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C3d
> >
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7CU
> > nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DKxmNvCfdm
> > qvk5gXteXUDXHVTK45yEt%2BUYO4vaBbLXis%3D&amp;reserved=3D0
> > > >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> > illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=3D05%7C01%7C
> >
> mario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C
> >
> 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7
> > CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DpZRqAG3
> > %2Bg0QevLOGZ8m9PNxcmkmh58soT2dSLg%2B6qWc%3D&amp;reserved=3D0
> > > >
> > > > both of which have comments from the reporters that
> > > > the error message is back again; and presumably also
> > > > that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> > > > again.
> > > >
> > > > Can you please take a look and see if we can come up with
> > > > something which fixes both the re-surfaced issue, as well
> > > > as the issue which the revert tries to address ?
> > > >
> > >
> > >
> > > Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn't
> > backport
> > > to the stable trees it popped back up again?
> > >
> >
> > It is only in 5.18, no stable releases that I can see.
>=20
> I think that should probably come back to stable along with everything th=
is
> revert went back to, but before doing that perhaps we can get someone
> affected to confirm cherry-picking it helps.

Users have reported to the Kernel Bugzilla that just picking that patch did=
n't
help.  At it's core it "seems" to me the firmware masks CPPC support in the=
 _OSC
and previously that was actually ignored.  Since the final SSDT with the PR=
0._CPC
is loaded dynamically based on whether CPPC was supported this runtime erro=
r
happens.

As multiple people have been duplicated into that bug let's work through so=
me
ideas on it there.  To start out I've left a suggestion in there for users =
to have a
try with.
