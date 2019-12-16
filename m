Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E924E1210CF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 18:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLPRF7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 12:05:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:38961 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbfLPRF6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 12:05:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:05:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="212273102"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2019 09:05:56 -0800
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.176]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Mon, 16 Dec 2019 09:05:56 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
Thread-Topic: [PATCH v2 4/4] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
Thread-Index: AQHVseF3bvPS5ZOAmUuyTTcUxX7aS6e9iIGA
Date:   Mon, 16 Dec 2019 17:05:55 +0000
Message-ID: <752244e73e3703b6d20da3ab870e4e86f9e4a3fb.camel@intel.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
         <8964445c268f61beb8fbaa3f54b469ddd7f8cafa.1576260216.git.gayatri.kammela@intel.com>
In-Reply-To: <8964445c268f61beb8fbaa3f54b469ddd7f8cafa.1576260216.git.gayatri.kammela@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA96230C7571B74CA249DB7FDE131EEB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTEzIGF0IDEwOjE0IC0wODAwLCBHYXlhdHJpIEthbW1lbGEgd3JvdGU6
DQo+IFRpZ2VyIExha2UgaGFzIGEgbmV3IHVuaXF1ZSBoYXJkd2FyZSBJRHMgdG8gc3VwcG9ydCB0
aGVybWFsIGRyaXZlci4NCj4gSGVuY2UsIGFkZCB0aGVtLg0KPiANCj4gQ2M6IEFuZHkgU2hldmNo
ZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBDYzogWmhhbmcgcnVp
IDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2
YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEdheWF0cmkgS2FtbWVs
YSA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBQYW5kcnV2YWRhLCBT
cmluaXZhcyA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5jIHwgMSAr
DQo+ICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDNfdGhlcm1h
bC5jIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90
aGVybWFsLmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0
MDBfdGhlcm1hbC5jDQo+IGluZGV4IDM1MTc4ODNiNWNkYi4uZWZhZTBjMDJkODk4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhl
cm1hbC5jDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50
MzQwMF90aGVybWFsLmMNCj4gQEAgLTM2OSw2ICszNjksNyBAQCBzdGF0aWMgaW50IGludDM0MDBf
dGhlcm1hbF9yZW1vdmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBpbnQzNDAwX3RoZXJtYWxf
bWF0Y2hbXSA9IHsNCj4gKwl7IklOVDEwNDAiLCAwfSwNCj4gIAl7IklOVDM0MDAiLCAwfSwNCj4g
IAl7fQ0KPiAgfTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvaW50MzQwM190aGVybWFsLmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50
MzQweF90aGVybWFsL2ludDM0MDNfdGhlcm1hbC5jDQo+IGluZGV4IGE3YmJkODU4NGFlMi4uYWVl
Y2UxZTEzNmE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90
aGVybWFsL2ludDM0MDNfdGhlcm1hbC5jDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9p
bnQzNDB4X3RoZXJtYWwvaW50MzQwM190aGVybWFsLmMNCj4gQEAgLTI4Miw2ICsyODIsNyBAQCBz
dGF0aWMgaW50IGludDM0MDNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgaW50MzQw
M19kZXZpY2VfaWRzW10gPSB7DQo+ICsJeyJJTlQxMDQzIiwgMH0sDQo+ICAJeyJJTlQzNDAzIiwg
MH0sDQo+ICAJeyIiLCAwfSwNCj4gIH07DQo=
