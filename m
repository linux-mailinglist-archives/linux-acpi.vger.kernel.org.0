Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2F27D35B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgI2QK6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 12:10:58 -0400
Received: from smtp.asem.it ([151.1.184.197]:59429 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2QK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 12:10:57 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000512599.MSG 
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 18:10:54 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 18:10:52 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Tue, 29 Sep 2020 18:10:52 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoA///YULA=
Date:   Tue, 29 Sep 2020 16:10:52 +0000
Message-ID: <43a2499484c2435eae63fe372f9b7b17@asem.it>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
In-Reply-To: <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
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
X-SGOP-RefID: str=0001.0A090210.5F735C8D.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQmFydG9zeiwNCg0KPiA+IEkgbmVlZCB0byBleHBvc2UgdG8gdGhlIHVzZXJzcGFjZSBhIEdQ
SU8sIHBoeXNpY2FsbHkgY29ubmVjdGVkIHRvIGENCj4gYm9hcmQNCj4gPiBwdXNoLWJ1dHRvbi4g
VGhpcyBHUElPIG11c3QgZXhwb3NlIGEgcHJlLWRlZmluZWQgbmFtZSwgc3VjaCBhcw0KPiA+ICJ1
c2VyLXB1c2gtYnV0dG9uIiwgc28gdGhhdCB0aGUgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBjYW4g
dXNlIGl0DQo+IHdpdGhvdXQNCj4gPiBrbm93IGFueSBwaHlzaWNhbCBHUElPIGRldGFpbHMuDQo+
ID4NCj4gPiBJIGNhbiBjdXN0b21pemUgdGhlIGJvYXJkIEJJT1MgYW5kIHNvIG15IGdvYWwgaXMg
dG8gYWRkIGFuIEFDUEkgdGFibGUNCj4gd2l0aA0KPiA+IGEgY29udGVudCBsaWtlIHRoaXM6DQo+
ID4NCj4gPiAuLi4NCj4gPiBTY29wZSAoXF9TQi5HUE8xKQ0KPiA+ICAgICAgICAgew0KPiA+ICAg
ICAgICAgICAgICAgICBEZXZpY2UgKEJUTlMpDQo+ID4gICAgICAgICAgICAgICAgIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBOYW1lIChfSElELCAiUFJQMDAwMSIpDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgTmFtZSAoX0RETiwgIkdQSU8gYnV0dG9ucyBkZXZpY2UiKQ0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgTmFtZSAoX0NSUywgUmVzb3VyY2VUZW1wbGF0
ZSAoKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdwaW9JbyAoDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFeGNsdXNpdmUsICAgICAgICAgICAgICAgLy8gTm90IHNoYXJlZA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUHVsbE5vbmUsICAgICAgICAgICAgICAgIC8vIE5vIG5l
ZWQgZm9yDQo+IHB1bGxzDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAg
ICAgICAgICAgICAgICAgICAgICAgLy8gRGVib3VuY2UNCj4gdGltZW91dA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMCwgICAgICAgICAgICAgICAgICAgICAgIC8vIERyaXZl
DQo+IHN0cmVuZ3RoDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJb1Jlc3Ry
aWN0aW9uSW5wdXRPbmx5LCAgLy8gT25seSB1c2VkIGFzDQo+IGlucHV0DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiXFxfU0IuR1BPMSIsICAgICAgICAgICAgLy8gR1BJTw0K
PiBjb250cm9sbGVyDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBSZXNv
dXJjZUNvbnN1bWVyLCAsICkgLy8gTXVzdCBiZSAwDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDI1LCAgICAgICAgICAgICAgLy8gR1BJTyBudW1iZXINCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gPiAuLi4NCj4gPg0KPiA+IEkga25vdyB0aGF0IHRoaXMgR1BJTyBj
YW4gYmUgdXNlZCBmcm9tIG90aGVyIGRyaXZlcnMuDQo+ID4gRm9yIGV4YW1wbGUgSSBzdWNjZXNz
ZnVsbHkgdGVzdGVkIGl0IHVzaW5nIHRoZSAiZ3Bpby1rZXlzIiBkZXZpY2UNCj4gZHJpdmVyLA0K
PiA+IGdpdmluZyB0byBteSBHUElPIGEga2V5LWNvZGUgYW5kIGVtdWxhdGluZyBpbiB0aGlzIHdh
eSBhIGtleWJvYXJkIGtleS4NCj4gPiBUaGlzIGNvdWxkIGJlIGEgcG9zc2libGUgc29sdXRpb24u
DQo+ID4NCj4gPiBCdXQgSSBwcmVmZXIgdG8gZXhwb3NlIG15IEdQSU8gYXMgYSBjbGFzc2ljIEdQ
SU8sIG5vdCBhcyBhIGtleWJvYXJkIGtleS4NCj4gPg0KPiA+IEkgd2FzIHdvbmRlcmluZyBpZiB0
aGVyZSBpcyBhIGdlbmVyaWMgR1BJTyBkcml2ZXIgdGhhdCBJIGNhbiB1c2UgdG8NCj4gZXhwb3Nl
DQo+ID4gdGhpcyBHUElPIHdpdGggaXRzIHByZS1kZWZpbmVkIG5hbWUgKGNhbWluZyBmcm9tIHRo
ZSBBQ1BJIHRhYmxlDQo+IGRlY2xhcmF0aW9uKSwNCj4gPiB0byB0aGUgdXNlcnNwYWNlLi4uDQo+
ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4NCj4gPiBGbGF2aW8NCj4gDQo+IEFkZGluZyBBbmR5
IHdobyBrbm93cyBBQ1BJIEdQSU8gd2VsbC4NCj4gDQo+IEluIGdlbmVyYWwsIHRoZSAiZ3Bpby1s
aW5lLW5hbWVzIiBwcm9wZXJ0eSBpcyB1c2VkIGZvciB0aGF0IGFuZCBpdCdzDQo+IHN1cHBvcnRl
ZCBib3RoIGZvciBkZXZpY2UgdHJlZSBhcyB3ZWxsIGFzIEFDUEksIGFsdGhvdWdoIEkgaGF2ZSBv
bmx5DQo+IGV2ZXIgdXNlZCB0aGUgZm9ybWVyLg0KPiANCj4gQmFydG9zeg0KDQpUaGFua3MhIEkn
bGwgdHJ5ISEhDQoNCkZsYXZpbw0K
