Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA3563831
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Jul 2022 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGAQnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Jul 2022 12:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGAQnN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2022 12:43:13 -0400
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841013D43
        for <linux-acpi@vger.kernel.org>; Fri,  1 Jul 2022 09:43:10 -0700 (PDT)
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4LZLb26StgzTwLq;
        Sat,  2 Jul 2022 00:42:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 2 Jul 2022 00:43:05 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Fri, 1 Jul 2022 17:43:04 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYgKBK6ZkZvzZxLEqm8BkaLnkVo61TfSMAgAs//6CABHLxAIABViUAgAVKlWA=
Date:   Fri, 1 Jul 2022 16:43:03 +0000
Message-ID: <9bcec024bba444caa0f60d37afd88b6b@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
 <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.16]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiBTZW50OiAyOCBKdW5lIDIwMjIgMDk6MDANCj4gVG86ICdSb2JpbiBNdXJw
aHknIDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IGpvcm9AOGJ5dGVzLm9yZzsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsN
Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gQ2M6IGpvbkBzb2xpZC1ydW4u
Y29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IGhjaEBpbmZyYWRlYWQub3Jn
OyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pIDxndW9oYW5qdW5AaHVhd2VpLmNvbT47DQo+IFNhbWku
TXVqYXdhckBhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1
aXFpYW5nQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IFN0ZXZlbiBQcmljZQ0K
PiA8c3RldmVuLnByaWNlQGFybS5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBnbWFpbC5jb20NCj4g
U3ViamVjdDogUkU6IFtQQVRDSCB2MTMgMC85XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQg
Uk1SIG5vZGUNCj4gPiA+IEhpIFdpbGwvUm9iaW4sDQo+ID4gPg0KPiA+ID4gQXBwcmVjaWF0ZSwg
aWYgeW91IGNvdWxkIHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgcmVtYWluaW5nIFNNTVUNCj4g
PiA+IHJlbGF0ZWQNCj4gPiA+IHBhdGNoZXMoNy05KSBhbmQgcHJvdmlkZSB5b3VyIGFwcHJvdmFs
Pw0KPiA+DQo+ID4gSSBzYWlkIHYxMiBsb29rZWQgZmluZSwgYnV0IGZvciB0aGUgYXZvaWRhbmNl
IG9mIGRvdWJ0LCBoZXJlIGl0IGlzDQo+ID4gYWdhaW4sIGFzIGZvcm1hbGx5IGFzIGNhbiBiZToN
Cj4gPg0KPiA+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0K
PiANCj4gVGhhbmtzIFJvYmluLg0KPiANCj4gSGkgSm9lcmcsDQo+IA0KPiBOb3cgdGhhdCB3ZSBo
YXZlIGFsbCB0aGUgcmVxdWlyZWQgYWNrcywgY291bGQgeW91IHBsZWFzZSBwaWNrIHRoaXMgc2Vy
aWVzIHZpYQ0KPiBJT01NVSB0cmVlPw0KDQpIaSBXaWxsLA0KDQpTaW5jZSBKb2VyZyBoYXNuJ3Qg
cmVwbGllZCB5ZXQsIGp1c3Qgd29uZGVyaW5nIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBpdCB0aHJv
dWdoIEFSTQ0KU01NVSB0cmVlIGlmIHRoYXQgbWFrZXMgc2Vuc2U/IERvbid0IHdhbnQgdG8gbWlz
cyB0aGUgNS4yMCBtZXJnZSB3aW5kb3cgZm9yIHRoaXMNCnNlcmllcy4NCg0KVGhhbmtzLA0KU2hh
bWVlcg0KDQoNCg==
