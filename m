Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE27232CA0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jul 2020 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG3Hd7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jul 2020 03:33:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3Hd7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Jul 2020 03:33:59 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EA2B942A9034AD7533E;
        Thu, 30 Jul 2020 15:33:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Jul 2020 15:33:22 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] ACPI / APEI: do memory failure on the physical address reported by ARM processor error section
Date:   Thu, 30 Jul 2020 15:32:28 +0800
Message-ID: <1596094348-10230-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the following commit applied, user-mode SEA is preferentially
processed by APEI. Do memory failure to recover.

But there are some problems:
1) The function apei_claim_sea() has processed an CPER, does not
mean that memory failure handling has done. Because the firmware-first
RAS error is reported by both producer and consumer. Mostly SEA uses
ARM processor error section to report as a consumer. (The producer could
be DDRC and cache, and use memory error section and other error section
to report). But memory failure handling for ARM processor error section
has not been supported. We should add it.

2) Some hardware platforms can't record physical address each time. But
they could always have reported a firmware-first RAS error using ARM
processor error section. Such platform should update firmware. Don't
report the RAS error when physical address is not recorded.

Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/apei/ghes.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b..07bfa28 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -466,6 +466,44 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
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
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return false;
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
+		return false;
+
+	err_info = (struct cper_arm_err_info *) (err + 1);
+	for (i = 0; i < err->err_info_num; i++, err_info++) {
+		unsigned long pfn;
+
+		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
+			continue;
+
+		pfn = PHYS_PFN(err_info->physical_fault_addr);
+		if (!pfn_valid(pfn)) {
+			pr_warn(FW_WARN GHES_PFX
+				"Invalid address in generic error data: 0x%#llx\n",
+				err_info->physical_fault_addr);
+			continue;
+		}
+
+		memory_failure_queue(pfn, 0);
+		queued = true;
+	}
+
+	return queued;
+}
+
 /*
  * PCIe AER errors need to be sent to the AER driver for reporting and
  * recovery. The GHES severities map to the following AER severities and
@@ -543,9 +581,7 @@ static bool ghes_do_proc(struct ghes *ghes,
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

