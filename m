Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC59C16E99B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgBYPJD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 10:09:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:50480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbgBYPJD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 10:09:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 07:09:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="438092275"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2020 07:09:02 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 07:09:02 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0439.000;
 Tue, 25 Feb 2020 07:09:02 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: Linux hangs at ACPI init on Medion P15648 MD63490
Thread-Topic: Linux hangs at ACPI init on Medion P15648 MD63490
Thread-Index: AQHV5dA2EWI8nKIQbUyz8qOOeLk+uqgsD1Tg
Date:   Tue, 25 Feb 2020 15:09:01 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96EA886@ORSMSX110.amr.corp.intel.com>
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
 <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com>
 <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr>
 <CAJZ5v0jOOi0SjZ+SUv8L8f6z2uxu40Q7AP_q9XKVEOePxwBHfg@mail.gmail.com>
 <nycvar.YFH.7.76.2002170109040.8537@n3.vanv.qr>
 <CAJZ5v0g+xnQb7t_d5dqMaPUDhSXiGVNri+kc75Tj5fjCgith3A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+xnQb7t_d5dqMaPUDhSXiGVNri+kc75Tj5fjCgith3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODY4ZmFiNmYtMDMwOS00Yzg4LWEzMWUtNGZjNmNkMWMwZDdkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0wzVkI0K1U0TmlGOVpwSnF4K2kyOE1ybU1Ianpqb0psXC9xMkRENFROdFZlUWU4aEk5dnoxRHVER1BKcVFCVHgifQ==
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+IA0KU2VudDogTW9uZGF5LCBGZWJydWFyeSAxNywgMjAyMCAxMjoy
NCBQTQ0KVG86IEphbiBFbmdlbGhhcmR0IDxqZW5nZWxoQGluYWkuZGU+OyBLYW5lZGEsIEVyaWsg
PGVyaWsua2FuZWRhQGludGVsLmNvbT47IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRl
bC5jb20+DQpDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgQUNQSSBE
ZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+DQpTdWJqZWN0OiBS
ZTogTGludXggaGFuZ3MgYXQgQUNQSSBpbml0IG9uIE1lZGlvbiBQMTU2NDggTUQ2MzQ5MA0KDQpP
biBNb24sIEZlYiAxNywgMjAyMCBhdCAxOjEwIEFNIEphbiBFbmdlbGhhcmR0IDxqZW5nZWxoQGlu
YWkuZGU+IHdyb3RlOg0KPg0KPg0KPiBPbiBTdW5kYXkgMjAyMC0wMi0xNiAyMTo0OSwgUmFmYWVs
IEouIFd5c29ja2kgd3JvdGU6DQo+DQo+ID4+IEkgdGh1cyB3ZW50IGJhY2sgdG8gNS42LXJjIGFu
ZCBlbmFibGVkIGZ1bGwgQUNQSSB0cmFjaW5nDQo+ID4+IChsYXllcj0weGZmZmZmZmZmL2xldmVs
PTB4ZmZmZmZmZmYpIHN0YXJ0aW5nIGZyb20NCj4gPj4NCj4gPj4gbnNpbml0LmM6MjEzICAgIC8q
IFdhbGsgbmFtZXNwYWNlIHRvIGV4ZWN1dGUgYWxsIF9JTklzIG9uIHByZXNlbnQgZGV2aWNlcyAq
Lw0KPiA+Pg0KPiA+PiBvbndhcmRzLiBUaGF0IGxvZyBvdXRwdXQgaXMgYXQgaHR0cDovL2luYWku
ZGUvZmlsZXMvbTkyMy5tcDQgWzUzTUJdLg0KPiA+DQo+ID5JZiB0aGF0IGlzIHRoZSBjYXNlLCB0
aGVuIEFGQUlDUyB0aGUgaXNzdWUgbWF5IG5vdCBiZSBkaXJlY3RseSANCj4gPnJlbGF0ZWQgdG8g
dGhlIEVDIGF0IGFsbC4gIFRoaXMgb3V0cHV0IG9ubHkgbWVhbnMgdGhhdCB0aGUgc3lzdGVtIGhh
cyANCj4gPmFuIEVDRFQsIGJ1dCB0aGF0IHNob3VsZCBub3QgYmUgYSBwcm9ibGVtIGJ5IGl0c2Vs
Zi4NCj4gPg0KPiA+VGhlIHN5c3RlbSBhcHBlYXJzIHRvIGhhbmcgc29tZXdoZXJlIGluIGFjcGlf
bnNfaW5pdGlhbGl6ZV9kZXZpY2VzKCkgDQo+ID5hbmQgaXQgaXMgaGFyZCB0byBzYXkgd2hlcmUg
ZXhhY3RseS4NCj4NCj4gSSBoYWQgYW4gZXhhY3Qgc3RhY2sgdHJhY2UuIChTdGFzaGVkIGluIGFs
bCB0aG9zZSB2aWRlb3MgLSBub3cgDQo+IGV4dHJhY3RlZCBhbmQgcG9zdGVkIHRvIHRoZSBidWcp
DQo+DQo+ID5JIHdvdWxkIHN1Z2dlc3QgY3JlYXRpbmcgYSBCWiBlbnRyeSBhdCBidWd6aWxsYS5r
ZXJuZWwub3JnIGZvciB0aGlzIA0KPiA+aXNzdWUgYW5kIGF0dGFjaGluZyB0aGUgb3V0cHV0IG9m
IGFjcGlkdW1wIGZyb20gdGhlIGFmZmVjdGVkIHN5c3RlbSANCj4gPmluIHRoZXJlLg0KPg0KPiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNjU1Mw0KDQpFcmlr
LCBCb2IsIGNhbiB5b3UgcGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoaXMgQlo/ICBJdCBsb29rcyBs
aWtlIHRoZXJlIGlzIGEgZGVhZGxvY2sgb24gdGhlIGdsb2JhbCBsb2NrIHdoaWxlIHByb2Nlc3Np
bmcgc29tZSBBTUwgZHVyaW5nDQphY3BpX25zX2luaXRpYWxpemVfZGV2aWNlcygpIGV4ZWN1dGlv
bi4NCg0KWWVzLCB3ZSBhcmUgbG9va2luZyBhdCB0aGlzLg0KQm9iDQoNCg==
