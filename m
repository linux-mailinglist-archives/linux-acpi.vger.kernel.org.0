Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F53107A33
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 22:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKVVtG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 22 Nov 2019 16:49:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:61158 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVVtG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 16:49:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 13:49:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="219591918"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2019 13:49:06 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 13:49:05 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.52]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.11]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 13:49:05 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     zhengbin <zhengbin13@huawei.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Topic: [PATCH] ACPICA: Use ARRAY_SIZE for
 'fadt_info_table','fadt_pm_info_table'
Thread-Index: AQHVoRboulD/DOKym0m5GPkUUMHHlKeXuvow
Date:   Fri, 22 Nov 2019 21:49:05 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A5A@ORSMSX110.amr.corp.intel.com>
References: <1574415183-19322-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1574415183-19322-1-git-send-email-zhengbin13@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDEzM2NmMTUtMDFjMy00NDQ3LWI5YzgtYzU2ZGZjMWY3YTVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidXhvXC9jYk9zUDd5ZmhXeEpIYm9nRXNCdW5rQkh1UWNRWU1uemRWa3Zxd1hERWJhRDZ3cWt0THByVWN5Q1NVSTQifQ==
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

Where does "ARRAY_SIZE" come from? It's not a part of ACPICA.
Bob


-----Original Message-----
From: zhengbin <zhengbin13@huawei.com> 
Sent: Friday, November 22, 2019 1:33 AM
To: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org
Cc: zhengbin13@huawei.com
Subject: [PATCH] ACPICA: Use ARRAY_SIZE for 'fadt_info_table','fadt_pm_info_table'

Fixes coccicheck warning:

drivers/acpi/acpica/tbfadt.c:107:27-28: WARNING: Use ARRAY_SIZE
drivers/acpi/acpica/tbfadt.c:137:30-31: WARNING: Use ARRAY_SIZE

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/acpi/acpica/tbfadt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c index 0041bfb..324a804 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -103,8 +103,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}  };

-#define ACPI_FADT_INFO_ENTRIES \
-			(sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
+#define ACPI_FADT_INFO_ENTRIES (ARRAY_SIZE(fadt_info_table))

 /* Table used to split Event Blocks into separate status/enable registers */

@@ -133,8 +132,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
 	 1}
 };

-#define ACPI_FADT_PM_INFO_ENTRIES \
-			(sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
+#define ACPI_FADT_PM_INFO_ENTRIES (ARRAY_SIZE(fadt_pm_info_table))

 /*******************************************************************************
  *
--
2.7.4

