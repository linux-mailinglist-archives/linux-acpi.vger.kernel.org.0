Return-Path: <linux-acpi+bounces-8599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19152994135
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 10:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E91C2645F
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA91E0B73;
	Tue,  8 Oct 2024 07:50:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3F1E04AE;
	Tue,  8 Oct 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373839; cv=none; b=MeFBPMarrm402iWWrxg5wNgQYw3bmTuCjmZMN0/6jJe2cAnIRVBrABbXP5APgkFDi9ZsB1D+exkKnMNQ9GGgof5wt/Io0QdB0siqRVCDwVBJ34qe9CbCefU35kTGyDUJGH39YxPW1DGVi1Y+/ts5gPCxfnpl0M6udjFkT9NPo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373839; c=relaxed/simple;
	bh=2YVKqK8qdPwBNwhXjtlQ2NETdbx0YBzrRgxdzyXwlfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZilSRKuVjziRRt6ICzQGoBn+rPoZdKLrdVRRKdQtNzQYYRkNvm82UYAuofpOQwPRHO1HFeENGn7+Fre86yKAS1rZvyttfTDRyauwTq77uBo/YuqzO1o2AZovlGbUtHxvCjrgU0ZAV8HGtWieJPrpjX0r/x8Q4GXoxvHfsjR+0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XN7Tf5BVbzCt48;
	Tue,  8 Oct 2024 15:49:58 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 418BB14035E;
	Tue,  8 Oct 2024 15:50:34 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemd200010.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 8 Oct
 2024 15:50:33 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH v2] ACPI: GTDT: simplify acpi_gtdt_init() implementation
Date: Tue, 8 Oct 2024 16:24:29 +0800
Message-ID: <20241008082429.33646-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200010.china.huawei.com (7.221.188.124)

According to GTDT Table Structure of ACPI specification, the result of
expression '(void *)gtdt + gtdt->platform_timer_offset' will be same
with the expression '(void *)table + sizeof(struct acpi_table_gtdt)'
in function acpi_gtdt_init(), so the condition of the "invalid timer
data" check will never be true, remove the EINVAL error check branch
and change to void return type for acpi_gtdt_init() to simplify the
function implementation and error handling by callers.

Besides, after commit c2743a36765d ("clocksource: arm_arch_timer: add
GTDT support for memory-mapped timer"), acpi_gtdt_init() currently will
not be called with parameter platform_timer_count set to NULL and we
can explicitly initialize the integer variable which is used for storing
the number of platform timers by caller to zero, so there is no need to
do null pointer check for platform_timer_count in acpi_gtdt_init(),
remove it to make code a bit more concise.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
Changes in v2:
- initialize 'ret' in gtdt_sbsa_gwdt_init() to silence build warning

v1: https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
---
 drivers/acpi/arm64/gtdt.c            | 31 +++++++---------------------
 drivers/clocksource/arm_arch_timer.c |  6 ++----
 include/linux/acpi.h                 |  2 +-
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..7fe27c0edde7 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -147,45 +147,30 @@ bool __init acpi_gtdt_c3stop(int type)
  * @table:			The pointer to GTDT table.
  * @platform_timer_count:	It points to a integer variable which is used
  *				for storing the number of platform timers.
- *				This pointer could be NULL, if the caller
- *				doesn't need this info.
- *
- * Return: 0 if success, -EINVAL if error.
  */
-int __init acpi_gtdt_init(struct acpi_table_header *table,
+void __init acpi_gtdt_init(struct acpi_table_header *table,
 			  int *platform_timer_count)
 {
-	void *platform_timer;
 	struct acpi_table_gtdt *gtdt;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 	acpi_gtdt_desc.gtdt = gtdt;
 	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
 	acpi_gtdt_desc.platform_timer = NULL;
-	if (platform_timer_count)
-		*platform_timer_count = 0;
 
 	if (table->revision < 2) {
 		pr_warn("Revision:%d doesn't support Platform Timers.\n",
 			table->revision);
-		return 0;
+		return;
 	}
 
 	if (!gtdt->platform_timer_count) {
 		pr_debug("No Platform Timer.\n");
-		return 0;
+		return;
 	}
 
-	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
-	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
-		pr_err(FW_BUG "invalid timer data.\n");
-		return -EINVAL;
-	}
-	acpi_gtdt_desc.platform_timer = platform_timer;
-	if (platform_timer_count)
-		*platform_timer_count = gtdt->platform_timer_count;
-
-	return 0;
+	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
+	*platform_timer_count = gtdt->platform_timer_count;
 }
 
 static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
@@ -377,7 +362,7 @@ static int __init gtdt_sbsa_gwdt_init(void)
 {
 	void *platform_timer;
 	struct acpi_table_header *table;
-	int ret, timer_count, gwdt_count = 0;
+	int ret = 0, timer_count = 0, gwdt_count = 0;
 
 	if (acpi_disabled)
 		return 0;
@@ -394,8 +379,8 @@ static int __init gtdt_sbsa_gwdt_init(void)
 	 * to re-initialize them with permanent mapped pointer values to let the
 	 * GTDT parsing possible.
 	 */
-	ret = acpi_gtdt_init(table, &timer_count);
-	if (ret || !timer_count)
+	acpi_gtdt_init(table, &timer_count);
+	if (!timer_count)
 		goto out_put_gtdt;
 
 	for_each_platform_timer(platform_timer) {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 03733101e231..4ca06aba68a4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1741,7 +1741,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 /* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	int ret, platform_timer_count;
+	int ret, platform_timer_count = 0;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
@@ -1750,9 +1750,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	ret = acpi_gtdt_init(table, &platform_timer_count);
-	if (ret)
-		return ret;
+	acpi_gtdt_init(table, &platform_timer_count);
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..2e2b168f3790 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -750,7 +750,7 @@ int acpi_reconfig_notifier_register(struct notifier_block *nb);
 int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 
 #ifdef CONFIG_ACPI_GTDT
-int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
+void __init acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
 int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
-- 
2.20.1


