Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A880D37ADBD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhEKSGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 14:06:08 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:37601
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231587AbhEKSGI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 14:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSJt/z1EucFmB9Aw1N6/h01yWrUw8/dmmSUk9v4K31FwNwGg6IaalXtpbjJTyF7YlrDjJo1Km/3WDqGysobVH9pJzgab4tFEUAfs8vYyVfhTVluT2plVl2sQn17Epw4A8XbH9c5m5iNlJlu9ihHEIUeiakiNYBfjXaRSht7nX4jLw+i2MZri7mTws+63HlBJbkNCu3xrgbP2Lu7Bg9qY3Lh6jgeLbUla40+ILg5AwZFoiJtrHAJXYz5wk2l7g0p9VjHMVDWyubEoIU4RkBAwWvZmp7qadZzClr68hd6mesUws1HNYpeD22R/1CdkHeTkWtQaTLFJ6i8c+7dOQHheOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78l6lvH/fFkcY5dke/uxiFm4t5Tx4TQ75tBagNOOVts=;
 b=M6x8zEcM06xkh6N1loMI3FL+zrZm0+qe5YVodg9mFq6h3EDbKXYBMJc93XcI39idMwp51W+cfgDpJaM2uxcRsog1Mgi3wo5pt5Ln3CJxXtw88UOLX14bTro+YER/YQ36ec8aTdQuow/sgs52wFt6X+b74VdyMwO8J9EQE9lSZmAtZimgKWd31glfRmG8gqvwqelH+eJbdWO2GbMCHSRdrtJcwYwMyixiHh++vKDKiX/w7kf0Pr6HtCbVIkaxth0mlgXQyP6Ww9wxmkk4uVhI9cpWQeh9YiHKeTPpxZwBVQ22cKAwnz/Y2qH664R9gXtfXgE+hHWia1fD1BSkOv+j8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78l6lvH/fFkcY5dke/uxiFm4t5Tx4TQ75tBagNOOVts=;
 b=l2ZS5XcUzGZbhE3egmBAoHNQioBevqLsI7VUXVVEhAlmMMJwy5KxQ1dya2/Q0XhoTiltD3/jgr3wVp8bGpdaMpAHT30H0YO7OHRnEoHgePvHKSHPdV5dItVvE2L3bnIyBUU3uMA6PQv5gIF6GBeJ6NCofo4sEWEBmm/zHpRs8xA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 18:05:00 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 18:05:00 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXRhB3iYtXC8kOSUmPM3b6GW+YfareE2SAgABS9wCAABtyAIAAASCAgAAGAYCAAAm/EA==
