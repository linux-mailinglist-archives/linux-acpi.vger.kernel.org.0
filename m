Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B44E5207
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505810AbfJYRIa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 13:08:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:35724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505834AbfJYRIU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 13:08:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 10:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="400170156"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 10:08:15 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 10:08:15 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.32]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.232]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 10:08:15 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 00/12] ACPICA version 20191018
Thread-Topic: [PATCH 00/12] ACPICA version 20191018
Thread-Index: AQHVip8oUZi7VDJ6Nkavjfaj4eVCHadripMAgAANiYA=
Date:   Fri, 25 Oct 2019 17:08:14 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6641E5@ORSMSX122.amr.corp.intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
 <CAJZ5v0gqN3yGcLLVntYQgwxVsUhbEZ8L0UJNXOh=xA6nmgTQLA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gqN3yGcLLVntYQgwxVsUhbEZ8L0UJNXOh=xA6nmgTQLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGI0OTA3ZjUtNmZkMS00MDQxLTlhZWMtMGQ0OTE5MTgwNWNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDY3NmdaRW9YaEVcL2xPWjA4THVtOTNhaFNtQklQcCttRFZ6eE9NbUprVUU2T25lM1hyRVpUUEw5cTZZZDE3UHkifQ==
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
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjUsIDIwMTkg
MjoxOSBBTQ0KPiBUbzogU2NobWF1c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPg0K
PiBDYzogUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEFDUEkgRGV2ZWwg
TWFsaW5nIExpc3QgPGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwMC8xMl0gQUNQSUNBIHZlcnNpb24gMjAxOTEwMTgNCj4gDQo+IE9uIFRodSwg
T2N0IDI0LCAyMDE5IGF0IDk6MTMgUE0gRXJpayBTY2htYXVzcyA8ZXJpay5zY2htYXVzc0BpbnRl
bC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBjb250YWlucyB0aGUgbGlu
dXhpemVkIHBhdGNoZXMgZm9yIEFDUElDQSB2ZXJzaW9uDQo+ID4gMjAxOTEwMTguIFRoZXJlIGFy
ZSBzZXZlcmFsIGRlYnVnZ2VyIGNoYW5nZXMgYnV0IHRoZXkgYXJlIG1lYW50IGZvcg0KPiA+IGFj
cGlleGVjIGF0IHRoaXMgdGltZS4gYWNwaV9sb2FkX3RhYmxlIGRlZmluaXRpb24gaGFzIGJlZW4g
bW9kaWZpZWQNCj4gPiBhbmQgYSBuZXcgYWNwaV91bmxvYWRfdGFibGUgaGFzIGJlZW4gYWRkZWQu
IFRoZXNlIG5ldyBpbnRlcmZhY2VzIGNhbg0KPiA+IGJlIHVzZWQgYXMgYSBwYXJ0IG9mIGNvbmZp
ZyBmcyB0byBsb2FkIGFuZCB1bmxvYWQgdGFibGVzLg0KPiA+DQo+ID4gT3RoZXIgdGhhbiB0aGF0
LCBCb2IgaGFzIHJ1biBjbGFuZyBvbiBvdXIgY29kZSBiYXNlIGFuZCByZW1vdmVkDQo+ID4gc2V2
ZXJhbCBjb21waWxlciB3YXJuaW5ncy4NCj4gPg0KPiA+IFRoaXMgcGF0Y2hzZXQgaXMgYWxzbyBh
dmFpbGFibGUgaGVyZToNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vU2NobUVyaWsvbGludXgvdHJl
ZS92MjAxOTEwMTgNCj4gPg0KPiA+IEJvYiBNb29yZSAoNSk6DQo+ID4gICBBQ1BJQ0E6IFJlc3Vs
dHMgZnJvbSBDbGFuZyBjaGFuZ2VzL2ZpeGVzIEZyb20gQ2xhbmcgVjUuMC4xLiBNb3N0bHkNCj4g
PiAgICAgInNldCBidXQgbmV2ZXIgcmVhZCIgd2FybmluZ3MuDQo+ID4gICBBQ1BJQ0E6IFdpbiBP
U0w6IFJlcGxhY2UgZ2V0X3RpY2tfY291bnQgd2l0aCBnZXRfdGlja19jb3VudDY0DQo+ID4gICBB
Q1BJQ0E6IE1vcmUgQ2xhbmcgY2hhbmdlcyAtIFY4LjAuMSBGaXhlZCBhbGwgImRlYWQgYXNzaWdu
bWVudCINCj4gPiAgICAgd2FybmluZ3MuDQo+ID4gICBBQ1BJQ0E6IEFkZCBuZXcgZXh0ZXJuYWwg
aW50ZXJmYWNlLCBhY3BpX3VubG9hZF90YWJsZQ0KPiA+ICAgQUNQSUNBOiBVcGRhdGUgdmVyc2lv
biB0byAyMDE5MTAxOA0KPiA+DQo+ID4gRXJpayBTY2htYXVzcyAoNik6DQo+ID4gICBBQ1BJQ0E6
IHV0aWxpdGllczogYWRkIGZsYWcgdG8gb25seSBkaXNwbGF5IGRhdGEgd2hlbiBkdW1waW5nIGJ1
ZmZlcnMNCj4gPiAgIEFDUElDQTogRGVidWdnZXI6IGFkZCBjb21tYW5kIHRvIGR1bXAgYWxsIGZp
ZWxkcyBvZiBhIHBhcnRpY3VsYXINCj4gPiAgICAgc3VidHlwZQ0KPiA+ICAgQUNQSUNBOiBkZWJ1
Z2dlcjogc3Vycm91bmQgZmllbGQgdW5pdCBvdXRwdXQgd2l0aCBicmFjZXMgJ3snDQo+ID4gICBB
Q1BJQ0E6IGRlYnVnZ2VyOiBhZGQgZmllbGQgdW5pdCBzdXBwb3J0IGZvciBhY3BpX2RiX2dldF9u
ZXh0X3Rva2VuDQo+ID4gICBBQ1BJQ0E6IGFjcGlleGVjOiBpbml0aWFsaXplIGFsbCBzaW1wbGUg
dHlwZXMgYW5kIGZpZWxkIHVuaXRzIGZyb20NCj4gPiAgICAgdXNlciBpbnB1dA0KPiA+ICAgQUNQ
SUNBOiBkZWJ1Z2dlcjogcmVtb3ZlIGxlYWRpbmcgd2hpdGVzcGFjZXMgd2hlbiBjb252ZXJ0aW5n
IGEgc3RyaW5nDQo+ID4gICAgIHRvIGEgYnVmZmVyDQo+ID4NCj4gPiBOaWtvbGF1cyBWb3NzICgx
KToNCj4gPiAgIEFDUElDQTogbWFrZSBhY3BpX2xvYWRfdGFibGUoKSByZXR1cm4gdGFibGUgaW5k
ZXgNCj4gDQo+IFF1ZXVpbmcgdXAgYXMgNS41IG1hdGVyaWFsIHdpdGggc29tZSBtaW5vciBzdWJq
ZWN0L2NoYW5nZWxvZyBtb2RpZmljYXRpb25zLg0KW1NjaG1hdXNzLCBFcmlrXQ0KDQpTb3JyeSBh
Ym91dCB0aGUgYnVpbGQgZXJyb3JzLi4uSSdsbCBzZW5kIGEgdjIgdG9kYXkuDQo+IA0KPiBUaGFu
a3MhDQo=
