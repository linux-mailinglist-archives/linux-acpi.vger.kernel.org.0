Return-Path: <linux-acpi+bounces-2895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CC82E53C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jan 2024 01:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE5283C65
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jan 2024 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5C1B96D;
	Tue, 16 Jan 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDCXd+Da"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686925548;
	Tue, 16 Jan 2024 00:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C8C43601;
	Tue, 16 Jan 2024 00:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364112;
	bh=K3UXMUExt8JhP1UJ446a6iC8OCLjfKajiaaS0DYjBM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDCXd+Da/oCOAcMZmVQciRzfOFlNmH23gjYkXKvQ3TKPHFkEp+4TL9AxiwllItEP0
	 CBw8GhmWm1SOiozqMlL8UUCPRhx+DE47e/8T461A7RsG6Oo/LDJt75YWj/vLhf7tqO
	 6g6eCd10U26BW5sLCGfYNffT27WyRmC2SZisWyOfplAmeGA+sjX2PjTy3zxCB5hHiS
	 xO7PC9c4U+Vuq0DslI0Tl7iQ81ZSdDZ3snivAoOQxBUPsc8DC/29bUADWk4aRNeu0/
	 vJq5GgIdNsOfPZmT5koB70Wlfom7IIPrpoyuWlnYpTqmFnqVbzPI9REcTKw4x3HkCs
	 Qsjtm44XrhcOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Ma Wupeng <mawupeng1@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Xiaofei Tan <tanxiaofei@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	leoyang.li@nxp.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events
Date: Mon, 15 Jan 2024 19:14:54 -0500
Message-ID: <20240116001457.214018-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001457.214018-1-sashal@kernel.org>
References: <20240116001457.214018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit a70297d2213253853e95f5b49651f924990c6d3b ]

There are two major types of uncorrected recoverable (UCR) errors :

 - Synchronous error: The error is detected and raised at the point of
   the consumption in the execution flow, e.g. when a CPU tries to
   access a poisoned cache line. The CPU will take a synchronous error
   exception such as Synchronous External Abort (SEA) on Arm64 and
   Machine Check Exception (MCE) on X86. OS requires to take action (for
   example, offline failure page/kill failure thread) to recover this
   uncorrectable error.

 - Asynchronous error: The error is detected out of processor execution
   context, e.g. when an error is detected by a background scrubber.
   Some data in the memory are corrupted. But the data have not been
   consumed. OS is optional to take action to recover this uncorrectable
   error.

When APEI firmware first is enabled, a platform may describe one error
source for the handling of synchronous errors (e.g. MCE or SEA notification
), or for handling asynchronous errors (e.g. SCI or External Interrupt
notification). In other words, we can distinguish synchronous errors by
APEI notification. For synchronous errors, kernel will kill the current
process which accessing the poisoned page by sending SIGBUS with
BUS_MCEERR_AR. In addition, for asynchronous errors, kernel will notify the
process who owns the poisoned page by sending SIGBUS with BUS_MCEERR_AO in
early kill mode. However, the GHES driver always sets mf_flags to 0 so that
all synchronous errors are handled as asynchronous errors in memory failure.

To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
events.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8678e162181f..160606af8b4f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -99,6 +99,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
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
@@ -461,7 +475,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -475,7 +489,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -483,9 +497,11 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
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
@@ -510,7 +526,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -631,6 +647,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -648,13 +665,13 @@ static bool ghes_do_proc(struct ghes *ghes,
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
 
-- 
2.43.0


