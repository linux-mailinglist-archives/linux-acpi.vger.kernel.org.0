Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71F346DD6
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 00:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhCWXVY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 19:21:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2736 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhCWXVP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Mar 2021 19:21:15 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4nLN6999z681yy;
        Wed, 24 Mar 2021 07:16:28 +0800 (CST)
Received: from lhreml721-chm.china.huawei.com (10.201.108.72) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 00:21:13 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 23:21:11 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 07:21:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for x86
Thread-Topic: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for
 x86
Thread-Index: AQHXHHecEK2PZNeGJ0y0ASUDVCEuNqqRruSAgACLbJA=
Date:   Tue, 23 Mar 2021 23:21:09 +0000
Message-ID: <67cc380019fd40d88d7a493b6cbc0852@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-5-song.bao.hua@hisilicon.com>
 <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com>
In-Reply-To: <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.12]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltIENoZW4gW21haWx0
bzp0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAy
NCwgMjAyMSAxMTo1MSBBTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+Ow0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBr
ZXJuZWwub3JnOyByandAcmp3eXNvY2tpLm5ldDsNCj4gdmluY2VudC5ndWl0dG90QGxpbmFyby5v
cmc7IGJwQGFsaWVuOC5kZTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29t
OyBsZW5iQGtlcm5lbC5vcmc7IHBldGVyekBpbmZyYWRlYWQub3JnOw0KPiBkaWV0bWFyLmVnZ2Vt
YW5uQGFybS5jb207IHJvc3RlZHRAZ29vZG1pcy5vcmc7IGJzZWdhbGxAZ29vZ2xlLmNvbTsNCj4g
bWdvcm1hbkBzdXNlLmRlDQo+IENjOiBtc3lzLm1penVtYUBnbWFpbC5jb207IHZhbGVudGluLnNj
aG5laWRlckBhcm0uY29tOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSm9uYXRoYW4g
Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4ganVyaS5sZWxsaUByZWRo
YXQuY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc3VkZWVwLmhvbGxhQGFybS5jb207DQo+IGF1
YnJleS5saUBsaW51eC5pbnRlbC5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOw0KPiB4dXdlaSAoTykgPHh1d2VpNUBodWF3ZWkuY29t
PjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47DQo+IGd1b2RvbmcueHVA
bGluYXJvLm9yZzsgeWFuZ3lpY29uZyA8eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgTGlndW96aHUg
KEtlbm5ldGgpDQo+IDxsaWd1b3podUBoaXNpbGljb24uY29tPjsgbGludXhhcm1Ab3BlbmV1bGVy
Lm9yZzsgaHBhQHp5dG9yLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NSA0LzRdIHNj
aGVkdWxlcjogQWRkIGNsdXN0ZXIgc2NoZWR1bGVyIGxldmVsIGZvciB4ODYNCj4gDQo+IA0KPiAN
Cj4gT24gMy8xOC8yMSA5OjE2IFBNLCBCYXJyeSBTb25nIHdyb3RlOg0KPiA+IEZyb206IFRpbSBD
aGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPg0KPiA+IFRoZXJlIGFyZSB4ODYg
Q1BVIGFyY2hpdGVjdHVyZXMgKGUuZy4gSmFjb2JzdmlsbGUpIHdoZXJlIEwyIGNhaGNlDQo+ID4g
aXMgc2hhcmVkIGFtb25nIGEgY2x1c3RlciBvZiBjb3JlcyBpbnN0ZWFkIG9mIGJlaW5nIGV4Y2x1
c2l2ZQ0KPiA+IHRvIG9uZSBzaW5nbGUgY29yZS4NCj4gPg0KPiA+IFRvIHByZXZlbnQgb3ZlcnN1
YnNjcmlwdGlvbiBvZiBMMiBjYWNoZSwgbG9hZCBzaG91bGQgYmUNCj4gPiBiYWxhbmNlZCBiZXR3
ZWVuIHN1Y2ggTDIgY2x1c3RlcnMsIGVzcGVjaWFsbHkgZm9yIHRhc2tzIHdpdGgNCj4gPiBubyBz
aGFyZWQgZGF0YS4NCj4gPg0KPiA+IEFsc28gd2l0aCBjbHVzdGVyIHNjaGVkdWxpbmcgcG9saWN5
IHdoZXJlIHRhc2tzIGFyZSB3b2tlbiB1cA0KPiA+IGluIHRoZSBzYW1lIEwyIGNsdXN0ZXIsIHdl
IHdpbGwgYmVuZWZpdCBmcm9tIGtlZXBpbmcgdGFza3MNCj4gPiByZWxhdGVkIHRvIGVhY2ggb3Ro
ZXIgYW5kIGxpa2VseSBzaGFyaW5nIGRhdGEgaW4gdGhlIHNhbWUgTDINCj4gPiBjbHVzdGVyLg0K
PiA+DQo+ID4gQWRkIENQVSBtYXNrcyBvZiBDUFVzIHNoYXJpbmcgdGhlIEwyIGNhY2hlIHNvIHdl
IGNhbiBidWlsZCBzdWNoDQo+ID4gTDIgY2x1c3RlciBzY2hlZHVsZXIgZG9tYWluLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJhcnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29t
Pg0KPiANCj4gDQo+IEJhcnJ5LA0KPiANCj4gQ2FuIHlvdSBhbHNvIGFkZCB0aGlzIGNodW5rIHRv
IHRoZSBwYXRjaC4NCj4gVGhhbmtzLg0KDQpTdXJlLCBUaW0sIFRoYW5rcy4gSSdsbCBwdXQgdGhh
dCBpbnRvIHBhdGNoIDQvNCBpbiB2Ni4NCg0KPiANCj4gVGltDQo+IA0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4gYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS90b3BvbG9neS5oDQo+IGluZGV4IDJhMTFjY2MxNGZiMS4uODAwZmE0OGM5ZmNkIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90b3BvbG9neS5oDQo+ICsrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4gQEAgLTExNSw2ICsxMTUsNyBAQCBleHRlcm4g
dW5zaWduZWQgaW50IF9fbWF4X2RpZV9wZXJfcGFja2FnZTsNCj4gDQo+ICAjaWZkZWYgQ09ORklH
X1NNUA0KPiAgI2RlZmluZSB0b3BvbG9neV9kaWVfY3B1bWFzayhjcHUpCQkocGVyX2NwdShjcHVf
ZGllX21hcCwgY3B1KSkNCj4gKyNkZWZpbmUgdG9wb2xvZ3lfY2x1c3Rlcl9jcHVtYXNrKGNwdSkJ
CShjcHVfY2x1c3Rlcmdyb3VwX21hc2soY3B1KSkNCj4gICNkZWZpbmUgdG9wb2xvZ3lfY29yZV9j
cHVtYXNrKGNwdSkJCShwZXJfY3B1KGNwdV9jb3JlX21hcCwgY3B1KSkNCj4gICNkZWZpbmUgdG9w
b2xvZ3lfc2libGluZ19jcHVtYXNrKGNwdSkJCShwZXJfY3B1KGNwdV9zaWJsaW5nX21hcCwgY3B1
KSkNCj4gDQoNClRoYW5rcw0KQmFycnkNCg0KDQo=
