Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D013A672A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhFNMyb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 08:54:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4063 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhFNMyA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 08:54:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3WRj33K0zXfZT;
        Mon, 14 Jun 2021 20:46:57 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:51:56 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:51:55 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 14 Jun 2021 13:51:52 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSCB2NSA1LzhdIGlvbW11L2FybS1zbW11LXYzOiBBZGQgYnlw?=
 =?utf-8?B?YXNzIGZsYWcgdG/CoGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoKQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIIHY1IDUvOF0gaW9tbXUvYXJtLXNtbXUtdjM6IEFkZCBieXBhc3Mg?=
 =?utf-8?B?ZmxhZyB0b8KgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudCgp?=
Thread-Index: AQHXUIx/cOwHmW58uUq136QHDvp3LasTXKyAgAA53IA=
Date:   Mon, 14 Jun 2021 12:51:52 +0000
Message-ID: <af362953f07a4236b999b8cdb1eca761@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
 <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
In-Reply-To: <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.26.251]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDE0IEp1bmUgMjAyMSAxMToyMw0K
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3JnOyB3YW5naHVpcWlhbmcgPHdhbmdodWlx
aWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuDQo+IChIYW5qdW4gR3VvKSA8Z3VvaGFuanVuQGh1
YXdlaS5jb20+OyBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsNCj4gU2FtaS5NdWphd2FyQGFybS5jb207
IGpvbkBzb2xpZC1ydW4uY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IHlhbmd5aWNvbmcg
PHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzhdIGlv
bW11L2FybS1zbW11LXYzOiBBZGQgYnlwYXNzIGZsYWcNCj4gdG/CoGFybV9zbW11X3dyaXRlX3N0
cnRhYl9lbnQoKQ0KPiANCj4gT24gMjAyMS0wNS0yNCAxMjowMiwgU2hhbWVlciBLb2xvdGh1bSB3
cm90ZToNCj4gPiBCeSBkZWZhdWx0LMKgZGlzYWJsZV9ieXBhc3MgaXMgc2V0IGFuZCBhbnkgZGV2
IHdpdGhvdXQgYW4gaW9tbXUgZG9tYWluDQo+ID4gaW5zdGFsbHMgU1RFIHdpdGggQ0ZHX0FCT1JU
IGR1cmluZ8KgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpLg0KPiBJbnRyb2R1Y2UNCj4gPiBh
ICJieXBhc3MiIGZsYWcgdG/CoGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoKSBzbyB0aGF0IHdl
IGNhbiBmb3JjZSBpdCB0bw0KPiA+IGluc3RhbGzCoENGR19CWVBBU1MgU1RFIGZvciBzcGVjaWZp
YyBTSURzLiBUaGlzIHdpbGwgYmXCoHVzZWZ1bMKgaW4gZm9sbG93DQo+ID4gdXAgcGF0Y2ggdG8g
aW5zdGFsbCBieXBhc3MgZm9yIElPUlQgUk1SIFNJRHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5jIHwgOCArKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5jDQo+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYw0KPiA+IGluZGV4IDc1NGJhZDYwOTJjMS4uZjkxOTViNzQwZjQ4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My5jDQo+ID4gQEAgLTExNzQsNyArMTE3NCw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3N5bmNf
c3RlX2Zvcl9zaWQoc3RydWN0DQo+IGFybV9zbW11X2RldmljZSAqc21tdSwgdTMyIHNpZCkNCj4g
PiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChz
dHJ1Y3QgYXJtX3NtbXVfbWFzdGVyDQo+ICptYXN0ZXIsIHUzMiBzaWQsDQo+ID4gLQkJCQkgICAg
ICBfX2xlNjQgKmRzdCkNCj4gPiArCQkJCSAgICAgIF9fbGU2NCAqZHN0LCBib29sIGJ5cGFzcykN
Cj4gPiAgIHsNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIFRoaXMgaXMgaGlkZW91c2x5IGNvbXBsaWNh
dGVkLCBidXQgd2Ugb25seSByZWFsbHkgY2FyZSBhYm91dA0KPiA+IEBAIC0xMjQ1LDcgKzEyNDUs
NyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdA0KPiBhcm1f
c21tdV9tYXN0ZXIgKm1hc3RlciwgdTMyIHNpZCwNCj4gPg0KPiA+ICAgCS8qIEJ5cGFzcy9mYXVs
dCAqLw0KPiA+ICAgCWlmICghc21tdV9kb21haW4gfHwgIShzMV9jZmcgfHwgczJfY2ZnKSkgew0K
PiA+IC0JCWlmICghc21tdV9kb21haW4gJiYgZGlzYWJsZV9ieXBhc3MpDQo+ID4gKwkJaWYgKCFz
bW11X2RvbWFpbiAmJiBkaXNhYmxlX2J5cGFzcyAmJiAhYnlwYXNzKQ0KPiANCj4gVW1tLi4uDQo+
IA0KPiA+ICAgCQkJdmFsIHw9IEZJRUxEX1BSRVAoU1RSVEFCX1NURV8wX0NGRywNCj4gU1RSVEFC
X1NURV8wX0NGR19BQk9SVCk7DQo+ID4gICAJCWVsc2UNCj4gPiAgIAkJCXZhbCB8PSBGSUVMRF9Q
UkVQKFNUUlRBQl9TVEVfMF9DRkcsDQo+IFNUUlRBQl9TVEVfMF9DRkdfQllQQVNTKTsNCj4gPiBA
QCAtMTMyMCw3ICsxMzIwLDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3Rl
cyhfX2xlNjQNCj4gKnN0cnRhYiwgdW5zaWduZWQgaW50IG5lbnQpDQo+ID4gICAJdW5zaWduZWQg
aW50IGk7DQo+ID4NCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgbmVudDsgKytpKSB7DQo+ID4gLQkJ
YXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChOVUxMLCAtMSwgc3RydGFiKTsNCj4gPiArCQlhcm1f
c21tdV93cml0ZV9zdHJ0YWJfZW50KE5VTEwsIC0xLCBzdHJ0YWIsIGZhbHNlKTsNCj4gDQo+IC4u
LmFuZCBpbiBwYXJ0aWN1bGFyLCBhbiBvcGVyYXRpb24gbmFtZWQgImluaXRfYnlwYXNzX3N0ZXMi
IHBhc3NpbmcNCj4gYnlwYXNzPWZhbHNlIGlzIGp1c3QgYnJlYWtpbmcgbXkgYnJhaW4uIENhbiB3
ZSBwdWxsIHRoZSBsb2dpYyBmb3INCj4gZGVmYXVsdCBieXBhc3MvZmF1bHQgb3V0IHRvIGhlcmUg
YXMgcGFydCBvZiB0aGUgcmVmYWN0b3Jpbmcgc28gdGhhdCBpdA0KPiBhY3R1YWxseSBtYWtlcyBz
ZW5zZT8NCg0KQWdyZWUsIGl0IGlzIGNvbmZ1c2luZy4gV2lsbCBhZGQgdGhlIGRlZmF1bHQgYnlw
YXNzL2ZhdWx0IGxvZ2ljIGhlcmUuDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCj4gUm9iaW4u
DQo+IA0KPiA+ICAgCQlzdHJ0YWIgKz0gU1RSVEFCX1NURV9EV09SRFM7DQo+ID4gICAJfQ0KPiA+
ICAgfQ0KPiA+IEBAIC0yMDk3LDcgKzIwOTcsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9pbnN0
YWxsX3N0ZV9mb3JfZGV2KHN0cnVjdA0KPiBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlcikNCj4gPiAg
IAkJaWYgKGogPCBpKQ0KPiA+ICAgCQkJY29udGludWU7DQo+ID4NCj4gPiAtCQlhcm1fc21tdV93
cml0ZV9zdHJ0YWJfZW50KG1hc3Rlciwgc2lkLCBzdGVwKTsNCj4gPiArCQlhcm1fc21tdV93cml0
ZV9zdHJ0YWJfZW50KG1hc3Rlciwgc2lkLCBzdGVwLCBmYWxzZSk7DQo+ID4gICAJfQ0KPiA+ICAg
fQ0KPiA+DQo+ID4NCg==
