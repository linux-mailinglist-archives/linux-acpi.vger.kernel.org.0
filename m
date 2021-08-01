Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2A3DCB6E
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Aug 2021 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhHALpr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Aug 2021 07:45:47 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:38881
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231461AbhHALpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 1 Aug 2021 07:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEsjTVEeINGmbI2BHGSELjSm8lrp6aLLGprCCtf9tK66sW6uEAPPd6cC2ZVAc5qos0AIgSHQhacgMFcM02wdAh1MlUcpHYVgE/oGjheGqdWqp68y+2v4+uivyGfLUOReSWBn7XxZBoODmawqcLLhaozbKcC7F9T95BbvZOZPKSsfU8wpVlutv742fpLMYIO5yWTB8+JtVSjIh55NxlrArfK9Ru6WOOxOoYP0u+spYfpxjiBAIwaQrX6A0v0VGvpwyxw9gJlu1A9naW9ML2MIft+fbUHm9oERaWN63cwaznWthIDyZ0br6Yxubhyaam4zwVmloFSx+oZ9+YsK7K0Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqPQthK4TIKvadoaq1CoBORxnFccDmjWNd0MajInoHQ=;
 b=ZloTa5O3lQmC+cXTP5QOVsVeaHuuXS51Eyl+Pd/WSkgD1iShB2MIo9XAIxRmjlQ9pUJuaWnL62eZOxhf0G4lcgaTqukuF3dzvXBY3bfwKmBgnEP9PAvG80srFv0IjM9sj74UuuF7O5sctggHZ29qS9hQhgyzSTPPvkINO+TThDp+EThr11KqllITO6Vr1VhPhvamy4CCl567m4513TOXK+norRs9jOrMewkO4hevbq8gbEuX3bHOAiy3Uh2DNpcQ8i8g1HNgahC65moiuvPRGMY1zb6dGP2kqWOfjLCrvQUvkPU8uewqwjxMnDwPrIQ4Pk+BWdvQ1g0zmRTpERb/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqPQthK4TIKvadoaq1CoBORxnFccDmjWNd0MajInoHQ=;
 b=uDnbwFcD9dp0r5+z40pRx/eaP8ya1iqS0P/FIyn5hS42Xah39uDnqHt4Cn+7t51XuMCVgbud8iXSH6Qn5IUDt8e2JKeLzpclQA1WXBnly3S6GAaQLFcrJb5dc/2r+9lItk3vP5rzeU4oYbOIWtoKcqEYhBieNw+PZKfs3gfJWOk=
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Sun, 1 Aug
 2021 11:45:36 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e%6]) with mapi id 15.20.4373.026; Sun, 1 Aug 2021
 11:45:36 +0000
