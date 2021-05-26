Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB4391D2A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhEZQiZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 12:38:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3980 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhEZQiY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 12:38:24 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqxMT3LlxzQrmn;
        Thu, 27 May 2021 00:33:09 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 00:36:47 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 00:36:45 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Wed, 26 May 2021 17:36:44 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
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
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Topic: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Index: AQHXUIxzNCstxTr9F0iaZEElN6n+2Kr1Vn6AgACfpbA=
Date:   Wed, 26 May 2021 16:36:44 +0000
Message-ID: <260859e85c854b90b513599f4febfbad@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
In-Reply-To: <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.87.129]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudGl1IFR1ZG9y
IFttYWlsdG86bGF1cmVudGl1LnR1ZG9yQG54cC5jb21dDQo+IFNlbnQ6IDI2IE1heSAyMDIxIDA4
OjUzDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZw0KPiBDYzogam9uQHNvbGlkLXJ1bi5jb207IExpbnV4YXJtIDxsaW51eGFybUBo
dWF3ZWkuY29tPjsNCj4gc3RldmVuLnByaWNlQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVuIEd1
bykgPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsNCj4geWFuZ3lpY29uZyA8eWFuZ3lpY29uZ0BodWF3
ZWkuY29tPjsgU2FtaS5NdWphd2FyQGFybS5jb207DQo+IHJvYmluLm11cnBoeUBhcm0uY29tOyB3
YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDMvOF0gQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIG1lbW9y
eQ0KPiByZWdpb25zDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNS8yNC8yMDIxIDI6MDIg
UE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gQWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRo
YXQgcmV0cmlldmVzIFJNUiBtZW1vcnkgZGVzY3JpcHRvcnMNCj4gPiBhc3NvY2lhdGVkIHdpdGgg
YSBnaXZlbiBJT01NVS4gVGhpcyB3aWxsIGJlIHVzZWQgYnkgSU9NTVUNCj4gPiBkcml2ZXJzIHRv
IHNldHVwIG5lY2Vzc2FyeSBtYXBwaW5ncy4NCj4gPg0KPiA+IE5vdyB0aGF0IHdlIGhhdmUgdGhp
cywgaW52b2tlIGl0IGZyb20gdGhlIGdlbmVyaWMgaGVscGVyDQo+ID4gaW50ZXJmYWNlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYXJtNjQv
aW9ydC5jIHwgNTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgfCAgNCArKysrDQo+ID4gIGluY2x1ZGUvbGlu
dXgvYWNwaV9pb3J0LmggfCAgNyArKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQu
YyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gPiBpbmRleCBmZWExZmZhZWRmM2IuLjAx
OTE3Y2FmNThkZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jDQo+
ID4gKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYw0KPiA+IEBAIC0xMiw2ICsxMiw3IEBA
DQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGlfaW9ydC5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvYml0ZmllbGQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RtYS1pb21tdS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0KPiA+IEBAIC04MzcsNiArODM4LDUzIEBA
IHN0YXRpYyBpbmxpbmUgaW50IGlvcnRfYWRkX2RldmljZV9yZXBsYXkoc3RydWN0DQo+IGRldmlj
ZSAqZGV2KQ0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qKg0KPiA+ICsg
KiBpb3J0X2lvbW11X2dldF9ybXJzIC0gSGVscGVyIHRvIHJldHJpZXZlIFJNUiBpbmZvIGFzc29j
aWF0ZWQgd2l0aA0KPiBJT01NVQ0KPiA+ICsgKiBAaW9tbXU6IGZ3bm9kZSBmb3IgdGhlIElPTU1V
DQo+ID4gKyAqIEBoZWFkOiBSTVIgbGlzdCBoZWFkIHRvIGJlIHBvcHVsYXRlZA0KPiA+ICsgKg0K
PiA+ICsgKiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIDwwIGZhaWx1cmUNCj4gPiArICovDQo+ID4g
K2ludCBpb3J0X2lvbW11X2dldF9ybXJzKHN0cnVjdCBmd25vZGVfaGFuZGxlICppb21tdV9md25v
ZGUsDQo+ID4gKwkJCXN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBpb3J0X3Jtcl9lbnRyeSAqZTsNCj4gPiArCXN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9tbXU7
DQo+ID4gKwlpbnQgcm1ycyA9IDA7DQo+ID4gKw0KPiA+ICsJaW9tbXUgPSBpb3J0X2dldF9pb3J0
X25vZGUoaW9tbXVfZndub2RlKTsNCj4gPiArCWlmICghaW9tbXUgfHwgbGlzdF9lbXB0eSgmaW9y
dF9ybXJfbGlzdCkpDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeShlLCAmaW9ydF9ybXJfbGlzdCwgbGlzdCkgew0KPiA+ICsJCWludCBwcm90
ID0gSU9NTVVfUkVBRCB8IElPTU1VX1dSSVRFIHwgSU9NTVVfTk9FWEVDIHwNCj4gSU9NTVVfTU1J
TzsNCj4gDQo+IFdlIGhhdmUgYSBjYXNlIHdpdGggYW4gSVAgYmxvY2sgdGhhdCBuZWVkcyBFWEVD
IHJpZ2h0cyBvbiBpdHMgcmVzZXJ2ZWQNCj4gbWVtb3J5LCBzbyBjb3VsZCB5b3UgcGxlYXNlIGRy
b3AgdGhlIElPTU1VX05PRVhFQyBmbGFnPw0KDQpPaywgSSB0aGluayBJIGNhbiBkcm9wIHRoYXQg
b25lIGlmIHRoZXJlIGFyZSBubyBvdGhlciBjb25jZXJucy4gSSB3YXMgbm90IHF1aXRlDQpzdXJl
IHdoYXQgdG8gaW5jbHVkZSBoZXJlIGluIHRoZSBmaXJzdCBwbGFjZSBhcyB0aGUgSU9SVCBzcGVj
IGlzIG5vdCBnaXZpbmcgYW55DQpmdXJ0aGVyIGRldGFpbHMgYWJvdXQgdGhlIFJNUiByZWdpb25z
KE1heSBiZSB0aGUgZmxhZ3MgZmllbGQgY2FuIGJlIGV4dGVuZGVkIHRvDQpkZXNjcmliZSB0aGVz
ZSBkZXRhaWxzKS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQogICANCg==
