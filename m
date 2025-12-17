Return-Path: <linux-acpi+bounces-19616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7ECC755D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BA23009FE7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A0350A31;
	Wed, 17 Dec 2025 11:29:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809F350A28;
	Wed, 17 Dec 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970993; cv=none; b=H7y7UcoqDIaCYOs/s7xVaPSD7OSwlMvISKXnhLusBrPzQZhq5Mr9D/rlhiwpWFS9jXLNh5g8zEu5LIly1lJogyqacAoKhtnXMLsjoRy9ZpVUjSd7jnac01EVnWraIobslZieoAief9WnzF+tiRLrwV44S0sDm8Y73KKXoR8PVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970993; c=relaxed/simple;
	bh=4dJow6oM0o/c2WNql+5NWkbYQLnVpx+lhpuMOSpZUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX/aydgaPkK2CDV3XxAX9w7jDbBOto2Yh626xX1cHQxWoxC7ITb8KceSBh/9ZKjL+/ZTxJy06acpnOGMYpl4Pw5edzKDMcbPH0XRkPeeGaeebXEOYsW8B1JGZMmrr14LgdggSGYd4Zt7C5b7Z8qvX8rLJVxWhjmQpNnflEvMou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE87914BF;
	Wed, 17 Dec 2025 03:29:43 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 063213F73B;
	Wed, 17 Dec 2025 03:29:48 -0800 (PST)
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
Subject: [PATCH 04/12] ras: add estatus queuing and IRQ/NMI handling
Date: Wed, 17 Dec 2025 11:28:37 +0000
Message-ID: <20251217112845.1814119-5-ahmed.tiba@arm.com>
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

Hook the estatus core into the IRQ-work and NMI-safe queues that used to
live in GHES. The new code records CPER payloads into a per-source node,
ships them via irq_work so heavy processing happens out of the NMI path,
and adds the task_work hook used by memory-failure. Behaviour remains the
same as before, but the logic now lives alongside the rest of the estatus
infrastructure so both GHES and DeviceTree providers can reuse it.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/firmware/efi/estatus.c | 78 ++++++++++++++++++++++++++++++++++
 include/linux/estatus.h        |  3 +-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
index 5a848d1b218e..8b62b23e2e93 100644
--- a/drivers/firmware/efi/estatus.c
+++ b/drivers/firmware/efi/estatus.c
@@ -973,3 +973,81 @@ void estatus_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	arch_apei_report_mem_error(sev, mem_err);
 #endif
 }
+
+int estatus_in_nmi_queue_one_entry(struct estatus_source *source, enum fixed_addresses fixmap_idx)
+{
+	estatus_generic_status *estatus, tmp_header;
+	struct estatus_node *estatus_node;
+	u32 len, node_len;
+	phys_addr_t buf_paddr;
+	int sev, rc;
+
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG))
+		return -EOPNOTSUPP;
+
+	rc = __estatus_peek_estatus(source, &tmp_header, &buf_paddr,
+				    fixmap_idx);
+	if (rc) {
+		estatus_clear_estatus(source, &tmp_header, buf_paddr,
+				      fixmap_idx);
+		return rc;
+	}
+
+	rc = __estatus_check_estatus(source, &tmp_header);
+	if (rc) {
+		estatus_clear_estatus(source, &tmp_header, buf_paddr,
+				      fixmap_idx);
+		return rc;
+	}
+
+	len = estatus_len(&tmp_header);
+	node_len = ESTATUS_NODE_LEN(len);
+	estatus_node = (void *)gen_pool_alloc(estatus_pool, node_len);
+	if (!estatus_node)
+		return -ENOMEM;
+
+	estatus_node->source = source;
+	estatus = ESTATUS_FROM_NODE(estatus_node);
+
+	if (__estatus_read_estatus(source, estatus, buf_paddr, fixmap_idx,
+				   len)) {
+		estatus_clear_estatus(source, estatus, buf_paddr, fixmap_idx);
+		rc = -ENOENT;
+		goto no_work;
+	}
+
+	sev = estatus_severity(estatus->error_severity);
+	if (sev >= ESTATUS_SEV_PANIC) {
+		estatus_print_queued_estatus();
+		__estatus_panic(source, estatus, buf_paddr, fixmap_idx);
+	}
+
+	estatus_clear_estatus(source, &tmp_header, buf_paddr, fixmap_idx);
+
+	/* This error has been reported before, don't process it again. */
+	if (estatus_cached(estatus))
+		goto no_work;
+
+	llist_add(&estatus_node->llnode, &estatus_llist);
+
+	return rc;
+
+no_work:
+	gen_pool_free(estatus_pool, (unsigned long)estatus_node,
+		      node_len);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(estatus_in_nmi_queue_one_entry);
+
+void estatus_register_report_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&estatus_report_chain, nb);
+}
+EXPORT_SYMBOL_GPL(estatus_register_report_chain);
+
+void estatus_unregister_report_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&estatus_report_chain, nb);
+}
+EXPORT_SYMBOL_GPL(estatus_unregister_report_chain);
diff --git a/include/linux/estatus.h b/include/linux/estatus.h
index 002a9533c85a..506a74ad60b9 100644
--- a/include/linux/estatus.h
+++ b/include/linux/estatus.h
@@ -122,8 +122,7 @@ enum {
 };
 
 int estatus_proc(struct estatus_source *ghes);
-int estatus_in_nmi_queue_one_entry(struct estatus_source *ghes,
-				   enum fixed_addresses fixmap_idx);
+int estatus_in_nmi_queue_one_entry(struct estatus_source *ghes, enum fixed_addresses fixmap_idx);
 void estatus_proc_in_irq(struct irq_work *irq_work);
 
 /**
-- 
2.43.0


