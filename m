Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282D354858
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhDEVuO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:26882 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242300AbhDEVuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:11 -0400
IronPort-SDR: yuSgFBtbZQFCeJnE3UTLOmR/3TU7FQgiiUyC04mq4KydYruU6FmYZmqP5hdvItueYbLKkdmrt/
 gDZzWnaj0PRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278759"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: kyOlIPsr93IHvQODYc7pNNDs16w3UBuFKm4VMgOQAoeFoZx1UkMILdw+5Z8aVR2DL7nym1/QnZ
 tP0Fa38X3Tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673615"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 13/22] ACPICA: iASL: Add definitions for the VIOT table
Date:   Mon,  5 Apr 2021 14:15:01 -0700
Message-Id: <20210405211510.484603-14-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

