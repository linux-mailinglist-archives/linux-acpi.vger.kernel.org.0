Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0003DE47D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhHCCmd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 22:42:33 -0400
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:31872
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233197AbhHCCmc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 22:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVMcKMedoGKz9BMiTiUq55Fc7MQI4+jcyfozdLA7UJZu/QUdri2S4O45+MJ39+K/bFyrqB57dN3GkmDQIq7ApmUf5PpD8L4Fa2GxcSjAiQ5CduX1mD3QuE2IMbb74WTF5zOPonwGMqVPjG4/Gg3cgkv8XQHxW43OCSIIl6gGZy+3B+ufMipPmW/AEEe/oM+Vsh5jTiYAmsjnYHaBoblAk1ROU/F//9X8+6Oq8XpsAlO/bcBQ5LFOhoZ1WKlilY9o2TmrvTX/PVTBHAyTbY6MBMePsyY/53y0UrM2KHVddqZ4TcjoJHgh0gU8luqDJNDo+Gbg7vxjPPqqwI+ipRHe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzRm/F5qkVbEixhEGzNoUsRyT2oMi+dhNd+5Ox5RVJc=;
 b=fDISuHeDqIWHIdh3hQbzcxMZri2MIbRotoH/LJHqVDL1rxeeWl2hJS/ld4khBmwe9bwFaMjdEHY9mVPLsgPMiLM7r7dRNx4dvrSWKUbdgIwMHIwkCYISWlpHrNATtJsxpYZK9bG6hW39g05xNyY6X0kxQzln8hlyMLNoJlD/PDAS8i/cI59quDn6ZahdDXl2QPuWdjc6Q9QwZZPSuQUoCT8uIqprRXHggNCUs9a/ewsBsP6O0/Hji+3nDpr1ueCISr3LuQW7b8CnaRpkEsWSznlYjo5KDaBJKn+vCknJOw4qfPgKCsdy37RMUDlBqrqBqUeH/H2dk5/vvKgIfW9gQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzRm/F5qkVbEixhEGzNoUsRyT2oMi+dhNd+5Ox5RVJc=;
 b=DNs90T661dnz+e/EAcSPSc1CWutqwhCzo9ss/hhc3uZheQb5Tmda8yvSfTkSn+gwNxgb+oCsVnWJOe8LFqIPIpRK0glNnEn4HtTeaIL89LFgj4forCA4rCZQTdWoqHTpj2lu+AotV+9dE3QWPFuWvxln4x480CNskXRYRKLzK5Q=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Tue, 3 Aug
 2021 02:42:18 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 02:42:18 +0000
From:   "Liang, Prike" <Prike.Liang@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
Thread-Topic: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
Thread-Index: AQHXhrozB0v0BCXrukiiYq2OCgOVV6teiAcAgAFtv4CAACPdgIAA05UAgAAd+hA=
Date:   Tue, 3 Aug 2021 02:42:18 +0000
Message-ID: <BYAPR12MB3238DC9B9BBDF9B21C430646FBF09@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
 <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
 <e11ce06f-8a5d-345a-5113-dd8802e9a0b9@amd.com>
 <eab56fac-175b-29b7-f66b-398b6477f390@redhat.com>
 <20210803002018.GH2563957@hr-amd>
