Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D418B2A82BA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 16:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKEPyh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 10:54:37 -0500
Received: from smtp.asem.it ([151.1.184.197]:63877 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbgKEPyh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 10:54:37 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000589026.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 16:54:35 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 16:54:33 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Thu, 5 Nov 2020 16:54:33 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2wACVbgAAABK9IAABkeZAAAAulsAAALtYfA=
Date:   Thu, 5 Nov 2020 15:54:32 +0000
Message-ID: <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
In-Reply-To: <20201105152020.GO2495@lahna.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A090210.5FA42039.0083,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgTWlrYSwNCg0KPiA+ID4gPiA+IEluIG9uZSBvZiBvdXIgYm9hcmRzIHdlIGhhdmUgYW4gYWRk
LW9uIFBDSSBib2FyZCwgd2l0aCBhIFBDSQ0KPiBzZXJpYWwNCj4gPiA+IGRldmljZQ0KPiA+ID4g
PiA+IEV4YXIgWFIxN1YzNTIuIFRoaXMgZGV2aWNlIGFsc28gY29udGFpbnMgMTYgZ3Bpb3MuDQo+
ID4gPiA+ID4gVGhlIGV4YXIgZGV2aWNlIGRyaXZlcnMgd29yayBnb29kLCBib3RoIHRoZSAiODI1
MF9leGFyIiBhbmQgdGhlDQo+ID4gPiAiZ3Bpb19leGFyIiwgYW5kDQo+ID4gPiA+ID4gSSBjYW4g
bWFuYWdlIHRoZSBleGFyJ3MgZ3Bpb3MgY29ycmVjdGx5Lg0KPiA+ID4gPiA+IFRoZSBwcm9ibGVt
IGlzIGhvdyB0byBhc3NpZ24gdGhlIGdwaW8tbGluZS1uYW1lcyBwcm9wZXJ0eSB0byBhIFBDSQ0K
PiA+ID4gZ3Bpbw0KPiA+ID4gPiA+IGV4cGFuZGVycyBsaWtlIHRoaXMuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJIHRyaWVkIGFkZGluZyBhIG5ldyBkZXZpY2UgaW4gbXkgQUNQSSBjb25maWd1cmF0
aW9uLCBhczoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERldmljZSAoRVhBUikNCj4gPiA+ID4gPiB7
DQo+ID4gPiA+ID4gICAgIE5hbWUgKF9ISUQsICIxM0E4MDM1MiIpDQo+ID4gPg0KPiA+ID4gSWYg
dGhpcyBpcyBQQ0kgZGV2aWNlIHRoZW4geW91IG5lZWQgdG8gaGF2ZSBfQURSIGhlcmUgaW5zdGVh
ZCBvZiBfSElELg0KPiA+DQo+ID4gdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgcGFyZW50IGJ1cyBv
ZiB0aGlzIGRldmljZSBpcyBub3QgZGVjbGFyZWQgaW4gYW55DQo+IEFDUEkgdGFibGUuDQo+ID4g
VGhlIGV4YXIgY2hpcCBpcyBvbiB0aGUgYnVzIDcgOg0KPiA+DQo+ID4gMDc6MDAuMCBTZXJpYWwg
Y29udHJvbGxlcjogRXhhciBDb3JwLiBYUjE3VjM1MjEgRHVhbCBQQ0llIFVBUlQgKHJldiAwMykN
Cj4gPg0KPiA+IGFuZCBpbiB0aGUgX0FEUiBvYmplY3QgeW91IGNhbiBzcGVjaWZ5IGRldmljZSBh
bmQgZnVuY3Rpb24gb25seS4NCj4gPiBIb3cgY2FuIEkgc3BlY2lmeSB0aGUgcGFyZW50IGJ1cz8g
SXQgaXMgbm90IHNpbXBsZSDigKYNCj4gPiBUaGUgbHNwY2kgb3V0cHV0IGlzIHRoZSBmb2xsb3dp
bmc6DQo+IA0KPiBUaGUgcGFyZW50IGlzIHRoZSByb290IHBvcnQgdGhlIGRldmljZSBpcyBjb25u
ZWN0ZWQgdG8gYW5kIEknbSBwcmV0dHkNCj4gc3VyZSBpdCBleGlzdHMgaW4gdGhlIG5hbWVzcGFj
ZSBhcyB0aGlzIHNlZW1zIHRvIGJlIEludGVsIGhhcmR3YXJlLiBJZg0KPiB5b3UgcnVuICdsc3Bj
aSAtdCcgaXQgc2hvd3MgeW91IHRoZSByb290IHBvcnQuDQo+IA0KPiBUaGUgX0FEUiBzaG91bGQg
YmUgMCBmb3IgdGhpcyBvbmUuDQoNClVuZm9ydHVuYXRlbHkgdGhlcmUgaXMgYnJpZGdlIGluIHRo
ZSBtaWRkbGU6DQoNCnJvb3RAZGViaWFuOn4jIGxzcGNpIC10DQotWzAwMDA6MDBdLSstMDAuMA0K
ICAgICAgICAgICArLTAyLjANCiAgICAgICAgICAgKy0wZS4wDQogICAgICAgICAgICstMGYuMA0K
ICAgICAgICAgICArLTEyLjANCiAgICAgICAgICAgKy0xMy4wLVswMV0tLS0tMDAuMA0KICAgICAg
ICAgICArLTEzLjEtWzAyXS0tLS0wMC4wDQogICAgICAgICAgICstMTMuMi1bMDNdLS0NCiAgICAg
ICAgICAgKy0xNC4wLVswNF0tLS0tMDAuMA0KICAgICAgICAgICArLTE0LjEtWzA1LTA5XS0tLS0w
MC4wLVswNi0wOV0tLSstMDEuMC1bMDddLS0tLTAwLjAgPC0tIEV4YXIgKGJ1cyA3LCBkZXYgMCwg
ZnVuY3QgMCkNCiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLTAy
LjAtWzA4XS0tLS0wMC4wDQogICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXC0wMy4wLVswOV0tLQ0KICAgICAgICAgICArLTE1LjANCiAgICAgICAgICAgKy0xNi4wDQog
ICAgICAgICAgICstMTYuMQ0KICAgICAgICAgICArLTE5LjANCiAgICAgICAgICAgKy0xOS4xDQog
ICAgICAgICAgICstMTkuMg0KICAgICAgICAgICArLTFmLjANCiAgICAgICAgICAgXC0xZi4xDQpy
b290QGRlYmlhbjp+Iw0KDQpNeSBjaGFuZ2VzIGluIHRoZSBBQ1BJOg0KDQpTY29wZSAoX1NCLlBD
STApIHsNCiAgICBEZXZpY2UgKEVYQVIpDQoJCXsNCgkJCU5hbWUgKF9BRFIsIDB4MDAwMCkNCi4u
Li4NCg0KYnV0IGl0IGRvZXNuJ3Qgd29yaywgYmVjYXVzZSBvZiB0aGUgYnJpZGdlLg0KDQpSZWdh
cmRzLA0KDQpGbGF2aW8NCg0KDQoNCg==
