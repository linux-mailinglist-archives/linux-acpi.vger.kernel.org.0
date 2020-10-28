Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA429D7CB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 23:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgJ1W0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:26:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:3013 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733111AbgJ1W0y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:54 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 81CF89497963A380C9A9;
        Wed, 28 Oct 2020 18:40:34 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 28 Oct 2020 18:40:34 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Wed, 28 Oct 2020 18:40:34 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
Thread-Topic: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
Thread-Index: AQHWrFRpYmjWzlgvCkWX8PhkbYIcjqmr/GWAgACrRfCAAK2ZAIAAAX1Q
Date:   Wed, 28 Oct 2020 18:40:33 +0000
Message-ID: <ad260ac88bb84f9d850f95f05454e140@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-2-shameerali.kolothum.thodi@huawei.com>
 <BYAPR11MB3256AFF743B4FCC400F4181C87160@BYAPR11MB3256.namprd11.prod.outlook.com>
 <610c14ef56d64fe087ca52aede07d811@huawei.com>
 <MWHPR11MB1599988D7C857E3AFFA4A48AF0170@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599988D7C857E3AFFA4A48AF0170@MWHPR11MB1599.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.37]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRXJpaywNCg0KW0FkZGluZyBiYWNrIHRoZSBvcmlnaW5hbCBNTHMgKyBDQyBsaXN0XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbmVkYSwgRXJpayBbbWFpbHRv
