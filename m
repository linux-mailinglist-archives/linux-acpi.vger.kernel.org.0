Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC26456B3
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLGJjy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLGJjx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 04:39:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1093A7;
        Wed,  7 Dec 2022 01:39:51 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRsc31fdbzJp8c;
        Wed,  7 Dec 2022 17:36:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 17:39:15 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <lvying6@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v1 1/2] ACPI: APEI: Make memory_failure() triggered by synchronization errors execute in the current context
Date:   Wed, 7 Dec 2022 17:39:34 +0800
Message-ID: <20221207093935.1972530-2-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221207093935.1972530-1-lvying6@huawei.com>
References: <20221207093935.1972530-1-lvying6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The memory uncorrected error which is detected by an external component and
notified via an IRQ, can be called asynchronization error. If an error is
detected as a result of user-space process accessing a corrupt memory
location, the CPU may take an abort. On arm64 this is a
'synchronous external abort', and on a firmware first system it is notified
via NOTIFY_SEA, this can be called synchronization error.

Currently, synchronization error and asynchronization error both use
memory_failure_queue to schedule memory_failure() exectute in kworker
context. Commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue
for synchronous errors") make task_work pending to flush out the queue,
cancel_work_sync() in memory_failure_queue_kick() will make
memory_failure() exectute in kworker context first which will get
synchronization error info from kfifo, so task_work later will get nothing
from kfifo which doesn't work as expected. Even worse, synchronization
error notification has NMI like properties, (it can interrupt IRQ-masked
code), task_work may get wrong kfifo entry from interrupted
asynchronization error which is notified by IRQ.

Since the memory_failure() triggered by a synchronous exception is
executed in the kworker context, the early_kill mode of memory_failure()
will send wrong si_code by SIGBUS signal: current process is kworker
thread, the actual user-space process accessing the corrupt memory location
will be collected by find_early_kill_thread(), and then send SIGBUS with
BUS_MCEERR_AO si_code to the actual user-space process instead of
BUS_MCEERR_AR. The machine-manager(kvm) use the si_code: BUS_MCEERR_AO for
'action optional' early notifications, and BUS_MCEERR_AR for
'action required' synchronous/late notifications.

Make memory_failure() triggered by synchronization errors execute in the
current context, we do not need workqueue for synchronization error
anymore, use task_work handle synchronization errors directly. Since,
synchronization errors and asynchronization errors share the same kfifo,
use MF_ACTION_REQUIRED flag to distinguish them. And the asynchronization
error keeps the same as before.

Signed-off-by: Lv Ying <lvying6@huawei.com>
---
 drivers/acpi/apei/ghes.c | 36 +++++++++++++++++++++++-------------
 mm/memory-failure.c      | 34 ++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9952f3a792ba..1ff3756e70d4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -423,8 +423,8 @@ static void ghes_clear_estatus(struct ghes *ghes,
 
 /*
  * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+ * Ensure any queued corrupt page in synchronous errors has been handled before
+ * we return to the user context that triggered the notification.
  */
 static void ghes_kick_task_work(struct callback_head *head)
 {
@@ -461,7 +461,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -475,7 +475,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -483,7 +483,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	bool queued = false;
@@ -510,7 +510,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr,
+					sync ? MF_ACTION_REQUIRED : 0);
 			p += err_info->length;
 			continue;
 		}
@@ -623,7 +624,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_do_proc(struct ghes *ghes,
-			 const struct acpi_hest_generic_status *estatus)
+			 const struct acpi_hest_generic_status *estatus, bool sync)
 {
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
@@ -648,13 +649,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
@@ -868,7 +869,7 @@ static int ghes_proc(struct ghes *ghes)
 		if (ghes_print_estatus(NULL, ghes->generic, estatus))
 			ghes_estatus_cache_add(ghes->generic, estatus);
 	}
