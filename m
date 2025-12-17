Return-Path: <linux-acpi+bounces-19613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130ECC76B6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD71F30BEA75
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0B34DCFC;
	Wed, 17 Dec 2025 11:29:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4F34DB43;
	Wed, 17 Dec 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970943; cv=none; b=c8c9YyRpeeXbGIJDutQEP+Fwo4d6k03m05bNVM2GXirj7DmFfDVn+9R1BBeU/vjE7g/t3BQWzbTowr3RMbbwc0KVnKBn6qW6Tk9VGLhhyqyvVdAg5evbnrakQPwXNzHkYujz5fepIDeYwhuZR/guFylP46m0IZZ8c3OuFondz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970943; c=relaxed/simple;
	bh=AALp5dZg7BIrvJvTY7HHQeJsrF+mrJ/YreqxRpaMOvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fisPgn5gBFicz5yghMcjfxSwI9ePvzDOcMq0hG/opz9/zbt2TM9ss5Nomd6BV63MWgb3QJmryOrd18IqQLcsdsOXQtmPNrbfHBW1nLckBmicUhjaTKzrEsmuY3lQWLdGS5CBvmTPt6lzJk4X+vcsX2jyfg92p6HYH5nngqKCuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF0EA1516;
	Wed, 17 Dec 2025 03:28:53 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3636B3F73B;
	Wed, 17 Dec 2025 03:28:59 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 01/12] ras: add estatus core interfaces
Date: Wed, 17 Dec 2025 11:28:34 +0000
Message-ID: <20251217112845.1814119-2-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CONFIG_RAS_ESTATUS_CORE and the public header that exposes
the generic error-status abstractions. Nothing uses the option yet, but
the definitions are shared by both GHES and the forthcoming DeviceTree
provider, so land them ahead of the core implementation.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 MAINTAINERS                  |   5 +
 drivers/firmware/efi/Kconfig |  11 ++
 include/linux/estatus.h      | 267 +++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 include/linux/estatus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..501b6d300aa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21757,6 +21757,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS ERROR STATUS
+M:	Ahmed Tiba <ahmed.tiba@arm.com>
+S:	Maintained
+F:	include/linux/estatus.h
+
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 29e0729299f5..d348ceb81cfb 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -329,6 +329,17 @@ config UEFI_CPER_X86
 	depends on UEFI_CPER && X86
 	default y
 
+config RAS_ESTATUS_CORE
+	bool "Firmware-first estatus processing core"
+	depends on UEFI_CPER
+	select GENERIC_ALLOCATOR
+	help
+	  Provide the shared Common Platform Error Record (CPER) handling core
+	  that firmware-first error sources reuse to read, cache, log, and
+	  dispatch Generic Hardware Error Status Blocks. This gets selected
+	  automatically by providers such as ACPI APEI GHES or the DeviceTree
+	  estatus driver.
+
 config TEE_STMM_EFI
 	tristate "TEE-based EFI runtime variable service driver"
 	depends on EFI && OPTEE
