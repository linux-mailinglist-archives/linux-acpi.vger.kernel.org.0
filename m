Return-Path: <linux-acpi+bounces-10674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447FA11C45
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CEF188ABCC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865311EEA32;
	Wed, 15 Jan 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mxg4qX8H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C031E7C34;
	Wed, 15 Jan 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930572; cv=none; b=NMIw91VbhC7ZrkcGj3MF8fdPFwaTyOhJdbMhbaNlYyAhXn82dFLuh3u0JcYeyM3uCLqhCou0iWWgyWyHj0TwadJsbQZEK+OxMgBYPfkudOI55eDVjpY+deQCXvkIac9MUMlkI6N4Ge3C7xnJAtuZPMRo3Lj2nNTPNrxP8Umj+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930572; c=relaxed/simple;
	bh=J+bbjmFVuXtZlK/YngJ2JUOmX9HZtGpHQr2OjWeMi1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlscOlJC9q4W4ggnxW63V0pgqF+cab0vjfbBtup8Cs50QacyxdPkqCpAIRsPUQ9b9352EvJhGtQPeyMk2Xruoas1IhNLMB1LzMIaxq+nS8YATkT+awOl50RNp0Ev2QtmecqXmkWMDrr/5OW1m6nScvoClnV9lwCVPceFmeVcDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mxg4qX8H; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736930561; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xjBRVnRNir2yorfiUax7O2/0CZ3MeEGVqbkYJk/5aoI=;
	b=mxg4qX8HOg1JTgNOQofYutO2/GCTVIdtrqdScr3NAN6pDPnWUuO/0OFrJ//I5QT4+o4OAyWXtrSYB9KoKqHZADhOgWaI6jY2jvHlTNrRAUhXtXI+sTfHPSvcFDvSZs04iV6IKpUveGbRWee1KSB6W41kjvFtzOICUH9mL/bVuuc=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WNhzd43_1736930559 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 16:42:40 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v3 3/5] RAS/AEST: Introduce AEST inject interface to test AEST driver
Date: Wed, 15 Jan 2025 16:42:26 +0800
Message-Id: <20250115084228.107573-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AEST injection interface can help to test how AEST driver process error
record which raise error.

This interface just raise a SW simulate error rather than HW error.

Example1:

1. write RAS register value to err_* file:
echo 0x... > <debugfs>/aest/<dev>/<node>/inject/err_fr
echo 0x... > <debugfs>/aest/<dev>/<node>/inject/err_status
echo 0x... > <debugfs>/aest/<dev>/<node>/inject/err_addr
echo 0x... > <debugfs>/aest/<dev>/<node>/inject/err_*

2. trigger the error:
echo -1 > <debugfs>/aest/<dev>/<node>/inject/inject

AEST driver will process this error with error register value specified
by user.

Example2:

1. just trigger the error:
echo n(record_cpunt > n >=0 ) > <debugfs>/aest/<dev>/<node>/inject/inject

AEST driver will process this error with error register values read
from record<n> of this node.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest |  17 +++
 drivers/ras/aest/Makefile              |   1 +
 drivers/ras/aest/aest-inject.c         | 151 +++++++++++++++++++++++++
 drivers/ras/aest/aest-sysfs.c          |   8 +-
 drivers/ras/aest/aest.h                |   2 +
 5 files changed, 177 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ras/aest/aest-inject.c

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 39d9c85843ef..4d3f4464cf98 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -96,3 +96,20 @@ KernelVersion	6.10
 Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Outputs error statistics for all this records.
+
+What:		/sys/devices/platform/AEST.<UID>/<Nome_name>/inject/err_*
+Date:		June 2024
+KernelVersion	6.10
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RW) Write any integer to this file to trigger the error
+		injection. Make sure you have specified all necessary error
+		parameters, i.e. this write should be the last step when
+		injecting errors.
+
+		Accepts values -  -1 or n ( 0 <= n < <record_count>).
+		-1 : If you write -1, make sure you specified all err_* file,
+		     driver will use these err_* value to proce AEST error.
+		n : Driver will read record<n> of this error node to collect
+		    error register value, and use these values to proce AEST
+		    error.
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
index 75495413d2b6..5ee10fc8b2e9 100644
--- a/drivers/ras/aest/Makefile
+++ b/drivers/ras/aest/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_AEST) 	+= aest.o
 
 aest-y		:= aest-core.o
 aest-y		+= aest-sysfs.o
