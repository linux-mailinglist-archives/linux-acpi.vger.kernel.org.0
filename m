Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0852043CB6F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbhJ0OEp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 10:04:45 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:12545
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242376AbhJ0OEm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 10:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKghmqHaGvqiHRAQybZccAqq8O5a08IDyEI1Ov1RFg+LgOKw/zpdhxja60CMologZG36x2jWiBqBPMcEdiUvC50tTS64n4t6w4mE8j1eOzzAfwSsHPJ1c3Eec3cxcBv1X2oi7uXRIYcl8f4QjveAuvJh2CPd3jZvEj/Lpg+eRpfBSx+jByKK/wpXOm0Bd52rthqh0lFhRbwMqOeQuSyxItCvW7SUcZBFmnJi3rEbjOe0gMUmP+o+6A9LbMvHULynrQ6NyqTMhFbQorCRNNP4rzPVQNJGlIvAuck0J87Rc+FC1C82tT8TbJerpUsZbPG1UrEzxIVEultJww6e1t8MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6qtJfulol8LHfRoRgmvo0RDYwKAGrG2vErCDJGPukY=;
 b=C75cS17N5zArB5XOcrpOW0CRNLpNG/ExKc1RSfVqZOcTE+YTjigt+bs5okzfOqDdIIH505RPr4sltdI1r8Lcv0lC1KhN9u+Ih9klWExPB48HPnCfwhnOI2pedsvMQx2KBETLN2yM6V9DxefnA6IPyi/dFOe6yyQxcE6d3snXKUJCSq/MWawodBB3GikmpRua+qEWs80wnNlE0GsTci1bIrZ/gX9N2DPhyIPsS3e13wIpctKoGQDroQeJN73RmuAdUCdeo91BxrguIiQY4EwhLIbcTQLp16+iiK9VVKoitxNikzE17AXykraS1yPZUSuXum049ICUu9TVDqpDQgfjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6qtJfulol8LHfRoRgmvo0RDYwKAGrG2vErCDJGPukY=;
 b=w73psazep29N/v6+PjxKDExlaBTf9vnZBLiE7IGZVh4Gy2ilHOO3EINZwKXMfgr9JwEzB8qOJtMPfwvaYi6tYaadNndXjJSMxPj+CTitAaHzEZ7PZyAffCTtdp8guDeQWr7db7k7/3sw1OED02xvSwZSdDZUOhZqRYhbST7QZVs=
Received: from DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 14:02:14 +0000
Received: from DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::65:3406:3d73:adbc]) by DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::65:3406:3d73:adbc%8]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 14:02:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] Let other drivers react to platform profile
 changes
Thread-Topic: [PATCH v4 0/3] Let other drivers react to platform profile
 changes
Thread-Index: AQHXypzsc36TFKKQb0muAUEeEhECdavm3lSAgAABhACAAAAxMA==
Date:   Wed, 27 Oct 2021 14:02:14 +0000
Message-ID: <DM6PR12MB4499640A5B49EDC447B49C01E2859@DM6PR12MB4499.namprd12.prod.outlook.com>
References: <20211026190835.10697-1-mario.limonciello@amd.com>
 <2ef89421-a783-e1b2-0a31-1f2be5343e22@redhat.com>
 <CAJZ5v0j-OCekKM1vv3m5JGAMKKcyC2O8hy3ZHESj+Zdx2GRagQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-OCekKM1vv3m5JGAMKKcyC2O8hy3ZHESj+Zdx2GRagQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-27T14:02:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d671f565-7365-458e-a61a-fd1efbb2001a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78863a2b-e7e0-4c56-750d-08d99952614d