diff --git a/include/linux/estatus.h b/include/linux/estatus.h
new file mode 100644
index 000000000000..002a9533c85a
--- /dev/null
+++ b/include/linux/estatus.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Firmware-first RAS: Generic Error Status Core
+ *
+ * Copyright (C) 2025 ARM Ltd.
+ * Author: Ahmed Tiba <ahmed.tiba@arm.com>
+ */
+
+#ifndef __LINUX_ESTATUS_H
+#define __LINUX_ESTATUS_H
+
+/* "estatus" abbreviates "error status" (CPER status blocks). */
+
+/*
+ * "estatus" is a contraction of "error status".  The naming mirrors the ACPI
+ * Generic Error Status Block (HEST/CPER) terminology while staying agnostic of
+ * the transport (ACPI, DeviceTree, etc.).
+ */
+
+#include <linux/irq_work.h>
+#include <linux/kconfig.h>
+#include <linux/cper.h>
+#include <asm/fixmap.h>
+
+#if IS_ENABLED(CONFIG_ACPI)
+#include <linux/acpi.h>
+#include <acpi/actbl1.h>
+#define estatus_generic_status struct acpi_hest_generic_status
+#define estatus_generic_data struct acpi_hest_generic_data
+#define estatus_generic_data_v300 struct acpi_hest_generic_data_v300
+#else
+struct estatus_generic_status {
+	u32 block_status;
+	u32 raw_data_offset;
+	u32 raw_data_length;
+	u32 data_length;
+	u32 error_severity;
+} __packed;
+
+struct estatus_generic_data {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+} __packed;
+
+struct estatus_generic_data_v300 {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+	u64 time_stamp;
+} __packed;
+
+#define estatus_generic_status struct estatus_generic_status
+#define estatus_generic_data struct estatus_generic_data
+#define estatus_generic_data_v300 struct estatus_generic_data_v300
+
+#define acpi_hest_generic_status estatus_generic_status
+#define acpi_hest_generic_data estatus_generic_data
+#define acpi_hest_generic_data_v300 estatus_generic_data_v300
+#endif
+
+struct estatus_source;
+
+#if IS_ENABLED(CONFIG_ACPI_APEI_GHES)
+#include <acpi/apei.h>
+#endif
+
+void estatus_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+
+enum estatus_notify_mode {
+	ESTATUS_NOTIFY_ASYNC,
+	ESTATUS_NOTIFY_SEA,
+};
+
+struct estatus_ops {
+	int (*get_phys)(struct estatus_source *source, phys_addr_t *addr);
+	int (*read)(struct estatus_source *source, phys_addr_t addr,
+		    void *buf, size_t len, enum fixed_addresses fixmap_idx);
+	int (*write)(struct estatus_source *source, phys_addr_t addr,
+		     const void *buf, size_t len, enum fixed_addresses fixmap_idx);
+	void (*ack)(struct estatus_source *source);
+	size_t (*get_max_len)(struct estatus_source *source);
+	enum estatus_notify_mode (*get_notify_mode)(struct estatus_source *source);
+	const char *(*get_name)(struct estatus_source *source);
+};
+
+struct estatus_source {
+	const struct estatus_ops *ops;
+	void *priv;
+	estatus_generic_status *estatus;
+	enum fixed_addresses fixmap_idx;
+};
+
+struct estatus_node {
+	struct llist_node llnode;
+	struct estatus_source *source;
+};
+
+struct estatus_cache {
+	u32 estatus_len;
+	atomic_t count;
+	struct estatus_source *source;
+	unsigned long long time_in;
+	struct rcu_head rcu;
+};
+
+enum {
+	ESTATUS_SEV_NO = 0x0,
+	ESTATUS_SEV_CORRECTED = 0x1,
+	ESTATUS_SEV_RECOVERABLE = 0x2,
+	ESTATUS_SEV_PANIC = 0x3,
+};
+
+int estatus_proc(struct estatus_source *ghes);
+int estatus_in_nmi_queue_one_entry(struct estatus_source *ghes,
+				   enum fixed_addresses fixmap_idx);
+void estatus_proc_in_irq(struct irq_work *irq_work);
+
+/**
+ * estatus_register_vendor_record_notifier - register a notifier for vendor
+ * records that the kernel would otherwise ignore.
+ * @nb: pointer to the notifier_block structure of the event handler.
+ *
+ * return 0 : SUCCESS, non-zero : FAIL
+ */
+int estatus_register_vendor_record_notifier(struct notifier_block *nb);
+
+/**
+ * estatus_unregister_vendor_record_notifier - unregister the previously
+ * registered vendor record notifier.
+ * @nb: pointer to the notifier_block structure of the vendor record handler.
+ */
+void estatus_unregister_vendor_record_notifier(struct notifier_block *nb);
+
+int estatus_pool_init(unsigned int num_ghes);
+
+struct notifier_block;
+void estatus_register_report_chain(struct notifier_block *nb);
+void estatus_unregister_report_chain(struct notifier_block *nb);
+
+static inline int estatus_get_version(estatus_generic_data *gdata)
+{
+	return gdata->revision >> 8;
+}
+
+static inline void *estatus_get_payload(estatus_generic_data *gdata)
+{
+	if (estatus_get_version(gdata) >= 3)
+		return (void *)(((estatus_generic_data_v300 *)(gdata)) + 1);
+
+	return gdata + 1;
+}
+
+static inline int estatus_get_error_length(estatus_generic_data *gdata)
+{
+	return gdata->error_data_length;
+}
+
+static inline int estatus_get_size(estatus_generic_data *gdata)
+{
+	if (estatus_get_version(gdata) >= 3)
+		return sizeof(estatus_generic_data_v300);
+
+	return sizeof(estatus_generic_data);
+}
+
+static inline int estatus_get_record_size(estatus_generic_data *gdata)
+{
+	return (estatus_get_size(gdata) + estatus_get_error_length(gdata));
+}
+
+static inline void *estatus_get_next(estatus_generic_data *gdata)
+{
+	return (void *)(gdata) + estatus_get_record_size(gdata);
+}
+
+static inline estatus_generic_data *
+estatus_first_section(estatus_generic_status *estatus)
+{
+	return (estatus_generic_data *)(estatus + 1);
+}
+
+static inline bool
+estatus_section_valid(estatus_generic_status *estatus,
+		      estatus_generic_data *section)
+{
+	return (void *)section - (void *)(estatus + 1) < estatus->data_length;
+}
+
+struct estatus_section_iter {
+	estatus_generic_status *estatus;
+	estatus_generic_data *section;
+	bool started;
+};
+
+static inline estatus_generic_data *
+estatus_section_iter_next(struct estatus_section_iter *iter,
+			  estatus_generic_status *estatus)
+{
+	if (!iter->started) {
+		iter->estatus = estatus;
+		iter->section = estatus_first_section(estatus);
+		iter->started = true;
+	} else if (iter->section) {
+		iter->section = estatus_get_next(iter->section);
+	}
+
+	if (!iter->section)
+		return NULL;
+
+	if (!estatus_section_valid(iter->estatus, iter->section)) {
+		iter->section = NULL;
+		return NULL;
+	}
+
+	return iter->section;
+}
+
+#define estatus_for_each_section(_estatus, _section)				\
+	for (struct estatus_section_iter __estatus_iter = {0};		\
+	     ((_section) = estatus_section_iter_next(&__estatus_iter, (_estatus))); \
+	     )
+
+static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_version(gdata);
+}
+
+static inline void *acpi_hest_get_payload(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_payload(gdata);
+}
+
+static inline int acpi_hest_get_error_length(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_error_length(gdata);
+}
+
+static inline int acpi_hest_get_size(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_size(gdata);
+}
+
+static inline int acpi_hest_get_record_size(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_record_size(gdata);
+}
+
+static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
+{
+	return estatus_get_next(gdata);
+}
+
+#define apei_estatus_for_each_section(estatus, section)			\
+	estatus_for_each_section(estatus, section)
+
+#endif
-- 
2.43.0


