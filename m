Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072E81C1AC4
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgEAQqH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 12:46:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgEAQqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 12:46:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BF1101E;
        Fri,  1 May 2020 09:46:06 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B58813F305;
        Fri,  1 May 2020 09:46:04 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 3/3] arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
Date:   Fri,  1 May 2020 17:45:43 +0100
Message-Id: <20200501164543.24423-4-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200501164543.24423-1-james.morse@arm.com>
References: <20200501164543.24423-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

APEI is unable to do all of its error handling work in nmi-context, so
it defers non-fatal work onto the irq_work queue. arch_irq_work_raise()
sends an IPI to the calling cpu, but this is not guaranteed to be taken
before returning to user-space.

Unless the exception interrupted a context with irqs-masked,
irq_work_run() can run immediately. Otherwise return -EINPROGRESS to
indicate ghes_notify_sea() found some work to do, but it hasn't
finished yet.

With this apei_claim_sea() returning '0' means this external-abort was
also notification of a firmware-first RAS error, and that APEI has
processed the CPER records.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Tyler Baicar <baicar@os.amperecomputing.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/acpi.c | 25 +++++++++++++++++++++++++
 arch/arm64/mm/fault.c    | 12 +++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a100483b47c4..46ec402e97ed 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irq_work.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
@@ -269,6 +270,7 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 int apei_claim_sea(struct pt_regs *regs)
 {
 	int err = -ENOENT;
+	bool return_to_irqs_enabled;
 	unsigned long current_flags;
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
@@ -276,6 +278,12 @@ int apei_claim_sea(struct pt_regs *regs)
 
 	current_flags = local_daif_save_flags();
 
+	/* current_flags isn't useful here as daif doesn't tell us about pNMI */
+	return_to_irqs_enabled = !irqs_disabled_flags(arch_local_save_flags());
+
+	if (regs)
+		return_to_irqs_enabled = interrupts_enabled(regs);
+
 	/*
 	 * SEA can interrupt SError, mask it and describe this as an NMI so
 	 * that APEI defers the handling.
@@ -284,6 +292,23 @@ int apei_claim_sea(struct pt_regs *regs)
 	nmi_enter();
 	err = ghes_notify_sea();
 	nmi_exit();
+
+	/*
+	 * APEI NMI-like notifications are deferred to irq_work. Unless
+	 * we interrupted irqs-masked code, we can do that now.
+	 */
+	if (!err) {
+		if (return_to_irqs_enabled) {
+			local_daif_restore(DAIF_PROCCTX_NOIRQ);
+			__irq_enter();
+			irq_work_run();
+			__irq_exit();
+		} else {
+			pr_warn_ratelimited("APEI work queued but not completed");
+			err = -EINPROGRESS;
+		}
+	}
+
 	local_daif_restore(current_flags);
 
 	return err;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c9cedc0432d2..dff2d72b0883 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -635,11 +635,13 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 	inf = esr_to_fault_info(esr);
 
-	/*
-	 * Return value ignored as we rely on signal merging.
-	 * Future patches will make this more robust.
-	 */
-	apei_claim_sea(regs);
+	if (user_mode(regs) && apei_claim_sea(regs) == 0) {
+		/*
+		 * APEI claimed this as a firmware-first notification.
+		 * Some processing deferred to task_work before ret_to_user().
+		 */
+		return 0;
+	}
 
 	if (esr & ESR_ELx_FnV)
 		siaddr = NULL;
-- 
2.26.1

