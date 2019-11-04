Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32841EE6C4
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDR6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 12:58:20 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:42183 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfKDR6U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Nov 2019 12:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572890299; x=1604426299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eeEgY2XyY+cwKokmYY5siq2JKyesQ6KOP0bPbVLL74Q=;
  b=hSr2MplLI9vb2yCShGafCOAosEffYKYnvmShRjJs306mFVmtoK7oPE9P
   S2GUtmTZs/8+AKM3cb9W1qDxQmUjNOUR6+xLpQbA8Ch59i57cSyeQXhqj
   1bPWNbCrbZ3bw171V8HuKcEfUrL6riPz+CYuUQdIuPX/kLAFglukdKt7e
   Q=;
IronPort-SDR: LmUUgvdrhiYVjkM5q71KiXWQrIiPmMd6NW0MuoVYzOQboYPmQvY1mfLOzmFGEwEOG7CQAhg+0p
 tsCceCoXdLOw==
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="3645688"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Nov 2019 17:58:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id E4E6BA2414;
        Mon,  4 Nov 2019 17:58:16 +0000 (UTC)
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 4 Nov 2019 17:58:16 +0000
Received: from EX13D07UWB001.ant.amazon.com (10.43.161.238) by
 EX13D07UWB003.ant.amazon.com (10.43.161.66) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 4 Nov 2019 17:58:16 +0000
Received: from EX13D07UWB001.ant.amazon.com ([10.43.161.238]) by
 EX13D07UWB001.ant.amazon.com ([10.43.161.238]) with mapi id 15.00.1367.000;
 Mon, 4 Nov 2019 17:58:16 +0000
From:   "Agarwal, Anchal" <anchalag@amazon.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
CC:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Topic: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Index: AQHVkPqVm6n+MpBEcEmxJhBMWECi4Kd23XsA//+SDwCABFtCAA==
Date:   Mon, 4 Nov 2019 17:58:16 +0000
Message-ID: <CEC4A132-0FBC-4DC0-8C8F-84608AD8A91A@amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <CF6A88132359CE47947DB4C6E1709ED53C66675F@ORSMSX122.amr.corp.intel.com>
 <E31BA312-7B9D-4AA9-8BD5-F60E28069979@amazon.com>
In-Reply-To: <E31BA312-7B9D-4AA9-8BD5-F60E28069979@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <173942D46B6C22499E5049AFF490C638@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

