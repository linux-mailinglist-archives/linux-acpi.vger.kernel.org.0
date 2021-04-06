Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFADF355E70
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbhDFWFg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243376AbhDFWFa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:30 -0400
IronPort-SDR: YbOqHHY3a4nDcrDnT2iqy5aixKLpX/uJ0dzTc7zu4ZqXNylePE+er+FlQTnAy2p1KtZAkDB7FU
 w3DkV45qLFDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640467"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: uV5iHovWg/FosKOT2Ht6aHqiC4GlpDbVOSMmYBp4F//nF72YuzLIePe5Q4CUlBWVvhaDFSOG2M
 FsBZ9PvRmQyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581752"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Ben Widawsky <ben@bwidawsk.net>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 14/22] ACPICA: CXL 2.0: CEDT: Add new CEDT table
Date:   Tue,  6 Apr 2021 14:30:20 -0700
Message-Id: <20210406213028.718796-15-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Ben Widawsky <ben@bwidawsk.net>

ACPICA commit 0b03aa8ebd7a5b2b9407893f123ee587af45926f

This sets up all of the boilerplate without actually doing anything.

Link: https://github.com/acpica/acpica/commit/0b03aa8e
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl1.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 2ee7eeea783b..7b286766e810 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -28,6 +28,7 @@
 #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
 #define ACPI_SIG_BGRT           "BGRT"	/* Boot Graphics Resource Table */
 #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
+#define ACPI_SIG_CEDT           "CEDT"	/* CXL Early Discovery Table */
 #define ACPI_SIG_CPEP           "CPEP"	/* Corrected Platform Error Polling table */
 #define ACPI_SIG_CSRT           "CSRT"	/* Core System Resource Table */
 #define ACPI_SIG_DBG2           "DBG2"	/* Debug Port table type 2 */
@@ -301,6 +302,48 @@ struct acpi_table_boot {
 	u8 reserved[3];
 };
 
+/*******************************************************************************
+ *
+ * CEDT - CXL Early Discovery Table
+ *        Version 1
+ *
+ * Conforms to the "CXL Early Discovery Table" (CXL 2.0)
+ *
+ ******************************************************************************/
+
+struct acpi_table_cedt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/* CEDT subtable header (Performance Record Structure) */
+
+struct acpi_cedt_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_cedt_type {
+	ACPI_CEDT_TYPE_CHBS = 0,
+};
+
+/*
+ * CEDT subtables
+ */
+
+/* 0: CXL Host Bridge Structure */
+
+struct acpi_cedt_chbs {
+	ACPI_CEDT_HEADER header;
+	u32 uid;
+	u32 cxl_version;
+	u32 reserved;
+	u64 base;
+	u64 length;
+};
+
 /*******************************************************************************
  *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
-- 
2.29.2

