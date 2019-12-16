Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB3012116B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLPRNu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 12:13:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:42785 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfLPRNu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 12:13:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="227178778"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2019 09:13:48 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 09:13:48 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 09:13:48 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Dec 2019 09:13:48 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 09:13:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iECGgeFOQskoYj8Q0A+R3SDxzsyiLiKjLM9qKWMoe+ryi5T3gZWFyjRUmzYBUZsPN/X9hrpa2eMZozbeyvzRfYMt82goamGyR7aBTvjtKi7QhdYdueU9XH5gAXkGoq9mYKezmdq9QNistfYBGJTrrw6QmYHr5kxwbAlM8mhKAcsee6wB/v067o++ndjPBB+Tiv2+6HfpeNUsHsv6xQxCk+PU4o0G0HOmeZ/Alau8sqstMQ7cvbcFCzEwkMP2HIz0xbJA4FYjkeJI6RF2YIs9M1QkjVPkKCWOz+w4c/8whvVONhvWCETHBJR4nSlnbXJDpHvD5jqZ9+ra6O+vZja8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXYRvToxuTXIxD6uo0oYtJedwky8RO70ClLloct/fnw=;
 b=AzwFEINX+g+SLWRqtuEebvdW77vJCtxFFGwAw7tFVbzCdNSKPHZEkUeiKaNBahIoKQcE3oMqsho/5sQNS4f0W11RNggbz1961uIhsxU8MjrDKhXVPKxmu+hKsE/7cHWEsSFCpCrgdl42i4zr2v0Lta0IPsIK7eFUonyLxy+H9KGda3UFsB/sZjvfJFnBJdZW83f3rnvPBT8pjawLuxZhrDHEvGN80uFIV5DjcJJUN8AbRAxJHAB/26igrL3U+7w3WE3uKbws1UVO0QYqZYcV1euM0MLK7+csu9uTgBkXKg8riJptAxNWgVLh6ZLCJlEkq4xbzEYfjTMJBNhV97aGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXYRvToxuTXIxD6uo0oYtJedwky8RO70ClLloct/fnw=;
 b=izvTjdLHaNU9OOPbQ2wGGd01BcXHIgS/a5sXNcr8TiRk/B9N3WdJ3uBzO1AZ+x2aqI4biezOSr/alHEtTUycLLC+kv2ICy4GBVaFP17IZ08aBNQ3MmjY1PejVMYD4bkQmzjOo7jL395iMui8ZpVS/7BLOiDSmjQcDdtpyJlL5R8=
Received: from MWHPR11MB1278.namprd11.prod.outlook.com (10.169.230.151) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.50.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 17:13:27 +0000
Received: from MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e]) by MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 17:13:27 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH v2 2/4] acpi: fan: Add new Tiger Lake hardware ID to
 support fan driver in acpi
Thread-Topic: [PATCH v2 2/4] acpi: fan: Add new Tiger Lake hardware ID to
 support fan driver in acpi
