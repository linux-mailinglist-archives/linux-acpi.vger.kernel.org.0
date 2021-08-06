Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E023E2037
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbhHFAsf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:16378 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242437AbhHFAsd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="194555147"
X-IronPort-AV: E=Sophos;i="5.84,299,1620716400"; 
   d="scan'208";a="194555147"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 17:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,299,1620716400"; 
   d="scan'208";a="442714638"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.132])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2021 17:48:16 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH] ACPI/PRM: Deal with table not present or no module found
Date:   Fri,  6 Aug 2021 08:46:24 +0800
Message-Id: <1628210784-136676-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On the system PRMT table is not present, dmesg output:

	$ dmesg | grep PRM
	[    1.532237] ACPI: PRMT not present
	[    1.532237] PRM: found 4294967277 modules

The result of acpi_table_parse_entries need to be checked and return
immediately if PRMT table is not present or no PRM module found.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/acpi/prmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 31cf9ae..1f6007a 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -292,6 +292,12 @@ void __init init_prmt(void)
 	int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
 					  sizeof (struct acpi_table_prmt_header),
 					  0, acpi_parse_prmt, 0);
+	/*
+	 * Return immediately if PRMT table is not present or no PRM module found.
+	 */
+	if (mc <= 0)
+		return;
+
 	pr_info("PRM: found %u modules\n", mc);
 
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
-- 
2.7.4

