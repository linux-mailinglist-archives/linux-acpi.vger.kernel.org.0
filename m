Return-Path: <linux-acpi+bounces-21028-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGD0KPVkmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21028-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:43:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA4167ED1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B022D3023697
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F93349AEA;
	Fri, 20 Feb 2026 13:43:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B44346FCA;
	Fri, 20 Feb 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594992; cv=none; b=gZnwt8SOQ5CQGI1vPPYcH6la91HzjMR3nUC+if4+awQdGdW5OBqZFhUJ95yWC1lbj/3U7QieEI5zy5tM5pNcx9z/L6MNS/QlOascvNFHvwwAJbXzmyZmobTqt/MJyEDWgy8FsUI/s9kx2I+G/tnIsbLi6vGjrHBYJD3p9AW/5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594992; c=relaxed/simple;
	bh=D/86hDTgZ8orWrV4STpm+EF/5rjQgPy2U7KQ4/RLZ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDCNcTFKZ1jHdKNLunHkj9pXK56EjAUuhB+5qhnlyM+gTRZ5uttrkSnzOZVRXjqYc0OkzzsB/QTYfilzsrNHF2rpk1ysRRpwDT+W4rSzJ3pwcBC3Fxppln1pPMW8ZLa461f5Zjm3GT4y9YfexjuMT/hJtx5GfDZRhq3YkmHUYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA09815A1;
	Fri, 20 Feb 2026 05:43:03 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BC963F7D8;
	Fri, 20 Feb 2026 05:43:08 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:27 +0000
Subject: [PATCH v2 09/11] ACPI: APEI: share GHES CPER helpers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-9-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=30825;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=D/86hDTgZ8orWrV4STpm+EF/5rjQgPy2U7KQ4/RLZ3k=;
 b=P7HcPaRTvu9Wc+dzZWlC6ai1nCCscKy7LJhhIEq0qGi58/tfYfPSmK/dyroKrCk/RZmN/2pNS
 bwAsMUhT3lfDNfpT9bCo61E9DbmLCrrsviqKWD7tZxSuIkXSDvb5mil
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21028-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 80CA4167ED1
X-Rspamd-Action: no action

Wire GHES up to the helper routines in ghes_cper.c and remove the local
copies from ghes.c. This keeps the control flow identical while letting
the helpers be shared with other firmware-first providers.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 415 +--------------------------------------
 drivers/acpi/apei/ghes_cper.c | 438 +++++++++++++++++++++++++++++++++++++++++-
 include/acpi/ghes_cper.h      |  20 ++
 3 files changed, 459 insertions(+), 414 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 136993704d52..25abd3594c89 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -67,8 +67,6 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
