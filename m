Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73E110124
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2019 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLCPXX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Dec 2019 10:23:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:49802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfLCPXX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Dec 2019 10:23:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 07:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="410876264"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2019 07:23:22 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.52]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.179]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 07:23:21 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        zhengbin <zhengbin13@huawei.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Topic: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Index: AQHVoRboulD/DOKym0m5GPkUUMHHlKeXuvowgACTb4CABGzZAIAL3S+A
Date:   Tue, 3 Dec 2019 15:23:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B311D@ORSMSX110.amr.corp.intel.com>
References: <1574415183-19322-1-git-send-email-zhengbin13@huawei.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A5A@ORSMSX110.amr.corp.intel.com>
 <e2c60e61-4c2c-ced2-3eda-26d7b3fb8f4b@canonical.com>
 <CF6A88132359CE47947DB4C6E1709ED53C688958@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C688958@ORSMSX122.amr.corp.intel.com>
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

SG93ZXZlciwgQUNQSUNBIGhhcyBhbiAiQUNQSV9BUlJBWV9MRU5HVEgiIG1hY3JvIHdoaWNoIGNv
dWxkIHBvc3NpYmx5IGJlIHVzZWQuIEl0J3MgZGVmaW5lZCBsaWtlIHRoaXM6DQoNCiNkZWZpbmUg
QUNQSV9BUlJBWV9MRU5HVEgoeCkgICAgICAgICAgICAoc2l6ZW9mKHgpIC8gc2l6ZW9mKCh4KVsw
XSkpDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNjaG1hdXNzLCBFcmlr
IDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4gDQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDI1LCAy
MDE5IDEwOjExIEFNDQpUbzogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT47IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyB6aGVuZ2JpbiA8emhl
bmdiaW4xM0BodWF3ZWkuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lA
aW50ZWwuY29tPjsgbGVuYkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsg
ZGV2ZWxAYWNwaWNhLm9yZw0KU3ViamVjdDogUkU6IFtEZXZlbF0gUmU6IFtQQVRDSF0gQUNQSUNB
OiBVc2UgQVJSQVlfU0laRSBmb3IgJ2ZhZHRfaW5mb190YWJsZScsJ2ZhZHRfcG1faW5mb190YWJs
ZScNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNw
aS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgDQo+IDxsaW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVs
Lm9yZz4NCj4gT24gQmVoYWxmIE9mIENvbGluIElhbiBLaW5nDQo+IFNlbnQ6IEZyaWRheSwgTm92
ZW1iZXIgMjIsIDIwMTkgMjozNiBQTQ0KPiBUbzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3Jl
QGludGVsLmNvbT47IHpoZW5nYmluIA0KPiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPjsgU2NobWF1
c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPjsgDQo+IFd5c29ja2ksIFJhZmFlbCBK
IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IGxlbmJAa2VybmVsLm9yZzsgDQo+IGxpbnV4
LSBhY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0KPiBTdWJqZWN0OiBSZTog
W0RldmVsXSBSZTogW1BBVENIXSBBQ1BJQ0E6IFVzZSBBUlJBWV9TSVpFIGZvciANCj4gJ2ZhZHRf
aW5mb190YWJsZScsJ2ZhZHRfcG1faW5mb190YWJsZScNCj4gDQo+IE9uIDIyLzExLzIwMTkgMjE6
NDksIE1vb3JlLCBSb2JlcnQgd3JvdGU6DQo+ID4gV2hlcmUgZG9lcyAiQVJSQVlfU0laRSIgY29t
ZSBmcm9tPyBJdCdzIG5vdCBhIHBhcnQgb2YgQUNQSUNBLg0KPiA+IEJvYg0KPiANCj4gSXQncyBk
ZWZpbml0ZWx5IG5vdCBwYXJ0IG9mIEFDUElDQSwgaXQncyBkZWZpbmVkIGluIGxpbnV4L2tlcm5l
bC5oDQoNCkFDUElDQSBjb2RlYmFzZSBtdXN0IHdvcmsgYWNyb3NzIG11bHRpcGxlIG9wZXJhdGlu
ZyBzeXN0ZW1zLiBTaW5jZSBBUlJBWV9TSVpFIG1hY3JvIGlzIHNwZWNpZmljIHRvIGxpbnV4LCB3
ZSBjYW5ub3QgdGFrZSB0aGlzIGNoYW5nZSBhcyBpdCBzdGFuZHMuLg0KDQpFcmlrDQo+IA0KPiA+
DQo+ID4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IHpoZW5nYmlu
IDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyMiwg
MjAxOSAxOjMzIEFNDQo+ID4gVG86IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5j
b20+OyBTY2htYXVzcywgRXJpayANCj4gPiA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+OyBXeXNv
Y2tpLCBSYWZhZWwgSiANCj4gPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBsZW5iQGtl
cm5lbC5vcmc7IA0KPiA+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eu
b3JnDQo+ID4gQ2M6IHpoZW5nYmluMTNAaHVhd2VpLmNvbQ0KPiA+IFN1YmplY3Q6IFtQQVRDSF0g
QUNQSUNBOiBVc2UgQVJSQVlfU0laRSBmb3INCj4gJ2ZhZHRfaW5mb190YWJsZScsJ2ZhZHRfcG1f
aW5mb190YWJsZScNCj4gPg0KPiA+IEZpeGVzIGNvY2NpY2hlY2sgd2FybmluZzoNCj4gPg0KPiA+
IGRyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0LmM6MTA3OjI3LTI4OiBXQVJOSU5HOiBVc2UgQVJS
QVlfU0laRQ0KPiA+IGRyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0LmM6MTM3OjMwLTMxOiBXQVJO
SU5HOiBVc2UgQVJSQVlfU0laRQ0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1
bGtjaUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IHpoZW5nYmluIDx6aGVuZ2JpbjEz
QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0LmMg
fCA2ICsrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0
LmMgDQo+ID4gYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiZmFkdC5jIGluZGV4IDAwNDFiZmIuLjMy
NGE4MDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS90YmZhZHQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJmYWR0LmMNCj4gPiBAQCAtMTAzLDggKzEwMyw3
IEBAIHN0YXRpYyBzdHJ1Y3QgYWNwaV9mYWR0X2luZm8gZmFkdF9pbmZvX3RhYmxlW10gPSB7DQo+
ID4gIAkgQUNQSV9GQURUX1NFUEFSQVRFX0xFTkdUSCB8IEFDUElfRkFEVF9HUEVfUkVHSVNURVJ9
ICB9Ow0KPiA+DQo+ID4gLSNkZWZpbmUgQUNQSV9GQURUX0lORk9fRU5UUklFUyBcDQo+ID4gLQkJ
CShzaXplb2YgKGZhZHRfaW5mb190YWJsZSkgLyBzaXplb2YgKHN0cnVjdA0KPiBhY3BpX2ZhZHRf
aW5mbykpDQo+ID4gKyNkZWZpbmUgQUNQSV9GQURUX0lORk9fRU5UUklFUyAoQVJSQVlfU0laRShm
YWR0X2luZm9fdGFibGUpKQ0KPiA+DQo+ID4gIC8qIFRhYmxlIHVzZWQgdG8gc3BsaXQgRXZlbnQg
QmxvY2tzIGludG8gc2VwYXJhdGUgc3RhdHVzL2VuYWJsZSANCj4gPiByZWdpc3RlcnMgKi8NCj4g
Pg0KPiA+IEBAIC0xMzMsOCArMTMyLDcgQEAgc3RhdGljIHN0cnVjdCBhY3BpX2ZhZHRfcG1faW5m
byANCj4gPiBmYWR0X3BtX2luZm9fdGFibGVbXQ0KPiA9IHsNCj4gPiAgCSAxfQ0KPiA+ICB9Ow0K
PiA+DQo+ID4gLSNkZWZpbmUgQUNQSV9GQURUX1BNX0lORk9fRU5UUklFUyBcDQo+ID4gLQkJCShz
aXplb2YgKGZhZHRfcG1faW5mb190YWJsZSkgLyBzaXplb2YgKHN0cnVjdA0KPiBhY3BpX2ZhZHRf
cG1faW5mbykpDQo+ID4gKyNkZWZpbmUgQUNQSV9GQURUX1BNX0lORk9fRU5UUklFUyAoQVJSQVlf
U0laRShmYWR0X3BtX2luZm9fdGFibGUpKQ0KPiA+DQo+ID4NCj4gLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAqKioq
KioqKioqKioqDQo+ID4gICAqDQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gRGV2ZWwgbWFpbGluZyBsaXN0
IC0tIGRldmVsQGFjcGljYS5vcmcgVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCANCj4gPiB0
byBkZXZlbC1sZWF2ZUBhY3BpY2Eub3JnIA0KPiA+ICUod2ViX3BhZ2VfdXJsKXNsaXN0aW5mbyUo
Y2dpZXh0KXMvJShfaW50ZXJuYWxfbmFtZSlzDQo+ID4NCg0K
