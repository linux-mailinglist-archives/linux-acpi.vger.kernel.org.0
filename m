Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF155066F8
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiDSIeq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbiDSIep (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 04:34:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F43013D23
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 01:32:01 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjH8l6Z68zhXXK;
        Tue, 19 Apr 2022 16:31:51 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:31:58 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:31:57 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 19 Apr 2022 09:31:55 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYSCG95Y0d6z1dQEidSJE+wh/QIqzkZagAgAAHFACAAAGmAIASjl6g
Date:   Tue, 19 Apr 2022 08:31:55 +0000
Message-ID: <955601f02f3b474da3327963fb1630f0@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
 <Yk7uRPG1TwGFPbyY@infradead.org>
In-Reply-To: <Yk7uRPG1TwGFPbyY@infradead.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoIEhlbGx3
aWcgW21haWx0bzpoY2hAaW5mcmFkZWFkLm9yZ10NCj4gU2VudDogMDcgQXByaWwgMjAyMiAxNTow
MA0KPiBUbzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gQ2M6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IGpvbkBzb2xpZC1y
dW4uY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBh
cm0uY29tOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+
OyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHlhbmd5
aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47DQo+IFNhbWkuTXVqYXdhckBhcm0uY29tOyB3
aWxsQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDA2LzExXSBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0IHRv
IHJldHJpZXZlIElPUlQgUk1SDQo+IHJlc2VydmVkIHJlZ2lvbnMNCj4gDQo+IE9uIFRodSwgQXBy
IDA3LCAyMDIyIGF0IDAyOjUzOjM4UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gPiA+
IFdoeSBjYW4ndCB0aGlzIGp1c3QgZ28gaW50byBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lv
bnM/ICBUaGUgaWRlYQ0KPiA+ID4gdGhhdCB0aGUgaW9tbXUgbG93LWxldmVsIGRyaXZlcnMgbmVl
ZCB0byBjYWxsIGludG8gZG1hLWlvbW11IHdoaWNoIGlzDQo+ID4gPiBhIGNvbnN1bWVyIG9mIHRo
ZSBJT01NVSBBUEkgaXMgb2RkLiAgRXNwZWNpYWxseSBpZiB0aGF0IGp1c3QgY2FsbHMgb3V0DQo+
ID4gPiB0byBBQ1BJIGNvZGUgYW5kIGdlbmVyaWMgSU9NTVUgY29kZSBvbmx5IGFueXdheS4NCj4g
Pg0KPiA+IEJlY2F1c2UgYXNzdW1pbmcgQUNQSSBtZWFucyBJT1JUIGlzIG5vdCBnZW5lcmljLiBQ
YXJ0IG9mIHRoZSBhaW0gaW4gYWRkaW5nDQo+ID4gdGhlIHVuaW9uIHRvIGlvbW11X3Jlc3ZfcmVn
aW9uIGlzIHRoYXQgc3R1ZmYgbGlrZSBBTUQncyB1bml0eV9tYXBfZW50cnkNCj4gYW5kDQo+ID4g
SW50ZWwncyBkbWFyX3JtcnJfdW5pdCBjYW4gYmUgZm9sZGVkIGludG8gaXQgYXMgd2VsbCwgYW5k
IHRoZWlyIHJlc2VydmVkDQo+ID4gcmVnaW9uIGhhbmRsaW5nIGNvcnJlc3BvbmRpbmdseSBzaW1w
bGlmaWVkIHRvby4NCj4gPg0KPiA+IFRoZSBpb21tdV9kbWFfe2dldCxwdXR9X3Jlc3ZfcmVnaW9u
KCkgaGVscGVycyBhcmUga2luZCBvZiBpbnRlbmRlZCB0byBiZQ0KPiA+IHNwZWNpZmljIHRvIHRo
ZSBmd25vZGUgbWVjaGFuaXNtIHdoaWNoIGRlYWxzIHdpdGggSU9SVCBhbmQgZGV2aWNldHJlZQ0K
PiAob25jZQ0KPiA+IHRoZSByZXNlcnZlZCByZWdpb24gYmluZGluZ3MgYXJlIGZ1bGx5IHdvcmtl
ZCBvdXQpLg0KPiANCj4gQnV0IElPUlQgaXMgbm90IGRyaXZlcuKCi3NwZWNpZmljIGNvZGUuICBT
byB3ZSdsbCBuZWVkIGEgVVNFX0lPUlQgZmxhZw0KPiBzb21ld2hlcmUgaW4gY29yZSBJT01NVSBj
b2RlIGluc3RlYWQgb2YgdHJ5aW5nIHRvIHN0dWZmIHRoaXMgaW50bw0KPiBkcml2ZXIgb3BlcmF0
aW9ucy4gIGFuZCBkbWEtaW9tbXUgbW9zdGx5IGNlcnRhaW5seSBpbXBsaWVzIElPUlQgZXZlbg0K
PiBsZXNzIHRoYW4gQUNQSS4NCg0KU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlKHdhcyBv
biBob2xpZGF5cykuIFNvIGlmIHdlIG1vdmUgdGhlDQppb21tdV9kbWFfcHV0X3Jlc3ZfcmVnaW9u
KCkgY2FsbCB0byBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMoKSAsDQp3aWxsIHRoYXQg
YWRkcmVzcyB0aGUgY29uY2VybnMgaGVyZT8NCg0KSSB0aGluayBpdCB3aWxsIHJlc29sdmUgdGhl
IGlzc3VlIGluIDA1LzExIGFzIHdlbGwgcG9pbnRlZCBvdXQgYnkgQ2hyaXN0b3BoDQp3aGVyZSB3
ZSBlbmQgdXAgbm90IHJlbGVhc2luZyByZXNlcnZlZCByZWdpb25zIHdoZW4NCkNPTkZJR19JT01N
VV9ETUEgaXMgbm90IHNldC4NCg0KU29tZXRoaW5nIGxpa2UgYmVsb3csDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCmluZGV4IGYy
YzQ1Yjg1YjlmYy4uZDA4MjA0YTI1YmE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21t
dS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCkBAIC0yNjA1LDYgKzI2MDUsOCBAQCB2
b2lkIGdlbmVyaWNfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QNCmRldmljZSAqZGV2LCBz
dHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0KIHsNCiAgICAgICAgc3RydWN0IGlvbW11X3Jlc3ZfcmVn
aW9uICplbnRyeSwgKm5leHQ7DQoNCisgICAgICAgaW9tbXVfZG1hX3B1dF9yZXN2X3JlZ2lvbnMo
ZGV2LCBsaXN0KTsNCisNCiAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGVudHJ5LCBu
ZXh0LCBsaXN0LCBsaXN0KQ0KICAgICAgICAgICAgICAgIGtmcmVlKGVudHJ5KTsNCiB9DQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYw0KaW5kZXggNTgxMTIzM2RjOWZiLi44Y2IxZTQxOWRiNDkgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L2RtYS1pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
DQpAQCAtMzkzLDggKzM5Myw2IEBAIHZvaWQgaW9tbXVfZG1hX3B1dF9yZXN2X3JlZ2lvbnMoc3Ry
dWN0IGRldmljZQ0KKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkNCiB7DQogICAgICAgIGlm
ICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpLT5pb21tdV9md25vZGUpKQ0K
ICAgICAgICAgICAgICAgIGlvcnRfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOw0K
LQ0KLSAgICAgICBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsNCiB9
DQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGlzIGlzIG5vdCBnb29kIGVub3VnaC4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0K