-	ghes_do_proc(ghes, estatus);
+	ghes_do_proc(ghes, estatus, false);
 
 out:
 	ghes_clear_estatus(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
@@ -955,13 +956,22 @@ static struct notifier_block ghes_notifier_hed = {
 static struct llist_head ghes_estatus_llist;
 static struct irq_work ghes_proc_irq_work;
 
+/*
+ * TODO: Currently ghes_proc_in_irq can be called in SDEI, SEA, NMI notify type,
+ * this function run some job which may not be NMI safe in IRQ context.
+ * However, there is no good way to distinguish NMI-like notify type is
+ * synchronous or not.
+ * current implementation of ghes_proc_in_irq uses ghes_kick_task_work etc
+ * may imply this function is used in synchronous scenarios, so to be
+ * consistent with the current implementation
+ */
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	bool task_work_pending;
+	bool corruption_page_pending;
 	u32 len, node_len;
 	int ret;
 
@@ -978,14 +988,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
+		corruption_page_pending = ghes_do_proc(estatus_node->ghes, estatus, true);
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
 				ghes_estatus_cache_add(generic, estatus);
 		}
 
-		if (task_work_pending && current->mm) {
+		if (corruption_page_pending && current->mm) {
 			estatus_node->task_work.func = ghes_kick_task_work;
 			estatus_node->task_work_cpu = smp_processor_id();
 			ret = task_work_add(current, &estatus_node->task_work,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..3b6ac3694b8d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2204,7 +2204,11 @@ struct memory_failure_cpu {
 static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
 
 /**
- * memory_failure_queue - Schedule handling memory failure of a page.
+ * memory_failure_queue
+ * - Schedule handling memory failure of a page for asynchronous error, memory
+ *   failure page will be executed in kworker thread
+ * - put corrupt memory info into kfifo for synchronous error, task_work will
+ *   handle them before returning to the user
  * @pfn: Page Number of the corrupted page
  * @flags: Flags for memory failure handling
  *
@@ -2217,6 +2221,11 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
  * happen outside the current execution context (e.g. when
  * detected by a background scrubber)
  *
+ * This function can also be used in synchronous errors which was detected as a
+ * result of user-space accessing a corrupt memory location, just put memory
+ * error info into kfifo, and then, task_work get and handle it in current
+ * execution context instead of scheduling kworker to handle it
+ *
  * Can run in IRQ context.
  */
 void memory_failure_queue(unsigned long pfn, int flags)
@@ -2230,9 +2239,10 @@ void memory_failure_queue(unsigned long pfn, int flags)
 
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
 	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
-	if (kfifo_put(&mf_cpu->fifo, entry))
-		schedule_work_on(smp_processor_id(), &mf_cpu->work);
-	else
+	if (kfifo_put(&mf_cpu->fifo, entry)) {
+		if (!(entry.flags & MF_ACTION_REQUIRED))
+			schedule_work_on(smp_processor_id(), &mf_cpu->work);
+	} else
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
 	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
@@ -2240,7 +2250,7 @@ void memory_failure_queue(unsigned long pfn, int flags)
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
-static void memory_failure_work_func(struct work_struct *work)
+static void __memory_failure_work_func(struct work_struct *work, bool sync)
 {
 	struct memory_failure_cpu *mf_cpu;
 	struct memory_failure_entry entry = { 0, };
@@ -2256,22 +2266,22 @@ static void memory_failure_work_func(struct work_struct *work)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
-		else
+		else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
 			memory_failure(entry.pfn, entry.flags);
 	}
 }
 
-/*
- * Process memory_failure work queued on the specified CPU.
- * Used to avoid return-to-userspace racing with the memory_failure workqueue.
- */
+static void memory_failure_work_func(struct work_struct *work)
+{
+	__memory_failure_work_func(work, false);
+}
+
 void memory_failure_queue_kick(int cpu)
 {
 	struct memory_failure_cpu *mf_cpu;
 
 	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
+	__memory_failure_work_func(&mf_cpu->work, true);
 }
 
 static int __init memory_failure_init(void)
-- 
2.36.1

