Return-Path: <linux-acpi+bounces-19756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE18CD5602
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A0B5304D49E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF63312800;
	Mon, 22 Dec 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KfeVdgib"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074E311C21;
	Mon, 22 Dec 2025 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396661; cv=none; b=OVxoR4xFHmzcO6t1rYycg/HYtKxKV9enaqrvXiphlhOPKyCzPL8vqsBSySrFUz3YUPPJiAvCZ4o5Uor09JadUllBYhtkDZG9Y9G6ispCkwuanzIr8127Vyv4jGyg5szL5dgMD0o99HbZeF6puLPvHMTwsR1mZ+xdixeHJdNC474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396661; c=relaxed/simple;
	bh=ITIj0lBVMPLmiOa+cB6SF5mDxSiBQpFd7QgPmvkO2GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMkSdadCgbW/hQQNjFXTgLCRVuXb5AWUfQxEXfa3U43Rf+x1pQoVjVxXn0EEVLfLzbJMvZ7lJTgB7qaweazfYOw5HxXugmI72EHqs4JDH03poNHDgvPkv6fuOuMR7YRoOX2Sh/XaqPy7r/Du9a/NEHEYwkn/D5N2uP4HMVwbkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KfeVdgib; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396651; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jREerp1UUtlvwq6DucOPbqJRI1tz6hZrq/qDog8bRt8=;
	b=KfeVdgibMoRdwwVHOutQJDMg5yCUFGq4w1DrNI0xdUWpv9mGy6nXjYURJEnn1ADEe6qRlwbv25RyS/3LQabth3ZoIbrMC3sP1v0syKvEJ5yGK23hF3pzX/18aTbYdyJtiKQ7sqdqyv0HDhesXybspmYdBeZZkMRc4lrtfCZTemo=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvORvOX_1766396649 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:10 +0800
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
Subject: [PATCH v4 04/17] ras: AEST: Unify the read/write interface for system and MMIO register
Date: Mon, 22 Dec 2025 17:43:37 +0800
Message-Id: <20251222094351.38792-5-tianruidong@linux.alibaba.com>
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

Use record_read/write to simultaneously read and write system registers and
MMIO registers while maintaining code conciseness.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c |  1 +
 drivers/ras/aest/aest.h      | 94 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index acebb293ac75..f4a5119dc513 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -29,6 +29,7 @@ static int aest_init_record(struct aest_record *record, int i,
 		record->regs_base =
 			node->base + sizeof(struct ras_ext_regs) * i;
 
+	record->access = &aest_access[node->info->interface_hdr->type];
 	record->addressing_mode = test_bit(i, node->info->addressing_mode);
 	record->index = i;
 	record->node = node;
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index 3250675e99b7..31131cce9928 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -10,6 +10,11 @@
 
 #define MAX_GSI_PER_NODE 2
 
+#define record_read(record, offset) \
+	record->access->read(record->regs_base, offset)
+#define record_write(record, offset, val) \
+	record->access->write(record->regs_base, offset, val)
+
 #define aest_dev_err(__adev, format, ...) \
 	dev_err((__adev)->dev, format, ##__VA_ARGS__)
 #define aest_dev_info(__adev, format, ...) \
@@ -47,6 +52,20 @@
 #define ERXGROUP_16K_ERRGSR_NUM 4
 #define ERXGROUP_64K_ERRGSR_NUM 14
 
+#define ERXFR 0x0
+#define ERXCTLR 0x8
+#define ERXSTATUS 0x10
+#define ERXADDR 0x18
+#define ERXMISC0 0x20
+#define ERXMISC1 0x28
+#define ERXMISC2 0x30
+#define ERXMISC3 0x38
+
+struct aest_access {
+	u64 (*read)(void *base, u32 offset);
+	void (*write)(void *base, u32 offset, u64 val);
+};
+
 struct aest_record {
 	char *name;
 	int index;
@@ -63,6 +82,7 @@ struct aest_record {
 	 */
 	int addressing_mode;
 	struct aest_node *node;
+	const struct aest_access *access;
 };
 
 struct aest_group {
@@ -159,3 +179,77 @@ static inline int aest_set_name(struct aest_device *adev,
 
 	return 0;
 }
+
+#define CASE_READ(res, x)                           \
+	case (x): {                                 \
+		res = read_sysreg_s(SYS_##x##_EL1); \
+		break;                              \
+	}
+
+#define CASE_WRITE(val, x)                            \
+	case (x): {                                   \
+		write_sysreg_s((val), SYS_##x##_EL1); \
+		break;                                \
+	}
+
+static inline u64 aest_sysreg_read(void *__unused, u32 offset)
+{
+	u64 res;
+
+	switch (offset) {
+		CASE_READ(res, ERXFR)
+		CASE_READ(res, ERXCTLR)
+		CASE_READ(res, ERXSTATUS)
+		CASE_READ(res, ERXADDR)
+		CASE_READ(res, ERXMISC0)
+		CASE_READ(res, ERXMISC1)
+		CASE_READ(res, ERXMISC2)
+		CASE_READ(res, ERXMISC3)
+	default :
+		res = 0;
+	}
+	return res;
+}
+
+static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
+{
+	switch (offset) {
+		CASE_WRITE(val, ERXFR)
+		CASE_WRITE(val, ERXCTLR)
+		CASE_WRITE(val, ERXSTATUS)
+		CASE_WRITE(val, ERXADDR)
+		CASE_WRITE(val, ERXMISC0)
+		CASE_WRITE(val, ERXMISC1)
+		CASE_WRITE(val, ERXMISC2)
+		CASE_WRITE(val, ERXMISC3)
+	default :
+		return;
+	}
+}
+
+static inline u64 aest_iomem_read(void *base, u32 offset)
+{
+	return readq_relaxed(base + offset);
+}
+
+static inline void aest_iomem_write(void *base, u32 offset, u64 val)
+{
+	writeq_relaxed(val, base + offset);
+}
+
+/* access type is decided by AEST interface type. */
+static const struct aest_access aest_access[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = aest_sysreg_read,
+		.write = aest_sysreg_write,
+	},
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = aest_iomem_read,
+		.write = aest_iomem_write,
+	},
+	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] = {
+		.read = aest_iomem_read,
+		.write = aest_iomem_write,
+	},
+	{ }
+};
-- 
2.51.2.612.gdc70283dfc


