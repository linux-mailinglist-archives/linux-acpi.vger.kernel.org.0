Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A458428676
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 07:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJKFxQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 01:53:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24232 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhJKFxQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Oct 2021 01:53:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSSYs6qM1z8tXc;
        Mon, 11 Oct 2021 13:50:09 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:51:14 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:51:12 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 06:51:11 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
Thread-Topic: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
Thread-Index: AQHXidEodx2BBVDhGUqCqzqCM6RTq6vJZXAAgAROiyA=
Date:   Mon, 11 Oct 2021 05:51:11 +0000
Message-ID: <183c95d412df42c9b9a1ef6123832916@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
 <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
In-Reply-To: <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDA4IE9jdG9iZXIgMjAyMSAxNDow
NA0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3JnOyB3aWxsQGtlcm5lbC5vcmc7IHdh
bmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBHdW9oYW5qdW4gKEhhbmp1
biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOyBT
YW1pLk11amF3YXJAYXJtLmNvbTsNCj4gam9uQHNvbGlkLXJ1bi5jb207IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgeWFuZ3lpY29uZw0KPiA8eWFuZ3lpY29uZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY3IDMvOV0gaW9tbXUvZG1hOiBJbnRyb2R1Y2UgZ2VuZXJpYyBoZWxwZXIg
dG8gcmV0cmlldmUNCj4gUk1SIGluZm8NCj4gDQo+IE9uIDIwMjEtMDgtMDUgMDk6MDcsIFNoYW1l
ZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gUmVzZXJ2ZWQgTWVtb3J5IFJlZ2lvbnMoUk1SKSBhc3Nv
Y2lhdGVkIHdpdGggYW4gSU9NTVUgY2FuIGJlDQo+ID4gZGVzY3JpYmVkIHRocm91Z2ggQUNQSSBJ
T1JUIHRhYmxlcyBpbiBzeXN0ZW1zIHdpdGggZGV2aWNlcw0KPiA+IHRoYXQgcmVxdWlyZSBhIHVu
aXR5IG1hcHBpbmcgb3IgYnlwYXNzIGZvciB0aG9zZQ0KPiA+IHJlZ2lvbnMuDQo+ID4NCj4gPiBJ
bnRyb2R1Y2UgYSBnZW5lcmljIGludGVyZmFjZSBzbyB0aGF0IElPTU1VIGRyaXZlcnMgY2FuIHJl
dHJpZXZlDQo+ID4gYW5kIHNldCB1cCBuZWNlc3NhcnkgbWFwcGluZ3MuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwg
MjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgvZG1h
LWlvbW11LmggfCAxMyArKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDQyIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYw0KPiA+IGluZGV4IDk4YmE5MjdhZWUxYS4u
MmZhMjQ0NWU5MDcwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMN
Cj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jDQo+ID4gQEAgLTE3NCw2ICsxNzQs
MzUgQEAgdm9pZCBpb21tdV9wdXRfZG1hX2Nvb2tpZShzdHJ1Y3QNCj4gaW9tbXVfZG9tYWluICpk
b21haW4pDQo+ID4gICB9DQo+ID4gICBFWFBPUlRfU1lNQk9MKGlvbW11X3B1dF9kbWFfY29va2ll
KTsNCj4gPg0KPiA+ICsvKioNCj4gPiArICoNCj4gPiArICogaW9tbXVfZG1hX2dldF9ybXJzIC0g
UmV0cmlldmUgUmVzZXJ2ZWQgTWVtb3J5IFJlZ2lvbnMoUk1ScykNCj4gYXNzb2NpYXRlZA0KPiA+
ICsgKiAgICAgICAgICAgICAgICAgICAgICB3aXRoIGEgZ2l2ZW4gSU9NTVUNCj4gPiArICogQGlv
bW11X2Z3bm9kZTogZndub2RlIGFzc29jaWF0ZWQgd2l0aCBJT01NVQ0KPiA+ICsgKiBAbGlzdDog
Uk1SIGxpc3QgdG8gYmUgcG9wdWxhdGVkDQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICtpbnQgaW9t
bXVfZG1hX2dldF9ybXJzKHN0cnVjdCBmd25vZGVfaGFuZGxlICppb21tdV9md25vZGUsDQo+ID4g
KwkJICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpDQo+ID4gK3sNCj4gPiArCXJldHVybiAt
RUlOVkFMOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woaW9tbXVfZG1hX2dldF9ybXJzKTsN
Cj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKg0KPiA+ICsgKiBpb21tdV9kbWFfcHV0X3JtcnMgLSBS
ZWxlYXNlIFJlc2VydmVkIE1lbW9yeSBSZWdpb25zKFJNUnMpDQo+IGFzc29jaWF0ZWQNCj4gPiAr
ICogICAgICAgICAgICAgICAgICAgICAgd2l0aCBhIGdpdmVuIElPTU1VDQo+ID4gKyAqIEBpb21t
dV9md25vZGU6IGZ3bm9kZSBhc3NvY2lhdGVkIHdpdGggSU9NTVUNCj4gPiArICogQGxpc3Q6IFJN
UiBsaXN0DQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICt2b2lkIGlvbW11X2RtYV9wdXRfcm1ycyhz
dHJ1Y3QgZndub2RlX2hhbmRsZSAqaW9tbXVfZndub2RlLA0KPiA+ICsJCQlzdHJ1Y3QgbGlzdF9o
ZWFkICpsaXN0KQ0KPiA+ICt7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChpb21tdV9kbWFf
cHV0X3JtcnMpOw0KPiANCj4gVW5sZXNzIHRoZXJlJ3Mgc29tZXRoaW5nIHNwZWNpYWwgeW91IGV4
cGVjdCB0byBuZWVkIHRvIGRvIGhlcmUsIGNhbiB3ZQ0KPiBqdXN0IHVwaG9sZCB0aGUgcHJldmFp
bGluZyBleHBlY3RhdGlvbiB0aGF0IHJlc3ZfcmVnaW9ucyBhcmUga21hbGxvYygpZWQNCj4gYW5k
IGNhbiBiZSBmcmVlZCBkaXJlY3RseSBieSB0aGUgZ2VuZXJpYyBmdW5jdGlvbj8NCg0KUmlnaHQu
IEkgdGhpbmsgd2UgY2FuIGRvIHRoYXQuIA0KDQo+IA0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAg
ICogaW9tbXVfZG1hX2dldF9yZXN2X3JlZ2lvbnMgLSBSZXNlcnZlZCByZWdpb24gZHJpdmVyIGhl
bHBlcg0KPiA+ICAgICogQGRldjogRGV2aWNlIGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygp
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWlvbW11LmggYi9pbmNsdWRlL2xp
bnV4L2RtYS1pb21tdS5oDQo+ID4gaW5kZXggNzU4Y2E0Njk0MjU3Li4zYjdiMmQwOTZjNmUgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtaW9tbXUuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvZG1hLWlvbW11LmgNCj4gPiBAQCAtNDIsMTIgKzQyLDE2IEBAIHZvaWQgaW9tbXVf
ZG1hX2ZyZWVfY3B1X2NhY2hlZF9pb3Zhcyh1bnNpZ25lZA0KPiBpbnQgY3B1LA0KPiA+DQo+ID4g
ICBleHRlcm4gYm9vbCBpb21tdV9kbWFfZm9yY2VkYWM7DQo+ID4NCj4gPiAraW50IGlvbW11X2Rt
YV9nZXRfcm1ycyhzdHJ1Y3QgZndub2RlX2hhbmRsZSAqaW9tbXUsIHN0cnVjdCBsaXN0X2hlYWQN
Cj4gKmxpc3QpOw0KPiA+ICt2b2lkIGlvbW11X2RtYV9wdXRfcm1ycyhzdHJ1Y3QgZndub2RlX2hh
bmRsZSAqaW9tbXUsIHN0cnVjdCBsaXN0X2hlYWQNCj4gKmxpc3QpOw0KPiA+ICsNCj4gPiAgICNl
bHNlIC8qIENPTkZJR19JT01NVV9ETUEgKi8NCj4gPg0KPiA+ICAgc3RydWN0IGlvbW11X2RvbWFp
bjsNCj4gPiAgIHN0cnVjdCBtc2lfZGVzYzsNCj4gPiAgIHN0cnVjdCBtc2lfbXNnOw0KPiA+ICAg
c3RydWN0IGRldmljZTsNCj4gPiArc3RydWN0IGZ3bm9kZV9oYW5kbGU7DQo+ID4NCj4gPiAgIHN0
YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwg
dTY0DQo+IGRtYV9iYXNlLA0KPiA+ICAgCQkJCSAgICAgICB1NjQgZG1hX2xpbWl0KQ0KPiA+IEBA
IC04Myw1ICs4NywxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gaW9tbXVfZG1hX2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZQ0KPiA+ICAgew0KPiA+
ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgaW9tbXVfZG1hX2dldF9ybXJzKHN0cnVjdCBmd25v
ZGVfaGFuZGxlICppb21tdSwgc3RydWN0DQo+IGxpc3RfaGVhZCAqbGlzdCkNCj4gPiArew0KPiA+
ICsJcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBIbW0sIGlmIHRoaXMgbmVlZHMgdG8gYmUgc3R1YmJl
ZCBhdCBhbGwgdGhlbiByZXR1cm5pbmcgYW4gZXJyb3Igc2VlbXMNCj4gbGlrZSBwcm9iYWJseSB0
aGUgd3JvbmcgdGhpbmcgdG8gZG8uIEkgZ3Vlc3MgaXQncyBmb3IgMzItYml0IGJ1aWxkcyBvZg0K
PiBhcm0tc21tdT8gSXQgaXMgbm90IGFuIGVycm9yIGlmIHRoZSBmaXJtd2FyZSBkZXNjcmliZXMg
bm8gUk1ScyBiZWNhdXNlDQo+IHRoZXJlIGFyZSBubyBSTVJzLCBzbyBpdCBoYXJkbHkgZGVzZXJ2
ZXMgdG8gYmUgYW4gZXJyb3IgaWYgdGhlcmUgYXJlIG5vDQo+IFJNUnMgc2ltcGx5IGJlY2F1c2Ug
dGhlIGZpcm13YXJlIGlzbid0IEFDUEkuDQoNClllcywgZGVmaW5pdGVseSBub3QgYW4gZXJyb3Ig
cmV0dXJuLiBJIHdpbGwgY2hhbmdlIHRoYXQuDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCj4g
Um9iaW4uDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBpb21tdV9kbWFfcHV0
X3JtcnMoc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmlvbW11LCBzdHJ1Y3QNCj4gbGlzdF9oZWFkICps
aXN0KQ0KPiA+ICt7DQo+ID4gK30NCj4gPiArDQo+ID4gICAjZW5kaWYJLyogQ09ORklHX0lPTU1V
X0RNQSAqLw0KPiA+ICAgI2VuZGlmCS8qIF9fRE1BX0lPTU1VX0ggKi8NCj4gPg0K
