Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9923F3B7F60
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhF3IxB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 04:53:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhF3IxA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 04:53:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GFFMv58LFzZp54;
        Wed, 30 Jun 2021 16:47:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:50:30 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:50:28 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Wed, 30 Jun 2021 09:50:26 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jon Nettleton <jon@solid-run.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Steven Price" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Topic: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Index: AQHXUIyLvua7xjhPQkeDex9n58702KsTV/iAgBdgBoCAAGnfAIAAMyCAgAEihEA=
Date:   Wed, 30 Jun 2021 08:50:26 +0000
Message-ID: <d2223be42ce9497da8c02a87558beab6@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
 <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
 <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
In-Reply-To: <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIE5ldHRsZXRvbiBb
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAyOSBKdW5lIDIwMjEgMTc6MjYNCj4g
VG86IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+DQo+IENjOiBTaGFtZWVyYWxp
IEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0K
PiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
OyBBQ1BJIERldmVsIE1hbGluZw0KPiBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMaW51eGFybQ0KPiA8bGludXhhcm1A
aHVhd2VpLmNvbT47IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+OyBHdW9oYW5q
dW4NCj4gKEhhbmp1biBHdW8pIDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHlhbmd5aWNvbmcNCj4g
PHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47IFNhbWkuTXVqYXdhckBhcm0uY29tOyB3YW5naHVpcWlh
bmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
IDcvOF0gaW9tbXUvYXJtLXNtbXU6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZA0KPiBpbnN0
YWxsIGJ5cGFzcyBTTVINCj4gDQoNClsuLi5dDQogDQo+IFNoYW1lZXIsDQo+IA0KPiBTb3JyeSBm
b3IgdGhlIGRlbGF5cy4gIEhlcmUgaXMgYSBkaWZmIG9mIHRoZSBjaGFuZ2VzIHRoYXQgc2hvdWxk
DQo+IGFkZHJlc3MgdGhlIGlzc3VlcyBwb2ludGVkIG91dCBieSBSb2JpbiwNCj4gSSBoYXZlIHRl
c3RlZCB0aGF0IHRoaXMgd29ya3MgYXMgZXhwZWN0ZWQgb24gbXkgSG9uZXlDb21iIExYMjE2MEEu
DQoNCk9rLiBUaGFua3MgZm9yIHRoYXQuDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11L2FybS1zbW11LmMNCj4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9h
cm0tc21tdS5jDQo+IGluZGV4IGFiN2I5ZGI3NzYyNS4uYTM1OGJkMzI2ZDBiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jDQo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMNCj4gQEAgLTIwNjgsMjkgKzIwNjgsMjEg
QEAgc3RhdGljIHZvaWQNCj4gYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3NtcihzdHJ1Y3Qg
YXJtX3NtbXVfZGV2aWNlICpzbW11KQ0KPiAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgcm1yX2xp
c3Q7DQo+ICAgICAgICAgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICplOw0KPiAgICAgICAgIGlu
dCBpLCBjbnQgPSAwOw0KPiAtICAgICAgIHUzMiBzbXI7DQo+ICAgICAgICAgdTMyIHJlZzsNCj4g
DQo+ICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJnJtcl9saXN0KTsNCj4gICAgICAgICBpZiAoaW9t
bXVfZG1hX2dldF9ybXJzKGRldl9md25vZGUoc21tdS0+ZGV2KSwgJnJtcl9saXN0KSkNCj4gICAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IC0gICAgICAgcmVnID0gYXJtX3NtbXVfZ3IwX3Jl
YWQoc21tdSwgQVJNX1NNTVVfR1IwX3NDUjApOw0KPiArICAgICAgIC8qIFJhdGhlciB0aGFuIHRy
eWluZyB0byBsb29rIGF0IGV4aXN0aW5nIG1hcHBpbmdzIHRoYXQNCj4gKyAgICAgICAgKiBhcmUg
c2V0dXAgYnkgdGhlIGZpcm13YXJlIGFuZCB0aGVuIGludmFsaWRhdGUgdGhlIG9uZXMNCj4gKyAg
ICAgICAgKiB0aGF0IGRvIG5vIGhhdmUgbWF0Y2hpbmcgUk1SIGVudHJpZXMsIGp1c3QgZGlzYWJs
ZSB0aGUNCj4gKyAgICAgICAgKiBTTU1VIHVudGlsIGl0IGdldHMgZW5hYmxlZCBhZ2FpbiBpbiB0
aGUgcmVzZXQgcm91dGluZS4NCj4gKyAgICAgICAgKi8NCj4gDQo+IC0gICAgICAgaWYgKChyZWcg
JiBBUk1fU01NVV9zQ1IwX1VTRkNGRykgJiYgIShyZWcgJg0KPiBBUk1fU01NVV9zQ1IwX0NMSUVO
VFBEKSkgew0KPiAtICAgICAgICAgICAgICAgLyoNCj4gLSAgICAgICAgICAgICAgICAqIFNNTVUg
aXMgYWxyZWFkeSBlbmFibGVkIGFuZCBkaXNhbGxvd2luZyBieXBhc3MsIHNvDQo+IHByZXNlcnZl
DQo+IC0gICAgICAgICAgICAgICAgKiB0aGUgZXhpc3RpbmcgU01Scw0KPiAtICAgICAgICAgICAg
ICAgICovDQo+IC0gICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgc21tdS0+bnVtX21hcHBp
bmdfZ3JvdXBzOyBpKyspIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc21yID0gYXJtX3Nt
bXVfZ3IwX3JlYWQoc21tdSwNCj4gQVJNX1NNTVVfR1IwX1NNUihpKSk7DQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGlmICghRklFTERfR0VUKEFSTV9TTU1VX1NNUl9WQUxJRCwgc21yKSkNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgc21tdS0+c21yc1tpXS5pZCA9DQo+IEZJRUxEX0dFVChBUk1fU01NVV9TTVJf
SUQsIHNtcik7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0ubWFzayA9
DQo+IEZJRUxEX0dFVChBUk1fU01NVV9TTVJfTUFTSywgc21yKTsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgc21tdS0+c21yc1tpXS52YWxpZCA9IHRydWU7DQo+IC0gICAgICAgICAgICAgICB9
DQo+IC0gICAgICAgfQ0KPiArICAgICAgIHJlZyA9IGFybV9zbW11X2dyMF9yZWFkKHNtbXUsIEFS
TV9TTU1VX0dSMF9zQ1IwKTsNCj4gKyAgICAgICByZWcgJj0gfkFSTV9TTU1VX3NDUjBfQ0xJRU5U
UEQ7DQo+ICsgICAgICAgYXJtX3NtbXVfZ3IwX3dyaXRlKHNtbXUsIEFSTV9TTU1VX0dSMF9zQ1Iw
LCByZWcpOw0KPiANCj4gICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZybXJfbGlzdCwg
bGlzdCkgew0KPiAgICAgICAgICAgICAgICAgdTMyIHNpZCA9IGUtPmZ3X2RhdGEucm1yLnNpZDsN
Cj4gQEAgLTIxMDAsMjUgKzIwOTIsMTYgQEAgc3RhdGljIHZvaWQNCj4gYXJtX3NtbXVfcm1yX2lu
c3RhbGxfYnlwYXNzX3NtcihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11KQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICAgICAgICAgIGlmIChzbW11LT5z
MmNyc1tpXS5jb3VudCA9PSAwKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPnNt
cnNbaV0uaWQgPSBzaWQ7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0u
bWFzayA9IH4wOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzbW11LT5zbXJzW2ldLm1hc2sg
PSAwOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzbW11LT5zbXJzW2ldLnZhbGlkID0gdHJ1
ZTsNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIHNtbXUtPnMyY3JzW2ld
LmNvdW50Kys7DQo+ICAgICAgICAgICAgICAgICBzbW11LT5zMmNyc1tpXS50eXBlID0gUzJDUl9U
WVBFX0JZUEFTUzsNCj4gICAgICAgICAgICAgICAgIHNtbXUtPnMyY3JzW2ldLnByaXZjZmcgPSBT
MkNSX1BSSVZDRkdfREVGQVVMVDsNCj4gLSAgICAgICAgICAgICAgIHNtbXUtPnMyY3JzW2ldLmNi
bmR4ID0gMHhmZjsNCj4gDQo+ICAgICAgICAgICAgICAgICBjbnQrKzsNCj4gICAgICAgICB9DQo+
IA0KPiAtICAgICAgIGlmICgocmVnICYgQVJNX1NNTVVfc0NSMF9VU0ZDRkcpICYmICEocmVnICYN
Cj4gQVJNX1NNTVVfc0NSMF9DTElFTlRQRCkpIHsNCj4gLSAgICAgICAgICAgICAgIC8qIFJlbW92
ZSB0aGUgdmFsaWQgYml0IGZvciB1bnVzZWQgU01ScyAqLw0KPiAtICAgICAgICAgICAgICAgZm9y
IChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5nX2dyb3VwczsgaSsrKSB7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGlmIChzbW11LT5zMmNyc1tpXS5jb3VudCA9PSAwKQ0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPnNtcnNbaV0udmFsaWQgPSBmYWxzZTsNCj4g
LSAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICB9DQo+IC0NCj4gICAgICAgICBkZXZfbm90aWNl
KHNtbXUtPmRldiwgIlx0cHJlc2VydmVkICVkIGJvb3QgbWFwcGluZyVzXG4iLCBjbnQsDQo+ICAg
ICAgICAgICAgICAgICAgICBjbnQgPT0gMSA/ICIiIDogInMiKTsNCj4gICAgICAgICBpb21tdV9k
bWFfcHV0X3JtcnMoZGV2X2Z3bm9kZShzbW11LT5kZXYpLCAmcm1yX2xpc3QpOw0KPiANCj4gUGxl
YXNlIGluY2x1ZGUgdGhhdCBpbiB5b3VyIG5leHQgcGF0Y2ggc2VyaWVzLiAgTGV0IG1lIGtub3cg
aWYgeW91DQo+IHdhbnQgbWUgdG8gc2VuZCB5b3UgdGhlIHBhdGNoIGRpcmVjdA0KPiBvZmYgdGhl
IGxpc3QuDQoNCk5vIHByb2JsZW0sIEkgd2lsbCB0YWtlIHRoaXMgaW4gbmV4dC4NCg0KVGhhbmtz
LA0KU2hhbWVlcg0K
