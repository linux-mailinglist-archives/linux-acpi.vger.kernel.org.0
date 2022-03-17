Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA954DC9FF
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiCQPcP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiCQPcP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 11:32:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FA16F6C9
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 08:30:57 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK9x45Xqqz9sj3;
        Thu, 17 Mar 2022 23:27:04 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:30:54 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:30:53 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 17 Mar 2022 15:30:51 +0000
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
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0azA3K4AgAL7+yA=
Date:   Thu, 17 Mar 2022 15:30:51 +0000
Message-ID: <dcc862048c624e109afbc7309f01c59d@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
In-Reply-To: <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciBbbWFp
bHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbV0NCj4gU2VudDogMTUgTWFyY2ggMjAyMiAxNzo1Mw0K
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
Cj4gSGkgU2hhbWVlciwNCg0KWy4uLl0NCg0KPiA+DQo+ID4gSm9uIE5ldHRsZXRvbiAoMSk6DQo+
ID4gICBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwg
YnlwYXNzIFNNUg0KPiA+DQo+ID4gU2hhbWVlciBLb2xvdGh1bSAoMTApOg0KPiA+ICAgQUNQSS9J
T1JUOiBBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5pdGlvbnMNCj4gPiAgIGlvbW11
OiBJbnRyb2R1Y2UgYSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24NCj4gPiAgIEFD
UEkvSU9SVDogQWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gcGFyc2UgUk1SIG5vZGVzDQo+ID4gICBp
b21tdS9kbWE6IEludHJvZHVjZSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5mbw0K
PiA+ICAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIG1lbW9yeSByZWdp
b25zDQo+ID4gICBpb21tdS9hcm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0IGhlbHBl
cg0KPiA+ICAgaW9tbXUvYXJtLXNtbXUtdjM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNz
X3N0ZXMoKSB0byBmb3JjZQ0KPiA+ICAgICBieXBhc3MNCj4gPiAgIGlvbW11L2FybS1zbW11LXYz
OiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBhbmQgaW5zdGFsbCBieXBhc3MgU1RFDQo+ID4gICBp
b21tdS9hcm0tc21tdS12MzogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNzb2NpYXRlZCB3aXRo
IGEgZGV2DQo+ID4gICBpb21tdS9hcm0tc21tdTogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNz
b2NpYXRlZCB3aXRoIGEgZGV2DQo+IGZ5aSwgdGhlIGxhc3QgMiBwYXRjaGVzIGhhdmUgY29uZmxp
Y3RzIHdpdGgNCj4gW1BBVENIIHY0IDkvOV0gaW9tbXU6IFNwbGl0IHN0cnVjdCBpb21tdV9vcHMN
Cj4gd2hpY2ggd2FzIGFwcGxpZWQgb24gY29yZSBicmFuY2guDQoNCkhpIEVyaWMsDQoNClRoYW5r
cyBmb3IgdGhlIGhlYWRzIHVwLiBJIGFtIGdvaW5nIHRvIHJlc3BpbiB0aGlzIHNlcmllcyBzb29u
Lg0KDQpBbGwsDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGZ1cnRoZXIg
Y29tbWVudHMgb24gdGhpcyBzZXJpZXMuDQoNClRoYW5rcywNClNoYW1lZXINCg==
