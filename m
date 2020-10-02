Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBD28108E
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgJBK0R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 06:26:17 -0400
Received: from smtp.asem.it ([151.1.184.197]:58127 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBK0Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:26:16 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000519847.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 12:26:14 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 12:26:12 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Fri, 2 Oct 2020 12:26:12 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0IAAJ14A//6Yg1CAAsA0gP//s0vAAA+m6wAAAI1qgP/9IHKw
Date:   Fri, 2 Oct 2020 10:26:11 +0000
Message-ID: <8b6adbc45d134da7b0fd1f9044a37cf6@asem.it>
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
X-SGOP-RefID: str=0001.0A09020E.5F770044.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0Kd2l0aCBteSBjdXN0b20gU1NEVCB0YWJsZToNCg0KRGVmaW5pdGlvbkJsb2Nr
ICgiZ3Bpb19idXR0b24uYW1sIiwgIlNTRFQiLCA1LCAiQVNFTXNwIiwgIkdQSU9fQlROIiwgMSkN
CnsNCglFeHRlcm5hbCAoX1NCXy5HUE8xLCBEZXZpY2VPYmopDQoJU2NvcGUgKFxfU0IuR1BPMSkN
Cgl7DQoJCURldmljZSAoQlROUykNCgkJew0KCQkJTmFtZSAoX0hJRCwgIkFTRU0wMDA1IikJCS8v
IF9ISUQ6IEhhcmR3YXJlIElEIFBSUDAwMDENCgkJCU5hbWUgKF9VSUQsIFplcm8pICAgICAgICAg
ICAgIC8vIF9VSUQ6IFVuaXF1ZSBJRA0KCQkJTmFtZSAoX0RETiwgIkRETiAtIFNXIFJlYWRhYmxl
IEJ1dHRvbiIpICAvLyBfREROOiBET1MgRGV2aWNlIE5hbWUNCgkJCU5hbWUgKF9TVFIsIFVuaWNv
ZGUgKCJTVFIgLSBTVyBSZWFkYWJsZSBCdXR0b24iKSkgIC8vIF9TVFI6IERlc2NyaXB0aW9uIFN0
cmluZw0KDQoJCQlOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpCSAvLyBfQ1JTOiBDdXJy
ZW50IFJlc291cmNlIFNldHRpbmdzDQoJCQl7DQoJCQkJR3Bpb0lvICgNCgkJCQkJU2hhcmVkLCAg
ICAgICAgICAgICAgICAgIC8vIE5vdCBzaGFyZWQNCgkJCQkJUHVsbE5vbmUsICAgICAgICAgICAg
ICAgIC8vIE5vIG5lZWQgZm9yIHB1bGxzDQoJCQkJCTAsICAgICAgICAgICAgICAgICAgICAgICAv
LyBEZWJvdW5jZSB0aW1lb3V0DQoJCQkJCTAsICAgICAgICAgICAgICAgICAgICAgICAvLyBEcml2
ZSBzdHJlbmd0aA0KCQkJCQlJb1Jlc3RyaWN0aW9uSW5wdXRPbmx5LCAgLy8gT25seSB1c2VkIGFz
IGlucHV0DQoJCQkJCSJcXF9TQi5HUE8xIiwgICAgICAgICAgICAvLyBHUElPIGNvbnRyb2xsZXIN
CgkJCQkJMCwgUmVzb3VyY2VDb25zdW1lciwgLCApIC8vIE11c3QgYmUgMA0KCQkJCQl7DQoJCQkJ
CQkyNSwgICAgICAgICAgICAgICAgLy8gR1BJTyBudW1iZXIgMjUNCgkJCQkJfQ0KCQkJfSkNCgkJ
fQ0KCX0NCn0NCg0KSSdtIGFibGUgdG8gc2VlIHRoZSBHUElPIGluOg0KDQovc3lzL2J1cy9wbGF0
Zm9ybS9kZXZpY2VzL0FTRU0wMDA1OjAwL2Zpcm13YXJlX25vZGU6DQoNCi1yLS1yLS1yLS0gICAg
MSByb290ICAgICByb290ICAgICAgICAgIDQwOTYgT2N0ICAyIDEyOjEwIGRlc2NyaXB0aW9uDQot
ci0tci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAgICA0MDk2IE9jdCAgMiAxMjoxMCBo
aWQNCi1yLS1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQwOTYgT2N0ICAyIDEy
OjEwIG1vZGFsaWFzDQotci0tci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAgICA0MDk2
IE9jdCAgMiAxMjoxMCBwYXRoDQpscnd4cnd4cnd4ICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAg
ICAgICAwIE9jdCAgMiAxMjoxMCBwaHlzaWNhbF9ub2RlIC0+IC4uLy4uLy4uLy4uL3BsYXRmb3Jt
L0lOVDM0NTI6MDEvQVNFTTAwMDU6MDANCmRyd3hyLXhyLXggICAgMiByb290ICAgICByb290ICAg
ICAgICAgICAgIDAgT2N0ICAyIDEyOjEwIHBvd2VyDQpscnd4cnd4cnd4ICAgIDEgcm9vdCAgICAg
cm9vdCAgICAgICAgICAgICAwIE9jdCAgMiAxMjoxMCBzdWJzeXN0ZW0gLT4gLi4vLi4vLi4vLi4v
Li4vYnVzL2FjcGkNCi1ydy1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgIDQwOTYg
T2N0ICAyIDEyOjEwIHVldmVudA0KLXItLXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAg
ICAgNDA5NiBPY3QgIDIgMTI6MTAgdWlkDQoNCmFuZCBzbyBJIGNhbiBzZWUgc29tZSB1c2VmdWwg
aW5mbzoNCg0KIyBjYXQgZGVzY3JpcHRpb24NClNUUiAtIFNXIFJlYWRhYmxlIEJ1dHRvbg0KIyBj
YXQgaGlkDQpBU0VNMDAwNQ0KIyBjYXQgbW9kYWxpYXMNCmFjcGk6QVNFTTAwMDU6DQpibXh4eHgt
eDg2LTY0Oi9zeXMvYnVzL3BsYXRmb3JtL2RldmljZXMvQVNFTTAwMDU6MDAvZmlybXdhcmVfbm9k
ZSMgY2F0IHBhdGgNClxfU0JfLkdQTzEuQlROUw0KDQpTbywgZnJvbSB1c2Vyc3BhY2UsIEkgY2Fu
IGRpc2NvdmVyIHRoZSBHUElPIGNvbnRyb2xsZXIgL2Rldi9ncGlvY2hpcDEsDQpidXQgSSBkb24n
dCBrbm93IGhvdyB0byBkaXNjb3ZlciB0aGUgR1BJTyBudW1iZXIgKDI1IGluIHRoaXMgY2FzZSku
DQpEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbiBhYm91dCBob3cgdG8gZGlzY292ZXIgdGhpcyBH
UElPIG51bWJlcj8NCg0KVGhhbmtzIQ0KDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBB
bmR5IFNoZXZjaGVua28NCg0KQmVzdCByZWdhcmRzLA0KRmxhdmlvDQo=
