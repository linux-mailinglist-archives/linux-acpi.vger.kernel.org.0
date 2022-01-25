Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B749B494
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jan 2022 14:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356807AbiAYND7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jan 2022 08:03:59 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32056 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574897AbiAYNAh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2022 08:00:37 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jjn140vWnz1FCtn;
        Tue, 25 Jan 2022 20:56:40 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 21:00:33 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 21:00:32 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Tue, 25 Jan 2022 13:00:30 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHXidEW6lbeFvKh4k2Spj/Qhyfs76x0tQKA
Date:   Tue, 25 Jan 2022 13:00:30 +0000
Message-ID: <9da65c2504b944398188e468eac1abff@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgUm9iaW4vTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBpb21tdSBbbWFpbHRvOmlvbW11LWJvdW5jZXNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmdd
IE9uIEJlaGFsZg0KPiBPZiBTaGFtZWVyIEtvbG90aHVtDQo+IFNlbnQ6IDA1IEF1Z3VzdCAyMDIx
IDA5OjA3DQo+IFRvOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiBDYzogcm9iaW4ubXVycGh5QGFybS5jb207IGpvbkBzb2xpZC1ydW4uY29tOyBMaW51eGFy
bQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOyBHdW9oYW5q
dW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHlhbmd5aWNvbmcgPHlh
bmd5aWNvbmdAaHVhd2VpLmNvbT47DQo+IFNhbWkuTXVqYXdhckBhcm0uY29tOyB3aWxsQGtlcm5l
bC5vcmc7IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2NyAwLzldIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQ0K
PiANCj4gSGksDQo+IA0KPiBUaGUgc2VyaWVzIGFkZHMgc3VwcG9ydCB0byBJT1JUIFJNUiBub2Rl
cyBzcGVjaWZpZWQgaW4gSU9SVA0KPiBSZXZpc2lvbiBFLmIgLUFSTSBERU4gMDA0OUVbMF0uIFJN
UiBub2RlcyBhcmUgdXNlZCB0byBkZXNjcmliZQ0KPiBtZW1vcnkgcmFuZ2VzIHRoYXQgYXJlIHVz
ZWQgYnkgZW5kcG9pbnRzIGFuZCByZXF1aXJlIGEgdW5pdHkNCj4gbWFwcGluZyBpbiBTTU1VLg0K
PiANCj4gV2UgaGF2ZSBmYWNlZCBpc3N1ZXMgd2l0aCAzNDA4aU1SIFJBSUQgY29udHJvbGxlciBj
YXJkcyB3aGljaA0KPiBmYWlsIHRvIGJvb3Qgd2hlbiBTTU1VIGlzIGVuYWJsZWQuIFRoaXMgaXMg
YmVjYXVzZSB0aGVzZQ0KPiBjb250cm9sbGVycyBtYWtlIHVzZSBvZiBob3N0IG1lbW9yeSBmb3Ig
dmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQNCj4gcHVycG9zZXMgYW5kIHdoZW4gU01NVSBpcyBlbmFi
bGVkIHRoZSBpTVIgZmlybXdhcmUgZmFpbHMgdG8NCj4gYWNjZXNzIHRoZXNlIG1lbW9yeSByZWdp
b25zIGFzIHRoZXJlIGlzIG5vIG1hcHBpbmcgZm9yIHRoZW0uDQo+IElPUlQgUk1SIHByb3ZpZGVz
IGEgd2F5IGZvciBVRUZJIHRvIGRlc2NyaWJlIGFuZCByZXBvcnQgdGhlc2UNCj4gbWVtb3J5IHJl
Z2lvbnMgc28gdGhhdCB0aGUga2VybmVsIGNhbiBtYWtlIGEgdW5pdHkgbWFwcGluZyBmb3INCj4g
dGhlc2UgaW4gU01NVS4NCj4gDQo+IENoYW5nZSBIaXN0b3J5Og0KPiANCj4gdjYgLS0+IHY3DQo+
IA0KPiBUaGUgb25seSBjaGFuZ2UgZnJvbSB2NiBpcyB0aGUgZml4IHBvaW50ZWQgb3V0IGJ5IFN0
ZXZlIHRvDQo+IHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4Lg0KPiAN
Cj4gVGhhbmtzIHRvIHRoZSBUZXN0ZWQtYnkgdGFncyBieSBMYXVyZW50aXUgd2l0aCBTTU1VdjIg
YW5kDQo+IEhhbmp1bi9IdWlxaWFuZyB3aXRoIFNNTVV2MyBmb3IgdjYuIEkgaGF2ZW4ndCBhZGRl
ZCB0aGUgdGFncw0KPiB5ZXQgYXMgdGhlIHNlcmllcyBzdGlsbCBuZWVkcyBtb3JlIHJldmlld1sx
XS4NCj4gDQo+IEZlZWRiYWNrIGFuZCB0ZXN0cyBvbiB0aGlzIHNlcmllcyBpcyB2ZXJ5IG11Y2gg
YXBwcmVjaWF0ZWQuDQoNClNpbmNlIHdlIGhhdmUgYW4gdXBkYXRlIHRvIElPUlQgc3BlYyhFLmMp
IG5vd1sxXSBhbmQgaW5jbHVkZXMgYWRkaXRpb25hbA0KYXR0cmlidXRlcy9mbGFncyBmb3IgdGhl
IFJNUiBub2RlLCBJIGFtIHBsYW5uaW5nIHRvIHJlc3BpbiB0aGlzIHNlcmllcyBzb29uLg0KDQpH
b2luZyB0aHJvdWdoIHRoZSBuZXcgc3BlYywgSSBoYXZlIGEgZmV3IHF1ZXJpZXMsDQoNClRoZSBt
ZW1vcnkgcmFuZ2UgYXR0cmlidXRlcyBjYW4gbm93IGJlIGRlc2NyaWJlZCBhcyBvbmUgb2YgdGhl
IGZvbGxvd2luZywNCg0KMHgwMDogRGV2aWNlLW5HblJuRSBtZW1vcnkNCjB4MDE6IERldmljZS1u
R25SRSBtZW1vcnkNCjB4MDI6IERldmljZS1uR1JFIG1lbW9yeQ0KMHgwMzogRGV2aWNlLUdSRSBt
ZW1vcnkNCjB4MDQ6IE5vcm1hbCBJbm5lciBOb24tY2FjaGVhYmxlIE91dGVyIE5vbi1jYWNoZWFi
bGUNCjB4MDU6IE5vcm1hbCBJbm5lciBXcml0ZS1iYWNrIE91dGVyIFdyaXRlLWJhY2sgSW5uZXIg
U2hhcmVhYmxlDQoNCkkgYW0gbm90IHN1cmUgaG93IHRoaXMgbmVlZHMgdG8gYmUgY2FwdHVyZWQg
YW5kIHVzZWQgaW4gdGhlIGtlcm5lbC4gSXMgdGhlcmUNCmFueSBpbnRlbnRpb24gb2YgdXNpbmcg
dGhlc2UgZmluZS1ncmFpbmVkIGF0dHJpYnV0ZXMgaW4gdGhlIGtlcm5lbCBub3cNCm9yIGEgZ2Vu
ZXJpYyBtYXBwaW5nIG9mIHRoZSBhYm92ZSB0byB0aGUgc3RydWN0IGlvbW11X3Jldl9yZWdpb24g
cHJvdCBmaWVsZA0KaXMgZW5vdWdoPyBpLmUuLCBzb21ldGhpbmcgbGlrZSwNCg0Kew0KICAgIC4u
Li4NCiAgICBwcm90ID0gSU9NTVVfUkVBRCB8IElPTU1VX1dSSVRFOw0KDQogICAgaWYgKHJtcl9h
dHRyID09IG5vcm1hbF9tZW0pIC8vIDB4MDUNCiAgICAgICAgcHJvdCB8PSBJT01NVV9DQUNIRTsN
CiAgICANCiAgICBpZiAocm1yX2F0dHIgPT0gZGV2aWNlX21lbSkgeyAvLzB4MDAgLSAweDAzDQog
ICAgICAgIHByb3QgfD0gSU9NTVVfTU1JTzsNCiAgICAgICAgcHJvdCB8PSBJT01NVV9OT0VYRUM7
DQogICAgfQ0KICAgIC4uLi4NCn0NCg0KU2ltaWxhcmx5IGZvciB0aGUgJ2ZsYWdzJyBmaWVsZCwg
dGhlIG5ldyAnQWNjZXNzIFByaXZpbGVnZScgaXMgaW50ZW5kZWQgdG8gc2V0IHRoZQ0KSU9NTVVf
UFJJViA/DQogIA0KUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNClsx
XSBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVuMDA0OS9lYy8/bGFu
Zz1lbg0KDQo=
