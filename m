Return-Path: <linux-acpi+bounces-10974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FEA2FB84
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D5B1882519
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784324CECD;
	Mon, 10 Feb 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngxoJKQw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085124C67A;
	Mon, 10 Feb 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221955; cv=none; b=N+6dbn730PnUO8UR0+QQuPtmn1pHLf6+vK2JDKIfzYrCen608QI+NCuSMZ0kryFW9Q8aOLi0xUhDJCc+hksM89y55z6fy5o3q+/LW32O4/g3bGwH9Ioro1mGQZxi7vXV6SQbmzTvhL7Wm3rkWvIIzNvNIFug01TWqZVKPXdyeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221955; c=relaxed/simple;
	bh=pXZ11WvTQA0adNzVy9qi7XllhR+Pg+JRhUXICoa34fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTu3aAlynuNhIbnTAO6tVLXEO1igzBEIdyH+AT2dKEG1zqipDcYKYqFbbfqMd9lpIF3ANBHrHr/L5vx4OiMce8cQKm2i53e/sPKAKamJrsC2xIh+fteC1T4xsRuRSjMn9+OO3Ax2I7cCcdR+3S8KS9a6fHAgI7xy6f7alWqxwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngxoJKQw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221954; x=1770757954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXZ11WvTQA0adNzVy9qi7XllhR+Pg+JRhUXICoa34fQ=;
  b=ngxoJKQwN3ipNCHM4uSt1WgUCT/fz8cYzDIaJ0ExssWvUqou+Evhsbpm
   ZBpYR45YEdNGUdNURN0eY+nShfl7oIKfE/CF+wF4BSHhMmFcd3Gk72C2d
   MaBd+FQY+tMqLnLSzE1KtdqTJ0Sm4AdhAo88sQk6SHVt4GQgMFn/XuYY6
   r33Gt6mvIN6yHD1ls57X9wx00UtZDt1k/xAf6lJc+kevXWu5MHm0ph/Fz
   9PlUnfkSxBYo9IYyQMrwTJ+Q153ASmCA6el1sgR8lV+OOKqiSOEPgIu4l
   FfDNuQ/+VpxuVcvzwilRSymn2ieieF5VoswRhdFT26m00Ogx8gBDI3wm2
   g==;
X-CSE-ConnectionGUID: bkNJM/pVTCe62z2yRsKHyw==
X-CSE-MsgGUID: WQvP94wUSza8hHBDe0janw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39969755"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39969755"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
X-CSE-ConnectionGUID: fVKF8hFgR5uitkXDI0pWRQ==
X-CSE-MsgGUID: SGe+P9TuQRu8llXraQd0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116393884"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
From: Tony Luck <tony.luck@intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/4] ACPI/MRRM: Create /sys/devices/system/memory/rangeX ABI
Date: Mon, 10 Feb 2025 13:12:21 -0800
Message-ID: <20250210211223.6139-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210211223.6139-1-tony.luck@intel.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
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
 include/linux/memory.h   |   9 +++
 drivers/acpi/acpi_mrrm.c | 159 +++++++++++++++++++++++++++++++++++++++
 drivers/base/memory.c    |   9 +++
 arch/x86/Kconfig         |   1 +
 drivers/acpi/Kconfig     |   4 +
 drivers/acpi/Makefile    |   1 +
 6 files changed, 183 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c

diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..0a21943ce44d 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -189,4 +189,13 @@ void memory_block_add_nid(struct memory_block *mem, int nid,
  */
 extern struct mutex text_mutex;
 
+#ifdef CONFIG_ACPI_MRRM
+int mrrm_max_mem_region(void);
+int memory_subsys_device_register(struct device *dev);
+#else
+static inline int mrrm_max_mem_region(void) { return -EONENT; }
+static inline int memory_subsys_device_register(struct device *dev) { return -EINVAL; }
+#define memory_subsys_device_register memory_subsys_device_register
+#endif
+
 #endif /* _LINUX_MEMORY_H_ */
diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
new file mode 100644
index 000000000000..51ed9064e025
--- /dev/null
+++ b/drivers/acpi/acpi_mrrm.c
@@ -0,0 +1,159 @@
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
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/memory.h>
+#include <linux/sysfs.h>
+
+static int max_mem_region = -ENOENT;
+
+/* Access for use by resctrl file system */
+int mrrm_max_mem_region(void)
+{
+	return max_mem_region;
+}
+
+struct mrrm_mem_range_entry {
+	struct device dev;
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
+	struct acpi_table_mrrm_mem_range_entry *mre_entry;
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
+		mre += mre_entry->length;
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
+		e->base = ((u64)mre_entry->base_addr_high << 32) + mre_entry->base_addr_low;
+		e->length = ((u64)mre_entry->len_high << 32) + mre_entry->len_low;
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
+		mre += mre_entry->length;
+	}
+
+	max_mem_region = mrrm->max_mem_region;
+
+	return 0;
+}
+
+#define RANGE_ATTR(name)						\
+static ssize_t name##_show(struct device *dev,				\
+			  struct device_attribute *attr, char *buf)	\
+{									\
+	struct mrrm_mem_range_entry *mre;				\
+									\
+	mre = container_of(dev, struct mrrm_mem_range_entry, dev);	\
+	return sysfs_emit(buf, "0x%lx\n", (unsigned long)mre->name);	\
+}									\
+static DEVICE_ATTR_RO(name)
+
+RANGE_ATTR(base);
+RANGE_ATTR(length);
+RANGE_ATTR(local_region_id);
+RANGE_ATTR(remote_region_id);
+
+static struct attribute *memory_range_attrs[] = {
+	&dev_attr_base.attr,
+	&dev_attr_length.attr,
+	&dev_attr_local_region_id.attr,
+	&dev_attr_remote_region_id.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(memory_range);
+
+static __init int add_boot_memory_ranges(void)
+{
+	char name[16];
+	int i, ret;
+
+	for (i = 0; i < mrrm_mem_entry_num; i++) {
+		struct mrrm_mem_range_entry *entry;
+
+		entry = mrrm_mem_range_entry + i;
+
+		sprintf(name, "range%d", i);
+		entry->dev.init_name = name;
+
+		entry->dev.id = i;
+		entry->dev.groups = memory_range_groups;
+
+		ret = memory_subsys_device_register(&entry->dev);
+		if (ret) {
+			put_device(&entry->dev);
+			return ret;
+		}
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
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68..1f7853a4df5c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -699,6 +699,15 @@ static int __add_memory_block(struct memory_block *memory)
 	return ret;
 }
 
+#ifndef memory_subsys_device_register
+int memory_subsys_device_register(struct device *dev)
+{
+	dev->bus = &memory_subsys;
+
+	return device_register(dev);
+}
+#endif
+
 static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
 						     int nid)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..96aa73e8fb13 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -36,6 +36,7 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
+	select ACPI_MRRM			if MEMORY_HOTPLUG
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d81b55f5068c..c3d1b0217e99 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,10 @@ config ACPI_FFH
 	  Enable this feature if you want to set up and install the FFH Address
 	  Space handler to handle FFH OpRegion in the firmware.
 
+config ACPI_MRRM
+	bool
+	depends on MEMORY_HOTPLUG
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


