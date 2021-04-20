Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01A7365145
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 06:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhDTEXO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 00:23:14 -0400
Received: from mail-bn8nam08on2070.outbound.protection.outlook.com ([40.107.100.70]:7360
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229508AbhDTEXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Apr 2021 00:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGrqlMsTNbrxBsJ43gxCSN3LVD17hqI2hH/+nk/sV7Buf2a/buIcZ14+Ls1O1wLzLjSd/F0z1XhwnTl8rU6+zNtdjSuFq5a0A8TPoXC5PiXP/gvlqVwhMsP2FkeYUIhcHUq+n8+bSTK7+ZZbwQOywPI4udoFQj52Q+HbPHCh8OOy2yCV8YttkGLi1S4ppIwcnDK3mjssGQ+rkaG8BLERKqoxvh/H/PhaUaZYtKEKe5I7/909Tfz6Yprh5m+WSJqLE6sr5K88+ZSS8aM508usXxYGFkevEKOD66k7o4SpJQB2Zw1c+BICa/ZMUN2FrNfK93fFIvQYWYlswTH95wxmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ckxnsCfEQ4itYLoX0Tx15YdtiP87/s0hteh9suRqY=;
 b=aGBU4sv8Y9qtupYvp5LGgs9UUtzNQ8NLdwR6zxEUGWvJ7gj9Sr2I9XbxlNrQiTvwHJJfaDekreAKrq4tN/1eH91Z7ZyaF+WzL7XJPrVTRYF2YDn123ZTsWnpwKMgMeH6DlwO4BK9qyrcftbsYdUR/fcAiUzCx12zxUky6xU08PP/owrUbOcBTVGCGq92T2Ko8MwGdS8zPPyCJuCfJIT0MPajSY9424KzoXYcD5Xd5tFldZEcXGNN4yicX6KuO3MpZ2jTgXLQ6nYG5RCiPEP12RzB8GgTYqx2Tq9+cNmLjn96lNavVzB6lSQi+94NTEYEILyc6RO7gDAKrMZC1Z0R5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ckxnsCfEQ4itYLoX0Tx15YdtiP87/s0hteh9suRqY=;
 b=Vc/hQcO2e9Uvxmpu/fgC58WmhcRkU7a9j2gPQKEa9xYyc0FogHPsqjzTBlg+zpNiNYHY1P7q+GJDuP3HqCXwCTJIx2NKeodhghhueeBxVmm/PsE8VGWrAoD0FmZtkcyAHUrcCmGID7cst6wk7A2PqK5wVA+ZfX5pAF1Obt8+9Y2tTgKTXAGLBAx4iWgBN19R4jg1TeDyzrSDpMmYNzoqStZyOoctYBFvPteNuDp7aOtTUoIdTnm4vT2sLIah00CT0u9nv7U2zCbuP4pdjSwymQKLarobZqfTPf6FWi1d2g4LW/+kiulLRnSUwZ7bj30f5Tu5nkg5p4eRUyh/gSp9Iw==
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 04:22:42 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::5105:e8df:9631:bf0f]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::5105:e8df:9631:bf0f%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 04:22:42 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: RE: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
Thread-Topic: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
Thread-Index: AQHXLcst0OqV1gbZbka3uZ3UykiE86q3on2wgAUp/wCAAAz9sA==
Date:   Tue, 20 Apr 2021 04:22:42 +0000
Message-ID: <BL0PR12MB2532D6AD41E6CF4F3252EE59BD489@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com>
 <BL0PR12MB25321D18363AD50ACC7A2643BD499@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jztOGShTF+pVSMAtGeK4giHvC3mGNa5bC0pXz=2ZcrJw@mail.gmail.com>
