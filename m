Return-Path: <linux-acpi+bounces-19892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9497CE92B3
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58A1300E152
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72D27F73A;
	Tue, 30 Dec 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T/VlAu2y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897052737F2;
	Tue, 30 Dec 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085809; cv=none; b=cEpOt0qA5mN7kXp2QOpB3Gla/Tjunm3WfVEJaSx9obBtW/Mtq8iynWVmcMfvAP5EOw9CLAT1GsE3kL6XKvNMG+GNjt41ZIYsEhoootiD+AeN48Z+59GoWABS0gi6GHGVz8YhnCpD25LPLwS9wCqD+Nan4WcJTBIgKykFPrJmaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085809; c=relaxed/simple;
	bh=mAMoJo+Kvsz4X1OwI4WnPLmPvtxxsXUsrHFJPpVhu38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ea+o2PbvTFCX358KQqv7jqY5ojoz7AZySeOE0UD3yszFXlupi/mKSD6MCfOjNr3zzL4zRzd7fmjDfo8ahE9d8N6wu7jNuUuBp845GrqEUlZELVtvYZdOTL9yQ/499ndR9+ZpiREMnCHK3kjfsFqNcp6ZZ3RfaG77J70NnEIwcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T/VlAu2y; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085797; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=D/vMfRRh7cuvXEtbLHFXnYJZv36RdKpDGNyDigXMmtU=;
	b=T/VlAu2ybZAqRaBwsA6r8RgLKFofe7NVmptsbmiiIS7XZDW8Bfy+6ti/mAbHs4n7OLJCgb6ovBZKcEJp+XxcOxaoCZnfNPYCdGEyTtX7ptuxYgdLlGzYzIPtWOePLNsIcbdbso1OUmB3fT3cbG2A1ItRy6Ptlu/1cmuTbLjyvCs=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzWD78_1767085794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:09:55 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v5 02/17] ras: AEST: Add probe/remove for AEST driver
Date: Tue, 30 Dec 2025 17:09:30 +0800
Message-Id: <20251230090945.43969-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse register information from the AEST table in the probe function,
create corresponding structures, and mappings AEST record.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |   2 +
 drivers/ras/Kconfig          |   1 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/aest/Kconfig     |  17 +++
 drivers/ras/aest/Makefile    |   5 +
 drivers/ras/aest/aest-core.c | 217 +++++++++++++++++++++++++++++++++++
 drivers/ras/aest/aest.h      | 124 ++++++++++++++++++++
 include/linux/acpi_aest.h    |   9 ++
 8 files changed, 376 insertions(+)
 create mode 100644 drivers/ras/aest/Kconfig
 create mode 100644 drivers/ras/aest/Makefile
 create mode 100644 drivers/ras/aest/aest-core.c
 create mode 100644 drivers/ras/aest/aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bfb6f049ea5..e2ffd89c6bb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -346,7 +346,9 @@ M:	Ruidong Tian <tianruidond@linux.alibaba.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
+F:	arch/arm64/include/asm/ras.h
 F:	drivers/acpi/arm64/aest.c
