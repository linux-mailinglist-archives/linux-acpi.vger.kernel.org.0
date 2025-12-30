Return-Path: <linux-acpi+bounces-19901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E6CE92BF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CF56301936C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D296BB5;
	Tue, 30 Dec 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YoWrP86z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C828CF42;
	Tue, 30 Dec 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085829; cv=none; b=bZ2xy80VhvIBWf/tL7wrt/SbgLUf6HhLCW7Lc+y+3GhDhul2uMjBKj7eXJwYv9Ecmqg4bqc8yohUUC8LQMhBL4sHklSXzABESfjdBhlKqbMjSFCTZdn7aaV1gvx7xLawOSTO1nQpJOok2LSXjbnIFe3fzGidPXRx8UOfLO7QNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085829; c=relaxed/simple;
	bh=MFS5bXP2p+LYZR9hqvHsrGWijnrQENHEUA0youdne+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEQT71fC5q9R44lqoutuUD+P24482rPIPjuy61UPZXFAQEG5ncjcm9bIM2YKTzQLONh1FTxn69CehYcmpM6x7xkGZ93D2ryPeewqOEMfjhuKOCK53pkOhUxsoedrscz48QaKhbuers9tL8Pg86MYR5Fp5sdeZqwghHNrRcGPjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YoWrP86z; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085818; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5gZ+FgszbOmNjP1Y5tdd/BPgkyRM7WgfN7qlfJ3utgA=;
	b=YoWrP86zpgAUM39FKNhvX7AJMFAZGyNm4qCA3FjDSZq/b5utZevcazhLTdqg49AifuQP4g9M8kugucc+eMG2qxWzpPhRPmqOOhjIr2MLcStSrmdFevBu6zhsCQpMZOugXtXSSd1oaslUQ2V58cPT+o7S5iMKbNbH2FaEpzVUiIQ=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzYJcp_1767085816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:10:17 +0800
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
Subject: [PATCH v5 11/17] ras: AEST: Add error count tracking and debugfs interface
Date: Tue, 30 Dec 2025 17:09:39 +0800
Message-Id: <20251230090945.43969-12-tianruidong@linux.alibaba.com>
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

This commit introduces error counting functionality for AEST records.
Previously, error statistics were not directly available for individual
error records or AEST nodes.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest | 14 ++++++
 drivers/ras/aest/aest-core.c           | 21 +++++++++
 drivers/ras/aest/aest-sysfs.c          | 64 ++++++++++++++++++++++++++
 drivers/ras/aest/aest.h                | 10 ++++
 4 files changed, 109 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 8bacc6bb20b6..295df9e9b455 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -24,9 +24,23 @@ Description:
 		See more at:
 			https://developer.arm.com/documentation/den0085/latest/
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/err_count
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RO) Outputs error statistics for all error records of this node.
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_*
 Date:		Dec 2025
 KernelVersion:	6.19
 Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Read err_* register and return val.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_count
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RO) Outputs error statistics for all this records.
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 3bcc635cf8e4..75cca98024ad 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -170,6 +170,27 @@ static int aest_node_gen_pool_add(struct aest_device *adev,
 	init_aest_event(event, record, regs);
 	llist_add(&event->llnode, &adev->event_list);
 
+	if (regs->err_status & ERR_STATUS_CE)
+		record->count.ce++;
+	if (regs->err_status & ERR_STATUS_DE)
+		record->count.de++;
+	if (regs->err_status & ERR_STATUS_UE) {
+		switch (regs->err_status & ERR_STATUS_UET) {
+		case ERR_STATUS_UET_UC:
+			record->count.uc++;
+			break;
+		case ERR_STATUS_UET_UEU:
+			record->count.ueu++;
+			break;
+		case ERR_STATUS_UET_UER:
+			record->count.uer++;
+			break;
+		case ERR_STATUS_UET_UEO:
+			record->count.ueo++;
+			break;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index f3b5427ff4f0..b54e879506aa 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -7,6 +7,46 @@
 
 #include "aest.h"
 
+static void
+aest_error_count(struct aest_record *record, void *data)
+{
+	struct record_count *count = data;
+
+	count->ce += record->count.ce;
+	count->de += record->count.de;
+	count->uc += record->count.uc;
+	count->ueu += record->count.ueu;
+	count->uer += record->count.uer;
+	count->ueo += record->count.ueo;
+}
+
+/*******************************************************************************
+ *
+ * Debugfs for AEST node
+ *
+ ******************************************************************************/
+
+static int aest_node_err_count_show(struct seq_file *m, void *data)
+{
+	struct aest_node *node = m->private;
+	struct record_count count = { 0 };
+	int i;
+
+	for (i = 0; i < node->record_count; i++)
+		aest_error_count(&node->records[i], &count);
+
+	seq_printf(m, "CE: %llu\n"
+				"DE: %llu\n"
+				"UC: %llu\n"
+				"UEU: %llu\n"
+				"UEO: %llu\n"
+				"UER: %llu\n",
+				count.ce, count.de, count.uc, count.ueu,
+				count.uer, count.ueo);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(aest_node_err_count);
+
 /*******************************************************************************
  *
  * Attribute for AEST record
@@ -37,6 +77,25 @@ DEFINE_AEST_DEBUGFS_ATTR(err_misc1, ERXMISC1);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc2, ERXMISC2);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc3, ERXMISC3);
 
+static int aest_record_err_count_show(struct seq_file *m, void *data)
+{
+	struct aest_record *record = m->private;
+	struct record_count count = { 0 };
+
+	aest_error_count(record, &count);
+
+	seq_printf(m, "CE: %llu\n"
+				"DE: %llu\n"
+				"UC: %llu\n"
+				"UEU: %llu\n"
+				"UEO: %llu\n"
+				"UER: %llu\n",
+				count.ce, count.de, count.uc, count.ueu,
+				count.uer, count.ueo);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(aest_record_err_count);
+
 static void aest_record_init_debugfs(struct aest_record *record)
 {
 	debugfs_create_file("err_fr", 0600, record->debugfs, record,
@@ -55,6 +114,8 @@ static void aest_record_init_debugfs(struct aest_record *record)
 								&err_misc2_ops);
 	debugfs_create_file("err_misc3", 0600, record->debugfs, record,
 								&err_misc3_ops);
+	debugfs_create_file("err_count", 0400, record->debugfs, record,
+						&aest_record_err_count_fops);
 }
 
 static void
@@ -63,6 +124,9 @@ aest_node_init_debugfs(struct aest_node *node)
 	int i;
 	struct aest_record *record;
 
+	debugfs_create_file("err_count", 0400, node->debugfs, node,
+					&aest_node_err_count_fops);
+
 	for (i = 0; i < node->record_count; i++) {
 		record = &node->records[i];
 		if (!record->name)
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index ceb9e32bcee3..802430857dc4 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -116,6 +116,15 @@ struct ce_threshold {
 	u64 reg_val;
 };
 
+struct record_count {
+	u64 ce;
+	u64 de;
+	u64 uc;
+	u64 uer;
+	u64 ueo;
+	u64 ueu;
+};
+
 struct aest_record {
 	char *name;
 	int index;
@@ -136,6 +145,7 @@ struct aest_record {
 
 	struct ce_threshold ce;
 	enum ras_ce_threshold threshold_type;
+	struct record_count count;
 	struct dentry *debugfs;
 };
 
-- 
2.47.3