In-Reply-To: <CAPcyv4jztOGShTF+pVSMAtGeK4giHvC3mGNa5bC0pXz=2ZcrJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.97.180.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd49dc03-801e-474a-ebd2-08d903b3f0d0
x-ms-traffictypediagnostic: BL0PR12MB2340:
x-microsoft-antispam-prvs: <BL0PR12MB23406DAB0E74CB0D2102E2D1BD489@BL0PR12MB2340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7rXPIP1qJKIa0dcnUEiQOE3pUbV80kIryw/w1H2ocdBYCW4a0TOLMGJrv8W+rK7MlH3rWb5sOxfbaKDfs49kHpVvU4z5qlfnBcOVTQhXoTd1CCovutn5jd+kc5u4QKHPkfsBA5DEx/Y8fiO4PLnAqfQiJSu9+smsUoBunjFefvfy2TVEsABM0Le5l3YxGZn+q+hdtUOWEaLlOPHIB7UQfrlW7xwHvS5d2sch7O1y6NvgT32Ncpl0rgWNL96toZERXhc3cN4/TPuERCBfxHE19iKIyOJu+AW0gA2SYyYUw1iaHw88niAgsLln+x5Ek4z6fE/HJTNzB9DPFpHAH8XafnxUfL8TvsixfJ8G/Wd82K7DCPwrPqLkI7mkl3Y2dY/wA1JnSQz6qTHpXLpin2MmTsMkPNP2KxnG25lG5q4tgGRncR4Q5JY2JSvc7IN3OgfBrKevatLKzPOlDRySu53p+nVeRfrTcalr406w2Sp4DCCzgL+HMeBppnN3p6hcoBWlFi3y/kIi3EbZf+iQZBzVKys2YSAqsmhCNnF1denqxXegu4UbmGMGmlIu/nOobIFSZ1dvDPllyoyATMKm/xtWZbpWjlR9xaUfQhQTLnMps19zWXCPb9MiE6Abnsnq+DDxUwAZ3XCyyUyHTtfqM6tM4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(9686003)(54906003)(55016002)(316002)(4326008)(2906002)(122000001)(38100700002)(186003)(26005)(86362001)(6916009)(52536014)(66446008)(83380400001)(53546011)(6506007)(71200400001)(478600001)(7696005)(5660300002)(8936002)(8676002)(7416002)(66556008)(33656002)(76116006)(64756008)(66946007)(66476007)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Mjg0c2gxdkpZNXVBRW5FT0EwOXN0WUJNbjdESGp1TDM4S2ExTjZ5UjZPSTJu?=
 =?utf-8?B?UzJYendITWVMckZoQ09qRElIckNGdTNJWjY2QmhEak8rZ2Z5RU1ldmFrb3JZ?=
 =?utf-8?B?cndJSXltSmJQZFhRQzRyNDRoU0FqSFBrUFdxemNpU2wxWGRsK1hUeFFFUnBw?=
 =?utf-8?B?REQvQ3VORVFCMTBQc0RIVFgyME4xVDcrVTlZMTcxN2lzYWxiM054UzllOXJs?=
 =?utf-8?B?UktWRkZvTjFSUEcvV0x5K25Bb2hBcFRiT1g4c0ZucU1PUWlqOGRjZ3JPdW5N?=
 =?utf-8?B?RnpOaTRsTjl5T2VhYWxSbGJ4Q3hNZUIveEZkdUxKY09IakszU0Jrb0xRK3Bl?=
 =?utf-8?B?ODBXMXhKWm00c1oyVEV5b0RyaWhGdzl4bXdOTEFBeVltY2IzeHduVHF3RURM?=
 =?utf-8?B?Zk9KYWxxUXhVR25qdml1ZWxZUkZiUFBTanpIaDVKUUp3NmJjSWJoRUplWWdl?=
 =?utf-8?B?SENwaVlhOW9aVlN0UHJZN3Z5RDY1aUVQRUMwVlRsdDBpWXdSTDN0Tk5oUFZm?=
 =?utf-8?B?bVpnT2FPWnVjRHo1d2pGV2xuWXhNbWJySUYzayt6QVg1Y0hPMHFsdWZ1RlBO?=
 =?utf-8?B?d3YzRHpxTWRZaGFpK3BPZUV0b1VBMUQyZ1Ryb0hoSTdZZ1dFa2pHRHJ4L2x3?=
 =?utf-8?B?REdiU3NFMTZ0L09SdVlYM3ZDeXUxY1FjNFVzYTNTT2JEOU9KYkhHdFlWNURu?=
 =?utf-8?B?amtzZC9oc3I3V25kMEVFMWxBY1ZhSDQraHBEcXJUWVZ4S25UZmtwdmVxUTNF?=
 =?utf-8?B?dmZ6YU00Zk5WaytzQ1FKVFN5U0EzbUhaeE95T1M3dGtZd0Q3bmFhK1R1ZlpH?=
 =?utf-8?B?Y05Dc3Z3ZS9UdzV1UmIzbnU5TXlpcXlEWERqVGpwQkc3SDQzdkF5NE0vRTVj?=
 =?utf-8?B?SFJYRXVjM2x1dzBuUkEyanp3UmVTckRRV1pBaTkyYlZ4YTEyY0xkcnNHNmhl?=
 =?utf-8?B?M0s4a1JMaTFuenlHMldHcG5rSDdzM2svUzJ4ZUkyQ2hBaHZrc0c3QmJYSEVu?=
 =?utf-8?B?Y3hQbW0rczRQTitkS1FzWFEwTER0d2o3a1k1NzFSV0NsbFU4cmpncXVqUmdY?=
 =?utf-8?B?dTU5OW5waHUzYkkxbnc2Qmh0TVlvNm1naU1nV05XOHB1Qkl1K3lnRURxQzFK?=
 =?utf-8?B?c05Rc3ZmNlBpU1J0dkplS1FBVytvdldRUnFzaHgvbjhsd1hEd0tKWXFkeXdX?=
 =?utf-8?B?blVDSTM5aHNzVnVhVVFURGFPUFpuTFZJa3Y5VnRDT1B5STlKOFVtR2hQWmM2?=
 =?utf-8?B?TEYyWnloVHk1YTBUa2N1MjZURUora0NzWTQ2RVMrZHYrMlpVWGRSY015aG9F?=
 =?utf-8?B?OVNyenoybjAzK0xKV2c0L2ExWVloVGllUmFvR0xOeGdDMnFuV0xqb2cxc3F1?=
 =?utf-8?B?ZGg5NGhLZEIwNTBCaXE4UVRCZ2k1eUR3V3g2SFFLa0ZTdFpCOFRhcUlJRHh0?=
 =?utf-8?B?SFI4RktROXhaUkdxdHhQMVYwZm90cjlWRFBoNDhaMjFHMWFuRGF5RVFSR0Rh?=
 =?utf-8?B?bU9Ma0J4UnAzYVE0RXFBbWM1M2hqWjZSL1QzYVlRaXNUZWxJNmpkZ21JN0l3?=
 =?utf-8?B?SjRJbzhnOWc2czBEN1hnQ0tBWHkydlNEcUlWVnFXMDVmenIwSnhxSzlDVi9C?=
 =?utf-8?B?bFphZml6a2JLSFV3MEpGOUFaWFVIY25xRndqOG02SGtDeFVDaHJSczVFallY?=
 =?utf-8?B?QWNTcVJpNkRQWG1ENGVaK3R4a20ybndHZFpHQU94SDJINEEwcEx1b1hHQ0xO?=
 =?utf-8?Q?1wHNlN77BE5Mci/+QN4SvLaA6NnPfZMKW1O/oE+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd49dc03-801e-474a-ebd2-08d903b3f0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 04:22:42.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5dzVWJDFQ15wdrCGr0xejLVxH1YpmV5/GtVWDxKKvaox8z6WUwRyiO8lvJjDqN0oAxUO+hnuQM1gkJrww0Ndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gT24gTW9u
