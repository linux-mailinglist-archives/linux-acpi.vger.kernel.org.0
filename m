Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7292D96AE
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 11:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgLNK4P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 05:56:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2253 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbgLNK4K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 05:56:10 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CvdVw2P2Wz67Q4M;
        Mon, 14 Dec 2020 18:51:52 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 14 Dec 2020 11:55:26 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 10:55:26 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.002; Mon, 14 Dec 2020 10:55:26 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>
Subject: RE: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHWvm1ikW2cGVer1kuw1XacsP3g9qnwQL+AgAY7lgA=
Date:   Mon, 14 Dec 2020 10:55:26 +0000
Message-ID: <67cb563d19114f609348dc9f8b4307e9@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
In-Reply-To: <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.67.216]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgU3RldmUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVu
IFByaWNlIFttYWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDEwIERlY2VtYmVy
IDIwMjAgMTA6MjYNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGku
a29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IENjOiBMaW51eGFybSA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5
dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFp
YW5nQGh1YXdlaS5jb20+OyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVh
d2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT47IFNhbWkuTXVqYXdhckBhcm0uY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDAv
OF0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+IA0KPiBPbiAxOS8xMS8y
MDIwIDEyOjExLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFJGQyB2MSAtLT4gdjI6DQo+
ID4gIMKgLSBBZGRlZCBhIGdlbmVyaWMgaW50ZXJmYWNlIGZvciBJT01NVSBkcml2ZXJzIHRvIHJl
dHJpZXZlIGFsbCB0aGUNCj4gPiAgwqAgwqBSTVIgaW5mbyBhc3NvY2lhdGVkIHdpdGggYSBnaXZl
biBJT01NVS4NCj4gPiAgwqAtIFNNTVV2MyBkcml2ZXIgZ2V0cyB0aGUgUk1SIGxpc3QgZHVyaW5n
IHByb2JlKCkgYW5kIGluc3RhbGxzDQo+ID4gIMKgwqAgYnlwYXNzIFNURXMgZm9yIGFsbCB0aGUg
U0lEcyBpbiB0aGUgUk1SIGxpc3QuIFRoaXMgaXMgdG8ga2VlcA0KPiA+ICAgwqAgdGhlIG9uZ29p
bmcgdHJhZmZpYyBhbGl2ZShpZiBhbnkpIGR1cmluZyBTTU1VdjMgcmVzZXQuIFRoaXMgaXMNCj4g
PiAgICAgYmFzZWQgb24gdGhlIHN1Z2dlc3Rpb25zIHJlY2VpdmVkIGZvciB2MSB0byB0YWtlIGNh
cmUgb2YgdGhlDQo+ID4gICAgIEVGSSBmcmFtZWJ1ZmZlciB1c2UgY2FzZS4gT25seSBzYW5pdHkg
dGVzdGVkIGZvciBub3cuDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gU29ycnkgZm9yIG5vdCBs
b29raW5nIGF0IHRoaXMgYmVmb3JlLg0KPiANCj4gRG8geW91IGhhdmUgYW55IHBsYW5zIHRvIGlt
cGxlbWVudCBzdXBwb3J0IGluIHRoZSBTTU1VdjIgZHJpdmVyPyBUaGUNCj4gcGxhdGZvcm0gSSd2
ZSBiZWVuIHRlc3RpbmcgdGhlIEVGSSBmcmFtZWJ1ZmZlciBzdXBwb3J0IG9uIGhhcyB0aGUNCj4g
ZGlzcGxheSBjb250cm9sbGVyIGJlaGluZCBTTU1VdjIsIHNvIGFzIGl0IHN0YW5kcyB0aGlzIHNl
cmllcyBkb2Vzbid0DQo+IHdvcmsuIEkgZGlkIGhhY2sgc29tZXRoaW5nIHVwIGZvciBTTU1VdjIg
c28gSSB3YXMgYWJsZSB0byB0ZXN0IHRoZSBmaXJzdA0KPiA0IHBhdGNoZXMuDQoNClRoYW5rcyBm
b3IgdGFraW5nIGEgbG9vay4gU3VyZSwgSSBjYW4gbG9vayBpbnRvIGFkZGluZyB0aGUgc3VwcG9y
dCBmb3IgU01NVXYyLiANCg0KPiANCj4gPiAgwqAtIER1cmluZyB0aGUgcHJvYmUvYXR0YWNoIGRl
dmljZSwgU01NVXYzIGRyaXZlciByZXNlcnZlcyBhbnkNCj4gPiAgwqAgwqBSTVIgcmVnaW9uIGFz
c29jaWF0ZWQgd2l0aCB0aGUgZGV2aWNlIHN1Y2ggdGhhdCB0aGVyZSBpcyBhIHVuaXR5DQo+ID4g
IMKgIMKgbWFwcGluZyBmb3IgdGhlbSBpbiBTTU1VLg0KPiANCj4gRm9yIHRoZSBFRkkgZnJhbWVi
dWZmZXIgdXNlIGNhc2UgdGhlcmUgaXMgbm8gZGV2aWNlIHRvIGF0dGFjaCBzbyBJDQo+IGJlbGll
dmUgd2UgYXJlIGxlZnQgd2l0aCBqdXN0IHRoZSBzdHJlYW0gSUQgaW4gYnlwYXNzIG1vZGUgLSB3
aGljaCBpcw0KPiBkZWZpbml0ZWx5IGFuIGltcHJvdmVtZW50ICh0aGUgZGlzcGxheSB3b3JrcyEp
DQoNCkNvb2wuIFRoYXTigJlzIGdvb2QgdG8ga25vdy4NCg0KIGJ1dCBub3QgYWN0dWFsbHkgYSB1
bml0eQ0KPiBtYXBwaW5nIG9mIHRoZSBSTVIgcmFuZ2UuIEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0
J3Mgd29ydGggZml4aW5nIHRoaXMgb3INCj4gbm90LCBidXQgSSBqdXN0IHdhbnRlZCB0byBwb2lu
dCBvdXQgdGhlcmUncyBzdGlsbCBhIG5lZWQgZm9yIGEgZHJpdmVyDQo+IGZvciB0aGUgZGV2aWNl
IGJlZm9yZSB0aGUgYnlwYXNzIG1vZGUgaXMgcmVwbGFjZWQgd2l0aCB0aGUgdW5pdHkgbWFwcGlu
Zy4NCg0KSSBhbSBub3Qgc3VyZSBlaXRoZXIuIE15IGlkZWEgd2FzIHdlIHdpbGwgaGF2ZSBieXBh
c3MgU1RFIHNldHVwIGZvciBhbGwgZGV2aWNlcw0Kd2l0aCBSTVIgaW5pdGlhbGx5IGFuZCB3aGVu
IHRoZSBjb3JyZXNwb25kaW5nIGRyaXZlciB0YWtlcyBvdmVyKGlmIHRoYXQgaGFwcGVucykNCndl
IHdpbGwgaGF2ZSB0aGUgdW5pdHkgbWFwcGluZyBzZXR1cCBwcm9wZXJseSBmb3IgdGhlIFJNUiBy
ZWdpb25zLiBBbmQgZm9yIGNhc2VzDQpsaWtlIHRoZSBhYm92ZSwgaXQgd2lsbCByZW1haW4gaW4g
dGhlIGJ5cGFzcyBtb2RlLg0KDQpEbyB5b3Ugc2VlIGFueSBwcm9ibGVtKHNlY3VyaXR5PykgaWYg
dGhlIGRldiBzdHJlYW1zIHJlbWFpbiBpbiBieXBhc3MgbW9kZSBmb3INCnRoaXMgZGV2PyBPciBp
cyBpdCBwb3NzaWJsZSB0byBoYXZlIGEgc3R1YiBkcml2ZXIgZm9yIHRoaXMgZGV2LCBzbyB0aGF0
IHdlIHdpbGwgaGF2ZQ0KdGhlIHByb2JlL2F0dGFjaCBpbnZva2VkIGFuZCBldmVyeXRoaW5nIHdp
bGwgZmFsbCBpbiBwbGFjZT8NCg0KVEJILCBJIGhhdmVuJ3QgbG9va2VkIGludG8gY3JlYXRpbmcg
YSB0ZW1wIGRvbWFpbiBmb3IgdGhlc2UgdHlwZXMgb2YgdGhlIGRldmljZXMNCmFuZCBhbHNvIG5v
dCBzdXJlIGhvdyB3ZSBiZW5lZml0IGZyb20gdGhhdCBjb21wYXJlZCB0byB0aGUgU1RFIGJ5cGFz
cyBtb2RlLg0KDQpUaG91Z2h0cy9JZGVhcyB3ZWxjb21lLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoN
Cg==
