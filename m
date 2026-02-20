Return-Path: <linux-acpi+bounces-21022-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLcEDWhlmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21022-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D5167F77
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF16F3011C68
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F621346E7D;
	Fri, 20 Feb 2026 13:43:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66713346FAD;
	Fri, 20 Feb 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594980; cv=none; b=jimHmSvJTOK86T/j7XGh9S+nyYyGy48F5Wu0/i9IqDrz8R2RoVwIbo61es2s1jAAVZTug/XXD58D3Fz1wsqoQXQVW6j5IpJVQ8v2girC52QqNGlTsofpRGIMCKMOM6C+I2Y6rNaWpG+DLV3ECzlLakBMbeKiQt2YBY1Dg4dWDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594980; c=relaxed/simple;
	bh=6MXXZ6wmXAKZk8i/1Uea9W8rzv5tLgSFVWTm23NDwjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZvKYAuUpegkE6G/Uz1TOmqAGkA1q5SgUaenyEcadNBtKJeTFgS9Smve6R1NhtqHPZrcJ56xBS3C/0tmFnkCveKcA1Y0GQWspLBEDE+FNdA21PkrScB1GTYfHQmUxaa200WM2HYiLtp+kPRYBr1lhdgmG/1l+P5uFQpcrJka/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9176C1650;
	Fri, 20 Feb 2026 05:42:51 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CAB3F7D8;
	Fri, 20 Feb 2026 05:42:56 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:21 +0000
Subject: [PATCH v2 03/11] ACPI: APEI: GHES: move CPER read helpers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=12872;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=6MXXZ6wmXAKZk8i/1Uea9W8rzv5tLgSFVWTm23NDwjI=;
 b=5oSDEm4DLpm0+W/sKGzY/QQHiEFaCNcWNZ+3nJdk5t1XwlDVGutG8MDA1zJs8pWeOtd4pH4C8
 AdU2Jm56nBQCsex7TEHORS24fL4nVMfqfka84iSwYHpXNzpNH+9yJPH
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21022-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.928];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A5D5167F77
X-Rspamd-Action: no action

Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
ghes_cper.c so they can be shared with other firmware-first providers.
This commit only shuffles code; behavior stays the same.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 170 +-----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 170 +++++++++++++++++++++++++++++++++++++++++-
 include/acpi/ghes_cper.h      |  14 ++--
 3 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07b70bcb8342..b159dbee90ac 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -118,26 +118,6 @@ static struct gen_pool *ghes_estatus_pool;
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
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
 	unsigned long addr, len;
@@ -193,22 +173,7 @@ static void unmap_gen_v2(struct ghes *ghes)
 	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
 }
 
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
-static struct ghes *ghes_new(struct acpi_hest_generic *generic)
+struct ghes *ghes_new(struct acpi_hest_generic *generic)
 {
 	struct ghes *ghes;
 	unsigned int error_block_length;
@@ -255,7 +220,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 	return ERR_PTR(rc);
 }
 
