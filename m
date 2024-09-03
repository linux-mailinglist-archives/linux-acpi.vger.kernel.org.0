Return-Path: <linux-acpi+bounces-8113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233596A871
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D881F232DD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3741D5CE8;
	Tue,  3 Sep 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4+va5KE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440881D5CDE;
	Tue,  3 Sep 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395831; cv=none; b=ZUk3q4OM5w5o4SkoMKkqbNFLbDOa2HisQiOBAaaoXix3erqB+3P6WonwYF8JVsY8Tmt54rf/MndOUe4RgxntRXFU+jfDyE5dm5wElavx4WC1sAjzu6TJeSSEol0RydNC6C841VZSHcxPejMxn9tS99Lp4LOfdk6kxOb+9OtRSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395831; c=relaxed/simple;
	bh=uRcOVJlImEQYMNMqGqw3ufNNAd9/xVXYqLEW1tRAtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcvCXLLRETJ2M59QutUP0XjJ8nPeq6KzIRIXqzeloLBu7TZ/feHAzQ3jJ7sZhgPIimPwiFhJ2Sg8BTaWAU5XiG0c6ztzRfmMXDiGnLGqR4jURILU/S5PBcvOHimnwGslbwHexyHozk/ZtW9oZzpNDLm/jZIeurwtvVrN3MQedOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4+va5KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B6C4CECD;
	Tue,  3 Sep 2024 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395830;
	bh=uRcOVJlImEQYMNMqGqw3ufNNAd9/xVXYqLEW1tRAtJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4+va5KEo7rqF+gZb2wvo3pBhwFeQIytnqMQaWWCCD7i6jnyjXqkwCY6TkWhZgtBd
	 KPGMlWN3Lx3dtB9OAgtfZz2PmCaUS3WQLpCgT5QbLwKl7B5aHwgzR2GOJ9dLVXuGPx
	 ZQOFd3jpMv7c8nwF1A3O6zKg6gAeiNkYlaRap0z8tdnLjd3NAOHtmaXSoZKocQV818
	 9hJ1q6ZwIeor8S2rD4fEqcgRVWMubatFhrjv/FuwzaumYFSBAWrYyU5jlE/xDrwu+L
	 BdH0IQ7nuSEW8yGepCWOfdxb6R3WaBH/vD5KQ+FEuHD/lCz0VugrLf3ZjORthQSVH5
	 ccYSuhil10ClA==
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
Subject: [PATCH v2 03/11] x86/amd: Rename amd_get_highest_perf() to amd_get_boost_ratio_numerator()
Date: Tue,  3 Sep 2024 15:36:53 -0500
Message-ID: <20240903203701.2695040-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903203701.2695040-1-superm1@kernel.org>
References: <20240903203701.2695040-1-superm1@kernel.org>
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
v1->v2:
 * Rename variable from `highest_perf` to `numerator`
 * Fail when unable to return boost numerator
 * Move prototype behind CONFIG_ACPI_CPPC_LIB (lkp robot)
---
 arch/x86/include/asm/processor.h |  3 ---
 arch/x86/kernel/acpi/cppc.c      | 44 +++++++++++++++++++++++---------
 drivers/cpufreq/acpi-cpufreq.c   | 12 ++++++---
 include/acpi/cppc_acpi.h         |  5 ++++
 4 files changed, 46 insertions(+), 18 deletions(-)

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
index 7ec8f2ce859c8..660cfeb6384ba 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -69,7 +69,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static void amd_set_max_freq_ratio(void)
 {
 	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
+	u64 numerator, nominal_perf;
 	u64 perf_ratio;
 	int rc;
 
@@ -79,15 +79,19 @@ static void amd_set_max_freq_ratio(void)
 		return;
 	}
 
-	highest_perf = amd_get_highest_perf();
+	rc = amd_get_boost_ratio_numerator(0, &numerator);
+	if (rc) {
+		pr_debug("Could not retrieve highest performance (%d)\n", rc);
+		return;
+	}
 	nominal_perf = perf_caps.nominal_perf;
 
-	if (!highest_perf || !nominal_perf) {
-		pr_debug("Could not retrieve highest or nominal performance\n");
+	if (!nominal_perf) {
+		pr_debug("Could not retrieve nominal performance\n");
 		return;
 	}
 
-	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	perf_ratio = div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf);
 	/* midpoint between max_boost and max_P */
 	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
 	if (!perf_ratio) {
@@ -117,18 +121,34 @@ void init_freq_invariance_cppc(void)
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
index 409a7190a4a86..97861abc5f5b8 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -159,6 +159,7 @@ extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -232,6 +233,10 @@ static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf
 {
 	return -EOPNOTSUPP;
 }
+static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.43.0


