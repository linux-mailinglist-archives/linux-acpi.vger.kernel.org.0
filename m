Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583476E3D23
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Apr 2023 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQBOV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Apr 2023 21:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjDQBOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Apr 2023 21:14:20 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811426B0;
        Sun, 16 Apr 2023 18:14:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0VgBQJ7w_1681694052;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VgBQJ7w_1681694052)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 09:14:13 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com,
        justin.he@arm.com, akpm@linux-foundation.org, ardb@kernel.org,
        ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v7 1/2] ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events
Date:   Mon, 17 Apr 2023 09:14:06 +0800
Message-Id: <20230417011407.58319-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are two major types of uncorrected recoverable (UCR) errors :

- Action Required (AR): The error is detected and the processor already
  consumes the memory. OS requires to take action (for example, offline
  failure page/kill failure thread) to recover this uncorrectable error.

- Action Optional (AO): The error is detected out of processor execution
  context. Some data in the memory are corrupted. But the data have not
  been consumed. OS is optional to take action to recover this
  uncorrectable error.

The essential difference between AR and AO errors is that AR is a
synchronous event, while AO is an asynchronous event. The hardware will
signal a synchronous exception (Machine Check Exception on X86 and
Synchronous External Abort on Arm64) when an error is detected and the
memory access has been architecturally executed.

When APEI firmware first is enabled, a platform may describe one error
source for the handling of synchronous errors (e.g. MCE or SEA notification
), or for handling asynchronous errors (e.g. SCI or External Interrupt
notification). In other words, we can distinguish synchronous errors by
APEI notification. For AR errors, kernel will kill current process
accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
addition, for AO errors, kernel will notify the process who owns the
poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
However, the GHES driver always sets mf_flags to 0 so that all UCR errors
are handled as AO errors in memory failure.

To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
events.

Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 34ad071a64e9..c479b85899f5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt). On x86, the HEST notifications are always
+ * asynchronous, so only SEA on ARM is delivered as a synchronous
+ * notification.
+ */
+static inline bool is_hest_sync_notify(struct ghes *ghes)
+{
+	u8 notify_type = ghes->generic->notify.type;
+
+	return notify_type == ACPI_HEST_NOTIFY_SEA;
+}
+
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -477,7 +491,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -491,7 +505,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -499,9 +513,11 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -526,7 +542,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -647,6 +663,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -664,13 +681,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
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
 
-- 
2.20.1.12.g72788fdb

