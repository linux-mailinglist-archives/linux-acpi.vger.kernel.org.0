Return-Path: <linux-acpi+bounces-11594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9708EA48BFE
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8903F16D1E1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9886A23E354;
	Thu, 27 Feb 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+0XG61J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CA2036FA;
	Thu, 27 Feb 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696522; cv=none; b=kcHhHKXLEMfPVdyJkUGIEaCI5anDVEkGj0aq2916mJZnhyieKld6yCsG2KvlHbW21bKxbb+gxDRld1v5x2ed68XrWsyzIHyC2lrhK5ksrKZ0pzwpLQilO110Zuew0Bg8LF/F8uoe3LgY0At0LJjsz1YMxW3Ko74B6jUCrVQl7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696522; c=relaxed/simple;
	bh=3Yu9IE/Z9DkuRxYELdGayJyznkA5d5/ZrNOPeDv0jwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU+MJg3CEoNM374ytZRtghAXwYzC+//fBtLEEO9BtszO6mZh9UI+CrHSLmqVTl+TOnOuLv6cOKiat1evApZTy5WWtIw655aiX+1EJ3FD1abhnEPicPWFzIOL6MTD/ET6aUWw36nhI57JUMvTVMjfKATtX99kK2RXzcA+UCqtMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+0XG61J; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740696521; x=1772232521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Yu9IE/Z9DkuRxYELdGayJyznkA5d5/ZrNOPeDv0jwk=;
  b=k+0XG61JskxK5E/WXWPc4Ea4VZtl8ps4DKPjeNdsbvge90XoNwRsWqUK
   q1ufHx+xaWb13VZ+F9lPLUSE3peht+3t9HQ6XyU2syQmjvfRvLNksKfEb
   v0oITbXWoCLws5sm3AGTVsbQh1TwhpSb1E/4WkM9ZOiUObXyOsv30rQyF
   XUcRgFDeVUyFfm8ByE5t0sWPuAI04a32G/HwqXT7RGB/hiU01bOgLpQg/
   epMRGgfiBuqpLOITsxHGl8tbrXQuaNncERQSaGinYVUGAANRZp+I0otBy
   lK3NTvEtD0dU/abhnXf7EagtiwxqKxftPvF0KdLs9cSi0heg0m3QA2yCY
   Q==;
X-CSE-ConnectionGUID: oSTuSMKRTyyndjTjaya3hg==
X-CSE-MsgGUID: fgaRz3RRTEeEQPE5xOgNpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64077564"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="64077564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:39 -0800
X-CSE-ConnectionGUID: Lx3V3JjlSrStGHsEoI7DYg==
X-CSE-MsgGUID: ae51hzlcSme4pz0e/Q4YXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117187049"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:39 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/4] ACPI/MRRM: Create /sys/firmware/acpi/memory_ranges/rangeX ABI
Date: Thu, 27 Feb 2025 14:48:26 -0800
Message-ID: <20250227224828.306537-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227224828.306537-1-tony.luck@intel.com>
References: <20250227224828.306537-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf and resctrl users need an enumeration of which memory addresses
are bound to which "region" tag.

Parse the ACPI MRRM table and add /sys entries for each memory range
describing base address, length, and which region tags apply for
same-socket and cross-socket access.

[Derived from code developed by Fenghua Yu <fenghua.yu@intel.com>]

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/acpi.h     |   6 ++
 drivers/acpi/acpi_mrrm.c | 161 +++++++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig         |   1 +
 drivers/acpi/Kconfig     |   3 +
 drivers/acpi/Makefile    |   1 +
 5 files changed, 172 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640..677a9c4fa355 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -773,6 +773,12 @@ int acpi_get_local_u64_address(acpi_handle handle, u64 *addr);
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
 const char *acpi_get_subsystem_id(acpi_handle handle);
 
