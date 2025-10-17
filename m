Return-Path: <linux-acpi+bounces-17903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5DBEB4CF
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9324B4037D2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204D332ED8;
	Fri, 17 Oct 2025 18:57:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B3332904;
	Fri, 17 Oct 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727460; cv=none; b=EgFszRvGfhd8Jfsu+WijZaRAUWN/gYz3TXyfzRk1LnyNYDfbCcYZuqWGeG1P06Zh5PBE42qqXUHKd6MeDJYNMJS5KGXAJsBEUb5gFG7OH0Y+Entc5K5EBb5FO2fy2T1kzPFCjvI9ob8uAcnkWTytG9YuGdStYDKWGuc3RMnuSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727460; c=relaxed/simple;
	bh=yDEb16V/HblNKdG3Btn3upfzJwhA1at/LcH5bd+zWWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPGMndGAKj/PGmWrZlinmLuHWHcstgLV1zeSt6hCnOReUAJOUvo4+OW4nS7JenJPyKjOxm8OOWog6oUufvfmexrC6IWQDW4DHk3+WEUSgVpkv87JLuj0AcDc7ZlfRgaSsMMLmh88IBcIyjDMLxXfhC1Cm87NZUxMZarNR2yw32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9060B1515;
	Fri, 17 Oct 2025 11:57:29 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E823F66E;
	Fri, 17 Oct 2025 11:57:32 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 06/29] ACPI / MPAM: Parse the MPAM table
Date: Fri, 17 Oct 2025 18:56:22 +0000
Message-Id: <20251017185645.26604-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v2:
 * Expanded commit message.
 * Moved explicit memset() to array initialisation.
 * Added comments on the sizing of arrays.
 * Moved MSC table entry parsing to a helper to allow use of a platform-device
   cleanup rune, result int more returns and fewer breaks.
 * Changed pre-processor macros for table bits.
 * Discover unsupported PPI partitions purely from the table to make gicv5
   easier, which also simplifies acpi_mpam_parse_irqs()
 * Gave interface type numbers pre-processor names.
 * Clarified some comments.
 * Fixed the WARN_ON comparison in acpi_mpam_parse_msc().
 * Made buffer over-run noisier.
 * Print an error condition as %d not %u.
 * Print a debug message when bad NUMA nodes are found.

Changes since v1:
 * Whitespace.
 * Gave GLOBAL_AFFINITY a pre-processor'd name.
 * Fixed assumption that there are zero functional dependencies.
 * Bounds check walking of the MSC RIS.
 * More bounds checking in the main table walk.
 * Check for nonsense numbers of function dependencies.
 * Smattering of pr_debug() to help folk feeding line-noise to the parser.
 * Changed the comment flavour on the SPDX string.
 * Removed additional table check.
 * More comment wrangling.

Changes since RFC:
 * Used DEFINE_RES_IRQ_NAMED() and friends macros.
 * Additional error handling.
 * Check for zero sized MSC.
 * Allow table revisions greater than 1. (no spec for revision 0!)
 * Use cleanup helpers to retrieve ACPI tables, which allows some functions
   to be folded together.
---
 arch/arm64/Kconfig              |   1 +
 drivers/acpi/arm64/Kconfig      |   3 +
 drivers/acpi/arm64/Makefile     |   1 +
 drivers/acpi/arm64/mpam.c       | 377 ++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c           |   2 +-
 include/linux/acpi.h            |  12 +
 include/linux/arm_mpam.h        |  48 ++++
 include/linux/platform_device.h |   1 +
 8 files changed, 444 insertions(+), 1 deletion(-)
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
index 000000000000..59712397025d
--- /dev/null
+++ b/drivers/acpi/arm64/mpam.c
@@ -0,0 +1,377 @@
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
+static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
+				   u32 flags, int *irq)
+{
+	u32 int_type;
+	int sense;
+
+	if (!intid)
+		return false;
+
+	if (_is_ppi_partition(flags))
+		return false;
+
+	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE, flags);
+	int_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags);
+	if (int_type != ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
+		return false;
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
+	u32 flags, intid;
+	int irq;
+
+	intid = tbl_msc->overflow_interrupt;
+	flags = tbl_msc->overflow_interrupt_flags;
+	if (acpi_mpam_register_irq(pdev, intid, flags, &irq))
+		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
+
+	intid = tbl_msc->error_interrupt;
+	flags = tbl_msc->error_interrupt_flags;
+	if (acpi_mpam_register_irq(pdev, intid, flags, &irq))
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
+			pr_debug("Bad proxmity domain %lld, using node 0 instead\n",
+				 res->locator.memory_locator.proximity_domain);
+			nid = 0;
+		}
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
+				       255, nid);
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
+	ptr = (char *)(tbl_msc + 1);
+	table_end = ptr + tbl_msc->length;
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
+static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
+				     struct platform_device *pdev,
+				     u32 *acpi_id)
+{
+	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] = { 0 };
+	bool acpi_id_valid = false;
+	struct acpi_device *buddy;
+	char uid[11];
+	int err;
+
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
+	if (err >= sizeof(uid)) {
+		pr_debug("Failed to convert uid of device for power management.");
+		return acpi_id_valid;
+	}
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
+	struct platform_device *pdev __free(platform_device_put) = platform_device_alloc("mpam_msc", tbl_msc->identifier);
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
+		if (companion)
+			ACPI_COMPANION_SET(&pdev->dev, companion);
+		else
+			pr_debug("MSC.%u: missing namespace entry\n",
+				 tbl_msc->identifier);
+	}
+
+	if (decode_interface_type(tbl_msc, &iface)) {
+		pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (iface == MPAM_IFACE_MMIO)
+		res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
+						       tbl_msc->mmio_size,
+						       "MPAM:MSC");
+	else if (iface == MPAM_IFACE_PCC)
+		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
+							tbl_msc->base_address);
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
+	WARN_ON_ONCE(next_prop > ARRAY_SIZE(props));
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
+	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
+	char *table_end, *table_offset = (char *)(table + 1);
+	struct acpi_mpam_msc_node *tbl_msc;
+	struct platform_device *pdev;
+
+	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
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
+		if (table_offset > table_end) {
+			pr_err("MSC entry overlaps end of ACPI table\n");
+			return -EINVAL;
+		}
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
+int acpi_mpam_count_msc(void)
+{
+	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
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
+	table_end = (char *)table + table->length;
+
+	while (table_offset < table_end) {
+		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
+		if (!tbl_msc->mmio_size)
+			continue;
+
+		if (tbl_msc->length < sizeof(*tbl_msc))
+			return -EINVAL;
+		if (tbl_msc->length > table_end - table_offset)
+			return -EINVAL;
+		table_offset += tbl_msc->length;
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
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a9dbacabdf89..9d66421f68ff 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
 #include <linux/resource_ext.h>
@@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
 void acpi_table_init_complete (void);
 int acpi_table_init (void);
 
+static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
+{
+	struct acpi_table_header *table;
+	int status = acpi_get_table(signature, instance, &table);
+
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-ENOENT);
+	return table;
+}
+DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))
+
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init_or_acpilib acpi_table_parse_entries(char *id,
 		unsigned long table_size, int entry_id,
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
new file mode 100644
index 000000000000..3d6c39c667c3
--- /dev/null
+++ b/include/linux/arm_mpam.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2025 Arm Ltd. */
+
+#ifndef __LINUX_ARM_MPAM_H
+#define __LINUX_ARM_MPAM_H
+
+#include <linux/acpi.h>
+#include <linux/types.h>
+
+#define GLOBAL_AFFINITY		~0
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
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..23a30ada2d4c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
+DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
-- 
2.39.5


