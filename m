Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF34CBE60
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 14:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiCCNDF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 08:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCCNDF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 08:03:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511D186426
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 05:02:19 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8WLL2JXZzBrbT;
        Thu,  3 Mar 2022 21:00:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:02:16 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:02:15 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 3 Mar 2022 13:02:13 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0aythveAgAAnagA=
Date:   Thu, 3 Mar 2022 13:02:13 +0000
Message-ID: <f62c9542a9ab46cab0ef26919a47e8b9@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <dc755b11-ece7-4028-b153-cc8b9301099c@arm.com>
In-Reply-To: <dc755b11-ece7-4028-b153-cc8b9301099c@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.4]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVuIFByaWNlIFtt
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDAzIE1hcmNoIDIwMjIgMTA6MzgN
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207
IHdpbGxAa2VybmVsLm9yZzsgd2FuZ2h1aXFpYW5nDQo+IDx3YW5naHVpcWlhbmdAaHVhd2VpLmNv
bT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgU2Ft
aS5NdWphd2FyQGFybS5jb207IGpvbkBzb2xpZC1ydW4uY29tOw0KPiBlcmljLmF1Z2VyQHJlZGhh
dC5jb207IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OCAwMC8xMV0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+
IA0KPiBPbiAyMS8wMi8yMDIyIDE1OjQzLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gU2luY2Ugd2Ugbm93IGhhdmUgYW4gdXBkYXRlZCB2ZXJpb25bMF0gb2YgSU9S
VCBzcGVjKEUuZCkgd2hpY2gNCj4gPiBhZGRyZXNzZXMgdGhlIG1lbW9yeSBhdHRyaWJ1dGVzIGlz
c3VlcyBkaXNjdXNzZWQgaGVyZSBbMV0sDQo+ID4gdGhpcyBzZXJpZXMgbm93IG1ha2UgdXNlIG9m
IGl0Lg0KPiA+DQo+ID4gVGhlIHB1bGwgcmVxdWVzdCBmb3IgQUNQSUNBIEUuZCByZWxhdGVkIGNo
YW5nZXMgYXJlIGFscmVhZHkNCj4gPiByYWlzZWQgYW5kIGNhbiBiZSBmb3VuZCBoZXJlLA0KPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwvNzUyDQo+ID4NCj4gPiB2NyAt
LT4gdjgNCj4gPiAgIC0gUGF0Y2ggIzEgaGFzIHRlbXAgZGVmaW5pdGlvbnMgZm9yIFJNUiByZWxh
dGVkIGNoYW5nZXMgdGlsbA0KPiA+ICAgICB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBw
YXJ0IG9mIGtlcm5lbC4NCj4gPiAgIC0gTm8gZWFybHkgcGFyc2luZyBvZiBSTVIgbm9kZSBpbmZv
IGFuZCBpcyBvbmx5IHBhcnNlZCBhdCB0aGUNCj4gPiAgICAgdGltZSBvZiB1c2UuDQo+ID4gICAt
IENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQgdG8gdGhlDQo+
ID4gICAgIHByZXZpb3VzIHZlcnNpb24uDQo+ID4gICAtIFN1cHBvcnQgZm9yIFJNUiBkZXNjcmlw
dG9yIHNoYXJlZCBieSBtdWx0aXBsZSBzdHJlYW0gSURzLg0KPiA+DQo+ID4gUGxlYXNlIHRha2Ug
YSBsb29rIGFuZCBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KPiANCj4gSGkgU2hhbWVlciwN
Cj4gDQo+IEkndmUgbm93IGJlZW4gYWJsZSB0byB0ZXN0IHRoaXMgb24gdGhlIEp1bm8gcGxhdGZv
cm0gd2l0aCBhIG1vZGlmaWVkDQo+IGZpcm13YXJlIHN1cHBvcnRpbmcgdGhlIG5ld2VyIHNwZWMg
KHRoYW5rcyBTYW1pISkuIEV2ZXJ5dGhpbmcgd29ya3MsIHNvDQo+IGZlZWwgZnJlZSB0byBhZGQg
bXk6DQo+IA0KPiBUZXN0ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+
DQo+IA0KPiAoTm90ZSB0aGF0IEkgaGF2ZW4ndCB0ZXN0ZWQgdGhlIHNtbXUtdjMgc3VwcG9ydCkN
Cg0KVGhhbmtzIFN0ZXZlLCBmb3IgZ2l2aW5nIGl0IGEgc3BpbiBhbmQgdmVyaWZ5aW5nLg0KDQpD
aGVlcnMsDQpTaGFtZWVyDQo=
