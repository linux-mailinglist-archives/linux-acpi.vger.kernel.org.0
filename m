Return-Path: <linux-acpi+bounces-21026-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAu2MX9lmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21026-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EAD167FC5
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C2630B8251
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C0347BC5;
	Fri, 20 Feb 2026 13:43:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7264347BB9;
	Fri, 20 Feb 2026 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594988; cv=none; b=aLvvZUPlVrWPUcDbK743bucOCFhmTps+hasSnrbHA0YhtsN9S+ovlCYbGONYc9VlFvUtFMjjDyqlebiajM9bFKS2U3mSQMLWEDiS3l3bfE+C2TdJnNKjlpCog9BjSrDPQ6SxpCVK6TOvtqVUNCv2FCm4skln/YHwEmmTR7hUnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594988; c=relaxed/simple;
	bh=1vM5YHlUpJIS6QB3JED+jUpTVhdCYnNzIEMrDhP301g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3tdNzCenHXPWGwotf9N/zosnfljK8E0yVo0B6WnX+0lMVrt94XUNuXKoO0dVzguIP3LfFt9syKketaHjNn/FOYfLOmj0x4zRMwiPvKosrhjTduHQIQshr4W5bwsPZWuykG8VZFsFx8gyyP/cd5fh4IK4OmBLO4OB0kFdAtm8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFBCD339;
	Fri, 20 Feb 2026 05:42:59 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777113F7D8;
	Fri, 20 Feb 2026 05:43:04 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:25 +0000
Subject: [PATCH v2 07/11] ACPI: APEI: GHES: move CXL CPER helpers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-7-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=9900;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=1vM5YHlUpJIS6QB3JED+jUpTVhdCYnNzIEMrDhP301g=;
 b=iCAXPo6/aAdsMScQjvJaaNZcPfxxvDSYi6KodcVBEal1q96IQmuTg5sNcwfx4nDGGPr8VYT+d
 7Usf7awDUFEDqY8esYU2T0r/RLMk4uOQaYkwj70SCZ6yjOsujlz8jc+
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21026-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74EAD167FC5
X-Rspamd-Action: no action

Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
helpers can be reused. The code is moved as-is, with the public
prototypes updated so GHES keeps calling into the new translation unit.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 132 -----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |  11 ++++
 3 files changed, 146 insertions(+), 132 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9703c602a8c2..136993704d52 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -383,138 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
-/* Room for 8 entries */
-#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
-static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
-		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
-
-/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
-static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
-struct work_struct *cxl_cper_prot_err_work;
-
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cxl_cper_prot_err_work_data wd;
-
-	if (cxl_cper_sec_prot_err_valid(prot_err))
-		return;
-
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
-
-	if (!cxl_cper_prot_err_work)
-		return;
-
-	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
-		return;
-
-	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
-		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
-	}
-
-	schedule_work(cxl_cper_prot_err_work);
-#endif
-}
-
-int cxl_cper_register_prot_err_work(struct work_struct *work)
-{
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = work;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
-
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
-{
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
-
-int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
-{
-	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
-
-/* Room for 8 entries for each of the 4 event log queues */
-#define CXL_CPER_FIFO_DEPTH 32
-DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
-
-/* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
-struct work_struct *cxl_cper_work;
-
-static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
-{
-	struct cxl_cper_work_data wd;
-
-	if (rec->hdr.length <= sizeof(rec->hdr) ||
-	    rec->hdr.length > sizeof(*rec)) {
-		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
-		       rec->hdr.length);
-		return;
-	}
-
-	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
-		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
-	}
-
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
-
-	if (!cxl_cper_work)
-		return;
-
-	wd.event_type = event_type;
-	memcpy(&wd.rec, rec, sizeof(wd.rec));
-
-	if (!kfifo_put(&cxl_cper_fifo, wd)) {
-		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
-	}
-
-	schedule_work(cxl_cper_work);
-}
-
-int cxl_cper_register_work(struct work_struct *work)
-{
-	if (cxl_cper_work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = work;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
-
-int cxl_cper_unregister_work(struct work_struct *work)
-{
-	if (cxl_cper_work != work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
-
-int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
-{
-	return kfifo_get(&cxl_cper_fifo, wd);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
-
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
 	if (sev != CPER_SEV_RECOVERABLE)
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 627f6c712261..673dca208935 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -9,10 +9,12 @@
  *
  */
 
+#include <linux/aer.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
 #include <linux/irq_work.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/math64.h>
@@ -319,6 +321,139 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+
+/* Room for 8 entries */
+#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
+static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
+		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
+static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+struct work_struct *cxl_cper_prot_err_work;
+
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cxl_cper_prot_err_work_data wd;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
+
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+
+	if (!cxl_cper_prot_err_work)
+		return;
+
+	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
+		return;
+
+	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_prot_err_work);
+#endif
+}
+
+int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+
+int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+
+/* Room for 8 entries for each of the 4 event log queues */
+#define CXL_CPER_FIFO_DEPTH 32
+DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_work changes */
+static DEFINE_SPINLOCK(cxl_cper_work_lock);
+struct work_struct *cxl_cper_work;
+
+void cxl_cper_post_event(enum cxl_event_type event_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cxl_cper_work_data wd;
+
+	if (rec->hdr.length <= sizeof(rec->hdr) ||
+	    rec->hdr.length > sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
+		       rec->hdr.length);
+		return;
+	}
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "CXL CPER invalid event\n");
+		return;
+	}
+
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+
+	if (!cxl_cper_work)
+		return;
+
+	wd.event_type = event_type;
+	memcpy(&wd.rec, rec, sizeof(wd.rec));
+
+	if (!kfifo_put(&cxl_cper_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_work);
+}
+
+int cxl_cper_register_work(struct work_struct *work)
+{
+	if (cxl_cper_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
+
+int cxl_cper_unregister_work(struct work_struct *work)
+{
+	if (cxl_cper_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
+
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
+
 /*
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index c5ff4c502017..4522e8699ce0 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
+#include <cxl/event.h>
 
 #define GHES_PFX	"GHES: "
 
@@ -99,5 +100,15 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
 void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 				   int sev);
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity);
+int cxl_cper_register_prot_err_work(struct work_struct *work);
+int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
+void cxl_cper_post_event(enum cxl_event_type event_type,
+			 struct cxl_cper_event_rec *rec);
+int cxl_cper_register_work(struct work_struct *work);
+int cxl_cper_unregister_work(struct work_struct *work);
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0