x-ms-traffictypediagnostic: DM6PR12MB4636:
x-microsoft-antispam-prvs: <DM6PR12MB46361C2B218204698DCAD05CE2859@DM6PR12MB4636.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GuFpydMAwrD4aI8a5N5B7Q8bNc8ht1+GDtr3GmSFCqT5E0rS4B3F3WxKlsd2rfV49yImG4uR4UKO/wlix8Ig6AJHEAe689KLjExwgM7YRPyyfWoEkNzobShXL4lyar/JXFGwYeEQOkUaommhn+UeKeSwTte8Bia6JVZ+eRbSuK+JTv7sxScbcY2tK3/7PFFJTG5KCTo0LN7hYsvq9ZFAeER1Uso8438AKmN0k8PHsGRhjCP/DgjmyF2hnU7oIoQk63I4ChA1eM7holZfR2CvT0/9bM+RzqrqptfjsLJj4Ei/kfjNkQf3/qAs5hfCrjlvQfUby2MsMOC/xXqXY8Ej02VQX0ihmQhAimh6PBstrBSdJSEy40+KbexG6j6gDjxV66IA90tZG9/nBZGXTAjnAS/qOyl/p1Ix8qLmsWM6PYYh5ZhSH7Rg6NjQ6SCZ8g/SUfO1xkgM+jasgklgUYv4x/r0OY0jdWJOoCik0v8U0U5g98XiTCh2FoZGdt62vQNjFbMfI+EOLe3OqzwvjW5GHYkzcx+gO12XNgZjH2dGb8t58jodKmEzXY1/QDeIBdJoGpOtt+yAaY0f3iinls03F5xY6OEjZ5WRciy814krB/+RHErSIXuzesuGt7020P5HhvFaT4r+s0qZ6Yub9K0fYMkzG/B7klSbpnaMMAXKLRlhXrpvo7nMTUSnLCTT55u1u19DJugk7xZ5DDQzt6hNeb8hNT2w+Aw8rKOnFUFskVbkDxvYxCDBfqtPSXVZa7gYkmTHdNZ3cHGCT0bhHwz0an1HKwVGmA5dM15myl8w8iY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4499.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(33656002)(7696005)(9686003)(5660300002)(38100700002)(66946007)(66446008)(38070700005)(186003)(6506007)(71200400001)(508600001)(966005)(122000001)(110136005)(54906003)(66556008)(8936002)(64756008)(83380400001)(53546011)(86362001)(66476007)(316002)(55016002)(52536014)(6636002)(8676002)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG5FdUlBS2NaMkdoYTVlM2l5a2QrNGtHa1N6UU5NQlBSSkdTOC9GWEt3bkJW?=
 =?utf-8?B?WDdVOGJMaWY3Q3dRTU9IOWhieDN1UzN2R0R5dmhlY3g1UEl4N3E3WGdIUHRQ?=
 =?utf-8?B?T2xqZTdnRmN2K1ZZOFlIdTNqUHpaY24zaXgzWkYyNjlraHJNVFhkdGdhVW55?=
 =?utf-8?B?QzRVNGkyWHp6RVVkMVRyUlNoTHZuUXRpa0JZN0ptb2twWkw3Y2hMZHJXeXVE?=
 =?utf-8?B?czIyUTFkcDFQTUNDTi9VbnoxVHpycnpkRXFuU3JnVmNuVUZXYXBjNjFEYitY?=
 =?utf-8?B?OTRLd0lFaHo4d1RsTkQ1QVpVS3MrTnpWeFd1bTRNMTVvbVVlRzNJS1Z4SVZr?=
 =?utf-8?B?YjlLNlRlTkg3R1B0N0VKekZRblQxVEdOdHNHQ2FBbmh1Q2kwRlVKeS85TFBQ?=
 =?utf-8?B?SkJCMk4vWW93MFVaLzBQMVVyYTd0eDR5Ny8vTVJjMWJHM0hRajcyQTRWckIr?=
 =?utf-8?B?Wmd2TkZLZ29aS2RDUVJSN0NMa3pJMm1mY0xPZ2ZQNTNtK2txd2NFemRTNVNw?=
 =?utf-8?B?bWhuUldpN2k3NG1INkJGcS9ucFRqeThlM1dzRlZwVXBLNWJvb0pLbmV3c0ta?=
 =?utf-8?B?bHlvTnZXQzdPVk9PWDBoT01vUWxjZlVpZ3g5WW5PWXpTSU12bnErK1pqdVZP?=
 =?utf-8?B?S050ZEN4VTNmYU5SWjNjOHBHa2MwRkRzZjJIa1FzVUcySVFBMnMzU3p6STJl?=
 =?utf-8?B?LzFLRmNoeGljcml2TFZSZWYvc1VDdThiK04vVHA5aEM2c3BkYTZWN2FhL2Np?=
 =?utf-8?B?TTlpZjdLOERHenh3aVlCOUx4MmVMK0drT05BbUJMQVNDdFVacURBYW1FZEtH?=
 =?utf-8?B?Rk1GL2FqYWVzMnhaeFNNVTdkUEhUVGswenBrRyszRzlmcXNVUHI2TFFuT0V4?=
 =?utf-8?B?R0xlZFRRUkY1YTV0bmZaaWx0Yjc2Z3lNUzF0OWFTVERnNGNhYmpCRTJ3MGJL?=
 =?utf-8?B?bnZ1dVJjdnZDbmptNFFVZWEvT2N2VFcvUzg5ZC9XeVdLdjZoK2tsR01HOEVV?=
 =?utf-8?B?a0oveW51U2NxaGRockhaL1I2RlRBVDFFRmxxdHdxMkRPdTI2Rmkvdy80M0Qz?=
 =?utf-8?B?SWpseCtNM2hSVlErZlhSV3dCNUdUQk1zSkNnVmRDSHk5NEVzakhETTdKVGVO?=
 =?utf-8?B?Y0Rmd2tBRGRtK2twVVFzOFhFS3BtZVJ4L2kvRG8rUStsVHR0SFIxUld3Z2U4?=
 =?utf-8?B?VkdkMEFlWUV6Q0pIU0hwQ1A1QjlLbTdxVWUvOFlhcnNoRTN0SS82M2prWjRl?=
 =?utf-8?B?NXZENnEzSXZWUjVPK0hRZlhQOERTQWlrK0pMTDhST1lyR2F6YTVzMm1rR2FK?=
 =?utf-8?B?TGtTNExSNXpCV25iWmdUZDNzZmJtYTFrWStFUXl3UStqV1RDOHpKZUFCSkpM?=
 =?utf-8?B?TGs5S3FRSE9MdEd6OFJIQ29OUjhxZXdQNjgyeUhzQVlxZWtWMHBDbzBIQ2R5?=
 =?utf-8?B?a3R0OUxqaXJ1UVVkb052ZklJa0YwVnppOUp4QVRXN1RzNkY0Kzk4UTBacFZB?=
 =?utf-8?B?N2NjMTlxS002aG9kNCtscVFNM1JQM2R2N0VKQmpZRzVxWkVxbEx3U2hqUzlP?=
 =?utf-8?B?Rk9NTmxLZDh2ODg5NGp3TDYyd3pjN1NoSUJlekpMS0xWM285b2dmd01wWTdn?=
 =?utf-8?B?N1AxMjdZQWZ0enNGdzNMV2JJalNVdXdBY1VSLytVQTBHdnRhamJBUUxpUnBx?=
 =?utf-8?B?bVIxbk90WlJ5MHl1ZzM5Z0RzTndKYllrRW9pWUN3ZXZnc0FzTVNmc2xsbW9i?=
 =?utf-8?B?TWJ4bityaE54OFNuZWtzL2ZaZjBaOEpPVXJqSXN1UWcwOXZHeW4yMEdaR1dV?=
 =?utf-8?B?bW9UV2cvTTdrSUNpOE9CT0VkcVZBbmZTeFRPbUc0Z0Vpc0RKWnVPMDVEcVFv?=
 =?utf-8?B?emsxYmo3YzlPZjQwbFRzeWVibGZ5b1RveTdpc0RXTnk5WUpsQXpOTDE3c1Jn?=
 =?utf-8?B?WjZtZThuL1gyaC9LUm45dFFHQ1JkcFpOaWFLNXoxUGdlMHowOWVrNGx4UTBu?=
 =?utf-8?B?dkNweWMvS2xJS2cwV2tNTTBNaFhJdVpzcHlqUkdiRENqQUFBRDdVR0tmb3Ft?=
 =?utf-8?B?Uit1bmZnbDBNQ1RjS29icDlpRzdDN2I4Z1hEbFpSdmFRYTZXTFozQS9Ubzk5?=
 =?utf-8?B?Qm0xN2hISnljYzZTekVNbXlYd3M3U3hZbmpJVk41K1pYN0hQajZjSWJIWkVa?=
 =?utf-8?B?dHdGencxNkZNdlZmRTJFaTg3ejI1eUVOZkU0akhuZWk3a2dSVFJqUVc4QWJU?=
 =?utf-8?Q?5xZfOACzDe4iUmae/QkQ6tBcC+sk2r/rtDCvzEgz5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4499.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78863a2b-e7e0-4c56-750d-08d99952614d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 14:02:14.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6aUPB+LdHuEPj+g2W4rNcdXyO2SRLrgTnXGnVc5jx8mQ4212cqecx8eeQ+yK66bH5Lsj0m4ZsQbbIyU3PkJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KK0FsZXgsIFNoeWFtDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBX
