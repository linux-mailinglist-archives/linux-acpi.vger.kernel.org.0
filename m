Return-Path: <linux-acpi+bounces-7839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B631C95FB57
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E8E1C216B3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00F19B3EA;
	Mon, 26 Aug 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5RpDVXs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD219B3CE;
	Mon, 26 Aug 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706846; cv=none; b=QsUy3Vu6atqZcYxklsuqarZA8FAzSCHA+ZugVLIb4EnhfuyqHxoq7t+c8IGnMRYdcINHJyO5dK6wLQvq9D3uinMTMKxuXcjVELzOw13+inlsAWg7THjDGB54+/Q7Map8bSJMaWKlUyJe9HphpxhzsWjRhfXGpLJoFPad+70FIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706846; c=relaxed/simple;
	bh=KVNp1G8slxA+wZy7zXLv6iv+GyN4Ap2hn6dkSBGSHck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXnfjpkcKDrSEDSEurCkBHNes8j+YsEt4vcfdM1omFQH9rzIayyIWLT6bewbmhtmpGg2O+rZgy0TZZFcZ4VhDdrf+NTim70HuEYjfQH+gjYsaxgtv8GKlic2QkSwTeFZjihTqwZtu6+57T54emVo+ICk0SKP4owz8r/b38n53NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5RpDVXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B12C4DDF0;
	Mon, 26 Aug 2024 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706845;
	bh=KVNp1G8slxA+wZy7zXLv6iv+GyN4Ap2hn6dkSBGSHck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5RpDVXsj0vnb1lf1gO9G7f5ypmw26FPrDCTDgqfcyUcP1G7wWqpwsYLkZy2u5m5m
	 he9nk0jeed1XVtANICao40uRvqw8HYxG185c4FaTrGr0DCLeYqjKYIq9nmxyquyd0o
	 yieB4O2DI1ibKHeuYkgJKjUHPpO7vX02AZD1kExlB6oRcD5mYUuVIzFxBUwLU1k9Cu
	 +e6L3XbNzdqV4ljMJvvwrATn1gzyqg1hf1wHF8RZaQ/+F4YrwWYZwohyeR0lS5sEXU
	 zH5hRTtZxgCcMQOj1SYui7B3H2Ox81VbzjYlYU6o4yrK23mHZVOFbY3oyr7i+4gWLh
	 rqfo5KvUdMrWQ==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/8] x86/amd: Rename amd_get_highest_perf() to amd_get_boost_ratio_numerator()
Date: Mon, 26 Aug 2024 16:13:52 -0500
Message-ID: <20240826211358.2694603-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826211358.2694603-1-superm1@kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The function name is ambiguous because it returns an intermediate value
for calculating maximum frequency rather than the CPPC 'Highest Perf'
register.

Rename the function to clarify its use and allow the function to return
errors. Adjust the consumer in acpi-cpufreq to catch errors.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/processor.h |  3 ---
 arch/x86/kernel/acpi/cppc.c      | 38 +++++++++++++++++++++++---------
 drivers/cpufreq/acpi-cpufreq.c   | 12 +++++++---
 include/acpi/cppc_acpi.h         |  6 +++++
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a75a07f4931fd..775acbdea1a96 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -691,8 +691,6 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u32 amd_get_highest_perf(void);
-
 /*
  * Issue a DIV 0/1 insn to clear any division data from previous DIV
  * operations.
@@ -705,7 +703,6 @@ static __always_inline void amd_clear_divider(void)
 
 extern void amd_check_microcode(void);
 #else
-static inline u32 amd_get_highest_perf(void)		{ return 0; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
 #endif
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 7ec8f2ce859c8..1d631ac5ec328 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -79,11 +79,13 @@ static void amd_set_max_freq_ratio(void)
 		return;
 	}
 
-	highest_perf = amd_get_highest_perf();
+	rc = amd_get_boost_ratio_numerator(0, &highest_perf);
+	if (rc)
+		pr_debug("Could not retrieve highest performance\n");
 	nominal_perf = perf_caps.nominal_perf;
 
-	if (!highest_perf || !nominal_perf) {
-		pr_debug("Could not retrieve highest or nominal performance\n");
+	if (!nominal_perf) {
+		pr_debug("Could not retrieve nominal performance\n");
 		return;
 	}
 
@@ -117,18 +119,34 @@ void init_freq_invariance_cppc(void)
 	mutex_unlock(&freq_invariance_lock);
 }
 
-u32 amd_get_highest_perf(void)
+/**
+ * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
+ * @cpu: CPU to get numerator for.
+ * @numerator: Output variable for numerator.
+ *
+ * Determine the numerator to use for calculating the boost ratio on
+ * a CPU. On systems that support preferred cores, this will be a hardcoded
+ * value. On other systems this will the highest performance register value.
+ *
+ * Return: 0 for success, negative error code otherwise.
+ */
+int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
-		return 166;
+			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
+		*numerator = 166;
+		return 0;
+	}
 
 	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
-		return 166;
+			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
+		*numerator = 166;
+		return 0;
+	}
+	*numerator = 255;
 
-	return 255;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_get_highest_perf);
+EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a8ca625a98b89..0f04feb6cafaf 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -642,10 +642,16 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 		return 0;
 	}
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		highest_perf = amd_get_highest_perf();
-	else
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
+		if (ret) {
+			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
+				 cpu, ret);
+			return 0;
+		}
+	} else {
 		highest_perf = perf_caps.highest_perf;
+	}
 
 	nominal_perf = perf_caps.nominal_perf;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4d..f25a881cd46dd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -136,6 +136,12 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+#ifdef CONFIG_CPU_SUP_AMD
+extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+#else /* !CONFIG_CPU_SUP_AMD */
+static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
+#endif /* !CONFIG_CPU_SUP_AMD */
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
-- 
2.43.0