In-Reply-To: <20210803002018.GH2563957@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=28442bb7-b885-4b9c-b4e3-5011f91af0e0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T02:07:54Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8241a9-5bf6-4dc6-31e6-08d956284fdd
x-ms-traffictypediagnostic: BYAPR12MB3333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB333311FEFA7CE64D9A7A8031FBF09@BYAPR12MB3333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvzuC42SHB+BN0TwRdgpvT9uyCUnBBw1fXlVQBwVDY3r1QSIUB5Y/7iW4l+jZX/g8zSQIirxCEOWsv3XBV8evF2+6w45aQ4QgV83ZiX5OVuo2+W+cYTyMlV3TWSuMpJ9WxftnWYYW2nrl14BSPKi/1Oiqmm7Xo1kahU2VEof3wkD2Rfc4EgklVBQQqDQIZU4UXAWhtE+rMfJ4j2MHmK0Y6kCNCGhj9qXCtF5mLmnsaIFReSJkBgxX0XsE8tkkMpB9Gb3B1SvO8IF0g5zMbcECZIgkIk/58VbDmYghm6ALopDtzMg0D/Ia2s3E7kOvKPvqO0ljQkFf+LC/f9fqGQjc2pCTLmO1oAs4g+wrtL8410cB0T7q/pN/3Vq6uqXqBW0100Dyw8NDkoGJ1bq9qLKKDOkL6P2kAvSDFiczo3UGF3fMwFDMBKe7i5m6Uj0AuopBIVg03GYr20YeKz9SjoU6+zmmd0An/WZy397/XeG6Z7mATBIvxto1uODHpPVYVyVmJuPw4ngWDdCdvfO0lNIH3a3Awmz4R/tAw54W7YCNjS+kByD4srpScqoZMdcv3sbrel4DX00FvAQVRulcysnkRHa/7YA1AbujxJGr6LvR7BHPd2yR+0Xp8LsS5QLhpuBME0yVlEkIRc+aiyyOQ5F5DAFGi/jET/jHVm8VijkjHVLjuOR4MNfk5HekzSB1QAa/BvBwVRnwnz0ZfvD/z36UxZQDQoLBRqSALggWRcm514Sly4qm7aD2RY3EbjeqAIqcwGAmybKwtmjVeec2SEF3HFAz8SV4SQebzfubwBjGNP3zClp6U8L0ajm2AApxmy8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3238.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(9686003)(8936002)(186003)(316002)(54906003)(8676002)(478600001)(30864003)(83380400001)(110136005)(26005)(2906002)(55016002)(66476007)(4326008)(66446008)(76116006)(53546011)(6506007)(71200400001)(66556008)(66946007)(52536014)(64756008)(5660300002)(86362001)(33656002)(38070700005)(38100700002)(7696005)(122000001)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aa8MhdTzuwWRtY4Y9r36ZA49c+xlzpILIX4pDE5rW3gaVc//1U4xFYnuPH?=
 =?iso-8859-1?Q?RqqTZhmfqaQqH5rrXBRHc5hGHjoSG9kS3+BjGfxWk5NdMP+WmQ3zrR9Hjf?=
 =?iso-8859-1?Q?f6A6VucNzfxZyJnBI5DQaMeMLCOz4vTqyYd/cOwyczLHaYBEAnZo9YK0pg?=
 =?iso-8859-1?Q?XVL/O1vqq7uehdxwLuVPPlBQF0WuN+zm5//oINkIcxsu4eMJTrZeLv2+wz?=
 =?iso-8859-1?Q?ehv53QsNayvtxQUwQWTE7046Pc8ehCn7AGp3h123Tf70Ozw8F4AD62lovm?=
 =?iso-8859-1?Q?KskAkz+TBzjwANMjipOZK6ExlGshcOCDSmMAGRNHBd092DrFiB7+7379y9?=
 =?iso-8859-1?Q?k+gb/o645LxoO+SMQwOwjwtpD1YuirZ5VNxC9SLpM7pkkqoSpGgsDotFni?=
 =?iso-8859-1?Q?BpjJw88ebERzeCWpKwNlxhLYkbFcouz9N4xcnfBYZXxCP4/CCO1JEy5sNH?=
 =?iso-8859-1?Q?vQo6PP8F147tWjzEIO6ZQuEWdC3MO9TEU/sSpHnh6UQcw7By45ybC5/0Ur?=
 =?iso-8859-1?Q?tY+m403mTCvehxx14+ZncirNyOnICOjLKoK/7DzLqEem+Wwqt1Xr5QBqxS?=
 =?iso-8859-1?Q?hf2i/Z0W64SCDChU+R8wdGtz6TbfbgfRQC3fPgP1NOHFmNq+NIevCOfkNW?=
 =?iso-8859-1?Q?W2mi/U46257pbLo6kB632Yla+2M4E+rolFsIsomem5PN/CzUh07E/c8kNR?=
 =?iso-8859-1?Q?h83KtF9mhXkwb9NeZoeDNn/4/kiIGdAMKRgM01ksnjtb0A4/kqDtX0lIvS?=
 =?iso-8859-1?Q?9kLorZE5EjiuPxeIceTUhTvJqm86OSmuyKJ61VGj0XJV13JIa3VVubJIkw?=
 =?iso-8859-1?Q?BUU3DjC5jU9YmXUxE0LS6tlJldcSNPx8qV6pp0Yf2PwCkPxo/3PQ8jxAm0?=
 =?iso-8859-1?Q?14/8AVjb4OTrtod/fyXp8OIDtAUmnvtfEBYNeV2y1mQDPN+Jnh34KeG6Mj?=
 =?iso-8859-1?Q?68Ot4to2idvs1YczSbBjc7l00LF0ikuolK8WXrkokF8FGflhhfh+B0K10q?=
 =?iso-8859-1?Q?KdAi6+sTBayUlMoZuj2JGNI8iCYhTXfmIF/nWlrhQfFSr2JYRadQN5q/cb?=
 =?iso-8859-1?Q?2ugdQRdT5wrx292luLRuLIChNdTFUxrVRtTCiLND3DmZcL8qa95y5zA5cC?=
 =?iso-8859-1?Q?4wEfYvtjDtkk1z8zA7pxcCngMJtDMN0Blj5jCRTgcbErh6Yw4qq8QEvxzY?=
 =?iso-8859-1?Q?/WFpreBuohPgJnr5FUuNODF8INRCSVD4g0IejxniTVXn5qn7rrQBsTYZlR?=
 =?iso-8859-1?Q?dG44RT10i465pzMeGg+aBDqJPKFggfTahLRTv8ke8mpraqzAsgnSCzlbHv?=
 =?iso-8859-1?Q?afQUz2RbvTMkCgsEIV9KZFM6Oz0E1Om2Ss6ERBYM8+WqNURJARJJ6D8FB5?=
 =?iso-8859-1?Q?ZgfLSU+XA8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8241a9-5bf6-4dc6-31e6-08d956284fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 02:42:18.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8eJKwjBnBYp2FyIjwqztFm7pwvRR+UcAb1n8YhSMVpmlvFrJeKnfSFGAU2/rGHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

