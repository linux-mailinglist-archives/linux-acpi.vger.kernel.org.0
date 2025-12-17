Return-Path: <linux-acpi+bounces-19621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76672CC7606
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0940E301D39F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366B32938B;
	Wed, 17 Dec 2025 11:31:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227F2F362D;
	Wed, 17 Dec 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971078; cv=none; b=k/oTSs1L3IFFs4E94jJdyaLejf1Q2Ni1LHvDgl89e3SKoHozQ/XzyNnI9ooEZuPYkmBwNc8DhuYR6tC5hNS159dvdf4XI5yhXRpDk2//Iwi17URRuIVbBtoEgdmXJ1LKq2yQdBdhHUNnXWRt6lIQChf8yTB5Gzb/W4FELSwWh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971078; c=relaxed/simple;
	bh=rf7Ah+U1i6XQn0d3IongzvQBiHNrH7ZwhL3LT+zdAdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDk2aBUgi8VjS0BBfQnk6LWHDqlEr5lgxjhzufW0zHYGGLEsSroeZM+2paX04uTa15xa8dTftSrvlVWRf++ibuXVOfaFEibhBHI7xa335jNJ9RLjZk3f+lcfp+Px7oDT42gBGbjgEGkTGsHPnYnRV/plYSzLSUlbmeA4r5fJcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5896B168F;
	Wed, 17 Dec 2025 03:31:06 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB063F73B;
	Wed, 17 Dec 2025 03:31:11 -0800 (PST)
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
Subject: [PATCH 09/12] ghes: route error handling through shared estatus core
Date: Wed, 17 Dec 2025 11:28:42 +0000
Message-ID: <20251217112845.1814119-10-ahmed.tiba@arm.com>
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

Switch GHES over to the shared estatus. GHES call the common helpers.
This shrinks ghes.c considerably
while keeping runtime behaviour identical, and it allows other
firmware-first providers to reuse exactly the same processing logic.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c       | 1137 +-------------------------------
 drivers/firmware/efi/estatus.c |   55 +-
 2 files changed, 43 insertions(+), 1149 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5932542ea942..8a9fb9d4ffda 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -60,36 +60,6 @@
 #define GHES_PFX	"GHES: "
 
 #define GHES_ESTATUS_MAX_SIZE		65536
