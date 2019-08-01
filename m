Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C867E447
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfHAU2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 16:28:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:18135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfHAU2y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Aug 2019 16:28:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="175366267"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2019 13:28:53 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 13:28:52 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.211]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 13:28:52 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>, Qian Cai <cai@lca.pw>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "jkim@FreeBSD.org" <jkim@FreeBSD.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Topic: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Index: AQHVPaHylXmfzBauvEybJLDaugeeCqbdV0WAgAneAYCAABE2gP//jYhw
Date:   Thu, 1 Aug 2019 20:28:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96643D0@ORSMSX110.amr.corp.intel.com>
References: <20190718194846.1880-1-cai@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
 <1564686979.11067.48.camel@lca.pw>
 <CF6A88132359CE47947DB4C6E1709ED53C618109@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C618109@ORSMSX122.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODI2ZGY1OTItNDEyMS00ZGYzLWFiYjgtOTUzMDk4MzM4OWY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakVRcDFSYXhteXJsblwvTnFwZ3ZPcVwvQkJvQjh6bVZSRXBnTmt6dkhsbkViTU11SEl0SkZCY2NpZVU1MWdNbElkIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTY2htYXVzcywgRXJpayANClNl
bnQ6IFRodXJzZGF5LCBBdWd1c3QgMDEsIDIwMTkgMToxOCBQTQ0KVG86IFFpYW4gQ2FpIDxjYWlA
bGNhLnB3PjsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29ja2ks
IFJhZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCkNjOiBqa2ltQEZyZWVCU0Qu
b3JnOyBsZW5iQGtlcm5lbC5vcmc7IG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tOyBsaW51eC1hY3Bp
QHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgY2xhbmctYnVpbHQtbGludXhAZ29v
Z2xlZ3JvdXBzLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUkU6
IFtQQVRDSCB2Ml0gYWNwaWNhOiBmaXggLVdudWxsLXBvaW50ZXItYXJpdGhtZXRpYyB3YXJuaW5n
cw0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRaWFuIENhaSBb
bWFpbHRvOmNhaUBsY2EucHddDQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMSwgMjAxOSAxMjox
NiBQTQ0KPiBUbzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29j
a2ksIFJhZmFlbCBKIA0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IENjOiBTY2ht
YXVzcywgRXJpayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+OyBqa2ltQEZyZWVCU0Qub3JnOyAN
Cj4gbGVuYkBrZXJuZWwub3JnOyBuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbTsgbGludXgtYWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IA0KPiBkZXZlbEBhY3BpY2Eub3JnOyBjbGFuZy1idWlsdC1saW51eEBn
b29nbGVncm91cHMuY29tOyBsaW51eC0gDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gYWNwaWNhOiBmaXggLVdudWxsLXBvaW50ZXItYXJpdGhtZXRp
YyB3YXJuaW5ncw0KPiANCj4gT24gRnJpLCAyMDE5LTA3LTI2IGF0IDE5OjM1ICswMDAwLCBNb29y
ZSwgUm9iZXJ0IHdyb3RlOg0KPiA+IFdlJ3ZlIHRha2VuIHRoZSBjaGFuZ2UgdG8gQUNQSV9UT19Q
T0lOVEVSLg0KPiANCj4gSSBhbSBhIGJpdCBjb25mdXNlZCBoZXJlLiBJIHNhdyB0aGUgY29tbWl0
IGluIHRoZSBhY3BpYSByZXBvLg0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3Bp
Y2EvY29tbWl0LzAyYmJjYTUwNzBlNDJkMjk4YzliODI0MzAwYWEwDQo+IGViOGEwODJkNzk3DQo+
IA0KPiBidXQgaG93IGRvZXMgdGhhdCBjaGFuZ2Ugd2lsbCBnbyBpbnRvIHRoZSBsaW51eCBrZXJu
ZWw/IFN1cHBvc2UgUmFmYWVsIA0KPiB3aWxsIG5lZWQgdG8gcGljayBpdCB1cCBtYW51YWxseT8N
Cg0KPkkgZG8gdGhhdCBhZnRlciBldmVyeSBBQ1BJQ0EgcmVsZWFzZQ0KDQpXaGljaCBoYXBwZW5z
IGFib3V0IG9uY2UgcGVyIG1vbnRoLg0KDQo+RXJpaw0KPiANCj4gPg0KPiA+DQo+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBRaWFuIENhaSBbbWFpbHRvOmNhaUBsY2Eu
cHddDQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMTkgMTI6NDkgUE0NCj4gPiBUbzog
V3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+IENjOiBN
b29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgU2NobWF1c3MsIEVyaWsgDQo+
ID4gPGVyaWsuc2NobWF1c3NAaW50ZSBsLmNvbT47IGpraW1ARnJlZUJTRC5vcmc7IGxlbmJAa2Vy
bmVsLm9yZzsgDQo+ID4gbmRlc2F1bG5pZXJzQGdvb2dsZS5jb207IGxpbnV4LWFjcGkgQHZnZXIu
a2VybmVsLm9yZzsgDQo+ID4gZGV2ZWxAYWNwaWNhLm9yZzsgY2xhbmctYnVpbHQtbGludXhAZ29v
Z2xlZ3JvdXBzLmNvbTsgbGludXgtIA0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFFpYW4g
Q2FpIDxjYWlAbGNhLnB3Pg0KPiA+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gYWNwaWNhOiBmaXggLVdu
dWxsLXBvaW50ZXItYXJpdGhtZXRpYyB3YXJuaW5ncw0KPiA+DQo+ID4gQ2xhbmcgZ2VuZXJhdGUg
cXVpdGUgYSBmZXcgb2YgdGhvc2Ugd2FybmluZ3MuDQo+ID4NCj4gPiBkcml2ZXJzL2FjcGkvc2Nh
bi5jOjc1OToyODogd2FybmluZzogYXJpdGhtZXRpYyBvbiBhIG51bGwgcG9pbnRlciANCj4gPiB0
cmVhdGVkIGFzIGEgY2FzdCBmcm9tIGludGVnZXIgdG8gcG9pbnRlciBpcyBhIEdOVSBleHRlbnNp
b24gDQo+ID4gWy1XbnVsbC1wb2ludGVyLQ0KPiBhcml0aG1ldGljXQ0KPiA+IAkJc3RhdHVzID0g
YWNwaV9nZXRfaGFuZGxlKEFDUElfUk9PVF9PQkpFQ1QsDQo+ID4gb2JqLT5zdHJpbmcucG9pbnRl
ciwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXn5+fn5+fn5+fn5+fn5+fg0KPiA+IC4v
aW5jbHVkZS9hY3BpL2FjdHlwZXMuaDo0NTg6NTY6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8N
Cj4gJ0FDUElfUk9PVF9PQkpFQ1QnDQo+ID4gwqAjZGVmaW5lIEFDUElfUk9PVF9PQkpFQ1TCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCgoYWNwaV9oYW5kbGUpIA0KPiA+IEFDUElfVE9f
UE9JTlRFUg0KPiA+IChBQ1BJX01BWF9QVFIpKQ0KPiA+IAkJCQkJCQlefn5+fn5+fn5+fn5+fn4N
Cj4gPiAuL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmg6NTA5OjQxOiBub3RlOiBleHBhbmRlZCBmcm9t
IG1hY3JvDQo+ICdBQ1BJX1RPX1BPSU5URVInDQo+ID4gwqAjZGVmaW5lIEFDUElfVE9fUE9JTlRF
UihpKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0FERF9QVFIgKHZvaWQsICh2b2lk
IA0KPiA+ICopIDAsDQo+ID4gKGFjcGlfc2l6ZSkgKGkpKQ0KPiA+DQo+ID4gXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IC4vaW5jbHVkZS9hY3BpL2FjdHlwZXMuaDo1MDM6ODQ6
IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ0FDUElfQUREX1BUUicNCj4gPiDCoCNkZWZpbmUg
QUNQSV9BRERfUFRSKHQsIGEsIGIpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFDUElfQ0FTVF9QVFIg
KHQsIA0KPiA+IChBQ1BJX0NBU1RfUFRSICh1OCwgKGEpKSArIChhY3BpX3NpemUpKGIpKSkNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXn5+fn5+fn5+fn5+fn5+fn4NCj4gPiAuL2luY2x1
ZGUvYWNwaS9hY3R5cGVzLmg6NTAxOjY2OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvDQo+ICdB
Q1BJX0NBU1RfUFRSJw0KPiA+IMKgI2RlZmluZSBBQ1BJX0NBU1RfUFRSKHQsIHApwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAoKHQgKikgKGFjcGlfdWludHB0cl90KSANCj4gPiAocCkpDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoF4gDQo+ID4gVGhpcyBpcyBiZWNhdXNlIHBvaW50ZXIgYXJpdGhtZXRp
YyBvbiBhIHBvaW50ZXIgbm90IHBvaW50aW5nIHRvIGFuIA0KPiA+IGFycmF5IGlzIGFuIHVuZGVm
aW5lZCBiZWhhdmlvciAoQzExIDYuNS42LCBjb25zdHJhaW50IDgpLiBGaXggaXQgYnkgDQo+ID4g
anVzdCBjYXN0aW5nIHRoZSBjb3JyZXNwb25kaW5nIHBvaW50ZXJzIHVzaW5nIEFDUElfQ0FTVF9Q
VFIoKSBhbmQgDQo+ID4gc2tpcCB0aGUgYXJpdGhtZXRpYy4gQWxzbywgZml4IGEgY2hlY2twYXRj
aCB3YXJuaW5nIHRvZ2V0aGVyLg0KPiA+DQo+ID4gRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBsZXgg
dmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNlcw0KPiA+IMKgIzQ1OiBGSUxF
OiBpbmNsdWRlL2FjcGkvYWN0eXBlcy5oOjUwOToNCj4gPiArI2RlZmluZSBBQ1BJX1RPX1BPSU5U
RVIoaSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9DQVNUX1BUUiAodm9pZCwgaSkN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpYW4gQ2FpIDxjYWlAbGNhLnB3Pg0KPiA+IC0tLQ0K
PiA+DQo+ID4gdjI6IFVzZSBBQ1BJX0NBU1RfUFRSKCkgaW4gQUNQSV9UT19QT0lOVEVSKCkgZGly
ZWN0bHkgd2l0aG91dA0KPiA+IMKgwqDCoMKgYXJpdGhtZXRpYy4NCj4gPg0KPiA+IMKgaW5jbHVk
ZS9hY3BpL2FjdHlwZXMuaCB8IDIgKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9h
Y3R5cGVzLmggYi9pbmNsdWRlL2FjcGkvYWN0eXBlcy5oIGluZGV4DQo+ID4gYWQ2ODkyYTI0MDE1
Li4xNjMxODFlMmQ4ODQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaA0K
PiA+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgNCj4gPiBAQCAtNTA2LDcgKzUwNiw3IEBA
IHR5cGVkZWYgdTY0IGFjcGlfaW50ZWdlcjsNCj4gPg0KPiA+IMKgLyogUG9pbnRlci9JbnRlZ2Vy
IHR5cGUgY29udmVyc2lvbnMgKi8NCj4gPg0KPiA+IC0jZGVmaW5lIEFDUElfVE9fUE9JTlRFUihp
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0FERF9QVFIgKHZvaWQsICh2b2lkIA0K
PiA+ICopIDAsDQo+ID4gKGFjcGlfc2l6ZSkgKGkpKQ0KPiA+ICsjZGVmaW5lIEFDUElfVE9fUE9J
TlRFUihpKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoQUNQSV9DQVNUX1BUUiAodm9pZCwg
aSkpDQo+ID4gwqAjZGVmaW5lIEFDUElfVE9fSU5URUdFUihwKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBBQ1BJX1BUUl9ESUZGIChwLCAodm9pZCAqKSANCj4gPiAwKQ0KPiA+IMKgI2RlZmlu
ZSBBQ1BJX09GRlNFVChkLCBmKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFDUElfUFRS
X0RJRkYgKCYoKChkICopIA0KPiA+IDApLT5mKSwgKHZvaWQNCj4gPiAqKSAwKQ0KPiA+IMKgI2Rl
ZmluZSBBQ1BJX1BIWVNBRERSX1RPX1BUUihpKcKgwqDCoMKgwqDCoMKgwqDCoEFDUElfVE9fUE9J
TlRFUihpKQ0KPiA+IC0tDQo+ID4gMi4yMC4xIChBcHBsZSBHaXQtMTE3KQ0KPiA+DQo=
