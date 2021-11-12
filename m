Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4744EE71
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Nov 2021 22:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhKLVVH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Nov 2021 16:21:07 -0500
Received: from mail-dm3nam07on2059.outbound.protection.outlook.com ([40.107.95.59]:63104
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235720AbhKLVVG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Nov 2021 16:21:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvyeZY9khRqAGMNBLRMQd8hymypSOn5bvHTjet9Jvh4W2jNKdkVCUN23espPS2m5Rq95xXHEq0Wi3lq/tbRdNdy7o+izyzq6EmjPoT02UA6l6LOxw9r3x4B1QKeTtREwUMpTXjw9xOvD9QniO1S8yIPzKKPOPZe+o24oAxcvInVWbqIcg5GqzcXxyDHh2wyYy9fIkEqhc736qh3qgNbT+jScECgtCWws5cpll4ME1UMnOO+n0pxRqigXFufXzZqRR3yv+BnvX2UeTtUZcWb0qDGP3VJnYF7kakExANFwN4fvgHOystS7gjQS0gOVZ2FU/mOWOnUrXp7mFHUnFhBSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXOBcaS4cFXUGSkNJWqedM3+zo3EG9QVnkm+Jyy9rjM=;
 b=GrLzUZ1PQoCDyYqJxtd6e0ZQ9ULYP83GNxoZC/e9iIcng6aJHUKT5D5L+ObTbauqlh9MjRz+QJPJPfPrCGhhXqzFRuaP5N20NS6z4ok1TJWQfWZZucCg/hS1HamWRWvdylRzs5wLMtiLN3B7kGL9RjuDa995sfwcUVJUC0nxSIv3hKXdqqcR+5tOVTJopYdx42Z/SJ94b0M9+R5qK+RMqSL6CMR8j2xQ49CcqzT6htGe6iBHhVyL0SLYAZGregZzpTqh0+bWF2Ae+wnlo6s3HuBFdoWXLbS/V6/wuaMXcfgehGgjC7zGWEUBMElPY0Ck9x2nH+X/NPBVsLrVODAJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXOBcaS4cFXUGSkNJWqedM3+zo3EG9QVnkm+Jyy9rjM=;
 b=HX3UkvNm8uGnj5kmyJTkE0F52exi6WYQlax525o6v3eSXZQi7RlQzNvsqq3Y4RhzmO+agvQYSq9o/gexIABmoSx/KgdWZeXCa5tfSeiddmi3STK8hkUSRJbKUVBu9oen2NlEcqpA4svq8U846oKmMJYaR4zgDR9rChPpWE4wcPc=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 21:18:11 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%7]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 21:18:11 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandey, Ajit Kumar" <AjitKumar.Pandey@amd.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 RESEND 2/5] drivers: acpi: acpi_apd: Remove unused
 device property "is-rv"
Thread-Topic: [PATCH v2 RESEND 2/5] drivers: acpi: acpi_apd: Remove unused
 device property "is-rv"
Thread-Index: AQHX0lYtuAxf/CFj/02DaeaZuiCHt6wAcCpg
Date:   Fri, 12 Nov 2021 21:18:11 +0000
Message-ID: <SA0PR12MB4510169A485EEA547A8D7564E2959@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
 <20211029063228.578909-3-AjitKumar.Pandey@amd.com>
 <CAJZ5v0jXnwC-C8mAWtQDtoPko9ALAYhpm3X-TZ5L83ROEUJWmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXnwC-C8mAWtQDtoPko9ALAYhpm3X-TZ5L83ROEUJWmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-12T21:18:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=23d5cc13-4ef5-4a8e-abd1-97abaed25986;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f2083a2-3297-47fa-b380-08d9a621ee79
