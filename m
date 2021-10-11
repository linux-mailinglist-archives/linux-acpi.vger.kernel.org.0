Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B066B42866D
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 07:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhJKFta (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 01:49:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28912 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhJKFta (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Oct 2021 01:49:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSSPd6HWWzbn0Z;
        Mon, 11 Oct 2021 13:43:01 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:47:28 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:47:26 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 06:47:24 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jon Nettleton <jon@solid-run.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Steven Price" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Topic: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Index: AQHXidEdw4nQ2pDnVEWq+ST9RUOUTKvJV6SAgAE56YCAAyElcA==
Date:   Mon, 11 Oct 2021 05:47:24 +0000
Message-ID: <9df40b8f09f6488382f25f419519a2fa@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
 <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
 <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
In-Reply-To: <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIE5ldHRsZXRvbiBb
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAwOSBPY3RvYmVyIDIwMjEgMDc6NTgN
Cj4gVG86IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+DQo+IENjOiBTaGFtZWVy
YWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Ow0KPiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBBQ1BJIERldmVsIE1hbGluZw0KPiBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IElPTU1VDQo+IDxpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz47IExp
bnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJp
Y2VAYXJtLmNvbT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWku
Y29tPjsgeWFuZ3lpY29uZyA8eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgU2FtaQ0KPiBNdWphd2Fy
IDxTYW1pLk11amF3YXJAYXJtLmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ow0K
PiB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDEvOV0gaW9tbXU6IEludHJvZHVjZSBhIHVuaW9uIHRvIHN0cnVjdA0KPiBpb21t
dV9yZXN2X3JlZ2lvbg0KPiANCj4gT24gRnJpLCBPY3QgOCwgMjAyMSBhdCAyOjE0IFBNIFJvYmlu
IE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAy
MS0wOC0wNSAwOTowNywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiA+IEEgdW5pb24gaXMg
aW50cm9kdWNlZCB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gdG8gaG9sZCBhbnkNCj4gPiA+
IGZpcm13YXJlIHNwZWNpZmljIGRhdGEuIFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gdG8gYWRkIHN1
cHBvcnQgZm9yDQo+ID4gPiBJT1JUIFJNUiByZXNlcnZlIHJlZ2lvbnMgYW5kIHRoZSB1bmlvbiBu
b3cgaG9sZHMgdGhlIFJNUiBzcGVjaWZpYw0KPiA+ID4gaW5mb3JtYXRpb24uDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA+ID4gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBpbmNsdWRlL2xpbnV4
L2lvbW11LmggfCAxMSArKysrKysrKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11
LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmggaW5kZXgNCj4gPiA+IDMyZDQ0ODA1MGJmNy4uYmQw
ZTQ2NDFjNTY5IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+ID4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiA+IEBAIC0xMTQsNiArMTE0LDEzIEBA
IGVudW0gaW9tbXVfcmVzdl90eXBlIHsNCj4gPiA+ICAgICAgIElPTU1VX1JFU1ZfU1dfTVNJLA0K
PiA+ID4gICB9Ow0KPiA+ID4NCj4gPiA+ICtzdHJ1Y3QgaW9tbXVfaW9ydF9ybXJfZGF0YSB7DQo+
ID4gPiArI2RlZmluZSBJT01NVV9STVJfUkVNQVBfUEVSTUlUVEVEICAgICgxIDw8IDApDQo+ID4g
PiArICAgICB1MzIgZmxhZ3M7DQo+ID4gPiArICAgICB1MzIgc2lkOyAgICAgICAgLyogU3RyZWFt
IElkIGFzc29jaWF0ZWQgd2l0aCBSTVIgZW50cnkgKi8NCj4gPiA+ICsgICAgIHZvaWQgKnNtbXU7
ICAgICAvKiBBc3NvY2lhdGVkIElPUlQgU01NVSBub2RlIHBvaW50ZXIgKi8NCj4gPiA+ICt9Ow0K
PiA+DQo+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gZHVwbGljYXRlIGFsbCB0aGlzIGRhdGE/IEFG
QUlDUyB3ZSBjb3VsZCBqdXN0DQo+ID4gc2F2ZSB0aGUgYWNwaV9pb3J0X3JtciBwb2ludGVyIGlu
IHRoZSBpb21tdV9yZXN2X3JlZ2lvbiAod2l0aCBhDQo+ID4gZm9yd2FyZCBkZWNsYXJhdGlvbiBo
ZXJlIGlmIG5lY2Vzc2FyeSkgYW5kIGRlZmVyIHBhcnNpbmcgaXRzIGFjdHVhbA0KPiA+IG1hcHBp
bmdzIHVudGlsIHRoZSBwb2ludCB3aGVyZSB3ZSBjYW4gZGlyZWN0bHkgY29uc3VtZSB0aGUgcmVz
dWx0cy4NCj4gDQo+IEZyb20gZWFybGllciBkaXNjdXNzaW9ucyBvbiB0aGlzIHBhdGNoc2V0LCB0
aGUgb3JpZ2luYWwgZ29hbCB3YXMgYWxzbyBmb3INCj4gZGV2aWNlLXRyZWUgbWVjaGFuaXNtcyB0
byBiZSBhYmxlIHRvIGhvb2sgaW50byB0aGlzIGNvZGUgdG8gc3VwcG9ydCBzaW1pbGFyDQo+IFJN
UidzIGFuZCBTTU1VIGluaXRpYWxpemF0aW9uLCBqdXN0IG5vdCB0aHJvdWdoIHRoZSBBQ1BJIC8g
SU9SVCBwYXRoLg0KDQpZZXMuIElJUkMsIHRoZXJlIHdlcmUgc29tZSBlYXJsaWVyIGF0dGVtcHRz
IHRvIGhhdmUgRFQgc3VwcG9ydCBmb3IgcmVzZXJ2ZWQgcmVnaW9ucw0KYW5kIHRoZXJlIHdhcyBh
IHN1Z2dlc3Rpb24gdG8gcHJvdmlkZSBnZW5lcmljIGludGVyZmFjZXMgc28gdGhhdCB3aGVuIERU
IHNvbHV0aW9uDQpjb21lcyB1cCBpdCBpcyBlYXNpZXIgdG8gYWRkIHRoZSBzdXBwb3J0Lg0KDQpU
aGFua3MsDQpTaGFtZWVyDQoNCj4gPg0KPiA+IFJvYmluLg0KPiA+DQo+ID4gPiArDQo+ID4gPiAg
IC8qKg0KPiA+ID4gICAgKiBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gLSBkZXNjcmlwdG9yIGZv
ciBhIHJlc2VydmVkIG1lbW9yeSByZWdpb24NCj4gPiA+ICAgICogQGxpc3Q6IExpbmtlZCBsaXN0
IHBvaW50ZXJzDQo+ID4gPiBAQCAtMTIxLDYgKzEyOCw3IEBAIGVudW0gaW9tbXVfcmVzdl90eXBl
IHsNCj4gPiA+ICAgICogQGxlbmd0aDogTGVuZ3RoIG9mIHRoZSByZWdpb24gaW4gYnl0ZXMNCj4g
PiA+ICAgICogQHByb3Q6IElPTU1VIFByb3RlY3Rpb24gZmxhZ3MgKFJFQUQvV1JJVEUvLi4uKQ0K
PiA+ID4gICAgKiBAdHlwZTogVHlwZSBvZiB0aGUgcmVzZXJ2ZWQgcmVnaW9uDQo+ID4gPiArICog
QHJtcjogQUNQSSBJT1JUIFJNUiBzcGVjaWZpYyBkYXRhDQo+ID4gPiAgICAqLw0KPiA+ID4gICBz
dHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gew0KPiA+ID4gICAgICAgc3RydWN0IGxpc3RfaGVhZCAg
ICAgICAgbGlzdDsNCj4gPiA+IEBAIC0xMjgsNiArMTM2LDkgQEAgc3RydWN0IGlvbW11X3Jlc3Zf
cmVnaW9uIHsNCj4gPiA+ICAgICAgIHNpemVfdCAgICAgICAgICAgICAgICAgIGxlbmd0aDsNCj4g
PiA+ICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIHByb3Q7DQo+ID4gPiAgICAgICBlbnVt
IGlvbW11X3Jlc3ZfdHlwZSAgICB0eXBlOw0KPiA+ID4gKyAgICAgdW5pb24gew0KPiA+ID4gKyAg
ICAgICAgICAgICBzdHJ1Y3QgaW9tbXVfaW9ydF9ybXJfZGF0YSBybXI7DQo+ID4gPiArICAgICB9
IGZ3X2RhdGE7DQo+ID4gPiAgIH07DQo+ID4gPg0KPiA+ID4gICAvKioNCj4gPiA+DQo=
