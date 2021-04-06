Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF70355E6F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbhDFWFc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243422AbhDFWF0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:26 -0400
IronPort-SDR: YjpdSrGO6+WHJxfYDZg2yB/K74KYczHREhrMmrolRY+ZBsEdA8r7cXz37NEBrSndGnTJmI3ZXQ
 IepF3XBaLXZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640464"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: NmTK/mRlK8qwzKdwS0mDME9QT74DL21zT5duGGLyVLtqnLoz+tamEVT5Fm/FM09DFqcqEUtWA9
 EUAhH6goWDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581745"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 12/22] ACPICA: ACPI 6.4: add SDEV secure access components
Date:   Tue,  6 Apr 2021 14:30:18 -0700
Message-Id: <20210406213028.718796-13-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
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

