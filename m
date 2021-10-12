Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3142AB55
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhJLR73 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 13:59:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:36073 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhJLR73 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 13:59:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="250631548"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="250631548"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="460469760"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2021 10:57:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 10:57:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 10:57:24 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Tue, 12 Oct 2021 10:57:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v9 0/7] Basic recovery for machine checks inside SGX
Thread-Topic: [PATCH v9 0/7] Basic recovery for machine checks inside SGX
Thread-Index: AQHXvtIgJmQWZT3tEE2Mnbpy811gw6vQCbsA//+csTA=
Date:   Tue, 12 Oct 2021 17:57:24 +0000
Message-ID: <56e62500e9e24f19bd51aaf038bfad6b@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
         <20211011185924.374213-1-tony.luck@intel.com>
 <73c711bc548b661977ff26e3d9cc87c9466a8f66.camel@kernel.org>
In-Reply-To: <73c711bc548b661977ff26e3d9cc87c9466a8f66.camel@kernel.org>
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

PiBJIHRoaW5rIHlvdSBpbnN0cnVjdGVkIG1lIG9uIHRoaXMgYmVmb3JlIGJ1dCBJJ3ZlIGZvcmdv
dCBpdDoNCj4gaG93IGRvIEkgc2ltdWxhdGUgdGhpcyBhbmQgdGVzdCBob3cgaXQgd29ya3M/DQoN
CkphcmtrbywNCg0KWW91IGNhbiB0ZXN0IHRoZSBub24tZXhlY3V0aW9uIHBhdGhzIChlLmcuIHdo
ZXJlIHRoZSBtZW1vcnkgZXJyb3IgaXMNCnJlcG9ydGVkIGJ5IGEgcGF0cm9sIHNjcnViYmVyIGlu
IHRoZSBtZW1vcnkgY29udHJvbGxlcikgYnk6DQoNCiMgZWNobyAweHtzb21lX1NHWF9FUENfQURE
UkVTU30gPiAvc3lzL2RldmljZXMvc3lzdGVtL21lbW9yeS9oYXJkX29mZmxpbmVfcGFnZQ0KDQpU
aGUgZXhlY3V0aW9uIHBhdGhzIGFyZSBtb3JlIGRpZmZpY3VsdC4gWW91IG5lZWQgYSBzeXN0ZW0g
dGhhdCBjYW4gaW5qZWN0DQplcnJvcnMgaW50byBFUEMgbWVtb3J5LiBUaGVyZSBhcmUgc29tZSBo
aW50cyBpbiB0aGUgRG9jdW1lbmF0aW9uIGNoYW5nZXMNCmluIHBhcnQgMDAwNi4NCg0KUmVpbmV0
dGUgcG9zdGVkIHNvbWUgY2hhbmdlcyB0byBzZ3ggdGVzdHMgdGhhdCBzaGUgdXNlZCB0byB2YWxp
ZGF0ZS4NCg0KLVRvbnkNCg0K
