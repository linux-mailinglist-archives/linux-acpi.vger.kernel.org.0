Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD74ECA8
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUP50 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 11:57:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfFUP50 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 11:57:26 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 14549C23308867A67A7A;
        Fri, 21 Jun 2019 16:57:25 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.112]) by
 LHREML713-CAH.china.huawei.com ([10.201.108.36]) with mapi id 14.03.0415.000;
 Fri, 21 Jun 2019 16:57:15 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Vijaya Kumar K <vkilari@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Tomasz Nowicki <Tomasz.Nowicki@cavium.com>,
        Richard Ruigrok <rruigrok@qti.qualcomm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Topic: MPAM branch verification (was RE: [RFC PATCH 2/2] ACPI / PPTT:
 cacheinfo: Label caches based on fw_token)
Thread-Index: AdUoR6JBXCmGfD+rTvOGseVrKJ7QIA==
Date:   Fri, 21 Jun 2019 15:57:14 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F2B38FD@lhreml524-mbs.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
TW9yc2UgW21haWx0bzpqYW1lcy5tb3JzZUBhcm0uY29tXQ0KPiBTZW50OiAxOSBKdW5lIDIwMTkg
MTQ6MzENCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBW
aWpheWEgS3VtYXIgSyA8dmtpbGFyaUBjb2RlYXVyb3JhLm9yZz47DQo+IExvcmVuem8gUGllcmFs
aXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgSmVmZnJleSBIdWdvDQo+IDxqaHVnb0Bj
b2RlYXVyb3JhLm9yZz47IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBKZXJl
bXkNCj4gTGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+OyBUb21hc3ogTm93aWNraQ0KPiA8
VG9tYXN6Lk5vd2lja2lAY2F2aXVtLmNvbT47IFJpY2hhcmQgUnVpZ3Jvaw0KPiA8cnJ1aWdyb2tA
cXRpLnF1YWxjb21tLmNvbT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykNCj4gPGd1b2hhbmp1bkBo
dWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5j
b20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IExpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzJdIEFDUEkg
LyBQUFRUOiBjYWNoZWluZm86IExhYmVsIGNhY2hlcyBiYXNlZCBvbg0KPiBmd190b2tlbg0KPiAN
Cj4gSGkgU2hhbWVlciwNCj4gDQpbLi4uXSANCj4gPiBJIHdhcyBqdXN0IHRyeWluZyBvdXQgdGhl
IGxhdGVzdCBwdWJsaWMgTVBBTSBicmFuY2ggYXZhaWxhYmxlIGhlcmVbMV0NCj4gDQo+IEdyZWF0
IQ0KPiANCj4gDQo+ID4gYW5kIG5vdGVkIHRoYXQNCj4gPiBvbiBvdXIgSGlTaWxpY29uIHBsYXRm
b3JtIGFsbCB0aGUgTDMgY2FjaGUgd2VyZSBsYWJlbGVkIHdpdGggdGhlIHNhbWUgSWQuDQo+IERl
YnVnZ2luZz4gcmV2ZWFsZWQgdGhhdCB0aGUgYWJvdmUgbGVhZiBub2RlIGNoZWNrIHdhcyByZW1v
dmVkIGluIHRoaXMNCj4gYnJhbmNoWzJdIHdoaWNoIG1ha2VzDQo+ID4gdGhlIG1pbl9waHlzaWQg
Y2FsY3VsYXRpb24gZ29pbmcgd3JvbmcuDQo+IA0KPiBUaGFua3MgZm9yIGRlYnVnZ2luZyB0aGlz
LA0KPiANCj4gPiBKdXN0IHdvbmRlcmluZyBpcyB0aGVyZSBhbnkgcGFydGljdWxhciByZWFzb24N
Cj4gPiBmb3IgcmVtb3ZpbmcgdGhlIGNoZWNrIG9yIHRoZSBicmFuY2ggaXMgbm90IGNhcnJ5aW5n
IHRoZSBsYXRlc3QgcGF0Y2g/DQo+IA0KPiBOb3BlLCB0aGF0J3MgYSBidWcuDQo+IA0KPiBKZXJl
bXkgTGludG9uJ3MgcmV2aWV3IGZlZWRiYWNrWzBdIHdhcyB0aGF0IHRoYXQgUFJPQ0VTU09SX0lE
X1ZBTElEIGZsYWcNCj4gY2FuJ3QgYmUgcmVsaWVkDQo+IG9uLiBJdCBsb29rcyBsaWtlIEkgb3Zl
ci16ZWFsb3VzbHkgcmVtb3ZlZCB0aGUgd2hvbGUgaWYoKSwgYW5kIHRoaXMgZG9lc24ndCBjYXVz
ZSBhDQo+IHByb2JsZW0gd2l0aCBteSBwcHR0IHNvIEkgZGlkbid0IG5vdGljZS4NCj4gDQo+IEkn
dmUgZml4ZWQgaXQgbG9jYWxseSwgSSd2ZSBhbHNvIHB1c2hlZCBhIGZpeCB0byB0aG9zZSBicmFu
Y2hlcywgYnV0IGl0IHdpbGwgZ2V0IGZvbGRlZA0KPiBpbg0KPiBuZXh0IHRpbWUgSSBwdXNoIGEg
YnJhbmNoLg0KDQpUaGFua3MgZm9yIHRoYXQuDQoNCkFwYXJ0IGZyb20gdGhlIGFib3ZlLCBJIGhh
dmUgY29tZSBhY3Jvc3MgZmV3IG90aGVyIGlzc3VlcyBhcyB3ZWxsIGFuZCBoYWQgc29tZQ0KdGVt
cG9yYXJ5IGZpeGVzIHRvIHRoZSBicmFuY2ggaGVyZVswXS4gVGhpcyBpcyBlbmNvdW50ZXJlZCB3
aGlsZSB0cnlpbmcgdG8gZ2V0IHRoZQ0KcmVzY3RybCBmcyBtb3VudGVkIGFuZCBhdHRlbXB0ZWQg
YSBjcW0gdGVzdCBydW4gdXNpbmcgcmVzY3RybF90ZXN0cyB0b29sLiANCg0KVGhlIGZpeGVzIG1h
eSBub3QgYmUgcHJvcGVyIG9uZXMsIGJ1dCBJIHRoaW5rIGl0IHdpbGwgZ2l2ZSB5b3UgYW4gaWRl
YS4gUGxlYXNlIHRha2UgYQ0KbG9vayBhbmQgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCg0K
VGhhbmtzLA0KU2hhbWVlcg0KDQpbMF0gaHR0cHM6Ly9naXRodWIuY29tL2hpc2lsaWNvbi9rZXJu
ZWwtZGV2LmdpdCAgYnJhbmNoOiBwcml2YXRlLWRiZy1tcGFtLTUuMi1yYzENCg0KPiANCj4gVGhh
bmtzIQ0KPiANCj4gSmFtZXMNCj4gDQo+IFswXSBsb3JlLmtlcm5lbC5vcmcvci9hNjhhYmZkMi0x
ZTI4LWQ5ZTctOTE5YS04YjMxMzNkYjRkMjBAYXJtLmNvbQ0K
