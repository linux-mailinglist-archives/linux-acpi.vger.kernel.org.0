Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3317C41B875
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhI1Uli (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 16:41:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:14593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242604AbhI1Ulh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Sep 2021 16:41:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="222909136"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="222909136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="538461783"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2021 13:39:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 13:39:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 13:39:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 13:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALPeMOoJz0GsV1O0TZgJnzY9vXvd+NDSHiXDmqbGW1kTUwmBR/YFQKCTDVrjE5d0mzMygoBqhXCAKclMfAlfK2mA2Ocqqg1BSw0aqM+Ecbe2xaZYG7M9vLJud96CLMnvyNnY3cIGY6dF/UEDlPGWP95AjVEYWBvA9+sb/aMtwDXksQmJAogBpvrT/Ezz2Fn+jClDIELc+TXfcdFxF79jKdwU905hzPelk829Pxr4cFE28/e942Bkq7OrpkELgL4htCjSyEDIlPWS5gSbRNwfwAdfaGKE5jIpd3UVs+0ZRMNOO6SrYm/hViZ9Tgiw0/tOHkffMrF+GwRXT2jHaucnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xc9uZEUmZ2rR+CcTGrR0M582KY+B52Av7aiwyNCv+FY=;
 b=Iwstz869XEHT6hqv1ZEj28VYOnp6EuLVu/SCMtagbKUXaVN2TzR8oZ1If9sEukuNjamxwKY6dQYkMaMQxqcgpplItfVYXMof6JMqChbECDbHo18lBeHYPO+9SeQaLjaFhwmfTzuBtadpTra6GKRtrwNh21ctRHb94PdHTgP/pRnKswI9XM7rbB3MHW349uYJ8zcMMFiMfNEOQIg8fYhYauY6duVYvhJrRzIN67/rkE7dFdkjK9R6+ay2mCTziDvhRuxjBKW84ibMhY2gz+ORIxHRdK7tE2c4KlHAgQKEmtRQnCMBIKydRO8Or7spQ6cQ4nI+qxye+Z85XL2Ax27Dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc9uZEUmZ2rR+CcTGrR0M582KY+B52Av7aiwyNCv+FY=;
 b=up1YGp8OwgH2wfNrApDZSUBRlH/HYx9iwakwPhkuZ2WdA0iw9VxFv8VTVY0TaqibfUwnxKTWFbqikCnYqmz7thHcyKGAq1dSrmRL4f3lx4Cc0DoR642oMmlYs+tXC49QTskTLIlC16G9JzXa0iDsTeoUKFH+V2XOcz33Ipazb8E=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 20:39:55 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::754c:cbde:1a6f:4980]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::754c:cbde:1a6f:4980%6]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 20:39:55 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] ACPI: avoid NULL pointer arithmetic
Thread-Topic: [PATCH] ACPI: avoid NULL pointer arithmetic
Thread-Index: AQHXs5klkVDgeHMiW0iyouULNb67HKu5uZ6AgAAw+TA=
Date:   Tue, 28 Sep 2021 20:39:55 +0000
Message-ID: <BYAPR11MB32560CEAC6CC3C2E93FBBF9387A89@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210927121338.938994-1-arnd@kernel.org>
 <92b02547-3aa5-537f-a782-7a25854d88fe@intel.com>
