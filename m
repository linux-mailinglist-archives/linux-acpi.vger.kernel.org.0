Return-Path: <linux-acpi+bounces-18940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B9C655DE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 218164F2FF3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F82D1F7E;
	Mon, 17 Nov 2025 17:01:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369A2D3EDF;
	Mon, 17 Nov 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398880; cv=none; b=CNHelwFvM/xEHqScdF+Ufr9jjH2hQbpzuYqyFjh80DqZP5BZoay7qMMx0jHjKTHFQUGyx6hA/gpbZq1+oNU3nIrgIDFpQJa1wvx/qVqaCx/2D4BL67r67vGDsH+jBtS0NHI1t+FxyQ7iFmfLDe6Udf4uCfhNkCl5ssBI6edayZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398880; c=relaxed/simple;
	bh=dfSKgJ4PgvaahLvt7K57Pm8XpAlY9e3cCTbAV+YV7YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmd3ZZe1FeyJmCxEQsHlRPFybX5DTeITutkB46ZOdEbESZbpV9e57Zf8dkeZZbAgaLc0CkcBlZuGyQA1/WnuEE88oPuBFWFtAvCo8PVrrGESZtxcda+30EbhI2+gUt54ONQ7r3FrvQD5GNu6G7EDhdt6VpxSmHY1ztyLGJ3nygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B251007;
	Mon, 17 Nov 2025 09:01:09 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 609043F66E;
	Mon, 17 Nov 2025 09:01:12 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v5 09/34] ACPI / MPAM: Parse the MPAM table
Date: Mon, 17 Nov 2025 16:59:48 +0000
Message-ID: <20251117170014.4113754-10-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

Add code to parse the arm64 specific MPAM table, looking up the cache
level from the PPTT and feeding the end result into the MPAM driver.

This happens in two stages. Platform devices are created first for the
MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
to discover the RIS entries the MSC contains.

For now the MPAM hook mpam_ris_create() is stubbed out, but will update
the MPAM driver with optional discovered data about the RIS entries.

CC: Carl Worth <carl@os.amperecomputing.com>
Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v4:
Gavin:
u32 intid
irq < 0
if formatting
revision < 1 pr_debug
MSC -> MSCs
Checks to ensure tbl_msc->length within the table before accessing

Fenghua:
proximity typo
table_end calculation
buddy and companion refcounting
Use MPAM_CLASS_ID_DEFAULT for memory class id

Tighten a WARN_ON_ONCE()
Spaces -> Tabs
Remove unused GLOBAL_AFFINITY define

Changes since v3:
return irq from acpi_mpam_register_irq (Jonathan)
err -> len rename (Jonathan)
Move table initialisation after checking (Jonathan)
Add sanity checking in acpi_mpam_count_msc() (Jonathan)
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/mpam.c   | 411 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 include/linux/arm_mpam.h    |  47 +++++
 6 files changed, 464 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/mpam.c
 create mode 100644 include/linux/arm_mpam.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 67015d51f7b5..c5e66d5d72cd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
 
 config ARM64_MPAM
 	bool "Enable support for MPAM"