ZWRuZXNkYXksIE9jdG9iZXIgMjcsIDIwMjEgMDg6NTcNCj4gVG86IEhhbnMgZGUgR29lZGUgPGhk
ZWdvZWRlQHJlZGhhdC5jb20+DQo+IENjOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9u
Y2llbGxvQGFtZC5jb20+OyBNYXJrIEdyb3NzDQo+IDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsg
UmFmYWVsIEogLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IG9wZW4NCj4gbGlzdDpYODYg
UExBVEZPUk0gRFJJVkVSUyA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+OyBN
YXJrDQo+IFBlYXJzb24gPG1hcmtwZWFyc29uQGxlbm92by5jb20+OyBBQ1BJIERldmVsIE1hbGlu
ZyBMaXN0IDxsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMC8zXSBMZXQgb3RoZXIgZHJpdmVycyByZWFjdCB0byBwbGF0Zm9ybSBwcm9maWxl
IGNoYW5nZXMNCj4gDQo+IE9uIFdlZCwgT2N0IDI3LCAyMDIxIGF0IDM6NTEgUE0gSGFucyBkZSBH
b2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBNYXJpbywN
Cj4gPg0KPiA+IE9uIDEwLzI2LzIxIDIxOjA4LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4g
PiA+IEN1cnJlbnRseSBvbmx5IG9uZSBkcml2ZXIgY2FuIHJlZ2lzdGVyIGFzIGEgaGFuZGxlciBm
b3IgYSBwbGF0Zm9ybSBwcm9maWxlLg0KPiA+ID4NCj4gPiA+IFRoaXMgbGltaXRhdGlvbiBtZWFu
cyB0aGF0IGlmIG11bHRpcGxlIGRyaXZlcnMgd2FudCB0byByZWFjdCB0byBwbGF0Zm9ybQ0KPiA+
ID4gcHJvZmlsZSBjaGFuZ2VzIHRoYXQgdGhleSB3aWxsIG5lZWQgdG8gZGlyZWN0bHkgaW50ZXJh
Y3Qgd2l0aCBpbmRpdmlkdWFsDQo+ID4gPiBkcml2ZXJzLg0KPiA+ID4NCj4gPiA+IEluc3RlYWQg
aW50cm9kdWNlIGEgbm90aWZpY2F0aW9uIGZsb3cgdGhhdCBkcml2ZXJzIGNhbiByZWdpc3RlciBm
b3IgZXZlbnQNCj4gPiA+IGNoYW5nZXMuICBUaGUgaWRlYSBpcyB0aGF0IGFueSBkcml2ZXIgdGhh
dCB3YW50cyB0byBjYW46DQo+ID4gPiAxLiByZWFkIHRoZSBjdXJyZW50IHByb2ZpbGUNCj4gPiA+
IDIuIHNldCB1cCBpbml0aWFsIHZhbHVlcw0KPiA+ID4gMy4gcmVnaXN0ZXIgZm9yIGNoYW5nZXMN
Cj4gPiA+IDQuIHJlYWN0IHRvIGNoYW5nZXMNCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIGZyb20gdjMt
PnY0Og0KPiA+ID4gICogU2ltcGxpZnkgcGxhdGZvcm1fcHJvZmlsZV9ub3RpZnkNCj4gPiA+ICAg
IC0gTm8gbmVlZCB0byBjaGVjayBjdXJfcHJvZmlsZSBhcyBwbGF0Zm9ybV9wcm9maWxlX2dldCBk
b2VzIGl0DQo+ID4gPiAgICAtIE5vIG5lZWQgdG8gdHJhY2sgcmV0IGFzIGl0J3MgdW51c2VkDQo+
ID4gPiBDaGFuZ2VzIGZyb20gdjItPnYzOg0KPiA+ID4gICogQWRkIHBhdGNoZXMgdG8gYXZvaWQg
Y29sbGlzaW9ucyBpbiBocC13bWkgYW5kIGFzdXMtd21pIHN5bWJvbHMNCj4gPg0KPiA+IFdlIHR5
cGljYWxseSBkbyBub3QgbWVyZ2UgbmV3IGluLWtlcm5lbCBBUEkgd2l0aG91dCBhdCBsZWFzdCBv
bmUNCj4gPiBjb25zdW1lciBvZiB0aGF0IGluLWtlcm5lbCBBUEkuDQo+ID4NCj4gPiBJIGNhbiB0
YWtlIHBhdGNoZXMgMSArIDIgbm93IGFzIHByZXAgd29yayBmb3IgdGhlIGZ1dHVyZSwNCj4gPiBi
dXQgSSB3b3VsZCBleHBlY3QgUmFmYWVsIHRvIG9ubHkgd2FudCB0byB0YWtlIHBhdGNoIDMvMyBp
Zg0KPiA+IHlvdSBwb3N0IGEgbmV3IHNlcmllcyB3aGljaCBhbHNvIGluY2x1ZGVzIGF0IGxlYXN0
IG9uZSBjb25zdW1lcg0KPiA+IGZvciB0aGUgZnVuY3Rpb25hbGl0eSBhZGRlZCBieSAzLzMuDQo+
ID4NCj4gPiBUaGF0IHdpbGwgYWxzbyBtYWtlIGl0IGEgbG90IGVhc2llciB0byByZXZpZXcgMy8z
IC8gdG8gY29uc2lkZXINCj4gPiBvdGhlciBtZWFucyB0byByZWFjaCB0aGUgc2FtZSBnb2FsLg0K
PiA+IFJhZmFlbCwgZG8geW91IGNvbmN1cj8NCj4gDQo+IFllcywgSSBkby4NCj4gDQo+IFRoYW5r
cyENCg0KT0sgVGhhbmtzLiAgQXQgbGVhc3QgbGFuZGluZyAxIGFuZCAyIHdpbGwgbWFrZSB0aGlu
Z3MgZWFzaWVyIGxhdGVyIHdoZW4NCml0J3MgdGltZSB0byBtZXJnZSAzLg0KDQpBbGV4LCBTaHlh
bSwNCg0KVGhpcyB3YXMgbW9zdGx5IGluIHByZXBhcmF0aW9uIGZvciB5b3VyIGRyaXZlcnMgdGhh
dCBtYXkgYnVpbGQgb24gdG9wIG9mIHRoaXMuDQpQbGVhc2UgZmVlbCBmcmVlIHRvIHB1bGwgdGhl
IGxhc3QgcGF0Y2ggaW50byB5b3VyIHNlcmllcyB3aGVuIHlvdSdyZSByZWFkeS4NCkZ1bGwgdGhy
ZWFkIGlzIGhlcmU6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9wbGF0Zm9y
bS1kcml2ZXIteDg2L2NvdmVyLzIwMjExMDI2MTkwODM1LjEwNjk3LTEtbWFyaW8ubGltb25jaWVs
bG9AYW1kLmNvbS8NCg==
