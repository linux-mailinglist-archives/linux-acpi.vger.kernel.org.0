Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B87E3FE
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfHAUR7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 16:17:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:43706 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389014AbfHAUR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Aug 2019 16:17:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="372728424"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2019 13:17:55 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 13:17:55 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.251]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 13:17:54 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Qian Cai <cai@lca.pw>, "Moore, Robert" <robert.moore@intel.com>,
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
Thread-Index: AQHVPaHqe/gnJU6NbEKNryIU7CFGuabdzLyAgAloioD//5trIA==
Date:   Thu, 1 Aug 2019 20:17:55 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C618109@ORSMSX122.amr.corp.intel.com>
References: <20190718194846.1880-1-cai@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
 <1564686979.11067.48.camel@lca.pw>
In-Reply-To: <1564686979.11067.48.camel@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODI2ZGY1OTItNDEyMS00ZGYzLWFiYjgtOTUzMDk4MzM4OWY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakVRcDFSYXhteXJsblwvTnFwZ3ZPcVwvQkJvQjh6bVZSRXBnTmt6dkhsbkViTU11SEl0SkZCY2NpZVU1MWdNbElkIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWlhbiBDYWkgW21haWx0
bzpjYWlAbGNhLnB3XQ0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDEsIDIwMTkgMTI6MTYgUE0N
Cj4gVG86IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBXeXNvY2tpLCBS
YWZhZWwgSg0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IENjOiBTY2htYXVzcywg
RXJpayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+OyBqa2ltQEZyZWVCU0Qub3JnOw0KPiBsZW5i
QGtlcm5lbC5vcmc7IG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tOyBsaW51eC1hY3BpQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2ZWxAYWNwaWNhLm9yZzsgY2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3Jv
dXBzLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2Ml0gYWNwaWNhOiBmaXggLVdudWxsLXBvaW50ZXItYXJpdGhtZXRpYyB3YXJuaW5n
cw0KPiANCj4gT24gRnJpLCAyMDE5LTA3LTI2IGF0IDE5OjM1ICswMDAwLCBNb29yZSwgUm9iZXJ0
IHdyb3RlOg0KPiA+IFdlJ3ZlIHRha2VuIHRoZSBjaGFuZ2UgdG8gQUNQSV9UT19QT0lOVEVSLg0K
PiANCj4gSSBhbSBhIGJpdCBjb25mdXNlZCBoZXJlLiBJIHNhdyB0aGUgY29tbWl0IGluIHRoZSBh
Y3BpYSByZXBvLg0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2EvY29tbWl0
LzAyYmJjYTUwNzBlNDJkMjk4YzliODI0MzAwYWEwDQo+IGViOGEwODJkNzk3DQo+IA0KPiBidXQg
aG93IGRvZXMgdGhhdCBjaGFuZ2Ugd2lsbCBnbyBpbnRvIHRoZSBsaW51eCBrZXJuZWw/IFN1cHBv
c2UgUmFmYWVsIHdpbGwNCj4gbmVlZCB0byBwaWNrIGl0IHVwIG1hbnVhbGx5Pw0KDQpJIGRvIHRo
YXQgYWZ0ZXIgZXZlcnkgQUNQSUNBIHJlbGVhc2UNCg0KRXJpaw0KPiANCj4gPg0KPiA+DQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBRaWFuIENhaSBbbWFpbHRvOmNh
aUBsY2EucHddDQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMTkgMTI6NDkgUE0NCj4g
PiBUbzogV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+
IENjOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgU2NobWF1c3MsIEVy
aWsNCj4gPiA8ZXJpay5zY2htYXVzc0BpbnRlIGwuY29tPjsgamtpbUBGcmVlQlNELm9yZzsgbGVu
YkBrZXJuZWwub3JnOw0KPiA+IG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tOyBsaW51eC1hY3BpIEB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gZGV2ZWxAYWNwaWNhLm9yZzsgY2xhbmctYnVpbHQtbGludXhA
Z29vZ2xlZ3JvdXBzLmNvbTsgbGludXgtDQo+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUWlh
biBDYWkgPGNhaUBsY2EucHc+DQo+ID4gU3ViamVjdDogW1BBVENIIHYyXSBhY3BpY2E6IGZpeCAt
V251bGwtcG9pbnRlci1hcml0aG1ldGljIHdhcm5pbmdzDQo+ID4NCj4gPiBDbGFuZyBnZW5lcmF0
ZSBxdWl0ZSBhIGZldyBvZiB0aG9zZSB3YXJuaW5ncy4NCj4gPg0KPiA+IGRyaXZlcnMvYWNwaS9z
Y2FuLmM6NzU5OjI4OiB3YXJuaW5nOiBhcml0aG1ldGljIG9uIGEgbnVsbCBwb2ludGVyDQo+ID4g
dHJlYXRlZCBhcyBhIGNhc3QgZnJvbSBpbnRlZ2VyIHRvIHBvaW50ZXIgaXMgYSBHTlUgZXh0ZW5z
aW9uIFstV251bGwtcG9pbnRlci0NCj4gYXJpdGhtZXRpY10NCj4gPiAJCXN0YXR1cyA9IGFjcGlf
Z2V0X2hhbmRsZShBQ1BJX1JPT1RfT0JKRUNULA0KPiA+IG9iai0+c3RyaW5nLnBvaW50ZXIsDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF5+fn5+fn5+fn5+fn5+fn4NCj4gPiAuL2luY2x1
ZGUvYWNwaS9hY3R5cGVzLmg6NDU4OjU2OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvDQo+ICdB
Q1BJX1JPT1RfT0JKRUNUJw0KPiA+IMKgI2RlZmluZSBBQ1BJX1JPT1RfT0JKRUNUwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoKGFjcGlfaGFuZGxlKQ0KPiA+IEFDUElfVE9fUE9JTlRF
Ug0KPiA+IChBQ1BJX01BWF9QVFIpKQ0KPiA+IAkJCQkJCQlefn5+fn5+fn5+fn5+fn4NCj4gPiAu
L2luY2x1ZGUvYWNwaS9hY3R5cGVzLmg6NTA5OjQxOiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3Jv
DQo+ICdBQ1BJX1RPX1BPSU5URVInDQo+ID4gwqAjZGVmaW5lIEFDUElfVE9fUE9JTlRFUihpKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0FERF9QVFIgKHZvaWQsICh2b2lkICopDQo+
ID4gMCwNCj4gPiAoYWNwaV9zaXplKSAoaSkpDQo+ID4NCj4gPiBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ID4gLi9pbmNsdWRlL2FjcGkvYWN0eXBlcy5oOjUwMzo4NDogbm90ZTog
ZXhwYW5kZWQgZnJvbSBtYWNybyAnQUNQSV9BRERfUFRSJw0KPiA+IMKgI2RlZmluZSBBQ1BJX0FE
RF9QVFIodCwgYSwgYinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9DQVNUX1BUUiAodCwNCj4g
PiAoQUNQSV9DQVNUX1BUUiAodTgsIChhKSkgKyAoYWNwaV9zaXplKShiKSkpDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoF5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gLi9pbmNsdWRlL2FjcGkv
YWN0eXBlcy5oOjUwMTo2Njogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybw0KPiAnQUNQSV9DQVNU
X1BUUicNCj4gPiDCoCNkZWZpbmUgQUNQSV9DQVNUX1BUUih0LCBwKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKCh0ICopIChhY3BpX3VpbnRwdHJfdCkgKHApKQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBeDQo+ID4gVGhpcyBpcyBiZWNhdXNlIHBvaW50ZXIgYXJpdGhtZXRpYyBvbiBhIHBvaW50ZXIg
bm90IHBvaW50aW5nIHRvIGFuDQo+ID4gYXJyYXkgaXMgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIChD
MTEgNi41LjYsIGNvbnN0cmFpbnQgOCkuIEZpeCBpdCBieQ0KPiA+IGp1c3QgY2FzdGluZyB0aGUg
Y29ycmVzcG9uZGluZyBwb2ludGVycyB1c2luZyBBQ1BJX0NBU1RfUFRSKCkgYW5kIHNraXANCj4g
PiB0aGUgYXJpdGhtZXRpYy4gQWxzbywgZml4IGEgY2hlY2twYXRjaCB3YXJuaW5nIHRvZ2V0aGVy
Lg0KPiA+DQo+ID4gRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBl
bmNsb3NlZCBpbiBwYXJlbnRoZXNlcw0KPiA+IMKgIzQ1OiBGSUxFOiBpbmNsdWRlL2FjcGkvYWN0
eXBlcy5oOjUwOToNCj4gPiArI2RlZmluZSBBQ1BJX1RPX1BPSU5URVIoaSnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgQUNQSV9DQVNUX1BUUiAodm9pZCwgaSkNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFFpYW4gQ2FpIDxjYWlAbGNhLnB3Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gdjI6IFVzZSBB
Q1BJX0NBU1RfUFRSKCkgaW4gQUNQSV9UT19QT0lOVEVSKCkgZGlyZWN0bHkgd2l0aG91dA0KPiA+
IMKgwqDCoMKgYXJpdGhtZXRpYy4NCj4gPg0KPiA+IMKgaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCB8
IDIgKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmggYi9pbmNsdWRl
L2FjcGkvYWN0eXBlcy5oIGluZGV4DQo+ID4gYWQ2ODkyYTI0MDE1Li4xNjMxODFlMmQ4ODQgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
YWNwaS9hY3R5cGVzLmgNCj4gPiBAQCAtNTA2LDcgKzUwNiw3IEBAIHR5cGVkZWYgdTY0IGFjcGlf
aW50ZWdlcjsNCj4gPg0KPiA+IMKgLyogUG9pbnRlci9JbnRlZ2VyIHR5cGUgY29udmVyc2lvbnMg
Ki8NCj4gPg0KPiA+IC0jZGVmaW5lIEFDUElfVE9fUE9JTlRFUihpKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBBQ1BJX0FERF9QVFIgKHZvaWQsICh2b2lkICopDQo+ID4gMCwNCj4gPiAoYWNw
aV9zaXplKSAoaSkpDQo+ID4gKyNkZWZpbmUgQUNQSV9UT19QT0lOVEVSKGkpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoChBQ1BJX0NBU1RfUFRSICh2b2lkLCBpKSkNCj4gPiDCoCNkZWZpbmUg
QUNQSV9UT19JTlRFR0VSKHApwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFDUElfUFRSX0RJ
RkYgKHAsICh2b2lkICopIDApDQo+ID4gwqAjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9QVFJfRElGRiAoJigoKGQgKikNCj4gPiAwKS0+
ZiksICh2b2lkDQo+ID4gKikgMCkNCj4gPiDCoCNkZWZpbmUgQUNQSV9QSFlTQUREUl9UT19QVFIo
aSnCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX1RPX1BPSU5URVIoaSkNCj4gPiAtLQ0KPiA+IDIuMjAu
MSAoQXBwbGUgR2l0LTExNykNCj4gPg0K