-#define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
-
-#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
-
-/* This is just an estimation for memory pool allocation */
-#define GHES_ESTATUS_CACHE_AVG_SIZE	512
-
-#define GHES_ESTATUS_CACHES_SIZE	4
-
-#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
-/* Prevent too many caches are allocated because of RCU */
-#define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
-
-#define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
-	(sizeof(struct ghes_estatus_cache) + (estatus_len))
-#define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
-	((struct acpi_hest_generic_status *)				\
-	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
-
-#define GHES_ESTATUS_NODE_LEN(estatus_len)			\
-	(sizeof(struct ghes_estatus_node) + (estatus_len))
-#define GHES_ESTATUS_FROM_NODE(estatus_node)			\
-	((struct acpi_hest_generic_status *)				\
-	 ((struct ghes_estatus_node *)(estatus_node) + 1))
-
-#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
-	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
-#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
-	((struct acpi_hest_generic_data *)                              \
-	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
 /*
  *  NMI-like notifications vary by architecture, before the compiler can prune
@@ -100,27 +70,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
-static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
-
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
-/*
- * A platform may describe one error source for the handling of synchronous
- * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
- * or External Interrupt). On x86, the HEST notifications are always
- * asynchronous, so only SEA on ARM is delivered as a synchronous
- * notification.
- */
-static inline bool is_hest_sync_notify(struct ghes *ghes)
-{
-	u8 notify_type = ghes->generic->notify.type;
-
-	return notify_type == ACPI_HEST_NOTIFY_SEA;
-}
-
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -165,67 +119,11 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-struct ghes_vendor_record_entry {
-	struct work_struct work;
-	int error_severity;
-	char vendor_record[];
-};
-
-static struct gen_pool *ghes_estatus_pool;
-
-static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
-static atomic_t ghes_estatus_cache_alloced;
-
-static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
-{
-	phys_addr_t paddr;
-	pgprot_t prot;
-
-	paddr = PFN_PHYS(pfn);
-	prot = arch_apei_get_mem_attribute(paddr);
-	__set_fixmap(fixmap_idx, paddr, prot);
-
-	return (void __iomem *) __fix_to_virt(fixmap_idx);
-}
-
-static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
-{
-	int _idx = virt_to_fix((unsigned long)vaddr);
-
-	WARN_ON_ONCE(fixmap_idx != _idx);
-	clear_fixmap(fixmap_idx);
-}
-
 int ghes_estatus_pool_init(unsigned int num_ghes)
 {
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
+	return estatus_pool_init(num_ghes);
 }
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_init);
 
 /**
  * ghes_estatus_pool_region_free - free previously allocated memory
@@ -237,7 +135,7 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
  */
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
 {
-	gen_pool_free(ghes_estatus_pool, addr, size);
+	estatus_pool_region_free(addr, size);
 }
 EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
 
@@ -253,21 +151,6 @@ static void unmap_gen_v2(struct ghes *ghes)
 
 static const struct estatus_ops ghes_estatus_ops;
 
-static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
-{
-	int rc;
-	u64 val = 0;
-
-	rc = apei_read(&val, &gv2->read_ack_register);
-	if (rc)
-		return;
-
-	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
-	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
-
-	apei_write(val, &gv2->read_ack_register);
-}
-
 static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 {
 	struct ghes *ghes;
@@ -329,876 +212,18 @@ static void ghes_fini(struct ghes *ghes)
 	if (is_hest_type_generic_v2(ghes))
 		unmap_gen_v2(ghes);
 }
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
-static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
-				  int from_phys,
-				  enum fixed_addresses fixmap_idx)
-{
-	void __iomem *vaddr;
-	u64 offset;
-	u32 trunk;
-
-	while (len > 0) {
-		offset = paddr - (paddr & PAGE_MASK);
-		vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
-		trunk = PAGE_SIZE - offset;
-		trunk = min(trunk, len);
-		if (from_phys)
-			memcpy_fromio(buffer, vaddr + offset, trunk);
-		else
-			memcpy_toio(vaddr + offset, buffer, trunk);
-		len -= trunk;
-		paddr += trunk;
-		buffer += trunk;
-		ghes_unmap(vaddr, fixmap_idx);
-	}
-}
-
-/* Check the top-level record header has an appropriate size. */
-static int __ghes_check_estatus(struct ghes *ghes,
-				struct acpi_hest_generic_status *estatus)
-{
-	u32 len = cper_estatus_len(estatus);
-
-	if (len < sizeof(*estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
-		return -EIO;
-	}
-
-	if (len > ghes->generic->error_block_length) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
-		return -EIO;
-	}
-
-	if (cper_estatus_check_header(estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/* Read the CPER block, returning its address, and header in estatus. */
-static int __ghes_peek_estatus(struct ghes *ghes,
-			       struct acpi_hest_generic_status *estatus,
-			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	struct acpi_hest_generic *g = ghes->generic;
-	int rc;
-
-	rc = apei_read(buf_paddr, &g->error_status_address);
-	if (rc) {
-		*buf_paddr = 0;
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-"Failed to read error status block address for hardware error source: %d.\n",
-				   g->header.source_id);
-		return -EIO;
-	}
-	if (!*buf_paddr)
-		return -ENOENT;
-
-	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
-			      fixmap_idx);
-	if (!estatus->block_status) {
-		*buf_paddr = 0;
-		return -ENOENT;
-	}
-
-	return 0;
-}
-
-static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
-			       u64 buf_paddr, enum fixed_addresses fixmap_idx,
-			       size_t buf_len)
-{
-	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
-	if (cper_estatus_check(estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Failed to read error status block!\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int ghes_read_estatus(struct ghes *ghes,
-			     struct acpi_hest_generic_status *estatus,
-			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	int rc;
-
-	rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
-	if (rc)
-		return rc;
-
-	rc = __ghes_check_estatus(ghes, estatus);
-	if (rc)
-		return rc;
-
-	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
-				   cper_estatus_len(estatus));
-}
-
-static void ghes_clear_estatus(struct ghes *ghes,
-			       struct acpi_hest_generic_status *estatus,
-			       u64 buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	estatus->block_status = 0;
-
-	if (!buf_paddr)
-		return;
-
-	ghes_copy_tofrom_phys(estatus, buf_paddr,
-			      sizeof(estatus->block_status), 0,
-			      fixmap_idx);
-
-	/*
-	 * GHESv2 type HEST entries introduce support for error acknowledgment,
-	 * so only acknowledge the error if this support is present.
-	 */
-	if (is_hest_type_generic_v2(ghes))
-		ghes_ack_error(ghes->generic_v2);
-}
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
-	char error_type[120];
-	bool queued = false;
-	int sec_sev, i;
-	char *p;
-
-	sec_sev = ghes_severity(gdata->error_severity);
-	log_arm_hw_error(err, sec_sev);
-	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
-		return false;
-
-	p = (char *)(err + 1);
-	for (i = 0; i < err->err_info_num; i++) {
-		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
-		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
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
-static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
-
 int ghes_register_vendor_record_notifier(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
+	return estatus_register_vendor_record_notifier(nb);
 }
 EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
 
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
+	estatus_unregister_vendor_record_notifier(nb);
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
 
-static void ghes_vendor_record_work_func(struct work_struct *work)
-{
-	struct ghes_vendor_record_entry *entry;
-	struct acpi_hest_generic_data *gdata;
-	u32 len;
-
-	entry = container_of(work, struct ghes_vendor_record_entry, work);
-	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
-
-	blocking_notifier_call_chain(&vendor_record_notify_list,
-				     entry->error_severity, gdata);
-
-	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len);
-}
-
-static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
-					  int sev)
-{
-	struct acpi_hest_generic_data *copied_gdata;
-	struct ghes_vendor_record_entry *entry;
-	u32 len;
-
-	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
-	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
-	if (!entry)
-		return;
-
-	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
-	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
-	entry->error_severity = sev;
-
-	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
-	schedule_work(&entry->work);
-}
-
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
-	u8 *dvsec_start, *cap_start;
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
-		pr_err_ratelimited("CXL CPER invalid agent type\n");
-		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
-		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
-		return;
-	}
-
-	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
-		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
-				   prot_err->err_len);
-		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
-		pr_warn(FW_WARN "CXL CPER no device serial number\n");
-
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
-
-	if (!cxl_cper_prot_err_work)
-		return;
-
-	switch (prot_err->agent_type) {
-	case RCD:
-	case DEVICE:
-	case LD:
-	case FMLD:
-	case RP:
-	case DSP:
-	case USP:
-		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
-
-		dvsec_start = (u8 *)(prot_err + 1);
-		cap_start = dvsec_start + prot_err->dvsec_len;
-
-		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
-		wd.severity = cper_severity_to_aer(severity);
-		break;
-	default:
-		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
-				   prot_err->agent_type);
-		return;
-	}
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
-
-static void ghes_do_proc(struct ghes *ghes,
-			 const struct acpi_hest_generic_status *estatus)
-{
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
-}
-
-/*
- * GHES error status reporting throttle, to report more kinds of
- * errors, instead of just most frequently occurred errors.
- */
-static int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
-{
-	u32 len;
-	int i, cached = 0;
-	unsigned long long now;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	len = cper_estatus_len(estatus);
-	rcu_read_lock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL)
-			continue;
-		if (len != cache->estatus_len)
-			continue;
-		cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-		if (memcmp(estatus, cache_estatus, len))
-			continue;
-		atomic_inc(&cache->count);
-		now = sched_clock();
-		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
-			cached = 1;
-		break;
-	}
-	rcu_read_unlock();
-	return cached;
-}
-
-static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
-	struct acpi_hest_generic *generic,
-	struct acpi_hest_generic_status *estatus)
-{
-	int alloced;
-	u32 len, cache_len;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
-	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	len = cper_estatus_len(estatus);
-	cache_len = GHES_ESTATUS_CACHE_LEN(len);
-	cache = (void *)gen_pool_alloc(ghes_estatus_pool, cache_len);
-	if (!cache) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-	memcpy(cache_estatus, estatus, len);
-	cache->estatus_len = len;
-	atomic_set(&cache->count, 0);
-	cache->generic = generic;
-	cache->time_in = sched_clock();
-	return cache;
-}
-
-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-	struct ghes_estatus_cache *cache;
-	u32 len;
-
-	cache = container_of(head, struct ghes_estatus_cache, rcu);
-	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
-	len = GHES_ESTATUS_CACHE_LEN(len);
-	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
-	atomic_dec(&ghes_estatus_cache_alloced);
-}
-
-static void
-ghes_estatus_cache_add(struct acpi_hest_generic *generic,
-		       struct acpi_hest_generic_status *estatus)
-{
-	unsigned long long now, duration, period, max_period = 0;
-	struct ghes_estatus_cache *cache, *new_cache;
-	struct ghes_estatus_cache __rcu *victim;
-	int i, slot = -1, count;
-
-	new_cache = ghes_estatus_cache_alloc(generic, estatus);
-	if (!new_cache)
-		return;
-
-	rcu_read_lock();
-	now = sched_clock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL) {
-			slot = i;
-			break;
-		}
-		duration = now - cache->time_in;
-		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
-			slot = i;
-			break;
-		}
-		count = atomic_read(&cache->count);
-		period = duration;
-		do_div(period, (count + 1));
-		if (period > max_period) {
-			max_period = period;
-			slot = i;
-		}
-	}
-	rcu_read_unlock();
-
-	if (slot != -1) {
-		/*
-		 * Use release semantics to ensure that ghes_estatus_cached()
-		 * running on another CPU will see the updated cache fields if
-		 * it can see the new value of the pointer.
-		 */
-		victim = xchg_release(&ghes_estatus_caches[slot],
-				      RCU_INITIALIZER(new_cache));
-
-		/*
-		 * At this point, victim may point to a cached item different
-		 * from the one based on which we selected the slot. Instead of
-		 * going to the loop again to pick another slot, let's just
-		 * drop the other item anyway: this may cause a false cache
-		 * miss later on, but that won't cause any problems.
-		 */
-		if (victim)
-			call_rcu(&unrcu_pointer(victim)->rcu,
-				 ghes_estatus_cache_rcu_free);
-	}
-}
-
-static void __ghes_panic(struct ghes *ghes,
-			 struct acpi_hest_generic_status *estatus,
-			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	const char *msg = GHES_PFX "Fatal hardware error";
-
-	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
-
-	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
-
-	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
-
-	if (!panic_timeout)
-		pr_emerg("%s but panic disabled\n", msg);
-
-	panic(msg);
-}
-
-static int ghes_proc(struct ghes *ghes)
-{
-	struct acpi_hest_generic_status *estatus = ghes->estatus;
-	u64 buf_paddr;
-	int rc;
-
-	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
-	if (rc)
-		goto out;
-
-	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
-		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
-
-	if (!ghes_estatus_cached(estatus)) {
-		if (ghes_print_estatus(NULL, ghes->generic, estatus))
-			ghes_estatus_cache_add(ghes->generic, estatus);
-	}
-	ghes_do_proc(ghes, estatus);
-
-out:
-	ghes_clear_estatus(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
-
-	return rc;
-}
-
 static void ghes_add_timer(struct ghes *ghes)
 {
 	struct acpi_hest_generic *g = ghes->generic;
@@ -1220,7 +245,7 @@ static void ghes_poll_func(struct timer_list *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	ghes_proc(ghes);
+	estatus_proc(&ghes->estatus_src);
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 	if (!(ghes->flags & GHES_EXITING))
 		ghes_add_timer(ghes);
@@ -1233,7 +258,7 @@ static irqreturn_t ghes_irq_func(int irq, void *data)
 	int rc;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rc = ghes_proc(ghes);
+	rc = estatus_proc(&ghes->estatus_src);
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 	if (rc)
 		return IRQ_NONE;
@@ -1250,7 +275,7 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
-		if (!ghes_proc(ghes))
+		if (!estatus_proc(&ghes->estatus_src))
 			ret = NOTIFY_OK;
 	}
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
@@ -1262,142 +287,8 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-/*
- * Handlers for CPER records may not be NMI safe. For example,
- * memory_failure_queue() takes spinlocks and calls schedule_work_on().
- * In any NMI-like handler, memory from ghes_estatus_pool is used to save
- * estatus, and added to the ghes_estatus_llist. irq_work_queue() causes
- * ghes_proc_in_irq() to run in IRQ context where each estatus in
- * ghes_estatus_llist is processed.
- *
- * Memory from the ghes_estatus_pool is also used with the ghes_estatus_cache
- * to suppress frequent messages.
- */
-static struct llist_head ghes_estatus_llist;
 static struct irq_work ghes_proc_irq_work;
 
-static void ghes_proc_in_irq(struct irq_work *irq_work)
-{
-	struct llist_node *llnode, *next;
-	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic *generic;
-	struct acpi_hest_generic_status *estatus;
-	u32 len, node_len;
-
-	llnode = llist_del_all(&ghes_estatus_llist);
-	/*
-	 * Because the time order of estatus in list is reversed,
-	 * revert it back to proper order.
-	 */
-	llnode = llist_reverse_order(llnode);
-	while (llnode) {
-		next = llnode->next;
-		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
-					   llnode);
-		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		len = cper_estatus_len(estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
-
-		ghes_do_proc(estatus_node->ghes, estatus);
-
-		if (!ghes_estatus_cached(estatus)) {
-			generic = estatus_node->generic;
-			if (ghes_print_estatus(NULL, generic, estatus))
-				ghes_estatus_cache_add(generic, estatus);
-		}
-		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
-			      node_len);
-
-		llnode = next;
-	}
-}
-
-static void ghes_print_queued_estatus(void)
-{
-	struct llist_node *llnode;
-	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic *generic;
-	struct acpi_hest_generic_status *estatus;
-
-	llnode = llist_del_all(&ghes_estatus_llist);
-	/*
-	 * Because the time order of estatus in list is reversed,
-	 * revert it back to proper order.
-	 */
-	llnode = llist_reverse_order(llnode);
-	while (llnode) {
-		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
-					   llnode);
-		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		generic = estatus_node->generic;
-		ghes_print_estatus(NULL, generic, estatus);
-		llnode = llnode->next;
-	}
-}
-
-static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
-				       enum fixed_addresses fixmap_idx)
-{
-	struct acpi_hest_generic_status *estatus, tmp_header;
-	struct ghes_estatus_node *estatus_node;
-	u32 len, node_len;
-	u64 buf_paddr;
-	int sev, rc;
-
-	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG))
-		return -EOPNOTSUPP;
-
-	rc = __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr, fixmap_idx);
-	if (rc) {
-		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
-		return rc;
-	}
-
-	rc = __ghes_check_estatus(ghes, &tmp_header);
-	if (rc) {
-		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
-		return rc;
-	}
-
-	len = cper_estatus_len(&tmp_header);
-	node_len = GHES_ESTATUS_NODE_LEN(len);
-	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
-	if (!estatus_node)
-		return -ENOMEM;
-
-	estatus_node->ghes = ghes;
-	estatus_node->generic = ghes->generic;
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-
-	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
-		ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
-		rc = -ENOENT;
-		goto no_work;
-	}
-
-	sev = ghes_severity(estatus->error_severity);
-	if (sev >= GHES_SEV_PANIC) {
-		ghes_print_queued_estatus();
-		__ghes_panic(ghes, estatus, buf_paddr, fixmap_idx);
-	}
-
-	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
-
-	/* This error has been reported before, don't process it again. */
-	if (ghes_estatus_cached(estatus))
-		goto no_work;
-
-	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
-
-	return rc;
-
-no_work:
-	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
-		      node_len);
-
-	return rc;
-}
-
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1406,7 +297,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, rcu_list, list) {
-		if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx))
+		if (!estatus_in_nmi_queue_one_entry(&ghes->estatus_src, fixmap_idx))
 			ret = 0;
 	}
 	rcu_read_unlock();
