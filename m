Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93850A2E5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389167AbiDUOqF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiDUOqF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 10:46:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501764092D
        for <linux-acpi@vger.kernel.org>; Thu, 21 Apr 2022 07:43:14 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkgHP6JM4z1J9mP;
        Thu, 21 Apr 2022 22:42:25 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:43:12 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:43:11 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 21 Apr 2022 15:43:09 +0100
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
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYVNaUTt7OoJdAgkmipcgAIvAb/6z6RJeAgAAqF+A=
Date:   Thu, 21 Apr 2022 14:43:09 +0000
Message-ID: <78cd48d112b144b69bcc498748c584e3@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
In-Reply-To: <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVuIFByaWNlIFtt
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDIxIEFwcmlsIDIwMjIgMTM6NTkN
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207
IHdpbGxAa2VybmVsLm9yZzsgd2FuZ2h1aXFpYW5nDQo+IDx3YW5naHVpcWlhbmdAaHVhd2VpLmNv
bT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgU2Ft
aS5NdWphd2FyQGFybS5jb207IGpvbkBzb2xpZC1ydW4uY29tOw0KPiBlcmljLmF1Z2VyQHJlZGhh
dC5jb207IGxhdXJlbnRpdS50dWRvckBueHAuY29tOyBoY2hAaW5mcmFkZWFkLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMCAwLzldIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBSTVIg
bm9kZQ0KPiANCj4gT24gMjAvMDQvMjAyMiAxNzo0OCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToN
Cj4gPiBIaQ0KPiA+DQo+ID4gdjkgLS0+IHYxMA0KPiA+ICAtIERyb3BwZWQgcGF0Y2ggIzEgKCJB
ZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5pdGlvbnMiKSBzaW5jZQ0KPiA+ICAgIHRo
ZSBBQ1BJQ0EgaGVhZGVyIHVwZGF0ZXMgcGF0Y2ggaXMgbm93IGluIHRoZSBtYWlsaW5nIGxpc3Rb
MV0NCj4gPiAgLSBCYXNlZCBvbiB0aGUgc3VnZ2VzdGlvbiBmcm9tIENocmlzdG9waCwgaW50cm9k
dWNlZCBhDQo+ID4gICAgcmVzdl9yZWdpb25fZnJlZV9md19kYXRhKCkgY2FsbGJhY2sgaW4gc3Ry
dWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZA0KPiA+ICAgIHVzZWQgdGhhdCB0byBmcmVlIFJNUiBz
cGVjaWZpYyBtZW1vcnkgYWxsb2NhdGlvbnMuDQo+ID4NCj4gPiBUaG91Z2ggdGhlcmUgaXMgYSBz
bWFsbCBjaGFuZ2UgZnJvbSB2OSB3aXRoIHJlc3BlY3QgdG8gaG93IHdlIGZyZWUgdXANCj4gPiB0
aGUgRlcgc3BlY2lmaWMgZGF0YSwgSSBoYXZlIHRha2VuIHRoZSBsaWJlcnR5IHRvIHBpY2sgdXAg
dGhlIFItYnkgYW5kDQo+ID4gVC1ieSB0YWdzIGZyb20gTG9yZW56bywgU3RldmUgYW5kIExhdXJl
bnRpdS4gQnV0IHBsZWFzZSBkbyB0YWtlIGEgbG9vaw0KPiA+IGFnYWluIGFuZCBsZXQgbWUga25v
dy4NCj4gDQo+IEkndmUgZ2l2ZW4gdGhpcyBhIGdvIGFuZCBpdCB3b3JrcyBmaW5lIG9uIG15IEp1
bm8gc2V0dXAuIFNvIGRvIGtlZXAgbXkNCj4gVC1ieSB0YWcuDQoNCk1hbnkgdGhhbmtzIGZvciB0
aGF0Lg0KDQo+IFNhbWkgaGFzIGJlZW4ga2luZCBlbm91Z2ggdG8gZ2l2ZSBtZSBhbiB1cGRhdGVk
IGZpcm13YXJlIHdoaWNoIGFsc28NCj4gZml4ZXMgdGhlIFJNUiBub2RlIGluIHRoZSBJT1JULiBB
bHRob3VnaCBhcyBtZW50aW9uZWQgYmVmb3JlIHRoZSBkZXRhaWxzDQo+IG9mIHRoZSBSTVIgbm9k
ZSBhcmUgY3VycmVudGx5IGJlaW5nIGlnbm9yZWQgc28gdGhpcyBkb2Vzbid0IGNoYW5nZSB0aGUN
Cj4gZnVuY3Rpb25hbGl0eSBidXQgc2lsZW5jZXMgdGhlIHdhcm5pbmcuDQo+IA0KPiBNeSBjb25j
ZXJuIGlzIHRoYXQgd2l0aCB0aGUgUk1SIHJlZ2lvbiBlZmZlY3RpdmVseSBpZ25vcmVkIHdlIG1h
eSBzZWUNCj4gbW9yZSBicm9rZW4gZmlybXdhcmUsIGFuZCB3aGlsZSBhIGxlbmd0aCBvZiB6ZXJv
IHByb2R1Y2VzIGEgd2FybmluZywgYW4NCj4gb3RoZXJ3aXNlIGluY29ycmVjdCBsZW5ndGggd2ls
bCBjdXJyZW50bHkgInNpbGVudGx5IHdvcmsiIGJ1dCBtZWFuIHRoYXQNCj4gYW55IGZ1dHVyZSB0
aWdodGVuaW5nIHdvdWxkIGNhdXNlIHByb2JsZW1zLiBGb3IgZXhhbXBsZSBpZiB0aGUgU01NVQ0K
PiBkcml2ZXIgd2VyZSB0byByZWNyZWF0ZSB0aGUgbWFwcGluZ3MgdG8gb25seSBjb3ZlciB0aGUg
cmVnaW9uIHNwZWNpZmllZA0KPiBpbiB0aGUgUk1SIGl0IG1heSBub3QgYmUgbGFyZ2UgZW5vdWdo
IGlmIHRoZSBSTVIgYmFzZS9sZW5ndGggYXJlIG5vdA0KPiBjb3JyZWN0Lg0KDQpOb3Qgc3VyZSBo
b3cgd2UgY2FuIGZ1cnRoZXIgdmFsaWRhdGUgdGhlIFJNUiBpZiB0aGUgZmlybXdhcmUgcHJvdmlk
ZXMgYW4NCmluY29ycmVjdCBvbmUuIEkgc2VlIHlvdXIgcG9pbnQgb2YgZnV0dXJlIHRpZ2h0ZW5p
bmcgY2F1c2luZyBwcm9ibGVtcw0Kd2l0aCBicm9rZW4gZmlybXdhcmUuIEJ1dCB0aGVuIGl0IGlz
IGluZGVlZCBhICJicm9rZW4gZmlybXdhcmUiLi4uDQoNCiBJdCdzIHVwIHRvIHRoZSBtYWludGFp
bmVycyBhcyB0byB3aGV0aGVyIHRoZXkgc2VlIHRoaXMgYXMgYQ0KPiBwcm9ibGVtIG9yIG5vdC4N
Cg0KSGkgUm9iaW4sDQoNCkFueSB0aG91Z2h0cyBvbiB0aGlzPw0KDQpUaGFua3MsDQpTaGFtZWVy
DQoNCg==