OmVyaWsua2FuZWRhQGludGVsLmNvbV0NCj4gU2VudDogMjggT2N0b2JlciAyMDIwIDE4OjIwDQo+
IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+Ow0KPiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsg
V3lzb2NraSwgUmFmYWVsIEoNCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW0RldmVsXSBbUkZDIFBBVENIIDEvNF0gQUNQSUNBOiBJT1JUOiBVcGRhdGUgZm9y
IHJldmlzaW9uIEUNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPiA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyOCwg
MjAyMCAxOjE1IEFNDQo+ID4gVG86IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5j
b20+DQo+ID4gQ2M6IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPg0KPiA+IFN1
YmplY3Q6IFJFOiBbRGV2ZWxdIFtSRkMgUEFUQ0ggMS80XSBBQ1BJQ0E6IElPUlQ6IFVwZGF0ZSBm
b3IgcmV2aXNpb24NCj4gPiBFDQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1vb3JlLCBSb2JlcnQgW21haWx0bzpyb2JlcnQu
bW9vcmVAaW50ZWwuY29tXQ0KPiA+ID4gU2VudDogMjcgT2N0b2JlciAyMDIwIDIxOjQ2DQo+ID4g
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA+IDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+DQo+ID4gPiBDYzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBp
bnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSRTogW0RldmVsXSBbUkZDIFBBVENIIDEvNF0gQUNQ
SUNBOiBJT1JUOiBVcGRhdGUgZm9yDQo+ID4gPiByZXZpc2lvbiBFDQo+ID4gPg0KPiA+ID4gVGhp
cyBwYXRjaCB3aWxsIG5lZWQgdG8gYmUgcG9ydGVkIHRvIHRoZSBuYXRpdmUgQUNQSUNBIGZvcm1h
dC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gU29ycnkgdGhhdCwgSSBhbSBu
b3QgZmFtaWxpYXIgd2l0aCB0aGUgcHJvY2VzcyBoZXJlLg0KPiA+IEFzIG1lbnRpb25lZA0KPiA+
IGJlbG93LCBJIHRob3VnaHQgYSBwdWxsIHJlcXVlc3QgdmlhIGFjcGljYSBnaXQgaXMgZW5vdWdo
LCB3aGljaCB5b3UNCj4gPiBjYW4gZmluZCBoZXJlLA0KPiA+DQo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2FjcGljYS9hY3BpY2EvcHVsbC82MzgNCj4gPg0KPiA+IFRoZSBhYm92ZSBwdWxsIGluY2x1
ZGVzIHRoaXMgaGVhZGVyIGZpbGUgY2hhbmdlICsgb3RoZXIgY2hhbmdlcw0KPiA+IHJlbGF0ZWQg
dG8gUk1SIGZvciB0b29scy4NCj4gPg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyB3aGF0IGVsc2Ug
bmVlZHMgdG8gYmUgZG9uZSB3aGVuIHlvdSBzYXkgIm5hdGl2ZQ0KPiA+IGZvcm1hdCIuDQo+IA0K
PiBPaCBvaywgdGhhbmtzIGZvciB0aGUgcHVsbCByZXF1ZXN0LiBZb3UncmUgc3VibWl0dGluZyB0
aGlzIGFzIGFuIFJGQyBmb3IgbGludXguIERvDQo+IHlvdSBleHBlY3QgdGhlIElPUlQgZGVmaW5p
dGlvbiB0byBjaGFuZ2UgdGhyb3VnaG91dCBsaW51eCdzIFJGQyBwZXJpb2Q/IElmIHlvdQ0KPiBk
b24ndCBwbGFuIG9uIGNoYW5naW5nIHRoZSBJT1JUIGRlZmluaXRpb24sIHdlIGNhbiBsb29rIGF0
IHRoZSBwdWxsIHJlcXVlc3QuDQoNClRoZSBJT1JUIHJldmlzaW9uIEUgZG9jdW1lbnQgaXMgcHVi
bGlzaGVkIGhlcmUsDQpodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVu
MDA0OS9sYXRlc3QvDQphbmQgSSBkb27igJl0IHRoaW5rIGl0IHdpbGwgY2hhbmdlIG5vdyAoQnV0
IEFSTSBmb2xrcyBjYW4gY29uZmlybSB0aGlzKS4NCg0KSSBzdWJtaXR0ZWQgdGhpcyBhcyBhbiBS
RkMsIGJlY2F1c2Ugb2YgdGhlIHZlcnkgZGVwZW5kZW5jeSBvbiB0aGlzIGFjdGJsMi5oDQpoZWFk
ZXIgdXBkYXRlcyBhbmQgdGhpcyBiZWluZyBub3QgYXZhaWxhYmxlIGluIGtlcm5lbC4gDQoNCj4g
T25jZSB3ZSBtZXJnZSBpdCwgSSdsbCBzdWJtaXQgdGhlIEFDUElDQSBwYXRjaGVzIHRvIFJhZmFl
bCBhZnRlciB3ZSBkbyBhDQo+IHJlbGVhc2UuDQoNCk9rLiBUaGFua3MgZm9yIHRoZSBkZXRhaWxz
LiBMb29raW5nIGZvcndhcmQgdG8gZ2V0dGluZyB0aGlzIG1lcmdlZCB0byBrZXJuZWwgc29vbiA6
KQ0KDQpUaGFua3MsDQpTaGFtZWVyDQogDQo+IEVyaWsNCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBT
aGFtZWVyDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyNywgMjAy
MCA0OjI3IEFNDQo+ID4gPiBUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiA+ID4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOw0KPiA+ID4gZGV2ZWxAYWNwaWNhLm9yZw0KPiA+ID4gQ2M6IGxpbnV4YXJt
QGh1YXdlaS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGpvcm9AOGJ5dGVzLm9yZzsN
Cj4gPiA+IHJvYmluLm11cnBoeUBhcm0uY29tOyB3YW5naHVpcWlhbmdAaHVhd2VpLmNvbTsNCj4g
PiA+IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbQ0KPiA+ID4gU3ViamVjdDogW0RldmVsXSBb
UkZDIFBBVENIIDEvNF0gQUNQSUNBOiBJT1JUOiBVcGRhdGUgZm9yIHJldmlzaW9uIEUNCj4gPiA+
DQo+ID4gPiBJT1JUIHJldmlzaW9uIEUgY29udGFpbnMgYSBmZXcgYWRkaXRpb25zIGxpa2UsDQo+
ID4gPiDCoCDCoCAtQWRkZWQgYW4gaWRlbnRpZmllciBmaWVsZCBpbiB0aGUgbm9kZSBkZXNjcmlw
dG9ycyB0byBhaWQgdGFibGUNCj4gPiA+IMKgIMKgIMKgY3Jvc3MtcmVmZXJlbmNpbmcuDQo+ID4g
PiDCoCDCoCAtSW50cm9kdWNlZCB0aGUgUmVzZXJ2ZWQgTWVtb3J5IFJhbmdlKFJNUikgbm9kZS4g
VGhpcyBpcyB1c2VkDQo+ID4gPiAgwqAgwqAgdG8gZGVzY3JpYmUgbWVtb3J5IHJhbmdlcyB0aGF0
IGFyZSB1c2VkIGJ5IGVuZHBvaW50cyBhbmQNCj4gPiA+IHJlcXVpcmVzDQo+ID4gPiAgwqAgwqAg
YSB1bml0eSBtYXBwaW5nIGluIFNNTVUuDQo+ID4gPiAgICAgLUludHJvZHVjZWQgYSBmbGFnIGlu
IHRoZSBSQyBub2RlIHRvIGV4cHJlc3Mgc3VwcG9ydCBmb3IgUFJJLg0KPiA+ID4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLVRoaXMgc2hvdWxkIGJlIHVwZGF0
ZWQgdGhyb3VnaCBhY3BpY2EgZ2l0LiBJIGhhdmUgc2VudCBvdXQgYSBwdWxsDQo+ID4gPiAgIHJl
cXVlc3QgZm9yIHRoZSBzYW1lIGhlcmUsDQo+ID4gPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9hY3Bp
Y2EvYWNwaWNhL3B1bGwvNjM4DQo+ID4gPg0KPiA+ID4gUGxlYXNlIGhlbHAgdG8gcmV2aWV3Lg0K
PiA+ID4gLS0tDQo+ID4gPiAgaW5jbHVkZS9hY3BpL2FjdGJsMi5oIHwgMjUgKysrKysrKysrKysr
KysrKysrKy0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWN0
YmwyLmggYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmggaW5kZXgNCj4gPiA+IGVjNjY3NzljYjE5My4u
Mjc0ZmNlN2I1YzAxIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjdGJsMi5oDQo+
ID4gPiArKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgNCj4gPiA+IEBAIC02OCw3ICs2OCw3IEBA
DQo+ID4gPiAgICogSU9SVCAtIElPIFJlbWFwcGluZyBUYWJsZQ0KPiA+ID4gICAqDQo+ID4gPiAg
ICogQ29uZm9ybXMgdG8gIklPIFJlbWFwcGluZyBUYWJsZSBTeXN0ZW0gU29mdHdhcmUgb24gQVJN
DQo+ID4gPiBQbGF0Zm9ybXMiLA0KPiA+ID4gLSAqIERvY3VtZW50IG51bWJlcjogQVJNIERFTiAw
MDQ5RCwgTWFyY2ggMjAxOA0KPiA+ID4gKyAqIERvY3VtZW50IG51bWJlcjogQVJNIERFTiAwMDQ5
RSwgSnVuZSAyMDIwDQo+ID4gPiAgICoNCj4gPiA+DQo+ID4gPg0KPiA+ICoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gPiAqKioqKioN
Cj4gPiA+ICoqKioqKioqKioqKioqLw0KPiA+ID4NCj4gPiA+IEBAIC04Niw3ICs4Niw4IEBAIHN0
cnVjdCBhY3BpX2lvcnRfbm9kZSB7DQo+ID4gPiAgCXU4IHR5cGU7DQo+ID4gPiAgCXUxNiBsZW5n
dGg7DQo+ID4gPiAgCXU4IHJldmlzaW9uOw0KPiA+ID4gLQl1MzIgcmVzZXJ2ZWQ7DQo+ID4gPiAr
CXUxNiByZXNlcnZlZDsNCj4gPiA+ICsJdTE2IGlkZW50aWZpZXI7DQo+ID4gPiAgCXUzMiBtYXBw
aW5nX2NvdW50Ow0KPiA+ID4gIAl1MzIgbWFwcGluZ19vZmZzZXQ7DQo+ID4gPiAgCWNoYXIgbm9k
ZV9kYXRhWzFdOw0KPiA+ID4gQEAgLTEwMCw3ICsxMDEsOCBAQCBlbnVtIGFjcGlfaW9ydF9ub2Rl
X3R5cGUgew0KPiA+ID4gIAlBQ1BJX0lPUlRfTk9ERV9QQ0lfUk9PVF9DT01QTEVYID0gMHgwMiwN
Cj4gPiA+ICAJQUNQSV9JT1JUX05PREVfU01NVSA9IDB4MDMsDQo+ID4gPiAgCUFDUElfSU9SVF9O
T0RFX1NNTVVfVjMgPSAweDA0LA0KPiA+ID4gLQlBQ1BJX0lPUlRfTk9ERV9QTUNHID0gMHgwNQ0K
PiA+ID4gKwlBQ1BJX0lPUlRfTk9ERV9QTUNHID0gMHgwNSwNCj4gPiA+ICsJQUNQSV9JT1JUX05P
REVfUk1SID0gMHgwNiwNCj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICBzdHJ1Y3QgYWNwaV9pb3J0
X2lkX21hcHBpbmcgew0KPiA+ID4gQEAgLTE2NywxMCArMTY5LDEwIEBAIHN0cnVjdCBhY3BpX2lv
cnRfcm9vdF9jb21wbGV4IHsNCj4gPiA+ICAJdTggcmVzZXJ2ZWRbM107CQkvKiBSZXNlcnZlZCwg
bXVzdCBiZSB6ZXJvICovDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAtLyogVmFsdWVzIGZvciBh
dHNfYXR0cmlidXRlIGZpZWxkIGFib3ZlICovDQo+ID4gPiArLyogTWFza3MgZm9yIGF0c19hdHRy
aWJ1dGUgZmllbGQgYWJvdmUgKi8NCj4gPiA+DQo+ID4gPiAtI2RlZmluZSBBQ1BJX0lPUlRfQVRT
X1NVUFBPUlRFRCAgICAgICAgIDB4MDAwMDAwMDEJLyogVGhlDQo+IHJvb3QNCj4gPiA+IGNvbXBs
ZXggc3VwcG9ydHMgQVRTICovDQo+ID4gPiAtI2RlZmluZSBBQ1BJX0lPUlRfQVRTX1VOU1VQUE9S
VEVEICAgICAgIDB4MDAwMDAwMDAJLyogVGhlDQo+IHJvb3QNCj4gPiA+IGNvbXBsZXggZG9lc24n
dCBzdXBwb3J0IEFUUyAqLw0KPiA+ID4gKyNkZWZpbmUgQUNQSV9JT1JUX0FUU19TVVBQT1JURUQg
ICAgICAgICAoMSkJLyogVGhlIHJvb3QgY29tcGxleA0KPiA+ID4gc3VwcG9ydHMgQVRTICovDQo+
ID4gPiArI2RlZmluZSBBQ1BJX0lPUlRfUFJJX1NVUFBPUlRFRCAgICAgICAgICgxPDwxKQkvKiBU
aGUgcm9vdA0KPiBjb21wbGV4DQo+ID4gPiBzdXBwb3J0cyBQUkkgKi8NCj4gPiA+DQo+ID4gPiAg
c3RydWN0IGFjcGlfaW9ydF9zbW11IHsNCj4gPiA+ICAJdTY0IGJhc2VfYWRkcmVzczsJLyogU01N
VSBiYXNlIGFkZHJlc3MgKi8NCj4gPiA+IEBAIC0yNDEsNiArMjQzLDE3IEBAIHN0cnVjdCBhY3Bp
X2lvcnRfcG1jZyB7DQo+ID4gPiAgCXU2NCBwYWdlMV9iYXNlX2FkZHJlc3M7DQo+ID4gPiAgfTsN
Cj4gPiA+DQo+ID4gPiArc3RydWN0IGFjcGlfaW9ydF9ybXIgew0KPiA+ID4gKwl1MzIgcm1yX2Nv
dW50Ow0KPiA+ID4gKwl1MzIgcm1yX29mZnNldDsNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4g
K3N0cnVjdCBhY3BpX2lvcnRfcm1yX2Rlc2Mgew0KPiA+ID4gKwl1NjQgYmFzZV9hZGRyZXNzOw0K
PiA+ID4gKwl1NjQgbGVuZ3RoOw0KPiA+ID4gKwl1MzIgcmVzZXJ2ZWQ7DQo+ID4gPiArfTsNCj4g
PiA+ICsNCj4gPiA+DQo+ID4gPg0KPiA+IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ID4gKioqKioNCj4gPiA+ICoqKioqKioqKioq
KioqKioNCj4gPiA+ICAgKg0KPiA+ID4gICAqIElWUlMgLSBJL08gVmlydHVhbGl6YXRpb24gUmVw
b3J0aW5nIFN0cnVjdHVyZQ0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+ID4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+IERldmVsIG1haWxp
bmcgbGlzdCAtLSBkZXZlbEBhY3BpY2Eub3JnIFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwN
Cj4gPiA+IHRvDQo+ID4gPiBkZXZlbC0NCj4gPiBsZWF2ZUBhY3BpY2Eub3JnICUod2ViX3BhZ2Vf
dXJsKXNsaXN0aW5mbyUoY2dpZXh0KXMvJShfaW50ZXJuYWxfbmFtZQ0KPiA+ID4gKXMNCg==
