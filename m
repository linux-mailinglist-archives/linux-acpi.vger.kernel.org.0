Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF32AF4C8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 16:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKKPeb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 10:34:31 -0500
Received: from smtp.asem.it ([151.1.184.197]:61308 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKKPeb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:34:31 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000601127.MSG 
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 16:34:29 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 16:34:27 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 11 Nov 2020 16:34:27 +0100
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
Thread-Index: AQHWuCs2DratU6tfqk6ZIQJSnDA95anC5K8AgAAdYVD///LlgIAAGh/g
Date:   Wed, 11 Nov 2020 15:34:27 +0000
Message-ID: <a68fdcb7302c4db5b8cf88dec60f8172@asem.it>
References: <20201111130435.432982-1-f.suligoi@asem.it>
 <CAHp75VeccWtKRQkQE0XyyDZVvkD3QrBig2yU6=pz3KEG-bCKjA@mail.gmail.com>
 <93941f3b0142473399bfdd18608a4056@asem.it>
 <CAHp75Vdhd2Swu5qiYszgBG4pfB8LG=jxgi=YMHNviogWQR_oJw@mail.gmail.com>
In-Reply-To: <CAHp75Vdhd2Swu5qiYszgBG4pfB8LG=jxgi=YMHNviogWQR_oJw@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A090204.5FAC0484.003A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+ID4gU2luY2UgaXQncyByZXN0LCBJIHdvdWxkIGV4cGVjdCBncGlvLWxpbmUtbmFtZXMgaW4g
YWJvdmUgcGFyYWdyYXBocyB0bw0KPiA+ID4gYmUgYSB0ZXJtLCBzb21ldGhpbmcgbGlrZQ0KPiA+
ID4gYGBncGlvLWxpbmUtbmFtZXNgYCAoZG91YmxlIGJhY2sgcXVvdGVzIG9uIGVhY2ggc2lkZSku
IFllcywgSSBrbm93DQo+ID4gPiB0aGF0IHRoZXJlIGFyZSBvdGhlciBwbGFjZXMgd2hpY2ggbmVl
ZCB0byBiZSBhbWVuZGVkLCBidXQgSSBiZWxpZXZlDQo+ID4gPiBpdCdzIG91dCBvZiBzY29wZSBv
ZiB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gT2ssIEknbGwgdXNlIHRoZSBiYWNrcXVvdGVzIGZvciBj
b2RlIHNhbXBsZXMsIHJpZ2h0IQ0KPiA+IElmIHlvdSB3YW50LCB3aGVuIHRoaXMgcGF0Y2ggd2ls
bCBiZSBjb25jbHVkZWQsIEkgY2FuIGNoZWNrIGFsbCB0aGUgQUNQSQ0KPiA+IGRvY3VtZW50YXRp
b24gdG8gcHV0IGFsbCBjb2RlIHNhbXBsZXMgaW50byBiYWNrcXVvdGVzLg0KPiANCj4gSSdtIG5v
dCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFudCB1bmRlciAnY29kZSBzYW1wbGVzJy4g
VGhlDQo+IGNvZGUgZXhjZXJwdHMgbGlrZSBiZWxvdyBhcmUgZmluZSwgd2hhdCBJJ20gdGFsa2lu
ZyBhYm91dCBpcyB0aGUNCj4gcmVmZXJlbmNlIHRvIHByb3BlcnRpZXMgaW4gdGhlIHRleHQuDQoN
Cm9rLCBub3cgaXQncyBjbGVhcmVyIQ0KDQo+IA0KPiAuLi4NCj4gDQo+ID4gPiBgYCIiYGAgYnV0
IGJldHRlciB0byBjaGVjayB0aGUgcmVzdWx0aW5nIChyZW5kZXJlZCkgZmlsZS4gWW91IG1heSB1
c2UNCj4gPiA+IHJzdDJwZGYgc2NyaXB0IGZvciB0aGF0Lg0KPiA+DQo+ID4gT0sgZm9yIHRoZWBg
IiJgYC4NCj4gPiBJIGNoZWNrIHRoZSByZW5kZXJlZCBIVE1MIHVzaW5nIHRoZSB1c3VhbCAibWFr
ZSBodG1sZG9jcyIuIElzIGl0IGVub3VnaD8NCj4gDQo+IElkZWFsbHkgaXQncyBub3QgZW5vdWdo
LiBodG1sLCBwZGYgYW5kIG1hbiBhbGwgc2hvdWxkIGJlIGNoZWNrZWQuDQoNCm9rLCBJJ2xsIGNo
ZWNrIGFsbCBvZiB0aGVtDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5
IFNoZXZjaGVua28NCg0KUmVnYXJkcywNCkZsYXZpbw0K
