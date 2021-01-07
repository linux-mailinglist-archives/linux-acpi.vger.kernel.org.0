Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8822EC9DC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 06:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAGFLU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 00:11:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:47387 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbhAGFLU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 00:11:20 -0500
IronPort-SDR: 7lR9+5Ynkb9jx4gdHEpbnHSphewj2xUOzpUI3gUaP34+S3Rg/MjBCX1VWUJ0aMS9syD/hPP6EZ
 SElrXWCxeAeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="173866034"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="173866034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 21:10:39 -0800
IronPort-SDR: cUAcMg9nHOIGQ69XSsqShzzb45m/z4GWkwCEVrdwm6V7gGH8stO8OT8/oAn1zXzDEc9F9js6Rn
 FB/xGkyMmoSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="566042941"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2021 21:10:38 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 21:10:37 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Jan 2021 13:10:36 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Thu, 7 Jan 2021 13:10:36 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "mjg59@codon.org.uk" <mjg59@codon.org.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling
 device binding
Thread-Topic: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling
 device binding
Thread-Index: AQHW0nJ0H4IIUd4InUWm3OU4yKraraoYyEkAgALdnGA=
Date:   Thu, 7 Jan 2021 05:10:35 +0000
Message-ID: <cb755a9f2b314dcda0392fd5c08f7fb9@intel.com>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-4-daniel.lezcano@linaro.org>
 <1de4868e-6229-ed33-f45a-7cd82d3ee48a@linaro.org>
In-Reply-To: <1de4868e-6229-ed33-f45a-7cd82d3ee48a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

