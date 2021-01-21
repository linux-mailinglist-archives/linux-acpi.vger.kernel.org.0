Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6002FF7B4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 23:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAUWGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 17:06:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:19652 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbhAUWG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 17:06:28 -0500
IronPort-SDR: GBwq3bbhPc88KbB95N65ihFw4XOvPtkD6WU73LXRYBUynDpKK+08crjmy3ZP6pUZRDib92Hu76
 VGpjkVNEtuJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179438972"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="179438972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 14:05:47 -0800
IronPort-SDR: 3VNd/qVawhtsMUN9MYLFoG7rzE9BR8Fgq30MBSswsGM/62HBkTuno8aStUddiGA0mQH41UI8vW
 ZFaxLCp271RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="367073075"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2021 14:05:47 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 14:05:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Jan 2021 14:05:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 21 Jan 2021 14:05:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7+cpt174OyeLOWULbz4q7/t2S5UU8PEHkQtN5alQ3/xlwAd1Rwy93ZUTqmX7C0BNutnWbP1fZ5HH0QPZci0mQqoPSu+LNt42fX9g+2Q6ijN2YzYL6kpyyQ1JyOKvg8zf2PGYUFWUUZHJFAHGjxwvkzWG58hRyMbvmpwS9VtNfGecPewWo+hMBlOyCmWSELXq2nhV3nIoK0gc3mIFyBI72t6vsvVOFqZRplBab+xjaZvjwkbPXfOgGYM8xjxMq1FnQP8JMhTX3dQ6NkfRe0IoxxCt7ntvYw9CAi6ZhbYULYHpEzrJjICcN2aGU77j+/lARZ1dHbFbfYU7BYnpapl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYVgoSwV3qnm3TOkF3xxd4fntWyrW0LKO+4+ap+qRdc=;
 b=Mxv7WD+LnNfq6QJe4MYLmqIOCRz1KZ/6qaA6l1nHMMAXarGFB8x/Xq8dGenTVV06z5nqaixnITYthEmacoosC/mEKWNmrdpzPktvFK4/a7+q5x8meMkHNVxH4D0tRcuI9OS8mxke8LkQXpm2y9CU32gvRlniDkEMov9SoHSBv7jxKU0RvFr56VzBblD13SojuK7ThoNI5iNlFieMRun6FFpvAEHikl5DPBck/9rP99L+i9pD2Tacv1XJM1zCknQSflZZypmuQJiq+BZfZGbUUqwDfSugDPRjRdU39W4R3RqtnESAArStmzASMyx/BlZAlBbsAdqDZCp8ZlFBKU4XBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYVgoSwV3qnm3TOkF3xxd4fntWyrW0LKO+4+ap+qRdc=;
 b=CxKmgDEvKXKQGv75jaOUlHfClF1REO1/CIsFB2SSdNleLnJIFjWg4BDUUSABE8AMfhOFJ8YbwZ7pteooI4/lW4/Qloh11S4YSmbdPTYSeRqKMphkW78+05kdrgtflf/dVsoPH7C5jRZhYv0wLy3EU6QukLNRuPB6HW8ZF2jP48w=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1391.namprd11.prod.outlook.com (2603:10b6:300:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 22:05:43 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3763.014; Thu, 21 Jan
 2021 22:05:43 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough
Thread-Topic: [PATCH] ACPICA: fix -Wfallthrough
Thread-Index: AQHWt9BQlYjhl8Bfrk+mO8TKTgEi+KoySncAgACWFoCAAAE0gIAAMY2g
Date:   Thu, 21 Jan 2021 22:05:43 +0000
Message-ID: <MWHPR11MB1599FF516D46CAEEDC1C21B8F0A10@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com>
 <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
 <CAKwvOdnG6Ew+7HMjJuH3Or8kEE_ZyP-xNGbwaX8HdT=6FApYxA@mail.gmail.com>
In-Reply-To: <CAKwvOdnG6Ew+7HMjJuH3Or8kEE_ZyP-xNGbwaX8HdT=6FApYxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 824e41e6-3071-404a-541f-08d8be58b2b0
x-ms-traffictypediagnostic: MWHPR11MB1391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1391553F3F77060303A8CB29F0A10@MWHPR11MB1391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPBWAFp0N3d0v50G4FZXBqVfqR5dYtDd2bF6eKdea8/ZnTnMCC6pOLTsdtkdFIbEwe+oNq/LtOPf6bdOmAjqMVKPt3lRc0SC1Y8G2LbJUdjBFrfijwNQq/VDHAk/iyLG7EJr8/GcFpBhQ2cu5pq8TMz1slV3MShBI6aNNBRKlX83Nse2529QvMCBC3aVAQgCxOa68qsuk9s7UDaUWNmJsLmUCx6Jzp81SI++CtCKE1grw5ejm3evOOGSdxrX0Yomi4H1Negxvvy7SGvHwMd9ktX0YPclueW5vS/Jgl5bKKNicIKPTxFR4jm7iYqNYejaggBHl6V1NSzQ36ogV62KtxIskqgIiUgtmu14tiflUk40Ry/+I8bM5Y+ZLm6QOS7TwDELM+eT1kg50V72oq2rekJCPH9kGn+nwj3CZMZM9pWuKF1FV1ZekYafJ8PIK81mG/NjkuYcMa06J4wDsRQVMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(478600001)(33656002)(26005)(9686003)(86362001)(4326008)(186003)(110136005)(71200400001)(5660300002)(2906002)(54906003)(7416002)(8936002)(52536014)(55016002)(66946007)(66476007)(316002)(76116006)(8676002)(83380400001)(6506007)(64756008)(53546011)(966005)(66556008)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RGRDdGdoTXFtWWFrYWorVXRwbk5vVkI4Yk5JQmtvYWVHMGMvcWpaZjJFZFlx?=
 =?utf-8?B?Z084Y0dmNU8ySlJVYlFWSHA1bzhicFJkOThweDI4cVVqY2NGYmdxdWhHRmFU?=
 =?utf-8?B?VkJpS2tWRXROWi9jZjBEbkxENXdVTXlER0l6MjdrUElnbW51cHRzRHVvRzhO?=
 =?utf-8?B?RzM5ZDF1Q2ZoV044YlpzTWRkaEJRVk9PUkV0ZVZ3RWtKVk0wWmZ6Ly9qcnZZ?=
 =?utf-8?B?ajFFVDNOcGlUT3lrYUZZYzFZVjJKZmwzU2t4dFg5ZEJkb1UzZGFTbDlBMXQx?=
 =?utf-8?B?SkpqZWZnUnN2SzNjTlJTQTdyUDVzbUJCTERhcmNLZGptN09QZVROUGxxK1hB?=
 =?utf-8?B?SUNlOU9tU0NuQzZvbnEzT3d4VWhqSXk5b0RqTkNnZ1NwdU50eDRMRytGTnFZ?=
 =?utf-8?B?QWhDaUU0QkRWRzRGVm9hZ295TnRDcFdVMVprQzVzUDBRWGJFQU5IaXBMQ3k5?=
 =?utf-8?B?V3RhTnBMVUplOWR0eUVTN3dXbVY0Q1VHY1ZTOVIxRC9saGFPTFh0ZE9lRUFk?=
 =?utf-8?B?MHZQTjYvemJtbjQwMTFsV1EySyswUGxpNmlRQkZMMmN1RmJvMnRZcnhnRXZC?=
 =?utf-8?B?SGF1VHhkTms0S08vQVQzR1RlVHVmYjdpUmMzbmlyTG1jUElRQTZrZzZSd2R6?=
 =?utf-8?B?cUlIZkZCS25NU3NEMWZKS055SlFCWlRhYWFXUmZxSXVNdG1WVU53UGVQdVpo?=
 =?utf-8?B?WmRZeTEwNjR4dW91UWcyN2lmL2tmWjlvY0xZQzlOM1B2VUEwRGxKMVVCamZ2?=
 =?utf-8?B?U3pPQVczNTQxRVJYVXBmOU1yTW4wekJQUHJxRlltNGcwcnNyUzBvUjVteUZK?=
 =?utf-8?B?QlNKQS9DZW5lTkdtRERQWVFpN2NNV1JrRm93RzhweUtlVzUzUE54TDI5bUNJ?=
 =?utf-8?B?RWp0WnNpL1NNZHlBMDVoVTZ0M1A1K2x5YU96VWpwa0dhQks3a3ZnbjVIVWN3?=
 =?utf-8?B?RWVFRSt4STFpUWNkSWRBSHRpNzFBVm42LzFsandFckduQ3pObVNTenRKUnJt?=
 =?utf-8?B?NHJyb0NKTGJtdnA4VTNoMDRzak5RK2hJSVd3dVFTOXhQY1RYUWF3ZVhicTJY?=
 =?utf-8?B?MVZXZnNOd0NLZGV4NlBKVWV1T2taYmxYZ1YzNEdkbnQrSVZtTDZLOTBpVzVy?=
 =?utf-8?B?c0NRS0MyZHowZE5pb1o1Q0tySFlUbVJBVGRPc1Fja0J4QXBhcHZwNW92czV2?=
 =?utf-8?B?MGNxSUhZbE1YQXZkek5CL2hxczBrejFpRVY2TzZidE1tbG80T2ZJSS9jVS9R?=
 =?utf-8?B?UEVSdDJtS0M3TmZEWHdEMkhoenFBNkJMWU5UV3ZUNkR1OVB0TXRWNEV0MEYz?=
 =?utf-8?B?NE4rc3VyYWludDdpeWxLTjl2bnMvQTBmTkx4bzA3U3RwTmdmQzM5RkhuQ1k2?=
 =?utf-8?B?Nm5GNnRHenIzUjRibDI0WXpQbGJiV1pwWVl0dS9vVkFyOHp0dWpRc05LZDFl?=
 =?utf-8?Q?nA9Cm5j5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824e41e6-3071-404a-541f-08d8be58b2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 22:05:43.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ar08mOoNu7F2YzJPXxlHk2Gjoh7pJq3+UqXvzDoWLGajweIz/vdAtrHz5w0SLZPAle5rGVYjAkpFrOjElxtK2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1391
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljayBEZXNhdWxuaWVy
cyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIx
LCAyMDIxIDExOjA4IEFNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5v
cmc+OyBLYW5lZGEsIEVyaWsNCj4gPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gQ2M6IEpvbiBI
dW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1v
b3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbT47DQo+IEd1c3Rhdm8gQSAuIFIgLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPjsg
Y2xhbmctYnVpbHQtbGludXggPGNsYW5nLWJ1aWx0LQ0KPiBsaW51eEBnb29nbGVncm91cHMuY29t
PjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBBQ1BJIERldmVsDQo+IE1hbGluZyBMaXN0
IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVA0K
PiBBUkNISVRFQ1RVUkUgKEFDUElDQSkgPGRldmVsQGFjcGljYS5vcmc+OyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtdGVn
cmEgPGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
QUNQSUNBOiBmaXggLVdmYWxsdGhyb3VnaA0KPiANCj4gT24gVGh1LCBKYW4gMjEsIDIwMjEgYXQg
MTE6MDMgQU0gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDExOjA4IEFNIEpvbiBIdW50ZXIgPGpv
bmF0aGFuaEBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMTEv
MTEvMjAyMCAwMjoxMSwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4gPiA+ID4gVGhlICJmYWxs
dGhyb3VnaCIgcHNldWRvLWtleXdvcmQgd2FzIGFkZGVkIGFzIGEgcG9ydGFibGUgd2F5IHRvDQo+
IGRlbm90ZQ0KPiA+ID4gPiBpbnRlbnRpb25hbCBmYWxsdGhyb3VnaC4gVGhpcyBjb2RlIHNlZW1l
ZCB0byBiZSB1c2luZyBhIG1peCBvZg0KPiA+ID4gPiBmYWxsdGhyb3VnaCBjb21tZW50cyB0aGF0
IEdDQyByZWNvZ25pemVzLCBhbmQgc29tZSBraW5kIG9mIGxpbnQNCj4gbWFya2VyLg0KPiA+ID4g
PiBJJ20gZ3Vlc3NpbmcgdGhhdCBsaW50ZXIgaGFzbid0IGJlZW4gcnVuIGluIGEgd2hpbGUgZnJv
bSB0aGUgbWl4ZWQgdXNlDQo+ID4gPiA+IG9mIHRoZSBtYXJrZXIgdnMgY29tbWVudHMuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVy
c0Bnb29nbGUuY29tPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBJIGtub3cgdGhpcyBpcyBub3QgdGhl
IGV4YWN0IHZlcnNpb24gdGhhdCB3YXMgbWVyZ2VkLCBJIGNhbid0IGZpbmQgaXQgb24NCj4gPiA+
IHRoZSBsaXN0LCBidXQgbG9va3MgbGlrZSB0aGUgdmVyc2lvbiB0aGF0IHdhcyBtZXJnZWQgWzBd
LA0KPiA+DQo+ID4gSXQgd291bGQgYmUgdGhpcyBwYXRjaDoNCj4gPg0KPiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj4gYWNwaS9wYXRjaC8yMDIxMDExNTE4
NDgyNi4yMjUwLTQtZXJpay5rYW5lZGFAaW50ZWwuY29tLw0KPiA+DQo+ID4gTmljaywgRXJpaz8N
Cj4gDQo+IG9oLCBzaGl0LCBsb29rcyBsaWtlIGEgbGluZSB3YXMgZHJvcHBlZC4gIEhlcmUncyB3
aGF0IEkgc2VudCB1cHN0cmVhbToNCj4gaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2Ev
cHVsbC82NTAvZmlsZXMjZGlmZi0NCj4gY2NjZDk2ZTkwMGUwMWY3MjI0YzgxNTA4Y2JkZGZiMWFm
NmZjZmJmZjk1OWQ2YmZiNTUxMjNlMWI5Y2FkNGUzOFIxNTQNCj4gMw0KPiBOb3RlIGluIHRoZSBw
YXRjaCBSYWZhZWwgbGlua3MgdG8gdGhhdCBsaW5lIGlzIG1pc3NpbmcgYW5kIHRoZXJlJ3MNCj4g
aW5zdGVhZCBhbiAjaWZkZWYgdGhhdCdzIGVtcHR5LiAgV2FzIHRoaXMgbGluZSBhY2NpZGVudGFs
bHkgZHJvcHBlZD8NCg0KTGV0IG1lIHRha2UgYSBsb29rLi4uDQo+IA0KPiA+DQo+ID4gPiBpcyBj
YXVzaW5nIGJ1aWxkIGVycm9ycyB3aXRoIG9sZGVyIHRvb2xjaGFpbnMgKEdDQyB2NikgLi4uDQo+
ID4gPg0KPiA+ID4gL2R2cy9naXQvZGlydHkvZ2l0LW1hc3Rlcl9sNHQtDQo+IHVwc3RyZWFtL2tl
cm5lbC9kcml2ZXJzL2FjcGkvYWNwaWNhL2RzY29udHJvbC5jOiBJbiBmdW5jdGlvbg0KPiDigJhh
Y3BpX2RzX2V4ZWNfYmVnaW5fY29udHJvbF9vcOKAmToNCj4gPiA+IC9kdnMvZ2l0L2RpcnR5L2dp
dC1tYXN0ZXJfbDR0LQ0KPiB1cHN0cmVhbS9rZXJuZWwvZHJpdmVycy9hY3BpL2FjcGljYS9kc2Nv
bnRyb2wuYzo2NTozOiBlcnJvcjoNCj4g4oCYQUNQSV9GQUxMVEhST1VHSOKAmSB1bmRlY2xhcmVk
IChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCj4gPiA+ICAgIEFDUElfRkFMTFRIUk9VR0g7
DQo+ID4gPiAgICBefn5+fn5+fn5+fn5+fn5+DQo+ID4gPiAvZHZzL2dpdC9kaXJ0eS9naXQtbWFz
dGVyX2w0dC0NCj4gdXBzdHJlYW0va2VybmVsL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNjb250cm9s
LmM6NjU6Mzogbm90ZTogZWFjaA0KPiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQg
b25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCj4gPiA+IC9kdnMvZ2l0
L2RpcnR5L2dpdC1tYXN0ZXJfbDR0LQ0KPiB1cHN0cmVhbS9rZXJuZWwvc2NyaXB0cy9NYWtlZmls
ZS5idWlsZDoyODc6IHJlY2lwZSBmb3IgdGFyZ2V0DQo+ICdkcml2ZXJzL2FjcGkvYWNwaWNhL2Rz
Y29udHJvbC5vJyBmYWlsZWQNCj4gPiA+DQo+ID4gPiBDaGVlcnMNCj4gPiA+IEpvbg0KPiA+ID4N
Cj4gPiA+IFswXSBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9jb21taXQvNGI5MTM1
ZjUNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gbnZwdWJsaWMNCj4gDQo+IA0KPiANCj4gLS0NCj4g
VGhhbmtzLA0KPiB+TmljayBEZXNhdWxuaWVycw0K
