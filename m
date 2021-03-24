Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA273483A8
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 22:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhCXVac (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 17:30:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:32604 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238368AbhCXVab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 17:30:31 -0400
IronPort-SDR: CeZIPP6KRbx5Gx2Pa1zMXWBqoHYhc2sgROrwdGFZAYPwWPCcq9N6ycUe1APN1vpfEsVVlyD2G3
 Bp8Nt9SSMoqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178343998"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178343998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:30 -0700
IronPort-SDR: givUmYSB9sMX/pM8eTqe4OEq4ApwEarIeoxhQktMm/caVih0tfVBBYs0n5Sc3j9E08v4sY0Epv
 7VwIr9sSRtbw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="442425792"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:29 -0700
Subject: [PATCH 1/8] cxl/mem: Move some definitions to mem.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:30:29 -0700
Message-ID: <161662142918.1723715.7277721673646893637.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for sharing cxl.h with other generic CXL consumers,
move / consolidate some of the memory device specifics to mem.h.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   57 ------------------------------------
 drivers/cxl/mem.c |   25 +---------------
 drivers/cxl/mem.h |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 81 deletions(-)
 create mode 100644 drivers/cxl/mem.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f14838c2d25..2e3bdacb32e7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -34,62 +34,5 @@
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
-#define CXLMDEV_STATUS_OFFSET 0x0
-#define   CXLMDEV_DEV_FATAL BIT(0)
-#define   CXLMDEV_FW_HALT BIT(1)
-#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
-#define     CXLMDEV_MS_NOT_READY 0
-#define     CXLMDEV_MS_READY 1
-#define     CXLMDEV_MS_ERROR 2
-#define     CXLMDEV_MS_DISABLED 3
-#define CXLMDEV_READY(status)                                                  \
-	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
-	 CXLMDEV_MS_READY)
-#define   CXLMDEV_MBOX_IF_READY BIT(4)
-#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
-#define     CXLMDEV_RESET_NEEDED_NOT 0
-#define     CXLMDEV_RESET_NEEDED_COLD 1
-#define     CXLMDEV_RESET_NEEDED_WARM 2
-#define     CXLMDEV_RESET_NEEDED_HOT 3
-#define     CXLMDEV_RESET_NEEDED_CXL 4
-#define CXLMDEV_RESET_NEEDED(status)                                           \
-	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
-	 CXLMDEV_RESET_NEEDED_NOT)
-
-struct cxl_memdev;
-/**
- * struct cxl_mem - A CXL memory device
- * @pdev: The PCI device associated with this CXL device.
- * @regs: IO mappings to the device's MMIO
- * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
- * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
- * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
- * @payload_size: Size of space for payload
- *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
- * @mbox_mutex: Mutex to synchronize mailbox access.
- * @firmware_version: Firmware version for the memory device.
- * @enabled_commands: Hardware commands found enabled in CEL.
- * @pmem_range: Persistent memory capacity information.
- * @ram_range: Volatile memory capacity information.
- */
-struct cxl_mem {
-	struct pci_dev *pdev;
-	void __iomem *regs;
-	struct cxl_memdev *cxlmd;
-
-	void __iomem *status_regs;
-	void __iomem *mbox_regs;
-	void __iomem *memdev_regs;
-
-	size_t payload_size;
-	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
-	char firmware_version[0x10];
-	unsigned long *enabled_cmds;
-
-	struct range pmem_range;
-	struct range ram_range;
-};
-
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..45871ef65152 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -12,6 +12,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "pci.h"
 #include "cxl.h"
+#include "mem.h"
 
 /**
  * DOC: cxl mem
@@ -29,12 +30,6 @@
  *  - Handle and manage error conditions.
  */
 
-/*
- * An entire PCI topology full of devices should be enough for any
- * config
- */
-#define CXL_MEM_MAX_DEVS 65536
-
 #define cxl_doorbell_busy(cxlm)                                                \
 	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
@@ -91,24 +86,6 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
-/**
- * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
- * @dev: driver core device object
- * @cdev: char dev core object for ioctl operations
- * @cxlm: pointer to the parent device driver data
- * @ops_active: active user of @cxlm in ops handlers
- * @ops_dead: completion when all @cxlm ops users have exited
- * @id: id number of this memdev instance.
- */
-struct cxl_memdev {
-	struct device dev;
-	struct cdev cdev;
-	struct cxl_mem *cxlm;
-	struct percpu_ref ops_active;
-	struct completion ops_dead;
-	int id;
-};
-
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 static struct dentry *cxl_debugfs;
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
new file mode 100644
index 000000000000..daa9aba0e218
--- /dev/null
+++ b/drivers/cxl/mem.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020-2021 Intel Corporation. */
+#ifndef __CXL_MEM_H__
+#define __CXL_MEM_H__
+
+/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
+#define CXLMDEV_STATUS_OFFSET 0x0
+#define   CXLMDEV_DEV_FATAL BIT(0)
+#define   CXLMDEV_FW_HALT BIT(1)
+#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
+#define     CXLMDEV_MS_NOT_READY 0
+#define     CXLMDEV_MS_READY 1
+#define     CXLMDEV_MS_ERROR 2
+#define     CXLMDEV_MS_DISABLED 3
+#define CXLMDEV_READY(status)                                                  \
+	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
+	 CXLMDEV_MS_READY)
+#define   CXLMDEV_MBOX_IF_READY BIT(4)
+#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
+#define     CXLMDEV_RESET_NEEDED_NOT 0
+#define     CXLMDEV_RESET_NEEDED_COLD 1
+#define     CXLMDEV_RESET_NEEDED_WARM 2
+#define     CXLMDEV_RESET_NEEDED_HOT 3
+#define     CXLMDEV_RESET_NEEDED_CXL 4
+#define CXLMDEV_RESET_NEEDED(status)                                           \
+	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
+	 CXLMDEV_RESET_NEEDED_NOT)
+
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
+
+/**
+ * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
+ * @dev: driver core device object
+ * @cdev: char dev core object for ioctl operations
+ * @cxlm: pointer to the parent device driver data
+ * @ops_active: active user of @cxlm in ops handlers
+ * @ops_dead: completion when all @cxlm ops users have exited
+ * @id: id number of this memdev instance.
+ */
+struct cxl_memdev {
+	struct device dev;
+	struct cdev cdev;
+	struct cxl_mem *cxlm;
+	struct percpu_ref ops_active;
+	struct completion ops_dead;
+	int id;
+};
+
+/**
+ * struct cxl_mem - A CXL memory device
+ * @pdev: The PCI device associated with this CXL device.
+ * @regs: IO mappings to the device's MMIO
+ * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
+ * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
+ * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
+ * @payload_size: Size of space for payload
+ *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
+ * @mbox_mutex: Mutex to synchronize mailbox access.
+ * @firmware_version: Firmware version for the memory device.
+ * @enabled_commands: Hardware commands found enabled in CEL.
+ * @pmem_range: Persistent memory capacity information.
+ * @ram_range: Volatile memory capacity information.
+ */
+struct cxl_mem {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+	struct cxl_memdev *cxlmd;
+
+	void __iomem *status_regs;
+	void __iomem *mbox_regs;
+	void __iomem *memdev_regs;
+
+	size_t payload_size;
+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
+	char firmware_version[0x10];
+	unsigned long *enabled_cmds;
+
+	struct range pmem_range;
+	struct range ram_range;
+};
+#endif /* __CXL_MEM_H__ */

