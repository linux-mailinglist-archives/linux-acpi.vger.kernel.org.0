Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0445735485C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbhDEVuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:38302 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242401AbhDEVuM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:12 -0400
IronPort-SDR: tTlkDnnCvjoFJp7/gmI4BPRaf3yfQsQAQ06ZdXaO4LUL6b4IQGD5d+Vr59PHupNOzajoCv0UgO
 qrUA7wX0rMbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914972"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: 42gqvYHQmgJYE8QnBsj6T4j6G5VNY5pTQE5rvnA37pJId0BuSxg5m8CPGGj9cZjKeWEfY9v23l
 XiB+ZIpOPYvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673623"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 15/22] ACPICA: ACPI 6.4: PMTT: add new fields/structures
Date:   Mon,  5 Apr 2021 14:15:03 -0700
Message-Id: <20210405211510.484603-16-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 036290735ad8020f762c4d94bcbc0e84b2e307b6

Link: https://github.com/acpica/acpica/commit/03629073
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 53 ++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2ae925fb7728..d8e1db5d5e55 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1410,7 +1410,11 @@ struct acpi_pdtt_channel {
 
 struct acpi_table_pmtt {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 reserved;
+	u32 memory_device_count;
+	/*
+	 * Immediately followed by:
+	 * MEMORY_DEVICE memory_device_struct[memory_device_count];
+	 */
 };
 
 /* Common header for PMTT subtables that follow main table */
@@ -1421,6 +1425,12 @@ struct acpi_pmtt_header {
 	u16 length;
 	u16 flags;
 	u16 reserved2;
+	u32 memory_device_count;	/* Zero means no memory device structs follow */
+	/*
+	 * Immediately followed by:
+	 * u8 type_specific_data[]
+	 * MEMORY_DEVICE memory_device_struct[memory_device_count];
+	 */
 };
 
 /* Values for Type field above */
@@ -1428,7 +1438,8 @@ struct acpi_pmtt_header {
 #define ACPI_PMTT_TYPE_SOCKET           0
 #define ACPI_PMTT_TYPE_CONTROLLER       1
 #define ACPI_PMTT_TYPE_DIMM             2
-#define ACPI_PMTT_TYPE_RESERVED         3	/* 0x03-0xFF are reserved */
+#define ACPI_PMTT_TYPE_RESERVED         3	/* 0x03-0xFE are reserved */
+#define ACPI_PMTT_TYPE_VENDOR           0xFF
 
 /* Values for Flags field above */
 
@@ -1447,37 +1458,43 @@ struct acpi_pmtt_socket {
 	u16 socket_id;
 	u16 reserved;
 };
+	/*
+	 * Immediately followed by:
+	 * MEMORY_DEVICE memory_device_struct[memory_device_count];
+	 */
 
 /* 1: Memory Controller subtable */
 
 struct acpi_pmtt_controller {
 	struct acpi_pmtt_header header;
-	u32 read_latency;
-	u32 write_latency;
-	u32 read_bandwidth;
-	u32 write_bandwidth;
-	u16 access_width;
-	u16 alignment;
+	u16 controller_id;
 	u16 reserved;
-	u16 domain_count;
-};
-
-/* 1a: Proximity Domain substructure */
-
-struct acpi_pmtt_domain {
-	u32 proximity_domain;
 };
+	/*
+	 * Immediately followed by:
+	 * MEMORY_DEVICE memory_device_struct[memory_device_count];
+	 */
 
 /* 2: Physical Component Identifier (DIMM) */
 
 struct acpi_pmtt_physical_component {
 	struct acpi_pmtt_header header;
-	u16 component_id;
-	u16 reserved;
-	u32 memory_size;
 	u32 bios_handle;
 };
 
+/* 0xFF: Vendor Specific Data */
+
+struct acpi_pmtt_vendor_specific {
+	struct acpi_pmtt_header header;
+	u8 type_uuid[16];
+	u8 specific[];
+	/*
+	 * Immediately followed by:
+	 * u8 vendor_specific_data[];
+	 * MEMORY_DEVICE memory_device_struct[memory_device_count];
+	 */
+};
+
 /*******************************************************************************
  *
  * PPTT - Processor Properties Topology Table (ACPI 6.2)
-- 
2.29.2

