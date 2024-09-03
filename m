Return-Path: <linux-acpi+bounces-8117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A496A87D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402AC1F23F5E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E51D88D6;
	Tue,  3 Sep 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSS6IL5C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D001D88CF;
	Tue,  3 Sep 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395836; cv=none; b=kzx6ZQt+zfOSFLuNFc4HwXTb4ufnUBSkv0soHF5gMq+61432xpPDsHm3YvbIzejd7eKFwiOY1aKg3S7hg7JRCBtpPjaWHOYzylPqdEKM2Nd6Z64vUaZVQFyitM0XzVaFmSPTQo/JdX0zhICD3alcVPzNi+Ls+s8bmfYLLgGEQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395836; c=relaxed/simple;
	bh=Ch6C5UQ4WTPNT0tIthwecxL4mfyIdFFFSrcO+IMiKZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWIS7uhK59Z6ojkM+L348GOwIvaFTS3j9BArnWp4I2BxVyFAuDKGO9vqRATDKi+tSaChCf3JEVIF6PWY0ubDfo2XUH88fO36oDAyVMdUsC/evXudq/ZFoFI7SCH+WsaoDhirCAHmrdxztkJ8sqfK8zzpYwkfWQYy9WqMWZ3q6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSS6IL5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F6BC4CEC4;
	Tue,  3 Sep 2024 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395835;
	bh=Ch6C5UQ4WTPNT0tIthwecxL4mfyIdFFFSrcO+IMiKZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSS6IL5CEPyQjlDpsot1cg5oPI0qpfQsNtPm1ZwOqz7p0q+ZuTO90YtvK68Qpf7ch
	 KCTv8PaF1ehsOB6MwtV3/4ETWcinnQBMcK0/E9aP7woDKBIJAOYGMzCJtu3l3s8zvT
	 6pzIqIIBASA7N4CNSKaAKkR0mpL7eoVXlgVaLCnj4GakM+jxfBMvd0TJZp8ibqdMgA
	 tDgyPMWnMf3e9nMDLs+Y9wGEmVaYcjh0VftroZ1mLYJuWeqs6yMaOwnP346hoQepYR
	 TSUwoXLu7Ira6o3iAxIn13+iJnfZ+qNJCZOedggnLupNhux1APPqCzeORydhjF0Wly
	 bbs0+XKPcwM1Q==
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
Subject: [PATCH v2 07/11] x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
Date: Tue,  3 Sep 2024 15:36:57 -0500
Message-ID: <20240903203701.2695040-8-superm1@kernel.org>
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

AMD systems that support preferred cores will use "166" as their
numerator for max frequency calculations instead of "255".

Add a function for detecting preferred cores by looking at the
highest perf value on all cores.

If preferred cores are enabled return 166 and if disabled the
value in the highest perf register. As the function will be called
multiple times, cache the values for the boost numerator and if
preferred cores will be enabled in global variables.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a comment into amd_get_boost_ratio_numerator() as well
---
 arch/x86/kernel/acpi/cppc.c  | 93 ++++++++++++++++++++++++++++++++----
 drivers/cpufreq/amd-pstate.c | 34 +++++--------
 include/acpi/cppc_acpi.h     |  7 +++
 3 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index a75dcb382c786..df367bc359308 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -9,6 +9,16 @@
 #include <asm/processor.h>
 #include <asm/topology.h>
 
+#define CPPC_HIGHEST_PERF_PREFCORE	166
+
+enum amd_pref_core {
+	AMD_PREF_CORE_UNKNOWN = 0,
+	AMD_PREF_CORE_SUPPORTED,
+	AMD_PREF_CORE_UNSUPPORTED,
+};
+static enum amd_pref_core amd_pref_core_detected;
+static u64 boost_numerator;
+
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
 bool cpc_supported_by_cpu(void)
@@ -146,6 +156,66 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 }
 EXPORT_SYMBOL_GPL(amd_get_highest_perf);
 
