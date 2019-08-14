Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEC8E014
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfHNVoV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:44:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:38219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHNVoV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Aug 2019 17:44:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 14:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="376182235"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2019 14:44:20 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 14:44:19 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.226]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 14:44:20 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Duran, Leo" <leo.duran@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: RE: Parsing PXM from ACPI (DSDT)
Thread-Topic: Parsing PXM from ACPI (DSDT)
Thread-Index: AdVSCEGThmsUNGQZSm2XEI5B9E2GMQA3cq8AAAA9gMAAAAlkEAAAd9EA
Date:   Wed, 14 Aug 2019 21:44:19 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C61A2BC@ORSMSX122.amr.corp.intel.com>
References: <CY4PR12MB1815927E36A8A9A0E5B18734F9D20@CY4PR12MB1815.namprd12.prod.outlook.com>
 <CY4PR12MB18156AA493BA8F3C28F0377FF9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
 <CY4PR12MB1815E6208E334CE4EA8F2670F9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
 <CY4PR12MB1815251BBCB062AAA8EEB39CF9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1815251BBCB062AAA8EEB39CF9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWE4ZTM1NTQtNzkzMi00NzdhLTgyZDUtOWI3Y2JhYTcxNWI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZG1wRnF0MUtxQVpJdGNadVlpK2RJNDNlMml3YmF5Y1huOVY1bEhuNnBMVEF2bGMyRTZFTG8yMzJ0S3NtbVwvbjEifQ==
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1hY3BpLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBEdXJhbiwgTGVvDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0
IDE0LCAyMDE5IDI6MzAgUE0NCj4gVG86IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJq
d3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUGFy
c2luZyBQWE0gZnJvbSBBQ1BJIChEU0RUKQ0KPiANCkhpIExlbywNCg0KPiBIZWxsbywNCj4gSXMg
bm90IGNsZWFyIG9yIGV2aWRlbnQgdG8gbWUgaWYgdGhlIGtlcm5lbCBwYXJzZXMgX1BYTSB2YWx1
ZXMgYmVsb3cgKG9yIHVuZGVyKQ0KPiB0aGUgcm9vdC1jb21wbGV4Lg0KDQpCdWlsZCB3aXRoIENP
TkZJR19BQ1BJX0RFQlVHPXkgYW5kIGJvb3Qgd2l0aCBhY3BpLmRlYnVnX2xheWVyPTB4ZmZmZmZm
ZmYgYWNwaS5kZWJ1Z19sZXZlbD0weDgwMDAwDQoNClRoaXMgd2lsbCBwcmludCBhbGwgb2YgdGhl
IEFjcGlFdmFsdWF0ZU9iamVjdCBxdWVyaWVzIHRvIHRoZSBkbWVzZy4NCg0KPiANCj4gRm9yIGV4
YW1wbGUsIGluIG15IGV4cGVyaWVuY2U6DQo+IFRoaXMgQVNMIHNhbXBsZSBmb3IgUFhNIGF0IHRo
ZSByb290LWNvbXBsZXggbGV2ZWwgcHJvZHVjZXMgdGhlIGV4cGVjdGVkDQo+IE5VTUEgYXNzaWdu
bWVudCBmcm9tIOKAnGxzdG9wb+KAnToNCj4gU2NvcGUgKFxfU0IpIHsNCj4gICAvLyAuLi4NCj4g
ICBEZXZpY2UgKFBDSTApIHsgLy8gUm9vdCBQQ0kgQnVzIChIb3N0LUJyaWRnZSkNCj4gICAgIE5h
bWUgKF9ISUQsIEVJU0FJRCgiUE5QMEEwOCIpKQ0KPiAgICAgTmFtZSAoX0NJRCwgRUlTQUlEKCJQ
TlAwQTAzIikpDQo+ICAgICBOYW1lIChfQkJOLCAwKQ0KPiAgICAgTWV0aG9kIChfQ1JTLDApIHsN
Cj4gICAgICAgLy8gUmV0dXJuIGN1cnJlbnQgcmVzb3VyY2VzIGZvciBob3N0IGJyaWRnZSAwDQo+
ICAgICB9DQo+ICAgICBOYW1lIChfUFJULCBQYWNrYWdlKCkgew0KPiAgICAgIC8vIFBhY2thZ2Ug
d2l0aCBQQ0kgSVJRIHJvdXRpbmcgdGFibGUgaW5mb3JtYXRpb24NCj4gICAgIH0pDQo+ICAgICBN
ZXRob2QgKF9QWE0sIDAsIE5vdFNlcmlhbGl6ZWQpIHsNCj4gICAgICAgUmV0dXJuICgwKQ0KPiAg
ICAgfQ0KPiAgIH0NCj4gICAvLyAuLi4NCj4gfQ0KPiANCj4gSG93ZXZlciwNCj4gVGhpcyBBU0wg
c2FtcGxlIGZvciBQWE0gYXQgdGhlIFAyUCByb290LWJyaWRnZSBsZXZlbCBkb2VzIG5vdCBwcm9k
dWNlIHRoZQ0KPiBleHBlY3RlZCBOVU1BIGFzc2lnbm1lbnQgZnJvbSDigJxsc3RvcG/igJ06DQo+
ICAoT2YgY291cnNlLCB0aGUgYXNzdW1wdGlvbiBpcyB0aGF0IG11bHRpcGxlIE5VTUEgbm9kZXMg
YWN0dWFsbHkgZXhpc3Qgb24gdGhlDQo+IHN5c3RlbSkNCj4gDQo+ICBTY29wZSAoXF9TQikgew0K
PiAgIC8vIC4uLg0KPiAgIERldmljZSAoUENJMCkgeyAvLyBSb290IFBDSSBCdXMgKEhvc3QtQnJp
ZGdlKQ0KPiAgICAgTmFtZSAoX0hJRCwgRUlTQUlEICgiUE5QMEEwOCIpKQ0KPiAgICAgTmFtZSAo
X0NJRCwgRUlTQUlEICgiUE5QMEEwMyIpKQ0KPiAgICAgTmFtZSAoX0JCTiwgMCkNCj4gICAgIE1l
dGhvZCAoX0NSUywwKSB7DQo+ICAgICAgIC8vIFJldHVybiBjdXJyZW50IHJlc291cmNlcyBmb3Ig
aG9zdCBicmlkZ2UgMA0KPiAgICAgfQ0KPiAgICAgTmFtZSAoX1BSVCwgUGFja2FnZSgpIHsNCj4g
ICAgICAgLy8gUGFja2FnZSB3aXRoIFBDSSBJUlEgcm91dGluZyB0YWJsZSBpbmZvcm1hdGlvbg0K
PiAgICAgfSkNCj4gDQo+IMKgwqDCoCBEZXZpY2UgKFAyUDApIHsgLy8gRmlyc3QgUENJLXRvLVBD
SSBicmlkZ2UgKFBvcnQwKQ0KPiDCoMKgwqDCoMKgIE5hbWUgKF9BRFIsIDB4MDAwNzAwMDEpIC8v
IERldmljZSM3aCwgRnVuYyMxIG9uIGJ1cyBQQ0kwDQo+IMKgwqDCoMKgwqAgTmFtZSAoX1BSVCwg
UGFja2FnZSgpIHsNCj4gwqDCoMKgwqDCoCAgIC8vIFBhY2thZ2Ugd2l0aCBQQ0kgSVJRIHJvdXRp
bmcgdGFibGUgaW5mb3JtYXRpb24NCj4gwqDCoMKgwqDCoCB9KQ0KPiAgICAgICBNZXRob2QgKF9Q
WE0sIDAsIE5vdFNlcmlhbGl6ZWQpIHsNCj4gICAgICAgICBSZXR1cm4gKDApDQo+ICAgICAgIH0N
Cj4gwqDCoMKgIH0NCj4gDQo+IMKgwqDCoCBEZXZpY2UgKFAyUDEpIHsgLy8gU2Vjb25kIFBDSS10
by1QQ0kgYnJpZGdlIChQb3J0MSkNCj4gwqDCoMKgwqDCoCBOYW1lIChfQURSICwweDAwMDgwMDAx
KSAvLyBEZXZpY2UjOGgsIEZ1bmMjMSBvbiBidXMgUENJMA0KPiDCoMKgwqDCoMKgIE5hbWUgKF9Q
UlQsIFBhY2thZ2UoKSB7DQo+IMKgwqDCoMKgwqAgICAvLyBQYWNrYWdlIHdpdGggUENJIElSUSBy
b3V0aW5nIHRhYmxlIGluZm9ybWF0aW9uDQo+IMKgICAgwqAgfSkNCj4gICAgICAgTWV0aG9kIChf
UFhNLCAwLCBOb3RTZXJpYWxpemVkKSB7DQo+ICAgICAgICAgIFJldHVybiAoMSkNCj4gICAgICAg
fQ0KPiDCoMKgwqAgfQ0KPiAgIH0NCj4gICAvLyAuLi4NCj4gfQ0KPiANCj4gVGhhbmtzLA0KPiBM
ZW8uDQoNCg==
