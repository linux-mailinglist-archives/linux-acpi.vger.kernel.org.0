Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039A2349627
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCYPzS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 11:55:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3386 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCYPy7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2021 11:54:59 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F5qP32fMvz5hBt;
        Thu, 25 Mar 2021 23:52:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 25 Mar 2021 23:54:55 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 23:54:54 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.013; Thu, 25 Mar 2021 15:54:52 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jon Nettleton <jon@solid-run.com>,
        "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Topic: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Index: AQHWvm1dfTBTih8pMEKAOph+J6BTAKqQitWggAQXOICAAP9lgA==
Date:   Thu, 25 Mar 2021 15:54:51 +0000
Message-ID: <acfab98e75434a59910cf56336c54ba2@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
 <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
In-Reply-To: <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.26.249]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIE5ldHRsZXRvbiBb
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAyNSBNYXJjaCAyMDIxIDA4OjQwDQo+
IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+DQo+IENjOiBlcmlrLmthbmVkYUBpbnRlbC5jb207IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBkZXZlbEBhY3BpY2Eub3JnOyBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47DQo+IHJvYmVydC5tb29y
ZUBpbnRlbC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gc3RldmVuLnBy
aWNlQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29t
PjsNCj4gU2FtaS5NdWphd2FyQGFybS5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyB3YW5naHVp
cWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQ
QVRDSCB2MiAxLzhdIEFDUElDQTogSU9SVDogVXBkYXRlIGZvciByZXZpc2lvbiBFDQoNClsuLi5d
DQoNCj4gV2VsbCBpdCB3YXMgYSByZWxlYXNlZCByZXZpc2lvbiwgYWx0aG91Z2ggaXQgd2FzIGZv
dW5kIHRvIGhhdmUgaXNzdWVzLg0KPiBDdXJyZW50bHkNCj4gSG9uZXlDb21iIFN5c3RlbXMgUmVh
ZHkgY2VydGlmaWVkIGZpcm13YXJlIGRvZXMgaW5jbHVkZSBzdXBwb3J0IGZvciB0aGlzDQo+IHRh
YmxlLA0KPiBhbHRob3VnaCBpbmNvbXBsZXRlLiAgV2l0aG91dCBhZ3JlZW1lbnQgb24gbWFpbmxp
bmUgc3VwcG9ydCBJIGFtIGZpbmUgdG8NCj4gdXBkYXRlDQo+IHRvIHRoZSBsYXRlc3Qgc3BlYyBi
dW1wLg0KDQpPay4gU29ycnkgZGlkbuKAmXQga25vdyB0aGF0IHlvdSBhbHJlYWR5IGhhZCBhIGZp
cm13YXJlIHdpdGggdGhhdCByZXZpc2lvbi4NClRoYW5rcyBmb3IgYWdyZWVpbmcgdG8gdXBkYXRl
IHRvIGxhdGVzdC4NCg0KPiA+DQo+ID4gU28gY291bGQgeW91IHBsZWFzZSByZXZlcnQgdGhlIG1l
cmdlIGFuZCBJIGFtIHBsYW5uaW5nIHRvIHdvcmsgb24gdGhlIEUuYg0KPiBzb29uLg0KPiA+IFBs
ZWFzZSBsZXQgbWUga25vdyBpZiBJIG5lZWQgdG8gZXhwbGljaXRseSBzZW5kIGEgcmV2ZXJ0IHB1
bGwgcmVxdWVzdCBvciBub3QuDQo+IA0KPiBDYW4geW91IHBsZWFzZSBDQy4gbWUgb24geW91ciBu
ZXh0IHJlbGVhc2UuICBJIHdhcyBwbGFubmluZyBvbiBzcGVuZGluZyB0aW1lDQo+IG9uIHRoaXMg
cmVnYXJkbGVzcy4gIEkgYWxyZWFkeSBoYXZlIGEgcGF0Y2hzZXQgZm9yIHRoZSBmc2wtbWMtYnVz
IGRyaXZlciB0aGF0DQo+IG5lZWRzIHRvIGNoYW5nZSBpbiBvcmRlciB0byBmdW5jdGlvbiBwcm9w
ZXJseSB3aXRoIFJNUiBzdXBwb3J0Lg0KDQpTdXJlLiBXaWxsIENDIHlvdS4NCg0KSGkgQWxsLA0K
DQpJIGhhdmUgc2VuZCBwdWxsIHJlcXVlc3RzIHRvIGFjcGljYSBnaXQgZm9yIHJldmVydGluZyBy
ZXYgRSBhbmQgdG8gdXBkYXRlIGl0IHdpdGggRS5iLA0KDQpodHRwczovL2dpdGh1Yi5jb20vYWNw
aWNhL2FjcGljYS9wdWxsLzY4Mg0KDQpQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=
