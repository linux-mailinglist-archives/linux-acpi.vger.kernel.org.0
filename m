Return-Path: <linux-acpi+bounces-19894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00BCE9283
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBDCC30049F6
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B327A47F;
	Tue, 30 Dec 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OXg0g2p2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FB27A927;
	Tue, 30 Dec 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085810; cv=none; b=I22tdPj0It6Nl5G1mZ/vWclPXQVhSGq7V2q8Bg8t866fb9PINeheIJ5/02D2cIelFigRN3MKjFPeyMwci6Ib8e2oCb6RBF2f2dFfoHkF/8xFoYLrVd6QPhYVoHeLvC8ciiSzhIP1eiN2JnEV1tO6jTBuTIiiQUEY7YSjOGz6Ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085810; c=relaxed/simple;
	bh=ZC9GIpViHMJ+8wCUWENSxh4cNxLjSwk3cfIMSMvzW5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nqy5fA5hG86sU9ArNOE1wHs5SFA4pejs1IJV756JJ4Od3zDAJH8UKfMhp0V/JhVpZ+5ndWKzdouqgojkrs1I6Drj9R/xd4w9Cl2FMrwtNaTbj/ce2URWpdoa/lxOUNEpdyNyUKHgkfFXxoxsM70KueH0k1O8errSoKJBVORUkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OXg0g2p2; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085801; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0Ul1sx6SisOFhLh/di/2baASqMZA0nouNac7q4rV+e4=;
	b=OXg0g2p2/mT/TkIhFdy3dFkuJ/7zQ2NQl7ETj+mT1yBDXpoN/4JcYnR8dyEkyIcImQt4blSnBWO0D78ahPV4ADs7GmlPfsd/ynVpn1mFNmPsGrK/KtuRTMhBgAfkTCW3oVMy1B36JZuHrxbaYpyRx2TzQa4MmnqP1pSNzynB7Ag=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzWDA8_1767085799 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:10:01 +0800
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
Subject: [PATCH v5 04/17] ras: AEST: Unify the read/write interface for system and MMIO register
Date: Tue, 30 Dec 2025 17:09:32 +0800
Message-Id: <20251230090945.43969-5-tianruidong@linux.alibaba.com>
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
2.47.3


