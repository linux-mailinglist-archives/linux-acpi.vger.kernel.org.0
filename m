Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94B816AA2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEGSqs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 14:46:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:23077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfEGSqs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 May 2019 14:46:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 11:46:47 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2019 11:46:47 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.28]) with mapi id 14.03.0415.000;
 Tue, 7 May 2019 11:46:46 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Gabriel C <nix.or.die@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG
 being set
Thread-Topic: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG
 being set
Thread-Index: AQHVBGRFH2iPoaZGrUKM6INtXuK3nKZfsfkAgAAIwICAABFWAIAAEDuAgAAkt+A=
Date:   Tue, 7 May 2019 18:46:46 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5A9EBD@ORSMSX122.amr.corp.intel.com>
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
 <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
 <CAJZ5v0ghNMPMdc03T-is-=-k11rZ8K5O9Av+TnbBY_2mNr-eug@mail.gmail.com>
 <CAEJqkgiB7woieNZ-vVm7x-GzVrqGpJWLXOM9JpSUgPgE7eA6gA@mail.gmail.com>
In-Reply-To: <CAEJqkgiB7woieNZ-vVm7x-GzVrqGpJWLXOM9JpSUgPgE7eA6gA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzEzZjYwZTgtYjExMi00OTZkLWJhNDItN2MyYWZkNjU0Nzc1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUDVlM2VkZDVURjlmaGY3OFA1ZFcwNXdIckZGbWdiZk1IQ2l3RVZibmxVQVwvWHI2V1wvMTc2aEJReGxISUFYYXplIn0=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2FicmllbCBDIFttYWls
dG86bml4Lm9yLmRpZUBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA3LCAyMDE5IDI6
MzMgQU0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gQ2M6
IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTEtN
TCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTY2htYXVzcywgRXJpayA8ZXJp
ay5zY2htYXVzc0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbS2VybmVsIDUuMV0gQUNQSV9E
RUJVRyBtZXNzYWdlcyB3aXRob3V0DQo+IENPTkZJR19BQ1BJX0RFQlVHIGJlaW5nIHNldA0KPiAN
Cj4gQW0gRGkuLCA3LiBNYWkgMjAxOSB1bSAxMDozNSBVaHIgc2NocmllYiBSYWZhZWwgSi4gV3lz
b2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+Og0KPiA+DQo+ID4gT24gVHVlLCBNYXkgNywgMjAx
OSBhdCA5OjMxIEFNIEdhYnJpZWwgQyA8bml4Lm9yLmRpZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IEFtIERpLiwgNy4gTWFpIDIwMTkgdW0gMDk6MDEgVWhyIHNjaHJpZWIgUmFmYWVs
IEouIFd5c29ja2kNCj4gPHJhZmFlbEBrZXJuZWwub3JnPjoNCj4gPiA+ID4NCj4gPiA+ICBIZWxs
byBSYWZhZWwgLCAgRXJpaw0KPiA+ID4NCj4gPiA+ID4gK0VyaWsNCj4gPiA+ID4NCj4gPiA+ID4g
T24gVHVlLCBNYXkgNywgMjAxOSBhdCAxOjMzIEFNIEdhYnJpZWwgQyA8bml4Lm9yLmRpZUBnbWFp
bC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiB3aGlsZSB0ZXN0aW5nIGtlcm5lbC01LjEgSSBnZXQgb24gb25lIG9mIG15IExl
bm92byBMYXB0b3BzIHZlcnkNCj4gPiA+ID4gPiBzdHJhbmdlICdBQ1BJIERlYnVnOicgbWVzc2Fn
ZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBZnRlciBzb21lIGdyZXBwaW5nIEkgcmVhbGl6ZWQg
dGhlc2UgYXJlIERlYnVnIG1lc3NhZ2VzIGZyb20NCj4gPiA+ID4gPiBEU0RUICwgaG93ZXZlciBt
eSBrZXJuZWwgZG9lcyBub3QgaGF2ZSBBQ1BJX0RFQlVHIGVuYWJsZWQuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJIGZvdW5kIG91dCB0aGUgbW9kdWxlIHRyaWdnZXJpbmcgdGhpcywgb24gdGhpcyBM
YXB0b3AgaXMNCj4gPiA+ID4gPiBpZGVhcGFkX2xhcHRvcCAsIGJ1dCBsb29raW5nIGF0IHRoZSBj
b2RlIEkgY2Fubm90IHNlZSB3aGF0IHdvdWxkDQo+ID4gPiA+ID4gY2F1c2VzIHRoYXQuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBBbHNvIG9uIHRoZSBzYW1lIExhcHRvcCB3aXRoIGFueSA1LjAuWCBr
ZXJuZWxzIEkgY2Fubm90IHNlZSB0aGVzZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gfiQgZ3JlcCAtaSBBQ1BJX0RFQlVHIC9ib290L2NvbmZpZy01LjEtZncxICMNCj4gPiA+ID4g
PiBDT05GSUdfQUNQSV9ERUJVR0dFUiBpcyBub3Qgc2V0ICMgQ09ORklHX0FDUElfREVCVUcgaXMg
bm90DQo+IHNldCAjDQo+ID4gPiA+ID4gQ09ORklHX1RISU5LUEFEX0FDUElfREVCVUdGQUNJTElU
SUVTIGlzIG5vdCBzZXQgIw0KPiA+ID4gPiA+IENPTkZJR19USElOS1BBRF9BQ1BJX0RFQlVHIGlz
IG5vdCBzZXQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC4uIGRtZXNnIC4uDQo+ID4gPiA+ID4gLi4u
DQo+ID4gPiA+ID4gWyAgIDY4LjAyMDgxMl0gY2FsbGluZyAgaWRlYXBhZF9hY3BpX2RyaXZlcl9p
bml0KzB4MC8weDEwMDANCj4gPiA+ID4gPiBbaWRlYXBhZF9sYXB0b3BdIEAgMTMyMg0KPiA+ID4g
PiA+IFsgICA2OC4wMjY3MDhdIGlucHV0OiBJZGVhcGFkIGV4dHJhIGJ1dHRvbnMgYXMNCj4gPiA+
ID4gPg0KPiAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMC9QTlAwQzA5OjAwL1ZQQzIw
MDQ6MDAvaW5wdXQvaW5wdXQxNg0KPiA+ID4gPiA+IFsgICA2OC4wMzgyMzZdIEFDUEkgRGVidWc6
ICAiPT09PT1RVUVSWV82ND09PT09Ig0KPiA+ID4gPiA+IFsgICA2OC4wNTAyMzJdIEFDUEkgRGVi
dWc6ICAiPT09PT1RVUVSWV82NT09PT09Ig0KPiA+ID4gPiA+IFsgICA2OC4wNjAyMThdIEFDUEkg
RGVidWc6ICAiPT09PT1RVUVSWV82ND09PT09Ig0KPiA+ID4gPiA+IFsgICA2OC4wOTIyMTZdIHBy
b2JlIG9mIFZQQzIwMDQ6MDAgcmV0dXJuZWQgMSBhZnRlciA3MTM4NiB1c2Vjcw0KPiA+ID4gPiA+
IFsgICA2OC4wOTIyNDVdIGluaXRjYWxsIGlkZWFwYWRfYWNwaV9kcml2ZXJfaW5pdCsweDAvMHgx
MDAwDQo+ID4gPiA+ID4gW2lkZWFwYWRfbGFwdG9wXSByZXR1cm5lZCAwIGFmdGVyIDY5NzUxIHVz
ZWNzc2cNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhl
c2UgPT09PT1RVUVSWV9YWD09PT09IG1lc3NhZ2VzIGFyZSBmcm9tIERTRFQ6DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiB+L2FjcGkkIGdyZXAgUVVFUlkgZHNkdC5kc2wNCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICBEZWJ1ZyA9ICI9PT09PVFVRVJZXzExPT09PT0iDQo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgRGVidWcgPSAiPT09PT1RVUVSWV8xMj09PT09Ig0KPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgIERlYnVnID0gIj09PT09UVVFUllfMjQ9PT09PSINCj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICBEZWJ1ZyA9ICI9PT09PVFVRVJZXzI1PT09PT0iDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
RGVidWcgPSAiPT09PT1RVUVSWV8zNz09PT09Ig0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgIERl
YnVnID0gIj09PT09UVVFUllfMzg9PT09PSINCj4gPiA+ID4gPiAgICAgICAgICAgICAgICBEZWJ1
ZyA9ICI9PT09PVFVRVJZXzY0PT09PT0iDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgRGVidWcg
PSAiPT09PT1RVUVSWV82NT09PT09Ig0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbyB0aGlzIGlz
IHRoZSBjb2RlIGZyb20gRFNEVCBmb3IgUVVFUlkgNjQgYW5kIDY1Og0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gLi4uDQo+ID4gPiA+ID4gICAgICAgICAgICAgTWV0aG9kIChfUTY0LCAwLCBOb3RTZXJp
YWxpemVkKSAgLy8gX1F4eDogRUMgUXVlcnkNCj4gPiA+ID4gPiAgICAgICAgICAgIHsNCj4gPiA+
ID4gPiAgICAgICAgICAgICAgICBEZWJ1ZyA9ICI9PT09PVFVRVJZXzY0PT09PT0iDQo+ID4gPiA+
ID4gICAgICAgICAgICAgICAgSWYgKChPU1lTID09IDB4MDdEOSkpDQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgew0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICBJZiAoKChXTEVYID09IE9u
ZSkgJiAoV0xBVCA9PSBPbmUpKSkNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgew0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgU0dPViAoMHgwMjA0MDAwNSwgT25lKQ0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
IEVsc2UNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgew0KPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgU0dPViAoMHgwMjA0MDAwNSwgWmVybykNCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gPiAgICAg
ICAgICAgIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgICAgICAgTWV0aG9kIChfUTY1LCAw
LCBOb3RTZXJpYWxpemVkKSAgLy8gX1F4eDogRUMgUXVlcnkNCj4gPiA+ID4gPiAgICAgICAgICAg
IHsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICBEZWJ1ZyA9ICI9PT09PVFVRVJZXzY1PT09PT0i
DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgSWYgKChPU1lTID09IDB4MDdEOSkpDQo+ID4gPiA+
ID4gICAgICAgICAgICAgICAgew0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICBJZiAoKChC
VEVYID09IE9uZSkgJiAoQlRBVCA9PSBPbmUpKSkNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgew0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgU0dPViAoMHgwMjAyMDAwQiwg
T25lKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgIEVsc2UNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgew0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgU0dPViAoMHgwMjAyMDAwQiwgWmVybykNCj4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgIH0NCj4gPiA+
ID4gPiAgICAgICAgICAgIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBBbnkgaWRlYSB3aGF0IHdvdWxkIGNhdXNlIHRoaXMgPw0KPiA+
ID4NCj4gPiA+IEkgdGhpbmsgSSBmb3VuZCB3aGF0IGlzIGNhdXNpbmcgdGhhdC4NCj4gPiA+DQo+
ID4gPiBDb21taXQgYWE5YWFhNGQ2MWMwMDQ4ZDNmYWFkMDU2ODkzY2Q3ODYwYmJjMDg0YyBpcyBt
b3ZpbmcNCj4gZGVmaW5pdGlvbg0KPiA+ID4gb2YgTGludXgncyAgQUNQSV9ERUJVR19ERUZBVUxU
IHRvIGluY3VkZS9hY3BpL3BsYXRmb3JtL2FjbGludXguaCAsDQo+ID4gPiBob3dldmVyIGluY2x1
ZGUvYWNwaS9hY3BpLmggZGlkbid0IGdvdCB1cGRhdGVkIGFuZA0KPiA+ID4gQUNQSV9ERUJVR19E
RUZBVUxUIG5vdyBiZWluZyBhbHdheXMgZGVmaW5lZCBhcyAgKEFDUElfTFZfSU5JVCB8DQo+ID4g
PiBBQ1BJX0xWX0RFQlVHX09CSkVDVCB8IEFDUElfTFZfRVZBTFVBVElPTiB8IEFDUElfTFZfUkVQ
QUlSKQ0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gYnkgdGhpcy4NCj4gPg0K
PiA+IGluY2x1ZGUvYWNwaS9hY3BpLmggc2hvdWxkIGdldCB0aGUgcmlnaHQgZGVmaW5pdGlvbnMg
dGhyb3VnaA0KPiA+IGluY2x1ZGUvYWNwaS9wbGF0Zm9ybS9hY2Vudi5oIGFuZCBpbmNsdWRlL2Fj
cGkvYWNvdXRwdXQuaCB0aGF0IGFyZQ0KPiA+IGluY2x1ZGVkIGJ5IGl0Lg0KPiA+DQo+IA0KPiBI
bW0geWVzIHNob3VsZCAsIEkgbWlzc2VkIHRoYXQgaW5jbHVkZS4gSG93ZXZlciBpdCBkb2VzIG5v
dCB3b3JrLg0KPiANCj4gSSd2ZSBqdXN0IHB1dCBiYWNrIG9sZCBjb2RlIGJhY2sgaW50byBkcml2
ZXJzL2FjcGkvYnVzLmMgdG8gdGVzdCBhbmQgYWxsIHdvcmtpbmcNCj4gbm93IGZpbmUgd2l0aG91
dCBhbnkgb3RoZXIgY2hhbmdlcy4NCj4gDQo+ID4gSXQgbG9va3MgbGlrZSBpbmN1ZGUvYWNwaS9w
bGF0Zm9ybS9hY2xpbnV4LmggaGFzIG5vdCBiZWVuIGluY2x1ZGVkIGJ5DQo+ID4gaW5jbHVkZS9h
Y3BpL3BsYXRmb3JtL2FjZW52LmggZm9yIHNvbWUgcmVhc29uIHdoZW4gYnVpbGRpbmcgdGhpcw0K
PiA+IG1vZHVsZS4NCj4gDQo+IElmIHRoaXMgb25lIGdldHRpbmcgaXQgd3JvbmcgYWxsIHdpbGwg
ZG8gc28gLCB0aGV5IGFsbCBqdXN0IGluY2x1ZGUgPGxpbnV4L2FjcGkuaD4uDQo+IA0KPiBQcm9i
YWJseSBub3Qgc28gbXVjaCB1c2VycyB3aWxsIG5vdGljZSB0aGF0ICwgSSBqdXN0IGRpZCBiZWNh
dXNlIG15IEJJT1MNCj4gdmVuZG9yIGZvcmdvdCBERUJVRyBhcm91bmQuDQoNCkRvIHlvdSBzdGls
bCBnZXQgdGhpcyBpc3N1ZSBhZnRlciBkb2luZyBtYWtlIGNsZWFuIGFuZCByZWJ1aWxkaW5nIHlv
dXIga2VybmVsPw0K
