Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D309114A09
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfLEX5z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Dec 2019 18:57:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:4823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLEX5z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Dec 2019 18:57:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 15:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="236849251"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2019 15:57:54 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Dec 2019 15:57:54 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Dec 2019 15:57:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 5 Dec 2019 15:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R76eGQOb7dM6/VWsGWQZ2ECjNd+Yib8H4Q9MmPl/vrpvcPSe/UuCkug7WkzauFyCMHPg6t/ZQ4noQybs000e+J8drvTal2M029rl+XnZRTl49oAbRSKDtXoXnaY2a8ZfJqLfZzZ6/1MZIfuZNAp5HjqbtuJ9rvgbQXp0AXKoZ3T6UQ/Ftf8ss4AC/g8ctsk2uUy9TnPMB9FBIKR5cMnxJ0DpySdpUiVQ0A5mwa4NYg88OpMNZ0TUxMqur9Nllv3Ngt7vETs3fg5aIjU8MkoiQkeP7wr3QqD/qmx+k2epHDh8Rwpq2kuf7afmNSUOw5kkWi7dyvzw78APTOLgJRlJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LBWKiB5At74lV+SSxnzlG0fuFecPSNuMdNQwB0dqB8=;
 b=mNtx9K78TnPCcH0WiQkBPzTkI8lma6e6Xt9535lbCw2ay+b+T7PA2rUaO6BXUVY6Os/y27kSHAsm/8pGjuIgogASxe8AC9uFocKuYjd8hXWkfWq89Ec4F5b2YqWNdJTfpqM80ZVwzkAFaxagEs+snhtckBi9IaU8wWdR3HYT6nrwyiNDtyiXgQnHsmpVEjTcytuJ/OrcGpDfxoVH7ok0nHBQr7XGvCO1u+IfrDV1nHoktU59rHsxiIpajQqARzFF2TsSbvRRZCMSk8HZ+RjAWU5TPehgIz3LGamfo0uVCmAgW1KJ5QwVTkwWEaOKjiqVdxiWcZz6R4x5FNrKEwycZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LBWKiB5At74lV+SSxnzlG0fuFecPSNuMdNQwB0dqB8=;
 b=sKvxgGuwnM9mTZPIyrkJOh8OTmk8zA2Yi3yCjUzMC3EM3r+v1yAfx7gCjmd9otHKESpP6W22JsctE6bC64EQ6fl7f+6LvEWGcDd3ZhwTh08Ogpibe+BRLlwLBXmiHh5cDcT1u/h+m+00dQbzG9RKQI1boyjJ7UgYAu5nydJ/SJc=
