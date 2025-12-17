Return-Path: <linux-acpi+bounces-19615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A6CC7595
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C3730056F4
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85371350A28;
	Wed, 17 Dec 2025 11:29:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691F34AAE6;
	Wed, 17 Dec 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970978; cv=none; b=ppmQzxZG0xmQ3g8Shrbg0SNKdJAeHb6iNbm3GhGHMJ3XIr6ZXNSZ79JZS/B5nJMOC66BtiJ9+os/P75/PgewaZI/jd8hGHue+VKsktZe+4PHeqqBlfiZ73Xa7qSGz1Z2YA2UllfmSrx0NkKan74UvvkyZ9EtJWgcYomDuDp5YlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970978; c=relaxed/simple;
	bh=1yvtF9bP/STvx+l1oEeeXD80U6oOuBrssm1lMRDH+Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUVJ5SpYoTOC5aVHY4dguVSlccGqzJ3qn3+5NoK90KoRAOXnOUXJjCovotuYJ2QTriSLubzdKfeNw7w1ArZm6vfP7XQQRTkO4EWHG5uPkwS9dCPgHqfQCPbUhyrlgUqiTB5ge5R7g+IKFNMuyGIj3AwAFUNCdHvfQ+RFhdGtG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF4214BF;
	Wed, 17 Dec 2025 03:29:28 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0338C3F73B;
	Wed, 17 Dec 2025 03:29:33 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 03/12] ras: add estatus vendor handling and processing
Date: Wed, 17 Dec 2025 11:28:36 +0000
Message-ID: <20251217112845.1814119-4-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the estatus core how to walk CPER records and expose the vendor
record notification path. This adds the section iteration helpers,
the logging helpers that mirror the GHES behaviour, and the deferred
work used to hand vendor GUIDs to interested drivers. No users switch
over yet; this simply moves the common logic out of GHES so the next
patches can wire it up.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/firmware/efi/estatus.c | 415 +++++++++++++++++++++++++++++++++
 1 file changed, 415 insertions(+)

diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
index 8dae5c73ce27..5a848d1b218e 100644
--- a/drivers/firmware/efi/estatus.c
+++ b/drivers/firmware/efi/estatus.c
@@ -17,6 +17,7 @@
 #include <linux/aer.h>
 #include <linux/nmi.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/signal.h>
 #include <linux/uuid.h>
 #include <linux/kconfig.h>
 #include <linux/ras.h>
@@ -119,6 +120,14 @@ static int estatus_panic_timeout __read_mostly = 30;
 static struct gen_pool *estatus_pool;
 static DEFINE_MUTEX(estatus_pool_mutex);
 
+static enum fixed_addresses estatus_source_fixmap(struct estatus_source *source)
+{
+	if (WARN_ON_ONCE(!source->fixmap_idx))
+		return FIX_HOLE;
+
+	return source->fixmap_idx;
+}
+
 static inline const char *estatus_source_name(struct estatus_source *source)
 {
 	if (source->ops && source->ops->get_name)
@@ -558,3 +567,409 @@ static void estatus_cache_add(struct estatus_source *source,
 				 estatus_cache_rcu_free);
 	}
 }