QXBvbG9naWVzIGZvciByZXNlbmRpbmcgaXQuIExvb2tzIGxpa2UgaXQgZG9lcyBub3Qgc2hvdyBp
biBjYyBsaXN0IGl0IHdlbnQgdG8gYWxsIG1haWxpbmcgbGlzdCBob3dldmVyIHRoZSB0aHJlYWQg
ZG8gYXBwZWFyIG9uIGxrbWwuIA0KVGhhbmtzLA0KQW5jaGFsDQrvu78gICAgDQogICAgICAgICsg
UmFmYWVsLCBCb2INCiAgICAgICAgDQogICAgICAgIEFsc28sIGlzIHRoZXJlIGEgcmVhc29uIHdo
eSB0aGlzIHdhc24ndCBDQy1lZCB0byBsaW51eC1hY3BpIG1haWxpbmcgbGlzdD8gSXQgd291bGQg
YmUgZ29vZCB0byBnZXQgZmVlZGJhY2sgZnJvbSB0aGVyZSB0b28uLg0KICAgIEkgdGhpbmsgSSBk
aWQgdG8gYWxsIHRoZSBlbWFpbCBpZCdzIGdlbmVyYXRlZCBmcm9tIGdldF9tYWludGFpbmVyLnBs
LiBDY2luZyBhZ2FpbiANCiAgICArIGxpbnV4LWFjcGkNCiAgICANCiAgICAgICAgVGhhbmtzLA0K
ICAgICAgICBFcmlrDQogICAgICAgIA0KICAgICAgICA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQogICAgICAgID4gRnJvbTogQW5jaGFsIEFnYXJ3YWwgPGFuY2hhbGFnQGFtYXpvbi5jb20+
DQogICAgICAgID4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI5LCAyMDE4IDEwOjUyIEFNDQogICAg
ICAgID4gU3ViamVjdDogW1BBVENIXSBBQ1BJQ0E6IEVuYWJsZSBzbGVlcCBidXR0b24gb24gQUNQ
SSBsZWdhY3kgd2FrZQ0KICAgICAgICA+IA0KICAgICAgICA+IEN1cnJlbnRseSB3ZSBkbyBub3Qg
c2VlIHNsZWVwX2VuYWJsZSBiaXQgc2V0IGFmdGVyIGd1ZXN0IHJlc3VtZXMgZnJvbQ0KICAgICAg
ICA+IGhpYmVybmF0aW9uLiBIaWJlcm5hdGlvbiBpcyB0cmlnZ2VyZWQgaW4gZ3Vlc3Qgb24gcmVj
ZWl2aW5nIGEgc2xlZXAgdHJpZ2dlcg0KICAgICAgICA+IGZyb20gdGhlIGh5cGVydmlzb3IoUzQg
c3RhdGUpLiBXZSBzZWUgdGhhdCBwb3dlciBidXR0b24gaXMgZW5hYmxlZCBvbiB3YWtlDQogICAg
ICAgID4gdXAgZnJvbSBTNCBzdGF0ZSBob3dldmVyIHNsZWVwIGJ1dHRvbiBpc24ndC4gVGhpcyBj
YXVzZXMgc3Vic2VxdWVudA0KICAgICAgICA+IGludm9jYXRpb24gb2Ygc2xlZXAgc3RhdGUgdG8g
ZmFpbCBpbiB0aGUgZ3Vlc3QuIEFueSBlbnZpcm9ubWVudCAgZ29pbmcgdGhyb3VnaA0KICAgICAg
ICA+IGFjcGlfaHdfbGVnYWN5X3dha2UoKSB3b24ndCBoYXZlIHNsZWVwIGJ1dHRvbiBlbmFibGVk
Lg0KICAgICAgICA+IA0KICAgICAgICA+IFNpZ25lZC1vZmYtYnk6IEFuY2hhbCBBZ2Fyd2FsIDxh
bmNoYWxhZ0BhbWF6b24uY29tPg0KICAgICAgICA+IFJldmlld2VkLWJ5OiBCYWxiaXIgU2luZ2gg
PHNibGJpckBhbWF6b24uY29tPg0KICAgICAgICA+IFJldmlld2VkLWJ5OiBGcmFuayB2YW4gZGVy
IExpbmRlbiA8ZmxsaW5kZW5AYW1hem9uLmNvbT4NCiAgICAgICAgPiAtLS0NCiAgICAgICAgPiAg
ZHJpdmVycy9hY3BpL2FjcGljYS9od3NsZWVwLmMgfCAxMSArKysrKysrKysrKw0KICAgICAgICA+
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KICAgICAgICA+IA0KICAgICAgICA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3c2xlZXAuYyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvaHdzbGVlcC5jDQogICAgICAgID4gaW5kZXggYjYyZGI4ZWM0NDZmLi5hMTc2Yzc4
MDI3NjAgMTAwNjQ0DQogICAgICAgID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9od3NsZWVw
LmMNCiAgICAgICAgPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3c2xlZXAuYw0KICAgICAg
ICA+IEBAIC0zMDAsNiArMzAwLDE3IEBAIGFjcGlfc3RhdHVzIGFjcGlfaHdfbGVnYWN5X3dha2Uo
dTggc2xlZXBfc3RhdGUpDQogICAgICAgID4gIAkJCQkgICAgW0FDUElfRVZFTlRfUE9XRVJfQlVU
VE9OXS4NCiAgICAgICAgPiAgCQkJCSAgICBzdGF0dXNfcmVnaXN0ZXJfaWQsIEFDUElfQ0xFQVJf
U1RBVFVTKTsNCiAgICAgICAgPiANCiAgICAgICAgPiArCS8qIEVuYWJsZSBzbGVlcCBidXR0b24g
Ki8NCiAgICAgICAgPiArCSh2b2lkKQ0KICAgICAgICA+ICsJICAgICAgYWNwaV93cml0ZV9iaXRf
cmVnaXN0ZXIoYWNwaV9nYmxfZml4ZWRfZXZlbnRfaW5mbw0KICAgICAgICA+ICsJCQkJICAgICAg
W0FDUElfRVZFTlRfU0xFRVBfQlVUVE9OXS4NCiAgICAgICAgPiArCQkJCSAgICAgIGVuYWJsZV9y
ZWdpc3Rlcl9pZCwNCiAgICAgICAgPiBBQ1BJX0VOQUJMRV9FVkVOVCk7DQogICAgICAgID4gKw0K
ICAgICAgICA+ICsJKHZvaWQpDQogICAgICAgID4gKwkgICAgICBhY3BpX3dyaXRlX2JpdF9yZWdp
c3RlcihhY3BpX2dibF9maXhlZF9ldmVudF9pbmZvDQogICAgICAgID4gKwkJCQkgICAgICBbQUNQ
SV9FVkVOVF9TTEVFUF9CVVRUT05dLg0KICAgICAgICA+ICsJCQkJICAgICAgc3RhdHVzX3JlZ2lz
dGVyX2lkLCBBQ1BJX0NMRUFSX1NUQVRVUyk7DQogICAgICAgID4gKw0KICAgICAgICA+ICAJYWNw
aV9od19leGVjdXRlX3NsZWVwX21ldGhvZChNRVRIT0RfUEFUSE5BTUVfX1NTVCwNCiAgICAgICAg
PiBBQ1BJX1NTVF9XT1JLSU5HKTsNCiAgICAgICAgPiAgCXJldHVybl9BQ1BJX1NUQVRVUyhzdGF0
dXMpOw0KICAgICAgICA+ICB9DQogICAgICAgID4gLS0NCiAgICAgICAgPiAyLjE1LjMuQU1aTg0K
ICAgICAgICANCiAgICAgICAgDQogICAgDQogICAgDQoNCg==
