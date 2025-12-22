Return-Path: <linux-acpi+bounces-19752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D49CD55DA
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A684302DB78
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AA3126AD;
	Mon, 22 Dec 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nyCCavHy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B8311C30;
	Mon, 22 Dec 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396655; cv=none; b=bGyixFTiZxu8V8A+J6bAC5u20UAeQAWTTrFD7yo82yFZyZWrqsFgt7MpxWsB+kmXKte4GOn7vQF5LyKv/GOwpxKt5maGzF+ummdILjZ2Ejmji8yzL3Gijt5rXo5pEt8fQ+4L4n4KijedR8QTiM9SKBrc8o4rSxbAHnmOlyYioe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396655; c=relaxed/simple;
	bh=3UZPwYH8jgDt6dtKfmeGwXN/LtEOMTxSj4/4eXEp06I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STGCTki4oBZVA45WzHREZoMkUamhr/LHeu/YeebYF5hsLiWauPLIOLVip4icTrw3c5SNAwohfxh3qqc52CHgp1kSRWX9BQ9IlIrVQs4i/xf3CeCvvhRWe9tU6O162T2aSkrsySG1CG0Xeau6WcsLok6C2M6jBtUWT6vkomUl4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nyCCavHy; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396643; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=whDmWcH3uDX5oRzSiAIt8oU0lHiZyCFY96vsTOMyc4k=;
	b=nyCCavHy7KT3DvPf335c9edMmAg25aI/dQGRYnhttEU+GIAAxxyiNuWor6+sO1frx1amVhcYS/S/rgr1WmWo6R+31H88e8VcjC61O37+0CfXIM8seEwZWvrv8y1F+UUrOGVWHbAVCQH3Qhpv5B8cNTCm7Mmgo3b3B4iyETF8Bj4=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvOl8-C_1766396641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:02 +0800
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
	misono.tomohiro@fujitsu.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v4 01/17] ACPI/AEST: Parse the AEST table
Date: Mon, 22 Dec 2025 17:43:34 +0800
Message-Id: <20251222094351.38792-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
References: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces the creation of AEST platform devices, where each
device represents a logical "error node device" grouping one or more
AEST nodes from the ACPI table.

Instead of relying on the optional 'error_node_device' field in the AEST
table[1], this commit uses the interrupt number as the sole identifier for
the parent device. This design simplifies the driver logic by providing a
single, consistent mechanism for grouping nodes.

The 'error_node_device' field can be unspecified, but an AEST node is
always physically associated with a parent component. The interrupt
number serves as a reliable proxy for this association. This approach
is based on the safe assumption that distinct hardware components (e.g.,
SMMU, CMN, GIC) are assigned unique error interrupts and do not share
them.

[1]: https://developer.arm.com/documentation/den0085/latest

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |   8 +
 arch/arm64/include/asm/ras.h |  15 ++
 drivers/acpi/arm64/Kconfig   |  11 ++
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 311 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  56 +++++++
 6 files changed, 402 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cda6701685..d14e16c3a93b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -341,6 +341,14 @@ S:	Maintained
 F:	drivers/acpi/arm64
 F:	include/linux/acpi_iort.h
 