-static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
-
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -113,421 +111,12 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-struct gen_pool *ghes_estatus_pool;
-
-int ghes_estatus_pool_init(unsigned int num_ghes)
-{
-	unsigned long addr, len;
-	int rc;
-
-	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
-	if (!ghes_estatus_pool)
-		return -ENOMEM;
-
-	len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
-	len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
-
-	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
-	if (!addr)
-		goto err_pool_alloc;
-
-	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
-	if (rc)
-		goto err_pool_add;
-
-	return 0;
-
-err_pool_add:
-	vfree((void *)addr);
-
-err_pool_alloc:
-	gen_pool_destroy(ghes_estatus_pool);
-
-	return -ENOMEM;
-}
-
-/**
- * ghes_estatus_pool_region_free - free previously allocated memory
- *				   from the ghes_estatus_pool.
- * @addr: address of memory to free.
- * @size: size of memory to free.
- *
- * Returns none.
- */
-void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
-{
-	gen_pool_free(ghes_estatus_pool, addr, size);
-}
-EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
-
-static inline int ghes_severity(int severity)
-{
-	switch (severity) {
-	case CPER_SEV_INFORMATIONAL:
-		return GHES_SEV_NO;
-	case CPER_SEV_CORRECTED:
-		return GHES_SEV_CORRECTED;
-	case CPER_SEV_RECOVERABLE:
-		return GHES_SEV_RECOVERABLE;
-	case CPER_SEV_FATAL:
-		return GHES_SEV_PANIC;
-	default:
-		/* Unknown, go panic */
-		return GHES_SEV_PANIC;
-	}
-}
-
-
-/**
- * struct ghes_task_work - for synchronous RAS event
- *
- * @twork:                callback_head for task work
- * @pfn:                  page frame number of corrupted page
- * @flags:                work control flags
- *
- * Structure to pass task work to be handled before
- * returning to user-space via task_work_add().
- */
-struct ghes_task_work {
-	struct callback_head twork;
-	u64 pfn;
-	int flags;
-};
-
-static void memory_failure_cb(struct callback_head *twork)
-{
-	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
-	int ret;
-
-	ret = memory_failure(twcb->pfn, twcb->flags);
-	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
-
-	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
-		return;
-
-	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			twcb->pfn, current->comm, task_pid_nr(current));
-	force_sig(SIGBUS);
-}
-
-static bool ghes_do_memory_failure(u64 physical_addr, int flags)
-{
-	struct ghes_task_work *twcb;
-	unsigned long pfn;
-
-	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		return false;
-
-	pfn = PHYS_PFN(physical_addr);
-
-	if (flags == MF_ACTION_REQUIRED && current->mm) {
-		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
-		if (!twcb)
-			return false;
-
-		twcb->pfn = pfn;
-		twcb->flags = flags;
-		init_task_work(&twcb->twork, memory_failure_cb);
-		task_work_add(current, &twcb->twork, TWA_RESUME);
-		return true;
-	}
-
-	memory_failure_queue(pfn, flags);
-	return true;
-}
-
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
-{
-	int flags = -1;
-	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
-
-	/* iff following two events can be handled properly by now */
-	if (sec_sev == GHES_SEV_CORRECTED &&
-	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
-		flags = MF_SOFT_OFFLINE;
-	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = sync ? MF_ACTION_REQUIRED : 0;
-
-	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
-
-	return false;
-}
-
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				     int sev, bool sync)
-{
-	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-	int flags = sync ? MF_ACTION_REQUIRED : 0;
-	int length = gdata->error_data_length;
-	char error_type[120];
-	bool queued = false;
-	int sec_sev, i;
-	char *p;
-
-	sec_sev = ghes_severity(gdata->error_severity);
-	if (length >= sizeof(*err)) {
-		log_arm_hw_error(err, sec_sev);
-	} else {
-		pr_warn(FW_BUG "arm error length: %d\n", length);
-		pr_warn(FW_BUG "length is too small\n");
-		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
-		return false;
-	}
-
-	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
-		return false;
-
-	p = (char *)(err + 1);
-	length -= sizeof(err);
-
-	for (i = 0; i < err->err_info_num; i++) {
-		struct cper_arm_err_info *err_info;
-		bool is_cache, has_pa;
-
-		/* Ensure we have enough data for the error info header */
-		if (length < sizeof(*err_info))
-			break;
-
-		err_info = (struct cper_arm_err_info *)p;
-
-		/* Validate the claimed length before using it */
-		length -= err_info->length;
-		if (length < 0)
-			break;
-
-		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
-		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-
-		/*
-		 * The field (err_info->error_info & BIT(26)) is fixed to set to
-		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
-		 * firmware won't mix corrected errors in an uncorrected section,
-		 * and don't filter out 'corrected' error here.
-		 */
-		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
-			p += err_info->length;
-			continue;
-		}
-
-		cper_bits_to_str(error_type, sizeof(error_type),
-				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
-				 cper_proc_error_type_strs,
-				 ARRAY_SIZE(cper_proc_error_type_strs));
-
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type 0x%02x: %s%s\n",
-				    err_info->type, error_type,
-				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
-		p += err_info->length;
-	}
-
-	return queued;
-}
-
-/*
- * PCIe AER errors need to be sent to the AER driver for reporting and
- * recovery. The GHES severities map to the following AER severities and
- * require the following handling:
- *
- * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
- *     These need to be reported by the AER driver but no recovery is
- *     necessary.
- * GHES_SEV_RECOVERABLE -> AER_NONFATAL
- * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
- *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
- */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
-	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
-		unsigned int devfn;
-		int aer_severity;
-		u8 *aer_info;
-
-		devfn = PCI_DEVFN(pcie_err->device_id.device,
-				  pcie_err->device_id.function);
-		aer_severity = cper_severity_to_aer(gdata->error_severity);
-
-		/*
-		 * If firmware reset the component to contain
-		 * the error, we must reinitialize it before
-		 * use, so treat it as a fatal AER error.
-		 */
-		if (gdata->flags & CPER_SEC_RESET)
-			aer_severity = AER_FATAL;
-
-		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
-						  sizeof(struct aer_capability_regs));
-		if (!aer_info)
-			return;
-		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
-
-		aer_recover_queue(pcie_err->device_id.segment,
-				  pcie_err->device_id.bus,
-				  devfn, aer_severity,
-				  (struct aer_capability_regs *)
-				  aer_info);
-	}
-#endif
-}
-
-static void ghes_log_hwerr(int sev, guid_t *sec_type)
-{
-	if (sev != CPER_SEV_RECOVERABLE)
-		return;
-
-	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
-	    guid_equal(sec_type, &CPER_SEC_PROC_GENERIC) ||
-	    guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
-		hwerr_log_error_type(HWERR_RECOV_CPU);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-		hwerr_log_error_type(HWERR_RECOV_CXL);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
-	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS)) {
-		hwerr_log_error_type(HWERR_RECOV_PCI);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-		hwerr_log_error_type(HWERR_RECOV_MEMORY);
-		return;
-	}
-
-	hwerr_log_error_type(HWERR_RECOV_OTHERS);
-}
 
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
-	struct acpi_hest_generic_data *gdata;
-	guid_t *sec_type;
-	const guid_t *fru_id = &guid_null;
-	char *fru_text = "";
-	bool queued = false;
-	bool sync = is_hest_sync_notify(ghes);
-
-	sev = ghes_severity(estatus->error_severity);
-	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
-		sec_sev = ghes_severity(gdata->error_severity);
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-			fru_id = (guid_t *)gdata->fru_id;
-
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-			fru_text = gdata->fru_text;
-
-		ghes_log_hwerr(sev, sec_type);
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
-
-			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
-		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
-		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
-			ghes_defer_non_standard_event(gdata, sev);
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
-		}
-	}
-
-	/*
-	 * If no memory failure work is queued for abnormal synchronous
-	 * errors, do a force kill.
-	 */
-	if (sync && !queued) {
-		dev_err(ghes->dev,
-			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
-			current->comm, task_pid_nr(current));
-		force_sig(SIGBUS);
-	}
-}
-
-static void __ghes_print_estatus(const char *pfx,
-				 const struct acpi_hest_generic *generic,
-				 const struct acpi_hest_generic_status *estatus)
-{
-	static atomic_t seqno;
-	unsigned int curr_seqno;
-	char pfx_seq[64];
-
-	if (pfx == NULL) {
-		if (ghes_severity(estatus->error_severity) <=
-		    GHES_SEV_CORRECTED)
-			pfx = KERN_WARNING;
-		else
-			pfx = KERN_ERR;
-	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
-	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
-	       pfx_seq, generic->header.source_id);
-	cper_estatus_print(pfx_seq, estatus);
-}
-
-static int ghes_print_estatus(const char *pfx,
-			      const struct acpi_hest_generic *generic,
-			      const struct acpi_hest_generic_status *estatus)
-{
-	/* Not more than 2 messages every 5 seconds */
-	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
-	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
-	struct ratelimit_state *ratelimit;
-
-	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
-		ratelimit = &ratelimit_corrected;
-	else
-		ratelimit = &ratelimit_uncorrected;
-	if (__ratelimit(ratelimit)) {
-		__ghes_print_estatus(pfx, generic, estatus);
-		return 1;
-	}
-	return 0;
+	ghes_cper_handle_status(ghes->dev, ghes->generic,
+				estatus, is_hest_sync_notify(ghes));
 }
 
 static void __ghes_panic(struct ghes *ghes,
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 673dca208935..29b790160e91 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -10,22 +10,31 @@
  */
 
 #include <linux/aer.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
-#include <linux/irq_work.h>
 #include <linux/io.h>
+#include <linux/irq_work.h>
 #include <linux/kfifo.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/math64.h>
 #include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/uuid.h>
+#include <linux/sched/signal.h>
+#include <linux/task_work.h>
 #include <linux/notifier.h>
 #include <linux/llist.h>
+#include <linux/ras.h>
+#include <ras/ras_event.h>
 #include <linux/ratelimit.h>
 #include <linux/rcupdate.h>
 #include <linux/rculist.h>
 #include <linux/sched/clock.h>
 #include <linux/slab.h>
+#include <linux/vmcore_info.h>
+#include <linux/vmalloc.h>
 
 #include <acpi/apei.h>
 #include <acpi/ghes_cper.h>
@@ -35,9 +44,363 @@
 
 #include "apei-internal.h"
 
+ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+
+#ifndef CONFIG_ACPI_APEI
+void __weak arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err) { }
+#endif
+
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+struct gen_pool *ghes_estatus_pool;
+
+int ghes_estatus_pool_init(unsigned int num_ghes)
+{
+	unsigned long addr, len;
+	int rc;
+
+	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
+	if (!ghes_estatus_pool)
+		return -ENOMEM;
+
+	len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
+	len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
+
+	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
+	if (!addr)
+		goto err_pool_alloc;
+
+	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	if (rc)
+		goto err_pool_add;
+
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	gen_pool_destroy(ghes_estatus_pool);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_init);
+
+/**
+ * ghes_estatus_pool_region_free - free previously allocated memory
+ *				   from the ghes_estatus_pool.
+ * @addr: address of memory to free.
+ * @size: size of memory to free.
+ *
+ * Returns none.
+ */
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
+{
+	gen_pool_free(ghes_estatus_pool, addr, size);
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
+
+int ghes_severity(int severity)
+{
+	switch (severity) {
+	case CPER_SEV_INFORMATIONAL:
+		return GHES_SEV_NO;
+	case CPER_SEV_CORRECTED:
+		return GHES_SEV_CORRECTED;
+	case CPER_SEV_RECOVERABLE:
+		return GHES_SEV_RECOVERABLE;
+	case CPER_SEV_FATAL:
+		return GHES_SEV_PANIC;
+	default:
+		/* Unknown, go panic */
+		return GHES_SEV_PANIC;
+	}
+}
+
+
+/**
+ * struct ghes_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                work control flags
+ *
+ * Structure to pass task work to be handled before
+ * returning to user-space via task_work_add().
+ */
+struct ghes_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
+{
+	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
+	int ret;
+
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
+
+	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+			twcb->pfn, current->comm, task_pid_nr(current));
+	force_sig(SIGBUS);
+}
+
+static bool ghes_do_memory_failure(u64 physical_addr, int flags)
+{
+	struct ghes_task_work *twcb;
+	unsigned long pfn;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return false;
+
+	pfn = PHYS_PFN(physical_addr);
+
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return true;
+	}
+
+	memory_failure_queue(pfn, flags);
+	return true;
+}
+
+bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
+{
+	int flags = -1;
+	int sec_sev = ghes_severity(gdata->error_severity);
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == GHES_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
+		flags = sync ? MF_ACTION_REQUIRED : 0;
+
+	if (flags != -1)
+		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+
+	return false;
+}
+
+bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				     int sev, bool sync)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int length = gdata->error_data_length;
+	char error_type[120];
+	bool queued = false;
+	int sec_sev, i;
+	char *p;
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (length >= sizeof(*err)) {
+		log_arm_hw_error(err, sec_sev);
+	} else {
+		pr_warn(FW_BUG "arm error length: %d\n", length);
+		pr_warn(FW_BUG "length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		return false;
+	}
+
+	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
+		return false;
+
+	p = (char *)(err + 1);
+	length -= sizeof(err);
+
+	for (i = 0; i < err->err_info_num; i++) {
+		struct cper_arm_err_info *err_info;
+		bool is_cache, has_pa;
+
+		/* Ensure we have enough data for the error info header */
+		if (length < sizeof(*err_info))
+			break;
+
+		err_info = (struct cper_arm_err_info *)p;
+
+		/* Validate the claimed length before using it */
+		length -= err_info->length;
+		if (length < 0)
+			break;
+
+		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
+		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+
+		/*
+		 * The field (err_info->error_info & BIT(26)) is fixed to set to
+		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
+		 * firmware won't mix corrected errors in an uncorrected section,
+		 * and don't filter out 'corrected' error here.
+		 */
+		if (is_cache && has_pa) {
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			p += err_info->length;
+			continue;
+		}
+
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+		p += err_info->length;
+	}
+
+	return queued;
+}
+
+/*
+ * PCIe AER errors need to be sent to the AER driver for reporting and
+ * recovery. The GHES severities map to the following AER severities and
+ * require the following handling:
+ *
+ * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
+ *     These need to be reported by the AER driver but no recovery is
+ *     necessary.
+ * GHES_SEV_RECOVERABLE -> AER_NONFATAL
+ * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
+ *     These both need to be reported and recovered from by the AER driver.
+ * GHES_SEV_PANIC does not make it to this handling since the kernel must
+ *     panic.
+ */
+void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		unsigned int devfn;
+		int aer_severity;
+		u8 *aer_info;
+
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		aer_severity = cper_severity_to_aer(gdata->error_severity);
+
+		/*
+		 * If firmware reset the component to contain
+		 * the error, we must reinitialize it before
+		 * use, so treat it as a fatal AER error.
+		 */
+		if (gdata->flags & CPER_SEC_RESET)
+			aer_severity = AER_FATAL;
+
+		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
+						  sizeof(struct aer_capability_regs));
+		if (!aer_info)
+			return;
+		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
+		aer_recover_queue(pcie_err->device_id.segment,
+				  pcie_err->device_id.bus,
+				  devfn, aer_severity,
+				  (struct aer_capability_regs *)
+				  aer_info);
+	}
+#endif
+}
+
+void ghes_log_hwerr(int sev, guid_t *sec_type)
+{
+	if (sev != CPER_SEV_RECOVERABLE)
+		return;
+
+	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_GENERIC) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		hwerr_log_error_type(HWERR_RECOV_CPU);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+		hwerr_log_error_type(HWERR_RECOV_CXL);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
+	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS)) {
+		hwerr_log_error_type(HWERR_RECOV_PCI);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+		hwerr_log_error_type(HWERR_RECOV_MEMORY);
+		return;
+	}
+
+	hwerr_log_error_type(HWERR_RECOV_OTHERS);
+}
+
+void __ghes_print_estatus(const char *pfx,
+				 const struct acpi_hest_generic *generic,
+				 const struct acpi_hest_generic_status *estatus)
+{
+	static atomic_t seqno;
+	unsigned int curr_seqno;
+	char pfx_seq[64];
+
+	if (pfx == NULL) {
+		if (ghes_severity(estatus->error_severity) <=
+		    GHES_SEV_CORRECTED)
+			pfx = KERN_WARNING;
+		else
+			pfx = KERN_ERR;
+	}
+	curr_seqno = atomic_inc_return(&seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
+	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
+	       pfx_seq, generic->header.source_id);
+	cper_estatus_print(pfx_seq, estatus);
+}
+
+int ghes_print_estatus(const char *pfx,
+			      const struct acpi_hest_generic *generic,
+			      const struct acpi_hest_generic_status *estatus)
+{
+	/* Not more than 2 messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
+	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
+	struct ratelimit_state *ratelimit;
+
+	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
+		ratelimit = &ratelimit_corrected;
+	else
+		ratelimit = &ratelimit_uncorrected;
+	if (__ratelimit(ratelimit)) {
+		__ghes_print_estatus(pfx, generic, estatus);
+		return 1;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_ACPI_APEI
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -269,6 +632,7 @@ void ghes_clear_estatus(struct ghes *ghes,
 	if (is_hest_type_generic_v2(ghes))
 		ghes_ack_error(ghes->generic_v2);
 }
+#endif /* CONFIG_ACPI_APEI */
 
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
@@ -322,6 +686,78 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 }
 
 
+void ghes_cper_handle_status(struct device *dev,
+			     const struct acpi_hest_generic *generic,
+			     const struct acpi_hest_generic_status *estatus,
+			     bool sync)
+{
+	int sev, sec_sev;
+	struct acpi_hest_generic_data *gdata;
+	guid_t *sec_type;
+	const guid_t *fru_id = &guid_null;
+	char *fru_text = "";
+	bool queued = false;
+
+	sev = ghes_severity(estatus->error_severity);
+	apei_estatus_for_each_section(estatus, gdata) {
+		sec_type = (guid_t *)gdata->section_type;
+		sec_sev = ghes_severity(gdata->error_severity);
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+			fru_id = (guid_t *)gdata->fru_id;
+
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+			fru_text = gdata->fru_text;
+
+		ghes_log_hwerr(sev, sec_type);
+		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
+
+			arch_apei_report_mem_error(sev, mem_err);
+			queued = ghes_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			ghes_handle_aer(gdata);
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			ghes_defer_non_standard_event(gdata, sev);
+			log_non_standard_event(sec_type, fru_id, fru_text,
+					       sec_sev, err,
+					       gdata->error_data_length);
+		}
+	}
+
+	/*
+	 * If no memory failure work is queued for abnormal synchronous
+	 * errors, do a force kill.
+	 */
+	if (sync && !queued) {
+		dev_err(dev,
+			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
+			current->comm, task_pid_nr(current));
+		force_sig(SIGBUS);
+	}
+}
+
 /* Room for 8 entries */
 #define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
 static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 4522e8699ce0..f7c9fba62585 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -12,6 +12,8 @@
 #define ACPI_APEI_GHES_CPER_H
 
 #include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
@@ -52,6 +54,7 @@
 	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
 extern struct gen_pool *ghes_estatus_pool;
+extern struct atomic_notifier_head ghes_report_chain;
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -100,6 +103,23 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
 void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 				   int sev);
+int ghes_severity(int severity);
+bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				int sev, bool sync);
+bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+			      int sev, bool sync);
+void ghes_handle_aer(struct acpi_hest_generic_data *gdata);
+void ghes_log_hwerr(int sev, guid_t *sec_type);
+void __ghes_print_estatus(const char *pfx,
+			  const struct acpi_hest_generic *generic,
+			  const struct acpi_hest_generic_status *estatus);
+int ghes_print_estatus(const char *pfx,
+		       const struct acpi_hest_generic *generic,
+		       const struct acpi_hest_generic_status *estatus);
+void ghes_cper_handle_status(struct device *dev,
+			     const struct acpi_hest_generic *generic,
+			     const struct acpi_hest_generic_status *estatus,
+			     bool sync);
 void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 			    int severity);
 int cxl_cper_register_prot_err_work(struct work_struct *work);

-- 
2.43.0