x-ms-traffictypediagnostic: SN6PR12MB2686:
x-microsoft-antispam-prvs: <SN6PR12MB2686EA2B92297FE70060F96BE2959@SN6PR12MB2686.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnS7+xlCNXrZazts4Fbjb197UhuIPKq9rEK3bMWdHRtHVXytUxL+pAmKgF6zkBrhoabCDvb4A0ZS7QIrPbQQqnaIk1Jo4oHI6As4dRGTEOCBcPTZIKkysqSyfHepZPgoGcE60HaNr3iRPhAB8ae77tu0N8mT7aXRM8gwkFGfPVIPKDN5kHhZqXLmQz5ROyZNSgv5sbG+h9rKiqDupSMEdT8pTKOuLhnjo9XItondnO7TY2JX2FxVJNtMvMz5NwjyWecTCYie1NqW7q/vyf2Hu8/VX5hvbCqTgoX4rmLeXXvYJPFj7Wa6KRK+cG8oO4EtAsv8iTcDJk09tBN6uoWThPFzOMUxOyh6vsHn6UL/ocJ8l0Y6PbrYjqj6Am6U4b5/P3ZPQD5fy2zwwqMTdcw9ZZ8O68Fr4g602LnUExw6Y6hC/WyRoED2QYykVLzQdGkI1mMsXEut+XKFJ+yOdVHxk9HWPGZo2Lzur6iRViOoRUb5okxb4mh6vuHjf+4CGBccj/My7zyWyDk8VRSrAnyJQkvXFdEkOGJeVNyNT0+VXxTXDLpMKhmQLxM4xL2yHgdYvTYAWAq/NJHGKp9sJlFwXTzFoRaMH2YRywTApkSw7lU181tM7Gj3inN+BOT/Xr7ILZybuIPjgm17qGFO8H7yeRgVmkbdTGnFcBCRf9tpqV+kOmp3JnHIj77sIokva7MSRVw0kAiJBEydLrmzRs3ZNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(53546011)(122000001)(54906003)(4326008)(83380400001)(110136005)(38070700005)(316002)(508600001)(33656002)(2906002)(76116006)(186003)(7696005)(86362001)(5660300002)(6636002)(55016002)(71200400001)(9686003)(66446008)(8936002)(66946007)(26005)(66556008)(66476007)(64756008)(8676002)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWs4eGRzY0xZYVQrQzFIbGpWQjd5VGhZRG1tcWFVZmE0MCtibVUwZDZVSFRV?=
 =?utf-8?B?RUg0b29zKzg0aU00eVBhOTFmbUlvaVhPY3B6ejdzWHVYVVBrY3oyVkZoRk50?=
 =?utf-8?B?Y0thMXVJN2ZVdmtqMHVnM1I0K1F1VWttUjJ0YnZ1ME1nS1lYS2JZYUxsV3Zw?=
 =?utf-8?B?TFIzTjBjeUVPN3FtRTZESnd6ZldnVWRLVjFYYVZKcWt5M3pQaE9tQ1dlUDVN?=
 =?utf-8?B?dndFVGQ3VWg5N2g5cDNrZlRDOGlQRkFSZEUxeUkvenNRcXRZNlJDVlIxYzRn?=
 =?utf-8?B?d1d3T082RWh6bndOZ1ZwY251NWdOc3dqSXY1UmNxZFd3RDR1ekhBMzRUbEVu?=
 =?utf-8?B?M2hXcGlVN1JudVM1MVF1a09yKzdzQnhOcVhPQ2RMeEJPZkJCMUtCeXFnN2Nm?=
 =?utf-8?B?TnhRK0RaREFGcE5HTlM1RFRucEVtcSsyeXgvUDNqWjJ6ZnZPckpxWWw1Zldr?=
 =?utf-8?B?Ny83Rmsyb042OHEyb0U1TjQ0QThkRGFLcit1bDdMUG5wZ1ROcTBURTU0YWc4?=
 =?utf-8?B?dWNLOTNZdmhPUStYRjF5MFd4QUJWdmo2by9abHhnQldreVhkTFJ6QVNrSUtq?=
 =?utf-8?B?VThCMm80NzdXK2lNckgxNXJWTjJmZGtjNW43VUtRV3ZiYVFBQ3ZkN00zNGp2?=
 =?utf-8?B?dTNhSTFmck5lZ0xvVURVVWpNaHJGaWhEUEV3K3o5bStVMGF0aFRCWVpWbFJO?=
 =?utf-8?B?Sm5sK05MMWxwS29rZm94SmxQa1NOMzBJcHJXOUEyL3JFcUEwYnFLVmFVekZK?=
 =?utf-8?B?bkZqQVlVMVZQb3ZKRnY4eVdQZzZTTlJmT0NhWjIzL3FDS3VLaWtNbjRqRDFs?=
 =?utf-8?B?WlZEODZwTzhzZUVNcDh1RVVwd3pQVXRpRnBnbkdaSjlsL3N4SUVseGNMcnVH?=
 =?utf-8?B?b2FCTS9yUm5XMkV1RFZUR0drWXZ4SXlFeXU0Q2QwYnpqbEtxdDZWRHJ3MVpY?=
 =?utf-8?B?bDk5Vm5wUHFxYUNTaGpYUWJSSHhJbk5mbndYMTNwRjFNNlpFSHlaS2s0Y01i?=
 =?utf-8?B?ZUp3cWJaRWNscU5EUGRsSjZhU1Y0dEV4SXJPejdlYWVmRWxwRWlmRTFtQUNs?=
 =?utf-8?B?aVArVllkZVZWM0xNRUVodkVRU2lZY3l3aUNuTUF4ejAxcXV4cDhWWmc5MUNk?=
 =?utf-8?B?OGRHNlNzYUI1bzJoMDdGQzFZc2hZV3ZaTndJdmxQNFVralFhMjBGMjJCQTFL?=
 =?utf-8?B?ZjBjeWF2ZzFWbkdJNkExOENJTkJwNXJZOEpwWXJTM3RaVVE5c3p2Ym1lSDls?=
 =?utf-8?B?WDNCS2lONjkvbVlycE9oTHpaVkNoU3ZvMWU4clZURW15LzVMam1KRXIrS3d0?=
 =?utf-8?B?OUM1KzJPa0srNnJhamQvWS9RaXRwaWJkcHhHTWtMcWkvVk80N0xqMEpsTzJv?=
 =?utf-8?B?dytMNUNKcVlYb3JkRjRhTFNuMnd4em4wZHArOGxHeUw0TGsza1Z2RjFHZWp6?=
 =?utf-8?B?NFhxWGFsYmUvSE95U3NYaUx1bEUySExrbEJpNmlUYWNWbG1hbStuckZRYXpW?=
 =?utf-8?B?WkRLM3ZIdFU2b0tndmkxZktKM25ocHJzMm0yY29iNTZSSUhFYVl1am5jMDI1?=
 =?utf-8?B?dU9UZGNGT2FRYVFWOVkySzd5Z2lEZ3Z4cVB6T1NXZVpGNXhTWTBhU0FLZ1JB?=
 =?utf-8?B?VU5STTNRQ244cmcxWmNKaVhwekVkNGlRRkw5b0owbHFYdVVaQTlTd3NyRVZw?=
 =?utf-8?B?K2htOCs4OTRteTRtTlRTWExNenE1ZGJkNDVrL05VZ2Z4SGJDU0VsYXVJZEhj?=
 =?utf-8?B?UU9Gd1R2dTJiMWYvS2JibmhCMis2YVBPaW5uWTVIbC9nSnJBRDJUNXZISUZu?=
 =?utf-8?B?NnEzK1l6THRHZHlFYnVwdDhyaHZua3g3ZllzcEU2V2w1dWg4M1FxM0R6b3NN?=
 =?utf-8?B?U0ppcnRBOHRDSnZjWVU2ZXhQNXk5ODRjY3pyN3VmOVpiMThINDdGYnM0d2Rh?=
 =?utf-8?B?VE5jTHk5VlY5eHVXQmpsYkZMVWhNK2Jic3ovZjhEbEthL1VRbStPYVM2Rk5X?=
 =?utf-8?B?MHFIWHYzalcwYWNHaDdHQ0pCdFdsVnBqWHJUVlZvcHovM0xXUGEyTVdIMWRt?=
 =?utf-8?B?UWkvVFlqbVRnKzhvRDltVzhCdXpLa0dtdys0Q1JYZ0FJRWFiOThaODRvZDBz?=
 =?utf-8?B?UmdCWW16Q1VsVnNuZkJtZWdIbEtsNUc3ZkFObnhHMjVRWFNwR2tJRlZ1anFQ?=
 =?utf-8?Q?BX9tWAYtrA5OvquvIvqE5Yg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2083a2-3297-47fa-b380-08d9a621ee79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 21:18:11.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/Gir40hKw0J2wo3w66NBO2TjCd8QrvBdw4MWCCrnK4KPV/6v2z0uN0JBsdRhgEy+Cuoq4CmjNTF2NMD04n1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE5vdmVt