QUNQSSB0aGVybWFsIGRyaXZlciBiaW5kcyB0aGUgZGV2aWNlcyBsaXN0ZWQgaW4gX1RaRCBtZXRo
b2Qgd2l0aCBUSEVSTUFMX1RSSVBTX05PTkUuDQpOb3cgZ2l2ZW4gdGhhdA0KMS4gVEhFUk1BTF9U
UklQU19OT05FIGlzIHJlbW92ZWQgZnJvbSB0aGVybWFsIGZyYW1ld29yaw0KMi4gX1RaUCBpcyBy
YXJlbHkgc3VwcG9ydGVkLiBJIHNlYXJjaGVkIH41MDAgYWNwaWR1bXBzIGZyb20gZGlmZmVyZW50
IHBsYXRmb3JtcyByZXBvcnRlZCBieSBlbmQgdXNlcnMgaW4ga2VybmVsIEJ1Z3ppbGxhLCB0aGVy
ZSBpcyBvbmx5IG9uZSBwbGF0Zm9ybSB3aXRoIF9UWlAgaW1wbGVtZW50ZWQsIGFuZCBpdCB3YXMg
YWxtb3N0IDEwIHllYXJzIGFnby4NCg0KU28sIEkgdGhpbmsgaXQgaXMgc2FmZSB0byByZW1vdmUg
dGhpcyBwaWVjZSBvZiBjb2RlLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiBU
dWVzZGF5LCBKYW51YXJ5IDA1LCAyMDIxIDExOjQ0IFBNDQo+IFRvOiBaaGFuZywgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPg0KPiBDYzogbWpnNTlAY29kb24ub3JnLnVrOyBsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWl0a0BrZXJu
ZWwub3JnOyB0aGFyYS5nb3BpbmF0aEBsaW5hcm8ub3JnOw0KPiBSYWZhZWwgSi4gV3lzb2NraSA8
cmp3QHJqd3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IG9wZW4NCj4g
bGlzdDpBQ1BJIFRIRVJNQUwgRFJJVkVSIDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCA0LzZdIGFjcGkvZHJpdmVycy90aGVybWFsOiBSZW1vdmUgVFJJ
UFNfTk9ORSBjb29saW5nDQo+IGRldmljZSBiaW5kaW5nDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4g
DQo+IEhpIFJ1aSwNCj4gDQo+IA0KPiBPbiAxNS8xMi8yMDIwIDAwOjM4LCBEYW5pZWwgTGV6Y2Fu
byB3cm90ZToNCj4gPiBUaGUgbG9vcCBpcyBoZXJlIHRvIGNyZWF0ZSBkZWZhdWx0IGNvb2xpbmcg
ZGV2aWNlIGJpbmRpbmcgb24gdGhlDQo+ID4gVEhFUk1BTF9UUklQU19OT05FIG51bWJlciB3aGlj
aCBpcyB1c2VkIHRvIGJlIHRoZSAnZm9yY2VkX3Bhc3NpdmUnDQo+ID4gZmVhdHVyZS4gSG93ZXZl
ciwgd2UgcmVtb3ZlZCBhbGwgY29kZSBkZWFsaW5nIHdpdGggdGhhdCBpbiB0aGUgdGhlcm1hbA0K
PiA+IGNvcmUsIHRodXMgdGhpcyBiaW5kaW5nIGRvZXMgbm8gbG9uZ2VyIG1ha2Ugc2Vuc2UuDQo+
ID4NCj4gPiBSZW1vdmUgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgTGV6Y2Fu
byA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCg0KQWNrZWQtYnk6IFpoYW5nIFJ1aSA8cnVp
LnpoYW5nQGludGVsLmNvbT4NCg0KVGhhbmtzLA0KcnVpDQo+IA0KPiBBcmUgeW91IGZpbmUgd2l0
aCB0aGlzIGNoYW5nZT8NCj4gDQo+IFRoYW5rcw0KPiANCj4gICAtLSBEYW5pZWwNCj4gDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvYWNwaS90aGVybWFsLmMgfCAxOSAtLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jIGIvZHJpdmVycy9hY3BpL3RoZXJtYWwuYyBpbmRl
eA0KPiA+IGI1ZTRiYzllMzI4Mi4uMjZhODlmZjgwYTBlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvYWNwaS90aGVybWFsLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jDQo+ID4g
QEAgLTc2NCwyNSArNzY0LDYgQEAgc3RhdGljIGludCBhY3BpX3RoZXJtYWxfY29vbGluZ19kZXZp
Y2VfY2Ioc3RydWN0DQo+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnRoZXJtYWwsDQo+ID4gIAkJfQ0K
PiA+ICAJfQ0KPiA+DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgdHotPmRldmljZXMuY291bnQ7IGkr
Kykgew0KPiA+IC0JCWhhbmRsZSA9IHR6LT5kZXZpY2VzLmhhbmRsZXNbaV07DQo+ID4gLQkJc3Rh
dHVzID0gYWNwaV9idXNfZ2V0X2RldmljZShoYW5kbGUsICZkZXYpOw0KPiA+IC0JCWlmIChBQ1BJ
X1NVQ0NFU1Moc3RhdHVzKSAmJiAoZGV2ID09IGRldmljZSkpIHsNCj4gPiAtCQkJaWYgKGJpbmQp
DQo+ID4gLQkJCQlyZXN1bHQgPSB0aGVybWFsX3pvbmVfYmluZF9jb29saW5nX2RldmljZQ0KPiA+
IC0JCQkJCQkodGhlcm1hbCwNCj4gVEhFUk1BTF9UUklQU19OT05FLA0KPiA+IC0JCQkJCQkgY2Rl
diwgVEhFUk1BTF9OT19MSU1JVCwNCj4gPiAtCQkJCQkJIFRIRVJNQUxfTk9fTElNSVQsDQo+ID4g
LQ0KPiBUSEVSTUFMX1dFSUdIVF9ERUZBVUxUKTsNCj4gPiAtCQkJZWxzZQ0KPiA+IC0JCQkJcmVz
dWx0ID0NCj4gdGhlcm1hbF96b25lX3VuYmluZF9jb29saW5nX2RldmljZQ0KPiA+IC0JCQkJCQko
dGhlcm1hbCwNCj4gVEhFUk1BTF9UUklQU19OT05FLA0KPiA+IC0JCQkJCQkgY2Rldik7DQo+ID4g
LQkJCWlmIChyZXN1bHQpDQo+ID4gLQkJCQlnb3RvIGZhaWxlZDsNCj4gPiAtCQl9DQo+ID4gLQl9
DQo+ID4gLQ0KPiA+ICBmYWlsZWQ6DQo+ID4gIAlyZXR1cm4gcmVzdWx0Ow0KPiA+ICB9DQo+ID4N
Cj4gDQo+IA0KPiAtLQ0KPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBGb2xsb3cgTGluYXJvOiAg
PGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfA0KPiA8aHR0
cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8IDxodHRwOi8vd3d3LmxpbmFy
by5vcmcvbGluYXJvLQ0KPiBibG9nLz4gQmxvZw0K
