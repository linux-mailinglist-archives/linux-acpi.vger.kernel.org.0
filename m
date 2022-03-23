Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F714E55B4
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiCWP5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCWP5Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 11:57:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF857A99B
        for <linux-acpi@vger.kernel.org>; Wed, 23 Mar 2022 08:55:46 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KNtDw4bpYzCr6Q;
        Wed, 23 Mar 2022 23:53:36 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 23:55:43 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 23:55:42 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 23 Mar 2022 15:55:40 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Topic: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Thread-Index: AQHYJzn4JzDYsNDAv0udQS6OoRGEcqzL5oEAgAFnZ1A=
Date:   Wed, 23 Mar 2022 15:55:40 +0000
Message-ID: <07bb59d690e84edfa62d7c844612b526@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
 <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
In-Reply-To: <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDIyIE1hcmNoIDIwMjIgMTg6MjcN
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5dGVzLm9yZzsgd2lsbEBrZXJuZWwub3JnOyB3YW5n
aHVpcWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuIChIYW5qdW4g
R3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsgU2Ft
aS5NdWphd2FyQGFybS5jb207DQo+IGpvbkBzb2xpZC1ydW4uY29tOyBlcmljLmF1Z2VyQHJlZGhh
dC5jb207IHlhbmd5aWNvbmcNCj4gPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OCAwMi8xMV0gaW9tbXU6IEludHJvZHVjZSBhIHVuaW9uIHRvIHN0cnVjdA0K
PiBpb21tdV9yZXN2X3JlZ2lvbg0KPiANCj4gT24gMjAyMi0wMi0yMSAxNTo0MywgU2hhbWVlciBL
b2xvdGh1bSB3cm90ZToNCj4gPiBBIHVuaW9uIGlzIGludHJvZHVjZWQgdG8gc3RydWN0IGlvbW11
X3Jlc3ZfcmVnaW9uIHRvIGhvbGQNCj4gPiBhbnkgZmlybXdhcmUgc3BlY2lmaWMgZGF0YS4gVGhp
cyBpcyBpbiBwcmVwYXJhdGlvbiB0byBhZGQNCj4gPiBzdXBwb3J0IGZvciBJT1JUIFJNUiByZXNl
cnZlIHJlZ2lvbnMgYW5kIHRoZSB1bmlvbiBub3cgaG9sZHMNCj4gPiB0aGUgUk1SIHNwZWNpZmlj
IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0K
PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
aW5jbHVkZS9saW51eC9pb21tdS5oIHwgOSArKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lv
bW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiBpbmRleCBkZTBjNTdhNTY3YzguLmIw
Njk1MmE3NWY5NSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiBAQCAtMTI2LDYgKzEyNiwxMSBAQCBlbnVt
IGlvbW11X3Jlc3ZfdHlwZSB7DQo+ID4gICAJSU9NTVVfUkVTVl9TV19NU0ksDQo+ID4gICB9Ow0K
PiA+DQo+ID4gK3N0cnVjdCBpb21tdV9pb3J0X3Jtcl9kYXRhIHsNCj4gPiArCXUzMiAqc2lkczsJ
LyogU3RyZWFtIElkcyBhc3NvY2lhdGVkIHdpdGggSU9SVCBSTVIgZW50cnkgKi8NCj4gDQo+IFBs
ZWFzZSBtYWtlIHRoaXMgY29uc3QuDQo+IA0KPiBGdXJ0aGVyIG5pdDogY2FwaXRhbGlzYXRpb24g
b2YgIklEcyIgaW4gdGhlIGNvbW1lbnQsIG90aGVyd2lzZSBJIG1pZ2h0DQo+IHdvcnJ5IGFib3V0
IHRoZSBwb3NzaWJpbGl0eSBvZiBTdHJlYW0gRWdvcyB0b28gOlANCg0KVHJ1ZSA6KS4gV2lsbCBk
byB0aGF0Lg0KDQpUaGFua3MsDQpTaGFtZWVyIA0KDQo+IA0KPiA+ICsJdTMyIG51bV9zaWRzOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogc3RydWN0IGlvbW11X3Jlc3ZfcmVn
aW9uIC0gZGVzY3JpcHRvciBmb3IgYSByZXNlcnZlZCBtZW1vcnkgcmVnaW9uDQo+ID4gICAgKiBA
bGlzdDogTGlua2VkIGxpc3QgcG9pbnRlcnMNCj4gPiBAQCAtMTMzLDYgKzEzOCw3IEBAIGVudW0g
aW9tbXVfcmVzdl90eXBlIHsNCj4gPiAgICAqIEBsZW5ndGg6IExlbmd0aCBvZiB0aGUgcmVnaW9u
IGluIGJ5dGVzDQo+ID4gICAgKiBAcHJvdDogSU9NTVUgUHJvdGVjdGlvbiBmbGFncyAoUkVBRC9X
UklURS8uLi4pDQo+ID4gICAgKiBAdHlwZTogVHlwZSBvZiB0aGUgcmVzZXJ2ZWQgcmVnaW9uDQo+
ID4gKyAqIEBmd19kYXRhOiBGVyBzcGVjaWZpYyByZXNlcnZlZCByZWdpb24gZGF0YQ0KPiANCj4g
Tml0OiB3ZSd2ZSBnb3QgcGxlbnR5IG9mIHJvb20gdG8gc3BlbGwgb3V0ICJGaXJtd2FyZS1zcGVj
aWZpYyIsIGFuZCBpdA0KPiBuZXZlciBodXJ0cyB0byBtYWtlIGRvY3VtZW50YXRpb24gYXMgZWFz
eSB0byByZWFkIGFzIHBvc3NpYmxlLg0KPiANCj4gVGhhbmtzLA0KPiBSb2Jpbi4NCj4gDQo+ID4g
ICAgKi8NCj4gPiAgIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB7DQo+ID4gICAJc3RydWN0IGxp
c3RfaGVhZAlsaXN0Ow0KPiA+IEBAIC0xNDAsNiArMTQ2LDkgQEAgc3RydWN0IGlvbW11X3Jlc3Zf
cmVnaW9uIHsNCj4gPiAgIAlzaXplX3QJCQlsZW5ndGg7DQo+ID4gICAJaW50CQkJcHJvdDsNCj4g
PiAgIAllbnVtIGlvbW11X3Jlc3ZfdHlwZQl0eXBlOw0KPiA+ICsJdW5pb24gew0KPiA+ICsJCXN0
cnVjdCBpb21tdV9pb3J0X3Jtcl9kYXRhIHJtcjsNCj4gPiArCX0gZndfZGF0YTsNCj4gPiAgIH07
DQo+ID4NCj4gPiAgIC8qKg0K
