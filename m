Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4503840D472
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhIPI1k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 04:27:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19986 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhIPI1j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Sep 2021 04:27:39 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H996q084QzbmXv;
        Thu, 16 Sep 2021 16:22:11 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 16:26:17 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 16:26:16 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Thu, 16 Sep 2021 09:26:14 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jon Nettleton <jon@solid-run.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXidEiKr58723PTUGGkSglF1QKPatlAmqAgDJmwoCAACN+gIAO55oggAAG1QCAABhrQA==
Date:   Thu, 16 Sep 2021 08:26:14 +0000
Message-ID: <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
 <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
 <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
In-Reply-To: <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
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
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAxNiBTZXB0ZW1iZXIgMjAyMSAwODo1
Mg0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNv
bT47IExvcmVuem8gUGllcmFsaXNpDQo+IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgTGF1
cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJu
ZWwgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEFDUEkgRGV2ZWwgTWFs
aW5nDQo+IExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGludXggSU9NTVUNCj4g
PGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhi
eXRlcy5vcmc+OyBXaWxsDQo+IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgd2FuZ2h1aXFpYW5n
IDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47DQo+IEd1b2hhbmp1biAoSGFuanVuIEd1bykgPGd1
b2hhbmp1bkBodWF3ZWkuY29tPjsgU3RldmVuIFByaWNlDQo+IDxzdGV2ZW4ucHJpY2VAYXJtLmNv
bT47IFNhbWkgTXVqYXdhciA8U2FtaS5NdWphd2FyQGFybS5jb20+OyBFcmljDQo+IEF1Z2VyIDxl
cmljLmF1Z2VyQHJlZGhhdC5jb20+OyB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi85XSBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0IGZv
ciBSTVIgbm9kZSBwYXJzaW5nDQo+IA0KPiBPbiBUaHUsIFNlcCAxNiwgMjAyMSBhdCA5OjI2IEFN
IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSm9uIE5ldHRsZXRvbiBbbWFpbHRvOmpvbkBzb2xpZC1y
dW4uY29tXQ0KPiA+ID4gU2VudDogMDYgU2VwdGVtYmVyIDIwMjEgMjA6NTENCj4gPiA+IFRvOiBS
b2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+ID4gQ2M6IExvcmVuem8gUGll
cmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgU2hhbWVlcmFsaQ0KPiA+ID4gS29s
b3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IExhdXJl
bnRpdQ0KPiA+ID4gVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPjsgbGludXgtYXJtLWtl
cm5lbA0KPiA+ID4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEFDUEkg
RGV2ZWwgTWFsaW5nIExpc3QNCj4gPiA+IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IExp
bnV4IElPTU1VDQo+ID4gPiA8aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+OyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+ID4gPiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5
dGVzLm9yZz47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ow0KPiA+ID4gd2FuZ2h1aXFp
YW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4g
PiA+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFy
bS5jb20+OyBTYW1pDQo+ID4gPiBNdWphd2FyIDxTYW1pLk11amF3YXJAYXJtLmNvbT47IEVyaWMg
QXVnZXINCj4gPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47DQo+ID4gPiB5YW5neWljb25nIDx5YW5n
eWljb25nQGh1YXdlaS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDIvOV0gQUNQ
SS9JT1JUOiBBZGQgc3VwcG9ydCBmb3IgUk1SIG5vZGUNCj4gPiA+IHBhcnNpbmcNCj4gPiA+DQo+
ID4gWy4uLl0NCj4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gdGhlIHByb3QgdmFsdWUgYXNz
aWdubWVudCBiYXNlZCBvbiB0aGUgcmVtYXBwaW5nIGZsYWcsIEknZA0KPiA+ID4gPiA+IGxpa2Ug
dG8gaGVhciBSb2Jpbi9Kb2VyZydzIG9waW5pb24sIEknZCBhdm9pZCBiZWluZyBpbiBhDQo+ID4g
PiA+ID4gc2l0dWF0aW9uIHdoZXJlICJub3JtYWxseSIgdGhpcyB3b3VsZCB3b3JrIGJ1dCB0aGVu
IHdlIGhhdmUgdG8gcXVpcmsNCj4gaXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJcyB0aGlzIGEg
dmFsaWQgYXNzdW1wdGlvbiBfYWx3YXlzXyA/DQo+ID4gPiA+DQo+ID4gPiA+IE5vLiBDZXJ0YWlu
bHkgYXBwbHlpbmcgSU9NTVVfQ0FDSEUgd2l0aG91dCByZWZlcmVuY2UgdG8gdGhlDQo+ID4gPiA+
IGRldmljZSdzIF9DQ0EgYXR0cmlidXRlIG9yIGhvdyBDUFVzIG1heSBiZSBhY2Nlc3NpbmcgYSBz
aGFyZWQNCj4gPiA+ID4gYnVmZmVyIGNvdWxkIGxlYWQgdG8gYSBsb3NzIG9mIGNvaGVyZW5jeS4g
QXQgd29yc3QsIGFwcGx5aW5nDQo+ID4gPiA+IElPTU1VX01NSU8gdG8gYSBkZXZpY2UtcHJpdmF0
ZSBidWZmZXIgKmNvdWxkKiBjYXVzZSB0aGUgZGV2aWNlIHRvDQo+ID4gPiA+IGxvc2UgY29oZXJl
bmN5IHdpdGggaXRzZWxmIGlmIHRoZSBtZW1vcnkgdW5kZXJseWluZyB0aGUgUk1SIG1heQ0KPiA+
ID4gPiBoYXZlIGFsbG9jYXRlZCBpbnRvIHN5c3RlbSBjYWNoZXMuIE5vdGUgdGhhdCB0aGUgZXhw
ZWN0ZWQgdXNlIGZvcg0KPiA+ID4gPiBub24tcmVtYXBwYWJsZSBSTVJzIGlzIHRoZSBkZXZpY2Ug
aG9sZGluZyBzb21lIHNvcnQgb2YgbG9uZy1saXZlZA0KPiA+ID4gPiBwcml2YXRlIGRhdGEgaW4g
c3lzdGVtIFJBTSAtIHRoZSBNU0kgZG9vcmJlbGwgdHJpY2sgaXMgZmFyIG1vcmUgb2YgYSBuaWNo
ZQ0KPiBoYWNrIHJlYWxseS4NCj4gPiA+ID4NCj4gPiA+ID4gQXQgdGhlIHZlcnkgbGVhc3QgSSB0
aGluayB3ZSBuZWVkIHRvIHJlZmVyIHRvIHRoZSBkZXZpY2UncyBtZW1vcnkNCj4gPiA+ID4gYWNj
ZXNzIHByb3BlcnRpZXMgaGVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gSm9uLCBMYXVyZW50aXUgLSBo
b3cgZG8gUk1ScyBjb3JyZXNwb25kIHRvIHRoZSBFRkkgbWVtb3J5IG1hcCBvbg0KPiA+ID4gPiB5
b3VyIGZpcm13YXJlPyBJJ20gc3RhcnRpbmcgdG8gdGhpbmsgdGhhdCBhcyBsb25nIGFzIHRoZQ0K
PiA+ID4gPiB1bmRlcmx5aW5nIG1lbW9yeSBpcyBkZXNjcmliZWQgYXBwcm9wcmlhdGVseSB0aGVy
ZSB0aGVuIHdlIHNob3VsZA0KPiA+ID4gPiBiZSBhYmxlIHRvIGluZmVyIGNvcnJlY3QgYXR0cmli
dXRlcyBmcm9tIHRoZSBFRkkgbWVtb3J5IHR5cGUgYW5kIGZsYWdzLg0KPiA+ID4NCj4gPiA+IFRo
ZSBkZXZpY2VzIGFyZSBhbGwgY2FjaGUgY29oZXJlbnQgYW5kIG1hcmtlZCBhcyBfQ0NBLCAxLiAg
VGhlDQo+ID4gPiBNZW1vcnkgcmVnaW9ucyBhcmUgaW4gdGhlIHZpcnQgdGFibGUgYXMNCj4gQVJN
X01FTU9SWV9SRUdJT05fQVRUUklCVVRFX0RFVklDRS4NCj4gPiA+DQo+ID4gPiBUaGUgY3VycmVu
dCBjaGlja2VuIGFuZCBlZ2cgcHJvYmxlbSB3ZSBoYXZlIGlzIHRoYXQgZHVyaW5nIHRoZQ0KPiA+
ID4gZnNsLW1jLWJ1cyBpbml0aWFsaXphdGlvbiB3ZSBjYWxsDQo+ID4gPg0KPiA+ID4gZXJyb3Ig
PSBhY3BpX2RtYV9jb25maWd1cmVfaWQoJnBkZXYtPmRldiwgREVWX0RNQV9DT0hFUkVOVCwNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbWNfc3Ry
ZWFtX2lkKTsNCj4gPiA+DQo+ID4gPiB3aGljaCBnZXRzIGRlZmVycmVkIGJlY2F1c2UgdGhlIFNN
TVUgaGFzIG5vdCBiZWVuIGluaXRpYWxpemVkIHlldC4NCj4gPiA+IFRoZW4gd2UgaW5pdGlhbGl6
ZSB0aGUgUk1SIHRhYmxlcyBidXQgdGhlcmUgaXMgbm8gZGV2aWNlIHJlZmVyZW5jZQ0KPiA+ID4g
dGhlcmUgdG8gYmUgYWJsZSB0byBxdWVyeSBkZXZpY2UgcHJvcGVydGllcywgb25seSB0aGUgc3Ry
ZWFtIGlkLg0KPiA+ID4gQWZ0ZXIgdGhlIElPUlQgdGFibGVzIGFyZSBwYXJzZWQgYW5kIHRoZSBT
TU1VIGlzIHNldHVwLCBvbiB0aGUNCj4gPiA+IHNlY29uZCBkZXZpY2UgcHJvYmUgd2UgYXNzb2Np
YXRlIGV2ZXJ5dGhpbmcgYmFzZWQgb24gdGhlIHN0cmVhbSBpZA0KPiA+ID4gYW5kIHRoZSBmc2wt
bWMtYnVzIGRldmljZSBpcyBhYmxlIHRvIGNsYWltIGl0cyAxLTEgRE1BIG1hcHBpbmdzLg0KPiA+
DQo+ID4gQ2FuIHdlIHNvbHZlIHRoaXMgb3JkZXIgcHJvYmxlbSBieSBkZWxheWluZyB0aGUNCj4g
PiBpb21tdV9hbGxvY19yZXN2X3JlZ2lvbigpIHRvIHRoZSBpb21tdV9kbWFfZ2V0X3Jtcl9yZXN2
X3JlZ2lvbnMoZGV2LA0KPiA+IGxpc3QpID8gV2UgY291bGQgaW52b2tlDQo+ID4gZGV2aWNlX2dl
dF9kbWFfYXR0cigpIGZyb20gdGhlcmUgd2hpY2ggSSBiZWxpZXZlIHdpbGwgcmV0dXJuIHRoZSBf
Q0NBDQo+IGF0dHJpYnV0ZS4NCj4gPg0KPiA+IE9yIGlzIHRoYXQgc3RpbGwgZWFybHkgdG8gaW52
b2tlIHRoYXQ/DQo+IA0KPiBUaGF0IGxvb2tzIGxpa2UgaXQgc2hvdWxkIHdvcmsuIERvIHdlIHRo
ZW4gYWxzbyBuZWVkIHRvIHBhcnNlIHRocm91Z2ggdGhlDQo+IFZpcnR1YWxNZW1vcnlUYWJsZSBt
YXRjaGluZyB0aGUgc3RhcnQgYW5kIGVuZCBhZGRyZXNzZXMgdG8gZGV0ZXJtaW5lIHRoZQ0KPiBv
dGhlciBtZW1vcnkgYXR0cmlidXRlcyBsaWtlIE1NSU8/DQoNClllcy4gQnV0IHRoYXQgbG9va3Mg
dHJpY2t5IGFzIEkgY2FuJ3QgZmluZCB0aGF0IHJlYWRpbHkgYXZhaWxhYmxlIG9uIEFybSwgbGlr
ZSB0aGUNCmVmaV9tZW1fYXR0cmlidXRlcygpLiBJIHdpbGwgdGFrZSBhIGxvb2suDQoNClBsZWFz
ZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBvbmUgb3IgYW55IG90aGVyIGVhc3kgd2F5IHRvIHJl
dHJpZXZlIGl0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4gDQo+IC1Kb24NCj4gDQo+ID4NCj4g
PiBUaGFua3MsDQo+ID4gU2hhbWVlcg0KPiA+DQo+ID4gPiBjYXQgL3N5cy9rZXJuZWwvaW9tbXVf
Z3JvdXBzLzAvcmVzZXJ2ZWRfcmVnaW9ucw0KPiA+ID4gMHgwMDAwMDAwMDAxMDAwMDAwIDB4MDAw
MDAwMDAxMGZmZmZmZiBkaXJlY3QtcmVsYXhhYmxlDQo+ID4gPiAweDAwMDAwMDAwMDgwMDAwMDAg
MHgwMDAwMDAwMDA4MGZmZmZmIG1zaQ0KPiA+ID4gMHgwMDAwMDAwODBjMDAwMDAwIDB4MDAwMDAw
MDgxYmZmZmZmZiBkaXJlY3QtcmVsYXhhYmxlDQo+ID4gPiAweDAwMDAwMDFjMDAwMDAwMDAgMHgw
MDAwMDAxYzAwMWZmZmZmIGRpcmVjdC1yZWxheGFibGUNCj4gPiA+IDB4MDAwMDAwMjA4MDAwMDAw
MCAweDAwMDAwMDIwOWZmZmZmZmYgZGlyZWN0LXJlbGF4YWJsZQ0KPiA+ID4NCj4gPiA+IC1Kb24N
Cj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFJvYmluLg0K
