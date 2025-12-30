Return-Path: <linux-acpi+bounces-19903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1321CE92E0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D768730046FE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A4285061;
	Tue, 30 Dec 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xkhvx+sA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5726B76A;
	Tue, 30 Dec 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085999; cv=none; b=KL0SvCrzLiJHHxI/8bT5EsI6Wgh4CjaSnEtCGYMY5VXhG7QlWKsKtBfSW5h+0a2F0O/voognugWHiIf4aWZKZvnniTnGfQPOVW5LHIKUvm3YZ4CGFR+D5N1BcGkdfbFrDInM9hhFWjJ+EradCI6mmXs3OadfHiqarm7EaV08sjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085999; c=relaxed/simple;
	bh=pYH4r/VOxd9f5KC/eLOMoBtF7FpF2+/kA1loecekW6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNAx+egiI0Mdq0VITtJjknsKGhhQQ+T3cl6fFVKug2t+W+flF4G8SejEJ6mZEozqbOi/l5hdCA/rxUUJLIJ12NsvXVVZL1muJPW86RxErbq07dxO3xDk2oA9eB2lvDZrEcHWoV4cKkKKVFm1wLprieG0WVDrO9v/roH4uWfkrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xkhvx+sA; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085994; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vMFQJfvTUs2z5Ro/IYmUFu3yZRFtt+Ivtc6RNYrCS4w=;
	b=xkhvx+sAPDfLgFcRcv6zWih6qjRkWzHBdqnc1a1yE72oF9OYIVSqJWrXEhwvzvmTYzpLQKJK6a3O2OSvBGya0iJ7jsivyIAMEj8Ovo/JNgpiJSaAU/mFGN/0z8YOhQOTcWmt9wXEbtf6WN9cTs1rx4vuWcd34zj9Gf3LwKNtiLI=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzYKpN_1767085991 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:13:13 +0800
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
Subject: [PATCH v5 13/17] ras: AEST: Introduce AEST inject interface to test AEST driver
Date: Tue, 30 Dec 2025 17:13:10 +0800
Message-Id: <20251230091310.49641-1-tianruidong@linux.alibaba.com>
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

AEST offers both soft and hard injection. Soft injection simulates errors
in software, providing flexibility to define the error register content.
Hard injection, on the other hand, utilizes error injection registers to
introduce hardware faults, strictly requiring values that adhere to their
specifications.

Read Documentation/ABI/testing/debugfs-aest to learn how to use them.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest |  37 +++++++
 drivers/ras/aest/Makefile              |   1 +
 drivers/ras/aest/aest-core.c           |  24 +++--
 drivers/ras/aest/aest-inject.c         | 131 +++++++++++++++++++++++++
 drivers/ras/aest/aest-sysfs.c          |   8 +-
 drivers/ras/aest/aest.h                |   2 +
 6 files changed, 193 insertions(+), 10 deletions(-)
 create mode 100644 drivers/ras/aest/aest-inject.c

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 4d160072d37a..cc41ea7032c7 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -60,3 +60,40 @@ KernelVersion	6.19
 Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Outputs error statistics for all this records.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/inject/err_*
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RW) These registers are used to simulate soft injection errors
+		by holding error register values. You can write any values
+		to them. To trigger the injection, you need to write soft_inject
+		at last. The validity of the injected error depends on the
+		value written to err_status.
+
+		Accepts values -  any.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/inject/soft_inject
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) Write any value to this file to trigger the error
+		injection. Make sure you have specified all necessary error
+		parameters, i.e. this write should be the last step when
+		injecting errors.
+
+		Accepts values -  any.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/inject/hard_inject
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) If the AEST table provides error injection registers,
+		you can write to them via this interface. For instance,
+		values can be written to the ERXPFGCTL register. The post-injection
+		behavior is then determined by the hardware specification.
+
+		Accepts values - any.
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
index 75495413d2b6..5ee10fc8b2e9 100644
--- a/drivers/ras/aest/Makefile
+++ b/drivers/ras/aest/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_AEST) 	+= aest.o
 
 aest-y		:= aest-core.o
 aest-y		+= aest-sysfs.o
+aest-y		+= aest-inject.o
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 75cca98024ad..a290b482bf8b 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -273,7 +273,7 @@ static void aest_panic(struct aest_record *record, struct ras_ext_regs *regs,
 	panic(msg);
 }
 
