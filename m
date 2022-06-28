Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404055CF36
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiF1H7r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiF1H7q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 03:59:46 -0400
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381871276E
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 00:59:45 -0700 (PDT)
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4LXH6Z2Y0wzTsLd;
        Tue, 28 Jun 2022 15:59:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:59:41 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 28 Jun 2022 08:59:39 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYgKBK6ZkZvzZxLEqm8BkaLnkVo61TfSMAgAs//6CABHLxAIABViUA
Date:   Tue, 28 Jun 2022 07:59:39 +0000
Message-ID: <26bbc80ddc7b4260b0d345913ed5ba1b@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
 <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
In-Reply-To: <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDI3IEp1bmUgMjAyMiAxMzoyNg0K
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsNCj4gU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT47IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBqb25Ac29s
aWQtcnVuLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBoY2hAaW5mcmFk
ZWFkLm9yZzsgR3VvaGFuanVuIChIYW5qdW4gR3VvKSA8Z3VvaGFuanVuQGh1YXdlaS5jb20+Ow0K
PiBTYW1pLk11amF3YXJAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyB3YW5naHVpcWlhbmcNCj4g
PHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEzIDAvOV0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBu
b2RlDQo+IA0KPiBPbiAyMDIyLTA2LTI0IDE2OjQ0LCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2Rp
IHZpYSBpb21tdSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IFN0ZXZlbiBQcmljZSBbbWFpbHRvOnN0ZXZlbi5wcmljZUBhcm0uY29t
XQ0KPiA+PiBTZW50OiAxNyBKdW5lIDIwMjIgMTM6NDINCj4gPj4gVG86IFNoYW1lZXJhbGkgS29s
b3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+
ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+ID4+
IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFy
bS5jb207DQo+ID4+IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207IHdpbGxA
a2VybmVsLm9yZzsNCj4gd2FuZ2h1aXFpYW5nDQo+ID4+IDx3YW5naHVpcWlhbmdAaHVhd2VpLmNv
bT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gPj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsg
U2FtaS5NdWphd2FyQGFybS5jb207DQo+IGpvbkBzb2xpZC1ydW4uY29tOw0KPiA+PiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IGxhdXJlbnRpdS50dWRvckBueHAuY29tOyBoY2hAaW5mcmFkZWFkLm9y
Zw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMyAwLzldIEFDUEkvSU9SVDogU3VwcG9ydCBm
b3IgSU9SVCBSTVIgbm9kZQ0KPiA+Pg0KPiA+PiBPbiAxNS8wNi8yMDIyIDExOjEwLCBTaGFtZWVy
IEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4gSGkNCj4gPj4+DQo+ID4+PiB2MTIgLS0+IHYxMw0KPiA+
Pj4gICAgLU5vIGNoYW5nZXMuIFJlYmFzZWQgdG8gNS4xOS1yYzEuDQo+ID4+PiAgICAtUGlja2Vk
IHVwIHRhZ3MgcmVjZWl2ZWQgZnJvbSBMYXVyZW50aXUsIEhhbmp1biBhbmQgV2lsbC4gVGhhbmtz
IS4NCj4gPj4NCj4gPj4gWW91J3ZlIGFscmVhZHkgZ290IG15IFRlc3RlZC1ieSB0YWdzLCBidXQg
anVzdCB0byBjb25maXJtIEkgZ2F2ZSB0aGlzIGENCj4gPj4gc3BpbiBhbmQgaXQgd29ya3MgZmlu
ZS4NCj4gPg0KPiA+IFRoYW5rcyBTdGV2ZS4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHNlcmllcyBp
cyBub3cgaW4gYSBnb29kIHNoYXBlIHRvIGJlIG1lcmdlZC4NCj4gPg0KPiA+IEhpIFdpbGwvUm9i
aW4sDQo+ID4NCj4gPiBBcHByZWNpYXRlLCBpZiB5b3UgY291bGQgcGxlYXNlIHRha2UgYSBsb29r
IGF0IHRoZSByZW1haW5pbmcgU01NVSByZWxhdGVkDQo+ID4gcGF0Y2hlcyg3LTkpIGFuZCBwcm92
aWRlIHlvdXIgYXBwcm92YWw/DQo+IA0KPiBJIHNhaWQgdjEyIGxvb2tlZCBmaW5lLCBidXQgZm9y
IHRoZSBhdm9pZGFuY2Ugb2YgZG91YnQsIGhlcmUgaXQgaXMNCj4gYWdhaW4sIGFzIGZvcm1hbGx5
IGFzIGNhbiBiZToNCj4gDQo+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPg0KDQpUaGFua3MgUm9iaW4uDQoNCkhpIEpvZXJnLA0KDQpOb3cgdGhhdCB3ZSBoYXZl
IGFsbCB0aGUgcmVxdWlyZWQgYWNrcywgY291bGQgeW91IHBsZWFzZSBwaWNrIHRoaXMgc2VyaWVz
IHZpYQ0KSU9NTVUgdHJlZT8NCg0KVGhhbmtzLA0KU2hhbWVlcg0K
