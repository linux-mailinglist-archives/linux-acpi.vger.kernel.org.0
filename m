Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6093C3452CD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCVXKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 19:10:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:20269 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhCVXJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 19:09:39 -0400
IronPort-SDR: H5grCUC5XridzWYU9YqUvRLKASVC0FJCpJhrKFLubj2ssl1ozfz11E44dC1QPq+N7zHSaW3kgs
 OIbWO/XmVO6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251718882"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251718882"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:09:37 -0700
IronPort-SDR: wYVmKeg8Xd0M1rXiJB3+IgeTYRcJVGdqZbT+Pau1KEvpPS0csk2tft1dHGaRLHihBYfC6xG3g/
 lzPWfyy9Q+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607510496"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2021 16:09:37 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v3 1/4] ACPICA: iASL: add disassembler support for PRMT
Date:   Mon, 22 Mar 2021 15:37:04 -0700
Message-Id: <20210322223707.1838823-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322223707.1838823-1-erik.kaneda@intel.com>
References: <20210322223707.1838823-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d6478c430c99..3b6434fc3f3c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -38,6 +38,7 @@
 #define ACPI_SIG_PDTT           "PDTT"	/* Platform Debug Trigger Table */
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
+#define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
@@ -1528,6 +1529,45 @@ struct acpi_pptt_id {
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
+	struct acpi_table_header header;
+	u8 platform_guid[16];
+	u32 module_offset;
+	u32 module_count;
+};
+
+struct acpi_prmt_module_header {
+	u16 revision;
+	u16 length;
+};
+
+struct acpi_prmt_module_info {
+	u16 revision;
+	u16 length;
+	u8 guid[16];
+	u16 major_rev;
+	u16 minor_rev;
+	u16 handler_count;
+	u32 handler_offset;
+	u64 mmio_list_pointer;
+};
+
+struct acpi_prmt_handler_info {
+	u16 revision;
+	u16 length;
+	u8 guid[16];
+	u64 address;
+	u64 static_data_buffer_address;
+	u64 acpi_param_buffer_address;
+};
+
 /*******************************************************************************
  *
  * RASF - RAS Feature Table (ACPI 5.0)
-- 
2.29.2

