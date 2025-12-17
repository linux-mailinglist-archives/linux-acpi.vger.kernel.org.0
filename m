Return-Path: <linux-acpi+bounces-19617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67EECC7578
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D2830440F0
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9935293C;
	Wed, 17 Dec 2025 11:30:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E64350D61;
	Wed, 17 Dec 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971009; cv=none; b=eCOHBKUSrCFyBJFNYSU0aIZEN2eEP0PWVtts97hp6VeYILS9PAAbaqjb8tf3Z0vlbR1+exDpqt23hka+7nIs0sQ2X8+8oF5Yod/uq71XY3SrE2CTY0kLoYAiUvvKFle2uAPJ+ZoeRESePjhp/Mvjg8q3JOgKB+4LYLr8R7YStyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971009; c=relaxed/simple;
	bh=gITIBRpPiEtbePwwBSTKwprEbZSzEixCYoK28vfg3xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNuAJCkmvL3W+OuY0NQFXZaXyIPqWrdnzMOha3z1CR7Q4I0ISQ7Uz9ALxwE08mD2E2HTZDdEMC70SHq7AUOsAwIX8Bba3jiS+Dsmvm3mHuS+V53wMB+JHbiqNzK4HSIoKta6kof3081u18xNumSMUDD1w5mh+ByjEqo99mzPGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529A71516;
	Wed, 17 Dec 2025 03:30:00 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971CD3F73B;
	Wed, 17 Dec 2025 03:30:05 -0800 (PST)
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
Subject: [PATCH 05/12] ras: flesh out estatus processing core
Date: Wed, 17 Dec 2025 11:28:38 +0000
Message-ID: <20251217112845.1814119-6-ahmed.tiba@arm.com>
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

Complete the estatus core by adding the cache throttling logic, vendor
record notifier plumbing, IRQ/NMI queue handling and the processing
paths that walk CPER records. Landing the full implementation ahead of
the GHES conversion keeps the follow-on patches focused on their call
sites while leaving behaviour unchanged for existing users.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/firmware/efi/estatus.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
index 8b62b23e2e93..8043d68f907b 100644
--- a/drivers/firmware/efi/estatus.c
+++ b/drivers/firmware/efi/estatus.c
@@ -32,6 +32,7 @@
 
 void estatus_pool_region_free(unsigned long addr, u32 size);
 
+/* Emit a printk at the exact level encoded in the HW_ERR tag we build. */
 static void estatus_log_hw_error(char level, const char *seq_tag,
 				 const char *name)
 {
@@ -704,7 +705,7 @@ static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bo
  * ESTATUS_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void estatus_handle_aer(estatus_generic_data *gdata)
+static void estatus_handle_aer(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = estatus_get_payload(gdata);
@@ -759,7 +760,7 @@ EXPORT_SYMBOL_GPL(estatus_unregister_vendor_record_notifier);
 static void estatus_vendor_record_work_func(struct work_struct *work)
 {
 	struct estatus_vendor_record_entry *entry;
-	estatus_generic_data *gdata;
+	struct acpi_hest_generic_data *gdata;
 	u32 len;
 
 	entry = container_of(work, struct estatus_vendor_record_entry, work);
@@ -774,7 +775,7 @@ static void estatus_vendor_record_work_func(struct work_struct *work)
 
 static void estatus_defer_non_standard_event(estatus_generic_data *gdata, int sev)
 {
-	estatus_generic_data *copied_gdata;
+	struct acpi_hest_generic_data *copied_gdata;
 	struct estatus_vendor_record_entry *entry;
 	u32 len;
 
@@ -806,7 +807,7 @@ static inline bool estatus_is_sync_notify(struct estatus_source *source)
 static void estatus_do_proc(struct estatus_source *source, const estatus_generic_status *estatus)
 {
 	int sev, sec_sev;
-	estatus_generic_data *gdata;
+	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
@@ -871,7 +872,7 @@ static void __estatus_panic(struct estatus_source *source, estatus_generic_statu
 
 int estatus_proc(struct estatus_source *source)
 {
-	estatus_generic_status *estatus = source->estatus;
+	struct acpi_hest_generic_status *estatus = source->estatus;
 	phys_addr_t buf_paddr;
 	enum fixed_addresses fixmap_idx = estatus_source_fixmap(source);
 	int rc;
@@ -913,7 +914,7 @@ void estatus_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
 	struct estatus_node *estatus_node;
-	struct estatus_source *source;
+	struct acpi_hest_generic_status *source;
 	estatus_generic_status *estatus;
 	u32 len, node_len;
 
@@ -927,7 +928,7 @@ void estatus_proc_in_irq(struct irq_work *irq_work)
 		next = llnode->next;
 		estatus_node = llist_entry(llnode, struct estatus_node,
 					   llnode);
-		source = estatus_node->source;
+		struct estatus_source *source = estatus_node->source;
 		estatus = ESTATUS_FROM_NODE(estatus_node);
 		len = estatus_len(estatus);
 		node_len = ESTATUS_NODE_LEN(len);
@@ -949,7 +950,7 @@ static void estatus_print_queued_estatus(void)
 	struct llist_node *llnode;
 	struct estatus_node *estatus_node;
 	struct estatus_source *source;
-	estatus_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 
 	llnode = llist_del_all(&estatus_llist);
 	/*
@@ -976,7 +977,7 @@ void estatus_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 int estatus_in_nmi_queue_one_entry(struct estatus_source *source, enum fixed_addresses fixmap_idx)
 {
-	estatus_generic_status *estatus, tmp_header;
+	struct acpi_hest_generic_status *estatus, tmp_header;
 	struct estatus_node *estatus_node;
 	u32 len, node_len;
 	phys_addr_t buf_paddr;
-- 
2.43.0