In-Reply-To: <92b02547-3aa5-537f-a782-7a25854d88fe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0935c622-f5db-47a8-8a3f-08d982c02191
x-ms-traffictypediagnostic: SJ0PR11MB5168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5168EBAE256ADC6A0AA484ED87A89@SJ0PR11MB5168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXkdC25FdJky0Bo65ccicQpWDwodyms9CKtQ7E8TC1uQ+AEqdA08ANLSjpyZCbC8X3IA+TCt4N7GIKd3OswljWJKEPOvrR0OAQZNJQnTHHylyWOwAhUh47lWEtCQn++fjx1gotY3Qc6guUU2f26ExcXc4bXycY3FHaNyih1xwJ4aEGG/JJMw1sEzHSVIi6jOghRIDXOD6X2CA2MN2exOrWN2lqWENX0c0vKAIYZv2rP59fagsPUVMzy+8jK/zULYSzykfgSZWYuV5vzihN6qB+XcEu28pMdi5HWWuJ1lq+tJ15zQUU2Ion6QmX8Oh4O2/ZyXKwOkWXwX2qD/UzfYorMxUI+NR6ZR8883Pwcoo9G0BnSa0o/olVWy7/Z/J6WR4G6ull7wnMtAP+Lbp1TEy31rH7mEqv4GD+h4fuZuxKTKx6BzjH1rIjvt3d396vbAGydd+yr/jsbxYlbdptWtZXiN9zPh9obTBqlLlc+Ca4pKHb6OfRbKi+wACYKwYc/DARKiGTyz11qlCL7E38Vz/UEkVRPE4xAP5/cNNWex7QMFJmoMVBSh0FHM0ZKMymCTSEAi/7EhP4cABqi/HbU9n0lmWXFJCYyTjX3deNcu43vbfurSo3hfFdsXwoCemqtCRujGkvIlcTCX0yFGXKGy2zriqivYbIoPCOtx8LljQpX+ZifQ1rAv938VntP6fYlcbvEtCQnUMckOiVM8ScGk1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(38070700005)(86362001)(26005)(186003)(52536014)(4326008)(7416002)(66946007)(53546011)(71200400001)(6506007)(7696005)(66476007)(66556008)(64756008)(66446008)(76116006)(55016002)(9686003)(316002)(5660300002)(8936002)(33656002)(54906003)(2906002)(508600001)(8676002)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3lKWnhhcTdDSUpSK2RZUUErdEI2OHY4WmdEQUhiVncvOW9lci9uOTBnWkhZ?=
 =?utf-8?B?MEtkeVVNeExuN1hWT0ZRQTlIc3pRWWdHeHdJNkpKNGFxSGVTdzhmWndiSHBI?=
 =?utf-8?B?blMvK0dMb29seVhJMy9WYkordWhRSlVRL2pUMnMxYVBwSTVzV3U0U3BBcDV2?=
 =?utf-8?B?RFFiKzdGQ1FuN2FpSTRmS0JOUkFIUjBKOTZBazR2aVpsTGh2TkJIb0ZTalJx?=
 =?utf-8?B?YnMzYzI3QkF6bXRGNTBuVWVQSG1vMHBUYTJjNS9ickZUeHZ5SG50TVdzNXhB?=
 =?utf-8?B?c2dWaHBkM0Fxd1RhQ1JieEhMNWl5Nmhvbm1PdlYwQnEwTC9PcWh1OGFOdUpu?=
 =?utf-8?B?Q2FHSmEzZjlldGZ4NURobUJOY1BHY0FNdEQ1UGMyaElocHNTTDd6eFhIdjBZ?=
 =?utf-8?B?SlEwYWVYeG9GcDVmQ29UTTVubXZyL2JjUnpvanBFV1hqQ1V4U2Rpa2lNWUo3?=
 =?utf-8?B?cnZZbmQ5S3Uyd3QwNUZJME9XUTFJcE1POCsvVG85WDMwTzJBVVhNUGZYVHgw?=
 =?utf-8?B?WkNHYSsvYldHbDE2UDNSMXgyREdIREFmczBqdTlKRzFiN1h2R3V3V3RCc3JI?=
 =?utf-8?B?T01yb2ZJS0ZYbnpGSExYUk1reDU4emNuYzZ3M00xelFXMVp5QTRKTXpuNVlB?=
 =?utf-8?B?TVBrYmlKbXJCMWM3NjdxOTJIdjVyNkFrRzAxcHV6RmphbmVpcDZhcXdSWE90?=
 =?utf-8?B?RzU2MmlaMWI5S085SEhnUXlVOEQyeHJXZlZUWm1pWCtDdXhzazZTSC9NaWVE?=
 =?utf-8?B?WHNvbm1nVnJKcW5TcTZPT0k0S3YrQTRERHd0eGhQbS96d2hmcUM3MnRPWFFK?=
 =?utf-8?B?d05uZ09uMDlNUXZ2bjFYWGd6RHJLMnZiWFJzL1I4dGpJeHV6d1k1Y1NCOWZS?=
 =?utf-8?B?bEVRZU1YNE54RTNWWWhjbktxSDNjaklvZS9oSUk3bWVBcFg4MUViaStVMks3?=
 =?utf-8?B?VlZBeXQwQ2Z2RkJ6amZCWE1va0M5ZGVPR0lSM3VsOGh3czBWUjJ4cWg4Y2pT?=
 =?utf-8?B?ZkpxdGZ2a0ptMlRVWnFwU3kwS0twa3hVVHdsdTJJODdUVllZVHdLSzZqRlha?=
 =?utf-8?B?ajI5Q296WWVETmJNbEVIb0d3QXR1elkwOGpaeCtPVENpQ0FqMXdOZUZUV290?=
 =?utf-8?B?ZUFMbmIwWnVURFpQYkIycXdWQW0yMm0xT0VlN0VwRXBOdGRWbFQzNlZhalY4?=
 =?utf-8?B?c1dBajRGZ2hrWTlSRU9lVGorWHp3YWs5b0JSU2NhdGdhNER5OUhxQXZDckR4?=
 =?utf-8?B?dUZqTTdIMUNUT1VyUWtoNHI5a0x5dUZWekhqUlQxSWZXN0NOd1MxVlgyWXdZ?=
 =?utf-8?B?bWEyUkNNN0MvSE1iZlNqRkE5cTBQR21hZnhVN2JpZnhscFdtc2ZXS2RUbnR2?=
 =?utf-8?B?Q09tWlZUcy9uNEVWZ1MzdjNMMU5uT3g5QVRxa1ZreGtSdjJrU0VmOXZpR3Uv?=
 =?utf-8?B?SVZ6QWliZFFNd1FrRlhpSkNJUHl3Y3FjYmJqMUwrVERjSWRwOVA3aTk0bkkr?=
 =?utf-8?B?eXg4ZGdmUmlpL0RhSFNHcnJsVmM3bUFhK2pxenBLTzRQeVVab0JkVzloajNw?=
 =?utf-8?B?NWRISlhYSm5KazNpQUlsRzhJODYxNnVmUzVZOWhPWTdFU2h1cEMvT2dRakJk?=
 =?utf-8?B?dlU1TCtNWk03VnlTc2xhTTFxT2M1d3NkamhjdXhlek5TN054UHMvaU5Ibm9I?=
 =?utf-8?B?NWhFalRnMFpZalFMYldpUG9qRjByM01hb3JlYW8vanBCdVBNYUZaUmFXZWli?=
 =?utf-8?Q?9l5QI8ONHY58TooxbVAzF1ZJDi+DBq6XctmqSb/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0935c622-f5db-47a8-8a3f-08d982c02191
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 20:39:55.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6uTW1BRZBodg3Jgss4L79H46BYUKhlpzuFm1mu/cSGSZ0POzvwPhFBCbqJyM0TMHN6rc9QQlvclRmqTLEmGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SSBjYW4gdGFrZSB0aGlzIHBhdGNoIGFzLWlzLCBJIHRoaW5rLiBJJ2xsIHRyeSBmb3IgdGhlIG5l
eHQgYWNwaWNhIHJlbGVhc2UgbGF0ZXIgdGhpcyB3ZWVrLg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb20+IA0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI4LCAyMDIxIDEwOjQ0IEFNDQpUbzog
QXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPjsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1v
b3JlQGludGVsLmNvbT4NCkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgTmF0aGFu
IENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPjsgTmljayBEZXNhdWxuaWVycyA8bmRlc2F1
bG5pZXJzQGdvb2dsZS5jb20+OyBFcmlrIEthbmVkYSA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxsdm1AbGlzdHMubGludXguZGV2OyBMZW4gQnJvd24gPGxlbmJA
a2VybmVsLm9yZz47IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIEFDUEk6IGF2b2lkIE5VTEwgcG9pbnRlciBhcml0aG1ldGljDQoNCkJv
YiwgdGhpcyBpcyBBQ1BJQ0EgbWF0ZXJpYWwuDQoNCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGFw
cGx5IHRoaXMgdG8gdGhlIHVwc3RyZWFtIGZyb20gdGhlIHBhdGNoIG9yIGRvIHlvdSBuZWVkwqAg
YSBQUiBmb3IgdGhpcz8NCg0KT24gOS8yNy8yMDIxIDI6MTMgUE0sIEFybmQgQmVyZ21hbm4gd3Jv
dGU6DQo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+DQo+IFRoZXJlIGFy
ZSBzb21lIHZlcnkgb2xkIG1hY3JvcyBmb3IgZG9pbmcgYW4gb3Blbi1jb2RlZCBvZmZzZXRvZigp
IGFuZCANCj4gY2FzdCBiZXR3ZWVuIHBvaW50ZXIgYW5kIGludGVnZXIgaW4gQUNQSSBoZWFkZXJz
LiBjbGFuZy0xNCBub3cgDQo+IGNvbXBsYWlucyBhYm91dCB0aGVzZToNCj4NCj4gZHJpdmVycy9h
Y3BpL2FjcGljYS90YmZhZHQuYzo4NjozOiBlcnJvcjogcGVyZm9ybWluZyBwb2ludGVyIHN1YnRy
YWN0aW9uIHdpdGggYSBudWxsIHBvaW50ZXIgaGFzIHVuZGVmaW5lZCBiZWhhdmlvciBbLVdlcnJv
ciwtV251bGwtcG9pbnRlci1zdWJ0cmFjdGlvbl0NCj4gICAgICAgICAgIEFDUElfRkFEVF9PRkZT
RVQocG1fdGltZXJfYmxvY2spLA0KPiAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gaW5jbHVkZS9hY3BpL2FjdGJsLmg6Mzc2OjQ3OiBub3RlOiBleHBhbmRlZCBm
cm9tIG1hY3JvICdBQ1BJX0ZBRFRfT0ZGU0VUJw0KPiAgICNkZWZpbmUgQUNQSV9GQURUX09GRlNF
VChmKSAgICAgICAgICAgICAodTE2KSBBQ1BJX09GRlNFVCAoc3RydWN0IGFjcGlfdGFibGVfZmFk
dCwgZikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
Cj4gXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGluY2x1ZGUvYWNw
aS9hY3R5cGVzLmg6NTExOjQxOiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdBQ1BJX09GRlNF
VCcNCj4gICAjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpICAgICAgICAgICAgICAgQUNQSV9QVFJf
RElGRiAoJigoKGQgKikgMCktPmYpLCAodm9pZCAqKSAwKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KPiBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+IGluY2x1ZGUvYWNwaS9hY3R5cGVzLmg6NTA1Ojc5OiBub3RlOiBleHBh
bmRlZCBmcm9tIG1hY3JvICdBQ1BJX1BUUl9ESUZGJw0KPiAgICNkZWZpbmUgQUNQSV9QVFJfRElG
RihhLCBiKSAgICAgICAgICAgICAoKGFjcGlfc2l6ZSkgKEFDUElfQ0FTVF9QVFIgKHU4LCAoYSkp
IC0gQUNQSV9DQVNUX1BUUiAodTgsIChiKSkpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+
IF4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4gQ29udmVydCB0aGVtIHRvIHRoZSBtb2Rlcm4gZXF1
aXZhbGVudHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYWNwaS9hY3R5cGVzLmggfCA0ICsrLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmggaW5k
ZXggDQo+IDkyYzcxZGZjZTBkNS4uMjg1YmM3YjczZGUzIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2FjcGkvYWN0eXBlcy5oDQo+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgNCj4gQEAgLTUw
Nyw4ICs1MDcsOCBAQCB0eXBlZGVmIHU2NCBhY3BpX2ludGVnZXI7DQo+ICAgLyogUG9pbnRlci9J
bnRlZ2VyIHR5cGUgY29udmVyc2lvbnMgKi8NCj4gICANCj4gICAjZGVmaW5lIEFDUElfVE9fUE9J
TlRFUihpKSAgICAgICAgICAgICAgQUNQSV9DQVNUX1BUUiAodm9pZCwgKGFjcGlfc2l6ZSkgKGkp
KQ0KPiAtI2RlZmluZSBBQ1BJX1RPX0lOVEVHRVIocCkgICAgICAgICAgICAgIEFDUElfUFRSX0RJ
RkYgKHAsICh2b2lkICopIDApDQo+IC0jZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpICAgICAgICAg
ICAgICAgQUNQSV9QVFJfRElGRiAoJigoKGQgKikgMCktPmYpLCAodm9pZCAqKSAwKQ0KPiArI2Rl
ZmluZSBBQ1BJX1RPX0lOVEVHRVIocCkgICAgICAgICAgICAgICgodWludHB0cl90KShwKSkNCj4g
KyNkZWZpbmUgQUNQSV9PRkZTRVQoZCwgZikgICAgICAgICAgICAgICBvZmZzZXRvZihkLCBmKQ0K
PiAgICNkZWZpbmUgQUNQSV9QSFlTQUREUl9UT19QVFIoaSkgICAgICAgICBBQ1BJX1RPX1BPSU5U
RVIoaSkNCj4gICAjZGVmaW5lIEFDUElfUFRSX1RPX1BIWVNBRERSKGkpICAgICAgICAgQUNQSV9U
T19JTlRFR0VSKGkpDQo+ICAgDQoNCg0K
