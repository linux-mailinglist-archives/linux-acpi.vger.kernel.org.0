Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2B27D380
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgI2QVm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 12:21:42 -0400
Received: from smtp.asem.it ([151.1.184.197]:57393 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgI2QVm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 12:21:42 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000512618.MSG 
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 18:21:39 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 18:21:38 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Tue, 29 Sep 2020 18:21:38 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0A==
Date:   Tue, 29 Sep 2020 16:21:38 +0000
Message-ID: <feb8567c830748c483c8c66dd4717003@asem.it>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
In-Reply-To: <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020C.5F735F12.008F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSBhbmQgQmFydG9zeiwNCg0KPiA+ID4NCj4gPiA+IEkgbmVlZCB0byBleHBvc2UgdG8g
dGhlIHVzZXJzcGFjZSBhIEdQSU8sIHBoeXNpY2FsbHkgY29ubmVjdGVkIHRvIGENCj4gYm9hcmQN
Cj4gPiA+IHB1c2gtYnV0dG9uLiBUaGlzIEdQSU8gbXVzdCBleHBvc2UgYSBwcmUtZGVmaW5lZCBu
YW1lLCBzdWNoIGFzDQo+ID4gPiAidXNlci1wdXNoLWJ1dHRvbiIsIHNvIHRoYXQgdGhlIHVzZXJz
cGFjZSBhcHBsaWNhdGlvbnMgY2FuIHVzZSBpdA0KPiB3aXRob3V0DQo+ID4gPiBrbm93IGFueSBw
aHlzaWNhbCBHUElPIGRldGFpbHMuDQo+ID4gPg0KPiA+ID4gSSBjYW4gY3VzdG9taXplIHRoZSBi
b2FyZCBCSU9TIGFuZCBzbyBteSBnb2FsIGlzIHRvIGFkZCBhbiBBQ1BJIHRhYmxlDQo+IHdpdGgN
Cj4gPiA+IGEgY29udGVudCBsaWtlIHRoaXM6DQo+ID4gPg0KPiA+ID4gLi4uDQo+ID4gPiBTY29w
ZSAoXF9TQi5HUE8xKQ0KPiA+ID4gICAgICAgICB7DQo+ID4gPiAgICAgICAgICAgICAgICAgRGV2
aWNlIChCVE5TKQ0KPiA+ID4gICAgICAgICAgICAgICAgIHsNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIE5hbWUgKF9ISUQsICJQUlAwMDAxIikNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIE5hbWUgKF9ERE4sICJHUElPIGJ1dHRvbnMgZGV2aWNlIikNCj4gPiA+DQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpDQo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEdwaW9JbyAoDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEV4Y2x1c2l2ZSwgICAgICAgICAgICAgICAvLyBOb3Qgc2hhcmVkDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFB1bGxOb25lLCAgICAgICAgICAgICAgICAvLyBObyBu
ZWVkDQo+IGZvciBwdWxscw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAw
LCAgICAgICAgICAgICAgICAgICAgICAgLy8gRGVib3VuY2UNCj4gdGltZW91dA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAgICAgICAgICAgICAgICAgICAgICAgLy8g
RHJpdmUNCj4gc3RyZW5ndGgNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
SW9SZXN0cmljdGlvbklucHV0T25seSwgIC8vIE9ubHkgdXNlZA0KPiBhcyBpbnB1dA0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiXFxfU0IuR1BPMSIsICAgICAgICAgICAg
Ly8gR1BJTw0KPiBjb250cm9sbGVyDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAsIFJlc291cmNlQ29uc3VtZXIsICwgKSAvLyBNdXN0IGJlIDANCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgew0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDI1LCAgICAgICAgICAgICAgLy8gR1BJTw0KPiBudW1iZXINCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gLi4uDQo+ID4gPg0KPiA+
ID4gSSBrbm93IHRoYXQgdGhpcyBHUElPIGNhbiBiZSB1c2VkIGZyb20gb3RoZXIgZHJpdmVycy4N
Cj4gPiA+IEZvciBleGFtcGxlIEkgc3VjY2Vzc2Z1bGx5IHRlc3RlZCBpdCB1c2luZyB0aGUgImdw
aW8ta2V5cyIgZGV2aWNlDQo+IGRyaXZlciwNCj4gPiA+IGdpdmluZyB0byBteSBHUElPIGEga2V5
LWNvZGUgYW5kIGVtdWxhdGluZyBpbiB0aGlzIHdheSBhIGtleWJvYXJkIGtleS4NCj4gPiA+IFRo
aXMgY291bGQgYmUgYSBwb3NzaWJsZSBzb2x1dGlvbi4NCj4gPiA+DQo+ID4gPiBCdXQgSSBwcmVm
ZXIgdG8gZXhwb3NlIG15IEdQSU8gYXMgYSBjbGFzc2ljIEdQSU8sIG5vdCBhcyBhIGtleWJvYXJk
DQo+IGtleS4NCj4gPiA+DQo+ID4gPiBJIHdhcyB3b25kZXJpbmcgaWYgdGhlcmUgaXMgYSBnZW5l
cmljIEdQSU8gZHJpdmVyIHRoYXQgSSBjYW4gdXNlIHRvDQo+IGV4cG9zZQ0KPiA+ID4gdGhpcyBH
UElPIHdpdGggaXRzIHByZS1kZWZpbmVkIG5hbWUgKGNhbWluZyBmcm9tIHRoZSBBQ1BJIHRhYmxl
DQo+IGRlY2xhcmF0aW9uKSwNCj4gPiA+IHRvIHRoZSB1c2Vyc3BhY2UuLi4NCj4gDQo+IFVuZm9y
dHVuYXRlbHkgd2hhdCB5b3UgYXJlIGRlc2NyaWJpbmcgaW4gdGhlIHNlY29uZCBwYXJ0IGlzIHJh
dGhlcg0KPiBwcm9wZXJ0eSBvZiB0aGUgY29udHJvbGxlciB3aGljaCBjYW4gaG9nIHRoZSBsaW5l
LCBidXQgdGhpcyBpcyBub3QNCj4gd2hhdCB5b3Ugd2FudCBpbiB0aGUgZmlyc3QgcGFydC4NCj4g
VGhlIExpbnV4IGtlcm5lbCwgaW4gbWFueSB3YXlzLCBpcyBkZXNpZ25lZCB0aGF0IHlvdSBuZWVk
IGEgZHJpdmVyDQo+IChJwrJDIHVzZXIgc3BhY2UgZGV2aWNlIG5vZGUgaXMgcmF0aGVyIGEgbWlz
dGFrZSwgYnV0IGNvbXByb21pc2UgZm9yDQo+IHRoYXQgdGltZSB3aGVuIG1vc3Qgb2YgdGhlIGRl
dmljZXMgaGF2ZSBhY2Nlc3MgZnJvbSB1c2VyIHNwYWNlDQo+IGRyaXZlcnMpLiBTbywgdGhlIHBy
b3BlciB3YXkgaXMgdG8gZGVmaW5lIHRoaXMgYXMgZ3Bpby1rZXlzIChlaXRoZXINCj4gaW50ZXJy
dXB0IHZlcnNpb24gb3IgcG9sbGluZyBvbmUpIGFuZCBjb25uZWN0IGEgbGlzdGVuZXIgdG8gdGhl
IGV2ZW50Lg0KPiANCj4gU3VtbWFyaXplOiB5b3UgbmVlZCB0byBkZXNjcmliZSBwaW4ocykgdmlh
ICJncGlvLWxpbmUtbmFtZXMiIHByb3BlcnR5DQo+IG9mIHRoZSBjb250cm9sbGVyIChpdCdzIG5v
dCBzbyBlYXN5IHRhc2sgaWYgQUNQSSB0YWJsZXMgYWxyZWFkeSBoYXZlDQo+IHBhcnRzIG9mIGl0
LCBidXQgSSB0aGluayB5b3VyIGNhc2Ugc2hvdWxkIGJlIGZlYXNpYmxlKS4gQW5kIGVpdGhlcg0K
PiBwcm92aWRlIGEgZ3Bpby1rZXlzIGRldmljZSwgb3IgdXNlIGxpbmUgZGlyZWN0bHkgYnkgbmFt
ZSBhcyAobGliZ3Bpb2QNCj4gZXhhbXBsZSk6DQo+ICBncGlvZGV0ZWN0DQo+ICBncGlvaW5mbyBn
cGlvY2hpcFgNCj4gIGdwaW9maW5kICRHUElPX0xJTkVfTkFNRQ0KPiAgZ3Bpb21vbiBncGlvY2hp
cFggJChncGlvZmluZCAkR1BJT19MSU5FX05BTUUpICYNCj4gDQo+IEV4YW1wbGVzIG9mIEFDUEkg
YXJlIGhlcmUgWzFdIGZvciBjb250cm9sbGVyIHBhcnQgKGxvb2sgYXQgdGhlIG5hbWUNCj4gbGlz
dCkgYW5kIGZvciBkZXZpY2UgcGFydCBbMl0uIFlvdSBtYXkgbG9vayBpbnRvIG90aGVyIGZvbGRl
cnMgYXMNCj4gd2VsbCwgdGhvdWdoIHRoZXkgYXJlIG5vdCBzbyByZWFjaCBvZiBleGFtcGxlcy4N
Cj4gDQo+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3dlc3RlcmkvbWV0YS1hY3BpL2Jsb2IvbWFz
dGVyL3JlY2lwZXMtYnNwL2FjcGktDQo+IHRhYmxlcy9zYW1wbGVzL2VkaXNvbi9hcmR1aW5vLmFz
bGkNCj4gWzJdOiBodHRwczovL2dpdGh1Yi5jb20vd2VzdGVyaS9tZXRhLWFjcGkvYmxvYi9tYXN0
ZXIvcmVjaXBlcy1ic3AvYWNwaS0NCj4gdGFibGVzL3NhbXBsZXMvZWRpc29uL2J1dHRvbnMuYXNs
aQ0KPiANCg0KDQpJIGhhdmUgYWxyZWFkeSB3cml0dGVuIGFuZCBBQ1BJIHRhYmxlLCBub3QgaW4g
dGhlIEJJT1MgYnV0IGFzIHNlcGFyYXRlDQpTU0RULCBsb2FkZWQgbWFudWFsbHkgYXQgcnVudGlt
ZSwgdXNpbmcgdGhlIGdwaW8ta2V5cyAod2l0aCBpbnRlcnJ1cHQpDQphbmQgaW4gdGhpcyB3YXkg
YWxsIHdvcmtzIGdvb2QuIFNvIEkgaGF2ZSBhbHJlYWR5IHRlc3RlZCB0aGlzIHNvbHV0aW9uLg0K
DQpCdXQgSSBwcmVmZXIgb2J0YWluIHRoaXMgcmVzdWx0IGluIHRoZSBjbGFzc2ljIHdheSwgd2l0
aCBHUElPLi4uDQoNClNvIEkgdGhpbmsgSSdsbCB3cml0ZSBhIGRldmljZSBkcml2ZXIgZm9yIGl0
LiBBIGRldmljZSBkcml2ZXIgd2hpY2gNCnJlYWRzIHRoZSBBQ1BJIHRhYmxlIGFuZCBwdWJsaXNo
ZXMgdGhlIEdQSU8sIHdpdGggaXRzIG5hbWUsIGluIHN5c2ZzLi4uDQoNCg0KPiA+IEFkZGluZyBB
bmR5IHdobyBrbm93cyBBQ1BJIEdQSU8gd2VsbC4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+ID4gSW4g
Z2VuZXJhbCwgdGhlICJncGlvLWxpbmUtbmFtZXMiIHByb3BlcnR5IGlzIHVzZWQgZm9yIHRoYXQg
YW5kIGl0J3MNCj4gPiBzdXBwb3J0ZWQgYm90aCBmb3IgZGV2aWNlIHRyZWUgYXMgd2VsbCBhcyBB
Q1BJLCBhbHRob3VnaCBJIGhhdmUgb25seQ0KPiA+IGV2ZXIgdXNlZCB0aGUgZm9ybWVyLg0KPiAN
Cj4gUmlnaHQuIEFDUEkgc3VwcG9ydHMgcHJvcGVydGllcyB2aWEgX0RTRCgpIG1ldGhvZC4NCj4g
DQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KVGhhbmtz
IGFuZCBiZXN0IHJlZ2FyZHMsDQpGbGF2aW8NCg0K
