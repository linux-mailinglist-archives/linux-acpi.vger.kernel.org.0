Return-Path: <linux-acpi+bounces-8116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C096A87A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E41D286027
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1B1D88A9;
	Tue,  3 Sep 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqKrK4tz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684981D88A2;
	Tue,  3 Sep 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395834; cv=none; b=S4Y55a8uk2KvAkhIBo+JO9fxHKGpDfbbfpHJwdE7+U298DCoDc0tYlbYJiBPtV2LiCH+qkvUZGqoNewd6ZjVSr9latAcXH43CuRHc1TCVdpretQMtNrtP0Y2w6y8EXGdP5kU5ui5laDGh3Ou93VMhjZ2GMW3iHdWxSk7UxGtSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395834; c=relaxed/simple;
	bh=72h3WUChhX1/hxEuoU38xiisjOiAcozzY3/6ch+SP44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXmS7lFc2pHLneQQcp/MSItfdxjg4iqNl2HzHIcHb3hhF6GS6iuWGAL3AkAF9soqX9R3A3642ACayPRaaRoLN37jvUIHx/mYvmY+E5E2Egm3diD9lbzlxxiHvT7uwPJstzxpOFiXyyKwj03i07r6Hi0SlvRoQ8DN4fvouw9oiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqKrK4tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB1C4CEC9;
	Tue,  3 Sep 2024 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395834;
	bh=72h3WUChhX1/hxEuoU38xiisjOiAcozzY3/6ch+SP44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqKrK4tzVTxo/tdq7Ny46ILLN1twFPf9NC5Ma/ZEuJxtfWvw/21Oa1I0ZKaTEJ57c
	 WZOtG/k5X5BLWxv+umpIcSFGuGXxfj/+Q4YArTOmepttzz22PfoZpzhjXK/cF2LjQA
	 2FO+fo5tZHiDQaT2YL6MxUrDQM2bcIKLm1+ONlTGaMDCoYHDu2w2P3UoMZY5WoiTrd
	 2l2ZUvpiZSoP0rZqE9mRkyrolTUiPW1EjO+YtU15BClSHhBVBJuLSu3xWScQlsWUUt
	 tyoxyd7NuG5ewiTDEC2dzVEr6i34sH3wCpAxOJJIROmU2Fj2f39fTCuXBBVJYam8O6
	 zMab2ZyJHhfyA==
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
Subject: [PATCH v2 06/11] x86/amd: Move amd_get_highest_perf() out of amd-pstate
Date: Tue,  3 Sep 2024 15:36:56 -0500
Message-ID: <20240903203701.2695040-7-superm1@kernel.org>
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

amd_pstate_get_highest_perf() is a helper used to get the highest perf
value on AMD systems.  It's used in amd-pstate as part of preferred
core handling, but applicable for acpi-cpufreq as well.

Move it out to cppc handling code as amd_get_highest_perf().

Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message (Gautham)
---
 arch/x86/kernel/acpi/cppc.c  | 30 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c | 34 ++--------------------------------
 include/acpi/cppc_acpi.h     |  5 +++++
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index f0328ce98a8fe..a75dcb382c786 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -116,6 +116,36 @@ void init_freq_invariance_cppc(void)
 	mutex_unlock(&freq_invariance_lock);
 }
 
+/*
+ * Get the highest performance register value.
+ * @cpu: CPU from which to get highest performance.
+ * @highest_perf: Return address for highest performance value.
+ *
+ * Return: 0 for success, negative error code otherwise.
+ */
+int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
+{
+	u64 val;
+	int ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
+		if (ret)
+			goto out;
+
+		val = AMD_CPPC_HIGHEST_PERF(val);
+	} else {
+		ret = cppc_get_highest_perf(cpu, &val);
+		if (ret)
+			goto out;
+	}
+
+	WRITE_ONCE(*highest_perf, (u32)val);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_get_highest_perf);
+
 /**
  * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
  * @cpu: CPU to get numerator for.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index db4f747f128f1..44df6ef66b5fa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -803,36 +803,6 @@ static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
 }
 static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
 
-/*
- * Get the highest performance register value.
- * @cpu: CPU from which to get highest performance.
- * @highest_perf: Return address.
- *
- * Return: 0 for success, -EIO otherwise.
- */
-static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
-{
-	int ret;
-
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		u64 cap1;
-
-		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
-		if (ret)
-			return ret;
-		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
-	} else {
-		u64 cppc_highest_perf;
-
-		ret = cppc_get_highest_perf(cpu, &cppc_highest_perf);
-		if (ret)
-			return ret;
-		WRITE_ONCE(*highest_perf, cppc_highest_perf);
-	}
-
-	return (ret);
-}
-
 #define CPPC_MAX_PERF	U8_MAX
 
 static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
@@ -840,7 +810,7 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	int ret, prio;
 	u32 highest_perf;
 
-	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
+	ret = amd_get_highest_perf(cpudata->cpu, &highest_perf);
 	if (ret)
 		return;
 
@@ -879,7 +849,7 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
 		goto free_cpufreq_put;
 
-	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
+	ret = amd_get_highest_perf(cpu, &cur_high);
 	if (ret)
 		goto free_cpufreq_put;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 97861abc5f5b8..f7c7abf2a95e9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -159,6 +159,7 @@ extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -233,6 +234,10 @@ static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf
 {
 	return -EOPNOTSUPP;
 }
+static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
+{
+	return -ENODEV;
+}
 static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


