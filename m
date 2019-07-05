Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCF609ED
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGEQEX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 12:04:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:57037 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728260AbfGEQEX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 12:04:23 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-5-XIeXKrHJPJGG4dsIQCm2tg-1;
 Fri, 05 Jul 2019 17:04:19 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Jul 2019 17:04:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Jul 2019 17:04:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yehezkel Bernat' <yehezkelshb@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Anthony Wong" <anthony.wong@canonical.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring
 producer/consumer
Thread-Topic: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring
 producer/consumer
Thread-Index: AQHVMyIznn3HI+p3CEuvWWeqi0Ulhqa8L0sw
Date:   Fri, 5 Jul 2019 16:04:19 +0000
Message-ID: <0f3a47d8133945b181d623ea6e0d53f2@AcuMS.aculab.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-4-mika.westerberg@linux.intel.com>
 <CA+CmpXtMBEtyh77fcrhX2BU8esiit56CWfZmey6LYEHZVUxf8A@mail.gmail.com>
In-Reply-To: <CA+CmpXtMBEtyh77fcrhX2BU8esiit56CWfZmey6LYEHZVUxf8A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: XIeXKrHJPJGG4dsIQCm2tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

RnJvbTogWWVoZXprZWwgQmVybmF0DQo+IFNlbnQ6IDA1IEp1bHkgMjAxOSAxMjoxMA0KPiBPbiBG
cmksIEp1bCA1LCAyMDE5IGF0IDEyOjU4IFBNIE1pa2EgV2VzdGVyYmVyZw0KPiA8bWlrYS53ZXN0
ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcmVnaXN0ZXIgYWNj
ZXNzIHNob3VsZCBiZSB1c2luZyAzMi1iaXQgcmVhZHMvd3JpdGVzIGFjY29yZGluZyB0byB0aGUN
Cj4gPiBkYXRhc2hlZXQuIFdpdGggdGhlIHByZXZpb3VzIGdlbmVyYXRpb24gaGFyZHdhcmUgMTYt
Yml0IHdyaXRlcyBoYXZlIGJlZW4NCj4gPiB3b3JraW5nIGJ1dCBzdGFydGluZyB3aXRoIElDTCB0
aGlzIGlzIG5vdCB0aGUgY2FzZSBhbnltb3JlIHNvIGZpeA0KPiA+IHByb2R1Y2VyL2NvbnN1bWVy
IHJlZ2lzdGVyIHVwZGF0ZSB0byB1c2UgY29ycmVjdCB3aWR0aCByZWdpc3RlciBhZGRyZXNzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdA
bGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3RodW5kZXJib2x0L25oaS5j
IHwgMjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy90aHVuZGVyYm9sdC9uaGkuYyBiL2RyaXZlcnMvdGh1bmRlcmJvbHQvbmhpLmMNCj4gPiBp
bmRleCAyN2ZiZTYyYzdkZGQuLjA5MjQyNjUzZGE2NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3RodW5kZXJib2x0L25oaS5jDQo+ID4gKysrIGIvZHJpdmVycy90aHVuZGVyYm9sdC9uaGkuYw0K
PiA+IEBAIC0xNDMsOSArMTQzLDI0IEBAIHN0YXRpYyB2b2lkIF9faW9tZW0gKnJpbmdfb3B0aW9u
c19iYXNlKHN0cnVjdCB0Yl9yaW5nICpyaW5nKQ0KPiA+ICAgICAgICAgcmV0dXJuIGlvOw0KPiA+
ICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgcmluZ19pb3dyaXRlMTZkZXNjKHN0cnVjdCB0Yl9y
aW5nICpyaW5nLCB1MzIgdmFsdWUsIHUzMiBvZmZzZXQpDQo+ID4gK3N0YXRpYyB2b2lkIHJpbmdf
aW93cml0ZV9wcm9kKHN0cnVjdCB0Yl9yaW5nICpyaW5nLCB1MTYgcHJvZCkNCj4gPiAgew0KPiA+
IC0gICAgICAgaW93cml0ZTE2KHZhbHVlLCByaW5nX2Rlc2NfYmFzZShyaW5nKSArIG9mZnNldCk7
DQo+ID4gKyAgICAgICB1MzIgdmFsOw0KPiA+ICsNCj4gPiArICAgICAgIHZhbCA9IGlvcmVhZDMy
KHJpbmdfZGVzY19iYXNlKHJpbmcpICsgOCk7DQo+ID4gKyAgICAgICB2YWwgJj0gMHgwMDAwZmZm
ZjsNCj4gPiArICAgICAgIHZhbCB8PSBwcm9kIDw8IDE2Ow0KPiA+ICsgICAgICAgaW93cml0ZTMy
KHZhbCwgcmluZ19kZXNjX2Jhc2UocmluZykgKyA4KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIHZvaWQgcmluZ19pb3dyaXRlX2NvbnMoc3RydWN0IHRiX3JpbmcgKnJpbmcsIHUxNiBjb25z
KQ0KPiA+ICt7DQo+ID4gKyAgICAgICB1MzIgdmFsOw0KPiA+ICsNCj4gPiArICAgICAgIHZhbCA9
IGlvcmVhZDMyKHJpbmdfZGVzY19iYXNlKHJpbmcpICsgOCk7DQo+ID4gKyAgICAgICB2YWwgJj0g
MHhmZmZmMDAwMDsNCj4gPiArICAgICAgIHZhbCB8PSBjb25zOw0KPiA+ICsgICAgICAgaW93cml0
ZTMyKHZhbCwgcmluZ19kZXNjX2Jhc2UocmluZykgKyA4KTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyB2b2lkIHJpbmdfaW93cml0ZTMyZGVzYyhzdHJ1Y3QgdGJfcmluZyAqcmluZywgdTMyIHZh
bHVlLCB1MzIgb2Zmc2V0KQ0KPiA+IEBAIC0xOTcsNyArMjEyLDEwIEBAIHN0YXRpYyB2b2lkIHJp
bmdfd3JpdGVfZGVzY3JpcHRvcnMoc3RydWN0IHRiX3JpbmcgKnJpbmcpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgZGVzY3JpcHRvci0+c29mID0gZnJhbWUtPnNvZjsNCj4gPiAgICAgICAg
ICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICByaW5nLT5oZWFkID0gKHJpbmctPmhlYWQg
KyAxKSAlIHJpbmctPnNpemU7DQo+ID4gLSAgICAgICAgICAgICAgIHJpbmdfaW93cml0ZTE2ZGVz
YyhyaW5nLCByaW5nLT5oZWFkLCByaW5nLT5pc190eCA/IDEwIDogOCk7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChyaW5nLT5pc190eCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByaW5n
X2lvd3JpdGVfcHJvZChyaW5nLCByaW5nLT5oZWFkKTsNCj4gPiArICAgICAgICAgICAgICAgZWxz
ZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJpbmdfaW93cml0ZV9jb25zKHJpbmcsIHJp
bmctPmhlYWQpOw0KPiANCj4gUmVhbGx5IGEgbWF0dGVyIG9mIHRhc3RlLCBidXQgbWF5YmUgeW91
IHdhbnQgdG8gY29uc2lkZXIgaGF2aW5nIGEgc2luZ2xlDQo+IGZ1bmN0aW9uLCB3aXRoIGEgM3Jk
IHBhcmFtZXRlciwgYm9vbCBpc190eC4NCj4gVGhlIGNhbGxzIGhlcmUgd2lsbCBiZSB1bmlmaWVk
IHRvOg0KPiAgICAgICAgIHJpbmdfaW93cml0ZShyaW5nLCByaW5nLT5oZWFkLCByaW5nLT5pc190
eCk7DQo+IChObyBjb25kaXRpb24gaXMgbmVlZGVkIGhlcmUpLg0KPiANCj4gVGhlIGltcGxlbWVu
dGF0aW9uIHVzZXMgdGhlIG5ldyBwYXJhbWV0ZXIgdG8gZGVjaWRlIHdoaWNoIHBhcnQgb2YgdGhl
IHJlZ2lzdGVyDQo+IHRvIG1hc2ssIHJlZHVjaW5nIHRoZSBjb2RlIGR1cGxpY2F0aW9uIChpbiBt
eSBleWVzKToNCj4gDQo+ICAgICAgICAgdmFsID0gaW9yZWFkMzIocmluZ19kZXNjX2Jhc2Uocmlu
ZykgKyA4KTsNCj4gICAgICAgICBpZiAoaXNfdHgpIHsNCj4gICAgICAgICAgICAgICAgIHZhbCAm
PSAweDAwMDBmZmZmOw0KPiAgICAgICAgICAgICAgICAgdmFsIHw9IHZhbHVlIDw8IDE2Ow0KPiAg
ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICB2YWwgJj0gMHhmZmZmMDAwMDsNCj4g
ICAgICAgICAgICAgICAgIHZhbCB8PSB2YWx1ZTsNCj4gICAgICAgICB9DQo+ICAgICAgICAgaW93
cml0ZTMyKHZhbCwgcmluZ19kZXNjX2Jhc2UocmluZykgKyA4KTsNCj4gDQo+IEknbSBub3Qgc3Vy
ZSBpZiBpdCBpbXByb3ZlcyB0aGUgcmVhZGFiaWxpdHkgb3IgbWFrZXMgaXQgd29yc2UuIFlvdXIg
Y2FsbC4NCg0KR2FoLCB0aGF0IGlzIGFsbCBob3JyaWQgYmV5b25kIGJlbGllZi4NCklmIGEgMzJi
aXQgd3JpdGUgaXMgdmFsaWQgdGhlbiB0aGUgaGFyZHdhcmUgbXVzdCBub3QgYmUgdXBkYXRpbmcN
CnRoZSBvdGhlciAxNiBiaXRzLg0KSW4gd2hpY2ggY2FzZSB0aGUgZHJpdmVyIGtub3dzIHdoYXQg
dGhleSBzaG91bGQgYmUuDQpTbyBpdCBjYW4gZG8gYSBzaW5nbGUgMzJiaXQgd3JpdGUgb2YgdGhl
IHJlcXVpcmVkIHZhbHVlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