-static void aest_proc_record(struct aest_record *record, void *data)
+void aest_proc_record(struct aest_record *record, void *data, bool fake)
 {
 	struct ras_ext_regs regs = { 0 };
 	int *count = data;
@@ -315,9 +315,15 @@ static void aest_proc_record(struct aest_record *record, void *data)
 	/* panic if unrecoverable and uncontainable error encountered */
 	ue = FIELD_GET(ERR_STATUS_UET, regs.err_status);
 	if ((regs.err_status & ERR_STATUS_UE) &&
-	    (ue == ERR_STATUS_UET_UC || ue == ERR_STATUS_UET_UEU))
-		aest_panic(record, &regs,
-			   "AEST: unrecoverable error encountered");
+	    (ue == ERR_STATUS_UET_UC || ue == ERR_STATUS_UET_UEU)) {
+		if (fake)
+			aest_record_info(
+				record,
+				"Simulated error! Skip panic due to fault injection\n");
+		else
+			aest_panic(record, &regs,
+				   "AEST: unrecoverable error encountered");
+	}
 
 	aest_log(record, &regs);
 
@@ -335,7 +341,8 @@ static void aest_proc_record(struct aest_record *record, void *data)
 	record_write(record, ERXSTATUS, regs.err_status);
 }
 
-static void aest_node_foreach_record(void (*func)(struct aest_record *, void *),
+static void aest_node_foreach_record(void (*func)(struct aest_record *, void *,
+						  bool),
 				     struct aest_node *node, void *data,
 				     unsigned long *bitmap)
 {
@@ -344,7 +351,7 @@ static void aest_node_foreach_record(void (*func)(struct aest_record *, void *),
 	for_each_clear_bit(i, bitmap, node->record_count) {
 		aest_select_record(node, i);
 
-		func(&node->records[i], data);
+		func(&node->records[i], data, false);
 
 		aest_sync(node);
 	}
@@ -379,7 +386,7 @@ static int aest_proc(struct aest_node *node)
 			if (test_bit(i * BITS_PER_LONG + j,
 				     node->status_reporting))
 				continue;
-			aest_proc_record(&node->records[j], &count);
+			aest_proc_record(&node->records[j], &count, false);
 		}
 	}
 
@@ -595,7 +602,8 @@ static int aest_init_record(struct aest_record *record, int i,
 	return 0;
 }
 
-static void aest_online_record(struct aest_record *record, void *data)
+static void aest_online_record(struct aest_record *record, void *data,
+			       bool __unused)
 {
 	if (record_read(record, ERXFR) & ERR_FR_CE)
 		aest_set_ce_threshold(record);
diff --git a/drivers/ras/aest/aest-inject.c b/drivers/ras/aest/aest-inject.c
new file mode 100644
index 000000000000..fe6ccac8338e
--- /dev/null
+++ b/drivers/ras/aest/aest-inject.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2024, Alibaba Group.
+ */
+
+#include "aest.h"
+
+static struct ras_ext_regs regs_inj;
+
+struct inj_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct aest_node *n, struct inj_attr *a, char *b);
+	ssize_t (*store)(struct aest_node *n, struct inj_attr *a, const char *b,
+				size_t c);
+};
+
+struct aest_inject {
+	struct aest_node *node;
+	struct kobject kobj;
+};
+
+#define to_inj(k)	container_of(k, struct aest_inject, kobj)
+#define to_inj_attr(a)	container_of(a, struct inj_attr, attr)
+
+static u64 aest_sysreg_read_inject(void *__unused, u32 offset)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	return p[offset/8];
+}
+
+static void aest_sysreg_write_inject(void *base, u32 offset, u64 val)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	p[offset/8] = val;
+}
+
+static u64 aest_iomem_read_inject(void *base, u32 offset)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	return p[offset/8];
+}
+
+static void aest_iomem_write_inject(void *base, u32 offset, u64 val)
+{
+	u64 *p = (u64 *)&regs_inj;
+
+	p[offset/8] = val;
+}
+
+static struct aest_access aest_access_inject[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = aest_sysreg_read_inject,
+		.write = aest_sysreg_write_inject,
+	},
+
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = aest_iomem_read_inject,
+		.write = aest_iomem_write_inject,
+	},
+	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
+		.read = aest_iomem_read_inject,
+		.write = aest_iomem_write_inject,
+	},
+	{ }
+};
+
+static int soft_inject_store(void *data, u64 val)
+{
+	int count = 0;
+	struct aest_record record_inj, *record = data;
+	struct aest_node node_inj, *node = record->node;
+
+	memcpy(&node_inj, node, sizeof(*node));
+	node_inj.name = "AEST-injection";
+
+	record_inj.access = &aest_access_inject[node->info->interface_hdr->type];
+	record_inj.node = &node_inj;
+	record_inj.index = record->index;
+
+	regs_inj.err_status |= ERR_STATUS_V;
+
+	aest_proc_record(&record_inj, &count, true);
+
+	if (count != 1)
+		return -EIO;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(soft_inject_ops, NULL, soft_inject_store, "%llu\n");
+
+static int hard_inject_store(void *data, u64 val)
+{
+	struct aest_record *record = data;
+	struct aest_node *node = record->node;
+
+	if (!node->inj)
+		return -EPERM;
+
+	aest_select_record(node, record->index);
+	record_write(record, ERXPFGCTL, val);
+	record_write(record, ERXPFGCDN, 0x100);
+	aest_sync(node);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(hard_inject_ops, NULL, hard_inject_store, "%llu\n");
+
+void aest_inject_init_debugfs(struct aest_record *record)
+{
+	struct dentry *inj;
+
+	inj = debugfs_create_dir("inject", record->debugfs);
+
+	debugfs_create_u64("err_fr", 0600, inj, &regs_inj.err_fr);
+	debugfs_create_u64("err_ctrl", 0600, inj, &regs_inj.err_ctlr);
+	debugfs_create_u64("err_status", 0600, inj, &regs_inj.err_status);
+	debugfs_create_u64("err_addr", 0600, inj, &regs_inj.err_addr);
+	debugfs_create_u64("err_misc0", 0600, inj, &regs_inj.err_misc[0]);
+	debugfs_create_u64("err_misc1", 0600, inj, &regs_inj.err_misc[1]);
+	debugfs_create_u64("err_misc2", 0600, inj, &regs_inj.err_misc[2]);
+	debugfs_create_u64("err_misc3", 0600, inj, &regs_inj.err_misc[3]);
+	debugfs_create_file("soft_inject", 0400, inj, record, &soft_inject_ops);
+
+	if (record->node->inj)
+		debugfs_create_file("hard_inject", 0400, inj, record, &hard_inject_ops);
+}
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index 392e7ad8328e..66e9c1103f99 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -158,6 +158,7 @@ static void aest_record_init_debugfs(struct aest_record *record)
 						&aest_record_err_count_fops);
 	debugfs_create_file("ce_threshold", 0600, record->debugfs, record,
 						&record_ce_threshold_ops);
+	aest_inject_init_debugfs(record);
 }
 
 static void