From:   "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
Thread-Topic: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
Thread-Index: AQHXhroy+jDjSYh4xEeR1If1DbntTKteh+tA
Date:   Sun, 1 Aug 2021 11:45:36 +0000
Message-ID: <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
In-Reply-To: <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-01T11:45:32Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f2c71b7-9fa9-4adb-b894-c4083a71e225;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 362bf53d-1185-44e7-18f1-08d954e1e0cc
x-ms-traffictypediagnostic: BN9PR12MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53068185E9E496A298A0CA56A0EE9@BN9PR12MB5306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxETOkmHdvG/ygfQGRiN0rXKyIfBeny6aOSlRUa/MTcqxqPClFjEd+RkqELN93z/c8hf1cld+ZNDQMbRJHFSvDu+54RTmbvWOwL3VDHJJEfU0ew4Nd3TKywxxcmfbU/OpquBheTm9KA6k4APmJnEG/jnXLz/ZnbCubEipN6TL+mB0Lbok0rX4gEcM0T+2iVfgUfvN9oyJrtrq8hrIVU4TeYl3VhfDF28bsQnRGU7kdSnIv3m1v3ml1bw6f9iJoCdywXZ0v+QJu1AVyAp+IDS6NGVkVtd0RoaB9ZVik8kxgzL6V1w2axNKQxmzme7QyupT2SgdtEgrDs4RheKt9bMBN4qusieOBVSHirhyMi/iAMU7bfb2BREl8vKiJv15i1LyGLFxiNCVGruiQXL9OhvxFMzUoP4LaxvPaxCwS9s5YpkeczsAVkS0lACdY+WTEWFVV4TaLs/r5oxzc3zhsrZ7sKBZCDaK5vxU0vh9/db05DvRxGSWra2CCs4LSVv3IsCuS+4vFHhiOiQYhwY7rFyNtEN/gUKsVWSzaC5Ko/TXhkchtyLPDdHU6pIwnU7VJRbf6Li2AnXFvCVXe1HZ7XOu/k3ZD3wtJcFWZh0NCSJlWLoimXXuupEN/iy5wRWAyEFd1Q3Oynfa+5ngtFzXNNCslKVz6YGVt7IwEHnuQUnbr/7Qt0veNKYexnq+jb0pbtj40QA3IHY9/ZAvTUFYPPfzIuPV+AAGHbyCjEps/NVtoc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(86362001)(8936002)(186003)(71200400001)(66446008)(8676002)(122000001)(66476007)(54906003)(66556008)(478600001)(38070700005)(66946007)(110136005)(30864003)(64756008)(52536014)(33656002)(2906002)(83380400001)(76116006)(38100700002)(55016002)(316002)(6506007)(7696005)(9686003)(5660300002)(4326008)(53546011)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f1ci2saC4yo9W8pi1YqGzCtg89OEeyuYWME9979M/IMkAd6EX+hXuZI2DH?=
 =?iso-8859-1?Q?nC2pOmbNXMjqyzEBa/0LuqfBJgFF3jB/Ve8iWRwFQivkIX71LAJKkg7xBn?=
 =?iso-8859-1?Q?dezRX9G7r2UMLpmDrcFlb1PuWARz56jEY1aZhyLlWmvpZ/uFKpQvpLFpF/?=
 =?iso-8859-1?Q?7aZALbCjMovrJ0UyGwqmklLmTyqbkjaCmTAnbLuuYedhvGDaXe3WBCwkdH?=
 =?iso-8859-1?Q?zhULAbQTHVgBHRsWYN4f6VwvWS6MR7XKejtyqFmAJB/9MERGYIecO60lce?=
 =?iso-8859-1?Q?444a7l+/q1F82G4K7aIKZoaflQNRnADCN2sbGSlptLH/09ny2CjKZfDOMA?=
 =?iso-8859-1?Q?Fs3ZAFUxxOSCKdqPFR6sAAQC7ebW1To3L2IrbhUGticEXu1QC1PZlk8NSI?=
 =?iso-8859-1?Q?YpEw4rCN/2oGORZThU8abvMOaZBNQBQqrXCwyyvXAuCcTIDSPZLlLiEfdm?=
 =?iso-8859-1?Q?RSTnnxOYYlXn/SUvhVU5MtJ4T9VdqtYDiLEWSjn59ywbMtjOkhfDmA+AYV?=
 =?iso-8859-1?Q?xN0wQhdrlvTeLgWdfi5f3vGpLYTvZMqXCV5Dqj1wip19oUulz+2Orvgt6M?=
 =?iso-8859-1?Q?/EYX9NPhZk9M2JhUaWRVQX76EUeDNaDn8ChyWSgfbB5q1a5J1lG2embHbA?=
 =?iso-8859-1?Q?Fo7Du5BUl+8GXNZEyw851mDvTOq2RUdlDn+XJy2DjIK1ID4NZr4bnhUvtQ?=
 =?iso-8859-1?Q?9vodFlELJUKOX1unzZMsCgWPqSyW8OQxU7wX/erH0Z/TIR7XJCL0iiG5JG?=
 =?iso-8859-1?Q?3w38PP1CFFn0zc4cNNheTMmnTrFLgkz6mH0jenJ7WrvFSwS7bK3UUjhy+x?=
 =?iso-8859-1?Q?Wz7zKk20FCkuPDajr9yAq0nkUCuv4f78yK59iXK5dwnnXLRJrJoerAvjw8?=
 =?iso-8859-1?Q?H8p0wdsS6WaNHfPwT4hjL2cVrHNxAn0DVBJLtJo/QrOOdbdknZhuspdgC7?=
 =?iso-8859-1?Q?+Qxo1WnFcGArpT2gPtnqVY4j3gq64OlihqSXijsVG6Pj2fMAO6I2v08pc5?=
 =?iso-8859-1?Q?miJAbcXcoM3dyXBLUVRNohsAh/+lLZ6nU2ofD9aUA83+n6STADIOIbxrxO?=
 =?iso-8859-1?Q?wl3FeXCEe+u170R6mKuGL+NI9IYbr78d4gUm2odAET7NYVxSIo5EQR+TzS?=
 =?iso-8859-1?Q?mh4DgKCCAuegdE2qYC31Od3IE3vuSV4jCzQeMjeqcpyQD7O89SpJVPrgDR?=
 =?iso-8859-1?Q?PWf6ztZTSuklDT3651swcadmDEZRhmrodQTJfol6LIdhghZssWrmleyODY?=
 =?iso-8859-1?Q?eQDBvJER6plJaBpT+oGXOqR9h1pVZQk8+EKTVN52Byh6OmtM+uvg7HI9RO?=
 =?iso-8859-1?Q?atrUNTqvbVqpbpsWtitgr3tHZhKRdaXRk0+p75yORAu7jeqbcoQRTQvx4z?=
 =?iso-8859-1?Q?0WD4WnXTiuC5TlOmj0lmRIG4+8gUPw33WHLyKTuCqeb+0CFVmC+pLfzrUX?=
 =?iso-8859-1?Q?IM0mhlUIkzud/ZMQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362bf53d-1185-44e7-18f1-08d954e1e0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2021 11:45:36.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDZsuJdef5AlPjyVfYKWLt5hkkqralpA4LvLAA3/q/re6LTK9zgA7J017zzen/EZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[AMD Official Use Only]

