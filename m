Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1109D10A776
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2019 01:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0AZx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Nov 2019 19:25:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:56876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfK0AZx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Nov 2019 19:25:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 16:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600"; 
   d="scan'208";a="211590126"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2019 16:25:52 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.73]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.82]) with mapi id 14.03.0439.000;
 Tue, 26 Nov 2019 16:25:51 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: PROBLEM: Calling ObjectType on buffer field reports type integer
Thread-Topic: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Thread-Index: AQHU2nGbL6Z+rOUTjEmNgKjiKxQRHaYLXjCwgAaMyoCAAbd1AP//x1cAgAU5pID//5K0EIC9Al0AgALU3XCArt/DgIASk+KAgABSrgD//47LcAATQFMAAHue9oA=
Date:   Wed, 27 Nov 2019 00:25:51 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C688D60@ORSMSX122.amr.corp.intel.com>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
 <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
 <20f023a8-67f2-71dd-266d-700012c05b39@gmail.com>
In-Reply-To: <20f023a8-67f2-71dd-266d-700012c05b39@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODExZDFkOWItOGQxMS00MzQ2LWFlODQtZjI3NjlkMjgyZDllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia1FXOXMxR2VldHM4ZHo3Y1FVOXdPQ1ZMN0JsbFdadmc1YTRjcTdOQUJWaWFTYzJLT0ZGUXFlaUc5RFN5R280eiJ9
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

