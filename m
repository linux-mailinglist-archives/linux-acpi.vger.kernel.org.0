Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3D355E71
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhDFWFk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:54929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243450AbhDFWFa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:30 -0400
IronPort-SDR: dI4IAsukTxkldO8l/y1x37n4VvNjjqLREF6UcKI6d/bGjmPW5UyIIHg3hqbbJwodSaVdDdCDws
 ThGSrpAM8f6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640468"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: RSX4a/Jw5kjr5TzFPmsOAcJYcEUTZTyTRZhdHCaoBsIJCocif3JdItFs2Lt6On7WGC6Zoz0j2i
 hyJHzo5MOEUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581758"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:09 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 17/22] ACPICA: ACPI 6.4: add support for PHAT table
Date:   Tue,  6 Apr 2021 14:30:23 -0700
Message-Id: <20210406213028.718796-18-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit de805b6a355c01f3aff4044a4ba60e9845b7668c

This table displays health information about the platform firmware. For
full definition, see the ACPI specification.

Link: https://github.com/acpica/acpica/commit/de805b6a
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 61 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d8e1db5d5e55..8383446295a5 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -36,6 +36,7 @@
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
 #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
 #define ACPI_SIG_PDTT           "PDTT"	/* Platform Debug Trigger Table */
+#define ACPI_SIG_PHAT           "PHAT"	/* Platform Health Assessment Table */
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
@@ -1401,6 +1402,66 @@ struct acpi_pdtt_channel {
 #define ACPI_PDTT_WAIT_COMPLETION           (1<<1)
 #define ACPI_PDTT_TRIGGER_ORDER             (1<<2)
 
+/*******************************************************************************
+ *
+ * PHAT - Platform Health Assessment Table (ACPI 6.4)
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_phat {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/* Common header for PHAT subtables that follow main table */
+
+struct acpi_phat_header {
+	u16 type;
+	u16 length;
+	u8 revision;
+};
+
+/* Values for Type field above */
+
+#define ACPI_PHAT_TYPE_FW_VERSION_DATA  0
+#define ACPI_PHAT_TYPE_FW_HEALTH_DATA   1
+#define ACPI_PHAT_TYPE_RESERVED         2	/* 0x02-0xFFFF are reserved */
+
+/*
+ * PHAT subtables, correspond to Type in struct acpi_phat_header
+ */
+
+/* 0: Firmware Version Data Record */
+
+struct acpi_phat_version_data {
+	struct acpi_phat_header header;
+	u8 reserved[3];
+	u32 element_count;
+};
+
+struct acpi_phat_version_element {
+	u8 guid[16];
+	u64 version_value;
+	u32 producer_id;
+};
+
+/* 1: Firmware Health Data Record */
+
+struct acpi_phat_health_data {
+	struct acpi_phat_header header;
+	u8 reserved[2];
+	u8 health;
+	u8 device_guid[16];
+	u32 device_specific_offset;	/* Zero if no Device-specific data */
+};
+
+/* Values for Health field above */
+
+#define ACPI_PHAT_ERRORS_FOUND          0
+#define ACPI_PHAT_NO_ERRORS             1
+#define ACPI_PHAT_UNKNOWN_ERRORS        2
+#define ACPI_PHAT_ADVISORY              3
+
 /*******************************************************************************
  *
  * PMTT - Platform Memory Topology Table (ACPI 5.0)
-- 
2.29.2

