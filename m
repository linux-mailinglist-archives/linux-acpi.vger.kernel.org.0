Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDEB24B3
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfIMRk7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Sep 2019 13:40:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:25626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfIMRk7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Sep 2019 13:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 10:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179746174"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2019 10:40:58 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Sep 2019 10:40:58 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.57]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.180]) with mapi id 14.03.0439.000;
 Fri, 13 Sep 2019 10:40:58 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Ferry Toth <fntoth@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     Nikolaus Voss <nv@vosn.de>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Jacek Anaszewski" <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Dan Murphy" <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Topic: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Index: AQHVaUE6M44QnoJV0UqVXW85SrAmnKcoFnTQgAGaZwD///c2gIAAhhUAgAAa0gD//5ht0A==
Date:   Fri, 13 Sep 2019 17:40:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
 <20190913151228.GT2680@smile.fi.intel.com>
 <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com>
In-Reply-To: <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjI5NGViM2YtYzI3My00OGZmLTk4YWEtY2E5ZjZlOTNkN2E1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoielBsNzBkNFlLTUxHU016cjdTYTIzajhHeWRoQkZiTFBFMmhodWx6cXFYQWdXMm1PcnBXdGgzWFpvVU1vUFZTYSJ9
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGZXJyeSBUb3RoIFttYWlsdG86
Zm50b3RoQGdtYWlsLmNvbV0gDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMywgMjAxOSA5OjQ4
IEFNDQpUbzogU2hldmNoZW5rbywgQW5kcml5IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+
OyBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPg0KQ2M6IE5pa29sYXVzIFZv
c3MgPG52QHZvc24uZGU+OyBTY2htYXVzcywgRXJpayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+
OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJA
a2VybmVsLm9yZz47IEphY2VrIEFuYXN6ZXdza2kgPGphY2VrLmFuYXN6ZXdza2lAZ21haWwuY29t
PjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+OyBEYW4gTXVycGh5IDxkbXVycGh5QHRpLmNv
bT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuaWtvbGF1cy52b3NzQGxvZXdlbnN0ZWlubWVkaWNhbC5k
ZTsgSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIEFDUElDQTogbWFrZSBhY3BpX2xvYWRfdGFibGUoKSByZXR1cm4gdGFibGUgaW5kZXgNCg0K
SGVsbG8gYWxsLA0KDQpTb3JyeSB0byBoYXZlIHNlbnQgb3VyIG1lc3NhZ2Ugd2l0aCBjYW5jZWxs
ZWQgZS1tYWlsIGFkZHJlc3MuIEkgaGF2ZSBjb3JyZWN0IHRoaXMgbm93Lg0KDQpPcCAxMy0wOS0x
OSBvbSAxNzoxMiBzY2hyZWVmIFNoZXZjaGVua28sIEFuZHJpeToNCj4gT24gRnJpLCBTZXAgMTMs
IDIwMTkgYXQgMDU6MjA6MjFQTSArMDMwMCwgTW9vcmUsIFJvYmVydCB3cm90ZToNCj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBOaWtvbGF1cyBWb3NzIFttYWlsdG86bnZA
dm9zbi5kZV0NCj4+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDEzLCAyMDE5IDEyOjQ0IEFNDQo+
PiBUbzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4+IENjOiBTaGV2
Y2hlbmtvLCBBbmRyaXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IFNjaG1hdXNzLCBF
cmlrIA0KPj4gPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJq
d0Byand5c29ja2kubmV0PjsgTGVuIA0KPj4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEphY2Vr
IEFuYXN6ZXdza2kgDQo+PiA8amFjZWsuYW5hc3pld3NraUBnbWFpbC5jb20+OyBQYXZlbCBNYWNo
ZWsgPHBhdmVsQHVjdy5jej47IERhbiBNdXJwaHkgDQo+PiA8ZG11cnBoeUB0aS5jb20+OyBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgDQo+PiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBGZXJyeSBUb3RoIDxmdG90aEB0ZWxmb3J0Lm5sPjsgDQo+PiBu
aWtvbGF1cy52b3NzQGxvZXdlbnN0ZWlubWVkaWNhbC5kZQ0KPj4gU3ViamVjdDogUkU6IFtQQVRD
SF0gQUNQSUNBOiBtYWtlIGFjcGlfbG9hZF90YWJsZSgpIHJldHVybiB0YWJsZSANCj4+IGluZGV4
DQo+Pg0KPj4gQm9iLA0KPj4NCj4+IE9uIFRodSwgMTIgU2VwIDIwMTksIE1vb3JlLCBSb2JlcnQg
d3JvdGU6DQo+Pj4gVGhlIGFiaWxpdHkgdG8gdW5sb2FkIGFuIEFDUEkgdGFibGUgKGVzcGVjaWFs
bHkgQU1MIHRhYmxlcyBzdWNoIGFzDQo+Pj4gU1NEVHMpIGlzIGluIHRoZSBwcm9jZXNzIG9mIGJl
aW5nIGRlcHJlY2F0ZWQgaW4gQUNQSUNBIC0tIHNpbmNlIGl0IA0KPj4+IGlzIGFsc28gZGVwcmVj
YXRlZCBpbiB0aGUgY3VycmVudCBBQ1BJIHNwZWNpZmljYXRpb24uIFRoaXMgaXMgYmVpbmcgDQo+
Pj4gZG9uZSBiZWNhdXNlIG9mIHRoZSBkaWZmaWN1bHR5IG9mIGRlbGV0aW5nIHRoZSBuYW1lc3Bh
Y2UgZW50cmllcyBmb3IgDQo+Pj4gdGhlIHRhYmxlLiAgRllJLCBXaW5kb3dzIGRvZXMgbm90IHBy
b3Blcmx5IHN1cHBvcnQgdGhpcyBmdW5jdGlvbiBlaXRoZXIuDQo+Pg0KPj4gb2ssIEkgc2VlIGl0
IGNhbiBiZSBhIHByb2JsZW0gdG8gdW5sb2FkIGFuIEFNTCB0YWJsZSB3aXRoIGFsbCBpdCdzIA0K
Pj4gY29uc2VxdWVuY2VzIGUuZy4gd2l0aCByZXNwZWN0IHRvIGRyaXZlciB1bnJlZ2lzdGVyaW5n
IGluIHNldHVwcyB3aXRoIA0KPj4gY29tcGxleCBkZXBlbmRlbmNpZXMuIEl0IHdpbGwgb25seSB3
b3JrIHByb3Blcmx5IHVuZGVyIGNlcnRhaW4gDQo+PiBjb25kaXRpb25zDQo+PiAtIG5ldmVydGhl
bGVzcyBhY3BpX3RiX3VubG9hZF90YWJsZSgpIGlzIHN0aWxsIGV4cG9ydGVkIGluIEFDUElDQSBh
bmQgd2Ugc2hvdWxkIGdldCB0aGlzIHdvcmtpbmcgYXMgaXQgd29ya2VkIGJlZm9yZS4NCj4+DQo+
PiBBY3BpVGJVbmxvYWRUYWJsZSBpcyBub3QgZXhwb3J0ZWQsIGl0IGlzIGFuIGludGVybmFsIGlu
dGVyZmFjZSBvbmx5IA0KPj4gLS0gYXMgcmVjb2duaXplZCBieSB0aGUgIkFjcGlUYiIuDQo+IA0K
PiBJbiBMaW51eCBpdCBiZWNhbWUgYSBwYXJ0IG9mIEFCSSB3aGVuIHRoZQ0KPiANCj4gY29tbWl0
IDc3MmJmMWUyODc4ZWNmY2EwZDFmMzMyMDcxYzgzZTAyMWRkOWNmMDENCj4gQXV0aG9yOiBKYW4g
S2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBEYXRlOiAgIEZyaSBKdW4gOSAyMDoz
NjozMSAyMDE3ICswMjAwDQo+IA0KPiAgICAgIEFDUEk6IGNvbmZpZ2ZzOiBVbmxvYWQgU1NEVCBv
biBjb25maWdmcyBlbnRyeSByZW1vdmFsDQo+IA0KPiBhcHBlYXJlZCBpbiB0aGUga2VybmVsLg0K
DQpBbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5zIHF1aXRlIHdlbGwgd2h5IGl0IGlzIGFu
IGltcG9ydGFudCBmZWF0dXJlOg0KDQoiVGhpcyBhbGxvd3MgdG8gY2hhbmdlIFNTRFRzIHdpdGhv
dXQgcmVib290aW5nIHRoZSBzeXN0ZW0uDQpJdCBhbHNvIGFsbG93cyB0byBkZXN0cm95IGRldmlj
ZXMgYWdhaW4gdGhhdCBhIGR5bmFtaWNhbGx5IGxvYWRlZCBTU0RUIGNyZWF0ZWQuDQoNClRoZSBi
aWdnZXN0IHByb2JsZW0gQUZBSUsgaXMgdGhhdCB1bmRlciBsaW51eCwgbWFueSBkcml2ZXJzIGNh
bm5vdCBiZSB1bmxvYWRlZC4gQWxzbywgdGhlcmUgYXJlIG1hbnkgcmFjZSBjb25kaXRpb25zIGFz
IHRoZSBuYW1lc3BhY2UgZW50cmllcyAib3duZWQiIGJ5IGFuIFNTRFQgYmVpbmcgdW5sb2FkZWQg
YXJlIGRlbGV0ZWQgKG91dCBmcm9tIHVuZGVybmVhdGggYSBkcml2ZXIpLg0KDQpUaGlzIGlzIHdp
ZGVseSBzaW1pbGFyIHRvIHRoZSBEVCBvdmVybGF5IGJlaGF2aW9yLiINCg0KPj4gSSdtIG5vdCBz
dXJlIHRoYXQgSSB3YW50IHRvIGNoYW5nZSB0aGUgaW50ZXJmYWNlIHRvIEFjcGlMb2FkVGFibGUg
DQo+PiBqdXN0IGZvciBzb21ldGhpbmcgdGhhdCBpcyBiZWluZyBkZXByZWNhdGVkLiBBbHJlYWR5
LCB3ZSB0aHJvdyBhbiANCj4+IEFDUElfRVhDRVBUSU9OIGlmIHRoZSBVbmxvYWQgb3BlcmF0b3Ig
aXMgZW5jb3VudGVyZWQgaW4gdGhlIEFNTCBieXRlIA0KPj4gc3RyZWFtLiBUaGUgc2FtZSB0aGlu
ZyB3aXRoIEFjcGlVbmxvYWRQYXJlbnRUYWJsZSAtIGl0IGlzIGJlaW5nIGRlcHJlY2F0ZWQuDQo+
Pg0KPj4gICAgICBBQ1BJX0VYQ0VQVElPTiAoKEFFX0lORk8sIEFFX05PVF9JTVBMRU1FTlRFRCwN
Cj4+ICAgICAgICAgICJBTUwgVW5sb2FkIG9wZXJhdG9yIGlzIG5vdCBzdXBwb3J0ZWQiKSk7DQo+
IA0KDQo=
