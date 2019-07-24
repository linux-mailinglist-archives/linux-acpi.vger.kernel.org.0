Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7B473160
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2019 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGXORC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jul 2019 10:17:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:16617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfGXORC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 07:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="169940375"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2019 07:17:01 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 24 Jul 2019 07:17:00 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.211]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.251]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 07:17:00 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Qian Cai <cai@lca.pw>, Nick Desaulniers <ndesaulniers@google.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@freebsd.org" <jkim@freebsd.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Topic: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Index: AQHVPFEYIycQ0k5IUUyXy4NqYzTqpqbP0wgAgAAvDoCACLPGAIABkXSA//+Ut6A=
Date:   Wed, 24 Jul 2019 14:17:00 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96618DB@ORSMSX110.amr.corp.intel.com>
References: <20190717033807.1207-1-cai@lca.pw>
         <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
         <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
 <1563975605.11067.8.camel@lca.pw>
In-Reply-To: <1563975605.11067.8.camel@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjQzMDk3MjEtZGJkZi00NDhkLWE2NjYtNzY3MGNkODBkZDdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXE1WTNsUUNTQWJPbTRuU2NKTXJtaUFKQmhaN1NKcEtRcTluTGNpN0dmZW9QaUhKWFd3U2NHbTZJb0Z1WGUzZCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBRaWFuIENhaSBbbWFpbHRvOmNh
aUBsY2EucHddIA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDI0LCAyMDE5IDY6NDAgQU0NClRvOiBN
b29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgTmljayBEZXNhdWxuaWVycyA8
bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQpDYzogV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPjsgU2NobWF1c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50ZWwu
Y29tPjsgamtpbUBmcmVlYnNkLm9yZzsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgY2xhbmctYnVpbHQtbGlu
dXggPGNsYW5nLWJ1aWx0LWxpbnV4QGdvb2dsZWdyb3Vwcy5jb20+OyBMS01MIDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gYWNwaWNhOiBmaXggLVdu
dWxsLXBvaW50ZXItYXJpdGhtZXRpYyB3YXJuaW5ncw0KDQpPbiBUdWUsIDIwMTktMDctMjMgYXQg
MjA6NDkgKzAwMDAsIE1vb3JlLCBSb2JlcnQgd3JvdGU6DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBR
aWFuIENhaSA8Y2FpQGxjYS5wdz4NCj4gPiA+IC0tLQ0KPiA+ID4gaW5jbHVkZS9hY3BpL2FjdHlw
ZXMuaCB8IDQgKystLQ0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY3R5
cGVzLmggYi9pbmNsdWRlL2FjcGkvYWN0eXBlcy5oIGluZGV4DQo+ID4gPiBhZDY4OTJhMjQwMTUu
LjI1YjRhMzJkYTE3NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgN
Cj4gPiA+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgNCj4gPiA+IEBAIC01MDAsMTMgKzUw
MCwxMyBAQCB0eXBlZGVmIHU2NCBhY3BpX2ludGVnZXI7DQo+ID4gPiANCj4gPiA+ICNkZWZpbmUg
QUNQSV9DQVNUX1BUUih0LCBwKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKCh0ICopIChhY3Bp
X3VpbnRwdHJfdCkgDQo+ID4gPiAocCkpICNkZWZpbmUgQUNQSV9DQVNUX0lORElSRUNUX1BUUih0
LCBwKcKgwqDCoMKgKCh0ICoqKSANCj4gPiA+IChhY3BpX3VpbnRwdHJfdCkgKHApKSAtI2RlZmlu
ZSBBQ1BJX0FERF9QVFIodCwgYSwgYinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiBBQ1BJ
X0NBU1RfUFRSICh0LCAoQUNQSV9DQVNUX1BUUiAodTgsIChhKSkgKyAoYWNwaV9zaXplKShiKSkp
DQo+ID4gPiArI2RlZmluZSBBQ1BJX0FERF9QVFIodCwgYSwgYinCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgQUNQSV9DQVNUX1BUUiAodCwgKGEpICsNCj4gPiA+IChhY3BpX3NpemUpKGIpKQ0KPiANCj4g
V2UgaGF2ZSBzb21lIHF1ZXN0aW9ucyBjb25jZXJuaW5nIHRoaXMgY2hhbmdlLiBJZiAoYSkgaXMg
bm90IGNhc3QgdG8gYSANCj4gdTgsIHRoZSBhZGRpdGlvbiB3aWxsIGJlIGluIHdoYXRldmVyIHVu
aXRzIGFyZSBhcHByb3ByaWF0ZSBmb3IgKGEpIA0KPiBpLmUuLCB0aGUgdHlwZSBvZiAoYSkuIEhv
d2V2ZXIsIHdlIHdhbnQgQUNQSV9BRERfUFRSIChBbmQgDQo+IEFDUElfU1VCX1BUUikgdG8gc2lt
cGx5IHBlcmZvcm0gYSBieXRlIGFkZGl0aW9uIG9yIHN1YnRyYWN0aW9uIC0gdGh1cyANCj4gdGhl
IGNhc3QgdG8gdTguIEkgYmVsaWV2ZSB0aGF0IGlzIHRoZSBvcmlnaW5hbCB0aGlua2luZyBiZWhp
bmQgdGhlIG1hY3Jvcy4NCg0KSSBwb3N0ZWQgYSB2MiBhIHdoaWxlIGFnbywgYW5kIHNob3VsZCBj
bGVhciB0aGlzIGNvbmNlcm4uDQoNCk9LIHRoZW4gdGhpcyBjaGFuZ2Ugb25seSBhZmZlY3RzIEFD
UElfVE9fUE9JTlRFUj8NCg0KKyNkZWZpbmUgQUNQSV9UT19QT0lOVEVSKGkpICAgICAgICAgICAg
ICBBQ1BJX0NBU1RfUFRSICh2b2lkLCBpKQ0KDQoNCj4gDQo+ID4gPiAjZGVmaW5lIEFDUElfU1VC
X1BUUih0LCBhLCBiKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0NBU1RfUFRSICh0LCANCj4g
PiA+IChBQ1BJX0NBU1RfUFRSICh1OCwgKGEpKSAtIChhY3BpX3NpemUpKGIpKSkgI2RlZmluZSAN
Cj4gPiA+IEFDUElfUFRSX0RJRkYoYSwgYinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCgoYWNw
aV9zaXplKSAoQUNQSV9DQVNUX1BUUiAodTgsDQo+ID4gPiAoYSkpIC0gQUNQSV9DQVNUX1BUUiAo
dTgsIChiKSkpKQ0KPiA+ID4gDQo+ID4gPiAvKiBQb2ludGVyL0ludGVnZXIgdHlwZSBjb252ZXJz
aW9ucyAqLw0KPiA+ID4gDQo+ID4gPiAtI2RlZmluZSBBQ1BJX1RPX1BPSU5URVIoaSnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9BRERfUFRSICh2b2lkLCAodm9pZCANCj4gPiA+ICop
IDAsDQo+ID4gPiAoYWNwaV9zaXplKSAoaSkpDQo+ID4gPiArI2RlZmluZSBBQ1BJX1RPX1BPSU5U
RVIoaSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQUNQSV9BRERfUFRSICh2b2lkLCAwLA0K
PiA+ID4gKGFjcGlfc2l6ZSkgKGkpKQ0KPiA+IA0KPiA+IElJVUMsIHRoZXNlIGFyZSBhZGRpbmcg
YGlgIHRvIE5VTEwgKG9yICh2b2lkKikwKT8gWCArIDAgPT0gWCA/DQo+ID4gLS0NCj4gPiBUaGFu
a3MsDQo+ID4gfk5pY2sgRGVzYXVsbmllcnMNCj4gDQo+IA0K