+F:	drivers/ras/aest/
 F:	include/linux/acpi_aest.h
 
 ACPI FOR RISC-V (ACPI/riscv)
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..61a2a05d9c94 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -33,6 +33,7 @@ if RAS
 
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
+source "drivers/ras/aest/Kconfig"
 
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..72411ee9deaf 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RAS_CEC)	+= cec.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
+obj-y 			+= aest/
diff --git a/drivers/ras/aest/Kconfig b/drivers/ras/aest/Kconfig
new file mode 100644
index 000000000000..0b09a5d5acce
--- /dev/null
+++ b/drivers/ras/aest/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ARM Error Source Table Support
+#
+# Copyright (c) 2025, Alibaba Group.
+#
+
+config AEST
+	tristate "ARM AEST Driver"
+	depends on ACPI_AEST && RAS
+
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
new file mode 100644
index 000000000000..a6ba7e36fb43
--- /dev/null
+++ b/drivers/ras/aest/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_AEST) 	+= aest.o
+
+aest-y		:= aest-core.o
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
new file mode 100644
index 000000000000..c7ef6c13fd44
--- /dev/null
+++ b/drivers/ras/aest/aest-core.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/xarray.h>
+#include <linux/ras.h>
+
+#include "aest.h"
+
+DEFINE_PER_CPU(struct aest_device, percpu_adev);
+
+#undef pr_fmt
+#define pr_fmt(fmt) "AEST: " fmt
+
+static int aest_init_record(struct aest_record *record, int i,
+			    struct aest_node *node)
+{
+	struct device *dev = node->adev->dev;
+
+	record->name = devm_kasprintf(dev, GFP_KERNEL, "record%d", i);
+	if (!record->name)
+		return -ENOMEM;
+
+	if (node->base)
+		record->regs_base =
+			node->base + sizeof(struct ras_ext_regs) * i;
+
+	record->addressing_mode = test_bit(i, node->info->addressing_mode);
+	record->index = i;
+	record->node = node;
+
+	aest_record_dbg(record, "base: %p, index: %d, address mode: %x\n",
+			record->regs_base, record->index,
+			record->addressing_mode);
+	return 0;
+}
+
+static void aest_device_remove(struct platform_device *pdev)
+{
+	platform_set_drvdata(pdev, NULL);
+}
+
+static char *alloc_aest_node_name(struct aest_node *node)
+{
+	char *name;
+
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%d",
+				      aest_node_name[node->type],
+				      node->info->processor->processor_id);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+	case ACPI_AEST_PCIE_ERROR_NODE:
+	case ACPI_AEST_PROXY_ERROR_NODE:
+		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%llx",
+				      aest_node_name[node->type],
+				      node->info->interface_hdr->address);
+		break;
+	default:
+		name = devm_kasprintf(node->adev->dev, GFP_KERNEL, "Unknown");
+	}
+
+	return name;
+}
+
+static int aest_node_set_errgsr(struct aest_device *adev,
+				struct aest_node *node)
+{
+	struct acpi_aest_node *anode = node->info;
+	u64 errgsr_base = anode->common->error_group_register_base;
+
+	if (anode->interface_hdr->type != ACPI_AEST_NODE_MEMORY_MAPPED)
+		return 0;
+
+	if (!node->base)
+		return 0;
+
+	if (!(anode->interface_hdr->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
+		node->errgsr = node->base + ERXGROUP;
+		return 0;
+	}
+
+	if (!errgsr_base)
+		return -EINVAL;
+
+	node->errgsr = devm_ioremap(adev->dev, errgsr_base, PAGE_SIZE);
+	if (!node->errgsr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int aest_init_node(struct aest_device *adev, struct aest_node *node,
+			  struct acpi_aest_node *anode)
+{
+	int i, ret;
+	u64 address;
+
+	node->adev = adev;
+	node->info = anode;
+	node->type = anode->type;
+	node->name = alloc_aest_node_name(node);
+	if (!node->name)
+		return -ENOMEM;
+	node->record_implemented = anode->record_implemented;
+	node->status_reporting = anode->status_reporting;
+
+	address = anode->interface_hdr->address;
+	if (address) {
+		node->base = devm_ioremap(adev->dev, address, PAGE_SIZE);
+		if (!node->base)
+			return -ENOMEM;
+	}
+
+	ret = aest_node_set_errgsr(adev, node);
+	if (ret)
+		return ret;
+
+	node->record_count = anode->interface_hdr->error_record_count;
+	node->records = devm_kcalloc(adev->dev, node->record_count,
+				     sizeof(struct aest_record), GFP_KERNEL);
+	if (!node->records)
+		return -ENOMEM;
+
+	for (i = 0; i < node->record_count; i++) {
+		ret = aest_init_record(&node->records[i], i, node);
+		if (ret)
+			return ret;
+	}
+	aest_node_dbg(node, "%d records, base: %llx, errgsr: %llx\n",
+		      node->record_count, (u64)node->base, (u64)node->errgsr);
+	return 0;
+}
+
+static int aest_init_nodes(struct aest_device *adev, struct aest_hnode *ahnode)
+{
+	struct acpi_aest_node *anode;
+	struct aest_node *node;
+	int ret, i = 0;
+
+	adev->node_cnt = ahnode->count;
+	adev->nodes = devm_kcalloc(adev->dev, adev->node_cnt,
+				   sizeof(struct aest_node), GFP_KERNEL);
+	if (!adev->nodes)
+		return -ENOMEM;
+
+	list_for_each_entry(anode, &ahnode->list, list) {
+		adev->type = anode->type;
+
+		node = &adev->nodes[i++];
+		ret = aest_init_node(adev, node, anode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aest_device_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct aest_device *adev;
+	struct aest_hnode *ahnode;
+
+	ahnode = *((struct aest_hnode **)pdev->dev.platform_data);
+	if (!ahnode)
+		return -ENODEV;
+
+	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->dev = &pdev->dev;
+	adev->id = pdev->id;
+	aest_set_name(adev, ahnode);
+	ret = aest_init_nodes(adev, ahnode);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, adev);
+
+	aest_dev_dbg(adev, "Node cnt: %x, id: %x\n", adev->node_cnt, adev->id);
+
+	return 0;
+}
+
+static struct platform_driver aest_driver = {
+	.driver	= {
+		.name	= "AEST",
+	},
+	.probe	= aest_device_probe,
+	.remove = aest_device_remove,
+};
+
+static int __init aest_init(void)
+{
+	return platform_driver_register(&aest_driver);
+}
+module_init(aest_init);
+
+static void __exit aest_exit(void)
+{
+	platform_driver_unregister(&aest_driver);
+}
+module_exit(aest_exit);
+
+MODULE_DESCRIPTION("ARM AEST Driver");
+MODULE_AUTHOR("Ruidong Tian <tianruidong@linux.alibaba.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
new file mode 100644
index 000000000000..d918240c3f57
--- /dev/null
+++ b/drivers/ras/aest/aest.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/acpi_aest.h>
+#include <asm/ras.h>
+
+#define MAX_GSI_PER_NODE 2
+
+#define aest_dev_err(__adev, format, ...) \
+	dev_err((__adev)->dev, format, ##__VA_ARGS__)
+#define aest_dev_info(__adev, format, ...) \
+	dev_info((__adev)->dev, format, ##__VA_ARGS__)
+#define aest_dev_dbg(__adev, format, ...) \
+	dev_dbg((__adev)->dev, format, ##__VA_ARGS__)
+
+#define aest_node_err(__node, format, ...)                          \
+	dev_err((__node)->adev->dev, "%s: " format, (__node)->name, \
+		##__VA_ARGS__)
+#define aest_node_info(__node, format, ...)                          \
+	dev_info((__node)->adev->dev, "%s: " format, (__node)->name, \
+		 ##__VA_ARGS__)
+#define aest_node_dbg(__node, format, ...)                          \
+	dev_dbg((__node)->adev->dev, "%s: " format, (__node)->name, \
+		##__VA_ARGS__)
+
+#define aest_record_err(__record, format, ...)                  \
+	dev_err((__record)->node->adev->dev, "%s: %s: " format, \
+		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
+#define aest_record_info(__record, format, ...)                  \
+	dev_info((__record)->node->adev->dev, "%s: %s: " format, \
+		 (__record)->node->name, (__record)->name, ##__VA_ARGS__)
+#define aest_record_dbg(__record, format, ...)                  \
+	dev_dbg((__record)->node->adev->dev, "%s: %s: " format, \
+		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
+
+#define ERXGROUP 0xE00
+
+struct aest_record {
+	char *name;
+	int index;
+	void __iomem *regs_base;
+
+	/*
+	 * This bit specifies the addressing mode  to populate the ERR_ADDR
+	 * register:
+	 *   0b: Error record reports System Physical Addresses (SPA) in
+	 *       the ERR_ADDR register.
+	 *   1b: Error record reports error node-specific Logical Addresses(LA)
+	 *       in the ERR_ADD register. OS must use other means to translate
+	 *       the reported LA into SPA
+	 */
+	int addressing_mode;
+	struct aest_node *node;
+};
+
+struct aest_node {
+	char *name;
+	u8 type;
+	void *errgsr;
+	void *base;
+
+	/*
+	 * This bitmap indicates which of the error records within this error
+	 * node must be polled for error status.
+	 * Bit[n] of this field pertains to error record corresponding to
+	 * index n in this error group.
+	 * Bit[n] = 0b: Error record at index n needs to be polled.
+	 * Bit[n] = 1b: Error record at index n do not needs to be polled.
+	 */
+	unsigned long *record_implemented;
+	/*
+	 * This bitmap indicates which of the error records within this error
+	 * node support error status reporting using ERRGSR register.
+	 * Bit[n] of this field pertains to error record corresponding to
+	 * index n in this error group.
+	 * Bit[n] = 0b: Error record at index n supports error status reporting
+	 *              through ERRGSR.S.
+	 * Bit[n] = 1b: Error record at index n does not support error reporting
+	 *              through the ERRGSR.S bit If this error record is
+	 *              implemented, then it must be polled explicitly for
+	 *              error events.
+	 */
+	unsigned long *status_reporting;
+
+	struct aest_device *adev;
+	struct acpi_aest_node *info;
+
+	int record_count;
+	struct aest_record *records;
+};
+
+struct aest_device {
+	struct device *dev;
+	u32 type;
+	int node_cnt;
+	struct aest_node *nodes;
+	u32 id;
+};
+
+static const char *const aest_node_name[] = {
+	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
+	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
+	[ACPI_AEST_SMMU_ERROR_NODE] = "smmu",
+	[ACPI_AEST_VENDOR_ERROR_NODE] = "vendor",
+	[ACPI_AEST_GIC_ERROR_NODE] = "gic",
+	[ACPI_AEST_PCIE_ERROR_NODE] = "pcie",
+	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
+};
+
+static inline int aest_set_name(struct aest_device *adev,
+				struct aest_hnode *ahnode)
+{
+	adev->dev->init_name = devm_kasprintf(adev->dev, GFP_KERNEL, "%s%d",
+					      aest_node_name[ahnode->type],
+					      adev->id);
+	if (!adev->dev->init_name)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
index 53c1970e7583..77187ce43d44 100644
--- a/include/linux/acpi_aest.h
+++ b/include/linux/acpi_aest.h
@@ -15,6 +15,15 @@
 
 #define AEST_MAX_INTERRUPT_PER_NODE 2
 
+/* AEST interface */
+#define AEST_XFACE_FLAG_SHARED (1 << 0)
+#define AEST_XFACE_FLAG_CLEAR_MISC (1 << 1)
+#define AEST_XFACE_FLAG_ERROR_DEVICE (1 << 2)
+#define AEST_XFACE_FLAG_AFFINITY (1 << 3)
+#define AEST_XFACE_FLAG_ERROR_GROUP (1 << 4)
+#define AEST_XFACE_FLAG_FAULT_INJECT (1 << 5)
+#define AEST_XFACE_FLAG_INT_CONFIG (1 << 6)
+
 #define KB 1024
 #define MB (1024 * KB)
 #define GB (1024 * MB)
-- 
2.47.3


