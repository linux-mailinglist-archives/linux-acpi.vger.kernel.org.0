Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7B402278
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 05:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhIGD2c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Sep 2021 23:28:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:34706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhIGD2c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Sep 2021 23:28:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218223060"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="218223060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 20:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="502739730"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2021 20:27:23 -0700
Subject: Re: New warning: PRMT not found
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
 <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
 <CAJZ5v0i91+kPe4C-wy+oCDvYbR_Vp=MzwEyL+8T3xJU5O4XjRA@mail.gmail.com>
 <c6aaf684-2cd1-f615-34e1-7ef2020ae2d2@molgen.mpg.de>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <54b6f8cb-4714-587c-b2d0-98134473293d@linux.intel.com>
Date:   Tue, 7 Sep 2021 11:26:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6aaf684-2cd1-f615-34e1-7ef2020ae2d2@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Paul,

On 9/6/21 10:15 PM, Paul Menzel wrote:
> Dear Rafael, dear Aubrey,
> 
> 
> Thank you for replying.
> 
> 
> Am 06.09.21 um 14:02 schrieb Rafael J. Wysocki:
>>
>> This should be addressed by commit 2bbfa0addd63 "ACPI: PRM: Deal with
>> table not present or no module found", or yet another fix is needed.
> 
> Linux still warns on my systems with Linux 5.14 and Linus’ master in QEMU i440fx and an Asus F2A85-M PRO.

Does the following patch address your problem?

Thanks,
-Aubrey

----------------------------------------------------------------------
From 52fda76410fcb7a3661687e960634d34fa44fb5f Mon Sep 17 00:00:00 2001
From: Aubrey Li <aubrey.li@intel.com>
Date: Tue, 7 Sep 2021 11:06:59 +0800
Subject: [PATCH] ACPI/RPM: Find PRMT table before parse it

Find and verify PRMT table before parse it, this eliminates a
warning on machines without PRMT table.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/acpi/prmt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1f6007a..89c22bc 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -288,10 +288,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 
 void __init init_prmt(void)
 {
+	struct acpi_table_header *tbl;
 	acpi_status status;
-	int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
+	int mc;
+
+	status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
+	if (ACPI_FAILURE(status))
+		return;
+
+	mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
 					  sizeof (struct acpi_table_prmt_header),
 					  0, acpi_parse_prmt, 0);
+	acpi_put_table(tbl);
 	/*
 	 * Return immediately if PRMT table is not present or no PRM module found.
 	 */
-- 
2.7.4

