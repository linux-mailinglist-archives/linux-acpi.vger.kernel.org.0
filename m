Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56996343E13
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 11:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCVKgY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 06:36:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3375 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCVKgO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 06:36:14 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F3rSf6bpLz5fxY;
        Mon, 22 Mar 2021 18:33:38 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 18:36:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 18:36:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.013; Mon, 22 Mar 2021 10:36:04 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "robert.moore@intel.com" <robert.moore@intel.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Topic: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Index: AQHWvm1dfTBTih8pMEKAOph+J6BTAKqQitWg
Date:   Mon, 22 Mar 2021 10:36:04 +0000
Message-ID: <b7a2424941214b33803e34ba3e532440@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.24.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

WytdDQoNCkhpIEVyaWssDQoNCkFzIHRoaXMgaXMgbm93IGp1c3QgbWVyZ2VkIGlubyBhY3BpY2Et
bWFzdGVyIGFuZCBiYXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiB3ZSBoYWQgaGVyZSwNCg0KaHR0cHM6
Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2EvcHVsbC82MzgNCg0KSSBoYWQgYSBkaXNjdXNzaW9u
IHdpdGggQVJNIGZvbGtzKExvcmVuem8pIGluIHRoZSBsaW5hcm8tb3Blbi1kaXNjdXNzaW9ucyBj
YWxsIGFuZA0KY2FuIGNvbmZpcm0gdGhhdCB0aGUgSU9SVCBSZXZpc2lvbiBFIGlzIG5vdCB0aGUg
ZmluYWwgc3BlY2lmaWNhdGlvbiBhbmQgaGFzIHNvbWUgaXNzdWVzDQp3aGljaCBpcyBub3cgY29y
cmVjdGVkIGluIHRoZSBsYXRlc3QgRS5iIHJldmlzaW9uWzFdLiBBbHNvIHRoZXJlIGFyZSBubyBj
dXJyZW50IHVzZXJzDQpmb3IgdGhlIFJldiBFIGFuZCBpdCBtYXkgbm90IGJlIGEgZ29vZCBpZGVh
IHRvIHB1c2ggdGhpcyB2ZXJzaW9uIGludG8gdGhlIExpbnV4IGtlcm5lbA0Kb3IgZWxzZXdoZXJl
Lg0KDQpTbyBjb3VsZCB5b3UgcGxlYXNlIHJldmVydCB0aGUgbWVyZ2UgYW5kIEkgYW0gcGxhbm5p
bmcgdG8gd29yayBvbiB0aGUgRS5iIHNvb24uDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBuZWVk
IHRvIGV4cGxpY2l0bHkgc2VuZCBhIHJldmVydCBwdWxsIHJlcXVlc3Qgb3Igbm90Lg0KDQpUaGFu
a3MsDQpTaGFtZWVyDQoNCjEuIGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlv
bi9kZW4wMDQ5L2xhdGVzdC8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBpb21tdSBbbWFpbHRvOmlvbW11LWJvdW5jZXNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmdd
IE9uIEJlaGFsZiBPZg0KPiBTaGFtZWVyIEtvbG90aHVtDQo+IFNlbnQ6IDE5IE5vdmVtYmVyIDIw
MjAgMTI6MTINCj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNv
bT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOyBHdW9oYW5qdW4NCj4gKEhhbmp1biBHdW8pIDxndW9o
YW5qdW5AaHVhd2VpLmNvbT47IFNhbWkuTXVqYXdhckBhcm0uY29tOw0KPiByb2Jpbi5tdXJwaHlA
YXJtLmNvbTsgd2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogW1JGQyBQQVRDSCB2MiAxLzhdIEFDUElDQTogSU9SVDogVXBkYXRlIGZvciByZXZpc2lvbiBF
DQo+IA0KPiBJT1JUIHJldmlzaW9uIEUgY29udGFpbnMgYSBmZXcgYWRkaXRpb25zIGxpa2UsDQo+
IMKgIMKgIC1BZGRlZCBhbiBpZGVudGlmaWVyIGZpZWxkIGluIHRoZSBub2RlIGRlc2NyaXB0b3Jz
IHRvIGFpZCB0YWJsZQ0KPiDCoCDCoCDCoGNyb3NzLXJlZmVyZW5jaW5nLg0KPiDCoCDCoCAtSW50
cm9kdWNlZCB0aGUgUmVzZXJ2ZWQgTWVtb3J5IFJhbmdlKFJNUikgbm9kZS4gVGhpcyBpcyB1c2Vk
DQo+ICDCoCDCoCB0byBkZXNjcmliZSBtZW1vcnkgcmFuZ2VzIHRoYXQgYXJlIHVzZWQgYnkgZW5k
cG9pbnRzIGFuZCByZXF1aXJlcw0KPiAgwqAgwqAgYSB1bml0eSBtYXBwaW5nIGluIFNNTVUuDQo+
ICAgICAtSW50cm9kdWNlZCBhIGZsYWcgaW4gdGhlIFJDIG5vZGUgdG8gZXhwcmVzcyBzdXBwb3J0
IGZvciBQUkkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9hY3BpL2Fj
dGJsMi5oIHwgMjUgKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9hY3BpL2FjdGJsMi5oIGIvaW5jbHVkZS9hY3BpL2FjdGJsMi5oIGluZGV4DQo+IGVjNjY3
NzljYjE5My4uMjc0ZmNlN2I1YzAxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2FjcGkvYWN0Ymwy
LmgNCj4gKysrIGIvaW5jbHVkZS9hY3BpL2FjdGJsMi5oDQo+IEBAIC02OCw3ICs2OCw3IEBADQo+
ICAgKiBJT1JUIC0gSU8gUmVtYXBwaW5nIFRhYmxlDQo+ICAgKg0KPiAgICogQ29uZm9ybXMgdG8g
IklPIFJlbWFwcGluZyBUYWJsZSBTeXN0ZW0gU29mdHdhcmUgb24gQVJNIFBsYXRmb3JtcyIsDQo+
IC0gKiBEb2N1bWVudCBudW1iZXI6IEFSTSBERU4gMDA0OUQsIE1hcmNoIDIwMTgNCj4gKyAqIERv
Y3VtZW50IG51bWJlcjogQVJNIERFTiAwMDQ5RSwgSnVuZSAyMDIwDQo+ICAgKg0KPiANCj4gKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKg0KPiAqKioqKioqKioqKioqKi8NCj4gDQo+IEBAIC04Niw3ICs4Niw4IEBAIHN0cnVjdCBh
Y3BpX2lvcnRfbm9kZSB7DQo+ICAJdTggdHlwZTsNCj4gIAl1MTYgbGVuZ3RoOw0KPiAgCXU4IHJl
dmlzaW9uOw0KPiAtCXUzMiByZXNlcnZlZDsNCj4gKwl1MTYgcmVzZXJ2ZWQ7DQo+ICsJdTE2IGlk
ZW50aWZpZXI7DQo+ICAJdTMyIG1hcHBpbmdfY291bnQ7DQo+ICAJdTMyIG1hcHBpbmdfb2Zmc2V0
Ow0KPiAgCWNoYXIgbm9kZV9kYXRhWzFdOw0KPiBAQCAtMTAwLDcgKzEwMSw4IEBAIGVudW0gYWNw
aV9pb3J0X25vZGVfdHlwZSB7DQo+ICAJQUNQSV9JT1JUX05PREVfUENJX1JPT1RfQ09NUExFWCA9
IDB4MDIsDQo+ICAJQUNQSV9JT1JUX05PREVfU01NVSA9IDB4MDMsDQo+ICAJQUNQSV9JT1JUX05P
REVfU01NVV9WMyA9IDB4MDQsDQo+IC0JQUNQSV9JT1JUX05PREVfUE1DRyA9IDB4MDUNCj4gKwlB
Q1BJX0lPUlRfTk9ERV9QTUNHID0gMHgwNSwNCj4gKwlBQ1BJX0lPUlRfTk9ERV9STVIgPSAweDA2
LA0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgYWNwaV9pb3J0X2lkX21hcHBpbmcgew0KPiBAQCAtMTY3
LDEwICsxNjksMTAgQEAgc3RydWN0IGFjcGlfaW9ydF9yb290X2NvbXBsZXggew0KPiAgCXU4IHJl
c2VydmVkWzNdOwkJLyogUmVzZXJ2ZWQsIG11c3QgYmUgemVybyAqLw0KPiAgfTsNCj4gDQo+IC0v
KiBWYWx1ZXMgZm9yIGF0c19hdHRyaWJ1dGUgZmllbGQgYWJvdmUgKi8NCj4gKy8qIE1hc2tzIGZv
ciBhdHNfYXR0cmlidXRlIGZpZWxkIGFib3ZlICovDQo+IA0KPiAtI2RlZmluZSBBQ1BJX0lPUlRf
QVRTX1NVUFBPUlRFRCAgICAgICAgIDB4MDAwMDAwMDEJLyogVGhlIHJvb3QNCj4gY29tcGxleCBz
dXBwb3J0cyBBVFMgKi8NCj4gLSNkZWZpbmUgQUNQSV9JT1JUX0FUU19VTlNVUFBPUlRFRCAgICAg
ICAweDAwMDAwMDAwCS8qIFRoZSByb290DQo+IGNvbXBsZXggZG9lc24ndCBzdXBwb3J0IEFUUyAq
Lw0KPiArI2RlZmluZSBBQ1BJX0lPUlRfQVRTX1NVUFBPUlRFRCAgICAgICAgICgxKQkvKiBUaGUg
cm9vdCBjb21wbGV4DQo+IHN1cHBvcnRzIEFUUyAqLw0KPiArI2RlZmluZSBBQ1BJX0lPUlRfUFJJ
X1NVUFBPUlRFRCAgICAgICAgICgxPDwxKQkvKiBUaGUgcm9vdCBjb21wbGV4DQo+IHN1cHBvcnRz
IFBSSSAqLw0KPiANCj4gIHN0cnVjdCBhY3BpX2lvcnRfc21tdSB7DQo+ICAJdTY0IGJhc2VfYWRk
cmVzczsJLyogU01NVSBiYXNlIGFkZHJlc3MgKi8NCj4gQEAgLTI0MSw2ICsyNDMsMTcgQEAgc3Ry
dWN0IGFjcGlfaW9ydF9wbWNnIHsNCj4gIAl1NjQgcGFnZTFfYmFzZV9hZGRyZXNzOw0KPiAgfTsN
Cj4gDQo+ICtzdHJ1Y3QgYWNwaV9pb3J0X3JtciB7DQo+ICsJdTMyIHJtcl9jb3VudDsNCj4gKwl1
MzIgcm1yX29mZnNldDsNCj4gK307DQo+ICsNCj4gK3N0cnVjdCBhY3BpX2lvcnRfcm1yX2Rlc2Mg
ew0KPiArCXU2NCBiYXNlX2FkZHJlc3M7DQo+ICsJdTY0IGxlbmd0aDsNCj4gKwl1MzIgcmVzZXJ2
ZWQ7DQo+ICt9Ow0KPiArDQo+IA0KPiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKioqKioqKioqKioNCj4gICAq
DQo+ICAgKiBJVlJTIC0gSS9PIFZpcnR1YWxpemF0aW9uIFJlcG9ydGluZyBTdHJ1Y3R1cmUNCj4g
LS0NCj4gMi4xNy4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBpb21tdSBtYWlsaW5nIGxpc3QNCj4gaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcNCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXUNCg==
