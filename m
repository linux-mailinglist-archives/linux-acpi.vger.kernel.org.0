Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6412B26A1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKMV1h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 16:27:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:20634 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMV1K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 16:27:10 -0500
IronPort-SDR: t00EgCu2ImP+nn7tuVTecGSjOtbNbF4jY//aV76ehWeg8LKVDat0/NYBZ1cmNZaMN5zr5paCyQ
 h9STHcPNNX4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170639324"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="170639324"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:27:07 -0800
IronPort-SDR: fSly51ZhqySxb4TOE2z5WahDHWTSa8x1NVo7+qKTzVHCzV4RRRz5nIkMWZIKHo/2jzjZxlIUQe
 WqlPiCK0KloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="399862990"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2020 13:27:07 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 13:27:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 13:27:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Nov 2020 13:27:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 13 Nov 2020 13:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH2qFwb6gLiJwOs7Pyi32drxOBH5cjB9AZUAFcVQUHwyXfgEkww1NCucHf3TzB2hUtDeDcoJSsxRp0MpqngdccLxGvMbYzlXpErEs1qXBvJglCBoO+xQmUVpXG0h/FOC7ZfmzAClrY8zQvTSlets/rz+R7LMvq7rz9oqBwhQBbEZ1FzipqtjFi2dXhQ7/3JJdnMBZD5x5BH7N2Tj5V7cN0hoAgxpModvDOPrgIwz26LJ1VJnH1vRq0KsE/gXFjdN5yzTfB2Rf6ShYfvGqO60lA1Fl25GJJvX1SU0ko2JnsJlQFysBCs7w5AgqPgQZ18twQMYAuMBIff0O1QmnVFG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO/Enr5YBfPSQMOkuiPToyKP6O8h1tjKEVSY8sr5HPU=;
 b=YwNJsX2cOE1dCN/h3WozrxiLBj6mrB3rVDfSlPWzAeLJ78j4g/B0Phiv/1cJunpUwlGwWwZcapmdGSQTNxSySsLaDWckM5enBiEU/KHFephHgId7ErDms3FsIz6x2gevq+DsuubNqvIILOiD9bEq/9Z0fk4D2mLFhjOgZCpZ1umsyUOqtl4uY6xPkbkD9E2eMVYsi30ju+pLXyWbvGSbDl1Ut00BhCCj5RfOnXRAZj/vzx7v4HWszU//g5Qo683J3lC9bsXr9jgTGLIFkRljzdoMxAzSDcY1rQz9ae1H2hPl9rQRzqvcVlQThnRAZTWdkwJMVdNZOuAOz3m4/QBN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO/Enr5YBfPSQMOkuiPToyKP6O8h1tjKEVSY8sr5HPU=;
 b=GJXE2vc4yQ3emaQIZf+9EfvsT0qolrvziz4hV1K6wDXa9NRitBtGRm+NO9HkRspsVG3peqjcfFIEGl1o5bjwJFLJ87xlXQp4z1VaACN+m8TZ9Sxoya4IcJIDHQH3yxXMLAKJpZrAIujH8kzelRoCStUmFjLAzdYF7vr8KsR08sI=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 21:27:03 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 21:27:03 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
