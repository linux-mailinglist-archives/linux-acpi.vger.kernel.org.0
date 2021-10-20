Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CC4350F8
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhJTRJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 13:09:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:25525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhJTRJA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 13:09:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="215757149"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="215757149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 10:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="532757487"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2021 10:04:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 10:04:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 10:04:40 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 20 Oct 2021 10:04:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [PATCH v10 5/7] x86/sgx: Hook arch_memory_failure() into mainline
 code
Thread-Topic: [PATCH v10 5/7] x86/sgx: Hook arch_memory_failure() into
 mainline code
Thread-Index: AQHXxF5ZrkPc0a9WpE6juRLF18ZQTqvcEDsAgAAPdKA=
Date:   Wed, 20 Oct 2021 17:04:40 +0000
Message-ID: <9e19490a40564bd5b3a277f9ca37f808@intel.com>
References: <20211011185924.374213-1-tony.luck@intel.com>
 <20211018202542.584115-1-tony.luck@intel.com>
 <20211018202542.584115-6-tony.luck@intel.com>
 <20211020090648.GA2339043@u2004>
In-Reply-To: <20211020090648.GA2339043@u2004>
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

PiBIb3cgYWJvdXQgcHV0dGluZyB0aGVzZSBkZWZpbml0aW9ucyBuZWFyIHRoZSBvdGhlciByZWxh
dGVkIGZ1bmN0aW9ucw0KPiBpbiB0aGUgc2FtZSBmaWxlIChsaWtlIGJlbG93KT8NCj4NCj4gIC4u
Lg0KPiAgZXh0ZXJuIHZvaWQgc2hha2VfcGFnZShzdHJ1Y3QgcGFnZSAqcCk7DQo+ICBleHRlcm4g
YXRvbWljX2xvbmdfdCBudW1fcG9pc29uZWRfcGFnZXMgX19yZWFkX21vc3RseTsNCj4gIGV4dGVy
biBpbnQgc29mdF9vZmZsaW5lX3BhZ2UodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncyk7DQo+
ICANCj4gIC8vIGhlcmU/DQoNCk1ha2VzIHNlbnNlIHRvIGdyb3VwIHRvZ2V0aGVyIHdpdGggdGhl
c2Ugb3RoZXIgUkFTIGJpdHMuDQpJJ2xsIG1vdmUgdGhlIGRlZmluaXRpb25zIGhlcmUuDQogIA0K
DQo+IE90aGVyd2lzZSwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+IFJldmlld2Vk
LWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXchDQoNCi1Ub255DQo=