-static void ghes_fini(struct ghes *ghes)
+void ghes_fini(struct ghes *ghes)
 {
 	kfree(ghes->estatus);
 	apei_unmap_generic_address(&ghes->generic->error_status_address);
@@ -280,137 +245,6 @@ static inline int ghes_severity(int severity)
 	}
 }
 
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
-	u32 max_len = min(ghes->generic->error_block_length,
-			  ghes->estatus_length);
-
-	if (len < sizeof(*estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
-		return -EIO;
-	}
-
-	if (!len || len > max_len) {
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
 
 /**
  * struct ghes_task_work - for synchronous RAS event
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 63047322a3d9..7e0015e960c1 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *
- * APEI GHES CPER helper translation unit - staging file for helper moves
+ * APEI GHES CPER helper translation unit - code mechanically moved from ghes.c
  *
  * Copyright (C) 2026 ARM Ltd.
  * Author: Ahmed Tiba <ahmed.tiba@arm.com>
@@ -17,10 +17,176 @@
 #include <linux/slab.h>
 
 #include <acpi/apei.h>
+#include <acpi/ghes_cper.h>
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
 #include "apei-internal.h"
 
-/* Helper bodies will be moved here in follow-up commits. */
+static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
+{
+	phys_addr_t paddr;
+	pgprot_t prot;
+
+	paddr = PFN_PHYS(pfn);
+	prot = arch_apei_get_mem_attribute(paddr);
+	__set_fixmap(fixmap_idx, paddr, prot);
+
+	return (void __iomem *) __fix_to_virt(fixmap_idx);
+}
+
+static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
+{
+	int _idx = virt_to_fix((unsigned long)vaddr);
+
+	WARN_ON_ONCE(fixmap_idx != _idx);
+	clear_fixmap(fixmap_idx);
+}
+
+static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
+{
+	int rc;
+	u64 val = 0;
+
+	rc = apei_read(&val, &gv2->read_ack_register);
+	if (rc)
+		return;
+
+	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
+	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
+
+	apei_write(val, &gv2->read_ack_register);
+}
+
+static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
+				  int from_phys,
+				  enum fixed_addresses fixmap_idx)
+{
+	void __iomem *vaddr;
+	u64 offset;
+	u32 trunk;
+
+	while (len > 0) {
+		offset = paddr - (paddr & PAGE_MASK);
+		vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
+		trunk = PAGE_SIZE - offset;
+		trunk = min(trunk, len);
+		if (from_phys)
+			memcpy_fromio(buffer, vaddr + offset, trunk);
+		else
+			memcpy_toio(vaddr + offset, buffer, trunk);
+		len -= trunk;
+		paddr += trunk;
+		buffer += trunk;
+		ghes_unmap(vaddr, fixmap_idx);
+	}
+}
+
+/* Check the top-level record header has an appropriate size. */
+int __ghes_check_estatus(struct ghes *ghes,
+				struct acpi_hest_generic_status *estatus)
+{
+	u32 len = cper_estatus_len(estatus);
+	u32 max_len = min(ghes->generic->error_block_length,
+			  ghes->estatus_length);
+
+	if (len < sizeof(*estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
+		return -EIO;
+	}
+
+	if (!len || len > max_len) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
+		return -EIO;
+	}
+
+	if (cper_estatus_check_header(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Read the CPER block, returning its address, and header in estatus. */
+int __ghes_peek_estatus(struct ghes *ghes,
+			       struct acpi_hest_generic_status *estatus,
+			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	struct acpi_hest_generic *g = ghes->generic;
+	int rc;
+
+	rc = apei_read(buf_paddr, &g->error_status_address);
+	if (rc) {
+		*buf_paddr = 0;
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+"Failed to read error status block address for hardware error source: %d.\n",
+				   g->header.source_id);
+		return -EIO;
+	}
+	if (!*buf_paddr)
+		return -ENOENT;
+
+	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
+			      fixmap_idx);
+	if (!estatus->block_status) {
+		*buf_paddr = 0;
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			       u64 buf_paddr, enum fixed_addresses fixmap_idx,
+			       size_t buf_len)
+{
+	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
+	if (cper_estatus_check(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Failed to read error status block!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int ghes_read_estatus(struct ghes *ghes,
+			     struct acpi_hest_generic_status *estatus,
+			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	int rc;
+
+	rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+	if (rc)
+		return rc;
+
+	rc = __ghes_check_estatus(ghes, estatus);
+	if (rc)
+		return rc;
+
+	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
+				   cper_estatus_len(estatus));
+}
+
+void ghes_clear_estatus(struct ghes *ghes,
+			       struct acpi_hest_generic_status *estatus,
+			       u64 buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	estatus->block_status = 0;
+
+	if (!buf_paddr)
+		return;
+
+	ghes_copy_tofrom_phys(estatus, buf_paddr,
+			      sizeof(estatus->block_status), 0,
+			      fixmap_idx);
+
+	/*
+	 * GHESv2 type HEST entries introduce support for error acknowledgment,
+	 * so only acknowledge the error if this support is present.
+	 */
+	if (is_hest_type_generic_v2(ghes))
+		ghes_ack_error(ghes->generic_v2);
+}
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 2597fbadc4f3..2e3919f0c3e7 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -74,21 +74,21 @@ struct ghes_vendor_record_entry {
 	char vendor_record[];
 };
 
-static struct ghes *ghes_new(struct acpi_hest_generic *generic);
-static void ghes_fini(struct ghes *ghes);
+struct ghes *ghes_new(struct acpi_hest_generic *generic);
+void ghes_fini(struct ghes *ghes);
 
-static int ghes_read_estatus(struct ghes *ghes,
+int ghes_read_estatus(struct ghes *ghes,
 		      struct acpi_hest_generic_status *estatus,
 		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
-static void ghes_clear_estatus(struct ghes *ghes,
+void ghes_clear_estatus(struct ghes *ghes,
 			struct acpi_hest_generic_status *estatus,
 			u64 buf_paddr, enum fixed_addresses fixmap_idx);
-static int __ghes_peek_estatus(struct ghes *ghes,
+int __ghes_peek_estatus(struct ghes *ghes,
 			struct acpi_hest_generic_status *estatus,
 			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
-static int __ghes_check_estatus(struct ghes *ghes,
+int __ghes_check_estatus(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus);
-static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 			u64 buf_paddr, enum fixed_addresses fixmap_idx,
 			size_t buf_len);
 

-- 
2.43.0