PiANCj4gVGhpcyBsb29rcyBsaWtlIGEgc2VwYXJhdGUgcHJvYmxlbSB0byBtZS4gT24gdGhlIFNC
MiB0aGVyZSBpcyB0aGlzIHBpZWNlIG9mIGNvZGUsDQo+IHNpbXBsaWZpZWQ6DQo+IA0KPiAgICAg
IE5hbWUoUlFCRiwgQnVmZmVyICgweEZGKSB7fSkNCj4gICAgICBDcmVhdGVCeXRlRmllbGQgKFJR
QkYsIDB4MDMsIEFMRU4pDQo+IA0KPiAgICAgIC8vIC4uLg0KPiAgICAgIC8vIEdlbmVyaWNTZXJp
YWxCdXMvQXR0cmliUmF3UHJvY2Vzc0J5dGVzIGFjY2VzcyB0byBmaWxsIFJRQkYNCj4gICAgICAv
LyAuLi4NCj4gDQo+ICAgICAgSWYgKC8qIHN1Y2Nlc3MgYW5kIGV2ZXJ5dGhpbmcgaXMgdmFsaWQg
Ki8pDQo+ICAgICAgew0KPiAgICAgICAgICBMb2NhbDMgPSAoQUxFTiAqIDB4MDgpDQo+ICAgICAg
ICAgIENyZWF0ZUZpZWxkIChSUUJGLCAweDIwLCBMb2NhbDMsIEFSQikNCj4gICAgICAgICAgTG9j
YWw0ID0gQVJCIC8qIFxfU0JfLl9TQU4uUlFTWC5BUkJfICovDQo+ICAgICAgfQ0KPiAgICAgIEVs
c2UNCj4gICAgICB7DQo+ICAgICAgICAgIExvY2FsNCA9IDB4MDEgICAvLyBvciBzb21lIG90aGVy
IGVycm9yIGNvZGUgYXMgaW50ZWdlcg0KPiAgICAgIH0NCj4gDQo+ICAgICAgLy8gLi4uDQo+ICAg
ICAgLy8gc29tZSBtb3JlIHN0dWZmDQo+ICAgICAgLy8gLi4uDQo+IA0KPiAgICAgIElmICgoT2Jq
ZWN0VHlwZSAoTG9jYWw0KSA9PSBPbmUgLyogSW50ZWdlciAqLykpDQo+ICAgICAgew0KPiAgICAg
ICAgICAvLyBub3RpZnkgdGhhdCBhbiBlcnJvciBoYXMgb2NjdXJyZWQNCj4gICAgICB9DQo+ICAg
ICAgRWxzZQ0KPiAgICAgIHsNCj4gICAgICAgICAgLy8gc3VjY2VzcyBhbmQgYWN0dWFsbHkgdXNl
IGRhdGEgZnJvbSBMb2NhbDQNCj4gICAgICB9DQo+IA0KPiBUaGUgY29kZSBpbiBxdWVzdGlvbiBi
YXNpY2FsbHkgdW5wYWNrcyBhIHBheWxvYWQgZnJvbSBzb21lIG90aGVyDQo+IG1hbmFnZW1lbnQg
c3R1ZmYgc2VudCBvdmVyIHRoZSBPcGVyYXRpb25SZWdpb24uDQo+IA0KPiBIZXJlLCBBTEVOIGlz
IHRoZSBsZW5ndGggb2YgYSBkeW5hbWljYWxseSBzaXplZCBwYXlsb2FkIGluIGJ5dGVzLCB3aGlj
aCBpcw0KPiBvYnRhaW5lZCBmcm9tIHRoZSBkYXRhIHJldHVybmVkIGJ5IHRoZSBPcGVyYXRpb25S
ZWdpb24gYWNjZXNzLiBUaGlzIGNhbiBmb3INCj4gZXhhbXBsZSBiZSA0LCBtYWtpbmcgdGhlIGZp
ZWxkIGxlbmd0aCAzMiBiaXQuIFNvIHRoaXMgaXMgbm90IGFuIGlzc3VlIG9mIHRoZSBmaWVsZA0K
PiBsZW5ndGggYmVpbmcgbGFyZ2VyIHRoYW4gaW50bWF4IGJpdHMsIGl0IGFjdHVhbGx5IGlzIHNv
bWV0aW1lcyBvbmx5IDMyIGJpdHMsIG9yIDgNCj4gYml0cywgZGVwZW5kaW5nIG9uIHRoZSByZXNw
b25zZSBvZiB0aGUgZHJpdmVyIGNvbm5lY3RlZCB0byB0aGUNCj4gT3BlcmF0aW9uUmVnaW9uLiBB
bHNvIHRoZSBEU0RUIGRlcGVuZHMgb24gdGhhdCwgc2VlIHRoZSBleGFtcGxlIGJlbG93Lg0KPiAN
Cj4gSnVzdCB0byByZWl0ZXJhdGUsIHRoZSBjb2RlIHdvcmtzIGZpbmUgZm9yIHBheWxvYWRzIHdp
dGggQUxFTiA+IDggKHNvIG1vcmUgdGhhbg0KPiA4IGJ5dGVzKSwgYnV0IGZhaWxzIGZvciBhbnl0
aGluZyBsZXNzLg0KDQpGb3JnZXQgd2hhdCBJIHNhaWQgaW4gdGhlIHByZXZpb3VzIGVtYWlsLiBZ
b3UgYXJlIGNvcnJlY3QuDQoNClRoZXkgdHJlYXQgYnVmZmVyZmllbGRzIHRoYXQgYXJlIHNtYWxs
IGVub3VnaCB0byBmaXQgaW5zaWRlIG9mIGFuIGludGVnZXIgYXMgYSBidWZmZXIgb3IgYnVmZmVy
ZmllbGQuDQoNCkkgZGlkIGEgYnVuY2ggb2YgdGVzdGluZyBvbiB3aW5kb3dzIGFuZCBkZXRlcm1p
bmVkIHRoYXQsIG9iamVjdHMgY3JlYXRlZCBieSBDcmVhdGUoQml0fEJ5dGV8V29yZHxEV29yZHxR
d29yZClGaWVsZA0Kd29yayB0aGUgc2FtZSB3YXkgb24gYm90aCBpbnRlcnByZXRlcnMuIFRoZXkg
Z2V0IGNvbnZlcnRlZCB0byBJbnRlZ2VycyBhcyBvdXRsaW5lZCBpbiB0aGUgc3BlYy4NCg0KV2Ug
c2ltcGx5IG5lZWQgdG8gc3RvcCBwZXJmb3JtIHRoZSBCdWZmZXJGaWVsZC0+SW50ZWdlciBjb252
ZXJzaW9uIGZvciBidWZmZXIgZmllbGRzIGNyZWF0ZWQgYnkgdGhlIEFTTCBDcmVhdGVGaWVsZCgp
IG9wZXJhdG9ycy4NCkknbGwgZ2V0IGEgc29sdXRpb24gaG9wZWZ1bGx5IHNvbWV0aW1lIG5leHQg
d2Vlay4uDQoNClRoYW5rcywNCkVyaWsNCg0KPiANCj4gQWxzbyBub3RlIHRoYXQgdGhpcyBpcyBu
b3Qgc29tZXRoaW5nIHRoYXQgY2FuIGJlIGZpeGVkIGJ5IGp1c3QgdGVsbGluZyB0aGUNCj4gR2Vu
ZXJpY1NlcmlhbEJ1cy9PcGVyYXRpb25SZWdpb24gZHJpdmVyIHRvIGp1c3QgcmV0dXJuIDkgYnl0
ZXMNCj4gaW5zdGVhZDogVGhlcmUgYXJlIGxlbmd0aC1jaGVja3Mgb24gTG9jYWw0IGZ1cnRoZXIg
ZG93biB0aGUgbGluZSB0byB2YWxpZGF0ZSBpdA0KPiBhY3R1YWxseSBjb250YWlucyB3aGF0IHdh
cyByZXF1ZXN0ZWQuDQo+IA0KPiBBbiBleGFtcGxlIG9mIGhvdyB0aGlzIHBpZWNlIG9mIGNvZGUg
aXMgYWN0dWFsbHkgdXNlZCwgaWYgdGhhdCBoZWxwcyAoYWdhaW4NCj4gc2ltcGxpZmllZCk6DQo+
IA0KPiAgICAgIE1ldGhvZCAoUlFTVCwgMSkNCj4gICAgICB7DQo+ICAgICAgICAgIC8vIHByZXR0
eSBtdWNoIHRoZSBjb2RlIGFib3ZlDQo+ICAgICAgICAgIFJldHVybiAoTG9jYWw0KSAgICAgLy8g
ZWl0aGVyIHBheWxvYWQgb3IgaW50ZWdlciBlcnJvciBjb2RlDQo+ICAgICAgfQ0KPiANCj4gICAg
ICBTY29wZSAoX1NCLkJBVDEpDQo+ICAgICAgew0KPiAgICAgICAgICBNZXRob2QgKF9TVEEsIDAp
DQo+ICAgICAgICAgIHsNCj4gICAgICAgICAgICAgIExvY2FsMCA9IFJRU1QoMHgwMSkgICAgIC8v
IHJlcXVlc3QgYmF0dGVyeSBzdGF0dXMNCj4gDQo+ICAgICAgICAgICAgICBJZiAoKE9iamVjdFR5
cGUgKExvY2FsMCkgPT0gMHgwMykpICAgICAgLy8gaXMgYnVmZmVyIHR5cGUNCj4gICAgICAgICAg
ICAgIHsNCj4gICAgICAgICAgICAgICAgICBJZiAoKFNpemVPZiAoTG9jYWwwKSA9PSAweDA0KSkg
ICAgICAvLyBoYXMgbGVuZ3RoIDQNCj4gICAgICAgICAgICAgICAgICB7DQo+ICAgICAgICAgICAg
ICAgICAgICAgIENyZWF0ZURXb3JkRmllbGQgKExvY2FsMCwgMCwgQkFTVCkNCj4gICAgICAgICAg
ICAgICAgICAgICAgUmV0dXJuIChCQVNUKQ0KPiAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAg
ICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAgICBSZXR1cm4gKDB4MDApICAgICAgICAgICAvLyBy
ZXR1cm4gZGVmYXVsdCB2YWx1ZQ0KPiAgICAgICAgICB9DQo+ICAgICAgfQ0KPiANCj4gDQo+IFJl
Z2FyZHMsDQo+IE1heGltaWxpYW4NCg==
