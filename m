Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF303D6FB6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhG0GwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 02:52:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7878 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbhG0GwC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2021 02:52:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYnS01DHQz80CB;
        Tue, 27 Jul 2021 14:48:16 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:52:00 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:51:58 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Tue, 27 Jul 2021 07:51:56 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHXeh1vg51cV9IdVUizwG8vunPk8atKQ7KAgAwuDYA=
Date:   Tue, 27 Jul 2021 06:51:56 +0000
Message-ID: <014a451d00304b80b3de700817d688de@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
In-Reply-To: <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.57]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhdXJlbnRpdSBUdWRvciBb
bWFpbHRvOmxhdXJlbnRpdS50dWRvckBueHAuY29tXQ0KPiBTZW50OiAxOSBKdWx5IDIwMjEgMTQ6
NDYNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnDQo+IENjOiBqb25Ac29saWQtcnVuLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1
YXdlaS5jb20+Ow0KPiBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsgR3VvaGFuanVuIChIYW5qdW4gR3Vv
KSA8Z3VvaGFuanVuQGh1YXdlaS5jb20+Ow0KPiB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdl
aS5jb20+OyBTYW1pLk11amF3YXJAYXJtLmNvbTsNCj4gcm9iaW4ubXVycGh5QGFybS5jb207IHdh
bmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMC85XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQgUk1SIG5vZGUNCj4gDQo+IE9u
IDcvMTYvMjAyMSAxMTozNCBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBIaSwNCj4g
Pg0KPiA+IE1ham9yIENoYW5nZXMgZnJvbSB2NToNCj4gPiAtIEFkZHJlc3NlZCBjb21tZW50cyBm
cm9tIFJvYmluICYgTG9yZW56by4NCj4gPiAgIDogTW92ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBh
Y3BpX2lvcnRfaW5pdCgpIGZyb20NCj4gPiAgICAgaW9ydF9pbml0X3BsYXRmb3JtX2RldmljZXMo
KS4NCj4gPiAgIDogUmVtb3ZlZCB1c2Ugb2Ygc3RydWN0IGlvcnRfcm1yX2VudHJ5IGR1cmluZyB0
aGUgaW5pdGlhbA0KPiA+ICAgICBwYXJzZS4gVXNpbmcgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9u
IGluc3RlYWQuDQo+ID4gICA6IFJlcG9ydCBSTVIgYWRkcmVzcyBhbGlnbm1lbnQgYW5kIG92ZXJs
YXAgZXJyb3JzLCBidXQgY29udGludWUuDQo+ID4gICA6IFJld29ya2VkIGFybV9zbW11X2luaXRf
YnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4NCj4gPiAtIFVwZGF0ZWQgU01NVXYyIGJ5cGFzcyBT
TVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChwYXRjaCAjOCkuDQo+ID4gLSBTZXQgSU9NTVUgcHJv
dGVjdGlvbiBmbGFncyhJT01NVV9DQUNIRSwgSU9NTVVfTU1JTykgYmFzZWQNCj4gPiAgIG9uIFR5
cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBOLg0KDQpbLi4uXQ0KDQo+ID4NCj4g
VmFsaWRhdGVkIG9uIGEgTlhQIExYMjE2MEEgd2l0aCBTTU1VdjIsIHNvOg0KPiANCj4gVGVzdGVk
LWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiANCg0KVGhh
bmtzIGZvciB0ZXN0aW5nLg0KDQpIaSBBbGwsDQoNCkEgZ2VudGxlIHBpbmcgb24gdGhpcy4uLg0K
DQpJIGFtIHBsYW5uaW5nIHRvIHJlc3BpbiB0aGlzIHdpdGggdGhlIGZpeCBzdWdnZXN0ZWQgYnkg
U3RldmUgaW4NCnBhdGNoICM4IGZvciBTTU1VdjIuIEJ1dCB3b3VsZCB3YWl0IHRpbGwgb3RoZXIg
cGF0Y2hlcyBnZXQgYQ0KcHJvcGVyIHJldmlldyBzbyB0aGF0IEkgY2FuIGluY2x1ZGUgdGhvc2Ug
Y29tbWVudHMgYXMgd2VsbCBpZg0KYW55Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=
