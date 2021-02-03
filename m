Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5230D8B9
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhBCLdV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 06:33:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2490 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhBCLdU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 06:33:20 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVzwK5ZvJz67kYJ;
        Wed,  3 Feb 2021 19:29:05 +0800 (CST)
Received: from lhreml719-chm.china.huawei.com (10.201.108.70) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 12:32:35 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 11:32:34 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 3 Feb 2021 19:32:32 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
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
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
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
Thread-Index: AQHW5AbtPZ7BCMS2PUiSVVUiYd0GPqocSCyAgCouMeA=
Date:   Wed, 3 Feb 2021 11:32:32 +0000
Message-ID: <38ce39d2d4754d76934bb07370eff48b@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
In-Reply-To: <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.87]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltIENoZW4gW21haWx0
bzp0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDgs
IDIwMjEgMTI6MTcgUE0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFv
Lmh1YUBoaXNpbGljb24uY29tPjsNCj4gdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207IGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7DQo+IHJqd0Byand5c29ja2kubmV0
OyB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsNCj4gbWluZ29AcmVkaGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGp1
cmkubGVsbGlAcmVkaGF0LmNvbTsNCj4gZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0
QGdvb2RtaXMub3JnOyBic2VnYWxsQGdvb2dsZS5jb207DQo+IG1nb3JtYW5Ac3VzZS5kZTsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHN1ZGVlcC5ob2xsYUBhcm0uY29tOw0KPiBhdWJyZXkubGlAbGlu
dXguaW50ZWwuY29tDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnOyBsaW51eGFybUBvcGVuZXVsZXIub3JnOyB4dXdlaSAoTykNCj4gPHh1d2VpNUBodWF3ZWku
Y29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IHRpYW50YW8gKEgp
DQo+IDx0aWFudGFvNkBoaXNpbGljb24uY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2
MyAwLzJdIHNjaGVkdWxlcjogZXhwb3NlIHRoZSB0b3BvbG9neSBvZiBjbHVzdGVycyBhbmQNCj4g
YWRkIGNsdXN0ZXIgc2NoZWR1bGVyDQo+IA0KPiANCj4gDQo+IE9uIDEvNi8yMSAxMjozMCBBTSwg
QmFycnkgU29uZyB3cm90ZToNCj4gPiBBUk02NCBzZXJ2ZXIgY2hpcCBLdW5wZW5nIDkyMCBoYXMg
NiBjbHVzdGVycyBpbiBlYWNoIE5VTUEgbm9kZSwgYW5kIGVhY2gNCj4gPiBjbHVzdGVyIGhhcyA0
IGNwdXMuIEFsbCBjbHVzdGVycyBzaGFyZSBMMyBjYWNoZSBkYXRhIHdoaWxlIGVhY2ggY2x1c3Rl
cg0KPiA+IGhhcyBsb2NhbCBMMyB0YWcuIE9uIHRoZSBvdGhlciBoYW5kLCBlYWNoIGNsdXN0ZXIg
d2lsbCBzaGFyZSBzb21lDQo+ID4gaW50ZXJuYWwgc3lzdGVtIGJ1cy4gVGhpcyBtZWFucyBjYWNo
ZSBpcyBtdWNoIG1vcmUgYWZmaW5lIGluc2lkZSBvbmUgY2x1c3Rlcg0KPiA+IHRoYW4gYWNyb3Nz
IGNsdXN0ZXJzLg0KPiA+DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0rDQo+ID4gICAgIHwgICst
LS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsgICAgICAgICB8DQo+ID4gICAgIHwgIHwgQ1BVMCB8ICAgIHwgY3B1MSB8ICAgICAgICAgICAg
IHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0t
LS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAgfCAgICAgICAgIHwg
ICAgICAgICB8DQo+ID4gICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICst
LS0tKyAgICBMMyAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0r
ICAgICstLS0tLS0rICAgY2x1c3RlciAgIHwgICAgfCAgICB0YWcgICAgfCAgICAgICAgIHwgICAg
ICAgICB8DQo+ID4gICAgIHwgIHwgQ1BVMiB8ICAgIHwgQ1BVMyB8ICAgICAgICAgICAgIHwgICAg
fCAgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAg
ICstLS0tLS0rICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAg
ICB8DQo+ID4gICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8
DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAgICstLS0t
LS0rICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICB8DQo+
ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0t
LS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAgICstLS0tLS0r
ICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4g
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgfCAgICBMMyAgICAg
fCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAgICstLS0tLS0rICAg
ICAgICAgICAgICstLS0tKyAgICB0YWcgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAg
IHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAgfCAg
ICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAg
ICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICB8DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICBMMyAgICB8DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICBkYXRhICB8DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0t
LS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwg
ICAgICAgICB8DQo+ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwg
ICAgfCAgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0r
ICAgICstLS0tLS0rICAgICAgICAgICAgICstLS0tKyAgICBMMyAgICAgfCAgICAgICAgIHwgICAg
ICAgICB8DQo+ID4gICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
fCAgICB0YWcgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAg
ICstLS0tLS0rICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAgfCAgICAgICAgIHwgICAgICAg
ICB8DQo+ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgKysgICAgKy0t
LS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0rICAgICst
LS0tLS0rICAgICAgICAgICAgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICB8
DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXwgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+
ID4gICAgIHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSsgICAgICAgICB8DQo+ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8
ICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAgICAgIHwgICAgICAgICB8DQo+ID4g
ICAgIHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgfCAgICAgICAgICAg
fCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICstLS0tKyAgICBMMyAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAg
IHwgICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgfCAgICB0YWcgICAgfCAg
ICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAg
ICAgICAgIHwgICAgfCAgICAgICAgICAgfCAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwg
ICstLS0tLS0rICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICAgKy0tLS0tLS0tLS0tKyAgICAg
ICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICB8DQo+ID4gICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0t
LS0rICAgICstLS0tLS0rICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsg
ICAgICAgICB8DQo+ID4gICAgIHwgIHwgICAgICB8ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwg
ICArLS0tLS0tLS0tLS0rICAgICAgICAgIHwgICAgICAgICB8DQo+ID4gICAgIHwgICstLS0tLS0r
ICAgICstLS0tLS0rICAgICAgICAgICAgIHwgICB8ICAgICAgICAgICB8ICAgICAgICAgIHwgICAg
ICAgICB8DQo+ID4NCj4gPg0KPiANCj4gVGhlcmUgaXMgYSBzaW1pbGFyIG5lZWQgZm9yIGNsdXN0
ZXJpbmcgaW4geDg2LiAgU29tZSB4ODYgY29yZXMgY291bGQgc2hhcmUgTDINCj4gY2FjaGVzIHRo
YXQNCj4gaXMgc2ltaWxhciB0byB0aGUgY2x1c3RlciBpbiBLdXBlbmcgOTIwIChlLmcuIG9uIEph
Y29ic3ZpbGxlIHRoZXJlIGFyZSA2IGNsdXN0ZXJzDQo+IG9mIDQgQXRvbSBjb3JlcywgZWFjaCBj
bHVzdGVyIHNoYXJpbmcgYSBzZXBhcmF0ZSBMMiwgYW5kIDI0IGNvcmVzIHNoYXJpbmcgTDMpLg0K
PiBIYXZpbmcgYSBzY2hlZCBkb21haW4gYXQgdGhlIEwyIGNsdXN0ZXIgaGVscHMgc3ByZWFkIGxv
YWQgYW1vbmcNCj4gTDIgZG9tYWlucy4gIFRoaXMgd2lsbCByZWR1Y2UgTDIgY2FjaGUgY29udGVu
dGlvbiBhbmQgaGVscCB3aXRoDQo+IHBlcmZvcm1hbmNlIGZvciBsb3cgdG8gbW9kZXJhdGUgbG9h
ZCBzY2VuYXJpb3MuDQo+IA0KPiBUaGUgY2x1c3RlciBkZXRlY3Rpb24gbWVjaGFuaXNtIHdpbGwg
bmVlZA0KPiB0byBiZSBiYXNlZCBvbiBMMiBjYWNoZSBzaGFyaW5nIGluIHRoaXMgY2FzZS4gIEkg
c3VnZ2VzdCBtYWtpbmcgdGhlDQo+IGNsdXN0ZXIgZGV0ZWN0aW9uIHRvIGJlIENQVSBhcmNoaXRl
Y3R1cmUgZGVwZW5kZW50IHNvIGJvdGggQVJNNjQgYW5kIHg4NiB1c2UNCj4gY2FzZXMNCj4gY2Fu
IGJlIGFjY29tbW9kYXRlZC4NCj4gDQo+IEF0dGFjaGVkIGJlbG93IGFyZSB0d28gUkZDIHBhdGNo
ZXMgZm9yIGNyZWF0aW5nIHg4NiBMMg0KPiBjYWNoZSBzY2hlZCBkb21haW4sIHNhbnMgdGhlIGlk
bGUgY3B1IHNlbGVjdGlvbiBvbiB3YWtlIHVwIGNvZGUuICBJdCBpcw0KPiBzaW1pbGFyIGVub3Vn
aCBpbiBjb25jZXB0IHRvIEJhcnJ5J3MgcGF0Y2ggdGhhdCB3ZSBzaG91bGQgaGF2ZSBhDQo+IHNp
bmdsZSBwYXRjaHNldCB0aGF0IGFjY29tbW9kYXRlcyBib3RoIHVzZSBjYXNlcy4NCg0KSGkgVGlt
LCBBZ3JlZWQgb24gdGhpcy4NCmhvcGVmdWxseSB0aGUgUkZDIHY0IEkgYW0gcHJlcGFyaW5nIHdp
bGwgY292ZXIgeW91ciBjYXNlLg0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiBUaW0NCg0KVGhhbmtz
DQpCYXJyeQ0KDQo=
