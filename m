Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137512A3293
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBSL0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 13:11:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:59057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKBSLZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:25 -0500
IronPort-SDR: 5R+pxpHglk16TyvWL576MM8ecnxhGU/BbZEIbuYy91MKcsmoSNyVsJFu9oI1/2GvjTzaPNhW75
 au0I1CdOJzag==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165423967"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="165423967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 10:11:25 -0800
IronPort-SDR: QGrUjS4up1UyNSr1WeBQV0MtAt9Oo3/o+4etMB/wAbpnS2PzUHa1oyhKqUVCQdmm/YLtPDtrjl
 rppPrVo2Wv8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="470469737"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2020 10:11:24 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 10:11:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 10:11:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 10:11:24 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 10:11:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I89CVVRX+131nghU2FaUfZy3y1q+eRjFAJhTikTGQIoaBTApgvco/TmhPptA6kxvGT2EwTfvGhIP7t1nYkhL/RuoVJFKqA1XlvwyqAPOY0tw2UZj/VcEqB9jzs28zTVkIP7EltvWtZqpEku1nUTcqXZ/W4iKOqtIA1mWynIBhzn1nSpYrUriXyYnwHRrp2UX4i2qzxZWrz7sm61+fZWh2CZfyjRh3R375ot79ANULuRFDoqYXQlJE7+sAfBzoiZN2y+gHVc3oWJ+Zu4ltiIusqHgyvqgABwUI+rSgDNedzIuUMoZkTZGfKY1SexWdvrYlw6WdyssjehBdCmccFzOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fInlsdEhRGWDyqi6Xh6jvmoYivDqbFGmCS/HI/xZ6Ag=;
 b=K6M5hhFsXcZWi7hKlIsYd2GCL+bnoOi/DHoX6bnh6Rkk7G8YqFKPPttbBGSl13QzPaaibf8zp6xtw3/9JfU/tOELRyJYpf+XgN2az4YwtG8HogC/Mw4aTHiwdFyTKBM2UYj0y8LlA399VgD6AovTFDdy+z4F7ojLDkDS8DjHecwct7YmKkQw2uRx9LvgriGR42d+6ES4mvZqykslkMjzLPgy6nSfPwNhueDoVT+4ovv4VNylVH/08RehI16a1M6nkkkfyG/duAdXwQLWt0oDd0QB1iVj14X73wRs59+LjRZpx87STXMqaTnpFQbaOlca5iHo2SNkI9C9Qa5krv00yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fInlsdEhRGWDyqi6Xh6jvmoYivDqbFGmCS/HI/xZ6Ag=;
 b=dvXYJeXtE4yB+65R3ObJwYUuFyvuoK/0IGSFqEJ25EVKMhly94IcsQPxxDXq+98V86NfF2hHZhWAXt8D+TFLrcwmz/de/1CRIRKfAUGw3H95s6W1SlPTWKw8X2TUnhI8meUtj+EqTeK39JXMuHwpG1fmdUSHxvZI3qqalzs2hZg=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 18:11:22 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31%10]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:11:22 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Asselstine <mark.asselstine@windriver.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: avoid double free when object already has a zero
 reference count
Thread-Topic: [PATCH] ACPICA: avoid double free when object already has a zero
 reference count
Thread-Index: AQHWrZgqUSUAS5yOM0Kd9m5guNYbU6mungEAgAaNfIA=
Date:   Mon, 2 Nov 2020 18:11:22 +0000
Message-ID: <MWHPR11MB15993189246B6AC609247D69F0100@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201028200523.111028-1-mark.asselstine@windriver.com>
 <CAJZ5v0hr4xFA9bGJM+0e4i-QpESPnwy5ZT4KPwfJgby5Sz3UBw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hr4xFA9bGJM+0e4i-QpESPnwy5ZT4KPwfJgby5Sz3UBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.45.176.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ef0fb6-2029-44f9-f1e6-08d87f5ab46a