Date:   Tue, 11 May 2021 18:04:59 +0000
Message-ID: <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
 <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-11T17:24:31Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=13668c12-1c91-4094-972e-e52f0d596402;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52859478-5348-4112-6b1f-08d914a74b16
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB406349E46954A6DA8C54F22EF7539@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9q6EyvdRJ/zIq4lQKgiBWyGJUMtSBeo+HCSVSGrhJiKSvQNz9U6g0TbumYn5ukAogDcVSWYHhfg86F/O9ao+7W7gA4KpPnVPA92051v0RilVzamPzqrXCzKXDe+goFm08Gv+eqZr7/l98b9ywlJak6EGAdD6jKx2raUAiSmVfCUeyAecWuvM6Yx29XtvxUq4lkJK8rFU0HvIzkHQe8IeYr/PtWTyD4yqXqlwR3M8d53bUOdzDlDr8EXrXAkZ7gIf2758dcvhslZRF2j8Yq7f4FGBVoJu2yVHRSphqQ7y8UGxLnrMFJj0CdL/JBQCWCypFEqNTHnAwwsYhiySLzpRQ7WhxrMIrAUInDoBxH+MdluScn/HOwdHAl0zdjS6Nn5FjCuQ3acnKmrufMEmj9iaMPT4eLjBa5Jd0ydLmN5UrxyGiEQBGn73k+6YkWj1gfmmgQkNygBOH9BciKagILFT9UCjgIOg7YMASwC97xbvkYPEqEUhv5F7EpFqenqUyVK3KGk/1JMf0lz4vY0luooj52KT4NuwG2A5GAzM7TqP7vdBxx7Rj4lQK4z47VYubtq9w0b/oDTUiV+3kW4MV68LLs6EXBnVwbaWLuqoeU383D/rmUSgIrj9nX9xvI5CeNBCr/DxDp3oQjJKszYhsEZCHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(498600001)(33656002)(71200400001)(9686003)(110136005)(6506007)(53546011)(54906003)(38100700002)(122000001)(64756008)(4326008)(86362001)(5660300002)(55016002)(186003)(2906002)(26005)(8936002)(6636002)(66556008)(52536014)(66446008)(76116006)(66946007)(66476007)(8676002)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aW5LVmZ4akhHR2ZpalV5Q0p5N1dZVnhMbVNnUm5KWWJKWlpjZjcyT2hKWklm?=
 =?utf-8?B?OVZseDhzVmp0dVdDNE9sdnpveGNUSGIwby9XS05OZ0RZQkt3MEdXVFJuZUlX?=
 =?utf-8?B?MFdTczM3a2NwN3IvQm1abWpFUU83Z1ptbUl0d0RWNnhOVldpaWVjS3FVU2Uy?=
 =?utf-8?B?TkdRanJkWXl2ZmM1Y3lKRmpDUHVLaVJpNzNoMTdQalBMS3FTdTI4dUIvRTNh?=
 =?utf-8?B?ejB3V3ZEM1BIb0kzOU5WVE9xcEFIbWlmNHd0LzIzM1AyRkhvd254c0ZwYUp1?=
 =?utf-8?B?NmVQZ2tNTW5hK0VxRm1peFpoRlJiOE9Tc1FJQWV0c0hHUWFtTnlSZWVmNGhx?=
 =?utf-8?B?blFrR2o3a3Q3YjdYbk5xRzhlM1p2SEw4Snp2a3AxS0pKd3ZVMHdZUEtnZlU0?=
 =?utf-8?B?WEMvcjJQTE9aZGk2Z2cwL0FobXpIV2hNdVpNZ0RBbUNwdThYS1loeTNiVThK?=
 =?utf-8?B?dUhRS1F2SVJISzNUZncwVDZpd09ubXZJQlZwVnRUOENlTHFHcmFpSEJmUEc4?=
 =?utf-8?B?OUZPSTVaN04yazJnK0lKV2piY2pPWXdxdnA0UUtnWklHUmd0aDZsV25HSXVG?=
 =?utf-8?B?L1EyWWlmT1B4czhBRjZ6UjFuZnFKN0g5cmpsbE5ORkxmempVNUJjc3dmMEZN?=
 =?utf-8?B?K1k2K2hXeU5xLzJzQkFTRjNPRHdwem5DR241VGtocnhqemVrTU92UTBsRkdX?=
 =?utf-8?B?N08rT2RWLzlqUWdSLzNrWTFMZE9sNGN1YnpOZUlZakVZcnQ4OGV5bGllZkZx?=
 =?utf-8?B?dkNrYkpzbndCTDhmT1NyOWRtclg5Y29scjZLZ1hacGpPVlFjNFFqMjc4MHBY?=
 =?utf-8?B?bmN0K3pLZDdHL3ZZMTNBTk9ReGpMMklqbUNPc0tLMDlBZDEreU5UZlk4d0U3?=
 =?utf-8?B?aytBeW1TUGZyQW5iZVZkTXk5NHpFMkhRLzVJQzJXSFFjTHN6dW9QVFJyY3pw?=
 =?utf-8?B?Q01vOWp1M1RmUVgxUUkwU2I1SHZWcUZjemp4MTZ5YWwrTERXeUx5YlVwTEIw?=
 =?utf-8?B?dnpQUHVDaVBQZExYU1lZWDZUaVozOXZXQ3gyVTd3LzRNcWdjVzlya0M3NUFB?=
 =?utf-8?B?Q2tQTmFJcUJONWJDdGJ3ZWlVVTFmODkwbVNEQ1hSa0NRSk1XNTVPYitDcFFu?=
 =?utf-8?B?VDg5clUyUU84Z3N1UEgxRzJEaTBRSXFRMnZPbDg2QWpaR3A4d1pXOWlvZnVq?=
 =?utf-8?B?Q1NBdFFNeWFQSWFzSENzNHFHVEQ1RHNkYURETTJSTnVXVWw2ckhGd2dMbk84?=
 =?utf-8?B?VUtvV3JGbjl1S05pM3drTXQ5UFVSWlpUbGFmaEM2T2lmMEpKQytzVytrTXJY?=
 =?utf-8?B?T0RQQVZ3bzcvK1k2WFh5anRFVzdsazhaa3hFLzFESGc5WGJYWENzOWI3bXZa?=
 =?utf-8?B?THZ1LzlmSkd6VGM4VXpOMjY1TllZWkMzTVp5Zm51TU55T2ZQdHd0cVd2R1hx?=
 =?utf-8?B?M3Jabnl3RWFwK0NVVHZYSG1BOGRXREZNM01GQnEyTFRMUFNBWE94TVJXMDAv?=
 =?utf-8?B?ZlhMam5VN3VDcWtNUWgxeXN6S3hmdzZZNTZQSFpuZ0tCZUdtYW9EOHFPbFlX?=
 =?utf-8?B?Z3Nydml0OTVVSXRiQkwzZHhHYlB3M3JPYjBRZytkWHlvVlRHVzZVTDNxOVgy?=
 =?utf-8?B?MVJ1S1MzeGU1Z0hCK0ZGUW9LM2hSNHV0eUdvVTFqOGhJaVN2MXBWRWFuQ2Fo?=
 =?utf-8?B?SHFSc3RVTHo0N0tZdFRlZk0zeXhwaHBhODR3bkJNbjdtdnZLV1R5aFFxdXA3?=
 =?utf-8?Q?bRXA/cSBbMvcIiA7/IKm0clwNjvR7DwYu6relJN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52859478-5348-4112-6b1f-08d914a74b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 18:04:59.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8rOGbVuM/kkWbBJ74g+5IdF0cgBfSB5s7fhfHhO6Mcv3RhLIseb8vpIikmjuyTa2qIUTlu3wabSy1u4ocZcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxMSwgMjAy
