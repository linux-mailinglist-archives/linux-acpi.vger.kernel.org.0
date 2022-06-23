Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294E557EF3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jun 2022 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiFWPwR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jun 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFWPwQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 11:52:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9643EEE
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 08:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcdrgyLY6DFi74hP6MXNP1X75YpruxekWRp2T8kfGyGh+HWEd4TL4lHZCxSm4F0RaTb+PIIlKNiWVVXkek0/f3dMNarLM2A4hRADo5hP7ire+86vKhm1lwO0oREl9VKg6i6CL4mn64aqoPXGnoQAFKjQsMWWG4XfXNpbQoPRg4iAl1XzCkPBnhtGN5Qc5wS+ax7huwpuKwHxyEcybo+HB99e/qdxEzJUO5nByqEtjrUJap1XjSKyNLfxqoe5y6HHtigSbntEWeiRcOZ/NFv2wcCRRUAosYTIs6qyCH/sHOzabBSERcj1KXaXFt7vEVvGr/+VAU7vouoock/whQI4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkV63zFkW3u9ysbR1jr6oLhE0z+xwp6lFIWTr5+11mA=;
 b=iUuPGOfKE0gfZ1nDgY4hr/2uokXXksS/ZpBtTCxZf0IpSG20cTMKyIifwE0nQ7Z81U21f83uTAU4l1GrOwJdflSMwMR8UhmBEC1M09QNlrbZmb4FZ0c2mKXBctIHbwMJC7FYzkHCK4dg7emyaKzmsDtZmTQPokTqny+1sw91PuktilQWCmbHPBnq/F7Rf2fU5/dKB8RE4T8qBxkOVFWfw7+38Ytx/foP86HnibcNAxendmjqIIn2vu0FBOCJG3nfhUmfXsrGVvmPJubw6ZDfL8z6oC+VqZ2S/+cMXftOdzGdITa5j0Ur1y7vIxc5GDYJXAZNPSxRucs7JJJTZQud3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkV63zFkW3u9ysbR1jr6oLhE0z+xwp6lFIWTr5+11mA=;
 b=jESjx0pgpyDNaln8EGFsSdFridmku2yVvMfHrxbfSspoJgPHiPR1QrABZw/ThGtiJqFXY0M3G4jJj0iMIWq1QOSZE7gu3fqapiq2PXt6yrf8hKBlJt2aeahWc/nDte6G5MHBTrbiJ86Kyh1zcCGie0CIkpZqo7eniK4YyepQe4w=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 15:52:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Thu, 23 Jun 2022
 15:52:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Subject: RE: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Topic: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Thread-Index: AQHYhujxQSq7iG8/RkKTJTkz+FPUz61clsAAgABnMQCAACZqYA==
Date:   Thu, 23 Jun 2022 15:52:12 +0000
Message-ID: <MN0PR12MB61012088C50712D48968327CE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
 <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com> <YrRrwqc69MgpA9kl@kroah.com>
