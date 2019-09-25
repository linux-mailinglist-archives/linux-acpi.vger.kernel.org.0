Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA3BE465
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2019 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407008AbfIYSNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Sep 2019 14:13:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:18412 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404847AbfIYSNh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Sep 2019 14:13:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 11:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="364404539"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2019 11:13:35 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 11:13:35 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.236]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.226]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 11:13:34 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Moore, Robert" <robert.moore@intel.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ferry Toth <fntoth@gmail.com>
CC:     Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nv@vosn.de" <nv@vosn.de>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Topic: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Index: AQHVaUE6PwWyj3qAlUyiJ16YhgOwE6cojRAAgABYowCAE+EegA==
Date:   Wed, 25 Sep 2019 18:13:34 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C646E97@ORSMSX122.amr.corp.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <4929b1d2-c2a7-4efd-89e4-f02205e79c01@telfort.nl>
In-Reply-To: <4929b1d2-c2a7-4efd-89e4-f02205e79c01@telfort.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWU1OGVmOGItZjZjYi00MzM1LTlkYjQtMzg5ZGQ5MWZlNzAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibGF4NVNjVkF5aXgrZ2cyblwvZmt1eU5DY01YOHNtTFVQaDNuWUtMc01Bc0ExS2VDVTIzanR5XC95KzZCbnVJY2ZIIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVycnkgVG90aCA8ZnRv
dGhAdGVsZm9ydC5ubD4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMiwgMjAxOSAxMjoz
NyBQTQ0KPiBUbzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IE5pa29s
YXVzIFZvc3MNCj4gPG5pa29sYXVzLnZvc3NAbG9ld2Vuc3RlaW5tZWRpY2FsLmRlPjsgU2hldmNo
ZW5rbywgQW5kcml5DQo+IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBTY2htYXVzcywg
RXJpayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+Ow0KPiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3
QHJqd3lzb2NraS5uZXQ+DQo+IENjOiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEphY2Vr
IEFuYXN6ZXdza2kNCj4gPGphY2VrLmFuYXN6ZXdza2lAZ21haWwuY29tPjsgUGF2ZWwgTWFjaGVr
IDxwYXZlbEB1Y3cuY3o+OyBEYW4gTXVycGh5DQo+IDxkbXVycGh5QHRpLmNvbT47IGxpbnV4LWFj
cGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbnZAdm9zbi5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJQ0E6
IG1ha2UgYWNwaV9sb2FkX3RhYmxlKCkgcmV0dXJuIHRhYmxlIGluZGV4DQo+IA0KPiBPcCAxMi0w
OS0xOSBvbSAxNjoxOSBzY2hyZWVmIE1vb3JlLCBSb2JlcnQ6DQo+ID4gTmlrb2xhdXMsDQo+ID4g
VGhlIGFiaWxpdHkgdG8gdW5sb2FkIGFuIEFDUEkgdGFibGUgKGVzcGVjaWFsbHkgQU1MIHRhYmxl
cyBzdWNoIGFzIFNTRFRzKSBpcyBpbg0KPiB0aGUgcHJvY2VzcyBvZiBiZWluZyBkZXByZWNhdGVk
IGluIEFDUElDQSAtLSBzaW5jZSBpdCBpcyBhbHNvIGRlcHJlY2F0ZWQgaW4gdGhlDQo+IGN1cnJl
bnQgQUNQSSBzcGVjaWZpY2F0aW9uLiBUaGlzIGlzIGJlaW5nIGRvbmUgYmVjYXVzZSBvZiB0aGUg
ZGlmZmljdWx0eSBvZg0KPiBkZWxldGluZyB0aGUgbmFtZXNwYWNlIGVudHJpZXMgZm9yIHRoZSB0
YWJsZS4gIEZZSSwgV2luZG93cyBkb2VzIG5vdCBwcm9wZXJseQ0KPiBzdXBwb3J0IHRoaXMgZnVu
Y3Rpb24gZWl0aGVyLg0KPiANCj4gSSByZWFsbHkgaG9wZSB0aGlzIGlzIG5vdCB0aGUgY2FzZS4g
T24geDg2IGxvYWRpbmcvdW5sb2FkaW5nIFNTRFRzIGhhcyBwcm92ZW4gdG8NCj4gYmUgYSBwb3dl
cmZ1bCB3YXkgdG8gaGFuZGxlIHJlY29uZmlndXJhYmxlIGhhcmR3YXJlIHdpdGhvdXQgcmVib290
aW5nIGFuZA0KPiB3aXRob3V0IHJlcXVpcmluZyBkZWRpY2F0ZWQgcGxhdGZvcm0gZHJpdmVycy4g
U2FtZSBmb3IgdXNlciBwbHVnYWJsZSBoYXJkd2FyZQ0KPiBvbiBpMmMvc3BpIGJ1c3Nlcy4NCj4g
DQo+IFRoaXMgaGFzIHdvcmtlZCBiZWZvcmUgYW5kIHdpbGwgdmlvbGF0ZSB0aGUgImRvbid0IGJy
ZWFrIHVzZXIgc3BhY2UiIHJ1bGUuDQoNCklmIHRoZSB0YWJsZSBpbmRleCB3YXNuJ3QgYmVpbmcg
dXNlZCwgaG93IGRpZCB0aGlzIHdvcmsgYmVmb3JlPw0KV2hpY2ggY29tbWl0IGJyb2tlIHRoaXM/
DQoNCkJvYiBhbmQgSSBhcmUgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgaWYgdGhpcyBpcyBhIHJlZ3Jl
c3Npb24gb3IgYSBuZXcgZmVhdHVyZSByZXF1ZXN0Li4uDQoNClRoYW5rcywNCkVyaWsNCj4gDQo+
IEkgZG9uJ3Qgc2VlIHdoeSBXaW5kb3dzIGlzIGFuIGV4YW1wbGUgdG8gZm9sbG93LiBPbiBXaW5k
b3dzIHBsYXRmb3JtIGRyaXZlcnMNCj4gZG9uJ3QgZ2V0IGNvbXBpbGVkIGludG8gdGhlIGtlcm5l
bCBhbmQgZG9uJ3QgbmVlZCB0byBiZSB1cHN0cmVhbWVkLg0KPiANCj4gPiBCb2INCj4gPg0KPiA+
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBOaWtvbGF1cyBWb3Nz
IFttYWlsdG86bmlrb2xhdXMudm9zc0Bsb2V3ZW5zdGVpbm1lZGljYWwuZGVdDQo+ID4gU2VudDog
VGh1cnNkYXksIFNlcHRlbWJlciAxMiwgMjAxOSAxOjA4IEFNDQo+ID4gVG86IFNoZXZjaGVua28s
IEFuZHJpeSA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgU2NobWF1c3MsIEVyaWsNCj4g
PiA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lz
b2NraS5uZXQ+Ow0KPiA+IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+
ID4gQ2M6IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgSmFjZWsgQW5hc3pld3NraQ0KPiA+
IDxqYWNlay5hbmFzemV3c2tpQGdtYWlsLmNvbT47IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6
PjsgRGFuIE11cnBoeQ0KPiA+IDxkbXVycGh5QHRpLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJu
ZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IG52QHZvc24uZGU7IE5pa29sYXVzIFZvc3MNCj4gPiA8bmlrb2xhdXMudm9zc0Bsb2V3ZW5z
dGVpbm1lZGljYWwuZGU+DQo+ID4gU3ViamVjdDogW1BBVENIXSBBQ1BJQ0E6IG1ha2UgYWNwaV9s
b2FkX3RhYmxlKCkgcmV0dXJuIHRhYmxlIGluZGV4DQo+ID4NCj4gPiBGb3IgdW5sb2FkaW5nIGFu
IEFDUEkgdGFibGUsIGl0IGlzIG5lY2Vzc2FyeSB0byBwcm92aWRlIHRoZSBpbmRleCBvZiB0aGUg
dGFibGUuDQo+IFRoZSBtZXRob2QgaW50ZW5kZWQgZm9yIGR5bmFtaWNhbGx5IGxvYWRpbmcgb3Ig
aG90cGx1ZyBhZGRpdGlvbiBvZiB0YWJsZXMsDQo+IGFjcGlfbG9hZF90YWJsZSgpLCBzaG91bGQg
cHJvdmlkZSB0aGlzIGluZm9ybWF0aW9uIHZpYSBhbiBvcHRpb25hbCBwb2ludGVyIHRvDQo+IHRo
ZSBsb2FkZWQgdGFibGUgaW5kZXguDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSB0YWJs
ZSB1bmxvYWQgZnVuY3Rpb24gb2YgYWNwaV9jb25maWdmcy4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5
OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4g
PiBGaXhlczogZDA2YzQ3ZTNkZDA3ZiAoIkFDUEk6IGNvbmZpZ2ZzOiBSZXNvbHZlIG9iamVjdHMg
b24NCj4gPiBob3N0LWRpcmVjdGVkIHRhYmxlIGxvYWRzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aWtvbGF1cyBWb3NzIDxuaWtvbGF1cy52b3NzQGxvZXdlbnN0ZWlubWVkaWNhbC5kZT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvYWNwaS9hY3BpX2NvbmZpZ2ZzLmMgICB8IDIgKy0NCj4gPiAgIGRy
aXZlcnMvYWNwaS9hY3BpY2EvZGJmaWxlaW8uYyB8IDIgKy0NCj4gPiAgIGRyaXZlcnMvYWNwaS9h
Y3BpY2EvdGJ4ZmxvYWQuYyB8IDggKysrKysrLS0NCj4gPiAgIGRyaXZlcnMvZmlybXdhcmUvZWZp
L2VmaS5jICAgICB8IDIgKy0NCj4gPiAgIGluY2x1ZGUvYWNwaS9hY3BpeGYuaCAgICAgICAgICB8
IDMgKystDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfY29uZmlnZnMu
Yw0KPiA+IGIvZHJpdmVycy9hY3BpL2FjcGlfY29uZmlnZnMuYyBpbmRleCA1N2Q5ZDU3NGQ0ZGRl
Li43N2Y4MTI0MmEyOGU2DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlf
Y29uZmlnZnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpX2NvbmZpZ2ZzLmMNCj4gPiBA
QCAtNTMsNyArNTMsNyBAQCBzdGF0aWMgc3NpemVfdCBhY3BpX3RhYmxlX2FtbF93cml0ZShzdHJ1
Y3QgY29uZmlnX2l0ZW0NCj4gKmNmZywNCj4gPiAgIAlpZiAoIXRhYmxlLT5oZWFkZXIpDQo+ID4g
ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gLQlyZXQgPSBhY3BpX2xvYWRfdGFibGUodGFi
bGUtPmhlYWRlcik7DQo+ID4gKwlyZXQgPSBhY3BpX2xvYWRfdGFibGUodGFibGUtPmhlYWRlciwg
JnRhYmxlLT5pbmRleCk7DQo+ID4gICAJaWYgKHJldCkgew0KPiA+ICAgCQlrZnJlZSh0YWJsZS0+
aGVhZGVyKTsNCj4gPiAgIAkJdGFibGUtPmhlYWRlciA9IE5VTEw7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYWNwaS9hY3BpY2EvZGJmaWxlaW8uYw0KPiA+IGIvZHJpdmVycy9hY3BpL2FjcGlj
YS9kYmZpbGVpby5jIGluZGV4IGM2ZTI1NzM0ZGM1Y2QuLmUxYjZlNTRhOTZhYzENCj4gPiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2RiZmlsZWlvLmMNCj4gPiArKysgYi9k
cml2ZXJzL2FjcGkvYWNwaWNhL2RiZmlsZWlvLmMNCj4gPiBAQCAtOTMsNyArOTMsNyBAQCBhY3Bp
X3N0YXR1cyBhY3BpX2RiX2xvYWRfdGFibGVzKHN0cnVjdA0KPiBhY3BpX25ld190YWJsZV9kZXNj
ICpsaXN0X2hlYWQpDQo+ID4gICAJd2hpbGUgKHRhYmxlX2xpc3RfaGVhZCkgew0KPiA+ICAgCQl0
YWJsZSA9IHRhYmxlX2xpc3RfaGVhZC0+dGFibGU7DQo+ID4NCj4gPiAtCQlzdGF0dXMgPSBhY3Bp
X2xvYWRfdGFibGUodGFibGUpOw0KPiA+ICsJCXN0YXR1cyA9IGFjcGlfbG9hZF90YWJsZSh0YWJs
ZSwgTlVMTCk7DQo+ID4gICAJCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgew0KPiA+ICAgCQkJ
aWYgKHN0YXR1cyA9PSBBRV9BTFJFQURZX0VYSVNUUykgew0KPiA+ICAgCQkJCWFjcGlfb3NfcHJp
bnRmDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJ4ZmxvYWQuYw0KPiA+
IGIvZHJpdmVycy9hY3BpL2FjcGljYS90YnhmbG9hZC5jIGluZGV4IDg2ZjE2OTNmNmQyOWEuLmQw
OGNkOGZmY2JkYjYNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3Ri
eGZsb2FkLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2FkLmMNCj4gPiBA
QCAtMjY4LDcgKzI2OCw4IEBAIEFDUElfRVhQT1JUX1NZTUJPTF9JTklUKGFjcGlfaW5zdGFsbF90
YWJsZSkNCj4gPiAgICAqDQo+ID4gICAgKiBQQVJBTUVURVJTOiAgdGFibGUgICAgICAgICAgICAg
ICAtIFBvaW50ZXIgdG8gYSBidWZmZXIgY29udGFpbmluZyB0aGUgQUNQSQ0KPiA+ICAgICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YWJsZSB0byBiZSBsb2FkZWQuDQo+ID4g
LSAqDQo+ID4gKyAqICAgICAgICAgICAgICB0YWJsZV9pZHggICAgICAgICAgIC0gUG9pbnRlciB0
byBhIHUzMiBmb3Igc3RvcmluZyB0aGUgdGFibGUNCj4gPiArICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbmRleCwgbWlnaHQgYmUgTlVMTA0KPiA+ICAgICogUkVUVVJOOiAg
ICAgIFN0YXR1cw0KPiA+ICAgICoNCj4gPiAgICAqIERFU0NSSVBUSU9OOiBEeW5hbWljYWxseSBs
b2FkIGFuIEFDUEkgdGFibGUgZnJvbSB0aGUgY2FsbGVyJ3MgYnVmZmVyLg0KPiBNdXN0IEBAIC0y
NzgsNyArMjc5LDcgQEAgQUNQSV9FWFBPUlRfU1lNQk9MX0lOSVQoYWNwaV9pbnN0YWxsX3RhYmxl
KQ0KPiA+ICAgICogICAgICAgICAgICAgIHRvIGVuc3VyZSB0aGF0IHRoZSB0YWJsZSBpcyBub3Qg
ZGVsZXRlZCBvciB1bm1hcHBlZC4NCj4gPiAgICAqDQo+ID4NCj4gPg0KPiAqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+
ICoqKg0KPiA+ICoqKioqKioqLyAtYWNwaV9zdGF0dXMgYWNwaV9sb2FkX3RhYmxlKHN0cnVjdCBh
Y3BpX3RhYmxlX2hlYWRlcg0KPiA+ICp0YWJsZSkNCj4gPiArYWNwaV9zdGF0dXMgYWNwaV9sb2Fk
X3RhYmxlKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqdGFibGUsIHUzMg0KPiA+ICsqdGFibGVf
aWR4KQ0KPiA+ICAgew0KPiA+ICAgCWFjcGlfc3RhdHVzIHN0YXR1czsNCj4gPiAgIAl1MzIgdGFi
bGVfaW5kZXg7DQo+ID4gQEAgLTI5Nyw2ICsyOTgsOSBAQCBhY3BpX3N0YXR1cyBhY3BpX2xvYWRf
dGFibGUoc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyDQo+ICp0YWJsZSkNCj4gPiAgIAlzdGF0dXMg
PQ0KPiBhY3BpX3RiX2luc3RhbGxfYW5kX2xvYWRfdGFibGUoQUNQSV9QVFJfVE9fUEhZU0FERFIo
dGFibGUpLA0KPiA+DQo+IAlBQ1BJX1RBQkxFX09SSUdJTl9FWFRFUk5BTF9WSVJUVUFMLA0KPiA+
ICAgCQkJCQkJRkFMU0UsICZ0YWJsZV9pbmRleCk7DQo+ID4gKwlpZiAodGFibGVfaWR4KQ0KPiA+
ICsJCSp0YWJsZV9pZHggPSB0YWJsZV9pbmRleDsNCj4gPiArDQo+ID4gICAJaWYgKEFDUElfU1VD
Q0VTUyhzdGF0dXMpKSB7DQo+ID4NCj4gPiAgIAkJLyogQ29tcGxldGUgdGhlIGluaXRpYWxpemF0
aW9uL3Jlc29sdXRpb24gb2YgbmV3IG9iamVjdHMgKi8gZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVy
cy9maXJtd2FyZS9lZmkvZWZpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYyBpbmRleA0K
PiA+IGFkM2IxZjQ4NjZiMzUuLjk3NzNlNDIxMmJhZWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9maXJtd2FyZS9lZmkvZWZpLmMNCj4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmku
Yw0KPiA+IEBAIC0zMDgsNyArMzA4LDcgQEAgc3RhdGljIF9faW5pdCBpbnQgZWZpdmFyX3NzZHRf
bG9hZCh2b2lkKQ0KPiA+ICAgCQkJZ290byBmcmVlX2RhdGE7DQo+ID4gICAJCX0NCj4gPg0KPiA+
IC0JCXJldCA9IGFjcGlfbG9hZF90YWJsZShkYXRhKTsNCj4gPiArCQlyZXQgPSBhY3BpX2xvYWRf
dGFibGUoZGF0YSwgTlVMTCk7DQo+ID4gICAJCWlmIChyZXQpIHsNCj4gPiAgIAkJCXByX2Vycigi
ZmFpbGVkIHRvIGxvYWQgdGFibGU6ICVkXG4iLCByZXQpOw0KPiA+ICAgCQkJZ290byBmcmVlX2Rh
dGE7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY3BpeGYuaCBiL2luY2x1ZGUvYWNw
aS9hY3BpeGYuaCBpbmRleA0KPiA+IDM4NDVjOGZjYzk0ZTUuLmM5MGJiZGM0MTQ2YTYgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjcGl4Zi5oDQo+ID4gKysrIGIvaW5jbHVkZS9hY3Bp
L2FjcGl4Zi5oDQo+ID4gQEAgLTQ1Miw3ICs0NTIsOCBAQCBBQ1BJX0VYVEVSTkFMX1JFVFVSTl9T
VEFUVVMoYWNwaV9zdGF0dXMNCj4gQUNQSV9JTklUX0ZVTkNUSU9ODQo+ID4gICAJCQkJCSAgICAg
ICB1OCBwaHlzaWNhbCkpDQo+ID4NCj4gPiAgIEFDUElfRVhURVJOQUxfUkVUVVJOX1NUQVRVUyhh
Y3BpX3N0YXR1cw0KPiA+IC0JCQkgICAgYWNwaV9sb2FkX3RhYmxlKHN0cnVjdCBhY3BpX3RhYmxl
X2hlYWRlciAqdGFibGUpKQ0KPiA+ICsJCQkgICAgYWNwaV9sb2FkX3RhYmxlKHN0cnVjdCBhY3Bp
X3RhYmxlX2hlYWRlciAqdGFibGUsDQo+ID4gKwkJCQkJICAgIHUzMiAqdGFibGVfaWR4KSkNCj4g
Pg0KPiA+ICAgQUNQSV9FWFRFUk5BTF9SRVRVUk5fU1RBVFVTKGFjcGlfc3RhdHVzDQo+ID4gICAJ
CQkgICAgYWNwaV91bmxvYWRfcGFyZW50X3RhYmxlKGFjcGlfaGFuZGxlIG9iamVjdCkpDQo+ID4g
LS0NCj4gPiAyLjE3LjENCj4gPg0KPiA+DQoNCg==
