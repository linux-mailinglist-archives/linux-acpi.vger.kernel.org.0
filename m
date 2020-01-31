Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA08914EC19
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 12:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAaLyV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 06:54:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:48324 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728502AbgAaLyV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jan 2020 06:54:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-5-zpWOsHEVPoSZC0YuGcU7Rg-1;
 Fri, 31 Jan 2020 11:54:14 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 31 Jan 2020 11:54:13 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 31 Jan 2020 11:54:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'artem.bityutskiy@linux.intel.com'" 
        <artem.bityutskiy@linux.intel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
Thread-Topic: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
Thread-Index: AQHV13w6Eg2UWHP5m0aqtl9kDKUdz6gEmmHQgAAIoQCAAAUioA==
Date:   Fri, 31 Jan 2020 11:54:13 +0000
Message-ID: <6cf71f6964c6433abeaf445847c97611@AcuMS.aculab.com>
References: <1720216.0Jr2BLnqKp@kreacher> <16995896.bQtfYxEEOs@kreacher>
         <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
 <28a92577c83276baf355dc8de272a79dc854025a.camel@linux.intel.com>
In-Reply-To: <28a92577c83276baf355dc8de272a79dc854025a.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: zpWOsHEVPoSZC0YuGcU7Rg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

RnJvbTogQXJ0ZW0gQml0eXV0c2tpeSA+DQo+IFNlbnQ6IDMxIEphbnVhcnkgMjAyMCAxMToyNA0K
PiBPbiBGcmksIDIwMjAtMDEtMzEgYXQgMTE6MDcgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToN
Cj4gPiBVbmxlc3MgeW91IGtub3cgZXhhY3RseSB3aGljaCBjcHUgdGFibGUgaXMgYmVpbmcgdXNl
ZCB0aGUNCj4gPiBvbmx5IGNvbnN0cmFpbnQgYSB1c2VyIGNhbiByZXF1ZXN0IGlzIHRoZSBsYXRl
bmN5Lg0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBpbiBhbGwgbXkgdXNlLWNhc2VzIEkgYWx3YXlz
IGtub3cgd2hhdCBpcyB0aGUgQ1BVIEkgYW0gZGVhbGluZyB3aXRoIGFuZA0KPiB3aGF0IGFyZSB0
aGUgQy1zdGF0ZXMuIFNpbXBseSBiZWNhdXNlIGluIG15IHZpZXcgdGhleSBhcmUgYWx3YXlzIENQ
VS0NCj4gZGVwZW5kZW50IGluIHRlcm1zIG9mIHdoYXQgdGhleSBkbyBhbmQgaG93IGFyZSB0aGV5
IG5hbWVkLg0KPiANCj4gV2hhdCB5b3Ugc2F5IHNvdW5kcyB0byBtZSBsaWtlIHlvdSB3b3VsZCB3
YW50IHRvIGRpc2FibGUgc29tZSBDLXN0YXRlcw0KPiB3aXRob3V0IGtub3dpbmcgYW55dGhpbmcg
KG9yIG11Y2gpIGFib3V0IHRoZSBDUFUgeW91IGFyZSBkZWFsaW5nIHdpdGgNCj4gYW5kIHRoZSBD
LXN0YXRlIG5hbWVzLg0KPiANCj4gSWYgc28sIGNvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgZXhhbXBs
ZXMgb2Ygc3VjaCB1c2UtY2FzZXM/DQoNCkR1bm5vLCBidXQgY2xlYXJseSB5b3Ugd2FudCB0byBk
aXNhYmxlIChzYXkpIEMzIHdoaWxlIGxlYXZpbmcgQzYNCmVuYWJsZWQuDQoNCkkgd2FzIHRyeWlu
ZyB0byBmaW5kIHdoeSBpdCB3YXMgdGFraW5nIDYwMCt1cyBmb3IgYSBSVCBwcm9jZXNzDQp0byBn
ZXQgcmVzY2hlZHVsZWQgd2hlbiBpdCBoYWQgb25seSBiZWVuIHNsZWVwaW5nIGZvciBhIGZldyB1
cy4NCg0KSSBmb3VuZCB3aGVyZSBpdCB3YXMgc2xlZXBpbmcsIGJ1dCB0aGF0IGRpZG4ndCBoZWxw
IGF0IGFsbC4NClNvbWVvbmUgcG9pbnRlZCBtZSBhdCBhICdyYW5kb20nIHBkZiB0aGF0IHJlZmVy
cmVkIHRvIC9kZXYvY3B1X2RtYV9sYXRlbmN5Lg0KU2V0dGluZyB0aGF0IHRvIGEgc21hbGwgdmFs
dWUgKGVnIDIwKSBoZWxwcyBubyBlbmQuDQpCdXQgdGhlcmUgYXJlIG5vIHJlZmVyZW5jZXMgaW4g
dGhlIGNvZGUgb3IgbWFuIHBhZ2VzIHRvIHRoYXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