In-Reply-To: <YrRrwqc69MgpA9kl@kroah.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-23T15:52:10Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 13d5fae8-4528-4c94-9e7b-efce9036d9a0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3172ba81-126a-4b43-3a27-08da553056a1
x-ms-traffictypediagnostic: CY4PR12MB1814:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HroBJFsjkS/vFIdstQJEMYO8PY2YAcN/NqcXexXMwv1oAi0VngJ0TaC8n7ZCrBmMPK01BHmoUo8zXXaRT9MtfpnH4QIPoogKCMwOArKSvGc7PwA9DdL4GKAkbGlnwHEKxJrpixxlS31lxSfruuMfdhn0OBJsJncso/GiTMvnbUZQ0fFDOGRiRwlo+rvaaoOdalxfnDOB+OCJ5Kns55KIac75et2aFXaHqXbJhpc6y+OYLDXHRYpD4vsjYkDIB6q3cWbTzTgL4ahmh8lcc/CE+EaLv0yI8U48UfjvosNcrsvHAruZ5MQQyEJ7h/K8JaUC1lao5paWzt1ZGMjLHOCMv5TPoTfcZ5jFjEyQ/UBvzwYqS8hiVit9PKbJ5aU6v95BRNje87+AqaHyfG/PGrZQSsC5CnqU8rcbSdlLZ+N8ADfPQ10Z/JSSMjxlBIRvISSHpeMLaVQ6HuLmYNGxTV2IZ8KXJp5sm2ydx1ofiBf+gWv1+r8yAAV8YsanlCJ9gNHGkdy+cM2RoIHwGWh5kmyF9RPTN2fHe5UpTTJ5l2pgSPIBkIHyUy7B4lAcijirUHCiH6thiA+x5OmZedkqK9Anyvx815hncTNGLMw69f0bUt8lFmW6eSr7rM6roTOuOlln79mZj37CYCU3l8/0gp74R/ItGA91h01mTtAWJ9Zz4+WwhC1VxUeZF6yvoafXIkF32lB2lPHWCcDfDYyov4UiN8by0A7U065FbLq2mURXCgTa7buoJ7WI5WrJr7A9Uqc3EOOVl3bPE8h/4zOXV8Xc5TEVf1KkHulmiCCDXjpjWD6fY2xjjPhKg+kok5pQnMAv1s6cWhMy5rCcj7qt9TKiMgP15XlLcWMmMweadcFHpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(5660300002)(66556008)(38070700005)(53546011)(55016003)(86362001)(76116006)(66476007)(71200400001)(478600001)(8676002)(186003)(4326008)(41300700001)(7696005)(38100700002)(66946007)(66446008)(8936002)(64756008)(83380400001)(6506007)(45080400002)(966005)(2906002)(52536014)(54906003)(9686003)(6916009)(122000001)(33656002)(316002)(26953001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8pqjtTdSux9NptKAFmG2YXZDj0+6+KBK+AQZJv37bzHsUtdqLGpeePyAlEt+?=
 =?us-ascii?Q?SrdYYI79rPQddtr50TS0ayjrBDVQtAkZYW3ikAQF7dSCStt5BvjytC/0xU+7?=
 =?us-ascii?Q?6aiGaxgp2TldPsFHcJjD06X/lhn0p0arQetiIVLM6t1cSQC37V+bDsAtba1H?=
 =?us-ascii?Q?on29jgZMwf/NH/sQ0D/eBZrGZoTuTruomoETWhj9W/laLLDfZqljsMC2lgsN?=
 =?us-ascii?Q?GlJGbJYsU62tWywIxX0She0MicT0iaW1aVSWBmMClH9vJUlozDGvvego3J5V?=
 =?us-ascii?Q?Ki6lCZz55+p9BWWK3TLZ9i1W9evTMCqEwiipeLiGDo+fvWZMT0nut447+mWc?=
 =?us-ascii?Q?FKqyK6lvBLXen/uGD6NAKoUBLtysya60qtKi93a9xN7AU3VKg6Eh6CjOwV+f?=
 =?us-ascii?Q?nA1/b702iJbuRaZsNhil+kaD24AZaCGRLqnv5gtRbAKDboq6Uwz35rgvc78A?=
 =?us-ascii?Q?/6fO/Ui/WcIcX3aPB5lHOb78r9+CoDRbbXg056X1nrDMBoxLnOg+YKG/eWY1?=
 =?us-ascii?Q?9B24lo1SEiVJ3kIiW9bDdtsB/ngSBusON3+MeaSlfQQg/Rhux/KZgfTMCHNk?=
 =?us-ascii?Q?U8lX0tkRn5gocF6EF3GBzBjU8jdjCyzDVKcVXYHhTBOCNZWKUpobrdM3ArEx?=
 =?us-ascii?Q?jL0kHp8NdDlHa+t01QUhiZ7SiDKYZnkZOXQmMnh7A3IpD3xCvj9MVJhJtt2i?=
 =?us-ascii?Q?itcDCaOh46JjFsmcsJsGbwDBG6bapCT24uUR7F6+ZghWJ/uUIAZfegMo8L6I?=
 =?us-ascii?Q?mz8VBSlC7mdX3XbI9J1Uqo9Nnm3DXiUMkXrPLZXZxDAzBabdnayxP6jbA+sE?=
 =?us-ascii?Q?EoFnkQzh0IcACh49UcT9E77xEgIPthipcc9BwTB+rXIIaoINxzCtxbkfx6XK?=
 =?us-ascii?Q?q2tYXGLAS9GMEgMN4oVwdGej2AkNEdG5LHLf8zix/DjJJSayybTBNTpw1Tvn?=
 =?us-ascii?Q?/Cpmtx6pIMXC4QUx8ey9wznSd9NTAmPIQlVduAdna+Vb+N4B20hlzFHtMtmX?=
 =?us-ascii?Q?DgebJp+qFBKwcdJ3RGIRMZ+9mvPEYr5Pwqo52HY85Ps04WiXe/Q+X+Ux8fTa?=
 =?us-ascii?Q?nhN+8OjQu6PCYXKt8GQ1gJi0BAwuHg+2T0vhHs6u1ywVdd8eKc0ZwrUGgDPm?=
 =?us-ascii?Q?CXR7BF4aSkOTZPa356X7TbqDODknhdHzo/QUrCDwPKtHmIhhPQqgqZ7wL8BC?=
 =?us-ascii?Q?pAoIRqMhmRlhSfAco54ZA6k+GanGpoUci662Qidzp937rj77KrwEYaEhWRiS?=
 =?us-ascii?Q?K+5QwP1rZa2hNGDT8WWaYiAKfLW5Yoj16pHxNqpa+BCIFHAVOgEDwKvLgC7D?=
 =?us-ascii?Q?DBPfRrrL2h81qFUcbysq+9W8kqcJFHoVWDYwM7ZQ2FSSkbLjAabR7S9Vhfwz?=
 =?us-ascii?Q?mdY8POC5JOdErlnX24jWKbIm0B4tEuBDFMsMiT/5XJ9IfYll+lMQeWy9MBio?=
 =?us-ascii?Q?PdEdlAZHQFJYAXsvdV8M8aVkYFEEu8rC/TIYQh4rtWfj9IQGc/kxLrqU/n5o?=
 =?us-ascii?Q?7DlbQjjeJOXKg0Wt55UmKHyH3uu6rocj58uFtqrbYGdd71qlgCUdFKAhAw71?=
 =?us-ascii?Q?QG+bDQefID2lRh4+lX0XGyMxawXe+flNAZBYy2uZJgWy5Ny2kmKCMfk9mRos?=
 =?us-ascii?Q?+VClCw4M8obzxBPvE5KbSJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3172ba81-126a-4b43-3a27-08da553056a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:52:12.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuZQ0PIW0/9bYTWC2dJKESyuiupaV0sbymOUKmDzZwpPfrOLCvP1MuOVNTNGwuWWCo7Ofm87UezeEFM8uetm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1814
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
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 23, 2022 08:34
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> <rjw@rjwysocki.net>; linux-acpi <linux-acpi@vger.kernel.org>;
> regressions@lists.linux.dev; Thorsten Leemhuis (regressions address)
> <regressions@leemhuis.info>
> Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regard=
less
> of the query flag"" is causing regressions
>=20
> On Thu, Jun 23, 2022 at 07:24:34AM -0500, Mario Limonciello wrote:
> > On 6/23/22 05:06, Hans de Goede wrote:
> > > Hi Rafael, Mario,
> > >
> > > Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the
> > > _OSC regardless of the query flag"") is causing the issues fixed
> > > by the reverted commit to show up again, see:
> > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DKxmNvCfdm
> qvk5gXteXUDXHVTK45yEt%2BUYO4vaBbLXis%3D&amp;reserved=3D0
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=3D05%7C01%7C
> mario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C
> 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DpZRqAG3
> %2Bg0QevLOGZ8m9PNxcmkmh58soT2dSLg%2B6qWc%3D&amp;reserved=3D0
> > >
> > > both of which have comments from the reporters that
> > > the error message is back again; and presumably also
> > > that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> > > again.
> > >
> > > Can you please take a look and see if we can come up with
> > > something which fixes both the re-surfaced issue, as well
> > > as the issue which the revert tries to address ?
> > >
> >
> >
> > Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn't
> backport
> > to the stable trees it popped back up again?
> >
>=20
> It is only in 5.18, no stable releases that I can see.

I think that should probably come back to stable along with everything this
revert went back to, but before doing that perhaps we can get someone
affected to confirm cherry-picking it helps.
