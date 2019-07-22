Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6870CE9
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfGVXB5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 19:01:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:64834 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfGVXB5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jul 2019 19:01:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 16:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,296,1559545200"; 
   d="scan'208";a="368676008"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2019 16:01:19 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 16:01:19 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.237]) with mapi id 14.03.0439.000;
 Mon, 22 Jul 2019 16:01:19 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: PROBLEM: Calling ObjectType on buffer field reports type integer
Thread-Topic: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Thread-Index: AQHU2nGbL6Z+rOUTjEmNgKjiKxQRHaYLXjCwgAaMyoCAAbd1AP//x1cAgAU5pID//5K0EIC9Al0AgALU3XA=
Date:   Mon, 22 Jul 2019 23:01:19 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
In-Reply-To: <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDhlZmQzNWMtNmMxYi00MWExLWI0MWEtYWM2ODMzNDRkNzcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSkl0Wmk2Q3k5NGpLWHR0VnBTRWNtcFF3T2dqb2hoSXVZVndYYXRwS1MyemR2Q2RReXpjK1RwVHZoQkthamNtSiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF4aW1pbGlhbiBMdXog
W21haWx0bzpsdXptYXhpbWlsaWFuQGdtYWlsLmNvbV0NCj4gU2VudDogU2F0dXJkYXksIEp1bHkg
MjAsIDIwMTkgMTo0NSBQTQ0KPiBUbzogU2NobWF1c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50
ZWwuY29tPjsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29j
a2ksIFJhZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWFj
cGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IFN1YmplY3Q6IFJlOiBQUk9C
TEVNOiBDYWxsaW5nIE9iamVjdFR5cGUgb24gYnVmZmVyIGZpZWxkIHJlcG9ydHMgdHlwZSBpbnRl
Z2VyDQo+IA0KPiBPbiAzLzIyLzE5IDEwOjI4IFBNLCBTY2htYXVzcywgRXJpayB3cm90ZToNCj4g
PiBJJ3ZlIGJlZW4gZGlzY3Vzc2luZyB0aGlzIHdpdGggQm9iLiBJJ3ZlIGRlY2lkZWQgdG8gZmls
ZSBhIGJ1ZyBhZ2FpbnN0DQo+ID4gTWljcm9zb2Z0IGludGVybmFsbHkuIEkgd291bGQgbGlrZSB0
byB3YWl0IGFuZCBzZWUgd2hhdCB0aGV5IHNheS4uLg0KPiA+IEkndmUgbmV2ZXIgZG9uZSBzdWNo
IHRoaW5ncyBzbyBJIGRvbid0IGtub3cgaG93IGxvbmcgdGhlIHByb2Nlc3MgdGFrZXMgdG8gZ2V0
DQo+IGEgcmVzcG9uc2UgZm9ybSB0aGVtLg0KPiA+DQo+ID4gSSdsbCBwb3N0IHVwZGF0ZXMgd2hl
biBJIGdldCB0aGVtIGJ1dCBmZWVsIGZyZWUgdG8gcGluZyB1cyBhZ2FpbiBpbiBhDQo+ID4gZmV3
IHdlZWtzIGlmIHlvdSBkb24ndCBoZWFyIGJhY2suIFdlJ3JlIHN0aWxsIGludmVzdGlnYXRpbmcg
dGhlaXINCj4gPiBvcGVyYXRpb24gcmVnaW9uIGJlaGF2aW9yIGFzIHdlbGwuLi4NCj4gPg0KPiA+
IEVyaWsNCj4gDQo+IEhpLA0KPiANCj4gSSBhc3N1bWUgdGhlcmUgaGFzbid0IGJlZW4gYW55IHJl
c3BvbnNlIGZyb20gTWljcm9zb2Z0Pw0KDQpTb3JyeSBhYm91dCB0aGUgbGF0ZSByZXNwb25zZS4g
VGhpcyBzbGlwcGVkIHRocm91Z2ggdGhlIGNyYWNrcy4NCkkndmUgc2VudCB0aGVtIGFuIGVtYWls
IGp1c3Qgbm93IGFuZCBJJ2xsIGtlZXAgeW91IGluZm9ybWVkDQoNClRoYW5rcywNCkVyaWsNCj4g
DQo+IE1heGltaWxpYW4NCg==