LCBBcHIgMTksIDIwMjEgYXQgMzo1NiBQTSBWaWtyYW0gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29t
PiB3cm90ZToNCj4gWy4uXQ0KPiA+ID4gKiBSZXBsYWNlIGFsbCBpbnN0YW5jZXMgb2YgIkluaXRp
YXRvciIgd2l0aCAiSW5pdGlhdG9yIC8gUG9ydCIgaW4gIlRhYmxlDQo+ID4gPiAgIDUuNTkgRmxh
Z3MgLSBHZW5lcmljIEluaXRpYXRvciBBZmZpbml0eSBTdHJ1Y3R1cmUiLCBpbmNsdWRpbmcgdGhl
DQo+ID4gPiAgIHRhYmxlIG5hbWUuDQo+ID4NCj4gPiBJIHdhbnRlZCB0byBkaXNjdXNzIHRoZSBp
bXBsaWNhdGlvbnMgb2YgYSBDWEwgaG9zdCBicmlkZ2UgaW1wbGVtZW50YXRpb24gdGhhdA0KPiA+
IGRvZXMgbm90IHNldCB0aGUgIkFyY2hpdGVjdHVyYWwgVHJhbnNhY3Rpb25zIiBiaXQvZmxhZyBp
biB0aGUgYWZvcmVtZW50aW9uZWQNCj4gPiBGbGFncyBpbiBUYWJsZSA1LjU5Lg0KPiA+DQo+ID4g
U2luY2UgdGhlIGtlcm5lbCB3b3VsZCBiZSBleHBlY3RpbmcgYWxsICJTeXN0ZW0gUkFNIiB0byBo
YXZlIGVxdWl2YWxlbnQNCj4gPiBGdW5jdGlvbmFsIHByb3BlcnRpZXMsIGlmIEhETSBjYW5ub3Qg
aGF2ZSBhbGwgdGhlIHNhbWUgZnVuY3Rpb25hbGl0eSwgdGhlbiBpbg0KPiA+IHRoZSBhYnNlbmNl
IG9mIElTQSBzcGVjaWZpYyBBQ1BJIHRhYmxlcyBjbGFyaWZ5aW5nIHdoYXQgYXJjaGl0ZWN0dXJh
bCBmZWF0dXJlIGlzbid0DQo+ID4gc3VwcG9ydGVkLCB0aGUga2VybmVsIG1heSBiZSBmb3JjZWQg
dG8gbm90IG9ubGluZSB0aGUgSERNIG1lbW9yeSBhcyBzeXN0ZW0NCj4gPiBSQU0uIElmIHRoZXJl
IGlzIG1vcmUgZ3JhbnVsYXIgZXhwcmVzc2lvbiBvZiB3aGF0IGZlYXR1cmVzIGFyZSBsYWNraW5n
IGluIGEgSVNBDQo+ID4gU3BlY2lmaWMgdGFibGUgKGVnIE1lbW9yeSBUYWdnaW5nL01lbW9yeSBQ
cm90ZWN0aW9uIGtleXMgbm90IHN1cHBvcnRlZCksDQo+ID4gdGhlIGtlcm5lbCBjb3VsZCBjaG9v
c2UgdG8gbm90IGVuYWJsZSB0aGF0IGZlYXR1cmUgaW4gYWxsIG9mIHN5c3RlbSBSQU0gKGlmDQo+
ID4gZGlzY3JlcGFuY3kgZGlzY292ZXJlZCBhdCBib290KSwgYnV0IHN0aWxsIG9ubGluZSB0aGUg
SERNIGFzIFN5c3RlbSBSQU0uDQo+ID4NCj4gPiBUbyB0aGF0IGVuZCwgaXQgbWF5IGJlIHVzZWZ1
bCB0byBjbGFyaWZ5IHRoaXMgdG8gaG9zdCB2ZW5kb3JzIGJ5IHdheSBvZiBhbg0KPiA+IEltcGxl
bWVudGF0aW9uIG5vdGUgKGlkZWFsbHkgaW4gdGhlIENYTCBzcGVjaWZpY2F0aW9uKS4gU29tZXRo
aW5nIGxpa2U6DQo+ID4gIkNYTCBob3N0cyBhcmUgZW5jb3VyYWdlZCB0byBzdXBwb3J0IGFsbCBh
cmNoaXRlY3R1cmFsIGZlYXR1cmVzIGluIEhETQ0KPiA+IGFzIHRoZXkgZG8gaW4gQ1BVIGF0dGFj
aGVkIG1lbW9yeSB0byBhdm9pZCBlaXRoZXIgdGhlIG1lbW9yeSBmcm9tDQo+ID4gYmVpbmcgb25s
aW5lZCBhcyBTeXN0ZW0gUkFNLCBvciB0aGUgYXJjaGl0ZWN0dXJhbCBmZWF0dXJlIGJlaW5nIGRp
c2FibGVkLg0KPiA+IEhvc3RzIG11c3QgaW5kaWNhdGUgYXJjaGl0ZWN0dXJhbCBwYXJpdHkgZm9y
IEhETSBpbiBBQ1BJIFNSQVQNCj4gPiDigJxHZW5lcmljIFBvcnTigJ0gZmxhZ3Mg4oCcQXJjaGl0
ZWN0dXJhbCB0cmFuc2FjdGlvbnPigJ0gYml0IGJ5IHNldHRpbmcgaXQgdG8gMS4NCj4gPiBBIHBv
cnQgdGhhdCBzZXRzIHRoaXMgYml0IHRvIDAgd2lsbCBuZWVkIElTQSBzcGVjaWZpYyB3YXlzL0FD
UEkgdGFibGVzIHRvDQo+ID4gZGVzY3JpYmUgd2hpY2ggc3BlY2lmaWMgSVNBIGZlYXR1cmVzIHdv
dWxkIG5vdCB3b3JrIGluIEhETSwgc28gYW4gT1MNCj4gPiBjb3VsZCBkaXNhYmxlIHRoYXQgbWVt
b3J5IG9yIHRoYXQgZmVhdHVyZS4iDQo+ID4NCj4gPiBUaG91Z2h0cz8NCj4gDQo+IFRoZSBwcm9i
bGVtLCBhcyB5b3Uga25vdywgaXMgdGhhdCB0aG9zZSBmZWF0dXJlcyBhcmUgYWxyZWFkeSBkZWZp
bmVkDQo+IHdpdGhvdXQgdGhvc2UgIklTQSBzcGVjaWZpYyB3YXlzIC8gQUNQSSB0YWJsZXMiLiBJ
IHRoaW5rIGl0IHNpbXBseQ0KPiBtdXN0IGJlIHRoZSBjYXNlIHRoYXQgdGhlIG9ubHkgYWdlbnQg
aW4gdGhlIHN5c3RlbSB0aGF0IGlzIGF3YXJlIG9mDQo+IHRoZSBpbnRlcnNlY3Rpb24gb2YgY2Fw
YWJpbGl0aWVzIGJldHdlZW4gSVNBIGFuZCBDWEwgKHBsYXRmb3JtDQo+IGZpcm13YXJlKSBtdXN0
IG1pdGlnYXRlIHRoZSBjb25mbGljdC4gSS5lLiBzbyB0aGF0IHRoZSBDWEwNCj4gaW5mcmFzdHJ1
Y3R1cmUgbmVlZCBub3Qgd29ycnkgYWJvdXQgSVNBIGZlYXR1cmUgY2FwYWJpbGl0eSBhbmQgdmlj
ZQ0KPiB2ZXJzYS4gVG8gbWUsIHRoaXMgbG9va3MgbGlrZSBhIHBsYXRmb3JtIGZpcm13YXJlIHBy
ZS1ib290DQo+IGNvbmZpZ3VyYXRpb24gbWVudSAvIHN3aXRjaCB0aGF0IHR1cm5zIG9mZiBDWEwg
KGRlY2xpbmVzIHRvIHB1Ymxpc2gNCj4gQUNQSTAwMTYgZGV2aWNlcykgaWYgaW5jb21wYXRpYmxl
IElTQSBmZWF0dXJlICJYIiBpcyBlbmFibGVkLCBvciB0aGUNCj4gcmV2ZXJzZSB0dXJucyBvZmYg
SVNBIGZlYXR1cmUgIlgiIGlmIENYTCBpcyBlbmFibGVkLiBJbiBvdGhlciB3b3JkcywNCj4gdGhl
IGNvbmZsaWN0IG5lZWRzIHRvIGJlIHJlc29sdmVkIGJlZm9yZSB0aGUgT1MgYm9vdHMsIHNldHRp
bmcgdGhpcw0KPiBiaXQgdG8gMCBpcyBub3QgYSB2aWFibGUgb3B0aW9uIGZvciBtaXRpZ2F0aW5n
IHRoZSBjb25mbGljdCBiZWNhdXNlDQo+IHRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IGZvciB0aGUg
T1MgdG8gZXZlbiBsb29rIGF0IHRoaXMgZmxhZy4NCg0KTGVhdmluZyBpdCB0byBGaXJtd2FyZSBp
cyBlYXNpZXIgZm9yIHRoZSBPUywgYnV0IGNvdWxkIGJlIGEgY291cGxlIA0Kb2YgaXNzdWVzIHdp
dGggdGhhdDoNClBsYXRmb3JtIGZpcm13YXJlIG1heSBub3QgaGF2ZSBhIHdheSBvZiBkaXNhYmxp
bmcgSVNBIGZlYXR1cmUNCmlmIGl0IGlzIGRpcmVjdGx5IHZpc2libGUgdG8gdGhlIE9TIHZpYSBD
UFUgSUQgcmVnaXN0ZXJzLCBhbmQgdGhlDQpyZWdpc3RlcnMgY2FuJ3QgYmUgdHJhcHBlZCB0byBz
b21lIEZXIGFuZCB2YWx1ZXMgYWRqdXN0ZWQgDQpvbiBhY2Nlc3MNClBsYXRmb3JtIEZpcm13YXJl
IG1heSBub3Qga25vdyBpZiB0aGUgT1Mgc3VwcG9ydHMgYSBzcGVjaWZpYw0KRmVhdHVyZSAoY29k
ZSBtYXkgbm90IGV4aXN0IG9yIG5vdCBkZWZhdWx0IG9wdGlvbiBldGMpIHNvIGl0DQptYXkgYmUg
cHJlbWF0dXJlL3N1Ym9wdGltYWwgdG8gZGlzYWJsZSBDWEwgaG9zdGJyaWRnZSANCmFsdG9nZXRo
ZXIuIEFsdGhvdWdoIEkgc3VwcG9zZSBhIFVFRkkgdmFyaWFibGUgdHlwZSBrbm9iDQpjb3VsZCBi
ZSBhZGp1c3RlZCBpbiB0aGlzIGNhc2UgYW5kIHRha2UgZWZmZWN0IG9uIHJlYm9vdC4NCg0KQWxz
bywgZm9yIHNvbWUgKmZ1dHVyZSogSVNBIGZlYXR1cmVzIHdoZXJlIGl0IG1heSBiZSBwb3NzaWJs
ZSBhbmQNCnByYWN0aWNhbCB0byBkZWZpbmUgSVNBIGZlYXR1cmUgc3VwcG9ydCBkaXNjb3Zlcnkg
cGVyIE5VTUEgDQpub2RlL2FkZHJlc3MgcmFuZ2Ugdy8gQUNQSSAocHJpb3IgdG8gdXNlcnNwYWNl
IEFCSSBiZWluZyBzZXQpLA0KdGhlIHBsYXRmb3JtIHdvdWxkIHdhbnQgdG8gZW5hYmxlIHRoZSBD
WEwgaG9zdCBicmlkZ2UgYW5kIGxlYXZlDQpzZWxlY3RpdmUgZW5hYmxlbWVudCBvZiB0aGUgZmVh
dHVyZSB0byB0aGUgT1MuIFllcywgdGhpcyBpcyBtZXNzeQ0KYW5kIGJlc3QgYXZvaWRlZCwgYnV0
IGl0IG1heSBtYWtlIHNlbnNlIGRlcGVuZGluZyBvbiBJU0ENCmZlYXR1cmUgYW5kIGhvdyBtZXNz
eSBpdCBtYWtlcyB1c2VyIHNwYWNlLiBJJ20gcGVyc29uYWxseQ0Kbm90IGluIGZhdm9yIG9mIHRo
aXMgbGF0dGVyIG9wdGlvbiwgYnV0IEknbSB0b2xkIHRoaXMgd2FzIGRpc2N1c3NlZA0KaW4gb3Ro
ZXIgQ29oZXJlbnQgaW50ZXJjb25uZWN0IGZvcnVtcyBhbmQgY2hvc2VuIGFzIGEgcGF0aCANCmZv
cndhcmQuDQo=
