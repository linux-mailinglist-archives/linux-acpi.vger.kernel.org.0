Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1869107644
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 18:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVRLf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 12:11:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:52621 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRLf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 12:11:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 09:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="407636294"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2019 09:11:33 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.52]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.122]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 09:11:32 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: PROBLEM: Calling ObjectType on buffer field reports type integer
Thread-Topic: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Thread-Index: AQHVmA31VHOI3uSOc0mKl5AUoFma0qeXf3RA
Date:   Fri, 22 Nov 2019 17:11:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
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
In-Reply-To: <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjQ0N2VjYWMtYTNiMS00MTI5LTgyMjQtNmMzNTc0MDYyMGZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibTU1eVRwYzBhUWltTHlLT1N2VWtcL0lBa1hUOVJHU1JqZjV6emtaNzAreTFNNlBqRnBETGVxdmpYMjNhYitBdGwifQ==
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

V2Ugd2lsbCBwcm9iYWJseSBtYWtlIHRoaXMgY2hhbmdlLCBkZXBlbmRpbmcgb24gd2hhdCBXaW5k
b3dzIGRvZXMuDQpCb2INCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWF4
aW1pbGlhbiBMdXogPGx1em1heGltaWxpYW5AZ21haWwuY29tPiANClNlbnQ6IFN1bmRheSwgTm92
ZW1iZXIgMTAsIDIwMTkgMTozMCBQTQ0KVG86IFNjaG1hdXNzLCBFcmlrIDxlcmlrLnNjaG1hdXNz
QGludGVsLmNvbT47IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBXeXNv
Y2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQpDYzogbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmcNClN1YmplY3Q6IFJlOiBQUk9CTEVN
OiBDYWxsaW5nIE9iamVjdFR5cGUgb24gYnVmZmVyIGZpZWxkIHJlcG9ydHMgdHlwZSBpbnRlZ2Vy
DQoNCg0KT24gNy8yMy8xOSAxOjAxIEFNLCBTY2htYXVzcywgRXJpayB3cm90ZToNCj4gU29ycnkg
YWJvdXQgdGhlIGxhdGUgcmVzcG9uc2UuIFRoaXMgc2xpcHBlZCB0aHJvdWdoIHRoZSBjcmFja3Mu
DQo+IEkndmUgc2VudCB0aGVtIGFuIGVtYWlsIGp1c3Qgbm93IGFuZCBJJ2xsIGtlZXAgeW91IGlu
Zm9ybWVkDQoNCkhpIGFnYWluLA0KDQppcyB0aGVyZSBhbnkgdXBkYXRlIG9uIHRoaXM/DQoNClJl
Z2FyZHMsDQoNCk1heGltaWxpYW4NCg==
