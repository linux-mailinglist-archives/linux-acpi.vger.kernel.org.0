Return-Path: <linux-acpi+bounces-15917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D0B31EBB
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3997F1C23ED4
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750DF256C84;
	Fri, 22 Aug 2025 15:31:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F123BCE4;
	Fri, 22 Aug 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876714; cv=none; b=VlFioa+VdebBWuVSkhX+dF8ODIkB772fAUiqjfeyWIYHpBvcIWty9AKKP/EYVMr5/d8Xynp6GjFEbcqYQgHRbN57nyo6e1onE/SnayaUBzuB8R4ewwXkaU3iMH/TGikaRSHMSGQlzk6vPiGJORIDuyLksGsMOHKRiw17k0O7cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876714; c=relaxed/simple;
	bh=Q8GeH70wKvlYBI01fp/Tx7l3lcdzEfWVAqf8aPhatFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1UAm8B6BctWW3eNzRKxsico4r5j+lLBrzAdt8HElPZgbexxRVXtFzBAQi9bIjRVCsoUhcRmpL+KeVQPKQYoYFG2lLoDovFvwD6rtq4ETx6za8nzf0XZzFE0YD8oUe/BxWxZ4R/qvQv53KQ2Lhiza6ouUJbKX0MwPthvJ2UITdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C5C15A1;
	Fri, 22 Aug 2025 08:31:43 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457F43F63F;
	Fri, 22 Aug 2025 08:31:46 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
Date: Fri, 22 Aug 2025 15:29:49 +0000
Message-Id: <20250822153048.2287-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250822153048.2287-1-james.morse@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to parse the arm64 specific MPAM table, looking up the cache
level from the PPTT and feeding the end result into the MPAM driver.

CC: Carl Worth <carl@os.amperecomputing.com>
Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since RFC:
 * Used DEFINE_RES_IRQ_NAMED() and friends macros.
 * Additional error handling.
 * Check for zero sized MSC.
 * Allow table revisions greater than 1. (no spec for revision 0!)
 * Use cleanup helpers to retrive ACPI tables, which allows some functions
   to be folded together.
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/mpam.c   | 331 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 include/linux/arm_mpam.h    |  46 +++++
 6 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/mpam.c
 create mode 100644 include/linux/arm_mpam.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 658e47fc0c5a..e51ccf1da102 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
 
 config ARM64_MPAM
 	bool "Enable support for MPAM"
+	select ACPI_MPAM if ACPI
 	help
 	  Memory Partitioning and Monitoring is an optional extension
 	  that allows the CPUs to mark load and store transactions with
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index b3ed6212244c..f2fd79f22e7d 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -21,3 +21,6 @@ config ACPI_AGDI
 
 config ACPI_APMT
 	bool
