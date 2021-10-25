Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2E439B03
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhJYQCO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 12:02:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:19514 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhJYQCN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 12:02:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="229545012"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="229545012"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 08:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="493768434"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2021 08:59:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 25 Oct 2021 08:59:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 25 Oct 2021 08:59:08 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Mon, 25 Oct 2021 08:59:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH v2] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
Thread-Topic: [PATCH v2] ACPI, APEI, EINJ: Relax platform response timeout to
 1 second.
Thread-Index: AQHXx0r+hFO+UTVGcUC6Y89jbSc6h6vfsdiAgAKi84CAAc9gAP//v0XA
Date:   Mon, 25 Oct 2021 15:59:08 +0000
Message-ID: <bb5582286b13495b9d91e3f13b61cbd9@intel.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <20211022134424.67279-1-xueshuai@linux.alibaba.com>
 <YXNPSQT9LnxiyVFC@agluck-desk2.amr.corp.intel.com>
 <777aca99-b076-5bd7-03e3-f12ef9e7edd0@linux.alibaba.com>
 <f976af5e-6821-9ce1-0575-b4e2d7fd4479@linux.alibaba.com>
In-Reply-To: <f976af5e-6821-9ce1-0575-b4e2d7fd4479@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pj4gTm8sIEkgZG9uJ3QuIEVJTkogcHJvdmlkZXMgYSBoYXJkd2FyZSBlcnJvciBpbmplY3Rpb24g
bWVjaGFuaXNtIHRvIGRldmVsb3ANCj4+IGFuZCBkZWJ1ZyBmaXJtd2FyZSBjb2RlIGFuZCBoYXJk
d2FyZSBSQVMgZmVhdHVyZS4gV2hpbGUgd2UgdGVzdCBvbiBBcm0NCj4+IHBsYXRmb3JtLCBpdCBj
YW5ub3QgbWVldCB0aGUgb3JpZ2luYWwgdGltZW91dCBsaW1pdC4gVGhlcmVmb3JlLCB3ZSBzZW5k
DQo+PiB0aGlzIHBhdGNoIHRvIHJlbGF4IHRoZSB1cHBlciBib3VuZCBvZiB0aW1lb3V0LiBJbiBv
cmRlciB0byBmYWNpbGl0YXRlDQo+PiBvdGhlciBwbGF0Zm9ybXMgdG8gZW5jb3VudGVyIHRoZSBz
YW1lIHByb2JsZW1zLCB3ZSBleHBvc2UgdGltZW91dCBhcyBhDQo+PiBjb25maWd1cmFibGUgcGFy
YW1ldGVyIGluIHVzZXIgc3BhY2UuDQo+DQo+IFdoYXQncyB5b3VyIG9waW5pb24gYWJvdXQgdGhp
cyBpbnRlcmZhY2U/DQoNCkkgY2FuJ3Qgc2VlIGEgY2FzZSB3aGVyZSBhbnlvbmUgd291bGQgdXNl
IGl0LiBTbyBpdCBpcyBqdXN0IHVzZWxlc3MgZmx1ZmYuDQoNCkkgc2F5IGRyb3AgaXQgZnJvbSB0
aGUgbmV4dCByZXYgb2YgdGhlIHBhdGNoLg0KDQotVG9ueQ0K
