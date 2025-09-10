Return-Path: <linux-acpi+bounces-16563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E3B5129B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2A7B687F
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189EF313E06;
	Wed, 10 Sep 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ty2WBiMU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924733112BE;
	Wed, 10 Sep 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496859; cv=none; b=ovJ4BORRhrBH7zR6D5VMnBuxY5JlM4M2v+cRvArNp5MmMCTrigkmbI7+Xih8Qg5c2F7EffNoi/cVf82iFC7c+h08Us69VqB3TPAQ23HgGmHMbaudVVyLnHvsTA778+uLLWYZ7jc/lGpk4SX02qwvvN84BphhkMkHjjfprubwpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496859; c=relaxed/simple;
	bh=hV+FclEdVykCpBoJLA3hiIs8bAVEMpfOi1QesqODR1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAqFc2MCdrffzFE++5ZXKOO1JZ/AY7+KMv1m9j+WpoHijHj+39TVWi5zkjG91J9ldyklsiScEbwxAe5WXXfifct+/8O+3hYMxlbsVxq6NIFk00z93YWdUxDYObaLGiQLN0cqtQQM3urF0TmoqL6PzL4f9gk6uAzWQ5NnWVy6gdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ty2WBiMU; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496853; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CxOpiotR3/TBBHbw/zXSnCu06zXOVHPuSixUgLaNya4=;
	b=ty2WBiMULegD1S7qvJw/bXQZDV7HJ/q64rOCmdSA6jY6ahB3d51uYvMv2mIMvhHrd+FPnqHAqVdxBnMXjvj8NZawQS9QcC6B0P3Z+FVUtmkpj7pk4u9D1uz4Fm0fWWZRVb7DseDGEz11/l6i3XWTsK44q1Gbne7Z05o8AIbffpg=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wnhbz2M_1757496849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:34:12 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: xueshuai@linux.alibaba.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: james.morse@arm.com,
	tony.luck@intel.com,
	cleger@rivosinc.com,
	hchauhan@ventanamicro.com,
	tianruidong@linux.alibaba.com
Subject: [RFC PATCH 5/5] riscv: Add Hardware Error Exception trap handler
Date: Wed, 10 Sep 2025 17:33:47 +0800
Message-Id: <20250910093347.75822-6-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
References: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the Hardware Error Exception trap handler for RISC-V architecture
synchronous hardware error handling. This enables the OS to receive
hardware error notifications from firmware through the standardized ACPI
HEST (Hardware Error Source Table) interface.

The implementation includes:
- A new exception vector entry for Hardware Error Exceptio
- A trap handler (do_trap_hardware_error) that processes hardware errors
  in both kernel(panic now) and user modes(SIGBUS)
- Integration with APEI GHES (Generic Hardware Error Source) to report
  hardware errors from firmware

This change enables RISC-V systems with ACPI to handle synchronous
hardware errors in a firmware-first manner.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/riscv/include/asm/acpi.h |  2 ++
 arch/riscv/kernel/acpi.c      | 55 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/entry.S     |  4 +++
 arch/riscv/kernel/traps.c     | 19 ++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 0c599452ef48..ae861885b97d 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -91,6 +91,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+int apei_claim_hee(struct pt_regs *regs);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -108,6 +109,7 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 					   u32 *cbom_size, u32 *cboz_size,
 					   u32 *cbop_size) { }
 
+static inline int apei_claim_hee(struct pt_regs *regs) { return -ENOENT; }
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 3f6d5a6789e8..928f9474bfee 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -20,6 +20,11 @@
 #include <linux/of_fdt.h>
 #include <linux/pci.h>
 #include <linux/serial_core.h>
+#include <linux/efi.h>
+#include <linux/irq_work.h>
+#include <linux/nmi.h>
+#include <acpi/ghes.h>
+#include <asm/csr.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -334,3 +339,53 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 }
 
 #endif	/* CONFIG_PCI */
+
+/*
+ * Claim Hardware Error Exception as a firmware first notification.
+ *
+ * Used by RISC-V exception handler for hardware error processing.
+ * @regs may be NULL when called from process context.
+ */
+int apei_claim_hee(struct pt_regs *regs)
+{
+	int err = -ENOENT;
+	bool return_to_irqs_enabled;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
+		return err;
+
+	/* Save current interrupt state */
+	local_irq_save(flags);
+	return_to_irqs_enabled = !irqs_disabled();
+
+	if (regs)
+		return_to_irqs_enabled = (regs->status & SR_SIE) != 0;
+
+	/*
+	 * HEE can interrupt other operations, handle as NMI-like context
+	 * to ensure proper APEI processing
+	 */
+	nmi_enter();
+	err = ghes_notify_hee();
+	nmi_exit();
+
+	/*
+	 * APEI NMI-like notifications are deferred to irq_work. Unless
+	 * we interrupted irqs-masked code, we can do that now.
+	 */
+	if (!err) {
+		if (return_to_irqs_enabled) {
+			local_irq_restore(flags);
+			irq_work_run();
+		} else {
+			pr_warn_ratelimited("APEI work queued but not completed");
+			err = -EINPROGRESS;
+		}
+	} else {
+		local_irq_restore(flags);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(apei_claim_hee);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3a0ec6fd5956..1cbefe934d84 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -459,6 +459,10 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_trap_hardware_error /* Hardware Error */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 80230de167de..48f1ea1e03e6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/acpi.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -442,3 +443,21 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 		wait_for_interrupt();
 }
 #endif
+
+asmlinkage __visible __trap_section void do_trap_hardware_error(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		if (apei_claim_hee(regs))
+			do_trap_error(regs, SIGBUS, BUS_OBJERR, regs->badaddr, "Hardware Error");
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t state = irqentry_nmi_enter(regs);
+
+		die(regs, "Hardware Error");
+
+		irqentry_nmi_exit(regs, state);
+	}
+}
-- 
2.43.7


