Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C239C319
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFDWCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:48296 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhFDWCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:45 -0400
IronPort-SDR: bE8WDwFpX0r5r6sjDbsgI1HjfXYVe+LPFZlVBva+aTsPlprc+WIxGIqeiW+T6LSqaysrhQj24e
 HtrXkDReg8iw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="191710783"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="191710783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:57 -0700
IronPort-SDR: I5EgzBdSvLjsDfC8v9s+0VCjT5y2S000r96OtNZOA+swvHRwbpM2k0WWSnGVV6VoeXzavGgWgB
 cpmajbNHPWXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146734"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 12/14] ACPICA: iASL: add disassembler support for PRMT
Date:   Fri,  4 Jun 2021 14:26:06 -0700
Message-Id: <20210604212608.2604267-13-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit f70e7593e37c9e29f19be8ad3ef93f3f34799368

Link: https://github.com/acpica/acpica/commit/f70e7593
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 68a607961b2f..05b086d4d94a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -40,6 +40,7 @@
 #define ACPI_SIG_PHAT           "PHAT"	/* Platform Health Assessment Table */
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
+#define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
@@ -1710,6 +1711,43 @@ struct acpi_pptt_id {
 	u16 spin_rev;
 };
 
+/*******************************************************************************
+ *
+ * PRMT - Platform Runtime Mechanism Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_prmt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+struct acpi_table_prmt_header {
+	u8 platform_guid[16];
+	u32 module_info_offset;
+	u32 module_info_count;
+};
+
+struct acpi_prmt_module_info {
+	u16 revision;
+	u16 length;
+	u8 module_guid[16];
+	u16 major_rev;
+	u16 minor_rev;
+	u16 handler_info_count;
+	u32 handler_info_offset;
+	u64 mmio_list_pointer;
+};
+
+struct acpi_prmt_handler_info {
+	u16 revision;
+	u16 length;
+	u8 handler_guid[16];
+	u64 handler_address;
+	u64 static_data_buffer_address;
+	u64 acpi_param_buffer_address;
+};
+
 /*******************************************************************************
  *
  * RASF - RAS Feature Table (ACPI 5.0)
-- 
2.29.2