CC:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough
Thread-Topic: [PATCH] ACPICA: fix -Wfallthrough
Thread-Index: AQHWt9BSaSJ92WwBRk6cKvxE5xanpKnGl5Sw
Date:   Fri, 13 Nov 2020 21:27:03 +0000
Message-ID: <BYAPR11MB32568FEEF4CFA1C20296427B87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
In-Reply-To: <20201111021131.822867-1-ndesaulniers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f0f4869-b3ed-4784-75fe-08d8881add55
x-ms-traffictypediagnostic: SJ0PR11MB5168:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5168528ECBC46C7EAFD0540B87E60@SJ0PR11MB5168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoYZzUX4qXpWbgb3pleHYh5VGVbONlfJ4hNfcq8W8fwsIHQfEgLpLo6aamI7E3pK+xsGKgoFfCblIM/VvVkERuCZUNesZ9ARI++biZMxeFKM5ETtFydEclAZp22HWQR/SkWH8qC/gttETDm0xSESRnpMf5UDHV0XCVgjsZXmc+2yifaxS0cIx6Rb2lHcHrZeEvIvEwSdta7pt1MNTZrxnmb3BjI2SzGF3604E3Xj6wmgIVbYyLZAfnzUnSBWzHA+SIxzHoX9l4C6T7z5cp3GIPNVVv4iLrWTIWo2EaJ9gr5Gm7fMCXUHLAzxPrTmJQEKEwK7OmyMXoyEGJYGdPVSTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(71200400001)(83380400001)(66556008)(4326008)(316002)(6506007)(66446008)(64756008)(55016002)(7696005)(9686003)(8936002)(54906003)(110136005)(66946007)(2906002)(86362001)(26005)(66476007)(53546011)(76116006)(8676002)(5660300002)(52536014)(478600001)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 05bI+71TPkybb87aaxQqvB52kbVgtSO2J82mKOD6nBrLM/f718RpufQYu/nNWcM5ss5IHDv/XmGPXBTpb5+MxliQ0w4qrA2BObfE7JLUSJt90Z5nkMvCVEHmSEqXczMiEXwXI+xrUaTHVMirDLMyV+5s6MPMjnAaefsFssOPNfgX2Jph69xszM6AenNIoEcCMAy+4PX+s6uiGswyJcPot5yl9847gre9njORi/6UTjsVria6+3cwzPZAIsC+3oOe05RUEI2Llf+/lH/H8lu2FsPKhwkn3fBJGNVoswIlsAKNGpg2h018P4/HByaeqf900jHt/aLvQEgYtg4LiG3hF6cWm9WjLgS9WrG6fAlS0Ejt6Ttv6IXhqwXGyuIpNFqYXYaRmq8e0GWAEhxMjc46f9ZHM2jPTJXozfkbtQkkNE/CAyPkR9sGSqFc4rOqJoogcPlOcrx6cC5fQNTa6J3yOByvSOqHYfYo3XM696YyVp8T5eCf75DWaY/S7IGWXvpjYq49+Lyn2q6RKitx/1WP6rjeo1sNuu+ghL7A4ci+zUtEvUsmFctpa9DsKIgYq0a3oXE0KU5uVvMGFsNRM1ArWKMfHchrtbfcOCicNWHjUu5swuzMyuHCjblqWMsFjerXk6o95XG8z8/t2sCCyyXsUA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0f4869-b3ed-4784-75fe-08d8881add55
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 21:27:03.5588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4n8VeS9YAdVcysbPGhyPb7pdbLPpqsI3HJgeDZqzbe5qSm33/lZ38AvM/7H9hJmcJkCm7M58XYe/To3maThTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBuZGVzYXVsbmllcnMgdmlhIHNl
bmRnbXIgPG5kZXNhdWxuaWVyc0BuZGVzYXVsbmllcnMxLm10di5jb3JwLmdvb2dsZS5jb20+IE9u
IEJlaGFsZiBPZiBOaWNrIERlc2F1bG5pZXJzDQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwg
MjAyMCA2OjEyIFBNDQpUbzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47
IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEog
PHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+DQpDYzogY2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBzLmNv
bTsgTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+OyBMZW4gQnJvd24g
PGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3Bp
Y2Eub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbUEFUQ0hdIEFD
UElDQTogZml4IC1XZmFsbHRocm91Z2gNCg0KVGhlICJmYWxsdGhyb3VnaCIgcHNldWRvLWtleXdv
cmQgd2FzIGFkZGVkIGFzIGEgcG9ydGFibGUgd2F5IHRvIGRlbm90ZSBpbnRlbnRpb25hbCBmYWxs
dGhyb3VnaC4gVGhpcyBjb2RlIHNlZW1lZCB0byBiZSB1c2luZyBhIG1peCBvZiBmYWxsdGhyb3Vn
aCBjb21tZW50cyB0aGF0IEdDQyByZWNvZ25pemVzLCBhbmQgc29tZSBraW5kIG9mIGxpbnQgbWFy
a2VyLg0KSSdtIGd1ZXNzaW5nIHRoYXQgbGludGVyIGhhc24ndCBiZWVuIHJ1biBpbiBhIHdoaWxl
IGZyb20gdGhlIG1peGVkIHVzZSBvZiB0aGUgbWFya2VyIHZzIGNvbW1lbnRzLg0KDQovKmxpbnQg
LWZhbGx0aHJvdWdoICovDQoNClRoaXMgaXMgdGhlIGxpbnQgbWFya2VyDQoNCkJUVywgd2hhdCB2
ZXJzaW9uIG9mIGdjYyBhZGRlZCAtV2ZhbGx0aHJvdWdoPw0KDQoNClNpZ25lZC1vZmYtYnk6IE5p
Y2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KLS0tDQogZHJpdmVycy9h
Y3BpL2FjcGljYS9kc2NvbnRyb2wuYyB8IDMgKy0tDQogZHJpdmVycy9hY3BpL2FjcGljYS9kc3dl
eGVjLmMgICB8IDQgKy0tLQ0KIGRyaXZlcnMvYWNwaS9hY3BpY2EvZHN3bG9hZC5jICAgfCAzICst
LQ0KIGRyaXZlcnMvYWNwaS9hY3BpY2EvZHN3bG9hZDIuYyAgfCAzICstLQ0KIGRyaXZlcnMvYWNw
aS9hY3BpY2EvZXhmbGRpby5jICAgfCAzICstLQ0KIGRyaXZlcnMvYWNwaS9hY3BpY2EvZXhyZXNv
cC5jICAgfCA1ICsrLS0tDQogZHJpdmVycy9hY3BpL2FjcGljYS9leHN0b3JlLmMgICB8IDYgKyst
LS0tDQogZHJpdmVycy9hY3BpL2FjcGljYS9od2dwZS5jICAgICB8IDMgKy0tDQogZHJpdmVycy9h
Y3BpL2FjcGljYS91dGRlbGV0ZS5jICB8IDMgKy0tDQogZHJpdmVycy9hY3BpL2FjcGljYS91dHBy
aW50LmMgICB8IDIgKy0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyMyBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNjb250cm9s
LmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2RzY29udHJvbC5jIGluZGV4IDRiNWI2ZTg1OWY2Mi4u
MWU3NWU1ZmJmZDE5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc2NvbnRyb2wu
Yw0KKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS9kc2NvbnRyb2wuYw0KQEAgLTYxLDggKzYxLDcg
QEAgYWNwaV9kc19leGVjX2JlZ2luX2NvbnRyb2xfb3Aoc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAq
d2Fsa19zdGF0ZSwNCiAJCQkJYnJlYWs7DQogCQkJfQ0KIAkJfQ0KLQ0KLQkJLypsaW50IC1mYWxs
dGhyb3VnaCAqLw0KKwkJZmFsbHRocm91Z2g7DQogDQogCWNhc2UgQU1MX0lGX09QOg0KIAkJLyoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2Rzd2V4ZWMuYyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvZHN3ZXhlYy5jIGluZGV4IDFkNGY4YzgxMDI4Yy4uZThjMzJkNGZlNTVmIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dleGVjLmMNCisrKyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvZHN3ZXhlYy5jDQpAQCAtNTk3LDkgKzU5Nyw3IEBAIGFjcGlfc3RhdHVzIGFjcGlf
ZHNfZXhlY19lbmRfb3Aoc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAqd2Fsa19zdGF0ZSkNCiAJCQkJ
aWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7DQogCQkJCQlicmVhazsNCiAJCQkJfQ0KLQ0KLQkJ
CQkvKiBGYWxsIHRocm91Z2ggKi8NCi0JCQkJLypsaW50IC1mYWxsdGhyb3VnaCAqLw0KKwkJCQlm
YWxsdGhyb3VnaDsNCiANCiAJCQljYXNlIEFNTF9JTlRfRVZBTF9TVUJUUkVFX09QOg0KIA0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHN3bG9hZC5jIGIvZHJpdmVycy9hY3BpL2Fj
cGljYS9kc3dsb2FkLmMgaW5kZXggMjcwNjkzMjViNmRlLi5hZmM2NjNjMzc0MmQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2Rzd2xvYWQuYw0KKysrIGIvZHJpdmVycy9hY3BpL2Fj
cGljYS9kc3dsb2FkLmMNCkBAIC0yMjMsOCArMjIzLDcgQEAgYWNwaV9kc19sb2FkMV9iZWdpbl9v
cChzdHJ1Y3QgYWNwaV93YWxrX3N0YXRlICp3YWxrX3N0YXRlLA0KIAkJCSAgICAgcGFyc2VfZmxh
Z3MgJiBBQ1BJX1BBUlNFX01PRFVMRV9MRVZFTCkpIHsNCiAJCQkJYnJlYWs7DQogCQkJfQ0KLQ0K
LQkJCS8qbGludCAtZmFsbHRocm91Z2ggKi8NCisJCQlmYWxsdGhyb3VnaDsNCiANCiAJCWRlZmF1
bHQ6DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dsb2FkMi5jIGIvZHJp
dmVycy9hY3BpL2FjcGljYS9kc3dsb2FkMi5jIGluZGV4IGVkYWRiZTE0NjUwNi4uMWI3OTRiNmJh
MDcyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dsb2FkMi5jDQorKysgYi9k
cml2ZXJzL2FjcGkvYWNwaWNhL2Rzd2xvYWQyLmMNCkBAIC0yMTMsOCArMjEzLDcgQEAgYWNwaV9k
c19sb2FkMl9iZWdpbl9vcChzdHJ1Y3QgYWNwaV93YWxrX3N0YXRlICp3YWxrX3N0YXRlLA0KIAkJ
CSAgICAgcGFyc2VfZmxhZ3MgJiBBQ1BJX1BBUlNFX01PRFVMRV9MRVZFTCkpIHsNCiAJCQkJYnJl
YWs7DQogCQkJfQ0KLQ0KLQkJCS8qbGludCAtZmFsbHRocm91Z2ggKi8NCisJCQlmYWxsdGhyb3Vn
aDsNCiANCiAJCWRlZmF1bHQ6DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9l
eGZsZGlvLmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmxkaW8uYyBpbmRleCBhZGUzNWZmMWM3
YmEuLjlkMWNhYmUwZmVkOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhmbGRp
by5jDQorKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmxkaW8uYw0KQEAgLTQzMyw4ICs0MzMs
NyBAQCBhY3BpX2V4X2ZpZWxkX2RhdHVtX2lvKHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKm9i
al9kZXNjLA0KIAkJICogTm93IHRoYXQgdGhlIEJhbmsgaGFzIGJlZW4gc2VsZWN0ZWQsIGZhbGwg
dGhyb3VnaCB0byB0aGUNCiAJCSAqIHJlZ2lvbl9maWVsZCBjYXNlIGFuZCB3cml0ZSB0aGUgZGF0
dW0gdG8gdGhlIE9wZXJhdGlvbiBSZWdpb24NCiAJCSAqLw0KLQ0KLQkJLypsaW50IC1mYWxsdGhy
b3VnaCAqLw0KKwkJZmFsbHRocm91Z2g7DQogDQogCWNhc2UgQUNQSV9UWVBFX0xPQ0FMX1JFR0lP
Tl9GSUVMRDoNCiAJCS8qDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9leHJlc29w
LmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4cmVzb3AuYyBpbmRleCA0ZDFiMjI5NzFkNTguLmRm
NDhmYWE5YTU1MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhyZXNvcC5jDQor
KysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4cmVzb3AuYw0KQEAgLTE5Nyw4ICsxOTcsNyBAQCBh
Y3BpX2V4X3Jlc29sdmVfb3BlcmFuZHModTE2IG9wY29kZSwNCiAJCQkJY2FzZSBBQ1BJX1JFRkNM
QVNTX0RFQlVHOg0KIA0KIAkJCQkJdGFyZ2V0X29wID0gQU1MX0RFQlVHX09QOw0KLQ0KLQkJCQkJ
LypsaW50IC1mYWxsdGhyb3VnaCAqLw0KKwkJCQkJZmFsbHRocm91Z2g7DQogDQogCQkJCWNhc2Ug
QUNQSV9SRUZDTEFTU19BUkc6DQogCQkJCWNhc2UgQUNQSV9SRUZDTEFTU19MT0NBTDoNCkBAIC0y
NjQsNyArMjYzLDcgQEAgYWNwaV9leF9yZXNvbHZlX29wZXJhbmRzKHUxNiBvcGNvZGUsDQogCQkJ
ICogRWxzZSBub3QgYSBzdHJpbmcgLSBmYWxsIHRocm91Z2ggdG8gdGhlIG5vcm1hbCBSZWZlcmVu
Y2UNCiAJCQkgKiBjYXNlIGJlbG93DQogCQkJICovDQotCQkJLypsaW50IC1mYWxsdGhyb3VnaCAq
Lw0KKwkJCWZhbGx0aHJvdWdoOw0KIA0KIAkJY2FzZSBBUkdJX1JFRkVSRU5DRToJLyogUmVmZXJl
bmNlczogKi8NCiAJCWNhc2UgQVJHSV9JTlRFR0VSX1JFRjoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvYWNwaWNhL2V4c3RvcmUuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhzdG9yZS5jIGlu
ZGV4IDNhZGMwYTI5ZDg5MC4uMjA2N2JhYTdjMTIwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3Bp
L2FjcGljYS9leHN0b3JlLmMNCisrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhzdG9yZS5jDQpA
QCAtOTUsOCArOTUsNyBAQCBhY3BpX2V4X3N0b3JlKHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3Qg
KnNvdXJjZV9kZXNjLA0KIAkJaWYgKGRlc3RfZGVzYy0+Y29tbW9uLmZsYWdzICYgQU9QT0JKX0FN
TF9DT05TVEFOVCkgew0KIAkJCXJldHVybl9BQ1BJX1NUQVRVUyhBRV9PSyk7DQogCQl9DQotDQot
CQkvKmxpbnQgLWZhbGx0aHJvdWdoICovDQorCQlmYWxsdGhyb3VnaDsNCiANCiAJZGVmYXVsdDoN
CiANCkBAIC00MjEsOCArNDIwLDcgQEAgYWNwaV9leF9zdG9yZV9vYmplY3RfdG9fbm9kZSh1bmlv
biBhY3BpX29wZXJhbmRfb2JqZWN0ICpzb3VyY2VfZGVzYywNCiAJCQkJfQ0KIAkJCQlicmVhazsN
CiAJCQl9DQotDQotCQkJLyogRmFsbHRocm91Z2ggKi8NCisJCQlmYWxsdGhyb3VnaDsNCiANCiAJ
CWNhc2UgQUNQSV9UWVBFX0RFVklDRToNCiAJCWNhc2UgQUNQSV9UWVBFX0VWRU5UOg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvaHdncGUuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
aHdncGUuYyBpbmRleCBiMTNhNGVkNWJjNjMuLmZiZmFkODBjOGE1MyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvYWNwaS9hY3BpY2EvaHdncGUuYw0KKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS9od2dw
ZS5jDQpAQCAtMTY2LDggKzE2Niw3IEBAIGFjcGlfaHdfbG93X3NldF9ncGUoc3RydWN0IGFjcGlf
Z3BlX2V2ZW50X2luZm8gKmdwZV9ldmVudF9pbmZvLCB1MzIgYWN0aW9uKQ0KIAkJaWYgKCEocmVn
aXN0ZXJfYml0ICYgZ3BlX3JlZ2lzdGVyX2luZm8tPmVuYWJsZV9tYXNrKSkgew0KIAkJCXJldHVy
biAoQUVfQkFEX1BBUkFNRVRFUik7DQogCQl9DQotDQotCQkvKmxpbnQgLWZhbGx0aHJvdWdoICov
DQorCQlmYWxsdGhyb3VnaDsNCiANCiAJY2FzZSBBQ1BJX0dQRV9FTkFCTEU6DQogDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jIGIvZHJpdmVycy9hY3BpL2FjcGlj
YS91dGRlbGV0ZS5jIGluZGV4IDRjMGQ0ZTQzNDE5Ni4uODA3NmU3OTQ3NTg1IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQorKysgYi9kcml2ZXJzL2FjcGkvYWNw
aWNhL3V0ZGVsZXRlLmMNCkBAIC0xMTEsOCArMTExLDcgQEAgc3RhdGljIHZvaWQgYWNwaV91dF9k
ZWxldGVfaW50ZXJuYWxfb2JqKHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKm9iamVjdCkNCiAJ
CQkodm9pZClhY3BpX2V2X2RlbGV0ZV9ncGVfYmxvY2sob2JqZWN0LT5kZXZpY2UuDQogCQkJCQkJ
ICAgICAgIGdwZV9ibG9jayk7DQogCQl9DQotDQotCQkvKmxpbnQgLWZhbGx0aHJvdWdoICovDQor
CQlmYWxsdGhyb3VnaDsNCiANCiAJY2FzZSBBQ1BJX1RZUEVfUFJPQ0VTU09SOg0KIAljYXNlIEFD
UElfVFlQRV9USEVSTUFMOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRwcmlu
dC5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS91dHByaW50LmMgaW5kZXggNjgxYzExZjRhZjRlLi5m
N2U0M2JhZjVmZjIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3V0cHJpbnQuYw0K
KysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS91dHByaW50LmMNCkBAIC00NzUsNyArNDc1LDcgQEAg
aW50IHZzbnByaW50ZihjaGFyICpzdHJpbmcsIGFjcGlfc2l6ZSBzaXplLCBjb25zdCBjaGFyICpm
b3JtYXQsIHZhX2xpc3QgYXJncykNCiAJCWNhc2UgJ1gnOg0KIA0KIAkJCXR5cGUgfD0gQUNQSV9G
T1JNQVRfVVBQRVI7DQotCQkJLyogRkFMTFRIUk9VR0ggKi8NCisJCQlmYWxsdGhyb3VnaDsNCiAN
CiAJCWNhc2UgJ3gnOg0KIA0KLS0NCjIuMjkuMi4yMjIuZzVkMmE5MmQxMGY4LWdvb2cNCg0K
