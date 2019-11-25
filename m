Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1D10934C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2019 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKYSKu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Nov 2019 13:10:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:14667 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfKYSKu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Nov 2019 13:10:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 10:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; 
   d="scan'208";a="206363961"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2019 10:10:49 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 25 Nov 2019 10:10:49 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.73]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.36]) with mapi id 14.03.0439.000;
 Mon, 25 Nov 2019 10:10:48 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Colin Ian King <colin.king@canonical.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        zhengbin <zhengbin13@huawei.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Topic: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Index: AQHVoRbYAgfSUyPm4kuJ0bywmDfyraeYQUCAgAANKYCAA+NeAA==
Date:   Mon, 25 Nov 2019 18:10:48 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C688958@ORSMSX122.amr.corp.intel.com>
References: <1574415183-19322-1-git-send-email-zhengbin13@huawei.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A5A@ORSMSX110.amr.corp.intel.com>
 <e2c60e61-4c2c-ced2-3eda-26d7b3fb8f4b@canonical.com>
In-Reply-To: <e2c60e61-4c2c-ced2-3eda-26d7b3fb8f4b@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTQ1NWNhZmQtOGRiMS00NjhjLTg5OWYtOThlM2FlODA0N2NlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWlpEYndQSGxDMGx1NCtpMVBMdzdUU0dEVzltM1VyQWxXRzBhdG9wckR6SU9jcDFPZmpQSDYyUlF0K3dJK0JYRiJ9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBP
biBCZWhhbGYgT2YgQ29saW4gSWFuIEtpbmcNCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyMiwg
MjAxOSAyOjM2IFBNDQo+IFRvOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29t
PjsgemhlbmdiaW4NCj4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT47IFNjaG1hdXNzLCBFcmlrIDxl
cmlrLnNjaG1hdXNzQGludGVsLmNvbT47DQo+IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbT47IGxlbmJAa2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5r
ZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IFN1YmplY3Q6IFJlOiBbRGV2ZWxdIFJlOiBb
UEFUQ0hdIEFDUElDQTogVXNlIEFSUkFZX1NJWkUgZm9yDQo+ICdmYWR0X2luZm9fdGFibGUnLCdm
YWR0X3BtX2luZm9fdGFibGUnDQo+IA0KPiBPbiAyMi8xMS8yMDE5IDIxOjQ5LCBNb29yZSwgUm9i
ZXJ0IHdyb3RlOg0KPiA+IFdoZXJlIGRvZXMgIkFSUkFZX1NJWkUiIGNvbWUgZnJvbT8gSXQncyBu
b3QgYSBwYXJ0IG9mIEFDUElDQS4NCj4gPiBCb2INCj4gDQo+IEl0J3MgZGVmaW5pdGVseSBub3Qg
cGFydCBvZiBBQ1BJQ0EsIGl0J3MgZGVmaW5lZCBpbiBsaW51eC9rZXJuZWwuaA0KDQpBQ1BJQ0Eg
Y29kZWJhc2UgbXVzdCB3b3JrIGFjcm9zcyBtdWx0aXBsZSBvcGVyYXRpbmcgc3lzdGVtcy4gU2lu
Y2UgQVJSQVlfU0laRSBtYWNybyBpcyBzcGVjaWZpYyB0byBsaW51eCwgd2UgY2Fubm90IHRha2Ug
dGhpcyBjaGFuZ2UgYXMgaXQgc3RhbmRzLi4NCg0KRXJpaw0KPiANCj4gPg0KPiA+DQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiB6aGVuZ2JpbiA8emhlbmdiaW4xM0Bo
dWF3ZWkuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjIsIDIwMTkgMTozMyBBTQ0K
PiA+IFRvOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgU2NobWF1c3Ms
IEVyaWsNCj4gPiA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+OyBXeXNvY2tpLCBSYWZhZWwgSg0K
PiA+IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IGxlbmJAa2VybmVsLm9yZzsNCj4gPiBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0KPiA+IENjOiB6aGVu
Z2JpbjEzQGh1YXdlaS5jb20NCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIEFDUElDQTogVXNlIEFSUkFZ
X1NJWkUgZm9yDQo+ICdmYWR0X2luZm9fdGFibGUnLCdmYWR0X3BtX2luZm9fdGFibGUnDQo+ID4N
Cj4gPiBGaXhlcyBjb2NjaWNoZWNrIHdhcm5pbmc6DQo+ID4NCj4gPiBkcml2ZXJzL2FjcGkvYWNw
aWNhL3RiZmFkdC5jOjEwNzoyNy0yODogV0FSTklORzogVXNlIEFSUkFZX1NJWkUNCj4gPiBkcml2
ZXJzL2FjcGkvYWNwaWNhL3RiZmFkdC5jOjEzNzozMC0zMTogV0FSTklORzogVXNlIEFSUkFZX1NJ
WkUNCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL3RiZmFkdC5jIHwgNiArKy0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiZmFkdC5jDQo+ID4gYi9kcml2ZXJz
L2FjcGkvYWNwaWNhL3RiZmFkdC5jIGluZGV4IDAwNDFiZmIuLjMyNGE4MDQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS90YmZhZHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvdGJmYWR0LmMNCj4gPiBAQCAtMTAzLDggKzEwMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
YWNwaV9mYWR0X2luZm8gZmFkdF9pbmZvX3RhYmxlW10gPSB7DQo+ID4gIAkgQUNQSV9GQURUX1NF
UEFSQVRFX0xFTkdUSCB8IEFDUElfRkFEVF9HUEVfUkVHSVNURVJ9ICB9Ow0KPiA+DQo+ID4gLSNk
ZWZpbmUgQUNQSV9GQURUX0lORk9fRU5UUklFUyBcDQo+ID4gLQkJCShzaXplb2YgKGZhZHRfaW5m
b190YWJsZSkgLyBzaXplb2YgKHN0cnVjdA0KPiBhY3BpX2ZhZHRfaW5mbykpDQo+ID4gKyNkZWZp
bmUgQUNQSV9GQURUX0lORk9fRU5UUklFUyAoQVJSQVlfU0laRShmYWR0X2luZm9fdGFibGUpKQ0K
PiA+DQo+ID4gIC8qIFRhYmxlIHVzZWQgdG8gc3BsaXQgRXZlbnQgQmxvY2tzIGludG8gc2VwYXJh
dGUgc3RhdHVzL2VuYWJsZQ0KPiA+IHJlZ2lzdGVycyAqLw0KPiA+DQo+ID4gQEAgLTEzMyw4ICsx
MzIsNyBAQCBzdGF0aWMgc3RydWN0IGFjcGlfZmFkdF9wbV9pbmZvIGZhZHRfcG1faW5mb190YWJs
ZVtdDQo+ID0gew0KPiA+ICAJIDF9DQo+ID4gIH07DQo+ID4NCj4gPiAtI2RlZmluZSBBQ1BJX0ZB
RFRfUE1fSU5GT19FTlRSSUVTIFwNCj4gPiAtCQkJKHNpemVvZiAoZmFkdF9wbV9pbmZvX3RhYmxl
KSAvIHNpemVvZiAoc3RydWN0DQo+IGFjcGlfZmFkdF9wbV9pbmZvKSkNCj4gPiArI2RlZmluZSBB
Q1BJX0ZBRFRfUE1fSU5GT19FTlRSSUVTIChBUlJBWV9TSVpFKGZhZHRfcG1faW5mb190YWJsZSkp
DQo+ID4NCj4gPg0KPiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKioqKioqKioNCj4gPiAgICoNCj4gPiAt
LQ0KPiA+IDIuNy40DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gPiBEZXZlbCBtYWlsaW5nIGxpc3QgLS0gZGV2ZWxAYWNwaWNhLm9yZyBUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvDQo+ID4gZGV2ZWwtbGVhdmVAYWNwaWNhLm9yZw0K
PiA+ICUod2ViX3BhZ2VfdXJsKXNsaXN0aW5mbyUoY2dpZXh0KXMvJShfaW50ZXJuYWxfbmFtZSlz
DQo+ID4NCg0K
