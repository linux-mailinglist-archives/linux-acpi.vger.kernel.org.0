Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4892A994E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgKFQR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 11:17:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2068 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKFQR5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2020 11:17:57 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CSQW25SSDz67JTX;
        Sat,  7 Nov 2020 00:16:30 +0800 (CST)
Received: from lhreml718-chm.china.huawei.com (10.201.108.69) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 17:17:55 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 16:17:54 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Fri, 6 Nov 2020 16:17:54 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami Mujawar" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHWrFRPJBcPYX8YLkGaPFi/Jxyu9amtOlsAgAAZ6XCADfQ7gIAADDjg
Date:   Fri, 6 Nov 2020 16:17:54 +0000
Message-ID: <ad2f8ea7821f4b728ab32b61e4a6121e@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
 <36e3a0e58e334e6aa3c051000d742543@huawei.com>
 <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
In-Reply-To: <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVuIFByaWNlIFtt
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDA2IE5vdmVtYmVyIDIwMjAgMTU6
MjINCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tOyBqb3JvQDhieXRlcy5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVy
b25AaHVhd2VpLmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gR3VvaGFu
anVuIChIYW5qdW4gR3VvKSA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBTYW1pIE11amF3YXINCj4g
PFNhbWkuTXVqYXdhckBhcm0uY29tPjsgcm9iaW4ubXVycGh5QGFybS5jb207IHdhbmdodWlxaWFu
Zw0KPiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDAvNF0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+IA0KPiBPbiAyOC8x
MC8yMDIwIDE4OjI0LCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+IEhpIFN0
ZXZlLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFN0
ZXZlbiBQcmljZSBbbWFpbHRvOnN0ZXZlbi5wcmljZUBhcm0uY29tXQ0KPiA+PiBTZW50OiAyOCBP
Y3RvYmVyIDIwMjAgMTY6NDQNCj4gPj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNo
YW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+ID4+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+ID4+
IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBqb3JvQDhieXRlcy5vcmc7IEpvbmF0aGFu
IENhbWVyb24NCj4gPj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IExpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPjsNCj4gPj4gR3VvaGFuanVuIChIYW5qdW4gR3VvKSA8Z3VvaGFu
anVuQGh1YXdlaS5jb20+Ow0KPiByb2Jpbi5tdXJwaHlAYXJtLmNvbTsNCj4gPj4gd2FuZ2h1aXFp
YW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IFNhbWkgTXVqYXdhcg0KPiA+PiA8U2FtaS5N
dWphd2FyQGFybS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvNF0gQUNQSS9J
T1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+ID4+DQo+ID4+IE9uIDI3LzEwLzIwMjAg
MTE6MjYsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4+PiBUaGUgc2VyaWVzIGFkZHMgc3Vw
cG9ydCB0byBJT1JUIFJNUiBub2RlcyBzcGVjaWZpZWQgaW4gSU9SVA0KPiA+Pj4gUmV2aXNpb24g
RSAtQVJNIERFTiAwMDQ5RVswXS4gUk1SIG5vZGVzIGFyZcKgdXNlZCB0b8KgZGVzY3JpYmUgbWVt
b3J5DQo+ID4+PiByYW5nZXMgdGhhdCBhcmUgdXNlZCBieSBlbmRwb2ludHMgYW5kIHJlcXVpcmUg
YSB1bml0eSBtYXBwaW5nDQo+ID4+PiBpbiBTTU1VLg0KPiA+Pg0KPiA+PiBIaSBTaGFtZWVyLA0K
PiA+Pg0KPiA+PiBJJ3ZlIGFsc28gYmVlbiB0YWtpbmcgYSBsb29rIGF0IFJNUiwgYW5kIFNhbWkg
aXMgaGVscGluZyBtZSBnZXQgc2V0IHVwDQo+ID4+IHNvIHRoYXQgSSBjYW4gZG8gc29tZSB0ZXN0
aW5nLiBXZSdyZSBob3BpbmcgdG8gYmUgYWJsZSB0byB0ZXN0IGFuIEVGSQ0KPiA+PiBmcmFtZWJ1
ZmZlciBvciBzcGxhc2ggc2NyZWVuIC0gd2hpY2ggaGFzIHRoZSBhZGRlZCBjb21wbGljYXRpb24g
b2YgdGhlDQo+ID4+IHVuaXR5IG1hcHBpbmcgYmVjb21pbmcgcmVkdW5kYW50IGlmIGEgbmF0aXZl
IGRpc3BsYXkgZHJpdmVyIHRha2VzIG92ZXINCj4gPj4gdGhlIGRpc3BsYXkgY29udHJvbGxlci4N
Cj4gPj4NCj4gPj4gSSd2ZSBsb29rZWQgdGhyb3VnaCB5b3VyIHNlcmllcyBhbmQgdGhlIGNvZGUg
bG9va3MgY29ycmVjdCB0byBtZS4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBh
bmQgdGhlIGRldGFpbHMuDQo+ID4NCj4gPj4gSG9wZWZ1bGx5IEknbGwgYmUgYWJsZSB0byBnaXZl
IGl0IHNvbWUgdGVzdGluZyBzb29uLg0KPiA+DQo+ID4gQ29vbC4gUGxlYXNlIHVwZGF0ZSBvbmNl
IHlvdSBnZXQgYSBjaGFuY2UgcnVuIHRoZSB0ZXN0cy4NCj4gDQo+IEhpIFNoYW1lZXIsDQoNCkhp
IFN0ZXZlLA0KDQo+IEp1c3QgdG8gdXBkYXRlIG9uIHRoaXMsIGZvciB0aGUgRUZJIGZyYW1lYnVm
ZmVyIHVzZSBjYXNlIEkgaGl0IGV4YWN0bHkNCj4gdGhlIGlzc3VlIHRoYXQgUm9iaW4gaGFzIG1l
bnRpb25lZCBpbiBhbm90aGVyIHRocmVhZCAtIHRoZSBSTVIgaXMNCj4gZWZmZWN0aXZlbHkgaWdu
b3JlZCBiZWNhdXNlIHRoZSBkaXNwbGF5IGNvbnRyb2xsZXIgaXNuJ3QgYmVpbmcgaGFuZGxlZA0K
PiBieSBMaW51eCAoc28gdGhlcmUncyBubyBkZXZpY2UgdG8gbGluayBpdCB0bykuDQoNClRoYW5r
cyBmb3IgdGhlIHVwZGF0ZS4gSGVyZSwgYnkgImlnbm9yZWQgInlvdSBtZWFudCBnZXRfcmVzdl9y
ZWdpb25zKCkNCmlzIG5vdCBjYWxsZWQgb3Igbm90Pw0KDQogVGhlIHNwbGFzaCBzY3JlZW4gbWln
aHQNCj4gc2ltaWxhcmx5IGZsaWNrZXIgYXMgdGhlIFNNTVUgcmVzZXQgd2lsbCBpbml0aWFsbHkg
YmxvY2sgdGhlIHRyYWZmaWMNCj4gYmVmb3JlIHRoZSBSTVIgcmVnaW9uIGlzIGVuYWJsZWQuDQoN
CkRvZXMgdGhhdCBtZWFuIHlvdSBzb21laG93IG1hbmFnZWQgdG8gbWFrZSB0aGUgdW5pdHkNCm1h
cHBpbmcgYnV0IHRoZXJlIHdhcyBmbGlja2VyIGR1cmluZyB0aGUgU01NVSByZXNldCB0bw0KdW5p
dHkgbWFwcGluZyBzZXR1cCBwZXJpb2QuIFNvcnJ5IEkgYW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQN
CnRoZSBleGFjdCBiZWhhdmlvciBvYnNlcnZlZCBpbiB0aGlzIGNhc2UuDQoNClRoYW5rcywNClNo
YW1lZXINCg==
