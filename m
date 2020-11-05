Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C102E2A8371
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgKEQYg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 11:24:36 -0500
Received: from smtp.asem.it ([151.1.184.197]:60759 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgKEQYg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 11:24:36 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000589154.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 17:24:34 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 17:24:32 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Thu, 5 Nov 2020 17:24:32 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2wACVbgAAABK9IAABkeZAAAAulsAAALtYfD///ZLgIAAAsSA///upnA=
Date:   Thu, 5 Nov 2020 16:24:32 +0000
Message-ID: <942133825ef348d49a97a6bdc16a72e4@asem.it>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201105160925.GW4077@smile.fi.intel.com>
 <20201105161919.GX4077@smile.fi.intel.com>
In-Reply-To: <20201105161919.GX4077@smile.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A090202.5FA42741.0023,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQW5keSwNCg0KPiA+ID4NCj4gPiA+IFVuZm9ydHVuYXRlbHkgdGhlcmUgaXMgYnJpZGdlIGlu
IHRoZSBtaWRkbGU6DQo+ID4gPg0KPiA+ID4gcm9vdEBkZWJpYW46fiMgbHNwY2kgLXQNCj4gPiA+
IC1bMDAwMDowMF0tKy0wMC4wDQo+ID4gPiAgICAgICAgICAgICstMDIuMA0KPiA+ID4gICAgICAg
ICAgICArLTBlLjANCj4gPiA+ICAgICAgICAgICAgKy0wZi4wDQo+ID4gPiAgICAgICAgICAgICst
MTIuMA0KPiA+ID4gICAgICAgICAgICArLTEzLjAtWzAxXS0tLS0wMC4wDQo+ID4gPiAgICAgICAg
ICAgICstMTMuMS1bMDJdLS0tLTAwLjANCj4gPiA+ICAgICAgICAgICAgKy0xMy4yLVswM10tLQ0K
PiA+ID4gICAgICAgICAgICArLTE0LjAtWzA0XS0tLS0wMC4wDQo+ID4gPiAgICAgICAgICAgICst
MTQuMS1bMDUtMDldLS0tLTAwLjAtWzA2LTA5XS0tKy0wMS4wLVswN10tLS0tMDAuMCA8LS0NCj4g
RXhhciAoYnVzIDcsIGRldiAwLCBmdW5jdCAwKQ0KPiA+ID4gICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICstMDIuMC1bMDhdLS0tLTAwLjANCj4gPiA+ICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcLTAzLjAtWzA5XS0tDQo+ID4gPiAg
ICAgICAgICAgICstMTUuMA0KPiA+ID4gICAgICAgICAgICArLTE2LjANCj4gPiA+ICAgICAgICAg
ICAgKy0xNi4xDQo+ID4gPiAgICAgICAgICAgICstMTkuMA0KPiA+ID4gICAgICAgICAgICArLTE5
LjENCj4gPiA+ICAgICAgICAgICAgKy0xOS4yDQo+ID4gPiAgICAgICAgICAgICstMWYuMA0KPiA+
ID4gICAgICAgICAgICBcLTFmLjENCj4gPiA+IHJvb3RAZGViaWFuOn4jDQo+ID4gPg0KPiA+ID4g
TXkgY2hhbmdlcyBpbiB0aGUgQUNQSToNCj4gPiA+DQo+ID4gPiBTY29wZSAoX1NCLlBDSTApIHsN
Cj4gPiA+ICAgICBEZXZpY2UgKEVYQVIpDQo+ID4gPiAJCXsNCj4gPiA+IAkJCU5hbWUgKF9BRFIs
IDB4MDAwMCkNCj4gPg0KPiA+IF9BRFIgc2hvdWxkIHJlcHJlc2VudCBCREYgKEJ1czpEZXZpY2Uu
RnVuY3Rpb24pDQo+ID4NCj4gPiBTb21ldGhpbmcgbGlrZSAweDA3MDAwMDAwDQo+IA0KPiBQZXIg
ZG9jdW1lbnRhdGlvbjoNCj4gIkhpZ2ggd29yZOKAk0RldmljZSAjLCBMb3cgd29yZOKAk0Z1bmN0
aW9uICMuIChmb3IgZXhhbXBsZSwgZGV2aWNlIDMsIGZ1bmN0aW9uDQo+IDIgaXMNCj4gMHgwMDAz
MDAwMikuIFRvIHJlZmVyIHRvIGFsbCB0aGUgZnVuY3Rpb25zIG9uIGEgZGV2aWNlICMsIHVzZSBh
IGZ1bmN0aW9uDQo+IG51bWJlciBvZiBGRkZGKS4iDQo+IA0KDQpleGFjdGx5LCB3aXRoIHRoZSBf
QURSIG9iamVjdCB3ZSBjYW4gc3BlY2lmeSBvbmx5IGRldmljZSBhbmQgZnVuY3Rpb24uIA0KVGhl
IGJ1cyBpcyBpbXBsaWNpdCwgdGhhdCdzIHdheSBJIHVzZWQgdGhlOg0KDQpTY29wZSAoX1NCLlBD
STApIHsgLi4uDQoNCkJ1dCBpdCBpcyB0aGUgd3JvbmcgYnVzLCBiZWNhdXNlIG9mIGEgYnJpZGdl
IGluIHRoZSBtaWRkbGUuDQoNCkJlc3QgcmVnYXJkcywNCg0KRmxhdmlvDQo=
