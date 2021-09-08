Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF6403287
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Sep 2021 04:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbhIHCPb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 22:15:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:61320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235450AbhIHCPb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 22:15:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="200567464"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="200567464"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 19:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="503326869"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.132])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2021 19:14:22 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, pmenzel@molgen.mpg.de
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH] ACPI/PRM: Find PRMT table before parse it
Date:   Wed,  8 Sep 2021 10:09:44 +0800
Message-Id: <1631066984-63501-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Find and verify PRMT table before parse it, this eliminates a
warning on machines without PRMT table.

	[    7.197173] ACPI: PRMT not present

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
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

