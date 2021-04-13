Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0535DCAD
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhDMKqK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 06:46:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2841 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbhDMKqJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 06:46:09 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKMXC44g5z688L2;
        Tue, 13 Apr 2021 18:38:35 +0800 (CST)
Received: from lhreml719-chm.china.huawei.com (10.201.108.70) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 12:45:48 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 11:45:46 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 13 Apr 2021 18:45:44 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "Guodong Xu" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
Thread-Topic: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters
 and add cluster scheduler
Thread-Index: AQHW5/wlPZ7BCMS2PUiSVVUiYd0GPqojTioAgI99GlA=
Date:   Tue, 13 Apr 2021 10:45:44 +0000
Message-ID: <9201b56a29dd4dacb7d9fcbf307ca5ff@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
 <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
 <20210111092811.GB47324@e123083-lin>
 <4fdc781e-7385-2ae6-d9c9-3ec165f473c4@arm.com>
In-Reply-To: <4fdc781e-7385-2ae6-d9c9-3ec165f473c4@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBK
YW51YXJ5IDEzLCAyMDIxIDEyOjAwIEFNDQo+IFRvOiBNb3J0ZW4gUmFzbXVzc2VuIDxtb3J0ZW4u
cmFzbXVzc2VuQGFybS5jb20+OyBUaW0gQ2hlbg0KPiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5j
b20+DQo+IENjOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxp
Y29uLmNvbT47DQo+IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tOyBjYXRhbGluLm1hcmluYXNA
YXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOw0KPiByandAcmp3eXNvY2tpLm5ldDsgdmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc7IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47
DQo+IG1pbmdvQHJlZGhhdC5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyBqdXJpLmxlbGxpQHJl
ZGhhdC5jb207DQo+IHJvc3RlZHRAZ29vZG1pcy5vcmc7IGJzZWdhbGxAZ29vZ2xlLmNvbTsgbWdv
cm1hbkBzdXNlLmRlOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc3VkZWVwLmhvbGxhQGFybS5j
b207IGF1YnJleS5saUBsaW51eC5pbnRlbC5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4YXJtQG9wZW5ldWxlci5vcmc7IHh1d2VpIChPKQ0KPiA8
eHV3ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29t
PjsgdGlhbnRhbyAoSCkNCj4gPHRpYW50YW82QGhpc2lsaWNvbi5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUkZDIFBBVENIIHYzIDAvMl0gc2NoZWR1bGVyOiBleHBvc2UgdGhlIHRvcG9sb2d5IG9mIGNs
dXN0ZXJzIGFuZA0KPiBhZGQgY2x1c3RlciBzY2hlZHVsZXINCj4gDQo+IE9uIDExLzAxLzIwMjEg
MTA6MjgsIE1vcnRlbiBSYXNtdXNzZW4gd3JvdGU6DQo+ID4gT24gRnJpLCBKYW4gMDgsIDIwMjEg
YXQgMTI6MjI6NDFQTSAtMDgwMCwgVGltIENoZW4gd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9u
IDEvOC8yMSA3OjEyIEFNLCBNb3J0ZW4gUmFzbXVzc2VuIHdyb3RlOg0KPiA+Pj4gT24gVGh1LCBK
YW4gMDcsIDIwMjEgYXQgMDM6MTY6NDdQTSAtMDgwMCwgVGltIENoZW4gd3JvdGU6DQo+ID4+Pj4g
T24gMS82LzIxIDEyOjMwIEFNLCBCYXJyeSBTb25nIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4+IEkgdGhpbmsgaXQgaXMgZ29pbmcgdG8gZGVwZW5kIG9uIHRoZSB3b3JrbG9hZC4gIElmIHRo
ZXJlIGFyZSBkZXBlbmRlbnQNCj4gPj4gdGFza3MgdGhhdCBjb21tdW5pY2F0ZSB3aXRoIG9uZSBh
bm90aGVyLCBwdXR0aW5nIHRoZW0gdG9nZXRoZXINCj4gPj4gaW4gdGhlIHNhbWUgY2x1c3RlciB3
aWxsIGJlIHRoZSByaWdodCB0aGluZyB0byBkbyB0byByZWR1Y2UgY29tbXVuaWNhdGlvbg0KPiA+
PiBjb3N0cy4gIE9uIHRoZSBvdGhlciBoYW5kLCBpZiB0aGUgdGFza3MgYXJlIGluZGVwZW5kZW50
LCBwdXR0aW5nIHRoZW0gdG9nZXRoZXINCj4gb24gdGhlIHNhbWUgY2x1c3Rlcg0KPiA+PiB3aWxs
IGluY3JlYXNlIHJlc291cmNlIGNvbnRlbnRpb24gYW5kIHNwcmVhZGluZyB0aGVtIG91dCB3aWxs
IGJlIGJldHRlci4NCj4gPg0KPiA+IEFncmVlLiBUaGF0IGlzIGV4YWN0bHkgd2hlcmUgSSdtIGNv
bWluZyBmcm9tLiBUaGlzIGlzIGFsbCBhYm91dCB0aGUgdGFzaw0KPiA+IHBsYWNlbWVudCBwb2xp
Y3kuIFdlIGdlbmVyYWxseSB0ZW5kIHRvIHNwcmVhZCB0YXNrcyB0byBhdm9pZCByZXNvdXJjZQ0K
PiA+IGNvbnRlbnRpb24sIFNNVCBhbmQgY2FjaGVzLCB3aGljaCBzZWVtcyB0byBiZSB3aGF0IHlv
dSBhcmUgcHJvcG9zaW5nIHRvDQo+ID4gZXh0ZW5kLiBJIHRoaW5rIHRoYXQgbWFrZXMgc2Vuc2Ug
Z2l2ZW4gaXQgY2FuIHByb2R1Y2Ugc2lnbmlmaWNhbnQNCj4gPiBiZW5lZml0cy4NCj4gPg0KPiA+
Pg0KPiA+PiBBbnkgdGhvdWdodHMgb24gd2hhdCBpcyB0aGUgcmlnaHQgY2x1c3RlcmluZyAidGFn
IiB0byB1c2UgdG8gY2x1bXANCj4gPj4gcmVsYXRlZCB0YXNrcyB0b2dldGhlcj8NCj4gPj4gQ2dy
b3VwPyBQaWQ/IFRhc2tzIHdpdGggc2FtZSBtbT8NCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBpcyB0
aGUgcmVhbCBxdWVzdGlvbi4gSSB0aGluayB0aGUgY2xvc2VzdCB0aGluZyB3ZSBoYXZlIGF0DQo+
ID4gdGhlIG1vbWVudCBpcyB0aGUgd2FrZWUvd2FrZXIgZmxpcCBoZXVyaXN0aWMuIFRoaXMgc2Vl
bXMgdG8gYmUgcmVsYXRlZC4NCj4gPiBQZXJoYXBzIHRoZSB3YWtlX2FmZmluZSB0cmlja3MgY2Fu
IHNlcnZlIGFzIHN0YXJ0aW5nIHBvaW50Pw0KPiANCj4gd2FrZV93aWRlKCkgc3dpdGNoZXMgYmV0
d2VlbiBwYWNraW5nIChzZWxlY3RfaWRsZV9zaWJsaW5nKCksIGxsY19zaXplDQo+IENQVXMpIGFu
ZCBzcHJlYWRpbmcgKGZpbmRfaWRsZXN0X2NwdSgpLCBhbGwgQ1BVcykuDQo+IA0KPiBBRkFJQ1Ms
IHNpbmNlIG5vbmUgb2YgdGhlIHNjaGVkIGRvbWFpbnMgc2V0IFNEX0JBTEFOQ0VfV0FLRSwgY3Vy
cmVudGx5DQo+IGFsbCB3YWtldXBzIGFyZSAobGxjLSlwYWNrZWQuDQo+IA0KPiAgc2VsZWN0X3Rh
c2tfcnFfZmFpcigpDQo+IA0KPiAgICBmb3JfZWFjaF9kb21haW4oY3B1LCB0bXApDQo+IA0KPiAg
ICAgIGlmICh0bXAtPmZsYWdzICYgc2RfZmxhZykNCj4gICAgICAgIHNkID0gdG1wOw0KPiANCj4g
DQo+IEluIGNhc2Ugd2Ugd291bGQgbGlrZSB0byBmdXJ0aGVyIGRpc3Rpbmd1aXNoIGJldHdlZW4g
bGxjLXBhY2tpbmcgYW5kDQo+IGV2ZW4gbmFycm93ZXIgKGNsdXN0ZXIgb3IgTUMtTDIpLXBhY2tp
bmcsIHdlIHdvdWxkIGludHJvZHVjZSBhIDIuIGxldmVsDQo+IHBhY2tpbmcgdnMuIHNwcmVhZGlu
ZyBoZXVyaXN0aWMgZnVydGhlciBkb3duIGluIHNpcygpLg0KPiANCj4gSU1ITywgQmFycnkncyBj
dXJyZW50IGltcGxlbWVudGF0aW9uIGRvZXNuJ3QgZG8gdGhpcyByaWdodCBub3cuIEluc3RlYWQN
Cj4gaGUncyB0cnlpbmcgdG8gcGFjayBvbiBjbHVzdGVyIGZpcnN0IGFuZCBpZiBub3Qgc3VjY2Vz
c2Z1bCBsb29rIGZ1cnRoZXINCj4gYW1vbmcgdGhlIHJlbWFpbmluZyBsbGMgQ1BVcyBmb3IgYW4g
aWRsZSBDUFUuDQoNClJpZ2h0IG5vdyBpbiB0aGUgbWFpbiBjYXNlcyBvZiB1c2luZyB3YWtlX2Fm
ZmluZSB0byBhY2hpZXZlDQpiZXR0ZXIgcGVyZm9ybWFuY2UsIHByb2Nlc3NlcyBhcmUgYWN0dWFs
bHkgYm91bmQgd2l0aGluIG9uZQ0KbnVtYSB3aGljaCBpcyBhbHNvIGEgTExDIGluIGt1bnBlbmc5
MjAuIA0KDQpQcm9iYWJseSBMTEM9TlVNQSBpcyBhbHNvIHRydWUgZm9yIFg4NiBKYWNvYnN2aWxs
ZSwgVGltPw0KDQpTbyBvbmUgcG9zc2libGUgd2F5IHRvIHByZXRlbmQgYSAyLWxldmVsIHBhY2tp
bmcgbWlnaHQgYmU6DQppZiB0aGUgYWZmaW5pdHkgY3B1c2V0IG9mIHdha2VyIGFuZCB3YWtlciBh
cmUgYm90aCBzdWJzZXQNCm9mIG9uZSBzYW1lIExMQywgd2UgdG90YWxseSB1c2UgY2x1c3RlciBh
cyB0aGUgZmFjdG9yIHRvDQpkZXRlcm1pbmUgcGFja2luZyBvciBub3QgYW5kIGlnbm9yZSBMTEMu
DQoNCkkgaGF2ZW4ndCByZWFsbHkgZG9uZSB0aGlzLCBidXQgdGhlIGJlbG93IGNvZGUgY2FuIG1h
a2UgdGhlDQpzYW1lIHJlc3VsdCBieSBmb3JjaW5nIGxsY19pZD1jbHVzdGVyX2lkOg0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvdG9wb2xvZ3kuYyBiL2FyY2gvYXJtNjQva2VybmVs
L3RvcG9sb2d5LmMNCmluZGV4IGQ3MmViOGQuLjNkNzgwOTcgMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2tlcm5lbC90b3BvbG9neS5jDQorKysgYi9hcmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5j
DQpAQCAtMTA3LDcgKzEwNyw3IEBAIGludCBfX2luaXQgcGFyc2VfYWNwaV90b3BvbG9neSh2b2lk
KQ0KICAgICAgICAgICAgICAgIGNwdV90b3BvbG9neVtjcHVdLmNsdXN0ZXJfaWQgPSB0b3BvbG9n
eV9pZDsNCiAgICAgICAgICAgICAgICB0b3BvbG9neV9pZCA9IGZpbmRfYWNwaV9jcHVfdG9wb2xv
Z3lfcGFja2FnZShjcHUpOw0KICAgICAgICAgICAgICAgIGNwdV90b3BvbG9neVtjcHVdLnBhY2th
Z2VfaWQgPSB0b3BvbG9neV9pZDsNCi0NCisjaWYgMA0KICAgICAgICAgICAgICAgIGkgPSBhY3Bp
X2ZpbmRfbGFzdF9jYWNoZV9sZXZlbChjcHUpOw0KDQogICAgICAgICAgICAgICAgaWYgKGkgPiAw
KSB7DQpAQCAtMTE5LDggKzExOSwxMSBAQCBpbnQgX19pbml0IHBhcnNlX2FjcGlfdG9wb2xvZ3ko
dm9pZCkNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChjYWNoZV9pZCA+IDApDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90b3BvbG9neVtjcHVdLmxsY19pZCA9IGNhY2hl
X2lkOw0KICAgICAgICAgICAgICAgIH0NCi0gICAgICAgfQ0KKyNlbHNlDQorICAgICAgICAgICAg
ICAgY3B1X3RvcG9sb2d5W2NwdV0ubGxjX2lkID0gY3B1X3RvcG9sb2d5W2NwdV0uY2x1c3Rlcl9p
ZDsNCisjZW5kaWYNCg0KKyAgICAgICB9DQogICAgICAgIHJldHVybiAwOw0KIH0NCiAjZW5kaWYN
Cg0KV2l0aCB0aGlzLCBJIGhhdmUgc2VlbiBzb21lIG1ham9yIGltcHJvdmVtZW50IGluIGhhY2ti
ZW5jaCBlc3BlY2lhbGx5DQpmb3IgbW9ub2dhbW91cyBjb21tdW5pY2F0aW9uIG1vZGVsIChmZHNf
bnVtPTEsIG9uZSBzZW5kZXIgZm9yIG9uZQ0KcmVjZWl2ZXIpOg0KbnVtYWN0bCAtTiAwIGhhY2ti
ZW5jaCAtcCAtVCAtbCAyMDAwMDAgLWYgMSAtZyAkMQ0KDQpJIGhhdmUgdGVzdGVkIC1nKGdyb3Vw
X251bXMpIDYsIDEyLCAxOCwgMjQsIDI4LCAzMiwNCkZvciBlYWNoIGRpZmZlcmVudCBnLCBJIHJh
biAyMCB0aW1lcyBhbmQgZ290IHRoZQ0KYXZlcmFnZSB2YWx1ZS4gVGhlIHJlc3VsdCBpcyBhcyBi
ZWxvdzoNCg0KZz0gICAgNiAgICAgIDEyICAgIDE4ICAgICAgMjQgICAgMjggICAgIDMyDQp3L28g
MS4zMjQzIDEuNjc0MSAxLjc1NjAgMS45MDM2IDIuMDI2MiAyLjE4MjYNCncvICAxLjEzMTQgMS4x
ODY0IDEuNDQ5NCAxLjYxNTkgMS45MDc4IDIuMTI0OQ0KDQpVc2luZyB0b3AgLUggYW5kIGhpdCAi
ZiIgdG8gc2hvdyBjcHUgb2YgZWFjaCB0aHJlYWQsDQpJIGFtIHNlZWluZyB0aGUgdHdvIHRocmVh
ZHMgaW4gb25lIGdyb3VwIGFyZSBsaWtlbHkNCnRvIHJ1biBpbiBhIGNsdXN0ZXIuIFRoYXQncyB3
aHkgdGhlIGhhY2tiZW5jaCBsYXRlbmN5DQppcyBkZWNyZWFzaW5nIG11Y2guDQoNClRoYW5rcw0K
QmFycnkNCg==
