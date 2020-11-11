Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595622AF418
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKKOxW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 09:53:22 -0500
Received: from smtp.asem.it ([151.1.184.197]:60288 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgKKOxS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:18 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000601011.MSG 
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 15:53:15 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 15:53:13 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 11 Nov 2020 15:53:13 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] Documentation: ACPI: explain how to use
 gpio-line-names
Thread-Topic: [PATCH v1] Documentation: ACPI: explain how to use
 gpio-line-names
Thread-Index: AQHWuCs2DratU6tfqk6ZIQJSnDA95anC5K8AgAAdYVA=
Date:   Wed, 11 Nov 2020 14:53:13 +0000
Message-ID: <93941f3b0142473399bfdd18608a4056@asem.it>
References: <20201111130435.432982-1-f.suligoi@asem.it>
 <CAHp75VeccWtKRQkQE0XyyDZVvkD3QrBig2yU6=pz3KEG-bCKjA@mail.gmail.com>
In-Reply-To: <CAHp75VeccWtKRQkQE0XyyDZVvkD3QrBig2yU6=pz3KEG-bCKjA@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A090213.5FABFADA.0015,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0KPiA+IFRoaXMgY29tbWl0IGFsc28gZml4IGEgdHJpdmlhbCBzeW50YXggZXJy
b3IuDQo+IA0KPiBmaXggLT4gZml4ZXMNCj4gc3ludGF4IGVycm9yIC0+IHNwZWxsaW5nIG1pc3Rh
a2UNCg0Kb2sNCg0KPiA+IC1FeGFtcGxlOjoNCj4gPiArVGhlICJncGlvLWxpbmUtbmFtZXMiIGRl
Y2xhcmF0aW9uIGlzIGEgbGlzdCBvZiBzdHJpbmdzICgibmFtZXMiKSwgd2hpY2gNCj4gPiArZGVz
Y3JpYmVzIGVhY2ggbGluZS9waW4gb2YgYSBHUElPIGNvbnRyb2xsZXIvZXhwYW5kZXIuDQo+ID4g
K1RoaXMgbGlzdCwgY29udGFpbmVkIGluIGEgcGFja2FnZSwgbXVzdCBiZSBpbnNlcnRlZCBpbnNp
ZGUgdGhlIEdQSU8NCj4gY29udHJvbGxlcg0KPiA+ICtkZWNsYXJhdGlvbiBvZiBhbiBBQ1BJIHRh
YmxlICh0eXBpY2FsbHkgaW5zaWRlIHRoZSBEU0RUKS4NCj4gPiArVGhlIGdwaW8tbGluZS1uYW1l
cyBsaXN0IG11c3QgcmVzcGVjdCB0aGUgZm9sbG93aW5nIHJ1bGVzIChzZWUgYWxzbyB0aGUNCj4g
PiArZXhhbXBsZXMpOg0KPiANCj4gU2luY2UgaXQncyByZXN0LCBJIHdvdWxkIGV4cGVjdCBncGlv
LWxpbmUtbmFtZXMgaW4gYWJvdmUgcGFyYWdyYXBocyB0bw0KPiBiZSBhIHRlcm0sIHNvbWV0aGlu
ZyBsaWtlDQo+IGBgZ3Bpby1saW5lLW5hbWVzYGAgKGRvdWJsZSBiYWNrIHF1b3RlcyBvbiBlYWNo
IHNpZGUpLiBZZXMsIEkga25vdw0KPiB0aGF0IHRoZXJlIGFyZSBvdGhlciBwbGFjZXMgd2hpY2gg
bmVlZCB0byBiZSBhbWVuZGVkLCBidXQgSSBiZWxpZXZlDQo+IGl0J3Mgb3V0IG9mIHNjb3BlIG9m
IHRoaXMgcGF0Y2guDQoNCk9rLCBJJ2xsIHVzZSB0aGUgYmFja3F1b3RlcyBmb3IgY29kZSBzYW1w
bGVzLCByaWdodCENCklmIHlvdSB3YW50LCB3aGVuIHRoaXMgcGF0Y2ggd2lsbCBiZSBjb25jbHVk
ZWQsIEkgY2FuIGNoZWNrIGFsbCB0aGUgQUNQSQ0KZG9jdW1lbnRhdGlvbiB0byBwdXQgYWxsIGNv
ZGUgc2FtcGxlcyBpbnRvIGJhY2txdW90ZXMuDQoNCj4gDQo+IEFsc28gbm8gbmVlZCB0byBoYXZl
IGVhY2ggc2VudGVuY2UgdG8gYmUgc3RhcnRlZCBmcm9tIGEgbmV3IGxpbmUsIGl0DQo+IHdpbGwg
YmUgcmVuZGVyZWQgYXMgaXQgaGFzIG9uZSB3aGl0ZSBzcGFjZSBpbiBiZXR3ZWVuLg0KDQpvaw0K
DQo+ID4gKyAgICBvdGhlciB3b3JkcywgaXQgaXMgbm90IG1hbmRhdG9yeSB0byBmaWxsIGFsbCB0
aGUgR1BJTyBsaW5lcw0KPiA+ICsgIC0gZW1wdHkgbmFtZXMgYXJlIGFsbG93ZWQgKHR3byBxdW90
YXRpb24gbWFya3MgIiIgY29ycmVzcG9uZCB0byBhbg0KPiBlbXB0eSBuYW1lKQ0KPiANCj4gYGAi
ImBgIGJ1dCBiZXR0ZXIgdG8gY2hlY2sgdGhlIHJlc3VsdGluZyAocmVuZGVyZWQpIGZpbGUuIFlv
dSBtYXkgdXNlDQo+IHJzdDJwZGYgc2NyaXB0IGZvciB0aGF0Lg0KDQpPSyBmb3IgdGhlYGAiImBg
Lg0KSSBjaGVjayB0aGUgcmVuZGVyZWQgSFRNTCB1c2luZyB0aGUgdXN1YWwgIm1ha2UgaHRtbGRv
Y3MiLiBJcyBpdCBlbm91Z2g/DQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkg
U2hldmNoZW5rbw0KDQpSZWdhcmRzLA0KRmxhdmlvDQo=
