Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978F4D6258
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbiCKNZE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiCKNZE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 08:25:04 -0500
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE477AA6
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 05:24:00 -0800 (PST)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4KFRRY1DbjzHp3X;
        Fri, 11 Mar 2022 21:22:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 21:23:57 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Fri, 11 Mar 2022 13:23:55 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0ay572iAgABYQ+A=
Date:   Fri, 11 Mar 2022 13:23:55 +0000
Message-ID: <96b57daaf56f4f3c916b3e9271377c46@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
In-Reply-To: <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciBbbWFp
bHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbV0NCj4gU2VudDogMTEgTWFyY2ggMjAyMiAwODowNw0K
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsg
d2lsbEBrZXJuZWwub3JnOyB3YW5naHVpcWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29t
PjsgR3VvaGFuanVuIChIYW5qdW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBzdGV2
ZW4ucHJpY2VAYXJtLmNvbTsgU2FtaS5NdWphd2FyQGFybS5jb207DQo+IGpvbkBzb2xpZC1ydW4u
Y29tOyB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjggMDAvMTFdIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQ0KPiAN
Cj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDIvMjEvMjIgNDo0MyBQTSwgU2hhbWVlciBLb2xvdGh1
bSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IFNpbmNlIHdlIG5vdyBoYXZlIGFuIHVwZGF0ZWQg
dmVyaW9uWzBdIG9mIElPUlQgc3BlYyhFLmQpIHdoaWNoDQo+ID4gYWRkcmVzc2VzIHRoZSBtZW1v
cnkgYXR0cmlidXRlcyBpc3N1ZXMgZGlzY3Vzc2VkIGhlcmUgWzFdLA0KPiA+IHRoaXMgc2VyaWVz
IG5vdyBtYWtlIHVzZSBvZiBpdC4NCj4gPg0KPiA+IFRoZSBwdWxsIHJlcXVlc3QgZm9yIEFDUElD
QSBFLmQgcmVsYXRlZCBjaGFuZ2VzIGFyZSBhbHJlYWR5DQo+ID4gcmFpc2VkIGFuZCBjYW4gYmUg
Zm91bmQgaGVyZSwNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9wdWxsLzc1
Mg0KPiA+DQo+ID4gdjcgLS0+IHY4DQo+ID4gICAtIFBhdGNoICMxIGhhcyB0ZW1wIGRlZmluaXRp
b25zIGZvciBSTVIgcmVsYXRlZCBjaGFuZ2VzIHRpbGwNCj4gPiAgICAgdGhlIEFDUElDQSBoZWFk
ZXIgY2hhbmdlcyBhcmUgcGFydCBvZiBrZXJuZWwuDQo+ID4gICAtIE5vIGVhcmx5IHBhcnNpbmcg
b2YgUk1SIG5vZGUgaW5mbyBhbmQgaXMgb25seSBwYXJzZWQgYXQgdGhlDQo+ID4gICAgIHRpbWUg
b2YgdXNlLg0KPiA+ICAgLSBDaGFuZ2VzIHRvIHRoZSBSTVIgZ2V0L3B1dCBBUEkgZm9ybWF0IGNv
bXBhcmVkIHRvIHRoZQ0KPiA+ICAgICBwcmV2aW91cyB2ZXJzaW9uLg0KPiA+ICAgLSBTdXBwb3J0
IGZvciBSTVIgZGVzY3JpcHRvciBzaGFyZWQgYnkgbXVsdGlwbGUgc3RyZWFtIElEcy4NCj4gDQo+
IEkgdGVzdGVkIGl0IG9uIGd1ZXN0IHNpZGUgZm9yIGhvc3QgTVNJIFNXIFJFU1YgcmVnaW9uIGZs
YXQgbWFwcGluZw0KPiAodXNpbmcgYm90aCB0aGUgb2xkIHNpbmdsZSBtYXBwaW5nIGxheW91dCBh
bmQgdGhlIG5vdyBhbGxvd2VkIG11bHRpcGxlDQo+IFJJRCBJRCBtYXBwaW5nIGZvcm1hdCkgYW5k
IHRoaXMgd29ya2VkIGZvciBtZS4gRmVlbCBmcmVlIHRvIGFkZCBteQ0KPiANCj4gVGVzdGVkLWJ5
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQoNClRoYW5rcyBFcmljIGZvciB2
ZXJpZnlpbmcgdGhpcywgZXNwZWNpYWxseSB0aGUgbXVsdGlwbGUgUklEIG1hcHBpbmcgY2FzZS4N
Cg0KQ2hlZXJzLA0KU2hhbWVlcg0K
