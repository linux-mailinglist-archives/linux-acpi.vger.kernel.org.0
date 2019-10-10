Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D687D2C4D
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJJOWG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 10 Oct 2019 10:22:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:58525 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfJJOWG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Oct 2019 10:22:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 07:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="394056897"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2019 07:22:05 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 10 Oct 2019 07:22:04 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.139]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.170]) with mapi id 14.03.0439.000;
 Thu, 10 Oct 2019 07:22:04 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     John Garry <john.garry@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields in
 Processor Structure Flags
Thread-Topic: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields
 in Processor Structure Flags
Thread-Index: AQHVf29d/i25bO8x9k+D8X4yzuUW7qdT65HA
Date:   Thu, 10 Oct 2019 14:22:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9691ADA@ORSMSX110.amr.corp.intel.com>
References: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
 <1570714192-236724-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1570714192-236724-2-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzczY2E1MzUtMmRkMS00MzhjLWEwZTgtNTAwODgxMGVmZjU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2pcL3lzMk1yVGpXYVBIQVJcL3l5QnpSZHhMTGxLeDdxMkZnSzlWMFNKRGhSNGNLNVYwWW5xS1Y3cEd1SjF4cUdTIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

John,
These #defines are all already in actbl2.h. Perhaps they didn't make it into Linux.
Bob


-----Original Message-----
From: John Garry <john.garry@huawei.com> 
Sent: Thursday, October 10, 2019 6:30 AM
To: catalin.marinas@arm.com; will@kernel.org; rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; sudeep.holla@arm.com; rrichter@marvell.com; jeremy.linton@arm.com
Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linuxarm@huawei.com; gregkh@linuxfoundation.org; guohanjun@huawei.com; wanghuiqiang@huawei.com; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields in Processor Structure Flags

From: Erik Schmauss <erik.schmauss@intel.com>

Commit b5eab512e7cffb2bb37c4b342b5594e9e75fd486 upstream.

ACPICA commit c736ea34add19a3a07e0e398711847cd6b95affd

Link: https://github.com/acpica/acpica/commit/c736ea34
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/acpi/actbl2.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index c50ef7e6b942..1d4ef0621174 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1472,8 +1472,11 @@ struct acpi_pptt_processor {
 
 /* Flags */
 
-#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)	/* Physical package */
-#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (2)	/* ACPI Processor ID valid */
+#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)
+#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (1<<1)
+#define ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD  (1<<2)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_LEAF_NODE            (1<<3)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_IDENTICAL            (1<<4)	/* ACPI 6.3 */
 
 /* 1: Cache Type Structure */
 
--
2.17.1