Adding few more folks

-----Original Message-----
From: Hans de Goede <hdegoede@redhat.com>=20
Sent: Sunday, August 1, 2021 3:17 PM
To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel=
.org>
Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)

Hi Rafael, Mario,

Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad model=
) where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.

This is causing the sensors provided by the AMD Sensor Fusion Hub to stop w=
orking after a suspend/resume. Adding mem_sleep_default=3Ds2idle to the ker=
nel commandline fixes this.

Do you have any idea what might be causing this ?

Regards,

Hans



On 7/31/21 2:31 PM, Stephen MacNeil wrote:
> I wrote=A0Basavaraj Natikar the new maintainer of amd_sfh for the kernel,=
 after sending the information he wanted his reply was...
>=20
>>>Thanks Stephen MacNeil,
>=20
> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2 kernel.
> =A0
> Could you please check with Lenovo, as we are not observing amd_sfh issue=
 on our reference platforms too.
>=20
> Thanks,
> Basavaraj
> <<
> looking at the information I sent him=A0 i looks like the issue is (to=20
> me anyway)
>=20
> cat /sys/power/mem_sleep
> [s2idle] deep
>=20
> without
> cat /sys/power/mem_sleep
> s2idle [deep]
>=20
>=20
> this is the info he requested... any idea who else I can contact.
> this is the output with and without the kernel param
>=20
> =A0
>=20
> Thanks a lot Stephen MacNeil =A0for the information.
>=20
> =A0
>=20
> Could you please provide me below information:-
>=20
> =B7 =A0what version of kernel is running.
>=20
> uname -a
> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18=20
> 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>=20
>=20
> =B7 =A0Are you using latest patches from amd-sfh
>=20
> only the kernel
>=20
> =B7 =A0Could you please provide me output of /sys/power/mem_sleep
>=20
> with kernel option mem_sleep_default=3Ds2idle
>=20
> cat /sys/power/mem_sleep
> [s2idle] deep
>=20
> without
> cat /sys/power/mem_sleep
> s2idle [deep]
>=20
> =B7 =A0Could you please provide output of below script after installing=20
> "apt install iasl*". acpica-tools
>=20
> with kernel option mem_sleep_default=3Ds2idle
>=20
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20190509
> Copyright (c) 2000 - 2019 Intel Corporation
>=20
> File appears to be binary: found 265 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file apic.dat, Length 0x138 (312) bytes
> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output: =A0
> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI=20
> table header only Acpi Data Table [BATB] decoded Formatted output: =A0
> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output: =A0
> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI=20
> table header only Acpi Data Table [CDIT] decoded Formatted output: =A0
> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI=20
> table header only Acpi Data Table [CRAT] decoded Formatted output: =A0
> crat.dsl - 15424 bytes File appears to be binary: found 15189=20
> non-ASCII characters, disassembling Binary file appears to be a valid=20
> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699)=20
> bytes
> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD =A0 =A0 =A000001000=
=20
> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0dsdt.dsl - 384071 bytes File appears to be binary:=20
> found 229 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C=20
> (268) bytes
> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01 =A0 =A000000003=20
> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output: =A0
> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
> ACPI: FACS 0x0000000000000000 000040
> Acpi Data Table [FACS] decoded
> Formatted output: =A0facs.dsl - 1368 bytes File appears to be binary:=20
> found 28 non-ASCII characters, disassembling Binary file appears to be=20
> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34=20
> (52) bytes
> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output: =A0
> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output: =A0
> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output: =A0
> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output: =A0
> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output: =A0
> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output: =A0
> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt10.dsl - 5673 bytes File appears to be binary:=20
> found 708 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt11.dat, Length=20
> 0xC1D (3101) bytes
> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt11.dsl - 15424 bytes File appears to be binary:=20
> found 848 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt12.dat, Length=20
> 0x9AD (2477) bytes
> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt12.dsl - 12474 bytes File appears to be binary:=20
> found 9207 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt1.dat, Length=20
> 0x7216 (29206) bytes
> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002=20
> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt1.dsl - 208699 bytes File appears to be binary:=20
> found 3968 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt2.dat, Length=20
> 0x1500 (5376) bytes
> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD =
=A0
> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt2.dsl - 59265 bytes File appears to be binary:=20
> found 449 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt3.dat, Length=20
> 0x53A (1338) bytes
> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt3.dsl - 10738 bytes File appears to be binary:=20
> found 474 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt4.dat, Length=20
> 0x64C (1612) bytes
> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt4.dsl - 8258 bytes
> File appears to be binary: found 400 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt5.dsl - 5582 bytes
> File appears to be binary: found 1140 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt6.dsl - 20293 bytes File appears to be binary:=20
> found 1314 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt7.dat, Length=20
> 0x1576 (5494) bytes
> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt7.dsl - 30076 bytes File appears to be binary:=20
> found 4095 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt8.dat, Length=20
> 0x353C (13628) bytes
> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt8.dsl - 78242 bytes File appears to be binary:=20
> found 74 non-ASCII characters, disassembling Binary file appears to be=20
> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90=20
> (144) bytes
> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt9.dsl - 1767 bytes
> File appears to be binary: found 32 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output: =A0
> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output: =A0
> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI=20
> table header only Acpi Data Table [VFCT] decoded Formatted output: =A0
> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output: =A0
> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not=20
> support S0ix!
>=20
>=20
> without
>=20
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20190509
> Copyright (c) 2000 - 2019 Intel Corporation
>=20
> File appears to be binary: found 265 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file apic.dat, Length 0x138 (312) bytes
> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [APIC] decoded Formatted output: =A0
> apic.dsl - 16071 bytes File appears to be binary: found 40 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file batb.dat, Length 0x4A (74) bytes
> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Unknown ACPI table signature [BATB], decoding ACPI=20
> table header only Acpi Data Table [BATB] decoded Formatted output: =A0
> batb.dsl - 1274 bytes File appears to be binary: found 31 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file bgrt.dat, Length 0x38 (56) bytes
> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [BGRT] decoded Formatted output: =A0
> bgrt.dsl - 1606 bytes File appears to be binary: found 16 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file cdit.dat, Length 0x29 (41) bytes
> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [CDIT], decoding ACPI=20
> table header only Acpi Data Table [CDIT] decoded Formatted output: =A0
> cdit.dsl - 1115 bytes File appears to be binary: found 2765 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file crat.dat, Length 0xB80 (2944) bytes
> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [CRAT], decoding ACPI=20
> table header only Acpi Data Table [CRAT] decoded Formatted output: =A0
> crat.dsl - 15424 bytes File appears to be binary: found 15189=20
> non-ASCII characters, disassembling Binary file appears to be a valid=20
> ACPI table, disassembling Input file dsdt.dat, Length 0xAE9B (44699)=20
> bytes
> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD =A0 =A0 =A000001000=
=20
> INTL 20180313) Pass 1 parse of [DSDT] Pass 2 parse of [DSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0dsdt.dsl - 384071 bytes File appears to be binary:=20
> found 229 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file facp.dat, Length 0x10C=20
> (268) bytes
> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01 =A0 =A000000003=20
> LENO 00000001) Acpi Data Table [FACP] decoded Formatted output: =A0
> facp.dsl - 10098 bytes File appears to be binary: found 59 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file facs.dat, Length 0x40 (64) bytes
> ACPI: FACS 0x0000000000000000 000040
> Acpi Data Table [FACS] decoded
> Formatted output: =A0facs.dsl - 1368 bytes File appears to be binary:=20
> found 28 non-ASCII characters, disassembling Binary file appears to be=20
> a valid ACPI table, disassembling Input file fpdt.dat, Length 0x34=20
> (52) bytes
> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [FPDT] decoded Formatted output: =A0
> fpdt.dsl - 1452 bytes File appears to be binary: found 30 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file hpet.dat, Length 0x38 (56) bytes
> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [HPET] decoded Formatted output: =A0
> hpet.dsl - 1865 bytes File appears to be binary: found 279 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file ivrs.dat, Length 0x1A4 (420) bytes
> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [IVRS] decoded Formatted output: =A0
> ivrs.dsl - 6001 bytes File appears to be binary: found 36 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file mcfg.dat, Length 0x3C (60) bytes
> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [MCFG] decoded Formatted output: =A0
> mcfg.dsl - 1526 bytes File appears to be binary: found 32 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file msdm.dat, Length 0x55 (85) bytes
> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [MSDM] decoded Formatted output: =A0
> msdm.dsl - 1557 bytes File appears to be binary: found 25 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file sbst.dat, Length 0x30 (48) bytes
> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [SBST] decoded Formatted output: =A0
> sbst.dsl - 1282 bytes File appears to be binary: found 410 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file ssdt10.dat, Length 0x47F (1151) bytes
> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt10.dsl - 5673 bytes File appears to be binary:=20
> found 708 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt11.dat, Length=20
> 0xC1D (3101) bytes
> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt11.dsl - 15424 bytes File appears to be binary:=20
> found 848 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt12.dat, Length=20
> 0x9AD (2477) bytes
> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt12.dsl - 12474 bytes File appears to be binary:=20
> found 9207 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt1.dat, Length=20
> 0x7216 (29206) bytes
> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002=20
> MSFT 04000000) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt1.dsl - 208699 bytes File appears to be binary:=20
> found 3968 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt2.dat, Length=20
> 0x1500 (5376) bytes
> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD =
=A0
> 00000001) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt2.dsl - 59265 bytes File appears to be binary:=20
> found 449 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt3.dat, Length=20
> 0x53A (1338) bytes
> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt3.dsl - 10738 bytes File appears to be binary:=20
> found 474 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt4.dat, Length=20
> 0x64C (1612) bytes
> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt4.dsl - 8258 bytes
> File appears to be binary: found 400 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file ssdt5.dat, Length 0x480 (1152) bytes
> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt5.dsl - 5582 bytes
> File appears to be binary: found 1140 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file ssdt6.dat, Length 0x1497 (5271) bytes
> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt6.dsl - 20293 bytes File appears to be binary:=20
> found 1314 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt7.dat, Length=20
> 0x1576 (5494) bytes
> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt7.dsl - 30076 bytes File appears to be binary:=20
> found 4095 non-ASCII characters, disassembling Binary file appears to=20
> be a valid ACPI table, disassembling Input file ssdt8.dat, Length=20
> 0x353C (13628) bytes
> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt8.dsl - 78242 bytes File appears to be binary:=20
> found 74 non-ASCII characters, disassembling Binary file appears to be=20
> a valid ACPI table, disassembling Input file ssdt9.dat, Length 0x90=20
> (144) bytes
> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001=20
> INTL 20180313) Pass 1 parse of [SSDT] Pass 2 parse of [SSDT] Parsing=20
> Deferred Opcodes (Methods/Buffers/Packages/Regions)
>=20
> Parsing completed
> Disassembly completed
> ASL Output: =A0 =A0ssdt9.dsl - 1767 bytes
> File appears to be binary: found 32 non-ASCII characters,=20
> disassembling Binary file appears to be a valid ACPI table,=20
> disassembling Input file tpm2.dat, Length 0x38 (56) bytes
> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01 =A0 =A000000002=20
> LENO 00000001) Acpi Data Table [TPM2] decoded Formatted output: =A0
> tpm2.dsl - 1515 bytes File appears to be binary: found 189 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file uefi.dat, Length 0x12A (298) bytes
> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Acpi Data Table [UEFI] decoded Formatted output: =A0
> uefi.dsl - 2505 bytes File appears to be binary: found 37100 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file vfct.dat, Length 0xD484 (54404) bytes
> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01 =A0 =A000000001=20
> LENO 00000001) Unknown ACPI table signature [VFCT], decoding ACPI=20
> table header only Acpi Data Table [VFCT] decoded Formatted output: =A0
> vfct.dsl - 269557 bytes File appears to be binary: found 17 non-ASCII=20
> characters, disassembling Binary file appears to be a valid ACPI=20
> table, disassembling Input file wsmt.dat, Length 0x28 (40) bytes
> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01 =A0 =A000000000=20
> LENO 00000001) Acpi Data Table [WSMT] decoded Formatted output: =A0
> wsmt.dsl - 1313 bytes Low Power S0 Idle is 0 The system does not=20
> support S0ix!
>=20
>=20
> #################################################
> #!/bin/bash
>=20
> cd /var/tmp/
>=20
> acpidump -b
>=20
> iasl -d *.dat
>=20
> lp=3D$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print $(NF)}')
>=20
> if [ "$lp" -eq 1 ]; then
>=20
> echo "Low Power S0 Idle is" $lp
>=20
> echo "The system supports S0ix!"
>=20
> else
>=20
> echo "Low Power S0 Idle is" $lp
>=20
> echo "The system does not support S0ix!"
>=20
> fi
>=20
> =A0
>=20
> Thanks,
>=20
> Basavaraj
>=20
>=20
>=20
>=20
> --
> Stephen MacNeil
> 905 334 5092
> mglessons.com=20
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fmgles=
sons.com%2F&amp;data=3D04%7C01%7CNehal-bakulchandra.Shah%40amd.com%7C64a299=
468a7047508e7308d954d15362%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
634080305647130%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI=
iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DdeJr%2FVlbHHTyu%2BYTUma%=
2BpVhmAMtF%2B968z1hIai%2Bpdug%3D&amp;reserved=3D0>
