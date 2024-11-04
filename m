Return-Path: <linux-acpi+bounces-9283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18F9BBF15
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6D3B22203
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBC1F708B;
	Mon,  4 Nov 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZQ2xIGr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A81F7087;
	Mon,  4 Nov 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753694; cv=none; b=r6kd4iPEDHdevcpjk3mT1CgXlny3Z2WIUC0s+LB2WI8mUvZDJqdKNS/4/L6Idl43MvUOVqBMxK+8GVdOChSCQynnlEITzV5QF4xhutL6Vrkrzf91Tm1t5HWm7+w5TBQkLyrq9O2R3WOx+ARSn/RpEmKh9NSDwIB8eWNbo5Y6NOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753694; c=relaxed/simple;
	bh=2yRz5nUe4da7Yl2yzaqL5hAUKq8X0c65ags71T6J4q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i30YUSi8F0hWO4bh0jbccE6ohYSMIEnRVUhtbWG0S+8xjME2/Hw4jDH27B/Sr/nV9OdrEuIB8jw3pPB2OsDyyksrLul1h39enjhbWkka8wYiVQV/QnU/GTrkK4kUDox93L0H59tDQ7TZHv/gQb0emvg9WZ7nKcsC6JJkok7p/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZQ2xIGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD48C4CECE;
	Mon,  4 Nov 2024 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730753693;
	bh=2yRz5nUe4da7Yl2yzaqL5hAUKq8X0c65ags71T6J4q4=;
	h=From:To:Cc:Subject:Date:From;
	b=CZQ2xIGrJggWdP15D2rvE7J1XtI8uJ98UN/Kf3b0D8bfvGxF5ufDJ3TX9D64Eeoz5
	 LgFAGtidKJuAkMNJsbObpTEKfuQYm5iZ3vQugKArXvhcXoBG18UzgG/B8SkOXd0fG6
	 ocYY4WvECV2V59PVYA4hzCWPkx8hOyvHgLbjuPPeBo/EJ/kCjpqfqIhCL6V6pm6pm+
	 k5GLiU2z+Bap5v8yKWAC9CxmI7Nisw50bF4SI0t7/Z4CJQIgtLI4pb5hRcbtAoyO8i
	 uM1rAavqM/7770nRD2d6vNDMyHU90tSQ/gyp/vNpuvIfUuzrG0V7YIcfZNVYJKBJT2
	 jqJcVCRl/g/0A==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	Ivan Shapovalov <intelfx@intelfx.name>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc() call later
Date: Mon,  4 Nov 2024 14:54:46 -0600
Message-ID: <20241104205446.3874509-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

arch_init_invariance_cppc() is called at the end of
acpi_cppc_processor_probe() in order to configure frequency invariance
based upon the values from _CPC.

This however doesn't work on AMD CPPC shared memory designs that have
AMD preferred cores enabled because _CPC needs to be analyzed from all
cores to judge if preferred cores are enabled.

This issue manifests to users as a warning since commit 21fb59ab4b97
("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"):
```
Could not retrieve highest performance (-19)
```

However the warning isn't the cause of this, it was actually
commit 279f838a61f9 ("x86/amd: Detect preferred cores in
amd_get_boost_ratio_numerator()") which exposed the issue.

To fix this problem, change arch_init_invariance_cppc() into a new weak
symbol that is called at the end of acpi_processor_driver_init().
Each architecture that supports it can declare the symbol to override
the weak one.

Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219431
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Weak symbol instead of macro to help riscv build failure
 * Update commit message
 * Add comment
---
 arch/arm64/include/asm/topology.h | 2 +-
 arch/x86/include/asm/topology.h   | 2 +-
 drivers/acpi/cppc_acpi.c          | 6 ------
 drivers/acpi/processor_driver.c   | 9 +++++++++
 include/acpi/processor.h          | 2 ++
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 5fc3af9f8f29b..8a1860877967e 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
 #define arch_scale_freq_ref topology_get_freq_ref
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
+#define acpi_processor_init_invariance_cppc topology_init_cpu_capacity_cppc
 #endif
 
 /* Replace task scheduler's default cpu-invariant accounting */
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d6247..0fb705524aeaa 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
-#define arch_init_invariance_cppc init_freq_invariance_cppc
+#define acpi_processor_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1a40f0514eaa3..5c0cc7aae8726 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
  *  )
  */
 
-#ifndef arch_init_invariance_cppc
-static inline void arch_init_invariance_cppc(void) { }
-#endif
-
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
@@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	arch_init_invariance_cppc();
-
 	kfree(output.pointer);
 	return 0;
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index cb52dd000b958..3b281bc1e73c3 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_notifier_block = {
 	.notifier_call = acpi_processor_notifier,
 };
 
+void __weak acpi_processor_init_invariance_cppc(void)
+{ }
+
 /*
  * We keep the driver loaded even when ACPI is not running.
  * This is needed for the powernow-k8 driver, that works even without
@@ -270,6 +273,12 @@ static int __init acpi_processor_driver_init(void)
 				  NULL, acpi_soft_cpu_dead);
 
 	acpi_processor_throttling_init();
+
+	/*
+	 * Frequency invariance calculations on AMD platforms can't be run until
+	 * after acpi_cppc_processor_probe() has been called for all online CPUs.
+	 */
+	acpi_processor_init_invariance_cppc();
 	return 0;
 err:
 	driver_unregister(&acpi_processor_driver);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index e6f6074eadbf3..a17e97e634a68 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -465,4 +465,6 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
 extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif
 
+void acpi_processor_init_invariance_cppc(void);
+
 #endif

base-commit: 6db936d4ac0fe281af48b4d1ebf69b1523bbac31
-- 
2.43.0


