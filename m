Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC032D5A20
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgLJMOG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 07:14:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9491 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732927AbgLJMMc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 07:12:32 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsCSG0KHvzhpqj;
        Thu, 10 Dec 2020 20:11:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 20:11:35 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <james.morse@arm.com>, <rafael@kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <akpm@linux-foundation.org>, <jroedel@suse.de>,
        <peterz@infradead.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v5] ACPI / APEI: fix the regression of synchronous external aborts occur in user-mode
Date:   Thu, 10 Dec 2020 20:09:37 +0800
Message-ID: <1607602177-1507-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
synchronise with APEI's irq work") applied, do_sea() return directly
for user-mode if apei_claim_sea() handled any error record. Therefore,
each error record reported by the user-mode SEA must be effectively
processed in APEI GHES driver.

Currently, GHES driver only processes Memory Error Section.(Ignore PCIe
Error Section, as it has nothing to do with SEA). It is not enough.
Because ARM Processor Error could also be used for SEA in some hardware
platforms, such as Kunpeng9xx series. We can't ask them to switch to
use Memory Error Section for two reasons:
1)The server was delivered to customers, and it will introduce
compatibility issue.
2)It make sense to use ARM Processor Error Section. Because either
cache or memory errors could generate SEA when consumed by a processor.

Do memory failure handling for ARM Processor Error Section just like
for Memory Error Section.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
Changes since v4:
- 1. Change the patch name from " ACPI / APEI: do memory failure on the
physical address reported by ARM processor error section" to this
more proper one.
- 2. Add a comment in the code to tell why not filter out corrected
error in an uncorrected section.

Changes since v3:
- Print unhandled error following James Morse's advice.

Changes since v2:
- Updated commit log
---
 drivers/acpi/apei/ghes.c | 76 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade..0893968 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)
 	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
-	int flags = -1;
-	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
 		return false;
 
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
-
-	pfn = mem_err->physical_addr >> PAGE_SHIFT;
+	pfn = PHYS_PFN(physical_addr);
 	if (!pfn_valid(pfn)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 		"Invalid address in generic error data: %#llx\n",
-		mem_err->physical_addr);
+		physical_addr);
 		return false;
 	}
 
+	memory_failure_queue(pfn, flags);
+	return true;
+}
+
+static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev)
+{
+	int flags = -1;
+	int sec_sev = ghes_severity(gdata->error_severity);
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
@@ -470,14 +477,51 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
 		flags = 0;
 
-	if (flags != -1) {
-		memory_failure_queue(pfn, flags);
-		return true;
-	}
+	if (flags != -1)
+		return ghes_do_memory_failure(mem_err->physical_addr, flags);
 
 	return false;
 }
 
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	struct cper_arm_err_info *err_info;
+	bool queued = false;
+	int sec_sev, i;
+
+	log_arm_hw_error(err);
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
+		return false;
+
+	err_info = (struct cper_arm_err_info *) (err + 1);
+	for (i = 0; i < err->err_info_num; i++, err_info++) {
+		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+
+		/*
+		 * The field (err_info->error_info & BIT(26)) is fixed to set to
+		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
+		 * firmware won't mix corrected errors in an uncorrected section,
+		 * and don't filter out 'corrected' error here.
+		 */
+		if (!is_cache || !has_pa) {
+			pr_warn_ratelimited(FW_WARN GHES_PFX
+			"Unhandled processor error type %s\n",
+			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
+			cper_proc_error_type_strs[err_info->type] : "unknown error");
+			continue;
+		}
+
+		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
+			queued = true;
+	}
+
+	return queued;
+}
+
 /*
  * PCIe AER errors need to be sent to the AER driver for reporting and
  * recovery. The GHES severities map to the following AER severities and
@@ -605,9 +649,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
+			queued = ghes_handle_arm_hw_error(gdata, sev);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.8.1

