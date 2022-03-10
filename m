Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB84D44EC
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCJKqz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 05:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCJKqx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 05:46:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71213DE3C
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 02:45:52 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDm0B5Kc7zfYqJ;
        Thu, 10 Mar 2022 18:44:26 +0800 (CST)
Received: from dggpemm100008.china.huawei.com (7.185.36.125) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 18:45:50 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 18:45:49 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 10 Mar 2022 10:45:47 +0000
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
Subject: RE: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR
 nodes
Thread-Topic: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR
 nodes
Thread-Index: AQHYJzoU7y0scyFWHEWb6SBtCVveFqy4hbiAgAAB0fA=
Date:   Thu, 10 Mar 2022 10:45:47 +0000
Message-ID: <464edc7655514a89afd5d91a4553da4d@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
 <d5740467-f070-bd29-5ef4-de071b751292@redhat.com>
In-Reply-To: <d5740467-f070-bd29-5ef4-de071b751292@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.233]
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxMCBNYXJjaCAyMDIy
IDEwOjMyDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsb3Jl
bnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBqb3JvQDhieXRlcy5vcmc7IHJvYmluLm11cnBoeUBh
cm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1
YXdlaS5jb20+OyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNv
bT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOyBTYW1pLk11amF3YXJAYXJtLmNvbTsNCj4gam9uQHNv
bGlkLXJ1bi5jb207IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2OCAwMy8xMV0gQUNQSS9JT1JUOiBBZGQgaGVscGVyIGZ1bmN0aW9ucyB0
byBwYXJzZSBSTVINCj4gbm9kZXMNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAyLzIxLzIy
IDQ6NDMgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gVGhlIGhlbHBlciBmdW5jdGlv
bnMgaGVyZSBwYXJzZSB0aHJvdWdoIHRoZSBJT1JUIFJNUiBub2RlcyBhbmQNCj4gPiBwb3B1bGF0
ZSBhIHJlc2VydmVkIHJlZ2lvbiBsaXN0ICBjb3JyZXNwb25kaW5nIHRvIGEgZ2l2ZW4gaW9tbXUN
Cj4gPiBhbmQgZGV2aWNlKG9wdGlvbmFsKS4gVGhlc2UgYWxzbyBnbyB0aHJvdWdoIHRoZSBJRCBt
YXBwaW5ncyBvZg0KPiA+IHRoZSBSTVIgbm9kZSBhbmQgcmV0cmlldmVzIGFsbCB0aGUgU0lEcyBh
c3NvY2lhdGVkIHdpdGggYSBSTVINCj4gPiBkZXNjcmlwdG9yLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3
ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIHwgMjI1DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyMjUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNw
aS9hcm02NC9pb3J0LmMgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jDQo+ID4gaW5kZXggMDcz
MGM0ZGJiNzAwLi4wNWRhOWViZmY1MGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2Fy
bTY0L2lvcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gPiBAQCAt
ODMwLDYgKzgzMCwyMzEgQEAgc3RhdGljIHN0cnVjdCBhY3BpX2lvcnRfbm9kZQ0KPiAqaW9ydF9n
ZXRfbXNpX3Jlc3ZfaW9tbXUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJcmV0dXJuIE5VTEw7
DQo+ID4gIH0NCj4gPg0KWy4uLl0NCg0KPiA+ICtzdGF0aWMgdm9pZCBpb3J0X2ZpbmRfcm1ycyhz
dHJ1Y3QgYWNwaV9pb3J0X25vZGUgKmlvbW11LCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJ
CSAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhY3BpX3Rh
YmxlX2lvcnQgKmlvcnQ7DQo+ID4gKwlzdHJ1Y3QgYWNwaV9pb3J0X25vZGUgKmlvcnRfbm9kZSwg
KmlvcnRfZW5kOw0KPiA+ICsJaW50IGk7DQo+ID4gKw0KPiA+ICsJaWYgKGlvcnRfdGFibGUtPnJl
dmlzaW9uIDwgNSkNCj4gVGhpcyBtZWFucyBFLmIgYW5kIEUuYyByZXZzIGFyZSBub3Qgc3VwcG9y
dGVkLiBJcyBpdCB3aGF0IHdlIHdhbnQ/DQoNClllcy4gRS5iIGxhY2tzIG1lbW9yeSBhdHRyaWJ1
dGVzIGluZm8gYXNzb2NpYXRlZCB3aXRoIFJNUiBub2RlLiBUaG91Z2ggRS5jIA0KYWRkZWQgdGhv
c2UsIGl0IGJyb2tlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBBQ1BJQ0EgRS5iIHN1cHBv
cnQgYW5kDQppcyBub3cgZGVwcmVjYXRlZC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg==