@@ -1510,13 +401,13 @@ static inline void ghes_nmi_remove(struct ghes *ghes) { }
 
 static void ghes_nmi_init_cxt(void)
 {
-	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
+	init_irq_work(&ghes_proc_irq_work, estatus_proc_in_irq);
 }
 
 static int __ghes_sdei_callback(struct ghes *ghes,
 				enum fixed_addresses fixmap_idx)
 {
-	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+	if (!estatus_in_nmi_queue_one_entry(&ghes->estatus_src, fixmap_idx)) {
 		irq_work_queue(&ghes_proc_irq_work);
 
 		return 0;
@@ -1693,7 +584,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	ghes_proc(ghes);
+	estatus_proc(&ghes->estatus_src);
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return 0;
@@ -1846,13 +737,13 @@ EXPORT_SYMBOL_GPL(ghes_get_devices);
 
 void ghes_register_report_chain(struct notifier_block *nb)
 {
-	atomic_notifier_chain_register(&ghes_report_chain, nb);
+	estatus_register_report_chain(nb);
 }
 EXPORT_SYMBOL_GPL(ghes_register_report_chain);
 
 void ghes_unregister_report_chain(struct notifier_block *nb)
 {
-	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
+	estatus_unregister_report_chain(nb);
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
 
diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
index 259122730303..2080abef673d 100644
--- a/drivers/firmware/efi/estatus.c
+++ b/drivers/firmware/efi/estatus.c
@@ -16,23 +16,26 @@
 #include <linux/pfn.h>
 #include <linux/aer.h>
 #include <linux/nmi.h>
+#include <linux/mm.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/signal.h>
+#include <linux/spinlock.h>
 #include <linux/uuid.h>
 #include <linux/kconfig.h>
 #include <linux/ras.h>
 #include <linux/mutex.h>
+#include <linux/kfifo.h>
 #include <linux/notifier.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
 #include <ras/ras_event.h>
+#include <cxl/event.h>
 
 #include <linux/estatus.h>
 #include <asm/fixmap.h>
 
 void estatus_pool_region_free(unsigned long addr, u32 size);
 
-/* Emit a printk at the exact level encoded in the HW_ERR tag we build. */
 static void estatus_log_hw_error(char level, const char *seq_tag,
 				 const char *name)
 {
@@ -64,7 +67,7 @@ static void estatus_log_hw_error(char level, const char *seq_tag,
 	}
 }
 
-static inline u32 estatus_len(struct acpi_hest_generic_status *estatus)
+static inline u32 estatus_len(estatus_generic_status *estatus)
 {
 	if (estatus->raw_data_length)
 		return estatus->raw_data_offset + estatus->raw_data_length;
@@ -90,19 +93,19 @@ static inline u32 estatus_len(struct acpi_hest_generic_status *estatus)
 #define ESTATUS_CACHE_LEN(estatus_len)			\
 	(sizeof(struct estatus_cache) + (estatus_len))
 #define ESTATUS_FROM_CACHE(cache)			\
-	((struct acpi_hest_generic_status *)		\
+	((estatus_generic_status *)		\
 	 ((struct estatus_cache *)(cache) + 1))
 
 #define ESTATUS_NODE_LEN(estatus_len)			\
 	(sizeof(struct estatus_node) + (estatus_len))
 #define ESTATUS_FROM_NODE(node)				\
-	((struct acpi_hest_generic_status *)		\
+	((estatus_generic_status *)		\
 	 ((struct estatus_node *)(node) + 1))
 
 #define ESTATUS_VENDOR_ENTRY_LEN(gdata_len)		\
 	(sizeof(struct estatus_vendor_record_entry) + (gdata_len))
 #define ESTATUS_GDATA_FROM_VENDOR_ENTRY(vendor_entry)	\
-	((struct acpi_hest_generic_data *)		\
+	((estatus_generic_data *)		\
 	((struct estatus_vendor_record_entry *)(vendor_entry) + 1))
 
 static ATOMIC_NOTIFIER_HEAD(estatus_report_chain);
@@ -249,7 +252,7 @@ EXPORT_SYMBOL_GPL(estatus_pool_region_free);
 
 /* Check the top-level record header has an appropriate size. */
 static int __estatus_check_estatus(struct estatus_source *source,
-				   struct acpi_hest_generic_status *estatus)
+				   estatus_generic_status *estatus)
 {
 	u32 len = estatus_len(estatus);
 	size_t max_len = estatus_source_max_len(source);
@@ -274,7 +277,7 @@ static int __estatus_check_estatus(struct estatus_source *source,
 
 /* Read the CPER block, returning its address, and header in estatus. */
 static int __estatus_peek_estatus(struct estatus_source *source,
-				  struct acpi_hest_generic_status *estatus,
+				  estatus_generic_status *estatus,
 				  phys_addr_t *buf_paddr,
 				  enum fixed_addresses fixmap_idx)
 {
@@ -306,7 +309,7 @@ static int __estatus_peek_estatus(struct estatus_source *source,
 }
 
 static int __estatus_read_estatus(struct estatus_source *source,
-				  struct acpi_hest_generic_status *estatus,
+				  estatus_generic_status *estatus,
 				  phys_addr_t buf_paddr,
 				  enum fixed_addresses fixmap_idx,
 				  size_t buf_len)
@@ -329,7 +332,7 @@ static int __estatus_read_estatus(struct estatus_source *source,
 }
 
 static int estatus_read_estatus(struct estatus_source *source,
-				struct acpi_hest_generic_status *estatus,
+				estatus_generic_status *estatus,
 				phys_addr_t *buf_paddr,
 				enum fixed_addresses fixmap_idx)
 {
@@ -348,7 +351,7 @@ static int estatus_read_estatus(struct estatus_source *source,
 }
 
 static void estatus_clear_estatus(struct estatus_source *source,
-				  struct acpi_hest_generic_status *estatus,
+				  estatus_generic_status *estatus,
 				  phys_addr_t buf_paddr,
 				  enum fixed_addresses fixmap_idx)
 {
@@ -388,7 +391,7 @@ static inline int estatus_severity(int severity)
 
 static void __estatus_print_estatus(const char *pfx,
 				    struct estatus_source *source,
-				    const struct acpi_hest_generic_status *estatus)
+				    const estatus_generic_status *estatus)
 {
 	static atomic_t seqno;
 	unsigned int curr_seqno;
@@ -420,7 +423,7 @@ static void __estatus_print_estatus(const char *pfx,
 
 static int estatus_print_estatus(const char *pfx,
 				 struct estatus_source *source,
-				 const struct acpi_hest_generic_status *estatus)
+				 const estatus_generic_status *estatus)
 {
 	/* Not more than 2 messages every 5 seconds */
 	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5 * HZ, 2);
@@ -442,13 +445,13 @@ static int estatus_print_estatus(const char *pfx,
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
  */
-static int estatus_cached(struct acpi_hest_generic_status *estatus)
+static int estatus_cached(estatus_generic_status *estatus)
 {
 	u32 len;
 	int i, cached = 0;
 	unsigned long long now;
 	struct estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
+	estatus_generic_status *cache_estatus;
 
 	len = estatus_len(estatus);
 	rcu_read_lock();
@@ -472,12 +475,12 @@ static int estatus_cached(struct acpi_hest_generic_status *estatus)
 }
 
 static struct estatus_cache *estatus_cache_alloc(struct estatus_source *source,
-						 struct acpi_hest_generic_status *estatus)
+						 estatus_generic_status *estatus)
 {
 	int alloced;
 	u32 len, cache_len;
 	struct estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
+	estatus_generic_status *cache_estatus;
 
 	alloced = atomic_add_return(1, &estatus_cache_alloced);
 	if (alloced > ESTATUS_CACHE_ALLOCED_MAX) {
@@ -513,7 +516,7 @@ static void estatus_cache_rcu_free(struct rcu_head *head)
 }
 
 static void estatus_cache_add(struct estatus_source *source,
-			      struct acpi_hest_generic_status *estatus)
+			      estatus_generic_status *estatus)
 {
 	unsigned long long now, duration, period, max_period = 0;
 	struct estatus_cache *cache, *new_cache;
@@ -704,7 +707,7 @@ static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bo
  * ESTATUS_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void estatus_handle_aer(struct acpi_hest_generic_data *gdata)
+static void estatus_handle_aer(estatus_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = estatus_get_payload(gdata);
@@ -759,7 +762,7 @@ EXPORT_SYMBOL_GPL(estatus_unregister_vendor_record_notifier);
 static void estatus_vendor_record_work_func(struct work_struct *work)
 {
 	struct estatus_vendor_record_entry *entry;
-	struct acpi_hest_generic_data *gdata;
+	estatus_generic_data *gdata;
 	u32 len;
 
 	entry = container_of(work, struct estatus_vendor_record_entry, work);
@@ -774,7 +777,7 @@ static void estatus_vendor_record_work_func(struct work_struct *work)
 
 static void estatus_defer_non_standard_event(estatus_generic_data *gdata, int sev)
 {
-	struct acpi_hest_generic_data *copied_gdata;
+	estatus_generic_data *copied_gdata;
 	struct estatus_vendor_record_entry *entry;
 	u32 len;
 
@@ -806,7 +809,7 @@ static inline bool estatus_is_sync_notify(struct estatus_source *source)
 static void estatus_do_proc(struct estatus_source *source, const estatus_generic_status *estatus)
 {
 	int sev, sec_sev;
-	struct acpi_hest_generic_data *gdata;
+	estatus_generic_data *gdata;
 	guid_t *sec_type;
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
@@ -871,7 +874,7 @@ static void __estatus_panic(struct estatus_source *source, estatus_generic_statu
 
 int estatus_proc(struct estatus_source *source)
 {
-	struct acpi_hest_generic_status *estatus = source->estatus;
+	estatus_generic_status *estatus = source->estatus;
 	phys_addr_t buf_paddr;
 	enum fixed_addresses fixmap_idx = estatus_source_fixmap(source);
 	int rc;
@@ -913,7 +916,7 @@ void estatus_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
 	struct estatus_node *estatus_node;
-	struct acpi_hest_generic_status *source;
+	struct estatus_source *source;
 	estatus_generic_status *estatus;
 	u32 len, node_len;
 
@@ -927,7 +930,7 @@ void estatus_proc_in_irq(struct irq_work *irq_work)
 		next = llnode->next;
 		estatus_node = llist_entry(llnode, struct estatus_node,
 					   llnode);
-		struct estatus_source *source = estatus_node->source;
+		source = estatus_node->source;
 		estatus = ESTATUS_FROM_NODE(estatus_node);
 		len = estatus_len(estatus);
 		node_len = ESTATUS_NODE_LEN(len);
@@ -949,7 +952,7 @@ static void estatus_print_queued_estatus(void)
 	struct llist_node *llnode;
 	struct estatus_node *estatus_node;
 	struct estatus_source *source;
-	struct acpi_hest_generic_status *estatus;
+	estatus_generic_status *estatus;
 
 	llnode = llist_del_all(&estatus_llist);
 	/*
@@ -976,7 +979,7 @@ void estatus_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 int estatus_in_nmi_queue_one_entry(struct estatus_source *source, enum fixed_addresses fixmap_idx)
 {
-	struct acpi_hest_generic_status *estatus, tmp_header;
+	estatus_generic_status *estatus, tmp_header;
 	struct estatus_node *estatus_node;
 	u32 len, node_len;
 	phys_addr_t buf_paddr;
-- 
2.43.0


