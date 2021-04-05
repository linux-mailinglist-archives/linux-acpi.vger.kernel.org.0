Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413235484F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbhDEVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:38284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237567AbhDEVuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:07 -0400
IronPort-SDR: q/GzqGe6GY5XLUow5bpUQJtF/0LDqFj92JVEAiYBP18AJKuZTsnBJHzd3w9Z89XEHNR+lPQO3b
 ONTgPeE2YMqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914965"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: 3gXBhpDfiwb0HFEABHfHheHeaKyibORZ5woPYMIO5uMMaUhXCdDqkdx1KU7ziJdvkyFSlFbSo2
 9zaxR4XLjQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673607"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 12/22] ACPICA: ACPI 6.4: add SDEV secure access components
Date:   Mon,  5 Apr 2021 14:15:00 -0700
Message-Id: <20210405211510.484603-13-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 44ca5f4f9be24bf64524cdb1de46322509319056

This entails adding an optional subtable indicating secure access
components as well as two different types of secure access components
(ID-based or Memory). For definitons and uses, consult the ACPI
specification.

Link: https://github.com/acpica/acpica/commit/44ca5f4f
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 31ed30208c8a..2ae925fb7728 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1732,6 +1732,7 @@ enum acpi_sdev_type {
 /* Values for flags above */
 
 #define ACPI_SDEV_HANDOFF_TO_UNSECURE_OS    (1)
+#define ACPI_SDEV_SECURE_COMPONENTS_PRESENT (1<<1)
 
 /*
  * SDEV subtables
@@ -1747,6 +1748,46 @@ struct acpi_sdev_namespace {
 	u16 vendor_data_length;
 };
 
+struct acpi_sdev_secure_component {
+	u16 secure_component_offset;
+	u16 secure_component_length;
+};
+
+/*
+ * SDEV sub-subtables ("Components") for above
+ */
+struct acpi_sdev_component {
+	struct acpi_sdev_header header;
+};
+
+/* Values for sub-subtable type above */
+
+enum acpi_sac_type {
+	ACPI_SDEV_TYPE_ID_COMPONENT = 0,
+	ACPI_SDEV_TYPE_MEM_COMPONENT = 1
+};
+
+struct acpi_sdev_id_component {
+	struct acpi_sdev_header header;
+	u16 hardware_id_offset;
+	u16 hardware_id_length;
+	u16 subsystem_id_offset;
+	u16 subsystem_id_length;
+	u16 hardware_revision;
+	u8 hardware_rev_present;
+	u8 class_code_present;
+	u8 pci_base_class;
+	u8 pci_sub_class;
+	u8 pci_programming_xface;
+};
+
+struct acpi_sdev_mem_component {
+	struct acpi_sdev_header header;
+	u32 reserved;
+	u64 memory_base_address;
+	u64 memory_length;
+};
+
 /* 1: PCIe Endpoint Device Based Device Structure */
 
 struct acpi_sdev_pcie {
-- 
2.29.2

