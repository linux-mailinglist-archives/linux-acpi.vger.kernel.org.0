Return-Path: <linux-acpi+bounces-8182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180296DFC0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DC328B13B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D61A726E;
	Thu,  5 Sep 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfqHPmHV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CC1A7263;
	Thu,  5 Sep 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553827; cv=none; b=ct9+hUXtjBlGI/7DAGestfc8XWBqqoqgxgDhiIIV4E1Te2DtfUgGc/kWn8AK301WeacdN0I/XDK0x4GdJ2CvINQvlU7Fcfq8m4N5oA+0rm51XzRysUK2lbsPffbFshhALLaQ/5Xh4JyoYcITGiHAcaspOPe4aiuWp+meDGesuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553827; c=relaxed/simple;
	bh=V8++tM5kfE+fBeAJooozN2LS1B3Q+HgamDt7vl/R7Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e57lx46kII26oqA59RVtwlYvO8r8DoHVgnW1EstP0jR9qsBt3r/TehXhWimrW7ncpzM9RF0zVv+XZlfAwaHLX/e/y8g0mqofJODW4l+JgMbC4+0LuCNdYsSPjPOP+whLz+O5J941jSE/tXFLvc+tCStyIY/t9LUuvDWpI3M1LBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfqHPmHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D591EC4CEC3;
	Thu,  5 Sep 2024 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553825;
	bh=V8++tM5kfE+fBeAJooozN2LS1B3Q+HgamDt7vl/R7Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfqHPmHV9NQpjPhuiB+NbqqWFdD2tw0fwgJU9oNAkUN1iK6mnuomf4DD8qWblzAl/
	 DHyK7DnOiwSEDqCO5lto/RFpzcDmgpPAvCtWj/A6llNmeUv8sgV97iUTjaMUwrRwSY
	 FMJ2pVrT/qlrCamkMsam74jKWB7wfD/h0V4wUos4RCkJp23qQjBmMZ8SxHPIrad+zl
	 OSYdmTEST8veAJJpjAtc7ZePmjQcuBsN274nFwifNgsIRMaltQKzI/ejss5Hqx1gLW
	 lx6cXIgm182zqNi20wdV6aiFoY1lInQs7SMjfNItagFUMxIjSkX2KairNw6pzcweMo
	 miTQcUW8qS7/A==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 07/11] x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
Date: Thu,  5 Sep 2024 11:30:03 -0500
Message-ID: <20240905163007.1350840-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
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
v2->v3:
 * Fix kernel robot error
---
 arch/x86/kernel/acpi/cppc.c  | 93 ++++++++++++++++++++++++++++++++----
 drivers/cpufreq/amd-pstate.c | 34 +++++--------
 include/acpi/cppc_acpi.h     |  5 ++
 3 files changed, 101 insertions(+), 31 deletions(-)

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
index f7c7abf2a95e9..482e0587a0413 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -161,6 +161,7 @@ extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -242,6 +243,10 @@ static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator
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


