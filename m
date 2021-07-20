Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48383CF8B8
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jul 2021 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhGTKjg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Jul 2021 06:39:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11456 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhGTKjb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jul 2021 06:39:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTbkz2KWTzcgSR;
        Tue, 20 Jul 2021 19:16:43 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 19:20:05 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 19:20:04 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] ACPI / PPTT: get PPTT table in the first beginning
Date:   Tue, 20 Jul 2021 19:26:35 +0800
Message-ID: <20210720112635.38565-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When I added might_sleep() in down_timeout(), I got the following
Calltrace:

[    8.775671] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:160
[    8.777070] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0
[    8.778474] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 5.10.0-06616-g1fcfee258bd9-dirty #416
[    8.782067] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    8.783452] Call trace:
[    8.783878]  dump_backtrace+0x0/0x1c0
[    8.784512]  show_stack+0x18/0x68
[    8.784976]  dump_stack+0xd8/0x134
[    8.785428]  ___might_sleep+0x108/0x170
[    8.785928]  __might_sleep+0x54/0x90
[    8.786425]  down_timeout+0x30/0x88
[    8.786918]  acpi_os_wait_semaphore+0x70/0xb8
[    8.787483]  acpi_ut_acquire_mutex+0x4c/0xb8
[    8.788016]  acpi_get_table+0x38/0xc4
[    8.788521]  acpi_find_last_cache_level+0x94/0x178
[    8.789088]  _init_cache_level+0xd0/0xe0
[    8.789563]  generic_exec_single+0xa0/0x100
[    8.790122]  smp_call_function_single+0x160/0x1e0
[    8.790714]  init_cache_level+0x38/0x60
[    8.791247]  cacheinfo_cpu_online+0x30/0x898
[    8.791880]  cpuhp_invoke_callback+0x88/0x258
[    8.792707]  cpuhp_thread_fun+0xd8/0x170
[    8.793231]  smpboot_thread_fn+0x194/0x290
[    8.793838]  kthread+0x15c/0x160
[    8.794273]  ret_from_fork+0x10/0x34

It is because generic_exec_single() will disable local irq before
calling _init_cache_level(). _init_cache_level() use acpi_get_table() to
get the PPTT table, but this function could schedule out.

To fix this issue, we use a static pointer to record the mapped PPTT
table in the first beginning. Later, we use that pointer to reference
the PPTT table in acpi_find_last_cache_level(). We also modify other
functions in pptt.c to use the pointer to reference PPTT table.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/kernel/topology.c |  6 ++-
 drivers/acpi/pptt.c          | 83 +++++++++++++++---------------------
 include/linux/acpi.h         |  1 +
 3 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 4dd14a6620c1..401854bd8c48 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -83,11 +83,15 @@ static bool __init acpi_cpu_is_threaded(int cpu)
  */
 int __init parse_acpi_topology(void)
 {
-	int cpu, topology_id;
+	int cpu, topology_id, ret;
 
 	if (acpi_disabled)
 		return 0;
 
+	ret = acpi_pptt_init();
+	if (ret)
+		return ret;
+
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index fe69dc518f31..a4c7af9e9369 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -21,6 +21,9 @@
 #include <linux/cacheinfo.h>
 #include <acpi/processor.h>
 
+/* Root pointer to the mapped PPTT table */
+static struct acpi_table_header *pptt_table;
+
 static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
 							u32 pptt_ref)
 {
@@ -534,19 +537,13 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 
 static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 {
-	struct acpi_table_header *table;
-	acpi_status status;
 	int retval;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	if (!pptt_table)
 		return -ENOENT;
-	}
-	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
+	retval = topology_get_acpi_cpu_tag(pptt_table, cpu, level, flag);
 	pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
 		 cpu, level, retval);
-	acpi_put_table(table);
 
 	return retval;
 }
@@ -566,26 +563,19 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
  */
 static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 {
-	struct acpi_table_header *table;
-	acpi_status status;
 	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	struct acpi_pptt_processor *cpu_node = NULL;
 	int ret = -ENOENT;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
-		return ret;
-	}
+	if (!pptt_table)
+		return -ENOENT;
 
-	if (table->revision >= rev)
-		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+	if (pptt_table->revision >= rev)
+		cpu_node = acpi_find_processor_node(pptt_table, acpi_cpu_id);
 
 	if (cpu_node)
 		ret = (cpu_node->flags & flag) != 0;
 
-	acpi_put_table(table);
-
 	return ret;
 }
 
@@ -602,20 +592,14 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 int acpi_find_last_cache_level(unsigned int cpu)
 {
 	u32 acpi_cpu_id;
-	struct acpi_table_header *table;
 	int number_of_levels = 0;
-	acpi_status status;
 
 	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
-	} else {
-		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
-		acpi_put_table(table);
-	}
+	if (pptt_table)
+		number_of_levels = acpi_find_cache_levels(pptt_table, acpi_cpu_id);
+
 	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
 
 	return number_of_levels;
@@ -636,21 +620,14 @@ int acpi_find_last_cache_level(unsigned int cpu)
  */
 int cache_setup_acpi(unsigned int cpu)
 {
-	struct acpi_table_header *table;
-	acpi_status status;
-
 	pr_debug("Cache Setup ACPI CPU %d\n", cpu);
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	if (!pptt_table)
 		return -ENOENT;
-	}
 
-	cache_setup_acpi_cpu(table, cpu);
-	acpi_put_table(table);
+	cache_setup_acpi_cpu(pptt_table, cpu);
 
-	return status;
+	return 0;
 }
 
 /**
@@ -702,27 +679,20 @@ int find_acpi_cpu_topology(unsigned int cpu, int level)
  */
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 {
-	struct acpi_table_header *table;
 	struct acpi_pptt_cache *found_cache;
-	acpi_status status;
 	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	struct acpi_pptt_processor *cpu_node = NULL;
 	int ret = -1;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	if (!pptt_table)
 		return -ENOENT;
-	}
 
-	found_cache = acpi_find_cache_node(table, acpi_cpu_id,
+	found_cache = acpi_find_cache_node(pptt_table, acpi_cpu_id,
 					   CACHE_TYPE_UNIFIED,
 					   level,
 					   &cpu_node);
 	if (found_cache)
-		ret = ACPI_PTR_DIFF(cpu_node, table);
-
-	acpi_put_table(table);
+		ret = ACPI_PTR_DIFF(cpu_node, pptt_table);
 
 	return ret;
 }
@@ -771,3 +741,20 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_ACPI_IDENTICAL);
 }
+
+int __init acpi_pptt_init(void)
+{
+	acpi_status status;
+
+	/*
+	 * pptt_table will be used at runtime after acpi_pptt_init, so we don't
+	 * need to call acpi_put_table() to release the PPTT table mapping.
+	 */
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &pptt_table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 72e4f7fd268c..9263dc03dfb4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1351,6 +1351,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #endif
 
 #ifdef CONFIG_ACPI_PPTT
+int acpi_pptt_init(void);
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
-- 
2.20.1

