Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE7302449
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbhAYL3l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 06:29:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2404 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbhAYLJP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 06:09:15 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPRPn6jP1z67gYX;
        Mon, 25 Jan 2021 18:46:53 +0800 (CST)
Received: from lhreml714-chm.china.huawei.com (10.201.108.65) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 11:50:10 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 10:50:09 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 25 Jan 2021 18:50:07 +0800
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
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
Thread-Topic: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters
 and add cluster scheduler
Thread-Index: AQHW5/wlPZ7BCMS2PUiSVVUiYd0GPqojTioAgBTsp/A=
Date:   Mon, 25 Jan 2021 10:50:06 +0000
Message-ID: <076088f4daf64727b1587b162eb08dda@hisilicon.com>
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
x-originating-ip: [10.126.202.218]
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
cmVudGx5DQo+IGFsbCB3YWtldXBzIGFyZSAobGxjLSlwYWNrZWQuDQoNClNvcnJ5IGZvciBsYXRl
IHJlc3BvbnNlLiBJIHdhcyBzdHJ1Z2dsaW5nIHdpdGggc29tZSBvdGhlciB0b3BvbG9neQ0KaXNz
dWVzIHJlY2VudGx5Lg0KDQpGb3IgImFsbCB3YWtldXBzIGFyZSAobGxjLSlwYWNrZWQiLA0KaXQg
c2VlbXMgeW91IG1lYW4gY3VycmVudCB3YW50X2FmZmluZSBpcyBvbmx5IGFmZmVjdGluZyB0aGUg
bmV3X2NwdSwNCmFuZCBmb3Igd2FrZS11cCBwYXRoLCB3ZSB3aWxsIGFsd2F5cyBnbyB0byBzZWxl
Y3RfaWRsZV9zaWJsaW5nKCkgcmF0aGVyDQp0aGFuIGZpbmRfaWRsZXN0X2NwdSgpIHNpbmNlIG5v
Ym9keSBzZXRzIFNEX1dBS0VfQkFMQU5DRSBpbiBhbnkNCnNjaGVkX2RvbWFpbiA/DQoNCj4gDQo+
ICBzZWxlY3RfdGFza19ycV9mYWlyKCkNCj4gDQo+ICAgIGZvcl9lYWNoX2RvbWFpbihjcHUsIHRt
cCkNCj4gDQo+ICAgICAgaWYgKHRtcC0+ZmxhZ3MgJiBzZF9mbGFnKQ0KPiAgICAgICAgc2QgPSB0
bXA7DQo+IA0KPiANCj4gSW4gY2FzZSB3ZSB3b3VsZCBsaWtlIHRvIGZ1cnRoZXIgZGlzdGluZ3Vp
c2ggYmV0d2VlbiBsbGMtcGFja2luZyBhbmQNCj4gZXZlbiBuYXJyb3dlciAoY2x1c3RlciBvciBN
Qy1MMiktcGFja2luZywgd2Ugd291bGQgaW50cm9kdWNlIGEgMi4gbGV2ZWwNCj4gcGFja2luZyB2
cy4gc3ByZWFkaW5nIGhldXJpc3RpYyBmdXJ0aGVyIGRvd24gaW4gc2lzKCkuDQoNCkkgZGlkbid0
IGdldCB5b3VyIHBvaW50IG9uICIyIGxldmVsIHBhY2tpbmciLiBXb3VsZCB5b3UgbGlrZQ0KdG8g
ZGVzY3JpYmUgbW9yZT8gSXQgc2VlbXMgeW91IG1lYW4gd2UgbmVlZCB0byBoYXZlIHNlcGFyYXRl
DQpjYWxjdWxhdGlvbiBmb3IgYXZnX3NjYW5fY29zdCBhbmQgc2NoZWRfZmVhdChTSVNfKSBmb3Ig
Y2x1c3Rlcg0KKG9yIE1DLUwyKSBzaW5jZSBjbHVzdGVyIGFuZCBsbGMgYXJlIG5vdCBpbiB0aGUg
c2FtZSBsZXZlbA0KcGh5c2ljYWxseT8NCg0KPiANCj4gSU1ITywgQmFycnkncyBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIGRvZXNuJ3QgZG8gdGhpcyByaWdodCBub3cuIEluc3RlYWQNCj4gaGUncyB0
cnlpbmcgdG8gcGFjayBvbiBjbHVzdGVyIGZpcnN0IGFuZCBpZiBub3Qgc3VjY2Vzc2Z1bCBsb29r
IGZ1cnRoZXINCj4gYW1vbmcgdGhlIHJlbWFpbmluZyBsbGMgQ1BVcyBmb3IgYW4gaWRsZSBDUFUu
DQoNClllcy4gVGhhdCBpcyBleGFjdGx5IHdoYXQgdGhlIGN1cnJlbnQgcGF0Y2ggaXMgZG9pbmcu
DQoNClRoYW5rcw0KQmFycnkNCg==
