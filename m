Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F02A99CB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgKFQrk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 11:47:40 -0500
Received: from smtp.asem.it ([151.1.184.197]:52185 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFQrk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 11:47:40 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000592095.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2020 17:47:37 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 17:47:35 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Fri, 6 Nov 2020 17:47:35 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2wACVbgAAABK9IAABkeZAAAAulsAAALtYfAAHgxtAAAWS8WA
Date:   Fri, 6 Nov 2020 16:47:35 +0000
Message-ID: <c20e82318bbf426c9d9000cac7e7734b@asem.it>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201106070432.GQ2495@lahna.fi.intel.com>
In-Reply-To: <20201106070432.GQ2495@lahna.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A090213.5FA57E28.0048,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgTWlrYSBhbmQgQW5keSwNCg0KPiA+DQo+ID4gcm9vdEBkZWJpYW46fiMgbHNwY2kgLXQNCj4g
PiAtWzAwMDA6MDBdLSstMDAuMA0KPiA+ICAgICAgICAgICAgKy0wMi4wDQo+ID4gICAgICAgICAg
ICArLTBlLjANCj4gPiAgICAgICAgICAgICstMGYuMA0KPiA+ICAgICAgICAgICAgKy0xMi4wDQo+
ID4gICAgICAgICAgICArLTEzLjAtWzAxXS0tLS0wMC4wDQo+ID4gICAgICAgICAgICArLTEzLjEt
WzAyXS0tLS0wMC4wDQo+ID4gICAgICAgICAgICArLTEzLjItWzAzXS0tDQo+ID4gICAgICAgICAg
ICArLTE0LjAtWzA0XS0tLS0wMC4wDQo+ID4gICAgICAgICAgICArLTE0LjEtWzA1LTA5XS0tLS0w
MC4wLVswNi0wOV0tLSstMDEuMC1bMDddLS0tLTAwLjAgPC0tIEV4YXINCj4gKGJ1cyA3LCBkZXYg
MCwgZnVuY3QgMCkNCj4gPiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKy0wMi4wLVswOF0tLS0tMDAuMA0KPiA+ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcLTAzLjAtWzA5XS0tDQo+ID4gICAgICAgICAgICArLTE1LjANCj4gPiAg
ICAgICAgICAgICstMTYuMA0KPiA+ICAgICAgICAgICAgKy0xNi4xDQo+ID4gICAgICAgICAgICAr
LTE5LjANCj4gPiAgICAgICAgICAgICstMTkuMQ0KPiA+ICAgICAgICAgICAgKy0xOS4yDQo+ID4g
ICAgICAgICAgICArLTFmLjANCj4gPiAgICAgICAgICAgIFwtMWYuMQ0KPiBPSywgdGhlbiBhZGQg
dGhlIGJyaWRnZSBmaXJzdDoNCj4gDQo+IFNjb3BlIChfU0IuUENJMC5SUFgpIHsNCj4gICAgIERl
dmljZSAoQlJHKSB7IC8vIEJyaWRnZQ0KPiAgICAgICAgTmFtZSAoX0FEUiwgMCkNCj4gDQo+ICAg
ICAgICBEZXZpY2UgKEVYQVIpIHsgLy8gRXhwYW5kZXINCj4gICAgICAgICAgICBOYW1lIChfQURS
LCAwKQ0KPiAgICAgICAgfQ0KPiAgICAgfQ0KPiANCj4gT3Igc29tZXRoaW5nIGxpa2UgdGhhdC4g
UlBYIGlzIHRoZSByb290IHBvcnQgMTQuMSBhbmQgaWYgSSByZWFkIHRoZQ0KPiBhYm92ZSByaWdo
dCBib3RoIHRoZSBicmlkZ2UgYW5kIHRoZSBFWEFSIGRldmljZSBoYXZlIGRldmljZSBhbmQgZnVu
Y3Rpb24NCj4gMC4NCg0KQWxsIG9rIG5vdywgSSd2ZSBhZGRlZCB0aGUgYnJpZGdlIChJIGhhZCB0
byB1c2UgdGhlIEJJT1Mgc291cmNlcykgYW5kDQpub3QgaXQgd29ya3M6DQoNClNjb3BlIChfU0Iu
UENJMC5SUDAyKSB7DQoNCgkJRGV2aWNlIChCUkcxKSAvL0JyaWRnZQ0KCQl7DQoJCQlOYW1lIChf
QURSLCAweDAwMDApDQoJCQ0KCQkJRGV2aWNlIChCUkcyKSAvL0JyaWRnZQ0KCQkJew0KCQkJCU5h
bWUgKF9BRFIsIDB4MDAwMTAwMDApDQoNCgkJCQlEZXZpY2UgKEVYQVIpDQoJCQkJew0KCQkJCQlO
YW1lIChfQURSLCAweDAwMDApDQoNCgkJCQkJTmFtZSAoX0RTRCwgUGFja2FnZSAoKQ0KCQkJCQl7
DQoJCQkJCQlUb1VVSUQoImRhZmZkODE0LTZlYmEtNGQ4Yy04YTkxLWJjOWJiZjRhYTMwMSIpLA0K
CQkJCQkJUGFja2FnZSAoKQ0KCQkJCQkJew0KCQkJCQkJCVBhY2thZ2UgKCkNCgkJCQkJCQl7DQoJ
CQkJCQkJCSJncGlvLWxpbmUtbmFtZXMiLA0KCQkJCQkJCQlQYWNrYWdlICgpDQoJCQkJCQkJCXsN
CgkJCQkJCQkJCSJleGFyXzAiLA0KCQkJCQkJCQkJImV4YXJfMSIsDQoJCQkJCQkJCQkiZXhhcl8y
IiwNCgkJCQkJCQkJCSJleGFyXzMiLA0KCQkJCQkJCQkJImV4YXJfNCIsDQoJCQkJCQkJCQkiZXhh
cl81IiwNCgkJCQkJCQkJCSJleGFyXzYiLA0KCQkJCQkJCQkJImV4YXJfNyINCgkJCQkJCQkJfSAu
Li4uDQpyb290QGRlYmlhbjp+IyBncGlvaW5mbyBncGlvY2hpcDQNCmdwaW9jaGlwNCAtIDE2IGxp
bmVzOg0KCWxpbmUgICAwOiAgICAgImV4YXJfMCIgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2
ZS1oaWdoIA0KCWxpbmUgICAxOiAgICAgImV4YXJfMSIgICAgICAgdW51c2VkICAgaW5wdXQgIGFj
dGl2ZS1oaWdoIA0KCWxpbmUgICAyOiAgICAgImV4YXJfMiIgICAgICAgdW51c2VkICAgaW5wdXQg
IGFjdGl2ZS1oaWdoIA0KCWxpbmUgICAzOiAgICAgImV4YXJfMyIgICAgICAgdW51c2VkICAgaW5w
dXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA0OiAgICAgImV4YXJfNCIgICAgICAgdW51c2VkICAg
aW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA1OiAgICAgImV4YXJfNSIgICAgICAgdW51c2Vk
ICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA2OiAgICAgImV4YXJfNiIgICAgICAgdW51
c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA3OiAgICAgImV4YXJfNyIgICAgICAg
dW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA4OiAgICAgIHVubmFtZWQgICAg
ICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgICA5OiAgICAgIHVubmFtZWQg
ICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgIDEwOiAgICAgIHVubmFt
ZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgIDExOiAgICAgIHVu
bmFtZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgIDEyOiAgICAg
IHVubmFtZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgIDEzOiAg
ICAgIHVubmFtZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUgIDE0
OiAgICAgIHVubmFtZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0KCWxpbmUg
IDE1OiAgICAgIHVubmFtZWQgICAgICAgdW51c2VkICAgaW5wdXQgIGFjdGl2ZS1oaWdoIA0Kcm9v
dEBkZWJpYW46fiMgDQoNClRoYW5rcyBmb3IgeW91ciBwcmVjaW91cyBoZWxwIGFuZCBpZGVhcyAh
ISENCg0KQmVzdCByZWdhcmRzLA0KDQpGbGF2aW8NCg==
