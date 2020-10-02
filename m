Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C26281040
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJBKCX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 06:02:23 -0400
Received: from smtp.asem.it ([151.1.184.197]:53067 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBKCX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:02:23 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000519725.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 12:02:20 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 12:02:19 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Fri, 2 Oct 2020 12:02:19 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0IAAJ14A//6Yg1CAAsA0gP//s0vAAA+m6wAAAI1qgP/9IPng
Date:   Fri, 2 Oct 2020 10:02:19 +0000
Message-ID: <757023db21e642a3a4b6d33428c191cc@asem.it>
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
In-Reply-To: <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A09020E.5F76FAAC.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0Kc29ycnkgZm9yIHRoZSBkZWxheSENCg0KPiA+ID4gTXkgU1NEVCB0YWJsZSBp
czoNCj4gPg0KPiA+IF5eXl4gU2VlIHRoZSBkaWZmZXJlbmNlPyBJIGNhbid0IGhlbHAgaGVyZS4N
Cg0KVGhpcyBpcyB0aGUgRFNEVCB0YWJsZSByZWxhdGVkIHRvIHRoZSBHUElPIGNvbnRyb2xsZXIg
b2YgbXkgYm9hcmQ6DQoNCkRldmljZSAoR1BPMSkNCiAgICAgICAgew0KICAgICAgICAgICAgTmFt
ZSAoX0FEUiwgWmVybykgIC8vIF9BRFI6IEFkZHJlc3MNCiAgICAgICAgICAgIE5hbWUgKF9ISUQs
ICJJTlQzNDUyIikgIC8vIF9ISUQ6IEhhcmR3YXJlIElEDQogICAgICAgICAgICBOYW1lIChfQ0lE
LCAiSU5UMzQ1MiIpICAvLyBfQ0lEOiBDb21wYXRpYmxlIElEDQogICAgICAgICAgICBOYW1lIChf
REROLCAiR2VuZXJhbCBQdXJwb3NlIElucHV0L091dHB1dCAoR1BJTykgQ29udHJvbGxlciAtIE5v
cnRod2VzdCIpICAvLyBfREROOiBET1MgRGV2aWNlIE5hbWUNCiAgICAgICAgICAgIE5hbWUgKF9V
SUQsIDB4MDIpICAvLyBfVUlEOiBVbmlxdWUgSUQNCiAgICAgICAgICAgIE5hbWUgKFJCVUYsIFJl
c291cmNlVGVtcGxhdGUgKCkNCiAgICAgICAgICAgIHsNCiAgICAgICAgICAgICAgICBNZW1vcnkz
MkZpeGVkIChSZWFkV3JpdGUsDQogICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDAsICAgICAg
ICAgLy8gQWRkcmVzcyBCYXNlDQogICAgICAgICAgICAgICAgICAgIDB4MDAwMDQwMDAsICAgICAg
ICAgLy8gQWRkcmVzcyBMZW5ndGgNCiAgICAgICAgICAgICAgICAgICAgX1kwOCkNCiAgICAgICAg
ICAgICAgICBJbnRlcnJ1cHQgKFJlc291cmNlQ29uc3VtZXIsIExldmVsLCBBY3RpdmVMb3csIFNo
YXJlZCwgLCwgKQ0KICAgICAgICAgICAgICAgIHsNCiAgICAgICAgICAgICAgICAgICAgMHgwMDAw
MDAwRSwNCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICB9KQ0KICAgICAgICAgICAgTWV0
aG9kIChfQ1JTLCAwLCBOb3RTZXJpYWxpemVkKSAgLy8gX0NSUzogQ3VycmVudCBSZXNvdXJjZSBT
ZXR0aW5ncw0KICAgICAgICAgICAgew0KICAgICAgICAgICAgICAgIENyZWF0ZURXb3JkRmllbGQg
KFJCVUYsIFxfU0IuR1BPMS5fWTA4Ll9CQVMsIEIwQkEpICAvLyBfQkFTOiBCYXNlIEFkZHJlc3MN
CiAgICAgICAgICAgICAgICBDcmVhdGVEV29yZEZpZWxkIChSQlVGLCBcX1NCLkdQTzEuX1kwOC5f
TEVOLCBCMExOKSAgLy8gX0xFTjogTGVuZ3RoDQogICAgICAgICAgICAgICAgQjBCQSA9IEdQMUEg
LyogXEdQMUEgKi8NCiAgICAgICAgICAgICAgICBCMExOID0gR1AxTCAvKiBcR1AxTCAqLw0KICAg
ICAgICAgICAgICAgIFJldHVybiAoUkJVRikgLyogXF9TQl8uR1BPMS5SQlVGICovDQogICAgICAg
ICAgICB9DQoNCiAgICAgICAgICAgIE1ldGhvZCAoX1NUQSwgMCwgTm90U2VyaWFsaXplZCkgIC8v
IF9TVEE6IFN0YXR1cw0KICAgICAgICAgICAgew0KICAgICAgICAgICAgICAgIElmICgoT1NZUyA8
IDB4MDdEQykpDQogICAgICAgICAgICAgICAgew0KICAgICAgICAgICAgICAgICAgICBSZXR1cm4g
KFplcm8pDQogICAgICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAgICAgUmV0dXJuICgweDBG
KQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQoNCiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2Fy
ZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQpCZXN0IHJlZ2FyZHMsDQoNCkZsYXZpbw0K