+ACPI AEST
+M:	Ruidong Tian <tianruidond@linux.alibaba.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/acpi/arm64/aest.c
+F:	include/linux/acpi_aest.h
+
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
 L:	linux-acpi@vger.kernel.org
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..b6640b9972bf
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc[4];
+};
+
+#endif /* __ASM_RAS_H */
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index f2fd79f22e7d..52df190356c8 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -24,3 +24,14 @@ config ACPI_APMT
 
 config ACPI_MPAM
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
+	depends on ARM64_RAS_EXTN
+
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 9390b57cb564..bad77fdbf8dd 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..b8359b95f40f
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/xarray.h>
+#include <linux/platform_device.h>
+#include <linux/acpi_aest.h>
+
+#include "init.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+static struct xarray *aest_array;
+
+static void __init aest_init_interface(struct acpi_aest_hdr *hdr,
+				       struct acpi_aest_node *node)
+{
+	struct acpi_aest_node_interface_header *interface;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header, hdr,
+				 hdr->node_interface_offset);
+
+	node->type = hdr->type;
+	node->interface_hdr = interface;
+
+	switch (interface->group_format) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
+		struct acpi_aest_node_interface_4k *interface_4k =
+			(struct acpi_aest_node_interface_4k *)(interface + 1);
+
+		node->common = &interface_4k->common;
+		node->record_implemented =
+			(unsigned long *)&interface_4k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)&interface_4k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)&interface_4k->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
+		struct acpi_aest_node_interface_16k *interface_16k =
+			(struct acpi_aest_node_interface_16k *)(interface + 1);
+
+		node->common = &interface_16k->common;
+		node->record_implemented =
+			(unsigned long *)interface_16k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)interface_16k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)interface_16k->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
+		struct acpi_aest_node_interface_64k *interface_64k =
+			(struct acpi_aest_node_interface_64k *)(interface + 1);
+
+		node->common = &interface_64k->common;
+		node->record_implemented =
+			(unsigned long *)interface_64k->error_record_implemented;
+		node->status_reporting =
+			(unsigned long *)interface_64k->error_status_reporting;
+		node->addressing_mode =
+			(unsigned long *)interface_64k->addressing_mode;
+		break;
+	}
+	default:
+		pr_err("invalid group format: %d\n", interface->group_format);
+	}
+
+	node->interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2, hdr,
+				       hdr->node_interrupt_offset);
+
+	node->interrupt_count = hdr->node_interrupt_count;
+}
+
+static struct aest_hnode *__init
+acpi_aest_alloc_ahnode(struct acpi_aest_node *node, u64 error_device_id)
+{
+	struct aest_hnode *ahnode __free(kfree) = NULL;
+
+	ahnode = kzalloc(sizeof(*ahnode), GFP_KERNEL);
+	if (!ahnode)
+		return NULL;
+
+	INIT_LIST_HEAD(&ahnode->list);
+	ahnode->id = error_device_id;
+	ahnode->count = 0;
+	ahnode->type = node->type;
+
+	return_ptr(ahnode);
+}
+static int __init acpi_aest_init_node(struct acpi_aest_hdr *aest_hdr)
+{
+	struct aest_hnode *ahnode;
+	u64 error_device_id;
+	struct acpi_aest_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->spec_pointer =
+		ACPI_ADD_PTR(void, aest_hdr, aest_hdr->node_specific_offset);
+	if (aest_hdr->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
+		node->processor_spec_pointer =
+			ACPI_ADD_PTR(void, node->spec_pointer,
+				     sizeof(struct acpi_aest_processor));
+
+	aest_init_interface(aest_hdr, node);
+
+	if (node->interrupt_count <= 0)
+		return -EINVAL;
+
+	error_device_id = node->interrupt[0].gsiv;
+	ahnode = xa_load(aest_array, error_device_id);
+	if (!ahnode) {
+		ahnode = acpi_aest_alloc_ahnode(node, error_device_id);
+		if (!ahnode)
+			return -ENOMEM;
+		xa_store(aest_array, error_device_id, ahnode, GFP_KERNEL);
+	}
+
+	list_add_tail(&node->list, &ahnode->list);
+	ahnode->count++;
+
+	return 0;
+}
+
+static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int rc;
+
+	aest = (struct acpi_table_aest *)aest_table;
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest, aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_warn(FW_WARN
+				"AEST node pointer overflow, bad table.\n");
+			return -EINVAL;
+		}
+
+		rc = acpi_aest_init_node(aest_node);
+		if (rc)
+			return rc;
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	return 0;
+}
+
+static int acpi_aest_parse_irqs(struct platform_device *pdev,
+				struct acpi_aest_node *anode,
+				struct resource *res, int *res_idx, int irqs[2])
+{
+	int i;
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+	int trigger, irq;
+
+	for (i = 0; i < anode->interrupt_count; i++) {
+		interrupt = &anode->interrupt[i];
+		if (irqs[interrupt->type])
+			continue;
+
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+				  ACPI_LEVEL_SENSITIVE :
+				  ACPI_EDGE_SENSITIVE;
+
+		irq = acpi_register_gsi(&pdev->dev, interrupt->gsiv, trigger,
+					ACPI_ACTIVE_HIGH);
+		if (irq <= 0) {
+			pr_err("failed to map AEST GSI %d\n", interrupt->gsiv);
+			return irq;
+		}
+
+		res[*res_idx].start = irq;
+		res[*res_idx].end = irq;
+		res[*res_idx].flags = IORESOURCE_IRQ;
+		res[*res_idx].name = interrupt->type ? AEST_ERI_NAME :
+						       AEST_FHI_NAME;
+
+		(*res_idx)++;
+
+		irqs[interrupt->type] = irq;
+	}
+
+	return 0;
+}
+
+DEFINE_FREE(res, struct resource *, if (_T) kfree(_T))
+static struct platform_device *__init
+acpi_aest_alloc_pdev(struct aest_hnode *ahnode, int index)
+{
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc("AEST", index++);
+	struct resource *res __free(res);
+	struct acpi_aest_node *anode;
+	int ret, size, j, irq[AEST_MAX_INTERRUPT_PER_NODE] = { 0 };
+
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	res = kcalloc(ahnode->count + AEST_MAX_INTERRUPT_PER_NODE, sizeof(*res),
+		      GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	j = 0;
+	list_for_each_entry(anode, &ahnode->list, list) {
+		if (anode->interface_hdr->type !=
+		    ACPI_AEST_NODE_SYSTEM_REGISTER) {
+			res[j].name = AEST_NODE_NAME;
+			res[j].start = anode->interface_hdr->address;
+			switch (anode->interface_hdr->group_format) {
+			case ACPI_AEST_NODE_GROUP_FORMAT_4K:
+				size = 4 * KB;
+				break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+				size = 16 * KB;
+				break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+				size = 64 * KB;
+				break;
+			default:
+				size = 4 * KB;
+			}
+			res[j].end = res[j].start + size - 1;
+			res[j].flags = IORESOURCE_MEM;
+		}
+
+		ret = acpi_aest_parse_irqs(pdev, anode, res, &j, irq);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = platform_device_add_resources(pdev, res, j);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add_data(pdev, &ahnode, sizeof(ahnode));
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(pdev);
+}
+static int __init acpi_aest_alloc_pdevs(void)
+{
+	int ret = 0, index = 0;
+	struct aest_hnode *ahnode = NULL;
+	unsigned long i;
+
+	xa_for_each(aest_array, i, ahnode) {
+		struct platform_device *pdev =
+			acpi_aest_alloc_pdev(ahnode, index++);
+
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init acpi_aest_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	struct acpi_table_header *aest_table __free(acpi_put_table) =
+		acpi_get_table_pointer(ACPI_SIG_AEST, 0);
+	if (IS_ERR(aest_table))
+		return 0;
+
+	aest_array = kzalloc(sizeof(struct xarray), GFP_KERNEL);
+	if (!aest_array)
+		return -ENOMEM;
+
+	xa_init(aest_array);
+
+	ret = acpi_aest_init_nodes(aest_table);
+	if (ret) {
+		pr_err("Failed init aest node %d\n", ret);
+		return ret;
+	}
+
+	ret = acpi_aest_alloc_pdevs();
+	if (ret) {
+		pr_err("Failed alloc pdev %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+subsys_initcall_sync(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..53c1970e7583
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_AEST_H__
+#define __ACPI_AEST_H__
+
+#include <asm/ras.h>
+#include <linux/acpi.h>
+
+/* AEST resource name */
+#define AEST_NODE_NAME "AEST:NODE"
+#define AEST_FHI_NAME "AEST:FHI"
+#define AEST_ERI_NAME "AEST:ERI"
+
+/* AEST interrupt */
+#define AEST_INTERRUPT_MODE BIT(0)
+
+#define AEST_MAX_INTERRUPT_PER_NODE 2
+
+#define KB 1024
+#define MB (1024 * KB)
+#define GB (1024 * MB)
+
+struct aest_hnode {
+	struct list_head list;
+	int count;
+	u32 id;
+	int type;
+};
+
+struct acpi_aest_node {
+	struct list_head list;
+	int type;
+	struct acpi_aest_node_interface_header *interface_hdr;
+	unsigned long *record_implemented;
+	unsigned long *status_reporting;
+	unsigned long *addressing_mode;
+	struct acpi_aest_node_interface_common *common;
+	union {
+		struct acpi_aest_processor *processor;
+		struct acpi_aest_memory *memory;
+		struct acpi_aest_smmu *smmu;
+		struct acpi_aest_vendor_v2 *vendor;
+		struct acpi_aest_gic *gic;
+		struct acpi_aest_pcie *pcie;
+		struct acpi_aest_proxy *proxy;
+		void *spec_pointer;
+	};
+	union {
+		struct acpi_aest_processor_cache *cache;
+		struct acpi_aest_processor_tlb *tlb;
+		struct acpi_aest_processor_generic *generic;
+		void *processor_spec_pointer;
+	};
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+	int interrupt_count;
+};
+#endif /* __ACPI_AEST_H__ */
-- 
2.51.2.612.gdc70283dfc


