Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696B34FDCB
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Mar 2021 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhCaKIC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 06:08:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2753 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhCaKHf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 06:07:35 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F9MFq5Xxcz685P0;
        Wed, 31 Mar 2021 17:58:23 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 12:07:31 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 11:07:30 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Wed, 31 Mar 2021 18:07:28 +0800
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
Thread-Index: AQHXHHecEK2PZNeGJ0y0ASUDVCEuNqqRruSAgACLbJCAC7WRgA==
Date:   Wed, 31 Mar 2021 10:07:28 +0000
Message-ID: <3888ad9a9b3e49feb4767452ebcdacdd@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-5-song.bao.hua@hisilicon.com>
 <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.63]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI0LCAyMDIxIDEyOjE1IFBNDQo+
IFRvOiAnVGltIENoZW4nIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT47IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOw0KPiB3aWxsQGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyB2aW5j
ZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgYnBAYWxpZW44LmRlOw0KPiB0Z2x4QGxpbnV0cm9uaXgu
ZGU7IG1pbmdvQHJlZGhhdC5jb207IGxlbmJAa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5v
cmc7DQo+IGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbTsgcm9zdGVkdEBnb29kbWlzLm9yZzsgYnNl
Z2FsbEBnb29nbGUuY29tOw0KPiBtZ29ybWFuQHN1c2UuZGUNCj4gQ2M6IG1zeXMubWl6dW1hQGdt
YWlsLmNvbTsgdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
Ow0KPiBqdXJpLmxlbGxpQHJlZGhhdC5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzdWRlZXAu
aG9sbGFAYXJtLmNvbTsNCj4gYXVicmV5LmxpQGxpbnV4LmludGVsLmNvbTsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7DQo+IHh1d2VpIChP
KSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24u
Y29tPjsNCj4gZ3VvZG9uZy54dUBsaW5hcm8ub3JnOyB5YW5neWljb25nIDx5YW5neWljb25nQGh1
YXdlaS5jb20+OyBMaWd1b3podSAoS2VubmV0aCkNCj4gPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+
OyBsaW51eGFybUBvcGVuZXVsZXIub3JnOyBocGFAenl0b3IuY29tDQo+IFN1YmplY3Q6IFJFOiBb
UkZDIFBBVENIIHY1IDQvNF0gc2NoZWR1bGVyOiBBZGQgY2x1c3RlciBzY2hlZHVsZXIgbGV2ZWwg
Zm9yIHg4Ng0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
RnJvbTogVGltIENoZW4gW21haWx0bzp0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbV0NCj4gPiBT
ZW50OiBXZWRuZXNkYXksIE1hcmNoIDI0LCAyMDIxIDExOjUxIEFNDQo+ID4gVG86IFNvbmcgQmFv
IEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPjsNCj4gPiBjYXRh
bGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyByandAcmp3eXNvY2tpLm5ldDsN
Cj4gPiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgYnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0
cm9uaXguZGU7DQo+ID4gbWluZ29AcmVkaGF0LmNvbTsgbGVuYkBrZXJuZWwub3JnOyBwZXRlcnpA
aW5mcmFkZWFkLm9yZzsNCj4gPiBkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb207IHJvc3RlZHRAZ29v
ZG1pcy5vcmc7IGJzZWdhbGxAZ29vZ2xlLmNvbTsNCj4gPiBtZ29ybWFuQHN1c2UuZGUNCj4gPiBD
YzogbXN5cy5taXp1bWFAZ21haWwuY29tOyB2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbTsNCj4g
PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gPiBqdXJpLmxlbGxpQHJlZGhhdC5jb207IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gPiBhdWJyZXkubGlAbGludXgu
aW50ZWwuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IHg4
NkBrZXJuZWwub3JnOw0KPiA+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFv
IChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsNCj4gPiBndW9kb25nLnh1QGxpbmFyby5v
cmc7IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47IExpZ3Vvemh1DQo+IChLZW5u
ZXRoKQ0KPiA+IDxsaWd1b3podUBoaXNpbGljb24uY29tPjsgbGludXhhcm1Ab3BlbmV1bGVyLm9y
ZzsgaHBhQHp5dG9yLmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY1IDQvNF0gc2No
ZWR1bGVyOiBBZGQgY2x1c3RlciBzY2hlZHVsZXIgbGV2ZWwgZm9yDQo+IHg4Ng0KPiA+DQo+ID4N
Cj4gPg0KPiA+IE9uIDMvMTgvMjEgOToxNiBQTSwgQmFycnkgU29uZyB3cm90ZToNCj4gPiA+IEZy
b206IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBU
aGVyZSBhcmUgeDg2IENQVSBhcmNoaXRlY3R1cmVzIChlLmcuIEphY29ic3ZpbGxlKSB3aGVyZSBM
MiBjYWhjZQ0KPiA+ID4gaXMgc2hhcmVkIGFtb25nIGEgY2x1c3RlciBvZiBjb3JlcyBpbnN0ZWFk
IG9mIGJlaW5nIGV4Y2x1c2l2ZQ0KPiA+ID4gdG8gb25lIHNpbmdsZSBjb3JlLg0KPiA+ID4NCj4g
PiA+IFRvIHByZXZlbnQgb3ZlcnN1YnNjcmlwdGlvbiBvZiBMMiBjYWNoZSwgbG9hZCBzaG91bGQg
YmUNCj4gPiA+IGJhbGFuY2VkIGJldHdlZW4gc3VjaCBMMiBjbHVzdGVycywgZXNwZWNpYWxseSBm
b3IgdGFza3Mgd2l0aA0KPiA+ID4gbm8gc2hhcmVkIGRhdGEuDQo+ID4gPg0KPiA+ID4gQWxzbyB3
aXRoIGNsdXN0ZXIgc2NoZWR1bGluZyBwb2xpY3kgd2hlcmUgdGFza3MgYXJlIHdva2VuIHVwDQo+
ID4gPiBpbiB0aGUgc2FtZSBMMiBjbHVzdGVyLCB3ZSB3aWxsIGJlbmVmaXQgZnJvbSBrZWVwaW5n
IHRhc2tzDQo+ID4gPiByZWxhdGVkIHRvIGVhY2ggb3RoZXIgYW5kIGxpa2VseSBzaGFyaW5nIGRh
dGEgaW4gdGhlIHNhbWUgTDINCj4gPiA+IGNsdXN0ZXIuDQo+ID4gPg0KPiA+ID4gQWRkIENQVSBt
YXNrcyBvZiBDUFVzIHNoYXJpbmcgdGhlIEwyIGNhY2hlIHNvIHdlIGNhbiBidWlsZCBzdWNoDQo+
ID4gPiBMMiBjbHVzdGVyIHNjaGVkdWxlciBkb21haW4uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQmFycnkgU29uZyA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+ID4NCj4g
Pg0KPiA+IEJhcnJ5LA0KPiA+DQo+ID4gQ2FuIHlvdSBhbHNvIGFkZCB0aGlzIGNodW5rIHRvIHRo
ZSBwYXRjaC4NCj4gPiBUaGFua3MuDQo+IA0KPiBTdXJlLCBUaW0sIFRoYW5rcy4gSSdsbCBwdXQg
dGhhdCBpbnRvIHBhdGNoIDQvNCBpbiB2Ni4NCg0KSGkgVGltLA0KWW91IG1pZ2h0IHdhbnQgdG8g
dGFrZSBhIGxvb2sgYXQgdGhpcyBxZW11IHBhdGNoc2V0Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDIxMDMzMTA5NTM0My4xMjE3Mi0xLXdhbmd5YW5hbjU1QGh1YXdlaS5j
b20vVC8jdA0KDQpzb21lb25lIGlzIHRyeWluZyB0byBsZXZlcmFnZSB0aGlzIGNsdXN0ZXIgdG9w
b2xvZ3kNCnRvIGltcHJvdmUgS1ZNIHZpcnR1YWwgbWFjaGluZXMgcGVyZm9ybWFuY2UuDQoNCj4g
DQo+ID4NCj4gPiBUaW0NCj4gPg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3RvcG9sb2d5LmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgN
Cj4gPiBpbmRleCAyYTExY2NjMTRmYjEuLjgwMGZhNDhjOWZjZCAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS90b3BvbG9neS5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdG9wb2xvZ3kuaA0KPiA+IEBAIC0xMTUsNiArMTE1LDcgQEAgZXh0ZXJuIHVuc2lnbmVk
IGludCBfX21heF9kaWVfcGVyX3BhY2thZ2U7DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJR19TTVAN
Cj4gPiAgI2RlZmluZSB0b3BvbG9neV9kaWVfY3B1bWFzayhjcHUpCQkocGVyX2NwdShjcHVfZGll
X21hcCwgY3B1KSkNCj4gPiArI2RlZmluZSB0b3BvbG9neV9jbHVzdGVyX2NwdW1hc2soY3B1KQkJ
KGNwdV9jbHVzdGVyZ3JvdXBfbWFzayhjcHUpKQ0KPiA+ICAjZGVmaW5lIHRvcG9sb2d5X2NvcmVf
Y3B1bWFzayhjcHUpCQkocGVyX2NwdShjcHVfY29yZV9tYXAsIGNwdSkpDQo+ID4gICNkZWZpbmUg
dG9wb2xvZ3lfc2libGluZ19jcHVtYXNrKGNwdSkJCShwZXJfY3B1KGNwdV9zaWJsaW5nX21hcCwg
Y3B1KSkNCj4gPg0KPiANCg0KVGhhbmtzDQpCYXJyeQ0K