+
+struct estatus_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void estatus_memory_failure_cb(struct callback_head *twork)
+{
+	struct estatus_task_work *twcb = container_of(twork, struct estatus_task_work, twork);
+	int ret;
+
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	gen_pool_free(estatus_pool, (unsigned long)twcb, sizeof(*twcb));
+
+	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err(HW_ERR ESTATUS_PFX
+	       "%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+	       twcb->pfn, current->comm, task_pid_nr(current));
+	force_sig(SIGBUS);
+}
+
+static bool estatus_do_memory_failure(u64 physical_addr, int flags)
+{
+	struct estatus_task_work *twcb;
+	unsigned long pfn;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return false;
+
+	pfn = PHYS_PFN(physical_addr);
+	if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
+		pr_warn_ratelimited(FW_WARN ESTATUS_PFX
+		"Invalid address in generic error data: %#llx\n",
+		physical_addr);
+		return false;
+	}
+
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = (void *)gen_pool_alloc(estatus_pool, sizeof(*twcb));
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, estatus_memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return true;
+	}
+
+	memory_failure_queue(pfn, flags);
+	return true;
+}
+
+static bool estatus_handle_memory_failure(estatus_generic_data *gdata, int sev, bool sync)
+{
+	int flags = -1;
+	int sec_sev = estatus_severity(gdata->error_severity);
+	struct cper_sec_mem_err *mem_err = estatus_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == ESTATUS_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == ESTATUS_SEV_RECOVERABLE && sec_sev == ESTATUS_SEV_RECOVERABLE)
+		flags = sync ? MF_ACTION_REQUIRED : 0;
+
+	if (flags != -1)
+		return estatus_do_memory_failure(mem_err->physical_addr, flags);
+
+	return false;
+}
+
+static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bool sync)
+{
+	struct cper_sec_proc_arm *err = estatus_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	bool queued = false;
+	int sec_sev, i;
+	char *p;
+
+	log_arm_hw_error(err);
+
+	sec_sev = estatus_severity(gdata->error_severity);
+	if (sev != ESTATUS_SEV_RECOVERABLE || sec_sev != ESTATUS_SEV_RECOVERABLE)
+		return false;
+
+	p = (char *)(err + 1);
+	for (i = 0; i < err->err_info_num; i++) {
+		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
+		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+		const char *error_type = "unknown error";
+
+		/*
+		 * The field (err_info->error_info & BIT(26)) is fixed to set to
+		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
+		 * firmware won't mix corrected errors in an uncorrected section,
+		 * and don't filter out 'corrected' error here.
+		 */
+		if (is_cache && has_pa) {
+			queued = estatus_do_memory_failure(err_info->physical_fault_addr, flags);
+			p += err_info->length;
+			continue;
+		}
+
+		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
+			error_type = cper_proc_error_type_strs[err_info->type];
+
+		pr_warn_ratelimited(FW_WARN ESTATUS_PFX
+				    "Unhandled processor error type: %s\n",
+				    error_type);
+		p += err_info->length;
+	}
+
+	return queued;
+}
+
+/*
+ * PCIe AER errors need to be sent to the AER driver for reporting and
+ * recovery. The ESTATUS severities map to the following AER severities and
+ * require the following handling:
+ *
+ * ESTATUS_SEV_CORRECTABLE -> AER_CORRECTABLE
+ *     These need to be reported by the AER driver but no recovery is
+ *     necessary.
+ * ESTATUS_SEV_RECOVERABLE -> AER_NONFATAL
+ * ESTATUS_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
+ *     These both need to be reported and recovered from by the AER driver.
+ * ESTATUS_SEV_PANIC does not make it to this handling since the kernel must
+ *     panic.
+ */
+static void estatus_handle_aer(estatus_generic_data *gdata)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = estatus_get_payload(gdata);
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
+		aer_info = (void *)gen_pool_alloc(estatus_pool,
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
+static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
+
+int estatus_register_vendor_record_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(estatus_register_vendor_record_notifier);
+
+void estatus_unregister_vendor_record_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(estatus_unregister_vendor_record_notifier);
+
+static void estatus_vendor_record_work_func(struct work_struct *work)
+{
+	struct estatus_vendor_record_entry *entry;
+	estatus_generic_data *gdata;
+	u32 len;
+
+	entry = container_of(work, struct estatus_vendor_record_entry, work);
+	gdata = ESTATUS_GDATA_FROM_VENDOR_ENTRY(entry);
+
+	blocking_notifier_call_chain(&vendor_record_notify_list,
+				     entry->error_severity, gdata);
+
+	len = ESTATUS_VENDOR_ENTRY_LEN(estatus_get_record_size(gdata));
+	gen_pool_free(estatus_pool, (unsigned long)entry, len);
+}
+
+static void estatus_defer_non_standard_event(estatus_generic_data *gdata, int sev)
+{
+	estatus_generic_data *copied_gdata;
+	struct estatus_vendor_record_entry *entry;
+	u32 len;
+
+	len = ESTATUS_VENDOR_ENTRY_LEN(estatus_get_record_size(gdata));
+	entry = (void *)gen_pool_alloc(estatus_pool, len);
+	if (!entry)
+		return;
+
+	copied_gdata = ESTATUS_GDATA_FROM_VENDOR_ENTRY(entry);
+	memcpy(copied_gdata, gdata, estatus_get_record_size(gdata));
+	entry->error_severity = sev;
+
+	INIT_WORK(&entry->work, estatus_vendor_record_work_func);
+	schedule_work(&entry->work);
+}
+
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt). On x86, the HEST notifications are always
+ * asynchronous, so only SEA on ARM is delivered as a synchronous
+ * notification.
+ */
+static inline bool estatus_is_sync_notify(struct estatus_source *source)
+{
+	return estatus_source_notify_mode(source) == ESTATUS_NOTIFY_SEA;
+}
+
+static void estatus_do_proc(struct estatus_source *source, const estatus_generic_status *estatus)
+{
+	int sev, sec_sev;
+	estatus_generic_data *gdata;
+	guid_t *sec_type;
+	const guid_t *fru_id = &guid_null;
+	char *fru_text = "";
+	bool queued = false;
+	bool sync = estatus_is_sync_notify(source);
+
+	sev = estatus_severity(estatus->error_severity);
+	estatus_for_each_section(estatus, gdata) {
+		sec_type = (guid_t *)gdata->section_type;
+		sec_sev = estatus_severity(gdata->error_severity);
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+			fru_id = (guid_t *)gdata->fru_id;
+
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+			fru_text = gdata->fru_text;
+
+		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+			struct cper_sec_mem_err *mem_err = estatus_get_payload(gdata);
+
+			atomic_notifier_call_chain(&estatus_report_chain, sev, mem_err);
+
+			estatus_report_mem_error(sev, mem_err);
+			queued = estatus_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			estatus_handle_aer(gdata);
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+			queued = estatus_handle_arm_hw_error(gdata, sev, sync);
+		} else {
+			void *err = estatus_get_payload(gdata);
+
+			estatus_defer_non_standard_event(gdata, sev);
+			log_non_standard_event(sec_type, fru_id, fru_text,
+					       sec_sev, err,
+					       gdata->error_data_length);
+		}
+	}
+
+	if (sync && !queued) {
+		pr_err(HW_ERR ESTATUS_PFX
+		       "%s: synchronous unrecoverable error (SIGBUS)\n",
+		       estatus_source_name(source));
+		force_sig(SIGBUS);
+	}
+}
+
+static void __estatus_panic(struct estatus_source *source, estatus_generic_status *estatus,
+			    phys_addr_t buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	const char *msg = ESTATUS_PFX "Fatal hardware error";
+
+	__estatus_print_estatus(KERN_EMERG, source, estatus);
+
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
+	estatus_clear_estatus(source, estatus, buf_paddr, fixmap_idx);
+
+	if (!panic_timeout)
+		pr_emerg("%s but panic disabled\n", msg);
+
+	panic(msg);
+}
+
+int estatus_proc(struct estatus_source *source)
+{
+	estatus_generic_status *estatus = source->estatus;
+	phys_addr_t buf_paddr;
+	enum fixed_addresses fixmap_idx = estatus_source_fixmap(source);
+	int rc;
+
+	rc = estatus_read_estatus(source, estatus, &buf_paddr, fixmap_idx);
+	if (rc)
+		goto out;
+
+	if (estatus_severity(estatus->error_severity) >= ESTATUS_SEV_PANIC)
+		__estatus_panic(source, estatus, buf_paddr, fixmap_idx);
+
+	if (!estatus_cached(estatus)) {
+		if (estatus_print_estatus(NULL, source, estatus))
+			estatus_cache_add(source, estatus);
+	}
+	estatus_do_proc(source, estatus);
+
+out:
+	estatus_clear_estatus(source, estatus, buf_paddr, fixmap_idx);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(estatus_proc);
+
+/*
+ * Handlers for CPER records may not be NMI safe. For example,
+ * memory_failure_queue() takes spinlocks and calls schedule_work_on().
+ * In any NMI-like handler, memory from estatus_pool is used to save
+ * estatus, and added to the estatus_llist. irq_work_queue() causes
+ * estatus_proc_in_irq() to run in IRQ context where each estatus in
+ * estatus_llist is processed.
+ *
+ * Memory from the estatus_pool is also used with the estatus_cache
+ * to suppress frequent messages.
+ */
+static struct llist_head estatus_llist;
+
+void estatus_proc_in_irq(struct irq_work *irq_work)
+{
+	struct llist_node *llnode, *next;
+	struct estatus_node *estatus_node;
+	struct estatus_source *source;
+	estatus_generic_status *estatus;
+	u32 len, node_len;
+
+	llnode = llist_del_all(&estatus_llist);
+	/*
+	 * Because the time order of estatus in list is reversed,
+	 * revert it back to proper order.
+	 */
+	llnode = llist_reverse_order(llnode);
+	while (llnode) {
+		next = llnode->next;
+		estatus_node = llist_entry(llnode, struct estatus_node,
+					   llnode);
+		source = estatus_node->source;
+		estatus = ESTATUS_FROM_NODE(estatus_node);
+		len = estatus_len(estatus);
+		node_len = ESTATUS_NODE_LEN(len);
+		estatus_do_proc(source, estatus);
+		if (!estatus_cached(estatus)) {
+			if (estatus_print_estatus(NULL, source, estatus))
+				estatus_cache_add(source, estatus);
+		}
+		gen_pool_free(estatus_pool,
+			      (unsigned long)estatus_node, node_len);
+
+		llnode = next;
+	}
+}
+EXPORT_SYMBOL_GPL(estatus_proc_in_irq);
+
+static void estatus_print_queued_estatus(void)
+{
+	struct llist_node *llnode;
+	struct estatus_node *estatus_node;
+	struct estatus_source *source;
+	estatus_generic_status *estatus;
+
+	llnode = llist_del_all(&estatus_llist);
+	/*
+	 * Because the time order of estatus in list is reversed,
+	 * revert it back to proper order.
+	 */
+	llnode = llist_reverse_order(llnode);
+	while (llnode) {
+		estatus_node = llist_entry(llnode, struct estatus_node,
+					   llnode);
+		estatus = ESTATUS_FROM_NODE(estatus_node);
+		source = estatus_node->source;
+		estatus_print_estatus(NULL, source, estatus);
+		llnode = llnode->next;
+	}
+}
+
+void estatus_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
+{
+#if IS_ENABLED(CONFIG_ACPI_APEI_GHES)
+	arch_apei_report_mem_error(sev, mem_err);
+#endif
+}
-- 
2.43.0