Thread-Index: AQHVseGEAxttpjp63km2uFcUMgOw3qe8ejKAgACGWpA=
Date:   Mon, 16 Dec 2019 17:13:27 +0000
Message-ID: <MWHPR11MB1278A7759D1965B59B5EAA71F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
 <3c1ed2c9964c63fc956ec249d7bfce8d49f53fee.1576260216.git.gayatri.kammela@intel.com>
 <CAJZ5v0hysFS+tVKz3fJ0yoOTqaGpx+4oD2Nh98HCzT86=hXawA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hysFS+tVKz3fJ0yoOTqaGpx+4oD2Nh98HCzT86=hXawA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTBmNWRiZjMtYjYxMS00YWU2LWIyNWQtZmQyYTkxZmE1NWM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZHVKUDJVOWtCRmxkNGtPY0pXSUZIWWZjZTlVbUJ2YlRROXZpN2t1YVNDSTh0c05DdFwvcnJuSitZS2ZVQlJtcjEifQ==
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26bec074-fbea-4c88-653a-08d7824b442b
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17573CED2921405DE3259280F2510@MWHPR11MB1757.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:155;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(76116006)(5660300002)(66476007)(71200400001)(4744005)(52536014)(186003)(478600001)(33656002)(86362001)(316002)(9686003)(8936002)(7696005)(81156014)(81166006)(2906002)(6506007)(7416002)(55016002)(8676002)(54906003)(4326008)(6916009)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1278.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt6PsT3OmK9LyghbDI812Eb2Qi4ekrOvUiWUhRUdbJYYlgJwGs9R++G59+6sPVI7ScuRMYRlwzB5pLSf2BPZY/I+anMeO2Uqm/Vttu63N2L2MrOrsXpjtFcR35zYT8jP8ZKImdMJwawXo+Qp7kCj73GgmqnGOfxRqXwLb3pW86IdTgK/CiaeeNnQxFcgcJQqSsETaa59DS1Gvl89ElO4tUvBiCjDaqmMQh3FUQPxL1vKB6Q+ndPPkFabGzEVud55UUqRWwSu9VJczPP+GLdc50DjYBZzwiXdBipC5QVab5YXN9WATw1tK9qcmEv7VXN/4l6WbWLd9mQ5H7bhqMF30SX34hy3VngUC9I3f/AbGcOLwbznfd3DVnOmORFCkzsdFgxErogimjZSuypXTqL8akBdKtpxyZm4jChO8bA9O/RPKHmJYDJ7sBLJ6sevus7x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bec074-fbea-4c88-653a-08d7824b442b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:13:27.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMLzuEuXRND5vr9/mPVxvhpJzW/ZGGDwTcz+t5toE+4gU0jTM6GITwJDLY7JDBr3+ei+lurV3D8oizZdIdZebh+7sAXBMTwsZjvrpvD0T1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IFRpZ2VyIExha2UgaGFzIGEgbmV3IHVuaXF1ZSBoYXJkd2FyZSBJRCB0byBzdXBwb3J0IGZh
biBkcml2ZXIuIEhlbmNlLA0KPiA+IGFkZCBpdC4NCj4gPg0KPiA+IENjOiBBbmR5IFNoZXZjaGVu
a28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogWmhhbmcgUnVp
IDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmlu
aXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXlhdHJpIEth
bW1lbGEgPGdheWF0cmkua2FtbWVsYUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
YWNwaS9mYW4uYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvZmFuLmMgYi9kcml2ZXJzL2FjcGkvZmFu
LmMgaW5kZXgNCj4gPiA4MTZiMDgwM2Y3ZmIuLjEzNzA4ZmI0ODAzOCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2FjcGkvZmFuLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvZmFuLmMNCj4gPiBA
QCAtMjUsNiArMjUsNyBAQCBzdGF0aWMgaW50IGFjcGlfZmFuX3JlbW92ZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ID4gKnBkZXYpOw0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNw
aV9kZXZpY2VfaWQgZmFuX2RldmljZV9pZHNbXSA9IHsNCj4gPiAgICAgICAgIHsiUE5QMEMwQiIs
IDB9LA0KPiA+ICsgICAgICAgeyJJTlQxMDQ0IiwgMH0sDQo+IA0KPiBUaGlzIGhhcyB0byBnbyBp
bnRvIGRldmljZV9wbS5jOmFjcGlfZGV2X3BtX2F0dGFjaCgpIHRvbywgc2VlIGNvbW1pdA0KPiAN
Cj4gYjllYTBiYWUyNjBmIEFDUEk6IFBNOiBBdm9pZCBhdHRhY2hpbmcgQUNQSSBQTSBkb21haW4g
dG8gY2VydGFpbiBkZXZpY2VzDQpUaGFua3MgUmFmYWVsISBJIHdpbGwgYWRkIGl0IGFuZCBzZW5k
IHYzLg0KPiANCj4gPiAgICAgICAgIHsiSU5UMzQwNCIsIDB9LA0KPiA+ICAgICAgICAgeyIiLCAw
fSwNCj4gPiAgfTsNCj4gPiAtLQ0K