+aest-y		+= aest-inject.o
diff --git a/drivers/ras/aest/aest-inject.c b/drivers/ras/aest/aest-inject.c
new file mode 100644
index 000000000000..2ca074aa021c
--- /dev/null
+++ b/drivers/ras/aest/aest-inject.c
@@ -0,0 +1,151 @@
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
+static u64 hard_inject_val;
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
+static int inject_store(void *data, u64 val)
+{
+	int i = val, count = 0;
+	struct aest_record record_inj, *record;
+	struct aest_node node_inj, *node = data;
+
+	if (i > (int)node->info->interface_hdr->error_record_count)
+		return -EINVAL;
+
+	memcpy(&node_inj, node, sizeof(*node));
+	node_inj.name = "AEST-injection";
+
+	record_inj.access = &aest_access_inject[node->info->interface_hdr->type];
+	record_inj.node = &node_inj;
+	record_inj.index = i;
+	if (i >= 0) {
+		record = &node->records[i];
+		regs_inj.err_fr = record_read(record, ERXFR);
+		regs_inj.err_ctlr = record_read(record, ERXCTLR);
+		regs_inj.err_status = record_read(record, ERXSTATUS);
+		regs_inj.err_addr = record_read(record, ERXADDR);
+		regs_inj.err_misc[0] = record_read(record, ERXMISC0);
+		regs_inj.err_misc[1] = record_read(record, ERXMISC1);
+		regs_inj.err_misc[2] = record_read(record, ERXMISC2);
+		regs_inj.err_misc[3] = record_read(record, ERXMISC3);
+	}
+
+	regs_inj.err_status |= ERR_STATUS_V;
+
+	aest_proc_record(&record_inj, &count);
+
+	if (count != 1)
+		return -EIO;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(inject_ops, NULL, inject_store, "%llu\n");
+
+static int hard_inject_store(void *data, u64 val)
+{
+	struct aest_node *node = data;
+
+	if (!node->inj)
+		return -EPERM;
+
+	if (val > node->record_count)
+		return -ENODEV;
+
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
+		aest_select_record(node, val);
+		write_sysreg_s(hard_inject_val, SYS_ERXPFGCTL_EL1);
+		write_sysreg_s(0x100, SYS_ERXPFGCDN_EL1);
+		aest_sync(node);
+	} else
+		writeq_relaxed(hard_inject_val, node->inj + val * 8);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(hard_inject_ops, NULL, hard_inject_store, "%llu\n");
+
+void aest_inject_init_debugfs(struct aest_node *node)
+{
+	struct dentry *inj;
+
+	inj = debugfs_create_dir("inject", node->debugfs);
+
+	debugfs_create_u64("err_fr", 0400, inj, &regs_inj.err_fr);
+	debugfs_create_u64("err_ctrl", 0400, inj, &regs_inj.err_ctlr);
+	debugfs_create_u64("err_status", 0400, inj, &regs_inj.err_status);
+	debugfs_create_u64("err_addr", 0400, inj, &regs_inj.err_addr);
+	debugfs_create_u64("err_misc0", 0400, inj, &regs_inj.err_misc[0]);
+	debugfs_create_u64("err_misc1", 0400, inj, &regs_inj.err_misc[1]);
+	debugfs_create_u64("err_misc2", 0400, inj, &regs_inj.err_misc[2]);
+	debugfs_create_u64("err_misc3", 0400, inj, &regs_inj.err_misc[3]);
+	debugfs_create_file("inject", 0400, inj, node, &inject_ops);
+
+	debugfs_create_file("hard_inject", 0600, inj, node, &hard_inject_ops);
+	debugfs_create_u64("hard_inject_val", 0600, inj, &hard_inject_val);
+}
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index f19cd2b5edb2..ba913556fc03 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -192,8 +192,8 @@ aest_oncore_dev_init_debugfs(struct aest_device *adev)
 	for_each_possible_cpu(cpu) {
 		percpu_dev = this_cpu_ptr(adev->adev_oncore);
 
-		snprintf(name, sizeof(name), "processor%u", cpu);
-		percpu_dev->debugfs = debugfs_create_dir(name, aest_debugfs);
+		snprintf(name, sizeof(name), "CPU%u", cpu);
+		percpu_dev->debugfs = debugfs_create_dir(name, adev->debugfs);
 
 		for (i = 0; i < adev->node_cnt; i++) {
 			node = &adev->nodes[i];
@@ -210,6 +210,9 @@ void aest_dev_init_debugfs(struct aest_device *adev)
 	int i;
 	struct aest_node *node;
 
+	if (!aest_debugfs)
+		dev_err(adev->dev, "debugfs not enabled\n");
+
 	adev->debugfs = debugfs_create_dir(dev_name(adev->dev), aest_debugfs);
 	if (aest_dev_is_oncore(adev)) {
 		aest_oncore_dev_init_debugfs(adev);
@@ -222,5 +225,6 @@ void aest_dev_init_debugfs(struct aest_device *adev)
 			continue;
 		node->debugfs = debugfs_create_dir(node->name, adev->debugfs);
 		aest_node_init_debugfs(node);
+		aest_inject_init_debugfs(node);
 	}
 }
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index d9a52e39b1b9..90a96e2666d3 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -334,3 +334,5 @@ aest_set_name(struct aest_device *adev, struct aest_hnode *ahnode)
 }
 
 void aest_dev_init_debugfs(struct aest_device *adev);
+void aest_inject_init_debugfs(struct aest_node *node);
+void aest_proc_record(struct aest_record *record, void *data);
-- 
2.33.1


