Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7315B26E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBLVCE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 12 Feb 2020 16:02:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:40824 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBLVCE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 16:02:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 13:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281337938"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2020 13:02:03 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.123]) with mapi id 14.03.0439.000;
 Wed, 12 Feb 2020 13:02:03 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Tom Abraham" <tabraham@suse.com>
Subject: RE: [PATCH v2 1/3] ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
Thread-Topic: [PATCH v2 1/3] ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
Thread-Index: AQHV4bUX6obbox02EUG+swOmUWlaeagYC72w
Date:   Wed, 12 Feb 2020 21:02:02 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96E7D91@ORSMSX110.amr.corp.intel.com>
References: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
 <20200212145941.32914-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20200212145941.32914-2-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjhjMmE5OTktNjg4OC00MDRkLTg5OTgtY2ZlMzMzZDg3OGZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2lpWUJ1b2JzTHJsbzFiWm43cDVud1g2Ulh2WDFpXC9OUndHVW8yMXVxbmtGV1lhZGRMUVREQlhtZVB3elZDMjcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Mika Westerberg <mika.westerberg@linux.intel.com> 
Sent: Wednesday, February 12, 2020 7:00 AM
To: Jean Delvare <jdelvare@suse.de>; Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org; Wim Van Sebroeck <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; linux-watchdog@vger.kernel.org; Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Tom Abraham <tabraham@suse.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/3] ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro

Sometimes it is useful to find the access_width field value in bytes and not in bits so add a helper that can be used for this purpose.

Suggested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 include/acpi/actypes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index a2583c2bc054..4defed58ea33 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -532,11 +532,12 @@ typedef u64 acpi_integer;
 	 strnlen (a, ACPI_NAMESEG_SIZE) == ACPI_NAMESEG_SIZE)
 
 /*
- * Algorithm to obtain access bit width.
+ * Algorithm to obtain access bit or byte width.
  * Can be used with access_width of struct acpi_generic_address and access_size of
  * struct acpi_resource_generic_register.
  */
 #define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
+#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))
 
OK, we've taken this one into ACPICA.
Thanks,
Bob

 /*******************************************************************************
  *
--
2.25.0

