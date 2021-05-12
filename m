Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C42337B441
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 04:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELCsR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 22:48:17 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:22304
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhELCsQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 22:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhVcClflEG/SHCQRu9nSHI5DF9IcXi8e5g2c2eXthnQk4xwDL3f1UISkVbHj7OFPtwYU65mfzZaF1XaWrknaOvYEvLQJ/fbe1/BWP9KYSM2r622pFN33cYIP0CdlFEes8uoCAwNnxu3FZBYcG+gZIhz1QoENhG/qxn5DihTOjxMG26vzQO1hv2yiHzOPOb9eUignU3tjxDa1Fb9CbFMId3r7rNY4i4+Ia+XjW1vZ9UuHL5c9mwbj5/aCtjJFhkHGHTKopfG05ZI3EYF3g2RiWp7NAcsf6K8QRIJK3qBqbeuBtaP6r/0llSldPnVXxx8Ojq2Npb54XqYhMqaHJF945A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+vK0C/flShtV7BkU8HQNzuS5FSJP3WASrGRmWLni4Y=;
 b=QpOECYPJjVO1tIrsCNn5XpcB1cmsjUNLEEWAnYbXOSS41G5ygROta47vR7z0glyazJarBDEDZs7sYi16ADGd94UgASEuw6O3s2jxugYr+TN9NmLSaKpSzv1oFLeOK6wiNSp+s8AE5KsYkPj0TXAsl/smIafsuU2Ap8Dq6oYVcPtmNMFJ1k5N5pcsFNnuXv+tb1VXKp7alvQZVLXUxLN8W3hUGm5NQCMYoQ5YFzM2nprZ7gK7ECfgr/g+JCT1xJcSE2PYaC+sTndFTYWSNU8zg9GC4mFTdn0S1jwL/2diU+KLWdam+ipQ0rYVwDKIOeKP7MjcxriCE+oSvjZWREC8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+vK0C/flShtV7BkU8HQNzuS5FSJP3WASrGRmWLni4Y=;
 b=DTCaB6+c0p9YiievvWRo6N225TtgUvuUwT6cmC1SatoPfXsIdXsMw0ESkedKI0CpMZ8qkNrpUNpjnd789J6GG41SA69wPK47rNUmoLZTxss7o9+aYBHfg2aK8RGUjpPFvqTOtq1DsBdJ1be+twEPa1bVQkAlyLrAUMy4IOqOFJY=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 02:47:06 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 02:47:05 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXRhB2PGuo7Bnw1UWLxLUelvn94KreE2SAgABSPyCAABwqAIAAASCAgAAANICAABENgIAADJ1wgAAFeACAAH4YsA==
Date:   Wed, 12 May 2021 02:47:05 +0000
Message-ID: <BYAPR12MB26932E89C5FCE71DB23482E6E2529@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
 <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BYAPR12MB269399B97D4BBC07B5758CCDE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jznwY0Cs9uKQDx5UASOggTEXUmwUiVUT998jwS0N1AcQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jznwY0Cs9uKQDx5UASOggTEXUmwUiVUT998jwS0N1AcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-12T02:47:03Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=f42ea30b-b010-440f-87ee-b7b37426a80c;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:5f0:f9af:d99c:b88f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9020c85-744e-4210-569f-08d914f03abe
