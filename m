Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36940D3C1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhIPH2F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 03:28:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3833 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPH2E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Sep 2021 03:28:04 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H97rF22wjz67PNJ;
        Thu, 16 Sep 2021 15:24:29 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 09:26:42 +0200
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 08:26:42 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Thu, 16 Sep 2021 08:26:41 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jon Nettleton <jon@solid-run.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXidEiKr58723PTUGGkSglF1QKPatlAmqAgDJmwoCAACN+gIAO55og
Date:   Thu, 16 Sep 2021 07:26:41 +0000
Message-ID: <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
In-Reply-To: <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.177]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIE5ldHRsZXRvbiBb
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAwNiBTZXB0ZW1iZXIgMjAyMSAyMDo1
MQ0KPiBUbzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gQ2M6IExvcmVu
em8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgTGF1
cmVudGl1IFR1ZG9yDQo+IDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJu
ZWwNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEFDUEkgRGV2ZWwg
TWFsaW5nIExpc3QNCj4gPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGludXggSU9NTVUN
Cj4gPGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTGludXhhcm0gPGxpbnV4YXJt
QGh1YXdlaS5jb20+Ow0KPiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz47IFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+Ow0KPiB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3
ZWkuY29tPjsgR3VvaGFuanVuIChIYW5qdW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+
OyBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBhcm0uY29tPjsgU2FtaQ0KPiBNdWphd2FyIDxT
YW1pLk11amF3YXJAYXJtLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47
DQo+IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NyAyLzldIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQgZm9yIFJNUiBub2RlIHBhcnNpbmcN
Cj4gDQpbLi4uXQ0KDQo+ID4gPg0KPiA+ID4gT24gdGhlIHByb3QgdmFsdWUgYXNzaWdubWVudCBi
YXNlZCBvbiB0aGUgcmVtYXBwaW5nIGZsYWcsIEknZCBsaWtlDQo+ID4gPiB0byBoZWFyIFJvYmlu
L0pvZXJnJ3Mgb3BpbmlvbiwgSSdkIGF2b2lkIGJlaW5nIGluIGEgc2l0dWF0aW9uIHdoZXJlDQo+
ID4gPiAibm9ybWFsbHkiIHRoaXMgd291bGQgd29yayBidXQgdGhlbiB3ZSBoYXZlIHRvIHF1aXJr
IGl0Lg0KPiA+ID4NCj4gPiA+IElzIHRoaXMgYSB2YWxpZCBhc3N1bXB0aW9uIF9hbHdheXNfID8N
Cj4gPg0KPiA+IE5vLiBDZXJ0YWlubHkgYXBwbHlpbmcgSU9NTVVfQ0FDSEUgd2l0aG91dCByZWZl
cmVuY2UgdG8gdGhlIGRldmljZSdzDQo+ID4gX0NDQSBhdHRyaWJ1dGUgb3IgaG93IENQVXMgbWF5
IGJlIGFjY2Vzc2luZyBhIHNoYXJlZCBidWZmZXIgY291bGQgbGVhZA0KPiA+IHRvIGEgbG9zcyBv
ZiBjb2hlcmVuY3kuIEF0IHdvcnN0LCBhcHBseWluZyBJT01NVV9NTUlPIHRvIGENCj4gPiBkZXZp
Y2UtcHJpdmF0ZSBidWZmZXIgKmNvdWxkKiBjYXVzZSB0aGUgZGV2aWNlIHRvIGxvc2UgY29oZXJl
bmN5IHdpdGgNCj4gPiBpdHNlbGYgaWYgdGhlIG1lbW9yeSB1bmRlcmx5aW5nIHRoZSBSTVIgbWF5
IGhhdmUgYWxsb2NhdGVkIGludG8gc3lzdGVtDQo+ID4gY2FjaGVzLiBOb3RlIHRoYXQgdGhlIGV4
cGVjdGVkIHVzZSBmb3Igbm9uLXJlbWFwcGFibGUgUk1ScyBpcyB0aGUNCj4gPiBkZXZpY2UgaG9s
ZGluZyBzb21lIHNvcnQgb2YgbG9uZy1saXZlZCBwcml2YXRlIGRhdGEgaW4gc3lzdGVtIFJBTSAt
DQo+ID4gdGhlIE1TSSBkb29yYmVsbCB0cmljayBpcyBmYXIgbW9yZSBvZiBhIG5pY2hlIGhhY2sg
cmVhbGx5Lg0KPiA+DQo+ID4gQXQgdGhlIHZlcnkgbGVhc3QgSSB0aGluayB3ZSBuZWVkIHRvIHJl
ZmVyIHRvIHRoZSBkZXZpY2UncyBtZW1vcnkNCj4gPiBhY2Nlc3MgcHJvcGVydGllcyBoZXJlLg0K
PiA+DQo+ID4gSm9uLCBMYXVyZW50aXUgLSBob3cgZG8gUk1ScyBjb3JyZXNwb25kIHRvIHRoZSBF
RkkgbWVtb3J5IG1hcCBvbiB5b3VyDQo+ID4gZmlybXdhcmU/IEknbSBzdGFydGluZyB0byB0aGlu
ayB0aGF0IGFzIGxvbmcgYXMgdGhlIHVuZGVybHlpbmcgbWVtb3J5DQo+ID4gaXMgZGVzY3JpYmVk
IGFwcHJvcHJpYXRlbHkgdGhlcmUgdGhlbiB3ZSBzaG91bGQgYmUgYWJsZSB0byBpbmZlcg0KPiA+
IGNvcnJlY3QgYXR0cmlidXRlcyBmcm9tIHRoZSBFRkkgbWVtb3J5IHR5cGUgYW5kIGZsYWdzLg0K
PiANCj4gVGhlIGRldmljZXMgYXJlIGFsbCBjYWNoZSBjb2hlcmVudCBhbmQgbWFya2VkIGFzIF9D
Q0EsIDEuICBUaGUgTWVtb3J5DQo+IHJlZ2lvbnMgYXJlIGluIHRoZSB2aXJ0IHRhYmxlIGFzIEFS
TV9NRU1PUllfUkVHSU9OX0FUVFJJQlVURV9ERVZJQ0UuDQo+IA0KPiBUaGUgY3VycmVudCBjaGlj
a2VuIGFuZCBlZ2cgcHJvYmxlbSB3ZSBoYXZlIGlzIHRoYXQgZHVyaW5nIHRoZSBmc2wtbWMtYnVz
DQo+IGluaXRpYWxpemF0aW9uIHdlIGNhbGwNCj4gDQo+IGVycm9yID0gYWNwaV9kbWFfY29uZmln
dXJlX2lkKCZwZGV2LT5kZXYsIERFVl9ETUFfQ09IRVJFTlQsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbWNfc3RyZWFtX2lkKTsNCj4gDQo+IHdoaWNo
IGdldHMgZGVmZXJyZWQgYmVjYXVzZSB0aGUgU01NVSBoYXMgbm90IGJlZW4gaW5pdGlhbGl6ZWQg
eWV0LiBUaGVuIHdlDQo+IGluaXRpYWxpemUgdGhlIFJNUiB0YWJsZXMgYnV0IHRoZXJlIGlzIG5v
IGRldmljZSByZWZlcmVuY2UgdGhlcmUgdG8gYmUgYWJsZSB0bw0KPiBxdWVyeSBkZXZpY2UgcHJv
cGVydGllcywgb25seSB0aGUgc3RyZWFtIGlkLiAgQWZ0ZXIgdGhlIElPUlQgdGFibGVzIGFyZSBw
YXJzZWQNCj4gYW5kIHRoZSBTTU1VIGlzIHNldHVwLCBvbiB0aGUgc2Vjb25kIGRldmljZSBwcm9i
ZSB3ZSBhc3NvY2lhdGUgZXZlcnl0aGluZw0KPiBiYXNlZCBvbiB0aGUgc3RyZWFtIGlkIGFuZCB0
aGUgZnNsLW1jLWJ1cyBkZXZpY2UgaXMgYWJsZSB0byBjbGFpbSBpdHMgMS0xIERNQQ0KPiBtYXBw
aW5ncy4NCg0KQ2FuIHdlIHNvbHZlIHRoaXMgb3JkZXIgcHJvYmxlbSBieSBkZWxheWluZyB0aGUg
aW9tbXVfYWxsb2NfcmVzdl9yZWdpb24oKQ0KdG8gdGhlIGlvbW11X2RtYV9nZXRfcm1yX3Jlc3Zf
cmVnaW9ucyhkZXYsIGxpc3QpID8gV2UgY291bGQgaW52b2tlDQpkZXZpY2VfZ2V0X2RtYV9hdHRy
KCkgZnJvbSB0aGVyZSB3aGljaCBJIGJlbGlldmUgd2lsbCByZXR1cm4gdGhlIF9DQ0EgYXR0cmli
dXRlLg0KDQpPciBpcyB0aGF0IHN0aWxsIGVhcmx5IHRvIGludm9rZSB0aGF0Pw0KDQpUaGFua3Ms
DQpTaGFtZWVyDQoNCj4gY2F0IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8wL3Jlc2VydmVkX3Jl
Z2lvbnMNCj4gMHgwMDAwMDAwMDAxMDAwMDAwIDB4MDAwMDAwMDAxMGZmZmZmZiBkaXJlY3QtcmVs
YXhhYmxlDQo+IDB4MDAwMDAwMDAwODAwMDAwMCAweDAwMDAwMDAwMDgwZmZmZmYgbXNpDQo+IDB4
MDAwMDAwMDgwYzAwMDAwMCAweDAwMDAwMDA4MWJmZmZmZmYgZGlyZWN0LXJlbGF4YWJsZQ0KPiAw
eDAwMDAwMDFjMDAwMDAwMDAgMHgwMDAwMDAxYzAwMWZmZmZmIGRpcmVjdC1yZWxheGFibGUNCj4g
MHgwMDAwMDAyMDgwMDAwMDAwIDB4MDAwMDAwMjA5ZmZmZmZmZiBkaXJlY3QtcmVsYXhhYmxlDQo+
IA0KPiAtSm9uDQo+IA0KPiA+DQo+ID4gUm9iaW4uDQo=
