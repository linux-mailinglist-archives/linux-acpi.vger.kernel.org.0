Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B627A559E12
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiFXQEg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 12:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiFXQEf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 12:04:35 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 09:04:33 PDT
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9049903
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 09:04:33 -0700 (PDT)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4LV1bX1QPrzwSQQ;
        Fri, 24 Jun 2022 23:42:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 23:44:44 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Fri, 24 Jun 2022 16:44:42 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Steven Price <steven.price@arm.com>,
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
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYgKBK6ZkZvzZxLEqm8BkaLnkVo61TfSMAgAs//6A=
Date:   Fri, 24 Jun 2022 15:44:42 +0000
Message-ID: <44338c87254d4d439d29694de8f19435@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
In-Reply-To: <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVuIFByaWNlIFtt
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDE3IEp1bmUgMjAyMiAxMzo0Mg0K
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsg
d2lsbEBrZXJuZWwub3JnOyB3YW5naHVpcWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29t
PjsgR3VvaGFuanVuIChIYW5qdW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBTYW1p
Lk11amF3YXJAYXJtLmNvbTsgam9uQHNvbGlkLXJ1bi5jb207DQo+IGVyaWMuYXVnZXJAcmVkaGF0
LmNvbTsgbGF1cmVudGl1LnR1ZG9yQG54cC5jb207IGhjaEBpbmZyYWRlYWQub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEzIDAvOV0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBu
b2RlDQo+IA0KPiBPbiAxNS8wNi8yMDIyIDExOjEwLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0K
PiA+IEhpDQo+ID4NCj4gPiB2MTIgLS0+IHYxMw0KPiA+ICAgLU5vIGNoYW5nZXMuIFJlYmFzZWQg
dG8gNS4xOS1yYzEuDQo+ID4gICAtUGlja2VkIHVwIHRhZ3MgcmVjZWl2ZWQgZnJvbSBMYXVyZW50
aXUsIEhhbmp1biBhbmQgV2lsbC4gVGhhbmtzIS4NCj4gDQo+IFlvdSd2ZSBhbHJlYWR5IGdvdCBt
eSBUZXN0ZWQtYnkgdGFncywgYnV0IGp1c3QgdG8gY29uZmlybSBJIGdhdmUgdGhpcyBhDQo+IHNw
aW4gYW5kIGl0IHdvcmtzIGZpbmUuDQoNClRoYW5rcyBTdGV2ZS4NCg0KSSB0aGluayB0aGUgc2Vy
aWVzIGlzIG5vdyBpbiBhIGdvb2Qgc2hhcGUgdG8gYmUgbWVyZ2VkLg0KDQpIaSBXaWxsL1JvYmlu
LA0KDQpBcHByZWNpYXRlLCBpZiB5b3UgY291bGQgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSBy
ZW1haW5pbmcgU01NVSByZWxhdGVkIA0KcGF0Y2hlcyg3LTkpIGFuZCBwcm92aWRlIHlvdXIgYXBw
cm92YWw/DQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gU3RldmUN
Cj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gU2hhbWVlcg0KPiA+DQo+ID4gRnJvbSBvbGQ6DQo+
ID4gV2UgaGF2ZSBmYWNlZCBpc3N1ZXMgd2l0aCAzNDA4aU1SIFJBSUQgY29udHJvbGxlciBjYXJk
cyB3aGljaA0KPiA+IGZhaWwgdG8gYm9vdCB3aGVuIFNNTVUgaXMgZW5hYmxlZC4gVGhpcyBpcyBi
ZWNhdXNlIHRoZXNlDQo+ID4gY29udHJvbGxlcnMgbWFrZSB1c2Ugb2YgaG9zdCBtZW1vcnkgZm9y
IHZhcmlvdXMgY2FjaGluZyByZWxhdGVkDQo+ID4gcHVycG9zZXMgYW5kIHdoZW4gU01NVSBpcyBl
bmFibGVkIHRoZSBpTVIgZmlybXdhcmUgZmFpbHMgdG8NCj4gPiBhY2Nlc3MgdGhlc2UgbWVtb3J5
IHJlZ2lvbnMgYXMgdGhlcmUgaXMgbm8gbWFwcGluZyBmb3IgdGhlbS4NCj4gPiBJT1JUIFJNUiBw
cm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBkZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNlDQo+ID4g
bWVtb3J5IHJlZ2lvbnMgc28gdGhhdCB0aGUga2VybmVsIGNhbiBtYWtlIGEgdW5pdHkgbWFwcGlu
ZyBmb3INCj4gPiB0aGVzZSBpbiBTTU1VLg0KPiA+DQo+ID4gQ2hhbmdlIEhpc3Rvcnk6DQo+ID4N
Cj4gPiB2MTEgLS0+IHYxMg0KPiA+ICAgLU1pbm9yIGZpeCBpbiBwYXRjaCAjNCB0byBhZGRyZXNz
IHRoZSBpc3N1ZSByZXBvcnRlZCBieSB0aGUga2VybmVsIHRlc3QNCj4gcm9ib3QuDQo+ID4gICAt
QWRkZWQgUi1ieSB0YWdzIGJ5IENocmlzdG9waChwYXRjaCAjMSkgYW5kIExvcmVuem8ocGF0Y2gg
IzQpLg0KPiA+ICAgLUFkZGVkIFQtYnkgZnJvbSBTdGV2ZSB0byBhbGwgcmVsZXZhbnQgcGF0Y2hl
cy4gTWFueSB0aGFua3MhLg0KPiA+DQo+ID4gdjEwIC0tPiB2MTENCj4gPiDCoC1BZGRyZXNzZWQg
Q2hyaXN0b3BoJ3MgY29tbWVudHMuIFdlIG5vdyBoYXZlIGEgwqBjYWxsYmFjayB0bw0KPiA+ICAg
c3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIHRvIGZyZWUgYWxsIHJlbGF0ZWQgbWVtb3J5IGFuZCBh
bHNvwqBkcm9wcGVkDQo+ID4gICB0aGUgRlcgc3BlY2lmaWMgdW5pb24gYW5kIG5vdyBoYXMgYSBj
b250YWluZXIgc3RydWN0DQo+IGlvbW11X2lvcnRfcm1yX2RhdGEuDQo+ID4gICBTZWUgcGF0Y2hl
cyAjMSAmICM0DQo+ID4gIC1BZGRlZCBSLWJ5IGZyb20gQ2hyaXN0b3BoLg0KPiA+ICAtRHJvcHBl
ZCBSLWJ5IGZyb20gTG9yZW56byBmb3IgcGF0Y2hlcyAjNCAmICM1IGR1ZSB0byB0aGUgYWJvdmUN
Cj4gY2hhbmdlcy4NCj4gPiAgLUFsc28gZHJvcHBlZCBULWJ5IGZyb20gU3RldmUgYW5kIExhdXJl
bnRpdS4gTWFueSB0aGFua3PCoGZvciB5b3VyIHRlc3QNCj4gPiAgIGVmZm9ydHMuIEkgaGF2ZcKg
ZG9uZSBiYXNpYyBzYW5pdHkgdGVzdGluZyBvbiBteSBwbGF0Zm9ybSBidXQgcGxlYXNlDQo+ID4g
ICBkbyBpdCBhZ2FpbiBhdCB5b3VyIGVuZC4NCj4gPg0KPiA+IHY5IC0tPiB2MTANCj4gPiAgLSBE
cm9wcGVkIHBhdGNoICMxICgiQWRkIHRlbXBvcmFyeSBSTVIgbm9kZSBmbGFnIGRlZmluaXRpb25z
Iikgc2luY2UNCj4gPiAgICB0aGUgQUNQSUNBIGhlYWRlciB1cGRhdGVzIHBhdGNoIGlzIG5vdyBp
biB0aGUgbWFpbGluZyBsaXN0DQo+ID4gIC0gQmFzZWQgb24gdGhlIHN1Z2dlc3Rpb24gZnJvbSBD
aHJpc3RvcGgsIGludHJvZHVjZWQgYQ0KPiA+ICAgIHJlc3ZfcmVnaW9uX2ZyZWVfZndfZGF0YSgp
IGNhbGxiYWNrIGluIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBhbmQNCj4gPiAgICB1c2VkIHRo
YXQgdG8gZnJlZSBSTVIgc3BlY2lmaWMgbWVtb3J5IGFsbG9jYXRpb25zLg0KPiA+DQo+ID4gdjgg
LS0+IHY5DQo+ID4gwqAtIEFkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4gb24gaW50ZXJmYWNl
cy4NCj4gPiDCoC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gTG9yZW56by4NCj4gPg0KPiA+IHY3
IC0tPiB2OA0KPiA+IMKgIC0gUGF0Y2ggIzEgaGFzIHRlbXAgZGVmaW5pdGlvbnMgZm9yIFJNUiBy
ZWxhdGVkIGNoYW5nZXMgdGlsbA0KPiA+IMKgIMKgIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5nZXMg
YXJlIHBhcnQgb2Yga2VybmVsLg0KPiA+IMKgIC0gTm8gZWFybHkgcGFyc2luZyBvZiBSTVIgbm9k
ZSBpbmZvIGFuZCBpcyBvbmx5IHBhcnNlZCBhdCB0aGUNCj4gPiDCoCDCoCB0aW1lIG9mIHVzZS4N
Cj4gPiDCoCAtIENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQg
dG8gdGhlDQo+ID4gwqAgwqAgcHJldmlvdXMgdmVyc2lvbi4NCj4gPiDCoCAtIFN1cHBvcnQgZm9y
IFJNUiBkZXNjcmlwdG9yIHNoYXJlZCBieSBtdWx0aXBsZSBzdHJlYW0gSURzLg0KPiA+DQo+ID4g
djYgLS0+IHY3DQo+ID4gwqAtZml4IHBvaW50ZWQgb3V0IGJ5IFN0ZXZlIHRvIHRoZSBTTU1VdjIg
U01SIGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4Lg0KPiA+DQo+ID4gdjUgLS0+IHY2DQo+ID4g
LSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSb2JpbiAmIExvcmVuem8uDQo+ID4gwqAgOiBNb3Zl
ZCBpb3J0X3BhcnNlX3JtcigpIHRvIGFjcGlfaW9ydF9pbml0KCkgZnJvbQ0KPiA+IMKgIMKgIGlv
cnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKCkuDQo+ID4gwqAgOiBSZW1vdmVkIHVzZSBvZiBzdHJ1
Y3QgaW9ydF9ybXJfZW50cnkgZHVyaW5nIHRoZSBpbml0aWFsDQo+ID4gwqAgwqAgcGFyc2UuIFVz
aW5nIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBpbnN0ZWFkLg0KPiA+IMKgIDogUmVwb3J0IFJN
UiBhZGRyZXNzIGFsaWdubWVudCBhbmQgb3ZlcmxhcCBlcnJvcnMsIGJ1dCBjb250aW51ZS4NCj4g
PiDCoCA6IFJld29ya2VkIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4N
Cj4gPiAtIFVwZGF0ZWQgU01NVXYyIGJ5cGFzcyBTTVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChw
YXRjaCAjOCkuDQo+ID4gLSBTZXQgSU9NTVUgcHJvdGVjdGlvbiBmbGFncyhJT01NVV9DQUNIRSwg
SU9NTVVfTU1JTykgYmFzZWQNCj4gPiDCoCBvbiBUeXBlIG9mIFJNUiByZWdpb24uIFN1Z2dlc3Rl
ZCBieSBKb24gTi4NCj4gPg0KPiA+IHY0IC0tPiB2NQ0KPiA+IMKgLUFkZGVkIGEgZndfZGF0YSB1
bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5kIHJlbW92ZWQNCj4gPiDCoCBzdHJ1
Y3QgaW9tbXVfcm1yIChCYXNlZCBvbiBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4NCj4gPiDC
oC1BZGRlZCBpb21tdV9wdXRfcm1ycygpIHRvIHJlbGVhc2UgbWVtLg0KPiA+IMKgLVRoYW5rcyB0
byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9uIFNNTVV2MiwgYnV0IG5vdCBhZGRlZCB0aGUgVGVzdGVk
LWJ5DQo+ID4gwqAgeWV0IGJlY2F1c2Ugb2YgdGhlIGFib3ZlIGNoYW5nZXMuDQo+ID4NCj4gPiB2
MyAtLT52NA0KPiA+IC1JbmNsdWRlZCB0aGUgU01NVXYyIFNNUiBieXBhc3MgaW5zdGFsbCBjaGFu
Z2VzIHN1Z2dlc3RlZCBieQ0KPiA+IMKgU3RldmUocGF0Y2ggIzcpDQo+ID4gLUFzIHBlciBSb2Jp
bidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBpbXBsZW1lbnRhdGlvbiBpcyBub3cNCj4gPiDCoG1v
cmUgZ2VuZXJpYyDCoChwYXRjaCAjOCkgYW5kIGRyb3BwZWQgdjMgcGF0Y2hlcyA4IGFuZCAxMC4N
Cj4gPiAtUmViYXNlIHRvIDUuMTMtcmMxDQo+ID4NCj4gPiBSRkMgdjIgLS0+IHYzDQo+ID4gwqAt
RHJvcHBlZCBSRkMgdGFnIGFzIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5nZXMgYXJlIG5vdyByZWFk
eSB0byBiZQ0KPiA+IMKgIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhh
cyBhIGRlcGVuZGVuY3kgb24gdGhhdCBwYXRjaC4NCj4gPiDCoC1BZGRlZCBJT1JUIEUuYiByZWxh
dGVkIGNoYW5nZXMobm9kZSBmbGFncywgX0RTTSBmdW5jdGlvbiA1IGNoZWNrcyBmb3INCj4gPiDC
oCBQQ0llKS4NCj4gPiDCoC1DaGFuZ2VkIFJNUiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06
TiB0byBNOjEgYXMgcGVyIHRoZSBzcGVjDQo+IGFuZA0KPiA+IMKgIGRpc2N1c3Npb24gaGVyZVsx
XS4NCj4gPiDCoC1MYXN0IHR3byBwYXRjaGVzIGFkZCBzdXBwb3J0IGZvciBTTU1VdjIoVGhhbmtz
IHRvIEpvbiBOZXR0bGV0b24hKQ0KPiA+DQo+ID4gSm9uIE5ldHRsZXRvbiAoMSk6DQo+ID4gICBp
b21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNz
IFNNUg0KPiA+DQo+ID4gU2hhbWVlciBLb2xvdGh1bSAoOCk6DQo+ID4gICBpb21tdTogSW50cm9k
dWNlIGEgY2FsbGJhY2sgdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uDQo+ID4gICBBQ1BJL0lP
UlQ6IE1ha2UgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucygpIHJldHVybiB2b2lkDQo+
ID4gICBBQ1BJL0lPUlQ6IFByb3ZpZGUgYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSByZXNl
cnZlIHJlZ2lvbnMNCj4gPiAgIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQgdG8gcmV0cmlldmUgSU9S
VCBSTVIgcmVzZXJ2ZWQgcmVnaW9ucw0KPiA+ICAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8g
cmV0cmlldmUgUk1SIGluZm8gZGlyZWN0bHkNCj4gPiAgIGlvbW11L2FybS1zbW11LXYzOiBJbnRy
b2R1Y2Ugc3RydGFiIGluaXQgaGVscGVyDQo+ID4gICBpb21tdS9hcm0tc21tdS12MzogUmVmYWN0
b3IgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlDQo+ID4gICAgIGJ5cGFzcw0K
PiA+ICAgaW9tbXUvYXJtLXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0
YWxsIGJ5cGFzcyBTVEUNCj4gPg0KPiA+ICBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jICAgICAg
ICAgICAgICAgICAgIHwgMzYwDQo+ICsrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAgNzggKysrKy0NCj4gPiAgZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyAgICAgICB8ICA1MiArKysNCj4gPiAg
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+
ICBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQo+
ID4gIGluY2x1ZGUvbGludXgvYWNwaV9pb3J0LmggICAgICAgICAgICAgICAgICAgfCAgMTQgKy0N
Cj4gPiAgaW5jbHVkZS9saW51eC9pb21tdS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCAr
DQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgNDg2IGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygt
KQ0KPiA+DQo+IA0KDQo=
