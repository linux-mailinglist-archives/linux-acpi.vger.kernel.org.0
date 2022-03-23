Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40874E55F1
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 17:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiCWQHo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbiCWQHn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 12:07:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A97C7A6
        for <linux-acpi@vger.kernel.org>; Wed, 23 Mar 2022 09:06:11 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KNtTZ0w8TzfZWm;
        Thu, 24 Mar 2022 00:04:34 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 00:06:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 00:06:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 23 Mar 2022 16:06:04 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Topic: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Index: AQHYJzoHyQwMkRcbbE6vVIIVTT4JpazL8g2AgAFXK+A=
Date:   Wed, 23 Mar 2022 16:06:04 +0000
Message-ID: <ad7ae652a2b54261a522008a25238039@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
 <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
In-Reply-To: <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDIyIE1hcmNoIDIwMjIgMTk6MDkN
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnDQo+IENjOiBqb25Ac29saWQtcnVuLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+Ow0KPiBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsgR3VvaGFuanVuIChIYW5qdW4gR3VvKSA8
Z3VvaGFuanVuQGh1YXdlaS5jb20+Ow0KPiB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5j
b20+OyBTYW1pLk11amF3YXJAYXJtLmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyB3YW5naHVpcWlh
bmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDA1
LzExXSBBQ1BJL0lPUlQ6IEFkZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVINCj4gbWVtb3J5IHJl
Z2lvbnMNCj4gDQo+IE9uIDIwMjItMDItMjEgMTU6NDMsIFNoYW1lZXIgS29sb3RodW0gdmlhIGlv
bW11IHdyb3RlOg0KPiA+IEFkZCBoZWxwZXIgZnVuY3Rpb25zIChpb3J0X2lvbW11X2dldC9wdXRf
cm1ycygpKSB0aGF0DQo+ID4gcmV0cmlldmVzL3JlbGVhc2VzIFJNUiBtZW1vcnkgZGVzY3JpcHRv
cnMgYXNzb2NpYXRlZA0KPiA+IHdpdGggYSBnaXZlbiBJT01NVS4gVGhpcyB3aWxsIGJlIHVzZWQg
YnkgSU9NTVUgZHJpdmVycw0KPiA+IHRvIHNldCB1cCBuZWNlc3NhcnkgbWFwcGluZ3MuDQo+ID4N
Cj4gPiBJbnZva2UgaXQgZnJvbSB0aGUgZ2VuZXJpYyBpb21tdSBoZWxwZXIgZnVuY3Rpb25zLg0K
PiANCj4gaW9tbXVfZG1hX2dldF9yZXN2X3JlZ2lvbnMoKSBhbHJlYWR5IGV4aXN0cyAtIHBsZWFz
ZSBleHRlbmQgdGhhdCByYXRoZXINCj4gdGhhbiBhZGRpbmcgYSBwYXJhbGxlbCBpbXBsZW1lbnRh
dGlvbiBvZiB0aGUgc2FtZSB0aGluZyBidXQgZGlmZmVyZW50Lg0KPiBJT1JUIHNob3VsZCBleHBv
cnQgYSBzaW5nbGUgZ2V0X3Jlc3ZfcmVnaW9ucyBoZWxwZXIgd2hpY2ggY29tYmluZXMgdGhlDQo+
IG5ldyBSTVJzIHdpdGggdGhlIGV4aXN0aW5nIE1TSSB3b3JrYXJvdW5kLCBhbmQgYSBzZXBhcmF0
ZSAiZG8gSSBuZWVkIHRvDQo+IGJ5cGFzcyB0aGlzIFN0cmVhbUlEIiBoZWxwZXIgZm9yIHRoZSBT
TU1VIGRyaXZlcnMgdG8gY2FsbCBkaXJlY3RseSBhdA0KPiByZXNldCB0aW1lLCBzaW5jZSB0aGUg
bGF0dGVyIGlzbid0IHJlYWxseSBhbiBpb21tdS1kbWEgcmVzcG9uc2liaWxpdHkuDQoNClJpZ2h0
LiBJIGFjdHVhbGx5IGhhZCBjb3VwbGUgb2YgYmFjayBhbmQgZm9ydGggb24gdGhlIGludGVyZmFj
ZXMgYW5kIHNldHRsZWQNCm9uIHRoaXMgbWFpbmx5IGJlY2F1c2UgaXQganVzdCByZXF1aXJlcyBh
IHNpbmdsZSBpbnRlcmZhY2UgZnJvbSBJT1JUIGZvciBib3RoDQpnZXRfcmVzdl9yZWdpb25zKCkg
YW5kIFNNTVUgZHJpdmVyIHJlc2V0IGJ5cGFzcyBwYXRoLg0KaWUsIGlvcnRfaW9tbXVfZ2V0L3B1
dF9ybXJzKCkpLg0KDQpCdXQgYWdyZWUgdGhlIGFib3ZlIGNvbW1lbnQgaXMgYWxzbyB2YWxpZC4g
DQoNCj4gSSdtIGhhcHB5IHRvIGRvIHRoYXQganVzdCBieSBzaHVmZmxpbmcgd3JhcHBlcnMgYXJv
dW5kIGZvciBub3cgLSB3ZSBjYW4NCj4gY29tZSBiYWNrIGFuZCBzdHJlYW1saW5lIHRoZSBjb2Rl
IHByb3Blcmx5IGFmdGVyd2FyZHMgLSBidXQgdGhlIHNoZWVyDQo+IGFtb3VudCBvZiBpbmRpcmVj
dGlvbiBjdXJyZW50bHkgYXQgcGxheSBoZXJlIGlzIHNvIGhhcmQgdG8gZm9sbG93IHRoYXQNCj4g
aXQncyBub3QgZXZlbiBhbGwgdGhhdCBlYXN5IHRvIHNlZSBob3cgaXQncyBjcm9zc2luZyBhYnN0
cmFjdGlvbiBsZXZlbHMNCj4gaW1wcm9wZXJseS4NCg0KUGxlYXNlIGZpbmQgYmVsb3cgdGhlIHJl
dmlzZWQgb25lcy4gUGxlYXNlIHRha2UgYSBsb29rIGFuZCBsZXQgbWUga25vdy4NCg0KVGhhbmtz
LA0KU2hhbWVlcg0KDQppb21tdS1kbWE6DQoNCnZvaWQgaW9tbXVfZG1hX2dldF9yZXN2X3JlZ2lv
bnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KSB7DQoNCiAgICAg
ICAgaWYgKCFpc19vZl9ub2RlKGRldl9pb21tdV9md3NwZWNfZ2V0KGRldiktPmlvbW11X2Z3bm9k
ZSkpDQogICAgICAgICAgICAgICAgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKGRldiwgbGlz
dCk7DQp9DQoNCnZvaWQgaW9tbXVfZG1hX3B1dF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KSB7DQoNCiAgICAgICAgaWYgKCFpc19vZl9ub2Rl
KGRldl9pb21tdV9md3NwZWNfZ2V0KGRldiktPmlvbW11X2Z3bm9kZSkpDQogICAgICAgICAgICAg
ICAgaW9ydF9pb21tdV9wdXRfcmVzdl9yZWdpb25zKGRldiwgbGlzdCk7DQogICAgICAgIGdlbmVy
aWNfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOw0KfQ0KDQppb3J0Og0KDQp2b2lk
IGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBs
aXN0X2hlYWQgKmhlYWQpIHsNCiAgICAgICAgc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0g
ZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KTsNCg0KICAgICAgICBpb3J0X2lvbW11X21zaV9nZXRf
cmVzdl9yZWdpb25zKGRldiwgaGVhZCk7DQogICAgICAgIGlvcnRfaW9tbXVfZ2V0X3JtcnMoZndz
cGVjLT5pb21tdV9md25vZGUsIGRldiwgaGVhZCk7DQp9DQoNCnZvaWQgaW9ydF9pb21tdV9wdXRf
cmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkg
ew0KICAgLi8qRnJlZSBib3RoIFJNUnMgYW5kIEhXIE1TSSBvbmVzICovDQp9DQoNCi8qIFRoZSBi
ZWxvdyBvbmVzIHdpbGwgYmUgZGlyZWN0bHkgY2FsbGVkIGZyb20gU01NVSBkcml2ZXJzIGR1cmlu
ZyByZXNldCAqLw0Kdm9pZCBpb3J0X2dldF9ybXJfc2lkcyhzdHJ1Y3QgZndub2RlX2hhbmRsZSAq
aW9tbXVfZndub2RlLCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKSB7DQogICAgICAgIGlvcnRfaW9t
bXVfZ2V0X3JtcnMoaW9tbXVfZndub2RlLCBOVUxMLCBoZWFkKTsgfQ0KfQ0KDQp2b2lkIGlvcnRf
cHV0X3Jtcl9zaWRzKHN0cnVjdCBmd25vZGVfaGFuZGxlICppb21tdV9md25vZGUsIHN0cnVjdCBs
aXN0X2hlYWQgKmhlYWQpIHsNCiAgICAgICAgaW9ydF9pb21tdV9wdXRfcmVzdl9yZWdpb25zKE5V
TEwsIGhlYWQpOw0KfQ0K