+	select ACPI_MPAM if ACPI
 	help
 	  Memory System Resource Partitioning and Monitoring (MPAM) is an
 	  optional extension to the Arm architecture that allows each
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
index 000000000000..a6979d99cbd9
--- /dev/null
+++ b/drivers/acpi/arm64/mpam.c
@@ -0,0 +1,411 @@
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
+#define ACPI_MPAM_MSC_IRQ_MODE                              BIT(0)
+#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                         GENMASK(2, 1)
+#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                        0
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK                BIT(3)
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR           0
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER 1
+#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID                    BIT(4)
+
+/*
+ * Encodings for the MSC node body interface type field.
+ * See 2.1 MPAM MSC node, Table 4 of DEN0065B_MPAM_ACPI_3.0-bet.
+ */
+#define ACPI_MPAM_MSC_IFACE_MMIO   0x00
+#define ACPI_MPAM_MSC_IFACE_PCC    0x0a
+
+static bool _is_ppi_partition(u32 flags)
+{
+	u32 aff_type, is_ppi;
+	bool ret;
+
+	is_ppi = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_VALID, flags);
+	if (!is_ppi)
+		return false;
+
+	aff_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK, flags);
+	ret = (aff_type == ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER);
+	if (ret)
+		pr_err_once("Partitioned interrupts not supported\n");
+
+	return ret;
+}
+
+static int acpi_mpam_register_irq(struct platform_device *pdev,
+				  u32 intid, u32 flags)
+{
+	int irq;
+	u32 int_type;
+	int trigger;
+
+	if (!intid)
+		return -EINVAL;
+
+	if (_is_ppi_partition(flags))
+		return -EINVAL;
+
+	trigger = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE, flags);
+	int_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags);
+	if (int_type != ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
+		return -EINVAL;
+
+	irq = acpi_register_gsi(&pdev->dev, intid, trigger, ACPI_ACTIVE_HIGH);
+	if (irq < 0)
+		pr_err_once("Failed to register interrupt 0x%x with ACPI\n", intid);
+
+	return irq;
+}
+
+static void acpi_mpam_parse_irqs(struct platform_device *pdev,
+				 struct acpi_mpam_msc_node *tbl_msc,
+				 struct resource *res, int *res_idx)
+{
+	u32 flags, intid;
+	int irq;
+
+	intid = tbl_msc->overflow_interrupt;
+	flags = tbl_msc->overflow_interrupt_flags;
+	irq = acpi_mpam_register_irq(pdev, intid, flags);
+	if (irq > 0)
+		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
+
+	intid = tbl_msc->error_interrupt;
+	flags = tbl_msc->error_interrupt_flags;
+	irq = acpi_mpam_register_irq(pdev, intid, flags);
+	if (irq > 0)
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
+			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
+			return -EINVAL;
+		}
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
+				       level, cache_id);
+	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
+		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
+		if (nid == NUMA_NO_NODE) {
+			pr_debug("Bad proximity domain %lld, using node 0 instead\n",
+				 res->locator.memory_locator.proximity_domain);
+			nid = 0;
+		}
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
+				       MPAM_CLASS_ID_DEFAULT, nid);
+	default:
+		/* These get discovered later and are treated as unknown */
+		return 0;
+	}
+}
+
+int acpi_mpam_parse_resources(struct mpam_msc *msc,
+			      struct acpi_mpam_msc_node *tbl_msc)
+{
+	int i, err;
+	char *ptr, *table_end;
+	struct acpi_mpam_resource_node *resource;
+
+	table_end = (char *)tbl_msc + tbl_msc->length;
+	ptr = (char *)(tbl_msc + 1);
+	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
+		u64 max_deps, remaining_table;
+
+		if (ptr + sizeof(*resource) > table_end)
+			return -EINVAL;
+
+		resource = (struct acpi_mpam_resource_node *)ptr;
+
+		remaining_table = table_end - ptr;
+		max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
+		if (resource->num_functional_deps > max_deps) {
+			pr_debug("MSC has impossible number of functional dependencies\n");
+			return -EINVAL;
+		}
+
+		err = acpi_mpam_parse_resource(msc, resource);
+		if (err)
+			return err;
+
+		ptr += sizeof(*resource);
+		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
+	}
+
+	return 0;
+}
+
+/*
+ * Creates the device power management link and returns true if the
+ * acpi id is valid and usable for cpu affinity.  This is the case
+ * when the linked device is a processor or a processor container.
+ */
+static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
+				     struct platform_device *pdev,
+				     u32 *acpi_id)
+{
+	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] = { 0 };
+	bool acpi_id_valid = false;
+	struct acpi_device *buddy;
+	char uid[11];
+	int len;
+
+	memcpy(hid, &tbl_msc->hardware_id_linked_device,
+	       sizeof(tbl_msc->hardware_id_linked_device));
+
+	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
+		*acpi_id = tbl_msc->instance_id_linked_device;
+		acpi_id_valid = true;
+	}
+
+	len = snprintf(uid, sizeof(uid), "%u",
+		       tbl_msc->instance_id_linked_device);
+	if (len >= sizeof(uid)) {
+		pr_debug("Failed to convert uid of device for power management.");
+		return acpi_id_valid;
+	}
+
+	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
+	if (buddy) {
+		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
+		acpi_dev_put(buddy);
+	}
+
+	return acpi_id_valid;
+}
+
+static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
+				 enum mpam_msc_iface *iface)
+{
+	switch (tbl_msc->interface_type) {
+	case ACPI_MPAM_MSC_IFACE_MMIO:
+		*iface = MPAM_IFACE_MMIO;
+		return 0;
+	case ACPI_MPAM_MSC_IFACE_PCC:
+		*iface = MPAM_IFACE_PCC;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_node *tbl_msc)
+{
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc("mpam_msc", tbl_msc->identifier);
+	int next_res = 0, next_prop = 0, err;
+	/* pcc, nrdy, affinity and a sentinel */
+	struct property_entry props[4] = { 0 };
+	/* mmio, 2xirq, no sentinel. */
+	struct resource res[3] = { 0 };
+	struct acpi_device *companion;
+	enum mpam_msc_iface iface;
+	char uid[16];
+	u32 acpi_id;
+
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	/* Some power management is described in the namespace: */
+	err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
+	if (err > 0 && err < sizeof(uid)) {
+		companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
+		if (companion) {
+			ACPI_COMPANION_SET(&pdev->dev, companion);
+			acpi_dev_put(companion);
+		} else {
+			pr_debug("MSC.%u: missing namespace entry\n", tbl_msc->identifier);
+		}
+	}
+
+	if (decode_interface_type(tbl_msc, &iface)) {
+		pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (iface == MPAM_IFACE_MMIO) {
+		res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
+						       tbl_msc->mmio_size,
+						       "MPAM:MSC");
+	} else if (iface == MPAM_IFACE_PCC) {
+		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
+							tbl_msc->base_address);
+	}
+
+	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
+
+	WARN_ON_ONCE(next_res > ARRAY_SIZE(res));
+	err = platform_device_add_resources(pdev, res, next_res);
+	if (err)
+		return ERR_PTR(err);
+
+	props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
+						tbl_msc->max_nrdy_usec);
+
+	/*
+	 * The MSC's CPU affinity is described via its linked power
+	 * management device, but only if it points at a Processor or
+	 * Processor Container.
+	 */
+	if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id))
+		props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity", acpi_id);
+
+	WARN_ON_ONCE(next_prop > ARRAY_SIZE(props) - 1);
+	err = device_create_managed_software_node(&pdev->dev, props, NULL);
+	if (err)
+		return ERR_PTR(err);
+
+	/*
+	 * Stash the table entry for acpi_mpam_parse_resources() to discover
+	 * what this MSC controls.
+	 */
+	err = platform_device_add_data(pdev, tbl_msc, tbl_msc->length);
+	if (err)
+		return ERR_PTR(err);
+
+	err = platform_device_add(pdev);
+	if (err)
+		return ERR_PTR(err);
+
+	return_ptr(pdev);
+}
+
+static int __init acpi_mpam_parse(void)
+{
+	char *table_end, *table_offset;
+	struct acpi_mpam_msc_node *tbl_msc;
+	struct platform_device *pdev;
+
+	if (acpi_disabled || !system_supports_mpam())
+		return 0;
+
+	struct acpi_table_header *table __free(acpi_put_table) =
+		acpi_get_table_ret(ACPI_SIG_MPAM, 0);
+
+	if (IS_ERR(table))
+		return 0;
+
+	if (table->revision < 1) {
+		pr_debug("MPAM ACPI table revision %d not supported\n", table->revision);
+		return 0;
+	}
+
+	table_offset = (char *)(table + 1);
+	table_end = (char *)table + table->length;
+
+	while (table_offset < table_end) {
+		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+		if (table_offset + sizeof(*tbl_msc) > table_end ||
+		    table_offset + tbl_msc->length > table_end) {
+			pr_err("MSC entry overlaps end of ACPI table\n");
+			return -EINVAL;
+		}
+		table_offset += tbl_msc->length;
+
+		/*
+		 * If any of the reserved fields are set, make no attempt to
+		 * parse the MSC structure. This MSC will still be counted by
+		 * acpi_mpam_count_msc(), meaning the MPAM driver can't probe
+		 * against all MSC, and will never be enabled. There is no way
+		 * to enable it safely, because we cannot determine safe
+		 * system-wide partid and pmg ranges in this situation.
+		 */
+		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
+			pr_err_once("Unrecognised MSC, MPAM not usable\n");
+			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
+			continue;
+		}
+
+		if (!tbl_msc->mmio_size) {
+			pr_debug("MSC.%u: marked as disabled\n", tbl_msc->identifier);
+			continue;
+		}
+
+		pdev = acpi_mpam_parse_msc(tbl_msc);
+		if (IS_ERR(pdev))
+			return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_mpam_count_msc() - Count the number of MSC described by firmware.
+ *
+ * Returns the number of MSCs, or zero for an error.
+ *
+ * This can be called before or in parallel with acpi_mpam_parse().
+ */
+int acpi_mpam_count_msc(void)
+{
+	char *table_end, *table_offset;
+	struct acpi_mpam_msc_node *tbl_msc;
+	int count = 0;
+
+	if (acpi_disabled || !system_supports_mpam())
+		return 0;
+
+	struct acpi_table_header *table __free(acpi_put_table) =
+		acpi_get_table_ret(ACPI_SIG_MPAM, 0);
+
+	if (IS_ERR(table))
+		return 0;
+
+	if (table->revision < 1)
+		return 0;
+
+	table_offset = (char *)(table + 1);
+	table_end = (char *)table + table->length;
+
+	while (table_offset < table_end) {
+		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+
+		if (table_offset + sizeof(*tbl_msc) > table_end)
+			return -EINVAL;
+		if (tbl_msc->length < sizeof(*tbl_msc))
+			return -EINVAL;
+		if (tbl_msc->length > table_end - table_offset)
+			return -EINVAL;
+		table_offset += tbl_msc->length;
+
+		if (!tbl_msc->mmio_size)
+			continue;
+
+		count++;
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
index 57fc8bc56166..4286e4af1092 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT, ACPI_SIG_SWFT};
+	ACPI_SIG_NBFT, ACPI_SIG_SWFT, ACPI_SIG_MPAM};
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
new file mode 100644
index 000000000000..4b7f335181e0
--- /dev/null
+++ b/include/linux/arm_mpam.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+	MPAM_CLASS_CACHE,	/* Caches, e.g. L2, L3 */
+	MPAM_CLASS_MEMORY,	/* Main memory */
+	MPAM_CLASS_UNKNOWN,	/* Everything else, e.g. SMMU */
+};
+
+#define MPAM_CLASS_ID_DEFAULT	255
+
+#ifdef CONFIG_ACPI_MPAM
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
2.43.0