In the AMD existing S0ix system seems needn't monitor SFH idle state, meanw=
hile SFH is powered by S5 rail and the rail keeps ON when SOC is in S3/S0i3=
 state. Regards to SFH stop working after S3 resume maybe caused by power r=
ail and device context tear down during S3 suspend. In addition, we also ne=
ed implement SFH suspend callback in amd-sfh-hid like as other vendor.

Thanks,
Prike
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, August 3, 2021 8:20 AM
> To: Hans de Goede <hdegoede@redhat.com>
> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Shah, Nehal-
> bakulchandra <Nehal-bakulchandra.Shah@amd.com>; Stephen MacNeil
> <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Rafael J . Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
> pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel.org>; Natikar,
> Basavaraj <Basavaraj.Natikar@amd.com>; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>
> + Prike
>
> On Mon, Aug 02, 2021 at 01:43:01PM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 8/2/21 11:34 AM, Basavaraj Natikar wrote:
> > > On 8/1/2021 5:15 PM, Shah, Nehal-bakulchandra wrote:
> > >> [AMD Official Use Only]
> > >>
> > >> Adding few more folks
> > >>
> > >> -----Original Message-----
> > >> From: Hans de Goede <hdegoede@redhat.com>
> > >> Sent: Sunday, August 1, 2021 3:17 PM
> > >> To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario
> > >> <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
> > >> Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi
> > >> <linux-acpi@vger.kernel.org>
> > >> Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
> > >>
> > >> Hi Rafael, Mario,
> > >>
> > >> Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapa=
d
> model) where Linux defaults to using S3/deep suspend instead of S0ix/s2id=
le.
> > >
> > > Hi Hans, Et al.
> > >
> > > Looks like the Lenovo platform Stephen MacNeil is using does not supp=
ort
> the S2Idle as the FADT flags as not set (looking at the output of the scr=
ipt).
> >
> > I believe it does, if it would not support s2idle at all, then this
> > would not be offered as an option in the "cat /sys/power/mem_sleep"
> output.
> >
> > Part of the problem seems to be that the system supports s2idle, but
> > does not use it by default
> >
> > > If sensors are not working after ACPI S3 resume, I am suspecting
> > > that it could be because the PM support is missing in the amd-sfh dri=
ver
> (which is already WIP from my side).
> >
> > Right, making sure the SFH code also works with S3 suspend is good
> > regardless, but AFAIK most modern systems should use S01x / s2idle
> suspend by default.
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> > >> This is causing the sensors provided by the AMD Sensor Fusion Hub to
> stop working after a suspend/resume. Adding mem_sleep_default=3Ds2idle to
> the kernel commandline fixes this.
> > >>
> > >> Do you have any idea what might be causing this ?
> > >>
> > >> Regards,
> > >>
> > >> Hans
> > >>
> > >>
> > >>
> > >> On 7/31/21 2:31 PM, Stephen MacNeil wrote:
> > >>> I wrote Basavaraj Natikar the new maintainer of amd_sfh for the ker=
nel,
> after sending the information he wanted his reply was...
> > >>>
> > >>>>> Thanks Stephen MacNeil,
> > >>> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2
> kernel.
> > >>>
> > >>> Could you please check with Lenovo, as we are not observing amd_sfh
> issue on our reference platforms too.
> > >>>
> > >>> Thanks,
> > >>> Basavaraj
> > >>> <<
> > >>> looking at the information I sent him  i looks like the issue is
> > >>> (to me anyway)
> > >>>
> > >>> cat /sys/power/mem_sleep
> > >>> [s2idle] deep
> > >>>
> > >>> without
> > >>> cat /sys/power/mem_sleep
> > >>> s2idle [deep]
> > >>>
> > >>>
> > >>> this is the info he requested... any idea who else I can contact.
> > >>> this is the output with and without the kernel param
> > >>>
> > >>>
> > >>>
> > >>> Thanks a lot Stephen MacNeil  for the information.
> > >>>
> > >>>
> > >>>
> > >>> Could you please provide me below information:-
> > >>>
> > >>> =B7  what version of kernel is running.
> > >>>
> > >>> uname -a
> > >>> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul
> > >>> 18
> > >>> 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > >>>
> > >>>
> > >>> =B7  Are you using latest patches from amd-sfh
> > >>>
> > >>> only the kernel
> > >>>
> > >>> =B7  Could you please provide me output of /sys/power/mem_sleep
> > >>>
> > >>> with kernel option mem_sleep_default=3Ds2idle
> > >>>
> > >>> cat /sys/power/mem_sleep
> > >>> [s2idle] deep
> > >>>
> > >>> without
> > >>> cat /sys/power/mem_sleep
> > >>> s2idle [deep]
> > >>>
> > >>> =B7  Could you please provide output of below script after
> > >>> installing "apt install iasl*". acpica-tools
> > >>>
> > >>> with kernel option mem_sleep_default=3Ds2idle
> > >>>
> > >>> Intel ACPI Component Architecture
> > >>> ASL+ Optimizing Compiler/Disassembler version 20190509
> > >>> Copyright (c) 2000 - 2019 Intel Corporation
> > >>>
> > >>> File appears to be binary: found 265 non-ASCII characters,
> > >>> disassembling Binary file appears to be a valid ACPI table,
> > >>> disassembling Input file apic.dat, Length 0x138 (312) bytes
> > >>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:
> > >>> apic.dsl - 16071 bytes File appears to be binary: found 40
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file batb.dat, Length 0x4A
> > >>> (74) bytes
> > >>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI
> > >>> table header only Acpi Data Table [BATB] decoded Formatted output:
> > >>> batb.dsl - 1274 bytes File appears to be binary: found 31
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file bgrt.dat, Length 0x38
> > >>> (56) bytes
> > >>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:
> > >>> bgrt.dsl - 1606 bytes File appears to be binary: found 16
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file cdit.dat, Length 0x29
> > >>> (41) bytes
> > >>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI
> > >>> table header only Acpi Data Table [CDIT] decoded Formatted output:
> > >>> cdit.dsl - 1115 bytes File appears to be binary: found 2765
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file crat.dat, Length 0xB80
> > >>> (2944) bytes
> > >>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI
> > >>> table header only Acpi Data Table [CRAT] decoded Formatted output:
> > >>> crat.dsl - 15424 bytes File appears to be binary: found 15189
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B
> > >>> (44699) bytes
> > >>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO
> AMD      00001000
> > >>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary:
> > >>> found 229 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file facp.dat,
> > >>> Length 0x10C
> > >>> (268) bytes
> > >>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-
> 01    00000003
> > >>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:
> > >>> facp.dsl - 10098 bytes File appears to be binary: found 59
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file facs.dat, Length 0x40
> > >>> (64) bytes
> > >>> ACPI: FACS 0x0000000000000000 000040 Acpi Data Table [FACS]
> > >>> decoded Formatted output:  facs.dsl - 1368 bytes File appears to
> > >>> be binary:
> > >>> found 28 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file fpdt.dat,
> > >>> Length 0x34
> > >>> (52) bytes
> > >>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:
> > >>> fpdt.dsl - 1452 bytes File appears to be binary: found 30
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file hpet.dat, Length 0x38
> > >>> (56) bytes
> > >>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:
> > >>> hpet.dsl - 1865 bytes File appears to be binary: found 279
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file ivrs.dat, Length 0x1A4
> > >>> (420) bytes
> > >>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:
> > >>> ivrs.dsl - 6001 bytes File appears to be binary: found 36
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file mcfg.dat, Length 0x3C
> > >>> (60) bytes
> > >>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:
> > >>> mcfg.dsl - 1526 bytes File appears to be binary: found 32
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file msdm.dat, Length 0x55
> > >>> (85) bytes
> > >>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:
> > >>> msdm.dsl - 1557 bytes File appears to be binary: found 25
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file sbst.dat, Length 0x30
> > >>> (48) bytes
> > >>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:
> > >>> sbst.dsl - 1282 bytes File appears to be binary: found 410
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file ssdt10.dat, Length
> > >>> 0x47F (1151) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary:
> > >>> found 708 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt11.dat,
> > >>> Length 0xC1D (3101) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary:
> > >>> found 848 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt12.dat,
> > >>> Length 0x9AD (2477) bytes
> > >>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary:
> > >>> found 9207 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt1.dat,
> > >>> Length
> > >>> 0x7216 (29206) bytes
> > >>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable
> 00000002
> > >>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary:
> > >>> found 3968 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt2.dat,
> > >>> Length
> > >>> 0x1500 (5376) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable
> 00000001
> > >>> AMD
> > >>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing
> > >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary:
> > >>> found 449 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt3.dat,
> > >>> Length 0x53A (1338) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl
> 00009999
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary:
> > >>> found 474 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt4.dat,
> > >>> Length 0x64C (1612) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt4.dsl - 8258 bytes File appears to be binary:
> > >>> found 400 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt5.dat,
> > >>> Length 0x480 (1152) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt5.dsl - 5582 bytes File appears to be binary:
> > >>> found 1140 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt6.dat,
> > >>> Length 0x1497 (5271) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary:
> > >>> found 1314 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt7.dat,
> > >>> Length
> > >>> 0x1576 (5494) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary:
> > >>> found 4095 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt8.dat,
> > >>> Length 0x353C (13628) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary:
> > >>> found 74 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt9.dat,
> > >>> Length 0x90
> > >>> (144) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt9.dsl - 1767 bytes File appears to be binary:
> > >>> found 32 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file tpm2.dat,
> > >>> Length 0x38 (56) bytes
> > >>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:
> > >>> tpm2.dsl - 1515 bytes File appears to be binary: found 189
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file uefi.dat, Length 0x12A
> > >>> (298) bytes
> > >>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:
> > >>> uefi.dsl - 2505 bytes File appears to be binary: found 37100
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file vfct.dat, Length 0xD484
> > >>> (54404) bytes
> > >>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI
> > >>> table header only Acpi Data Table [VFCT] decoded Formatted output:
> > >>> vfct.dsl - 269557 bytes File appears to be binary: found 17
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file wsmt.dat, Length 0x28
> > >>> (40) bytes
> > >>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:
> > >>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not
> > >>> support S0ix!
> > >>>
> > >>>
> > >>> without
> > >>>
> > >>> Intel ACPI Component Architecture
> > >>> ASL+ Optimizing Compiler/Disassembler version 20190509
> > >>> Copyright (c) 2000 - 2019 Intel Corporation
> > >>>
> > >>> File appears to be binary: found 265 non-ASCII characters,
> > >>> disassembling Binary file appears to be a valid ACPI table,
> > >>> disassembling Input file apic.dat, Length 0x138 (312) bytes
> > >>> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output:
> > >>> apic.dsl - 16071 bytes File appears to be binary: found 40
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file batb.dat, Length 0x4A
> > >>> (74) bytes
> > >>> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI
> > >>> table header only Acpi Data Table [BATB] decoded Formatted output:
> > >>> batb.dsl - 1274 bytes File appears to be binary: found 31
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file bgrt.dat, Length 0x38
> > >>> (56) bytes
> > >>> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output:
> > >>> bgrt.dsl - 1606 bytes File appears to be binary: found 16
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file cdit.dat, Length 0x29
> > >>> (41) bytes
> > >>> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI
> > >>> table header only Acpi Data Table [CDIT] decoded Formatted output:
> > >>> cdit.dsl - 1115 bytes File appears to be binary: found 2765
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file crat.dat, Length 0xB80
> > >>> (2944) bytes
> > >>> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI
> > >>> table header only Acpi Data Table [CRAT] decoded Formatted output:
> > >>> crat.dsl - 15424 bytes File appears to be binary: found 15189
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B
> > >>> (44699) bytes
> > >>> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO
> AMD      00001000
> > >>> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    dsdt.dsl - 384071 bytes File appears to be binary:
> > >>> found 229 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file facp.dat,
> > >>> Length 0x10C
> > >>> (268) bytes
> > >>> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-
> 01    00000003
> > >>> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output:
> > >>> facp.dsl - 10098 bytes File appears to be binary: found 59
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file facs.dat, Length 0x40
> > >>> (64) bytes
> > >>> ACPI: FACS 0x0000000000000000 000040 Acpi Data Table [FACS]
> > >>> decoded Formatted output:  facs.dsl - 1368 bytes File appears to
> > >>> be binary:
> > >>> found 28 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file fpdt.dat,
> > >>> Length 0x34
> > >>> (52) bytes
> > >>> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output:
> > >>> fpdt.dsl - 1452 bytes File appears to be binary: found 30
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file hpet.dat, Length 0x38
> > >>> (56) bytes
> > >>> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output:
> > >>> hpet.dsl - 1865 bytes File appears to be binary: found 279
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file ivrs.dat, Length 0x1A4
> > >>> (420) bytes
> > >>> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output:
> > >>> ivrs.dsl - 6001 bytes File appears to be binary: found 36
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file mcfg.dat, Length 0x3C
> > >>> (60) bytes
> > >>> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output:
> > >>> mcfg.dsl - 1526 bytes File appears to be binary: found 32
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file msdm.dat, Length 0x55
> > >>> (85) bytes
> > >>> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output:
> > >>> msdm.dsl - 1557 bytes File appears to be binary: found 25
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file sbst.dat, Length 0x30
> > >>> (48) bytes
> > >>> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output:
> > >>> sbst.dsl - 1282 bytes File appears to be binary: found 410
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file ssdt10.dat, Length
> > >>> 0x47F (1151) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt10.dsl - 5673 bytes File appears to be binary:
> > >>> found 708 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt11.dat,
> > >>> Length 0xC1D (3101) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt11.dsl - 15424 bytes File appears to be binary:
> > >>> found 848 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt12.dat,
> > >>> Length 0x9AD (2477) bytes
> > >>> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt12.dsl - 12474 bytes File appears to be binary:
> > >>> found 9207 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt1.dat,
> > >>> Length
> > >>> 0x7216 (29206) bytes
> > >>> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable
> 00000002
> > >>> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt1.dsl - 208699 bytes File appears to be binary:
> > >>> found 3968 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt2.dat,
> > >>> Length
> > >>> 0x1500 (5376) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable
> 00000001
> > >>> AMD
> > >>> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing
> > >>> Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt2.dsl - 59265 bytes File appears to be binary:
> > >>> found 449 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt3.dat,
> > >>> Length 0x53A (1338) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl
> 00009999
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt3.dsl - 10738 bytes File appears to be binary:
> > >>> found 474 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt4.dat,
> > >>> Length 0x64C (1612) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt4.dsl - 8258 bytes File appears to be binary:
> > >>> found 400 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt5.dat,
> > >>> Length 0x480 (1152) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt5.dsl - 5582 bytes File appears to be binary:
> > >>> found 1140 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt6.dat,
> > >>> Length 0x1497 (5271) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt6.dsl - 20293 bytes File appears to be binary:
> > >>> found 1314 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt7.dat,
> > >>> Length
> > >>> 0x1576 (5494) bytes
> > >>> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt7.dsl - 30076 bytes File appears to be binary:
> > >>> found 4095 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt8.dat,
> > >>> Length 0x353C (13628) bytes
> > >>> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt8.dsl - 78242 bytes File appears to be binary:
> > >>> found 74 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file ssdt9.dat,
> > >>> Length 0x90
> > >>> (144) bytes
> > >>> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable
> 00000001
> > >>> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT]
> > >>> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > >>>
> > >>> Parsing completed
> > >>> Disassembly completed
> > >>> ASL Output:    ssdt9.dsl - 1767 bytes File appears to be binary:
> > >>> found 32 non-ASCII characters, disassembling Binary file appears
> > >>> to be a valid ACPI table, disassembling Input file tpm2.dat,
> > >>> Length 0x38 (56) bytes
> > >>> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-
> 01    00000002
> > >>> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output:
> > >>> tpm2.dsl - 1515 bytes File appears to be binary: found 189
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file uefi.dat, Length 0x12A
> > >>> (298) bytes
> > >>> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output:
> > >>> uefi.dsl - 2505 bytes File appears to be binary: found 37100
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file vfct.dat, Length 0xD484
> > >>> (54404) bytes
> > >>> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-
> 01    00000001
> > >>> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI
> > >>> table header only Acpi Data Table [VFCT] decoded Formatted output:
> > >>> vfct.dsl - 269557 bytes File appears to be binary: found 17
> > >>> non-ASCII characters, disassembling Binary file appears to be a
> > >>> valid ACPI table, disassembling Input file wsmt.dat, Length 0x28
> > >>> (40) bytes
> > >>> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-
> 01    00000000
> > >>> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output:
> > >>> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not
> > >>> support S0ix!
> > >>>
> > >>>
> > >>> #################################################
> > >>> #!/bin/bash
> > >>>
> > >>> cd /var/tmp/
> > >>>
> > >>> acpidump -b
> > >>>
> > >>> iasl -d *.dat
> > >>>
> > >>> lp=3D$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print
> > >>> $(NF)}')
> > >>>
> > >>> if [ "$lp" -eq 1 ]; then
> > >>>
> > >>> echo "Low Power S0 Idle is" $lp
> > >>>
> > >>> echo "The system supports S0ix!"
> > >>>
> > >>> else
> > >>>
> > >>> echo "Low Power S0 Idle is" $lp
> > >>>
> > >>> echo "The system does not support S0ix!"
> > >>>
> > >>> fi
> > >>>
> > >>>
> > >>>
> > >>> Thanks,
> > >>>
> > >>> Basavaraj
> > >>>
> > >>>
> > >>>
> > >>>
> > >>> --
> > >>> Stephen MacNeil
> > >>> 905 334 5092
> > >>> mglessons.com
> > >>>
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> > >>>
> mglessons.com%2F&amp;data=3D04%7C01%7Cray.huang%40amd.com%7C0db
> f347b
> > >>>
> 744f4480a76608d955aab43c%7C3dd8961fe4884e608e11a82d994e183d%7C0
> %7C
> > >>>
> 0%7C637635013945224005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDA
> > >>>
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZ
> > >>>
> c6RqCBpmncIWTGiBpZ%2BmOBmPVV7gIx8mS2hqBenP6k%3D&amp;reserve
> d=3D0>
> > >
> >