+#ifdef CONFIG_ACPI_MRRM
+int acpi_mrrm_max_mem_region(void);
+#else
+static inline int acpi_mrrm_max_mem_region(void) { return -ENOENT; }
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
new file mode 100644
index 000000000000..1f7d0381a628
--- /dev/null
+++ b/drivers/acpi/acpi_mrrm.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Intel Corporation.
+ *
+ * Memory Range and Region Mapping (MRRM) structure
+ *
+ * Parse and report the platform's MRRM table in /sys.
+ */
+
+#define pr_fmt(fmt) "acpi/mrrm: " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+static int max_mem_region = -ENOENT;
+
+/* Access for use by resctrl file system */
+int acpi_mrrm_max_mem_region(void)
+{
+	return max_mem_region;
+}
+
+struct mrrm_mem_range_entry {
+	u64 base;
+	u64 length;
+	u8  local_region_id;
+	u8  remote_region_id;
+};
+
+static struct mrrm_mem_range_entry *mrrm_mem_range_entry;
+static u32 mrrm_mem_entry_num;
+
+static __init int acpi_parse_mrrm(struct acpi_table_header *table)
+{
+	struct acpi_mrrm_mem_range_entry *mre_entry;
+	struct acpi_table_mrrm *mrrm;
+	void *mre, *mrrm_end;
+	int mre_count = 0;
+
+	mrrm = (struct acpi_table_mrrm *)table;
+	if (!mrrm)
+		return -ENODEV;
+
+	if (mrrm->flags & ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS)
+		return -EOPNOTSUPP;
+
+	mrrm_end = (void *)mrrm + mrrm->header.length - 1;
+	mre = (void *)mrrm + sizeof(struct acpi_table_mrrm);
+	while (mre < mrrm_end) {
+		mre_entry = mre;
+		mre_count++;
+		mre += mre_entry->header.length;
+	}
+	if (!mre_count) {
+		pr_info(FW_BUG "No ranges listed in MRRM table\n");
+		return -EINVAL;
+	}
+
+	mrrm_mem_range_entry = kmalloc_array(mre_count, sizeof(*mrrm_mem_range_entry),
+					     GFP_KERNEL | __GFP_ZERO);
+	if (!mrrm_mem_range_entry)
+		return -ENOMEM;
+
+	mre = (void *)mrrm + sizeof(struct acpi_table_mrrm);
+	while (mre < mrrm_end) {
+		struct mrrm_mem_range_entry *e;
+
+		mre_entry = mre;
+		e = mrrm_mem_range_entry + mrrm_mem_entry_num;
+
+		e->base = mre_entry->addr_base;
+		e->length = mre_entry->addr_len;
+
+		if (mre_entry->region_id_flags & ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL)
+			e->local_region_id = mre_entry->local_region_id;
+		else
+			e->local_region_id = -1;
+		if (mre_entry->region_id_flags & ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE)
+			e->remote_region_id = mre_entry->remote_region_id;
+		else
+			e->remote_region_id = -1;
+
+		mrrm_mem_entry_num++;
+		mre += mre_entry->header.length;
+	}
+
+	max_mem_region = mrrm->max_mem_region;
+
+	return 0;
+}
+
+#define RANGE_ATTR(name)						\
+static ssize_t name##_show(struct kobject *kobj,			\
+			  struct kobj_attribute *attr, char *buf)	\
+{									\
+	struct mrrm_mem_range_entry *mre;				\
+	const char *kname = kobject_name(kobj);				\
+	int n, ret;							\
+									\
+	ret = kstrtoint(kname + 5, 10, &n);				\
+	if (ret)							\
+		return ret;						\
+									\
+	mre = mrrm_mem_range_entry + n;					\
+									\
+	return sysfs_emit(buf, "0x%lx\n", (unsigned long)mre->name);	\
+}									\
+static struct kobj_attribute name##_attr = __ATTR_RO(name)
+
+RANGE_ATTR(base);
+RANGE_ATTR(length);
+RANGE_ATTR(local_region_id);
+RANGE_ATTR(remote_region_id);
+
+static struct attribute *memory_range_attrs[] = {
+	&base_attr.attr,
+	&length_attr.attr,
+	&local_region_id_attr.attr,
+	&remote_region_id_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(memory_range);
+
+static __init int add_boot_memory_ranges(void)
+{
+	struct kobject *pkobj, *kobj;
+	int ret = -EINVAL;
+	char *name;
+
+	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
+
+	for (int i = 0; i < mrrm_mem_entry_num; i++) {
+		name = kasprintf(GFP_KERNEL, "range%d", i);
+		if (!name)
+			break;
+
+		kobj = kobject_create_and_add(name, pkobj);
+
+		ret = sysfs_create_groups(kobj, memory_range_groups);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static __init int mrrm_init(void)
+{
+	int ret;
+
+	ret = acpi_table_parse(ACPI_SIG_MRRM, acpi_parse_mrrm);
+
+	if (ret < 0)
+		return ret;
+
+	return add_boot_memory_ranges();
+}
+device_initcall(mrrm_init);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..f77af6b3c6cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -36,6 +36,7 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
+	select ACPI_MRRM if ACPI
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d81b55f5068c..4f9aea2d0bc8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,9 @@ config ACPI_FFH
 	  Enable this feature if you want to set up and install the FFH Address
 	  Space handler to handle FFH OpRegion in the firmware.
 
+config ACPI_MRRM
+	bool
+
 source "drivers/acpi/pmic/Kconfig"
 
 config ACPI_VIOT
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0f5dfb..5092b518fc9b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,6 +62,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
 acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
 acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
+acpi-$(CONFIG_ACPI_MRRM)	+= acpi_mrrm.o
 
 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
-- 
2.48.1


