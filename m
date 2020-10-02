Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F3281402
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBN3M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 09:29:12 -0400
Received: from smtp.asem.it ([151.1.184.197]:54089 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBN3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Oct 2020 09:29:12 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000520443.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 15:29:07 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 15:29:06 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Fri, 2 Oct 2020 15:29:06 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0IAAJ14A//6Yg1CAAsA0gP//s0vAAA+m6wAAAI1qgP/9IPng//o02AD/9F/YAP/onSjw
Date:   Fri, 2 Oct 2020 13:29:06 +0000
Message-ID: <809e219eabd44f3886af1da853c58db4@asem.it>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it>
 <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it>
 <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it>
 <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
 <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com>
 <757023db21e642a3a4b6d33428c191cc@asem.it>
 <CAHp75Vf-hJ78LmXF8PqOeF-CfWEYqYzMiGCEGaEfnMqxmtiwiw@mail.gmail.com>
 <CAHp75VdBJEbm0=eNZMdc2ZWMh4qwP2S7jRECWWWvh2EfA-NykA@mail.gmail.com>
In-Reply-To: <CAHp75VdBJEbm0=eNZMdc2ZWMh4qwP2S7jRECWWWvh2EfA-NykA@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A090211.5F772B23.0003,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SEkgQW5keSwNCg0KPiA+IFNvLCB3aGF0IGFib3V0IGFkZGluZyB0aGUgZm9sbG93aW5nDQo+ID4N
Cj4gPg0KPiA+IChSZXBsYWNlICcuLi4nIHdpdGggbWVhbmluZ2Z1bCBsaW5lIG5hbWVzIG9yIGRy
b3AgZm9yIG5vdywgYnV0IGluIGFueQ0KPiA+IGNhc2UgeW91IG5lZWQgdG8gcHJvdmlkZSBhcyBt
dWNoIG5hbWVzIGFzIGxpbmVzIG9mIHN1Y2ggR1BJTw0KPiA+IGNvbnRyb2xsZXIpDQo+IA0KPiBJ
IGhhdmUgY2hlY2tlZCB0aGUgY29kZSwgc28gaXQgYWxsb3dzIHlvdSB0byBkZWZpbmUgZnJvbSAw
IHVwIHRvIGFsbA0KPiBsaW5lcywgYnV0IG5vIGdhcHMuDQo+IFRodXMsIEkgaGF2ZSBkcm9wcGVk
ICcuLi4nIGxpbmUgaW4gYWJvdmUgZXhjZXJwdCwgYWRkZWQgdGhlIGNvbXBpbGVkDQo+IEFNTCB0
byBpbml0cmFtZnMgKGluaXRyZCBtZXRob2QpIGFuZCB2b2lsYSENCj4gDQo+ICUgZ3Bpb2luZm8g
Z3Bpb2NoaXAxDQo+IGdwaW9jaGlwMSAtIDc3IGxpbmVzOg0KPiAgICAgICAgbGluZSAgIDA6ICAg
ICAgIkxpbmUwIiAgICAgICB1bnVzZWQgICBpbnB1dCAgYWN0aXZlLWhpZ2gNCj4gICAgICAgIGxp
bmUgICAxOiAgICAgICJMaW5lMSIgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoDQo+
ICAgICAgICBsaW5lICAgMjogICAgICAiTGluZTIiICAgICAgIHVudXNlZCAgIGlucHV0ICBhY3Rp
dmUtaGlnaA0KPiAgICAgICAgbGluZSAgIDM6ICAgICAgdW5uYW1lZCAgICAgICB1bnVzZWQgICBp
bnB1dCAgYWN0aXZlLWhpZ2gNCj4gDQo+IA0KPiAlIGdwaW9maW5kIExpbmUyDQo+IGdwaW9jaGlw
MSAyDQo+IA0KPiBPZiBjb3Vyc2UgeW91IG1heSBjb252ZXJ0IF9EU0QgdG8gYmUgYSBNZXRob2Qg
YW5kIGZpbGwgdGhlIGxpbmUgbmFtZXMNCj4gZHluYW1pY2FsbHkgd2l0aCBoZWxwIG9mIEFTTC4N
Cg0KVGhhbmtzIGZvciB5b3VyIGhlbHAsIEkgdHJ5IG5vdyENCg0KPiANCj4gLS0NCj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQpCZXN0IHJlZ2FyZHMsDQoNCkZsYXZp
bw0K
