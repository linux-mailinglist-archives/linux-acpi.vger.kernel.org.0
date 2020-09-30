Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEEA27E82D
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgI3MEs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 08:04:48 -0400
Received: from smtp.asem.it ([151.1.184.197]:63339 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgI3MEs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 08:04:48 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000514340.MSG 
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2020 14:04:45 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 14:04:43 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 30 Sep 2020 14:04:43 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0IAAJ14A//6Yg1A=
Date:   Wed, 30 Sep 2020 12:04:43 +0000
Message-ID: <22753b53cd7d4dfba4ef3610f71cc462@asem.it>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it>
 <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
In-Reply-To: <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A09020E.5F74745C.0040,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0KPiA+ID4gPiA+IEkgd2FzIHdvbmRlcmluZyBpZiB0aGVyZSBpcyBhIGdlbmVy
aWMgR1BJTyBkcml2ZXIgdGhhdCBJIGNhbiB1c2UNCj4gTWF5YmUgSSB3YXMgbm90IHNvIGNsZWFy
LCBidXQgYXMgQmFydCBtZW50aW9uZWQgdGhlIGxlYXN0IHlvdSBjYW4gZG8NCj4gaXMgc2ltcGx5
IGRlZmluZSBsaW5lIG5hbWUgdmlhICJncGlvLWxpbmUtbmFtZXMiIHByb3BlcnR5LiBUaGUgcHJv
YmxlbQ0KPiBoZXJlIGlzIHdoZW4gYW5kIGhvdyB5b3Ugd291bGQgbGlrZSB0byBoYXZlIHRoZW0g
aW5jb3Jwb3JhdGVkLg0KDQpJIGFscmVhZHkgdHJpZWQgYWRkaW5nIHRoZSAiZ3Bpby1saW5lLW5h
bWVzIiBwcm9wZXJ0eSwgYnV0IHRoZSBwcm9ibGVtDQppcyB0aGUgc2FtZTogbm8gZHJpdmVyIGFz
a3MgZm9yIHRoaXMgR1BJTywgYXMgc2hvd24gYnkgdGhlIGZvbGxvd2luZw0Ka2VybmVsIG1lc3Nh
Z2VzOg0KDQpBQ1BJOiBIb3N0LWRpcmVjdGVkIER5bmFtaWMgQUNQSSBUYWJsZSBMb2FkOg0KQUNQ
STogU1NEVCAweEZGRkY5OTQwMzRENDJBMDAgMDAwMEU4ICh2MDUgQVNFTXNwIEdQSU9fQlROIDAw
MDAwMDAxIElOVEwgMjAyMDA3MTcpDQpBQ1BJOiBcX1NCXy5HUE8xLkJUTlM6IFBSUDAwMDEgcmVx
dWlyZXMgJ2NvbXBhdGlibGUnIHByb3BlcnR5DQoNClNvIEknbGwgc3RhcnQgdG8gd3JpdGUgYSBz
aW1wbGUgZGV2aWNlIGRyaXZlciB0byB1c2UgdGhpcyBHUElPLg0KSSdsbCBrZWVwIHlvdSBpbmZv
cm1lZCENCiANCj4gV2hlbjogaWYgQUNQSSB0YWJsZXMgYXJlIGJlaW5nIHByb3ZpZGVkIGJ5IGZp
cm13YXJlIHdoaWNoIHlvdSBtYXkgbm90DQo+IGFsdGVyLCB0aGVuIHlvdSBtdXN0IHVzZSBpbml0
cmFtZnMgdHlwZSBvZiBzb2x1dGlvbiAobm8gY29uZmlnZnMsDQo+IGRvbid0IGtub3cgYWJvdXQg
RUZJIHZhciB0aG91Z2gpLiBIb3c6IEluIHRoYXQgY2FzZSB5b3UgbWlnaHQgaGF2ZSBhDQo+IGNo
YW5jZSB0byBpbmNvcnBvcmF0ZSBfRFNEKCkgbWV0aG9kIGludG8gKmV4aXN0aW5nKiBfQ1JTKCkg
b25lLg0KPiBQb3NzaWJsZSBpbXBlZGltZW50czogaWYgQUNQSSB0YWJsZSBmcm9tIGZpcm13YXJl
IGFscmVhZHkgaGFzIGEgX0RTRCgpDQo+IGRlZmluZWQgb3IgYWJvdmUgaXMgbm90IHdvcmtpbmcg
Zm9yIHNvbWUgcmVhc29uLiBJbiBzdWNoIGEgY2FzZSB5b3UNCj4gbXVzdCB1cGdyYWRlIGVudGly
ZSBEU0RUIHZpYSBpbml0cmFtZnMuDQo+IA0KPiA+ID4gPiBBZGRpbmcgQW5keSB3aG8ga25vd3Mg
QUNQSSBHUElPIHdlbGwuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLg0KPiA+ID4NCj4gPiA+ID4gSW4g
Z2VuZXJhbCwgdGhlICJncGlvLWxpbmUtbmFtZXMiIHByb3BlcnR5IGlzIHVzZWQgZm9yIHRoYXQg
YW5kIGl0J3MNCj4gPiA+ID4gc3VwcG9ydGVkIGJvdGggZm9yIGRldmljZSB0cmVlIGFzIHdlbGwg
YXMgQUNQSSwgYWx0aG91Z2ggSSBoYXZlIG9ubHkNCj4gPiA+ID4gZXZlciB1c2VkIHRoZSBmb3Jt
ZXIuDQo+ID4gPg0KPiA+ID4gUmlnaHQuIEFDUEkgc3VwcG9ydHMgcHJvcGVydGllcyB2aWEgX0RT
RCgpIG1ldGhvZC4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZj
aGVua28NCg0KVGhhbmtzIEFuZHkgYW5kIEJhcnRvc3ogZm9yIHlvdXIgc3VwcG9ydCENCkJlc3Qg
cmVnYXJkcywNCg0KRmxhdmlvDQo=
