Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF74C43BA22
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhJZTFW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:05:22 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:20032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235216AbhJZTFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOovjyDqPYUBr94Bk9sHvjbeS91giY0saGrlkHbGDgrQnyWKRaCiDzkkcPFGFDAbAlBurcc51BywUkNkH6pZW1rjJhtOkKCmlXn/JxPDixx4B88F3edAV+luoiSBvwlrdZowGxIH7JWLHOwcon+3nx1yNVMeQ4AsHYTxtCKcGYJb4baVscD/Y0guL8/n/jQU/6tKwaN07YRfxK1ZjYRX9LiMhMCamDqfJV9I835foOJaAPZAJoTjQ6sDg59hKkI0bd5saPUqXPpN/W0OyfvLvzuPYkXREiTdo+f3f7QcGJ4Y9Ig8ILvAeiS9C+tadcpnuQtHwW53rbj1HKr2JSRtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsLZeO2t/chj+kOwDeP8EVjpWx4Mqx/z58SmHzNugos=;
 b=XqG2yf6EVKKeQYTvI5REPg++ldJrpE5sVnG+Y/68ganEXMafSesMUjhYgEmH/Hnf9VbkN2FNSCS9b9mKKzrUx5mlhimhzF+u4MdjSkmRHvHIvoY5zADRBiX2Xxl4bPO9MPaYB+Ab71VkqvbHDnCCzT1Pmv/sauSYDl+jiQaq4h6INpfG88RDLu8DkzBLuiFhU0PXfpZf8bHegUdaURbxGM9adq/9cgULL70I7WPws3tMfXIpZCOSWa7oGpILIUlr7aOy6Wn2hgwbeq4mLtT8qbGQNheumViD5ft1NbBpi9CKs7oIPK+3nxL8MDvYSWYrmE+PvEJp9mDQlt+UbdczPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsLZeO2t/chj+kOwDeP8EVjpWx4Mqx/z58SmHzNugos=;
 b=0r4jANGyactFfgwXf9OVSUHfEu12Sssdt9Mrue1obdsdbuX2dh/WyPoHoIhnAPUy7LJUnphFugo6Fr7cpkH3LLVPUv26dS+bA6DhxaMSjl7wyOHLyKl2/VgW0skEA7lgxqtsVWPHOND3ZVsuyxlrWHp6vX4pj+kppQ66GM4JlUA=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 19:02:54 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4628.018; Tue, 26 Oct 2021
 19:02:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support for
 notification chains
Thread-Topic: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support
 for notification chains
Thread-Index: AQHXypQdQ8zuZQAM5kC+K14GdI5IOavlm4YAgAAAM7CAAAPJAIAAAyyA
Date:   Tue, 26 Oct 2021 19:02:54 +0000
Message-ID: <SA0PR12MB451044317D017725B27AFCB2E2849@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
 <20211026180535.9096-4-mario.limonciello@amd.com>
 <9a4ef81f-a064-31c0-d52a-42f79b12191f@lenovo.com>
 <SA0PR12MB4510745D300C9E3239EACA00E2849@SA0PR12MB4510.namprd12.prod.outlook.com>
 <ac75f7c5-6579-9d6e-6bcb-ed067f3889f7@lenovo.com>
In-Reply-To: <ac75f7c5-6579-9d6e-6bcb-ed067f3889f7@lenovo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-26T19:02:51Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d6b07fe5-7eff-4970-af4f-8e1a4bc5bdb0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lenovo.com; dkim=none (message not signed)
 header.d=none;lenovo.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17abce50-250a-4c35-f0d5-08d998b33734