YmVyIDUsIDIwMjEgMTA6MDINCj4gVG86IFBhbmRleSwgQWppdCBLdW1hciA8QWppdEt1bWFyLlBh
bmRleUBhbWQuY29tPg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgbGlu
dXgtY2xrIDxsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnPjsNCj4gTXVrdW5kYSwgVmlqZW5kYXIg
PFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IEhpcmVnb3VkYXIsIEJhc2F2YXJhag0KPiA8QmFzYXZhcmFq
LkhpcmVnb3VkYXJAYW1kLmNvbT47IERvbW1hdGksIFN1bmlsLWt1bWFyIDxTdW5pbC0NCj4ga3Vt
YXIuRG9tbWF0aUBhbWQuY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3Jn
PjsgTGVuDQo+IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6QUNQSSA8bGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuDQo+IGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgUkVTRU5EIDIvNV0gZHJpdmVyczogYWNwaTog
YWNwaV9hcGQ6IFJlbW92ZSB1bnVzZWQNCj4gZGV2aWNlIHByb3BlcnR5ICJpcy1ydiINCj4gDQo+
IE9uIEZyaSwgT2N0IDI5LCAyMDIxIGF0IDg6MzMgQU0gQWppdCBLdW1hciBQYW5kZXkNCj4gPEFq
aXRLdW1hci5QYW5kZXlAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbml0aWFsbHkgImlzLXJ2
IiBkZXZpY2UgcHJvcGVydHkgaXMgYWRkZWQgZm9yIDQ4TUh6IGZpeGVkIGNsb2NrDQo+ID4gc3Vw
cG9ydCBvbiBSYXZlbiBvciBSViBhcmNoaXRlY3R1cmUuIEl0J3MgdW51c2VkIG5vdyBhcyB3ZSBt
b3ZlZA0KPiA+IHRvIGNsb2NrIGNvbmZpZyBiYXNlZCBzZWxlY3Rpb24gdG8gZXh0ZW5kIHN1Y2gg
c3VwcG9ydCBvbiBvdGhlcnMNCj4gPiBhcmNoaXRlY3R1cmUuIFRoaXMgY2hhbmdlIHJlbW92ZWQg
dW51c2VkIGNvZGUgZnJvbSBhY3BpIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFq
aXQgS3VtYXIgUGFuZGV5IDxBaml0S3VtYXIuUGFuZGV5QGFtZC5jb20+DQo+IA0KPiBJcyB0aGlz
IGFuZCB0aGUgWzMvNV0gYXBwbGljYWJsZSB3aXRob3V0IHRoZSBbMS81XT8NCj4gDQo+IElmIHNv
LCBJIGNhbiBwaWNrIHRoZW0gdXAgb25jZSB0aGV5IGFyZSBhcHByb3ZlZCBieSBzb21lIG90aGVy
IEFNRA0KPiBmb2xrcywgcHJlZmVyYWJseSBNYXJpby4NCg0KSSBoYWQgc29tZSBvZmZsaW5lIGNv
bnZlcnNhdGlvbnMgd2l0aCBBaml0LCBhbmQgZ2F2ZSB0aGVtIHNvbWUgb3RoZXINCmlkZWFzIGlu
c3RlYWQgb2YgS2NvbmZpZyBiYXNlZCBjbG9jayBzZXR0aW5ncy4gIExldCdzIHdhaXQgZm9yIHRo
ZSByZXN1bHQNCm9mIHRob3NlIHRyaWVzLg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Fj
cGkvYWNwaV9hcGQuYyAgICAgICAgICAgICAgIHwgMyAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kYXRhL2Nsay1mY2guaCB8IDEgLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfYXBkLmMg
Yi9kcml2ZXJzL2FjcGkvYWNwaV9hcGQuYw0KPiA+IGluZGV4IDZlMDI0NDhkMTVkOS4uNjkxM2U5
NzEyODUyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX2FwZC5jDQo+ID4gKysr
IGIvZHJpdmVycy9hY3BpL2FjcGlfYXBkLmMNCj4gPiBAQCAtODcsOSArODcsNiBAQCBzdGF0aWMg
aW50IGZjaF9taXNjX3NldHVwKHN0cnVjdCBhcGRfcHJpdmF0ZV9kYXRhDQo+ICpwZGF0YSkNCj4g
PiAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VO
VDsNCj4gPg0KPiA+IC0gICAgICAgaWYgKCFhY3BpX2Rldl9nZXRfcHJvcGVydHkoYWRldiwgImlz
LXJ2IiwgQUNQSV9UWVBFX0lOVEVHRVIsICZvYmopKQ0KPiA+IC0gICAgICAgICAgICAgICBjbGtf
ZGF0YS0+aXNfcnYgPSBvYmotPmludGVnZXIudmFsdWU7DQo+ID4gLQ0KPiA+ICAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeShyZW50cnksICZyZXNvdXJjZV9saXN0LCBub2RlKSB7DQo+ID4gICAg
ICAgICAgICAgICAgIGNsa19kYXRhLT5iYXNlID0gZGV2bV9pb3JlbWFwKCZhZGV2LT5kZXYsIHJl
bnRyeS0+cmVzLT5zdGFydCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVzb3VyY2Vfc2l6ZShyZW50cnktPnJlcykpOw0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY2xrLWZjaC5oDQo+IGIvaW5jbHVkZS9saW51
eC9wbGF0Zm9ybV9kYXRhL2Nsay1mY2guaA0KPiA+IGluZGV4IGI5ZjY4MjQ1OWYwOC4uODUwY2E3
NzYxNTZkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jbGst
ZmNoLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY2xrLWZjaC5oDQo+
ID4gQEAgLTEyLDcgKzEyLDYgQEANCj4gPg0KPiA+ICBzdHJ1Y3QgZmNoX2Nsa19kYXRhIHsNCj4g
PiAgICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsNCj4gPiAtICAgICAgIHUzMiBpc19ydjsNCj4g
PiAgfTsNCj4gPg0KPiA+ICAjZW5kaWYgLyogX19DTEtfRkNIX0ggKi8NCj4gPiAtLQ0KPiA+IDIu
MjUuMQ0KPiA+DQo=
