Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DEE4293A5
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhJKPoY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 11:44:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24242 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbhJKPoW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Oct 2021 11:44:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSjgr6NBGz8tYr;
        Mon, 11 Oct 2021 23:41:12 +0800 (CST)
Received: from dggpemm100006.china.huawei.com (7.185.36.196) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 23:42:17 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 23:42:16 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 16:42:14 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jon Nettleton <jon@solid-run.com>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
Thread-Topic: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated
 with a dev
Thread-Index: AQHXidFJPtitnW05ZU6HeLs3tvFT7qvJZyyAgAEtMACAA6jKAIAAG4sQ
Date:   Mon, 11 Oct 2021 15:42:14 +0000
Message-ID: <9a84c9d20094403ea5aea53d6f6c304f@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
 <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
 <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
 <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
In-Reply-To: <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDExIE9jdG9iZXIgMjAyMSAxNjow
MQ0KPiBUbzogSm9uIE5ldHRsZXRvbiA8am9uQHNvbGlkLXJ1bi5jb20+DQo+IENjOiBTaGFtZWVy
YWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Ow0KPiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBBQ1BJIERldmVsIE1hbGluZw0KPiBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IElPTU1VDQo+IDxpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz47IExp
bnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gTG9yZW56byBQaWVyYWxpc2kgPGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb20+OyBKb2VyZyBSb2VkZWwNCj4gPGpvcm9AOGJ5dGVzLm9yZz47
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyB3YW5naHVpcWlhbmcNCj4gPHdhbmdodWlx
aWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuIChIYW5qdW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1
YXdlaS5jb20+OyBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBhcm0uY29tPjsgU2FtaQ0KPiBN
dWphd2FyIDxTYW1pLk11amF3YXJAYXJtLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT47DQo+IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NyA5LzldIGlvbW11L2RtYTogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMg
YXNzb2NpYXRlZA0KPiB3aXRoIGEgZGV2DQo+IA0KPiBPbiAyMDIxLTEwLTA5IDA4OjA3LCBKb24g
TmV0dGxldG9uIHdyb3RlOg0KPiA+IE9uIEZyaSwgT2N0IDgsIDIwMjEgYXQgMzoxMCBQTSBSb2Jp
biBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gT24g
MjAyMS0wOC0wNSAwOTowNywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPj4+IEdldCBBQ1BJ
IElPUlQgUk1SIHJlZ2lvbnMgYXNzb2NpYXRlZCB3aXRoIGEgZGV2IHJlc2VydmVkDQo+ID4+PiBz
byB0aGF0IHRoZXJlIGlzIGEgdW5pdHkgbWFwcGluZyBmb3IgdGhlbSBpbiBTTU1VLg0KPiA+Pg0K
PiA+PiBUaGlzIGZlZWxzIGxpa2UgbW9zdCBvZiBpdCBiZWxvbmdzIGluIHRoZSBJT1JUIGNvZGUg
cmF0aGVyIHRoYW4NCj4gPj4gaW9tbXUtZG1hICh3aGljaCBzaG91bGQgc2F2ZSB0aGUgdGVtcG9y
YXJ5IGxpc3QgY29weSBhcyB3ZWxsKS4NCj4gPg0KPiA+IFNlZSBwcmV2aW91cyBjb21tZW50LiAg
VGhlIG9yaWdpbmFsIGludGVudCB3YXMgZm9yIGRldmljZS10cmVlIHRvIGFsc28NCj4gPiBiZSBh
YmxlIHRvIHVzZSB0aGVzZSBtZWNoYW5pc21zIHRvIGNyZWF0ZSBSTVIncyBhbmQgc3VwcG9ydCB0
aGVtDQo+ID4gaW4gdGhlIFNNTVUuDQo+IA0KPiBDYW4geW91IGNsYXJpZnkgaG93IGNvZGUgYmVo
aW5kIGFuICJpZiAoIWlzX29mX25vZGUoLi4uKSkiIGNoZWNrDQo+IGFsb25nc2lkZSBvdGhlciBJ
T1JULXNwZWNpZmljIGNvZGUgaXMgZXhwZWN0ZWQgdG8gYmUgdXNlZnVsIGZvciBEVD8NCj4gDQo+
IFllcywgaW9tbXVfZG1hX2dldF9yZXN2X3JlZ2lvbnMoKSBpdHNlbGYgd2FudHMgdG8gZW5kIHVw
IHNlcnZpbmcgYXMgYW4NCj4gYWJzdHJhY3Rpb24gbGF5ZXIsIGJ1dCB0aGF0IHN0aWxsIGRvZXNu
J3QgbWVhbiBpdCBoYXMgdG8gZG8gbXVjaCBtb3JlDQo+IHRoYW4gZGlzcGF0Y2ggaW50byBmaXJt
d2FyZS1zcGVjaWZpYyBiYWNrZW5kcyBhcyBhcHByb3ByaWF0ZS4NCg0KKFJlc2VuZGluZyBhcyBJ
IGFjY2lkZW50bHkgcmVwbGllZCBlYXJsaWVyIGZyb20gb3VyIGludGVybmFsIE1MIGlkLiBTb3Jy
eSkNCg0KVGhlIHdheSBJIHRob3VnaHQgYWJvdXQgaXMgYXMgYmVsb3csDQoNCjEuICBpb21tdV9k
bWFfZ2V0X3Jlc3ZfcmVnaW9ucygpIHdpbGwgaW52b2tlIHRoZSBjb21tb24gaW9tbXVfZG1hX2dl
dF9ybXJfcmVzdl9yZWdpb25zKCkuDQogICAgWWVzLCB0aGUgaWYgKCFpc19vZl9ub2RlKC4uLikp
IGlzIG5vdCByZXF1aXJlZCBoZXJlLg0KMi4gIGlvbW11X2RtYV9nZXRfcm1yX3Jlc3ZfcmVnaW9u
cygpIGNhbGxzIGlvbW11X2RtYV9nZXRfcm1ycygpLg0KICAgIGlvbW11X2RtYV9nZXRfcm1ycygp
IGhhcyB0aGUgICghaXNfb2Zfbm9kZSguLi4pKSBjaGVjayB0byBjYWxsIGludG8gSU9SVCBvciBE
VCBzcGVjaWZpYyBmdW5jdGlvbnMNCiAgICB0byByZXRyaWV2ZSB0aGUgUk1SIHJlc2VydmUgcmVn
aW9ucyBhc3NvY2lhdGVkIHdpdGggYSBnaXZlbiBpb21tdV9md25vZGUuDQozLiAgVGhlIGNvbW1v
biBpb21tdV9kbWFfZ2V0X3Jtcl9yZXN2X3JlZ2lvbnMoKSBmdXJ0aGVyIGNoZWNrcyBmb3IgUENJ
IGhvc3QgcHJlc2VydmVfY29uZmlnDQogICAgYW5kIHdoZXRoZXIgdGhlIHJldHVybmVkIFJNUiBs
aXN0IGFjdHVhbGx5IGhhcyBhbnkgZGV2IHNwZWNpZmljIHJlZ2lvbiB0byByZXNlcnZlIG9yIG5v
dC4NCg0KU28gdGhlIG9ubHkgZmlybXdhcmUgc3BlY2lmaWMgYmFja2VuZCBpcyBoYW5kbGVkIGlu
c2lkZSB0aGUgaW9tbXVfZG1hX2dldF9ybXJzKCkgYW5kIHRoYXQgaXMgYWxzbyBjYWxsZWQNCmZy
b20gdGhlIFNNTVUgZHJpdmVyIHByb2JlIHRvIGluc3RhbGwgYnlwYXNzIFNJRHMuDQoNCkFueXdh
eSwgaWYgdGhlIGV2ZW50dWFsIERUIGltcGxlbWVudGF0aW9uIG9yIGZ1cnRoZXIgSU9SVCBzcGVj
IGNoYW5nZXMgbWFrZXMgdGhpcyBhYnN0cmFjdGlvbg0KaXJyZWxldmFudCBJIGFtIE9rIHRvIG1v
dmUgdGhpcyBpbnRvIHRoZSBJT1JUIGNvZGUuDQoNClRoYW5rcywNClNoYW1lZXINCg==