x-ms-traffictypediagnostic: SA0PR12MB4512:
x-microsoft-antispam-prvs: <SA0PR12MB45124C48C7CF7DE02EAD8563E2849@SA0PR12MB4512.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xyy7B9TMHLL1Af4Z11J5hGRJbXS3MThf+nDW05i4EEzIYBNJCY0rx/u0bHA1x7tKzLsFdQJ9qQT4LyFRiV4QyG0BqAvc6s6IlgmAa+rw22uYi9ZRI63AGubPC0fdvSZnQQCZIAMNMSfxZ4j1U7zpzmvbVm8y9RRdGO6/uep/++2juYAktrfRYf+qwsPCF6cqB6kFgOK/jNkMEFuxSuzaG2KDneXazGY3fKwiKzpIjqqc0m60kWJre7VKM1Q4LYFEC7E5hfswx0FVE5mrYx/YTYEHtWuIN2dpRSY+zYp44o68dQPegclqTREq8C4QIT2uPD7qX5IrvOW2ZMidjxn7M8BxmT8TTjp9/rknLTlqx0Q9ETl2X/rKKd1wBFdS/+JP4PsNzVHtytIv6fxZyfIj3Wb9QNDshNxN+e3Jx52BxynRrlG5annQH9CEqpbAIHxjRNEbMe+Ug8oMrbbl5QX0e8rHw/CIHTtOCb7X/ZIDu5bUfcPs7oEcwucVJSXbylwIwJpZjsOIluYUzXDMRhGeoMdw1XpzSCwNmkyf0nvIfOOrskaSgPuxIUbgoyJCHqjKxy7UR17XXN8qNF8zxOIq4FAstI2ZQJOeUP/ohE84NScCbglnLnH4+qxHy8+Ujxyc6a/+J8m5bS4QR0FSwDfMhc5NSrapBCERlMpmVAbAXvUf9PIJu8F+2BGtxHY4QggP6QFZs/YuPqvC4oUpzD/3Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66446008)(26005)(76116006)(64756008)(66946007)(66476007)(86362001)(52536014)(186003)(53546011)(55016002)(38100700002)(6506007)(33656002)(5660300002)(9686003)(66556008)(4001150100001)(122000001)(7696005)(4326008)(15650500001)(316002)(38070700005)(83380400001)(2906002)(508600001)(71200400001)(110136005)(54906003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTFkMkhoQTBBcldHcnRNVXdSaGFlZTlaT0dtdW1wYll4L2RVeldpUVlPZTRL?=
 =?utf-8?B?Yld6V3ROQkxzUkxkMHZVSDkrQjBzbUtnSTcvSUZZeGFER01zbWRiMFRCTEtj?=
 =?utf-8?B?clVsMUNmM1ppaENVSTlNU0MvZnBkMUptZzF5aFJMMEt6YlMwSjRObVpkRDZL?=
 =?utf-8?B?ajlVU3BuSXduVk9seEV1VStUZkxXWXk3VlBDSDN0UExxSE5aK3R3WTU5c0ZT?=
 =?utf-8?B?dUw3TjhObE9LVXMzWmpoTTJCRUIwQlIwVjgrT0psRGRkcVZyWlFQWkRKTDdy?=
 =?utf-8?B?M3FrdDQ1cWtLazN5aHltM3YyNmxnbGE2U0ZGMTJjY2F4bko2b3Nhb05UamdJ?=
 =?utf-8?B?SFVoOTVEejdDUHRyd01mOXRrdEJoS0RNeG0yVEdNWUc0Mk9qYU5vZlNlUWRw?=
 =?utf-8?B?MmJKcnczejlndjhYSmJzZlBRVTlIYjVCbXVIM0RsNS9mME5naW9mQ1poNzcy?=
 =?utf-8?B?T0ppUDBWVEV4U293UGlmWUZYTDRDZ0kzMkxpclRlVDc3V1VHY213RHJXc2Ns?=
 =?utf-8?B?VU5mUXlQQWRxVDFsK1RmbVQ4bkRJdjU1K2h2M25OTFdsdkVNS0wyR3dFQjlN?=
 =?utf-8?B?UTlKR2tYbjBlYXhQakdZb2cwbXVjaEJGd2NmMjdpdHZMNHUrTEd2SEZJSndw?=
 =?utf-8?B?U3N1ejFGYTJCYm1TcURDNjdvcWtuU1pQMWltVTdWc2c3SFNBN3VmSmpmMlIz?=
 =?utf-8?B?YTczTHkxZWxwZ21kREpMTmgxRVdmckUrSmpuTEViaDdySVhvSzR3Zmp1YVJp?=
 =?utf-8?B?bUtlQ2RRU2NHRktZejVYSU9Pb1hmT3lIVmZVblRjT0pJT3B5dmdNRk9FYWZh?=
 =?utf-8?B?MXpMM0JSYXMzRXkvcXdIakE5RHFjTGQ2M3ZKQlR5NkcyY3NhNVVSMk1qSERl?=
 =?utf-8?B?Q3h3dVRQZzdQVVFhZVFzQUpablJLMjJ3NmYrN0dhaHF1UU1sclJmeCtNZGs1?=
 =?utf-8?B?SXFJVmVnMWJEaWZ0dDVXSXJYVUlOWWM1WFI0MS9laFN2Zlg3bGZiQTlJNFhS?=
 =?utf-8?B?eXd6cTRzUSt5NUFPY05BbjNZcGxoTktMVVVDQWdzUm1kZHd2K0Y5d0xoTFJw?=
 =?utf-8?B?WlZZVWUzK3htZmlRUjc3Q2Z0VG1lUVFkWTR6c0ViRGoyS2tPdzQ5RkpPTWtW?=
 =?utf-8?B?Mkh2SWc4N3V4ZkJ6bW8wc004ZCtkT1pJMk5kVlptTDMxc0dPVVJGb2tSeDhh?=
 =?utf-8?B?Uk9MME9ncUdZRThOMmVGaHFDejR5WXQ1bjZGelJBSFlSUWw2ZVFZcTVvdlky?=
 =?utf-8?B?YlpvT00rT0R2aVV6UlkxOGJ3MDFpRGdsZjFnM2haQ1oybEFJbjNHaGUxM3Ux?=
 =?utf-8?B?Wmt6aWRwQVZQWGNxeU5GYVc3cDFqV29ZME12T1BYQVgvUytSOFRXcjhMZ1VR?=
 =?utf-8?B?ZHlCUXpOa1RSOVhmdFFaeEgwSmd4bnVjSDJsWHkwQ0NXTHJuZkNjT0kwQy9q?=
 =?utf-8?B?bk9NY3FQbHFRVHZJVnAzMXZ0cmJBcDNaUW9zdHpuNlZPdktyVjRKbkw2M05T?=
 =?utf-8?B?aFlCNDZYYTVVUFRlM1NwRnJkWTQ1MFpuU3VpeG9nVjdMLzVaU3VVU3plQjFa?=
 =?utf-8?B?V2VFR01aYmJRMXZnZDl3b0dNak0ramFxdC96V2dkc3dwdSsyQmwydG90eXZw?=
 =?utf-8?B?L0Vzd0h2WnJiL2dZMlpqMWhHTTR1Y1c1c0hFV29TK09GSHJQR3o4YVA2K2Z1?=
 =?utf-8?B?bXhHdk1KNTYvdWI3c1NxZVZrdEJVZzQ0ZTQ2ZXhLUzU0N1VpV1NvUm95czJR?=
 =?utf-8?B?NThOLzdnVzcxVHg0cE1qaFgyeGYzNmxnMVFDS1E0SytJUXhEU1Y0eFJwSjJK?=
 =?utf-8?B?SEYwSlBFeG9qUEdmMnVmZFZsTG9JNGVxNlBOWEVXUklvSTQ0M2FKeFFuQWp5?=
 =?utf-8?B?VGhDaHlNeUMxdEJDNi82dXNvcDVaUWxOWGhBSHNTUXZRRCt1M2tmZk1KN0wr?=
 =?utf-8?B?WlhGMzdGaUpiaGhNQk9vYkppNDFzR2VOUGNIT3dVU3RSV0ttU2VPdmhMdG5v?=
 =?utf-8?B?Z3BHREIvanhURFZHcWNBSXJhaHhGa0F2QkR6Z0RCeXg4U3ZaMFVEdUpza2gr?=
 =?utf-8?B?SklUQUtNRUptaGR1eUZhU01ZL1k2YUI0TXpMTUE4ZkxoTG9ia2JWUWhkVURX?=
 =?utf-8?B?aXdJbk56WEdBMmkvQks4cDFaMFZDWi8xZXA0R3pQbDA0bnJPWTZUMzVnb1FS?=
 =?utf-8?Q?KbYRxba+YPOjB9gQg6+iBeU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17abce50-250a-4c35-f0d5-08d998b33734
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 19:02:54.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbcR0uQE5iCIknYdaGBandEC42r09qaHO6o7a4qWJn4o7nfDs57SWFrOAJDBksp7Du6N36YZ80/hrpxOOFp5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFBl
YXJzb24gPG1hcmtwZWFyc29uQGxlbm92by5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
MjYsIDIwMjEgMTM6NTANCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJr
IEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsgUmFmYWVsIEogLg0KPiBXeXNvY2tpIDxy
andAcmp3eXNvY2tpLm5ldD4NCj4gQ2M6IG9wZW4gbGlzdDpYODYgUExBVEZPUk0gRFJJVkVSUyA8
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1hY3BpQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSBbUEFUQ0ggdjMgMy8zXSBBQ1BJ
OiBwbGF0Zm9ybV9wcm9maWxlOiBBZGQgc3VwcG9ydCBmb3INCj4gbm90aWZpY2F0aW9uIGNoYWlu
cw0KPiANCj4gDQo+IEhpIE1hcmlvDQo+IA0KPiBPbiAyMDIxLTEwLTI2IDE0OjM4LCBMaW1vbmNp
ZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJrIFBlYXJzb24gPG1hcmtwZWFyc29uQGxlbm92
by5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjYsIDIwMjEgMTM6MzYNCj4gPj4g
VG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEhhbnMg
ZGUgR29lZGUNCj4gPj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJrIEdyb3NzIDxtZ3Jvc3NA
bGludXguaW50ZWwuY29tPjsgUmFmYWVsIEogLg0KPiA+PiBXeXNvY2tpIDxyandAcmp3eXNvY2tp
Lm5ldD4NCj4gPj4gQ2M6IG9wZW4gbGlzdDpYODYgUExBVEZPUk0gRFJJVkVSUyA8cGxhdGZvcm0t
ZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwub3JnPjsNCj4gPj4gbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtFeHRlcm5hbF0gW1BBVENIIHYzIDMvM10gQUNQ
STogcGxhdGZvcm1fcHJvZmlsZTogQWRkIHN1cHBvcnQNCj4gZm9yDQo+ID4+IG5vdGlmaWNhdGlv
biBjaGFpbnMNCj4gPj4NCj4gPj4gVGhhbmtzIE1hcmlvLA0KPiA+Pg0KPiA+PiBQYXRjaCBzZXJp
ZXMgbG9va3MgZ29vZC4gT25lIG1pbm9yIHN1Z2dlc3Rpb24gYmVsb3cuDQo+ID4NCj4gPiBUaGFu
a3MgTWFyay4gIFdoYXQgZG8geW91IHRoaW5rIG9mIHRoZSBvdGhlciBpZGVhIEkgaGFkIGluIG15
IGNvdmVyIGxldHRlcj8NCj4gPiBJIHRoaW5rIHRoYXQncyBhbm90aGVyIHdheSB0byBkbyB0aGlz
LCB0aGF0IG1pZ2h0IG1lYW4gbGVzcyBzdXJnZXJ5IHRvIHRoaXMNCj4gPiBzb3VyY2UgZmlsZSBh
bmQgb3RoZXIgZnVuY3Rpb24gY2FsbC4NCj4gPg0KPiA+IEknbGwgcmUtc3BpbiBpdCBlaXRoZXIg
dG8gYWNjZXB0IHlvdXIgc3VnZ2VzdGlvbiBiZWxvdyBvciB0aGUgb3RoZXIgaWRlYSBJIHB1dA0K
PiA+IGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+IA0KPiBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3Bp
bmlvbiBlaXRoZXIgSSdtIGFmcmFpZCA6KSBHZXR0aW5nIHRoZQ0KPiBwcm9maWxlIHdoZW4geW91
IHJlZ2lzdGVyIHNlZW1zIG5lYXQgdG8gbWUgLSBJIGhhdmUgbm8gb2JqZWN0aW9ucy4NCj4gDQo+
IE1hcmsNCg0KT0sgSSBzbGlnaHRseSBsZWFuIHRvd2FyZHMga2VlcGluZyBpdCBhcyBpcyB0byBw
cmV2ZW50IHJhY2luZyBhcm91bmQgZHJpdmVyIGxvYWQNCm9yZGVyLiAgSSdsbCBhZG9wdCB5b3Vy
IHN1Z2dlc3Rpb24gYW5kIHJlLXNlbmQuDQo=
