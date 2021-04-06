Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B17355E66
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhDFWFX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:51781 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242361AbhDFWFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:19 -0400
IronPort-SDR: WiHmcdmtoh4tFZrG0BVk6SC4ULIvPe18HstGCPK9Vo0XIbQRNXglOgIp3eA/5YZ/XVc2m67Nxd
 0sgX8iYJ8rCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="173244343"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="173244343"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: qz5ZXxdNt9QFpNnnDotwZlVTe3Omf0GPkWoJYd3/MIyR3huDfIn5M0lmneAqLrG2QzWMbNu49D
 +C22Uez7HXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581749"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 13/22] ACPICA: iASL: Add definitions for the VIOT table
Date:   Tue,  6 Apr 2021 14:30:19 -0700
Message-Id: <20210406213028.718796-14-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

ACPICA commit fc4e33319c1ee08f20f5c44853dd8426643f6dfd

Add definitions for the VIOT table and its subtables.

Link: https://github.com/acpica/acpica/commit/fc4e3331
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index bf61a70deb22..e9bd7ce65f7c 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -33,6 +33,7 @@
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Translation Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
@@ -484,6 +485,71 @@ struct acpi_table_uefi {
 	u16 data_offset;	/* Offset of remaining data in table */
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Translation Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 node_count;
+	u16 node_offset;
+	u8 reserved[8];
+};
+
+/* VIOT subtable header */
+
+struct acpi_viot_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_viot_node_type {
+	ACPI_VIOT_NODE_PCI_RANGE = 0x01,
+	ACPI_VIOT_NODE_MMIO = 0x02,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
+};
+
+/* VIOT subtables */
+
+struct acpi_viot_pci_range {
+	ACPI_VIOT_HEADER header;
+	u32 endpoint_start;
+	u16 segment_start;
+	u16 segment_end;
+	u16 bdf_start;
+	u16 bdf_end;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_mmio {
+	ACPI_VIOT_HEADER header;
+	u32 endpoint;
+	u64 base_address;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_virtio_iommu_pci {
+	ACPI_VIOT_HEADER header;
+	u16 segment;
+	u16 bdf;
+	u8 reserved[8];
+};
+
+struct acpi_viot_virtio_iommu_mmio {
+	ACPI_VIOT_HEADER header;
+	u8 reserved[4];
+	u64 base_address;
+};
+
 /*******************************************************************************
  *
  * WAET - Windows ACPI Emulated devices Table
-- 
2.29.2