+/**
+ * amd_detect_prefcore: Detect if CPUs in the system support preferred cores
+ * @detected: Output variable for the result of the detection.
+ *
+ * Determine whether CPUs in the system support preferred cores. On systems
+ * that support preferred cores, different highest perf values will be found
+ * on different cores. On other systems, the highest perf value will be the
+ * same on all cores.
+ *
+ * The result of the detection will be stored in the 'detected' parameter.
+ *
+ * Return: 0 for success, negative error code otherwise
+ */
+int amd_detect_prefcore(bool *detected)
+{
+	int cpu, count = 0;
+	u64 highest_perf[2] = {0};
+
+	if (WARN_ON(!detected))
+		return -EINVAL;
+
+	switch (amd_pref_core_detected) {
+	case AMD_PREF_CORE_SUPPORTED:
+		*detected = true;
+		return 0;
+	case AMD_PREF_CORE_UNSUPPORTED:
+		*detected = false;
+		return 0;
+	default:
+		break;
+	}
+
+	for_each_present_cpu(cpu) {
+		u32 tmp;
+		int ret;
+
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret)
+			return ret;
+
+		if (!count || (count == 1 && tmp != highest_perf[0]))
+			highest_perf[count++] = tmp;
+
+		if (count == 2)
+			break;
+	}
+
+	*detected = (count == 2);
+	boost_numerator = highest_perf[0];
+
+	amd_pref_core_detected = *detected ? AMD_PREF_CORE_SUPPORTED :
+					     AMD_PREF_CORE_UNSUPPORTED;
+
+	pr_debug("AMD CPPC preferred core is %ssupported (highest perf: 0x%llx)\n",
+		 *detected ? "" : "un", highest_perf[0]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_detect_prefcore);
+
 /**
  * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
  * @cpu: CPU to get numerator for.
@@ -155,24 +225,27 @@ EXPORT_SYMBOL_GPL(amd_get_highest_perf);
  * a CPU. On systems that support preferred cores, this will be a hardcoded
  * value. On other systems this will the highest performance register value.
  *
+ * If booting the system with amd-pstate enabled but preferred cores disabled then
+ * the correct boost numerator will be returned to match hardware capabilities
+ * even if the preferred cores scheduling hints are not enabled.
+ *
  * Return: 0 for success, negative error code otherwise.
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
+	bool prefcore;
+	int ret;
 
-	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
-		*numerator = 166;
-		return 0;
-	}
+	ret = amd_detect_prefcore(&prefcore);
+	if (ret)
+		return ret;
 
-	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
-		*numerator = 166;
+	/* without preferred cores, return the highest perf register value */
+	if (!prefcore) {
+		*numerator = boost_numerator;
 		return 0;
 	}
-	*numerator = 255;
+	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
 }
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 44df6ef66b5fa..c29cdf2d3882c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -807,32 +807,18 @@ static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
 
 static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 {
-	int ret, prio;
-	u32 highest_perf;
-
-	ret = amd_get_highest_perf(cpudata->cpu, &highest_perf);
-	if (ret)
+	/* user disabled or not detected */
+	if (!amd_pstate_prefcore)
 		return;
 
 	cpudata->hw_prefcore = true;
-	/* check if CPPC preferred core feature is enabled*/
-	if (highest_perf < CPPC_MAX_PERF)
-		prio = (int)highest_perf;
-	else {
-		pr_debug("AMD CPPC preferred core is unsupported!\n");
-		cpudata->hw_prefcore = false;
-		return;
-	}
-
-	if (!amd_pstate_prefcore)
-		return;
 
 	/*
 	 * The priorities can be set regardless of whether or not
 	 * sched_set_itmt_support(true) has been called and it is valid to
 	 * update them at any time after it has been called.
 	 */
-	sched_set_itmt_core_prio(prio, cpudata->cpu);
+	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->highest_perf), cpudata->cpu);
 
 	schedule_work(&sched_prefcore_work);
 }
@@ -998,12 +984,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
-	amd_pstate_init_prefcore(cpudata);
-
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_freq(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1453,12 +1439,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
-	amd_pstate_init_prefcore(cpudata);
-
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_freq(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1920,6 +1906,12 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	}
 
+	if (amd_pstate_prefcore) {
+		ret = amd_detect_prefcore(&amd_pstate_prefcore);
+		if (ret)
+			return ret;
+	}
+
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index f7c7abf2a95e9..67325a9294ba1 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -136,6 +136,8 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
+extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
@@ -161,6 +163,7 @@ extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -242,6 +245,10 @@ static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator
 {
 	return -EOPNOTSUPP;
 }
+static inline int amd_detect_prefcore(bool *detected)
+{
+	return -ENODEV;
+}
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.43.0