Received: from DM6PR11MB3612.namprd11.prod.outlook.com (20.178.230.213) by
 DM6PR11MB2538.namprd11.prod.outlook.com (20.176.95.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Thu, 5 Dec 2019 23:57:52 +0000
Received: from DM6PR11MB3612.namprd11.prod.outlook.com
 ([fe80::fc93:7517:20e7:5dd6]) by DM6PR11MB3612.namprd11.prod.outlook.com
 ([fe80::fc93:7517:20e7:5dd6%2]) with mapi id 15.20.2516.013; Thu, 5 Dec 2019
 23:57:52 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: PROBLEM: Calling ObjectType on buffer field reports type integer
Thread-Topic: PROBLEM: Calling ObjectType on buffer field reports type integer
Thread-Index: AQHU2nGbL6Z+rOUTjEmNgKjiKxQRHaYLXjCwgAaMyoCAAbd1AP//x1cAgAU5pID//5K0EIC9Al0AgALU3XCArt/DgIASk+KAgABSrgD//47LcAATQFMAAHue9oABl40u4AAtGRSAADr5hNA=
Date:   Thu, 5 Dec 2019 23:57:52 +0000
Message-ID: <DM6PR11MB3612BE55D4E70040DEB102DCF05C0@DM6PR11MB3612.namprd11.prod.outlook.com>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
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
 <CF6A88132359CE47947DB4C6E1709ED53C688D60@ORSMSX122.amr.corp.intel.com>
 <DM6PR11MB3612787F2B1143C658168A26F0420@DM6PR11MB3612.namprd11.prod.outlook.com>
 <6fc2767d-4f48-dc7f-1bc1-6d0a2014b8f4@gmail.com>
In-Reply-To: <6fc2767d-4f48-dc7f-1bc1-6d0a2014b8f4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzAyYTg1MzQtZmY2Zi00NDkzLTllNTItOWJiYWFmZjhjMDU2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOUh4WmRnMkJZTFhQVU5QaDFiTTVURDhrc1wvWHl6Vkg2MFdrMjNhTzUxQnMrXC9uWjA1WEJHXC9icVwveWd2d0txZUUifQ==
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [134.134.136.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48785d69-e0bd-4e83-f4e4-08d779def0b7
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB25382E9A9A6E08F03AB925F4F05C0@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(366004)(396003)(13464003)(199004)(189003)(52536014)(81166006)(81156014)(305945005)(110136005)(8936002)(25786009)(71200400001)(316002)(7696005)(71190400001)(8676002)(11346002)(14444005)(74316002)(26005)(54906003)(99286004)(5660300002)(229853002)(4326008)(76176011)(55016002)(2906002)(186003)(76116006)(6636002)(53546011)(66476007)(66556008)(66946007)(33656002)(66446008)(9686003)(14454004)(478600001)(64756008)(102836004)(86362001)(6506007)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2538;H:DM6PR11MB3612.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IauFCuLwmED+J8RsVIaOjas3ZXjuUwxv8bL1SxxQY6qkPrivJK0Xs5ga+htJq6jpaJBEBb1Ryqt0gJ6J1DIcorHm2DMJmg+4wznzSMmgdoQEzOh70baSNVLCxK1BPFmyNdiVpYIQ8fSrZPAi0fkEYCc3ua+hyWD1HS7DrwrF4z3ObsHakQ5kkVD9zfXTuZEHNTD/meTMtZjQQmAdD03Q92Z4oIPK0DS10EtO1Azse5B7eCuOsuF2Cz7GZcWw+2aIgDT2wx46kBr0YL5hCoopaCfinBRM+/lWlf0TtPd4ZHHiqLUFWSGlxcVi9g7izxRv6+XvO6MESFI4kXgXfrgGIRQ7Woeg85qte9jQkRL03c3uZD4UEgTStlRiYTv6np4XJFf9u1x/DM62ILbjujQIlzsGfM2+Xz8JB24kkKyCWi6GbuloXROvdFwfRUMSTF/MTJMv2BluYaoPPr8pRswa9iNZ5OtBKFjeoQNc3qO3bGB/kSxeaYKrv/lgKh55Xf1xFspp1CLZZ2WHRDbLaJiOX/5xNqriQSLBG8Mc24rIT6M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48785d69-e0bd-4e83-f4e4-08d779def0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 23:57:52.3783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLm9Ef+0Xsldqd9lGIPjs7sJRLK/1yTVgmHhc/U3p2wu+icMyrQlF93FqM5EzhOWpA38mE6XVfr1Zf9ZqeC1mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF4aW1pbGlhbiBMdXog
PGx1em1heGltaWxpYW5AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDQs
IDIwMTkgMTE6MzQgQU0NCj4gVG86IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29t
PjsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJh
ZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IFN1YmplY3Q6IFJlOiBQUk9CTEVNOiBD
YWxsaW5nIE9iamVjdFR5cGUgb24gYnVmZmVyIGZpZWxkIHJlcG9ydHMgdHlwZSBpbnRlZ2VyDQo+
IA0KPiBPbiAxMi8zLzE5IDExOjIxIFBNLCBLYW5lZGEsIEVyaWsgd3JvdGU6DQo+ID4gSGkgTWF4
aW1pbGlhbiwNCj4gPg0KPiA+IFBsZWFzZSB0cnkgdGhlIHBhdGNoIGJlbG93Og0KPiANCj4gSGks
DQo+IA0KPiBJJ3ZlIHRlc3RlZCB0aGlzIG9uIDUuNC4xIGFuZCB0aGUgY3VycmVudCB1cHN0cmVh
bSBtYXN0ZXIgbm93Lg0KPiBVbmZvcnR1bmF0ZWx5IGl0IGRvZXNuJ3Qgc2VlbSB0byBmaXggdGhl
IGlzc3VlLg0KPiANCj4gU3BlY2lmaWNhbGx5LCBpdCBzZWVtcyBsaWtlIHRoZSBmbGFnIGRvZXNu
J3QgZ2V0IHNldCBoZXJlIChwcmludGstZGVidWdnaW5nDQo+IGluZGljYXRlcyB0aGF0IHRoZSBj
b2RlIGluIHRoZSBpZiBuZXZlciBydW5zKToNCj4gDQo+ID4NCj4gPg0KPiAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+
ICoqKg0KPiA+ICoqKioqKioqKiBkaWZmIC1OdXJwIGxpbnV4LmJlZm9yZV9uYW1lL2RyaXZlcnMv
YWNwaS9hY3BpY2EvZHN1dGlscy5jDQo+ID4gbGludXguYWZ0ZXJfbmFtZS9kcml2ZXJzL2FjcGkv
YWNwaWNhL2RzdXRpbHMuYw0KPiA+IC0tLSBsaW51eC5iZWZvcmVfbmFtZS9kcml2ZXJzL2FjcGkv
YWNwaWNhL2RzdXRpbHMuYwkyMDE5LTEyLTAzDQo+IDEzOjM2OjIxLjc4MjU3ODcxOCAtMDgwMA0K
PiA+ICsrKyBsaW51eC5hZnRlcl9uYW1lL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHN1dGlscy5jCTIw
MTktMTItMDMNCj4gMTM6MzY6MTcuNzY1NTc5MTEwIC0wODAwDQo+ID4gQEAgLTQ3MCw2ICs0NzAs
OSBAQCBhY3BpX2RzX2NyZWF0ZV9vcGVyYW5kKHN0cnVjdCBhY3BpX3dhbGtfDQo+ID4gICAJCQkg
ICAgQUNQSV9DQVNUX1BUUih1bmlvbiBhY3BpX29wZXJhbmRfb2JqZWN0LA0KPiA+ICAgCQkJCQkg
IHdhbGtfc3RhdGUtPmRlZmVycmVkX25vZGUpOw0KPiA+ICAgCQkJc3RhdHVzID0gQUVfT0s7DQo+
ID4gKwkJCWlmICh3YWxrX3N0YXRlLT5vcGNvZGUgPT0gQU1MX0NSRUFURV9GSUVMRF9PUCkgew0K
PiA+ICsJCQkJb2JqX2Rlc2MtPmJ1ZmZlcl9maWVsZC5pc19jcmVhdGVfZmllbGQgPSBUUlVFOw0K
PiA+ICsJCQl9DQo+ID4gICAJCX0gZWxzZSB7CS8qIEFsbCBvdGhlciBvcGNvZGVzICovDQo+ID4N
Cj4gPiAgIAkJCS8qDQo+IA0KPiBUaGF0IG9mIGNvdXJzZSBtZWFucyB0aGF0IHRoZSBpZiBjb25k
aXRpb24gaGVyZSBpcyBzdGlsbCBub3QgZnVsZmlsbGVkLCBzbyB0aGUNCj4gcHJvYmxlbSBpcyBu
b3QgZml4ZWQuDQo+IA0KPiA+IGRpZmYgLU51cnAgbGludXguYmVmb3JlX25hbWUvZHJpdmVycy9h
Y3BpL2FjcGljYS9leGZpZWxkLmMNCj4gbGludXguYWZ0ZXJfbmFtZS9kcml2ZXJzL2FjcGkvYWNw
aWNhL2V4ZmllbGQuYw0KPiA+IC0tLSBsaW51eC5iZWZvcmVfbmFtZS9kcml2ZXJzL2FjcGkvYWNw
aWNhL2V4ZmllbGQuYwkyMDE5LTEyLTAzDQo+IDEzOjM2OjIxLjc5MTU3ODcxNyAtMDgwMA0KPiA+
ICsrKyBsaW51eC5hZnRlcl9uYW1lL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhmaWVsZC5jCTIwMTkt
MTItMDMNCj4gMTM6MzY6MTguMjU3NTc5MDYyIC0wODAwDQo+ID4gQEAgLTE1MywxMiArMTU0LDE3
IEBAIGFjcGlfZXhfcmVhZF9kYXRhX2Zyb21fZmllbGQoc3RydWN0IGFjcGkNCj4gPiAgIAkgKiB0
aGUgdXNlIG9mIGFyaXRobWV0aWMgb3BlcmF0b3JzIG9uIHRoZSByZXR1cm5lZCB2YWx1ZSBpZiB0
aGUNCj4gPiAgIAkgKiBmaWVsZCBzaXplIGlzIGVxdWFsIG9yIHNtYWxsZXIgdGhhbiBhbiBJbnRl
Z2VyLg0KPiA+ICAgCSAqDQo+ID4gKwkgKiBIb3dldmVyLCBhbGwgYnVmZmVyIGZpZWxkcyBjcmVh
dGVkIGJ5IGNyZWF0ZV9maWVsZCBvcGVyYXRvciBuZWVkcyB0bw0KPiA+ICsJICogcmVtYWluIGFz
IGEgYnVmZmVyIHRvIG1hdGNoIG90aGVyIEFNTCBpbnRlcnByZXRlciBpbXBsZW1lbnRhdGlvbnMu
DQo+ID4gKwkgKg0KPiA+ICAgCSAqIE5vdGU6IEZpZWxkLmxlbmd0aCBpcyBpbiBiaXRzLg0KPiA+
ICAgCSAqLw0KPiA+ICAgCWJ1ZmZlcl9sZW5ndGggPQ0KPiA+DQo+ID4gKGFjcGlfc2l6ZSlBQ1BJ
X1JPVU5EX0JJVFNfVVBfVE9fQllURVMob2JqX2Rlc2MtPmZpZWxkLmJpdF9sZW5ndGgpOw0KPiA+
DQo+ID4gLQlpZiAoYnVmZmVyX2xlbmd0aCA+IGFjcGlfZ2JsX2ludGVnZXJfYnl0ZV93aWR0aCkg
ew0KPiA+ICsJaWYgKGJ1ZmZlcl9sZW5ndGggPiBhY3BpX2dibF9pbnRlZ2VyX2J5dGVfd2lkdGgg
fHwNCj4gPiArCSAgICAob2JqX2Rlc2MtPmNvbW1vbi50eXBlID09IEFDUElfVFlQRV9CVUZGRVJf
RklFTEQgJiYNCj4gPiArCSAgICAgb2JqX2Rlc2MtPmJ1ZmZlcl9maWVsZC5pc19jcmVhdGVfZmll
bGQpKSB7DQo+ID4NCj4gPiAgIAkJLyogRmllbGQgaXMgdG9vIGxhcmdlIGZvciBhbiBJbnRlZ2Vy
LCBjcmVhdGUgYSBCdWZmZXIgaW5zdGVhZCAqLw0KPiA+DQo+IA0KPiBJZiBJJ20gbm90IG1pc3Rh
a2VuIEkndmUgcHJvcG9zZWQgYSBwYXRjaCBoZXJlIHRoYXQgaXMgY29uY2VwdHVhbGx5IHF1aXRl
IHNpbWlsYXINCj4gKGJ1dCBtYXkgaGF2ZSBzb21lIGZsYXdzIG9yIGNhdXNlIG90aGVyIGlzc3Vl
cywgYXMgSSdtIG5vdCByZWFsbHkgZmFtaWxpYXIgd2l0aA0KPiB0aGUgQUNQSUNBIGNvZGUtYmFz
ZSkuIE15IGlkZWEgd2FzIHRvIG1vZGlmeSBhY3BpX2RzX2luaXRfYnVmZmVyX2ZpZWxkDQo+IChk
c29wY29kZS5jKSBpbnN0ZWFkIG9mIGFjcGlfZHNfY3JlYXRlX29wZXJhbmQuIEFzIHNhaWQsIEkn
bSBub3Qgc3VyZSBob3dldmVyDQo+IGlmIHRoaXMgbWF5IGhhdmUgYW55IG90aGVyIGNvbnNlcXVl
bmNlcyB0aGF0IEknbSB1bmF3YXJlIG9mLg0KPiANCj4gQWxzbyBJJ3ZlIGF2b2lkZWQgY3JlYXRp
bmcgYW4gaXNfY3JlYXRlX2ZpZWxkIGZsYWcgYnkgY2hhbmdpbmcgdGhlIGZpZWxkIGFjY2Vzcw0K
PiBmcm9tIEFNTF9GSUVMRF9BQ0NFU1NfQllURSB0byBBTUxfRklFTERfQUNDRVNTX0JVRkZFUiAo
d2hpY2ggZG9lc24ndA0KPiBzZWVtIHRvIGJlIHVzZWQgYW55d2hlcmUgZWxzZSkgYW5kIGNoZWNr
aW5nIHRoYXQsIGJ1dCB0aGUgZ2VuZXJhbCBpZGVhIG9mDQo+IGV4dGVuZGluZyB0aGUgaWYgY29u
ZGl0aW9uIGluIGFjcGlfZXhfcmVhZF9kYXRhX2Zyb21fZmllbGQgaXMgdGhlIHNhbWUuDQo+IA0K
PiBMaW5rIHRvIHRoZSBwYXRjaDoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3F6ZWQvbGludXgtc3Vy
ZmFjZWdlbjUtDQo+IGFjcGkvYmxvYi8yMDE0OTY0YmFjNTJmMTM4MTA5NDQzZGUzZTkyZGMyYzZj
ZmY1ZTgzL3BhdGNoZXMvNS4zLzAwMDEtDQo+IEFDUEktRml4LWJ1ZmZlci1pbnRlZ2VyLXR5cGUt
bWlzbWF0Y2gucGF0Y2gNCg0KWW91ciBzb2x1dGlvbiBsb29rcyB2ZXJ5IHNpbWlsYXIgdG8gbXkg
cGF0Y2guDQpJbiBBY3BpRHNJbml0QnVmZmVyRmllbGQsIEkgd291bGQgcHJlZmVyIHRvIHVzZSBh
IG5ldyBmaWVsZCAiaXNfY3JlYXRlX2ZpZWxkIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LiBBTUxf
RklFTERfQUNDRVNTX0JVRkZFUg0KZG9lcyBnZXQgdXNlZCBpbiBvdGhlciBwYXJ0cyBvZiBBQ1BJ
Q0Egc28gbGV0J3MgY3JlYXRlIGFuZCB1c2UgYSBuZXcgZmllbGQgaW4gdGhlIG9iamVjdCB1bmlv
bi4NCg0KR28gYWhlYWQgYW5kIHJlLXN1Ym1pdCB0aGUgcGF0Y2ggd2l0aCB0aGUgYWJvdmUgY2hh
bmdlcy4gSSdsbCBlZGl0IHlvdXIgZXhwbGFuYXRpb24gd2l0aCBtb3JlIGRldGFpbHMgYW5kIGlu
Y2x1ZGUgdGhpcyBpbg0KdGhlIG5leHQgQUNQSUNBIHJlbGVhc2UuIEl0J2xsIGxhbmQgaW4gbGlu
dXggYWZ0ZXIgdGhlIHJlbGVhc2UuDQoNClRoYW5rcyENCkVyaWsNCj4gDQo+IFRoYW5rcywNCj4g
TWF4aW1pbGlhbg0K