MSAxOjI1IFBNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBM
aWFuZywgUHJpa2UNCj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBSYWZhZWwgSiAuIFd5c29ja2kg
PHJqd0Byand5c29ja2kubmV0PjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+Ow0KPiBBQ1BJ
IERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVj
dDogUkU6IFtQQVRDSF0gQUNQSSAvIGlkbGU6IG92ZXJyaWRlIGMtc3RhdGUgbGF0ZW5jeSB3aGVu
IG5vdCBpbg0KPiBjb25mb3JtYW5jZSB3aXRoIHMwaXgNCj4gDQo+ID4gT24gVHVlLCBNYXkgMTEs
IDIwMjEgYXQgNjo1OSBQTSBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDU6MjEgUE0gTGlt
b25jaWVsbG8sIE1hcmlvDQo+ID4gPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+ID4gV2VsbCwgaWYgZmluZF9kZWVwZXN0X3N0YXRlKCkgbG9va2Vk
IGF0IHRoZSB0YXJnZXQgcmVzaWRlbmN5DQo+ID4gPiA+ID4gaW5zdGVhZCBvZiB0aGUgZXhpdCBs
YXRlbmN5LCB0aGlzIHdvdWxkIHdvcmsgSSBzdXBwb3NlPw0KPiA+ID4gPg0KPiA+ID4gPiBVbmZv
cnR1bmF0ZWx5IEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCBoZWxwIC0gZnJvbSBhbiBPRU0gc3lz
dGVtDQo+ID4gPiA+IHRoZQ0KPiA+IGZvbGxvd2luZw0KPiA+ID4gPiB0YXJnZXQgcmVzaWRlbmN5
IHZhbHVlczoNCj4gPiA+ID4NCj4gPiA+ID4gIyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUv
Y3B1MC9jcHVpZGxlLyovcmVzaWRlbmN5DQo+ID4gPiA+IDANCj4gPiA+ID4gMg0KPiA+ID4gPiA4
MDANCj4gPiA+ID4gNzAwDQo+ID4gPg0KPiA+ID4gQnV0IHRoaXMgbWVhbnMgdGhhdCBub3QganVz
dCBTMGl4LCBidXQgY3B1aWRsZSBpbiBnZW5lcmFsIGRvZXNuJ3QNCj4gPiA+IHdvcmsgY29ycmVj
dGx5IG9uIHRob3NlIHN5c3RlbXMgYW5kIHRoZSBsYXRlbmN5IHF1aXJrIGRvZXNuJ3QgaGVscCBo
ZXJlLg0KPiA+ID4NCj4gPiA+IFdlbGwsIGl0IGxvb2tzIGxpa2UgdGhlIGRyaXZlciBuZWVkcyB0
byBzb3J0IHRoZSBDLXN0YXRlcyB0YWJsZSwgdGhlbi4NCj4gPg0KPiA+IEJ1dCB0aGF0IHdvdWxk
bid0IGhlbHAsIGJlY2F1c2UgdGhlIDcwMCB1cyBpZGxlIHN0YXRlIGlzIGluIGZhY3QgZGVlcGVy
LA0KPiByaWdodD8NCj4gPg0KPiA+IEFyZSB0aGUgdmFsdWVzIGp1c3Qgc3dhcHBlZCBvciBhcmUg
dGhleSBjb21wbGV0ZWx5IGJvZ3VzPw0KPiANCj4gQWN0dWFsbHkgSSB0aGluayB0aGUgdmFsdWUg
c2V0IGluIHRoZSBPRU0gQklPUyBmb3Igc3RhdGUyIGZyb20gTFBJIGxvb2tzIGJvZ3VzDQo+IHRv
by4NCj4gSXQgc2hvdWxkIGhhdmUgYmVlbiAzNnVzLg0KPiANCj4gQExpYW5nLCBQcmlrZSBhbmQg
QERldWNoZXIsIEFsZXhhbmRlciB5b3UgaGF2ZSBzb21lIG1vcmUgaGlzdG9yeSBvbiB0aGlzDQo+
IHRoYW4gSSBkby4NCg0KSSB0aGluayB0aGV5IHdlcmUganVzdCBib2d1cywgYXQgbGVhc3QgaW4g
dGhlIGluaXRpYWwgY2FzZXMgd2hlcmUgd2Ugc2F3IHRoaXMuDQoNCkFsZXgNCg0K