x-ms-traffictypediagnostic: BY5PR12MB3843:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB384382BBCB995FE35C31A2DBE2529@BY5PR12MB3843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hthSb4Fn27UmILJd6pNu4+Jm+rIfrwKSRxHnPx04+7AW7TedBDLhn29v6WUHGozs1O+xmQy77Eeks6W2DmEJAE8T61Is1eJw+8uUHq+D4m0XQCOeOm1BzZs/PtJ8E5TrwGRtaG0bqnT/zTO36XqEJT2+tAXxg5+aQWJhRKERIKQiPTo7ADQgbNHmsMWXHS+JtcJvkxPmNHeRqzjjLXn4DtRIRVlC9BSx7kKUso0SvT9pF2yd+SdqvkzdJbb/Pakdd30YWwLIQYrHHiPfqwmsILS20tyhX5OeiC83+2Z0zxZqMx0+jiGgHXsZunlyuvmkn6KscO6HGi3Mos+4ZvYpKwn7L3QdwDcay41cMvCj9+oliHt2VfV7aF/qKBIpK/snZ+2ZGyw3PXwWps/IE66uWsn/1mb0n1f4JuxcQbXcLqrV01wy5Bs1026+PYdKV0sz8XhS6/YFAWWQbOfO8SVief3Kjg1n9lP1idJLB106BwSw37ZOtp2+zctfKmO+wRN/ATW4yGrUrAK1XRUqx1Gm3btRKN5jKXAzKNbkWYl1QUkuZk+TEaKG1YTDqoLtsIdoTmq177RVgXyUp3H+agSuqvrhKWYt3/MtIskcc/Q0AxqIJfCAExn9tj6mYEZUS3OYBhd80l3BInlL7XOH0TZBAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(7696005)(64756008)(66556008)(66476007)(66446008)(33656002)(76116006)(66946007)(71200400001)(6506007)(8676002)(38100700002)(52536014)(122000001)(83380400001)(478600001)(4326008)(54906003)(186003)(55016002)(5660300002)(8936002)(316002)(2906002)(6916009)(9686003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bUE2bWpuR1pCSnNUWnlqMUh1UHB0R0JJS2VKeXNFSUMvUk8ra0x0bno0R00w?=
 =?utf-8?B?STNReU5iaTIrUURZeGlUSi9peG5vQzFXVmI5aWl0S3FuVVVjeW1RR25WNFl1?=
 =?utf-8?B?cEo3cVdmaEVLWTN4ZFo5bWFvY0NaY2lCazY5Mnpmcms2RU42cTVXTlhIU1JL?=
 =?utf-8?B?bys1Q3hsVWNNMnJEMDRNbFFaemlTMXBRRTRoMEpObDQzMUJ0a2FzZXpBVHl5?=
 =?utf-8?B?a2hmVzBTamovL2tMT2dYcFloYTdtOVA3QlVoVTNLUGdCRmVYK2gvR09sV3Bv?=
 =?utf-8?B?Y3d3dlhtWHh4b1N3alJFc2ovU0RMcHQycmdZbVdRNUp0UFJ1aWdaZlNaQzVk?=
 =?utf-8?B?Sm95YW9RZmk1MisvS3M4M0c3S25kbmc0WllnQTZwMzRpOWdBN1h6T0J1K2Nn?=
 =?utf-8?B?K0lSTUxJdXhXTXplc1Ezc2ovRzhjcUplVHZKTnpwZDBKUUNEd3VDKzY3YmRh?=
 =?utf-8?B?Uk1nK3dpazA1Z25nZ3dpdmNUd0oyZDByTWw0b0s2QWZuUkl1WWxJQTIxNFd2?=
 =?utf-8?B?REJRbEZsZC9hbklLTUpWQUx2Q2QvamVSVlArMzJjOUdwZkdZTmNqekc5eXdv?=
 =?utf-8?B?cG11ZW1jNlVBUy9uLzRTSE4rUGpPWkFqaTRlRHEycmNyWCtGdXdoTElYdWND?=
 =?utf-8?B?dmVFV1JwSzEvN1FXS2krc1cvVVdCSkxib0E4WWhWcGk2Y0JsaE5FMDFwd3hn?=
 =?utf-8?B?UElCS3lNSlMxcnh3UlEyaVE0d2NONXRucWtlRnFWUVdyWjRUYVM0cDgydWM0?=
 =?utf-8?B?U2R6K3lMdzE0V3BHQ1BGRExybEpMRXY5NlFOTWIxWWd2ckJhcVRXR1FZdkZG?=
 =?utf-8?B?elJVUDgrRGpWbXBnbjB2eXgrdUFFN2RFWDdSdWJHV0t5ZzFsbzdqMFN0aFJJ?=
 =?utf-8?B?MDZDWEtPa1VBMjZRZXNPTlZ0VlcvZ1BaMnp0ZTRTdTdSTVFjdC8rT2t5RUls?=
 =?utf-8?B?U29FNWE3azhSSENPQlpFTWIvSmU4TjlNdUJEdmJ3QTZFd0pEOWZ1MzRPcWUv?=
 =?utf-8?B?UDJKaHdSd09melQ1RjhOV2JCcUM1TyswUmxSRGozcVpDdk5IcGFJNllSUTJB?=
 =?utf-8?B?ekUvdzgyQ3JHckdYZEQ1cFpMRkV3aXFFM2hmU2tReVJXWjNmNUlTUlI1N20y?=
 =?utf-8?B?VjlGT2cwdXBtci94V3pGT0NPSXFhV2ErdURaK2dETmZIRXBzczlSNllCenlx?=
 =?utf-8?B?Y0drUS9KSUgvcTl3ZFUybFJRZCtFMU54NTA4NURPZXlxcjd5djJSVzNLSk9X?=
 =?utf-8?B?aER5T29JZ0RmeGNiUnR2aG9Wa2VrVTROWkt5R0gzcmp4amUrcFdZSFU1VmFQ?=
 =?utf-8?B?VVNaRi9HUVFpK3NkY2w5VVE2TnNUUUxyUVFaSm93WWIrcVZGeWlBcHZRcWxp?=
 =?utf-8?B?YWFYbm5rOTZXYTFMc2JpeFhHWVE4VklHd29FOVZiWXZtSlE5V3hZSEVGTm5p?=
 =?utf-8?B?ZDlKU3d2ajF1Q3ZMQVRYSnNrb09zUWdSeTFoV0U4Zk9CRnNHeWdmYVkzdHNY?=
 =?utf-8?B?NXlsOWdqbjIva1F3UTJXMG1iNE5BOE91YTJlOVhHWlM1SzhJcjFTSVRHL2hM?=
 =?utf-8?B?cnZ1ZGtNY2RrblMybEpSeS9yOGRIMjlIL2RxSXZkZUlrZ1EzVXRqOVpsbGZR?=
 =?utf-8?B?Y2wxZ3FqRWhic0NlT0s0UC9KaTI4RE0xMGVERGx6dktjZ21EaXR6OU1QaXRI?=
 =?utf-8?B?cWpSL0tzSldZTUt3dHVnbk56Mzg1L2Vrdmx0RytpU1c3R3Q2ejN4SGY0enFm?=
 =?utf-8?B?MUxjNjJHTi9Hc29iUWlUOHltNGRCTWY4V08zUGRCMG9abjVuL0twci9lL28w?=
 =?utf-8?B?ckNnY0VvOHJTY3ZWQ1RRWlB1ZEtkTzVnZ1VJWnp2RTNKODVHSlJBTERYSFdQ?=
 =?utf-8?Q?Z9H5FUyvcpkJk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9020c85-744e-4210-569f-08d914f03abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 02:47:05.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcQXI/9u+VVSm7ErbjtTiQ50JRu9WZeuunR451nZ/6tsz7zgej6djAbdhHUhvCAcPw7EX5x6NsNMyweiFH1AhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3843
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IEluIHByb2Nlc3Nvcl9pZGxlLmMgdGFyZ2V0IHJlc2lkZW5jeSBpcyBjYWxjdWxhdGVkIGJ5
IGV4aXQgbGF0ZW5jeSBtdWx0aXBsaWVkIGJ5DQo+ID4gYSBsYXRlbmN5IGZhY3RvciBwYXJhbWV0
ZXIgKDIgYnkgZGVmYXVsdCkuICBTbyB3aGVuIHRoZXNlIHN5c3RlbXMgaGF2ZSB0aGUNCj4gYnVn
Z3kNCj4gPiBfQ1NUIEMyIHZhbHVlIG9mIDQwMCwgdGhhdCdzIHdoZXJlIHRoZSA4MDAgY29tZXMg
ZnJvbSBmb3IgcmVzaWRlbmN5LCBub3QNCj4gX0xQSS4NCj4gDQo+IFllcywgdGhhdCdzIHJpZ2h0
LCBzb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4NCj4gDQo+IE15IHBvaW50IHdhcyBtb3N0bHkgd2hl
dGhlciBvciBub3QgaXQgd291bGQgYmUgc3VmZmljaWVudCB0byBzd2FwIHRoZQ0KPiB2YWx1ZXMg
Zm9yIHRoZSBsYXN0IHR3byBzdGF0ZXMgb3IgaWYgc29tZSBuZXcgdmFsdWVzIG5lZWRlZCB0byBi
ZSB1c2VkDQo+IGFuZCB0aGUgYW5zd2VyIGFwcGVhcnMgdG8gYmUgdGhlIGxhdHRlci4NCj4gDQo+
IFNvIEkgZG9uJ3Qgc2VlIGFueSB3YXkgdG8gYWRkcmVzcyB0aGlzIHRoYXQgd291bGQgYmUgY2xl
YW5lciB0aGFuIHRoZQ0KPiBxdWlyayBtZWNoYW5pc20gYXMgcHJvcG9zZWQuDQoNClRoZSByb290
IG9mIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHN0YXRlcyBnZXQgc2tpcHBlZC4gIFNvIHllcyB0
ZWNobmljYWxseQ0KeW91ciBzdWdnZXN0aW9uIG9mIHN3YXBwaW5nIHRoZSB2YWx1ZXMgb2YgdGhl
IGxhc3QgdHdvIHN0YXRlcyB3b3VsZCBiZQ0KZW5vdWdoIHRvIGF2b2lkIHRoaXMgaXNzdWUgYXMg
d2VsbC4NCg0KTXkgdGhvdWdodCBpcyB0byBkbyBpdCBieSBjaGVja2luZyB3aGV0aGVyIGFsbCB0
aGUgbGF0ZW5jaWVzIGFyZSBhcml0aG1ldGljDQpwcm9ncmVzc2lvbnMgYW5kIGlmIG5vdCB0aGVu
IGVtaXQgYSBub3RpY2UgdGhpcyBpcyBhIEZXIGJ1ZyBhbmQgc29ydCBhdCB0aGUNCmVuZCBvZiBh
Y3BpX3Byb2Nlc3Nvcl9wb3dlcl92ZXJpZnkocHIpLiAgVGhpcyB3b3VsZCBiZSBkb25lIG9uIGFs
bCBzeXN0ZW1zLg0KDQpMZXQgbWUga25vdyBpZiB0aGF0IHNvdW5kcyBnb29kIG9yIGlmIHlvdSB3
b3VsZCBwcmVmZXIgdG8gc3RpY2sgdG8gdGhlIHF1aXJrDQphcHByb2FjaCBhcyBwcm9wb3NlZCBv
ciBzb21ldGhpbmcgaHlicmlkLg0K
