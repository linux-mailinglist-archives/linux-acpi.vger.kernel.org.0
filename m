Return-Path: <linux-acpi+bounces-19902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA46CE92DA
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8686C301672F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8528506F;
	Tue, 30 Dec 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sZRPe4pD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD0275114;
	Tue, 30 Dec 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085979; cv=none; b=TwYjZl6+JUqHhDTjWrs7LzxzHskYDqSWLw93ob5b42nT1p8Q/mjlvUT3PfwW6rZ7j8/H0m693tXnxvPysZMABb14WnNfjaFsk4T5UK8+6eWIPv9vorJ2IALpNZV27nJKGqjdH0+BH62jn/pnpsEjoEhBvHtMKDr+v0VC957RdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085979; c=relaxed/simple;
	bh=GEVjr7fudCkTye8lOjWvR9bkqBzUJ/UENdYag5JCUeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmPjbS33BhbqrF0t1xfc6KRqu6Kq1b0Z8cnp5sBcE9cDHiGjR7O8Z8ky/uVnxjt/grbbpRkPIuwr/PEGWVnsuhUtHNd7ApAYtfzY3O7Q3SyP0CY36k/naZup0CBX67ZssKi85T0kHC89FQ6jYKG9Euvhkr29Sa8CPCtIl2x//EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sZRPe4pD; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085975; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=523ljnXphvYWyh2qqOkyDzKwty7RiqB2tLyEg8M45UA=;
	b=sZRPe4pDDNW03EFdIRrByG1ChnWBKKUv+SdqIpX6yhvws/+75Cg1s+XyTVfHTfS8Nswm8YOc/dl11AXHGB/TPwzWaawAUWWxEvJU5AvaKTwyGdZqktWkQa5XQEJ4p0SeHsEKFCeP0HNDsE3H1V0HXm9MH0wvjCwWiOACz5nepnY=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzUoOF_1767085972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:12:54 +0800
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
Subject: [PATCH v5 12/17] ras: AEST: Allow configuring CE threshold via debugfs
Date: Tue, 30 Dec 2025 17:12:51 +0800
Message-Id: <20251230091251.49205-1-tianruidong@linux.alibaba.com>
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

This commit introduces the ability to configure the Corrected Error (CE)
threshold for AEST records through debugfs. This allows administrators to
dynamically adjust the CE threshold for error reporting.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest | 16 ++++++++++
 drivers/ras/aest/aest-sysfs.c          | 42 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
index 295df9e9b455..4d160072d37a 100644
--- a/Documentation/ABI/testing/debugfs-aest
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -24,6 +24,14 @@ Description:
 		See more at:
 			https://developer.arm.com/documentation/den0085/latest/
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/ce_threshold
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(WO) Write the ce threshold to all records of this node. Failed
+		if input exceeded the maximum threshold
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/err_count
 Date:		Dec 2025
 KernelVersion	6.19
@@ -38,6 +46,14 @@ Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
 Description:
 		(RO) Read err_* register and return val.
 
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/ce_threshold
+Date:		Dec 2025
+KernelVersion	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RW) Read and write the ce threshold to this record. Failed
+		if input exceeded the maximum threshold
+
 What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_count
 Date:		Dec 2025
 KernelVersion	6.19
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
index b54e879506aa..392e7ad8328e 100644
--- a/drivers/ras/aest/aest-sysfs.c
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -7,6 +7,25 @@
 
 #include "aest.h"
 
+static void
+aest_store_threshold(struct aest_record *record, void *data)
+{
+	u64 err_misc0, *threshold = data;
+	struct ce_threshold *ce = &record->ce;
+
+	if (*threshold > ce->info->max_count)
+		return;
+
+	ce->threshold = *threshold;
+	ce->count = ce->info->max_count - ce->threshold + 1;
+
+	err_misc0 = record_read(record, ERXMISC0);
+	ce->reg_val = (err_misc0 & ~ce->info->mask) |
+			(ce->count << ce->info->shift);
+
+	record_write(record, ERXMISC0, ce->reg_val);
+}
+
 static void
 aest_error_count(struct aest_record *record, void *data)
 {
@@ -77,6 +96,27 @@ DEFINE_AEST_DEBUGFS_ATTR(err_misc1, ERXMISC1);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc2, ERXMISC2);
 DEFINE_AEST_DEBUGFS_ATTR(err_misc3, ERXMISC3);
 
+static int record_ce_threshold_get(void *data, u64 *val)
+{
+	struct aest_record *record = data;
+
+	*val = record->ce.threshold;
+	return 0;
+}
+
+static int record_ce_threshold_set(void *data, u64 val)
+{
+	u64 threshold = val;
+	struct aest_record *record = data;
+
+	aest_store_threshold(record, &threshold);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(record_ce_threshold_ops, record_ce_threshold_get,
+					record_ce_threshold_set, "%llu\n");
+
 static int aest_record_err_count_show(struct seq_file *m, void *data)
 {
 	struct aest_record *record = m->private;
@@ -116,6 +156,8 @@ static void aest_record_init_debugfs(struct aest_record *record)
 								&err_misc3_ops);
 	debugfs_create_file("err_count", 0400, record->debugfs, record,
 						&aest_record_err_count_fops);
+	debugfs_create_file("ce_threshold", 0600, record->debugfs, record,
+						&record_ce_threshold_ops);
 }
 
 static void
-- 
2.47.3