x-ms-traffictypediagnostic: CO1PR11MB5188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB518871C29CD90D4685D4564EF0100@CO1PR11MB5188.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k77Ho6tnMcZ8dFfZr0SmzrM7qc5nqq1B8l5NKqzBwlz3h6r1ZVzWx715t10AoPZrKEw7ZM4pp11CvvkeFNPWCNC/Vn874eT4FbHxkDpgWXgdJUWYG2Ppn6600LpHAz2KJwcNwxpPTuOtkrvaB1i5LdrryOM9XhHZqA5vjzG8qAVe0paNFlNTtR1gZWsdnJHHpypMvypvBGTFI7d3LOIez7+IiXWrjRBNlZD5xHBMadKOSeHqvggQxbTFi/ICNb3gi6YvSf7zXEH6RzUGeZL3s8LMrnKoqOYw5G3fCqMXeeya4Ol0rVZ3UDu/1+p3McrS9ghzQknxnxH4rCzGMF8WZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(8676002)(107886003)(2906002)(8936002)(7696005)(71200400001)(53546011)(26005)(6506007)(4326008)(86362001)(186003)(110136005)(54906003)(478600001)(316002)(55016002)(9686003)(64756008)(66476007)(66946007)(83380400001)(5660300002)(52536014)(33656002)(66556008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6KQd8QeZtXV3GxlB8o9yu4QJD19rTd+GPXbE0NmNyECiyxSfWeMzJjTHgzVWl60nA0wC76UMjnAQpmxkU+TP0y8BVGpghElYgmI34/P/V+7y6o3lENW8A2RgwKi0+mr3qLXPbhwsQXCo3s7sNvxWhRfZCnQjZGFm4yxDv/vjykvJ8sFN504LKo2IE0/S9JcS5Q1KrSBDWBMcBWyV8odoOaz9ERNzrBr4peANk/vniSW5TmPIeJAlo1J3eNL6wz2JDXXtW10nuVUSbWvyDAXtmJOWDiSE8FYfEuejylXFK9FfUlWBROp7xYO/wfGaMcDHWoo6GS2BYDnhujJJngY0v0W3WKIHcURXap/+3awvQNzIeaB5ABMCPTWc2JTDSiFvTTfDxI3TCtHBpeH7UH1MYzI+lqWcUA1GWMhZBpqZmEyMvGff42kI3hkOVD29jmtoHHl2l9kHbrQLCDf7zIyFOyQdOrAqAuLlPJOk6/sQOEa7YJgtOKOABpQYGUrbljiNj/26NGXKVQTe3PjBxrNbjcBOONPlvUOJB5Y85aODYU3Sek65RzD7DCxnkKuAqLk1rKbSce31FFpPiujRgzjp5u4AqMClxYAOlK4MsO2y4DiAxdmJL55UNhs+egCNeOZBucKPDyUZd7aSp0pRk/MtJA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ef0fb6-2029-44f9-f1e6-08d87f5ab46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 18:11:22.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEBfkkpd6o5bGH/nk2sOtLvTIw5sRDIqTpePBx91QiukoDVzNtl+hc6PY0x5KWMxQG+dEqjnI/JEDl7fC26z9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyOSwgMjAy
MCA3OjA2IEFNDQo+IFRvOiBNYXJrIEFzc2Vsc3RpbmUgPG1hcmsuYXNzZWxzdGluZUB3aW5kcml2
ZXIuY29tPg0KPiBDYzogQUNQSSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc+OyBLYW5lZGEsIEVyaWsNCj4gPGVyaWsua2FuZWRhQGludGVsLmNvbT47IE1vb3Jl
LCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IEFDUElDQTogYXZvaWQgZG91YmxlIGZyZWUgd2hlbiBvYmplY3QgYWxyZWFkeSBoYXMgYQ0KPiB6
ZXJvIHJlZmVyZW5jZSBjb3VudA0KPiANCj4gK0VyaWsgYW5kIEJvYg0KPiANCj4gT24gVGh1LCBP
Y3QgMjksIDIwMjAgYXQgMzowNSBBTSBNYXJrIEFzc2Vsc3RpbmUNCj4gPG1hcmsuYXNzZWxzdGlu
ZUB3aW5kcml2ZXIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBmaXJzdCB0cmlwIGludG8gYWNw
aV91dF91cGRhdGVfcmVmX2NvdW50KCkgZm9yIGFuIG9iamVjdCB3aGVyZQ0KPiA+ICdvYmplY3Qt
PmNvbW1vbi5yZWZlcmVuY2VfY291bnQnIGlzIDEgYW5kIHdlIGFyZSBwZXJmb3JtaW5nIGENCj4g
PiBSRUZfREVDUkVNRU5UIHdpbGwgcmVzdWx0IGluICduZXdfY291bnQnIGJlaW5nIDAgYW5kIHRo
dXMgdGhlIG9iamVjdA0KPiA+IGlzIGRlbGV0ZWQgdmlhIGFjcGlfdXRfZGVsZXRlX2ludGVybmFs
X29iaigpLg0KPiA+DQo+ID4gSWYgZm9yIHNvbWUgcmVhc29uIHdlIG1ha2UgYSBzdWJzZXF1ZW50
IHRyaXAgaW50bw0KPiA+IGFjcGlfdXRfdXBkYXRlX3JlZl9jb3VudCgpIHdpdGggdGhlIHNhbWUg
b2JqZWN0LA0KPiA+IG9iamVjdC0+Y29tbW9uLnJlZmVyZW5jZV9jb3VudCcgd2lsbCBiZSAwIGFu
ZCBwZXJmb3JtaW5nIGENCj4gPiBSRUZfREVDUkVNRU5UIHdpbGwgcHJvZHVjZSBhIHdhcm5pbmcg
bXNnICJSZWZlcmVuY2UgQ291bnQgaXMgYWxyZWFkeQ0KPiA+IHplcm8sIGNhbm5vdCBkZWNyZW1l
bnQiLCAnbmV3X2NvdW50JyB3aWxsIGFnYWluIGJlIDAgYW5kIHRoZSBhbHJlYWR5DQo+ID4gZGVs
ZXRlZCBvYmplY3Qgd2lsbCBiZSBhdHRlbXB0ZWQgdG8gYmUgZGVsZXRlZCBhZ2FpbiB2aWENCj4g
PiBhY3BpX3V0X2RlbGV0ZV9pbnRlcm5hbF9vYmooKS4NCg0KTWFyaywgRG8geW91IGhhdmUgYW4g
ZXhhbXBsZSBvZiBBTUwvQVNMIHRoYXQgeW91IHVzZWQgdG8gZGV0ZXJtaW5lIHRoaXMgZG91Ymxl
IGZyZWU/DQoNClRoYW5rcywNCkVyaWsNCg0KPiA+DQo+ID4gU2luY2UgdGhlIG9iamVjdCBkZWxl
dGlvbiBkb2Vzbid0IE5VTEwgdGhlIG9iamVjdCB0aGUgY2FsbHMgdG8NCj4gPiBhY3BpX3V0X2Rl
bGV0ZV9pbnRlcm5hbF9vYmooKSwgYWNwaV91dF9kZWxldGVfb2JqZWN0X2Rlc2MoKSwNCj4gPiBh
Y3BpX29zX3JlbGVhc2Vfb2JqZWN0KCksIGttZW1fY2FjaGVfZnJlZSgpIHdpbGwgb3BlcmF0ZSBv
biB0aGUgb2JqZWN0DQo+ID4gYXMgaWYgaXQgaGFzbid0IGJlZW4gZGVsZXRlZC4gSW4gbWFueSBj
YXNlcyB0aGlzIGNhbiByZXN1bHQgaW4gbm8NCj4gPiBpc3N1ZXMsIGJ1dCBpZiB5b3UgYXJlIHVz
aW5nIHRoZSBzbGFiIGFuZCBhIG5ldyBvYmplY3QgaGFzIGJlZW4NCj4gPiBjcmVhdGVkIHdpdGgg
dGhlIHNhbWUgYWRkcmVzcyB0aGlzIGNhbiBiZSB0aGUgY2F1c2Ugc2xhYiBjb3JydXB0aW9uLg0K
PiA+DQo+ID4gQWRkaW5nIGEgY2hlY2sgaWYgd2UgYXJlIGRlY3JlbWVudGluZyB0byAwIGZvciB0
aGUgZmlyc3QgdGltZSBhbmQgb25seQ0KPiA+IGNhbGxpbmcgYWNwaV91dF9kZWxldGVfaW50ZXJu
YWxfb2JqKCkgaW4gdGhpcyBjYXNlIHdpbGwgcHJldmVudA0KPiA+IGFub3RoZXIgYXR0ZW1wdCBh
dCBkZWxldGluZyB0aGUgb2JqZWN0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyayBBc3Nl
bHN0aW5lIDxtYXJrLmFzc2Vsc3RpbmVAd2luZHJpdmVyLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS91dGRl
bGV0ZS5jDQo+ID4gaW5kZXggNGMwZDRlNDM0MTk2Li5jNmI4NjBmZDllYjUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9h
Y3BpL2FjcGljYS91dGRlbGV0ZS5jDQo+ID4gQEAgLTQyMSw5ICs0MjEsOSBAQCBhY3BpX3V0X3Vw
ZGF0ZV9yZWZfY291bnQodW5pb24NCj4gYWNwaV9vcGVyYW5kX29iamVjdCAqb2JqZWN0LCB1MzIg
YWN0aW9uKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUNQSV9H
RVRfRlVOQ1RJT05fTkFNRSwgb2JqZWN0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgb2JqZWN0LT5jb21tb24udHlwZSwgbmV3X2NvdW50KSk7DQo+ID4NCj4gPiAt
ICAgICAgICAgICAgICAgLyogQWN0dWFsbHkgZGVsZXRlIHRoZSBvYmplY3Qgb24gYSByZWZlcmVu
Y2UgY291bnQgb2YgemVybyAqLw0KPiA+ICsgICAgICAgICAgICAgICAvKiBJZiB3ZSBoYXZlbid0
IGFscmVhZHksIGFjdHVhbGx5IGRlbGV0ZSB0aGUgb2JqZWN0IG9uIGEgcmVmZXJlbmNlDQo+IGNv
dW50IG9mIHplcm8gKi8NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBpZiAobmV3X2NvdW50ID09
IDApIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKG5ld19jb3VudCA9PSAwICYmIG9yaWdpbmFs
X2NvdW50ICE9IDApIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBhY3BpX3V0X2RlbGV0
ZV9pbnRlcm5hbF9vYmoob2JqZWN0KTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAg
ICAgICAgICAgICBtZXNzYWdlID0gIkRlY3JlbWVudCI7DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4g
Pg0K
