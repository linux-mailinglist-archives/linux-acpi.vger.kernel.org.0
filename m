Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA0520E9C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 May 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiEJHjC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 May 2022 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiEJH16 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 May 2022 03:27:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E581AD59A
        for <linux-acpi@vger.kernel.org>; Tue, 10 May 2022 00:23:58 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ky8dJ6FNCz1JC5f;
        Tue, 10 May 2022 15:22:44 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:23:55 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:23:54 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 10 May 2022 08:23:52 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYXwu3gTgIMyz0zUiu6Dja1BmGsa0PbqaAgAhOLiA=
Date:   Tue, 10 May 2022 07:23:52 +0000
Message-ID: <8e4f012717e34195a53cb73f8ce28627@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
In-Reply-To: <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
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

SGkgSm9lcmcvUm9iaW4sDQoNCkkgdGhpbmsgdGhpcyBzZXJpZXMgaXMgbm93IHJlYWR5IHRvIGJl
IG1lcmdlZC4gQ291bGQgeW91IHBsZWFzZSBsZXQNCm1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhp
bmcgbWlzc2luZy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gU2VudDogMDUgTWF5IDIw
MjIgMDI6MjQNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5
QGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsgd2FuZ2h1aXFpYW5nDQo+IDx3YW5naHVpcWlhbmdA
aHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOw0KPiBTYW1pLk11amF3YXJAYXJtLmNv
bTsgam9uQHNvbGlkLXJ1bi5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gbGF1cmVudGl1
LnR1ZG9yQG54cC5jb207IGhjaEBpbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEyIDAvOV0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+IA0KPiBPbiAy
MDIyLzUvNCAwOjMzLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhpDQo+ID4NCj4gPiB2
MTEgLS0+IHYxMg0KPiA+ICAgIC1NaW5vciBmaXggaW4gcGF0Y2ggIzQgdG8gYWRkcmVzcyB0aGUg
aXNzdWUgcmVwb3J0ZWQgYnkgdGhlIGtlcm5lbCB0ZXN0DQo+IHJvYm90Lg0KPiA+ICAgIC1BZGRl
ZCBSLWJ5IHRhZ3MgYnkgQ2hyaXN0b3BoKHBhdGNoICMxKSBhbmQgTG9yZW56byhwYXRjaCAjNCku
DQo+ID4gICAgLUFkZGVkIFQtYnkgZnJvbSBTdGV2ZSB0byBhbGwgcmVsZXZhbnQgcGF0Y2hlcy4g
TWFueSB0aGFua3MhLg0KPiA+DQo+ID4gUGxlYXNlIG5vdGUsIHRoaXMgc2VyaWVzIGhhcyBhIGRl
cGVuZGVuY3kgb24gdGhlIEFDUElDQSBoZWFkZXIgcGF0Y2gNCj4gPiBoZXJlWzFdLg0KPiANCj4g
VGVzdGVkIG9uIGEgS3VucGVuZzkyMCBzZXJ2ZXIgbWFjaGluZSB3aXRoIFNNTVV2MywgdGhlIDM0
MDhpTVIgUkFJRA0KPiBjb250cm9sbGVyIGNhcmQgd29ya3MgYXMgZXhwZWN0ZWQsDQo+IA0KPiBU
ZXN0ZWQtYnk6IEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3ZWkuY29tPg0KPiANCj4gVGhhbmtz
DQo+IEhhbmp1bg0K
