Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE2BFA35
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfIZTlk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 15:41:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:6984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbfIZTlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Sep 2019 15:41:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 12:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="273576520"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2019 12:41:37 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 12:41:37 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.236]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.70]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 12:41:37 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Nikolaus Voss <nv@vosn.de>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Topic: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Index: AQHVaUE6PwWyj3qAlUyiJ16YhgOwE6c+NeMQgAB9wgD//42XEIAAlnqAgAALqgD//41KEA==
Date:   Thu, 26 Sep 2019 19:41:36 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6492CB@ORSMSX122.amr.corp.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com>
 <20190926163528.GH32742@smile.fi.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
 <alpine.DEB.2.20.1909262043380.13592@fox.voss.local>
 <CAJZ5v0g=onKCidHMLNWuYFCuhcQGmtDDp5QSGiHu1jhoDRuhWQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g=onKCidHMLNWuYFCuhcQGmtDDp5QSGiHu1jhoDRuhWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGM4MzNjMGMtOTQ1Ny00NGJiLWE2M2QtNzYwZWRmMzVhNmQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieitrM0hWejN6XC9MNWF4OGkwUjFFTWFkcHMyUTQ3dzFzUXEwRnpoS1J0MXhTVXlHUXczUk82S0lnTjcrN2FmNmEifQ==
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI2LCAy
MDE5IDEyOjI2IFBNDQo+IFRvOiBOaWtvbGF1cyBWb3NzIDxudkB2b3NuLmRlPg0KPiBDYzogU2No
bWF1c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPjsgU2hldmNoZW5rbywgQW5kcml5
DQo+IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3
QHJqd3lzb2NraS5uZXQ+Ow0KPiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29t
PjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+Ow0KPiBKYWNlayBBbmFzemV3c2tpIDxqYWNl
ay5hbmFzemV3c2tpQGdtYWlsLmNvbT47IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAdWN3LmN6Pjsg
RGFuIE11cnBoeSA8ZG11cnBoeUB0aS5jb20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsN
Cj4gZGV2ZWxAYWNwaWNhLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBBQ1BJQ0E6IG1ha2UgYWNwaV9sb2FkX3RhYmxlKCkgcmV0dXJuIHRh
YmxlIGluZGV4DQo+IA0KPiBPbiBUaHUsIFNlcCAyNiwgMjAxOSBhdCA4OjQ0IFBNIE5pa29sYXVz
IFZvc3MgPG52QHZvc24uZGU+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCAyNiBTZXAgMjAxOSwg
U2NobWF1c3MsIEVyaWsgd3JvdGU6DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+PiBGcm9tOiBsaW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiA+ID4+IDxs
aW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVsLm9yZz4NCj4gPiA+PiBPbiBCZWhhbGYgT2YgU2hl
dmNoZW5rbywgQW5kcml5DQo+ID4gPj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAx
OSA5OjM1IEFNDQo+ID4gPj4gVG86IFNjaG1hdXNzLCBFcmlrIDxlcmlrLnNjaG1hdXNzQGludGVs
LmNvbT4NCj4gPiA+PiBDYzogTmlrb2xhdXMgVm9zcyA8bmlrb2xhdXMudm9zc0Bsb2V3ZW5zdGVp
bm1lZGljYWwuZGU+OyBSYWZhZWwgSi4NCj4gPiA+PiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5l
dD47IE1vb3JlLCBSb2JlcnQNCj4gPiA+PiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IExlbiBC
cm93biA8bGVuYkBrZXJuZWwub3JnPjsgSmFjZWsNCj4gPiA+PiBBbmFzemV3c2tpIDxqYWNlay5h
bmFzemV3c2tpQGdtYWlsLmNvbT47IFBhdmVsIE1hY2hlaw0KPiA+ID4+IDxwYXZlbEB1Y3cuY3o+
OyBEYW4gTXVycGh5IDxkbXVycGh5QHRpLmNvbT47IGxpbnV4LQ0KPiA+ID4+IGFjcGlAdmdlci5r
ZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOw0KPiA+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IG52QHZvc24uZGUNCj4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJQ0E6
IG1ha2UgYWNwaV9sb2FkX3RhYmxlKCkgcmV0dXJuIHRhYmxlDQo+ID4gPj4gaW5kZXgNCj4gPiA+
Pg0KPiA+ID4+IE9uIFRodSwgU2VwIDI2LCAyMDE5IGF0IDA3OjA5OjA1UE0gKzAzMDAsIFNjaG1h
dXNzLCBFcmlrIHdyb3RlOg0KPiA+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+Pj4+IEZyb206IE5pa29sYXVzIFZvc3MgPG5pa29sYXVzLnZvc3NAbG9ld2Vuc3RlaW5tZWRp
Y2FsLmRlPg0KPiA+ID4+Pj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMiwgMjAxOSAxOjA4
IEFNDQo+ID4gPj4+PiBUbzogU2hldmNoZW5rbywgQW5kcml5IDxhbmRyaXkuc2hldmNoZW5rb0Bp
bnRlbC5jb20+OyBTY2htYXVzcywNCj4gPiA+Pj4+IEVyaWsgPGVyaWsuc2NobWF1c3NAaW50ZWwu
Y29tPjsgUmFmYWVsIEouIFd5c29ja2kNCj4gPiA+Pj4+IDxyandAcmp3eXNvY2tpLm5ldD47IE1v
b3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+ID4gPj4+PiBDYzogTGVuIEJy
b3duIDxsZW5iQGtlcm5lbC5vcmc+OyBKYWNlayBBbmFzemV3c2tpDQo+ID4gPj4+PiA8amFjZWsu
YW5hc3pld3NraUBnbWFpbC5jb20+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQHVjdy5jej47IERhbg0K
PiA+ID4+Pj4gTXVycGh5IDxkbXVycGh5QHRpLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnOw0KPiA+ID4+Pj4gZGV2ZWxAYWNwaWNhLm9yZzsgbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IG52QHZvc24uZGU7DQo+ID4gPj4+PiBOaWtvbGF1cyBWb3NzIDxuaWtvbGF1cy52b3Nz
QGxvZXdlbnN0ZWlubWVkaWNhbC5kZT4NCj4gPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSF0gQUNQSUNB
OiBtYWtlIGFjcGlfbG9hZF90YWJsZSgpIHJldHVybiB0YWJsZQ0KPiA+ID4+Pj4gaW5kZXgNCj4g
PiA+Pj4+DQo+ID4gPj4+IEhpIE5pa29sYXVzLA0KPiA+ID4+Pg0KPiA+ID4+Pj4gRm9yIHVubG9h
ZGluZyBhbiBBQ1BJIHRhYmxlLCBpdCBpcyBuZWNlc3NhcnkgdG8gcHJvdmlkZSB0aGUgaW5kZXgg
b2YgdGhlDQo+IHRhYmxlLg0KPiA+ID4+Pj4gVGhlIG1ldGhvZCBpbnRlbmRlZCBmb3IgZHluYW1p
Y2FsbHkgbG9hZGluZyBvciBob3RwbHVnIGFkZGl0aW9uDQo+ID4gPj4+PiBvZiB0YWJsZXMsIGFj
cGlfbG9hZF90YWJsZSgpLCBzaG91bGQgcHJvdmlkZSB0aGlzIGluZm9ybWF0aW9uIHZpYQ0KPiA+
ID4+Pj4gYW4gb3B0aW9uYWwgcG9pbnRlciB0byB0aGUgbG9hZGVkIHRhYmxlIGluZGV4Lg0KPiA+
ID4+Pg0KPiA+ID4+PiBXZSdsbCB0YWtlIHRoaXMgcGF0Y2ggZm9yIEFDUElDQSB1cHN0cmVhbQ0K
PiA+ID4+DQo+ID4gPj4gRXJpaywNCj4gPiA+Pg0KPiA+ID4gSGkgQW5keSwNCj4gPiA+DQo+ID4g
Pj4gaG93IGFib3V0IHRvIGhhdmUgYWxzbyBjb3VudGVycGFydCB0byBhY3BpX2xvYWRfdGFibGUo
KSB3aGljaCB3aWxsDQo+ID4gPj4gZG8gd2hhdCBpdCdzIGRvbmUgbm93IGluIGFjcGlfY29uZmln
ZnMuYyB2aWEgYWNwaV90Yl8qKCkgQVBJPw0KPiA+ID4NCj4gPiA+IEkgc2hvdWxkIGhhdmUgZ2l2
ZW4gbW9yZSBkZXRhaWxzLiBXZSBkZWNpZGVkIHRvIGFkZCB0aGlzIGV4dHJhDQo+ID4gPiBwYXJh
bWV0ZXIgaW4gQWNwaUxvYWRUYWJsZSBhbmQgd2UncmUgZ29pbmcgdG8gY3JlYXRlIGFuDQo+ID4g
PiBBY3BpVW5sb2FkVGFibGUgZnVuY3Rpb24gdGhhdCB3aWxsIHRha2UgdGFibGUgaW5kZXggdG8g
dW5sb2FkIHRoZQ0KPiA+ID4gdGFibGUgKGJhc2ljYWxseSB0aGUgYWNwaV90Yl91bmxvYWQuLiku
IE9uY2Ugd2UgZG8gdGhpcywgeW91IGNhbiB1c2UNCj4gPiA+IHRhYmxlIGluZGljZXMgd2l0aCBB
Y3BpVW5sb2FkVGFibGUgYW5kIEFjcGlMb2FkVGFibGUuDQo+ID4NCj4gPiB0aGF0J3MgZXZlbiBi
ZXR0ZXIgbmV3cy4NCj4gPg0KPiA+IFJhZmFlbCwgc2hhbGwgSSBwcmVwYXJlIGFueXRoaW5nPw0K
SGkgZXZlcnlvbmUsDQoNCj4gSSBkb24ndCB0aGluayBzby4gIEknbSBleHBlY3RpbmcgdG8gZ2V0
IGEgcHJvcGVyIGZpeCBmcm9tIHRoZSB1cHN0cmVhbSB0aHJvdWdoDQo+IHRoZSBub3JtYWwgcHJv
Y2Vzcy4NCkp1c3Qgc28gdGhhdCB3ZSBhcmUgb24gdGhlIHNhbWUgcGFnZToNCg0KSSd2ZSBiYWNr
cG9ydGVkIE5pa29sYXVzJ3MgcGF0Y2ggZm9yIHVwc3RyZWFtIGhlcmUgaHR0cHM6Ly9naXRodWIu
Y29tL2FjcGljYS9hY3BpY2EvcHVsbC81MDYNCmFuZCBCb2IgaGFzIGltcGxlbWVudGVkIHRoZSBu
ZXcgQVBJIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL2NvbW1pdC9jNjkz
NjljZDljZjAxMzRlMWFhYzUxNmU5N2Q2MTI5NDdkYWE4ZGMyDQoNCk9uY2Ugd2UgZG8gYSByZWxl
YXNlLCBJIHdpbGwgc2VuZCBCb2IncyBjaGFuZ2UgdG8gdGhlIGxpbnV4IEFDUEkgbWFpbGluZyBs
aXN0Lg0KRmVlbCBmcmVlIHRvIHVzZSB0aGlzIG5ldyBBUEkgd2hlcmUgeW91IHNlZSBmaXQuDQoN
ClRoYW5rcywNCkVyaWsNCg0KPiANCj4gVGhhbmtzLA0KPiBSYWZhZWwNCg==