+
+config ACPI_MPAM
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 05ecde9eaabe..9390b57cb564 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ACPI_FFH)		+= ffh.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
new file mode 100644
index 000000000000..e55fc2729ac5
--- /dev/null
+++ b/drivers/acpi/arm64/mpam.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Arm Ltd.
+
+/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
+
+#define pr_fmt(fmt) "ACPI MPAM: " fmt
+
+#include <linux/acpi.h>
+#include <linux/arm_mpam.h>
+#include <linux/bits.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/platform_device.h>
+
+#include <acpi/processor.h>
+
+/*
+ * Flags for acpi_table_mpam_msc.*_interrupt_flags.
+ * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
+ */
+#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
+#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    GENMASK(2, 1)
+#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
+
+static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
+		     int *irq, u32 processor_container_uid)
+{
+	int sense;
+
+	if (!intid)
+		return false;
+
+	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
+	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
+		return false;
+
+	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
+
+	/*
+	 * If the GSI is in the GIC's PPI range, try and create a partitioned
+	 * percpu interrupt.
+	 */
+	if (16 <= intid && intid < 32 && processor_container_uid != ~0) {
+		pr_err_once("Partitioned interrupts not supported\n");
+		return false;
+	}
+
+	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
+	if (*irq <= 0) {
+		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
+			    intid);
+		return false;
+	}
+
+	return true;
+}
+
+static void acpi_mpam_parse_irqs(struct platform_device *pdev,
+				 struct acpi_mpam_msc_node *tbl_msc,
+				 struct resource *res, int *res_idx)
+{
+	u32 flags, aff;
+	int irq;
+
+	flags = tbl_msc->overflow_interrupt_flags;
+	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
+	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
+		aff = tbl_msc->overflow_interrupt_affinity;
+	else
+		aff = ~0;
+	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
+		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
+
+	flags = tbl_msc->error_interrupt_flags;
+	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
+	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
+		aff = tbl_msc->error_interrupt_affinity;
+	else
+		aff = ~0;
+	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
+		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
+}
+
+static int acpi_mpam_parse_resource(struct mpam_msc *msc,
+				    struct acpi_mpam_resource_node *res)
+{
+	int level, nid;
+	u32 cache_id;
+
+	switch (res->locator_type) {
+	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
+		cache_id = res->locator.cache_locator.cache_reference;
+		level = find_acpi_cache_level_from_id(cache_id);
+		if (level <= 0) {
+			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
+			return -EINVAL;
+		}
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
+				       level, cache_id);
+	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
+		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
+		if (nid == NUMA_NO_NODE)
+			nid = 0;
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
+				       255, nid);
+	default:
+		/* These get discovered later and treated as unknown */
+		return 0;
+	}
+}
+
+int acpi_mpam_parse_resources(struct mpam_msc *msc,
+			      struct acpi_mpam_msc_node *tbl_msc)
+{
+	int i, err;
+	struct acpi_mpam_resource_node *resources;
+
+	resources = (struct acpi_mpam_resource_node *)(tbl_msc + 1);
+	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
+		err = acpi_mpam_parse_resource(msc, &resources[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
+				     struct platform_device *pdev,
+				     u32 *acpi_id)
+{
+	bool acpi_id_valid = false;
+	struct acpi_device *buddy;
+	char hid[16], uid[16];
+	int err;
+
+	memset(&hid, 0, sizeof(hid));
+	memcpy(hid, &tbl_msc->hardware_id_linked_device,
+	       sizeof(tbl_msc->hardware_id_linked_device));
+
+	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
+		*acpi_id = tbl_msc->instance_id_linked_device;
+		acpi_id_valid = true;
+	}
+
+	err = snprintf(uid, sizeof(uid), "%u",
+		       tbl_msc->instance_id_linked_device);
+	if (err >= sizeof(uid))
+		return acpi_id_valid;
+
+	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
+	if (buddy)
+		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
+
+	return acpi_id_valid;
+}
+
+static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
+				 enum mpam_msc_iface *iface)
+{
+	switch (tbl_msc->interface_type) {
+	case 0:
+		*iface = MPAM_IFACE_MMIO;
+		return 0;
+	case 0xa:
+		*iface = MPAM_IFACE_PCC;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __init acpi_mpam_parse(void)
+{
+        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
+	char *table_end, *table_offset = (char *)(table + 1);
+	struct property_entry props[4]; /* needs a sentinel */
+	struct acpi_mpam_msc_node *tbl_msc;
+	int next_res, next_prop, err = 0;
+	struct acpi_device *companion;
+	struct platform_device *pdev;
+	enum mpam_msc_iface iface;
+	struct resource res[3];
+	char uid[16];
+	u32 acpi_id;
+
+	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
+		return 0;
+
+	if (IS_ERR(table))
+		return 0;
+
+	if (table->revision < 1)
+		return 0;
+
+	table_end = (char *)table + table->length;
+
+	while (table_offset < table_end) {
+		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+		table_offset += tbl_msc->length;
+
+		/*
+		 * If any of the reserved fields are set, make no attempt to
+		 * parse the msc structure. This will prevent the driver from
+		 * probing all the MSC, meaning it can't discover the system
+		 * wide supported partid and pmg ranges. This avoids whatever
+		 * this MSC is truncating the partids and creating a screaming
+		 * error interrupt.
+		 */
+		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2)
+			continue;
+
+		if (!tbl_msc->mmio_size)
+			continue;
+
+		if (decode_interface_type(tbl_msc, &iface))
+			continue;
+
+		next_res = 0;
+		next_prop = 0;
+		memset(res, 0, sizeof(res));
+		memset(props, 0, sizeof(props));
+
+		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);
+		if (!pdev) {
+			err = -ENOMEM;
+			break;
+		}
+
+		if (tbl_msc->length < sizeof(*tbl_msc)) {
+			err = -EINVAL;
+			break;
+		}
+
+		/* Some power management is described in the namespace: */
+		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
+		if (err > 0 && err < sizeof(uid)) {
+			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
+			if (companion)
+				ACPI_COMPANION_SET(&pdev->dev, companion);
+		}
+
+		if (iface == MPAM_IFACE_MMIO) {
+			res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
+							       tbl_msc->mmio_size,
+							       "MPAM:MSC");
+		} else if (iface == MPAM_IFACE_PCC) {
+			props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
+								tbl_msc->base_address);
+			next_prop++;
+		}
+
+		acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
+		err = platform_device_add_resources(pdev, res, next_res);
+		if (err)
+			break;
+
+		props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
+							tbl_msc->max_nrdy_usec);
+
+		/*
+		 * The MSC's CPU affinity is described via its linked power
+		 * management device, but only if it points at a Processor or
+		 * Processor Container.
+		 */
+		if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id)) {
+			props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity",
+								acpi_id);
+		}
+
+		err = device_create_managed_software_node(&pdev->dev, props,
+							  NULL);
+		if (err)
+			break;
+
+		/* Come back later if you want the RIS too */
+		err = platform_device_add_data(pdev, tbl_msc, tbl_msc->length);
+		if (err)
+			break;
+
+		err = platform_device_add(pdev);
+		if (err)
+			break;
+	}
+
+	if (err)
+		platform_device_put(pdev);
+
+	return err;
+}
+
+int acpi_mpam_count_msc(void)
+{
+        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
+	char *table_end, *table_offset = (char *)(table + 1);
+	struct acpi_mpam_msc_node *tbl_msc;
+	int count = 0;
+
+	if (IS_ERR(table))
+		return 0;
+
+	if (table->revision < 1)
+		return 0;
+
+	tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+	table_end = (char *)table + table->length;
+
+	while (table_offset < table_end) {
+		if (!tbl_msc->mmio_size)
+			continue;
+
+		if (tbl_msc->length < sizeof(*tbl_msc))
+			return -EINVAL;
+
+		count++;
+
+		table_offset += tbl_msc->length;
+		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+	}
+
+	return count;
+}
+
+/*
+ * Call after ACPI devices have been created, which happens behind acpi_scan_init()
+ * called from subsys_initcall(). PCC requires the mailbox driver, which is
+ * initialised from postcore_initcall().
+ */
+subsys_initcall_sync(acpi_mpam_parse);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fa9bb8c8ce95..835e3795ede3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT };
+	ACPI_SIG_NBFT, ACPI_SIG_MPAM };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
new file mode 100644
index 000000000000..0edefa6ba019
--- /dev/null
+++ b/include/linux/arm_mpam.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Arm Ltd. */
+
+#ifndef __LINUX_ARM_MPAM_H
+#define __LINUX_ARM_MPAM_H
+
+#include <linux/acpi.h>
+#include <linux/types.h>
+
+struct mpam_msc;
+
+enum mpam_msc_iface {
+	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
+	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
+};
+
+enum mpam_class_types {
+	MPAM_CLASS_CACHE,       /* Well known caches, e.g. L2 */
+	MPAM_CLASS_MEMORY,      /* Main memory */
+	MPAM_CLASS_UNKNOWN,     /* Everything else, e.g. SMMU */
+};
+
+#ifdef CONFIG_ACPI_MPAM
+/* Parse the ACPI description of resources entries for this MSC. */
+int acpi_mpam_parse_resources(struct mpam_msc *msc,
+			      struct acpi_mpam_msc_node *tbl_msc);
+
+int acpi_mpam_count_msc(void);
+#else
+static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
+					    struct acpi_mpam_msc_node *tbl_msc)
+{
+	return -EINVAL;
+}
+
+static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
+#endif
+
+static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
+				  enum mpam_class_types type, u8 class_id,
+				  int component_id)
+{
+	return -EINVAL;
+}
+
+#endif /* __LINUX_ARM_MPAM_H */
-- 
2.20.1