@@ -190,8 +191,8 @@ aest_oncore_dev_init_debugfs(struct aest_device *adev)
 	for_each_possible_cpu(cpu) {
 		percpu_dev = this_cpu_ptr(adev->adev_oncore);
 
-		snprintf(name, sizeof(name), "processor%u", cpu);
-		percpu_dev->debugfs = debugfs_create_dir(name, aest_debugfs);
+		snprintf(name, sizeof(name), "processor%u%u", cpu);
+		percpu_dev->debugfs = debugfs_create_dir(name, adev->debugfs);
 
 		for (i = 0; i < adev->node_cnt; i++) {
 			node = &adev->nodes[i];
@@ -208,6 +209,9 @@ void aest_dev_init_debugfs(struct aest_device *adev)
 	int i;
 	struct aest_node *node;
 
+	if (!aest_debugfs)
+		dev_err(adev->dev, "debugfs not enabled\n");
+
 	adev->debugfs = debugfs_create_dir(dev_name(adev->dev), aest_debugfs);
 	if (aest_dev_is_oncore(adev)) {
 		aest_oncore_dev_init_debugfs(adev);
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 802430857dc4..2f6a7b9ca4ef 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -362,3 +362,5 @@ static inline bool aest_dev_is_oncore(struct aest_device *adev)
 }
 
 void aest_dev_init_debugfs(struct aest_device *adev);
+void aest_inject_init_debugfs(struct aest_record *record);
+void aest_proc_record(struct aest_record *record, void *data, bool fake);
-- 
2.47.3


