Return-Path: <linux-acpi+bounces-7841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F895FB5E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B401F2314F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76619D075;
	Mon, 26 Aug 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evDp0xMY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9319D06A;
	Mon, 26 Aug 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706848; cv=none; b=HwJalZ3P35rGJn9AF8d15ZIlYyFJKGK46a9isUU4Jqu5CB0QTalib2o72kJ/nBhLKs8ng8Y8bkYqAnq6m1X1foF7ckBuP4lURFceN/q8pvcdccmmxLyKjlrdmpgSVNo8WR8XTYUd45vdM9CmkI15cILehG926GbcgIKIe7M1itA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706848; c=relaxed/simple;
	bh=0K9IRUvCtBRV7Jmvx4IeBFO0vuipHE8D7dtiZfLwYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc4MrFttqAVpxIaa6BuV63srlQ6lS/epve11nLu+h99jOaKSluDv12pLVTG5EujaUET+tyutec171Y0kiK2ntvcggWc1ZL+sGttfltDkoUnXREeFz+nC/m+BcALNkLgGTpRDBjfYPa3ANOKnPyCO2Cimi4HDX5scbwyqRg8rxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evDp0xMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789BC4E699;
	Mon, 26 Aug 2024 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706848;
	bh=0K9IRUvCtBRV7Jmvx4IeBFO0vuipHE8D7dtiZfLwYqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evDp0xMYuBjknja+kHmGtkrSz1L7eERx9+UOpxRmwMxuREaGFDlAI9bPDebcTo3Yo
	 /xc9y9BN10VOYpoUoRf9hQpVicSqg4p/RaY5XAE01BONGSIbF/fNc+3BMPZKq8jKRu
	 CqcsoJ8Mk+AtaVXzg4ibZcZ0NvX2Z2QsOX7ykbnMxL3iSOD5oXx6TKb5ZNwrjefu7s
	 G1NQPsi3foIqNJDMOWrhP6/rV6AQEgV4DzMKGG7kOVvV8m9XeMnLDduIOCiyFsigc3
	 Plbq5tZwWot7lZBN9uYH7G9f+uLuoXloy2vybt7x7L3vxW3f1aqaDtVu1Fad9mys02
	 6anmlZblovNtA==
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
Subject: [PATCH 4/8] x86/amd: Move amd_get_highest_perf() out of amd-pstate
Date: Mon, 26 Aug 2024 16:13:54 -0500
Message-ID: <20240826211358.2694603-5-superm1@kernel.org>
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

amd_get_highest_perf() is a helper used to get the highest perf
value on AMD systems.  It's used in amd-pstate as part of preferred
core handling, but applicable for acpi-cpufreq as well.

Move it out to cppc handling code.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c  | 30 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c | 34 ++--------------------------------
 include/acpi/cppc_acpi.h     |  2 ++
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index e94507110ca24..5a6c01a1b0d95 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -119,6 +119,36 @@ void init_freq_invariance_cppc(void)
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
index 89bda7a2bb8d1..f470b5700db58 100644
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
index f25a881cd46dd..2246ce0630362 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -137,8 +137,10 @@ struct cppc_cpudata {
 };
 
 #ifdef CONFIG_CPU_SUP_AMD
+extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 #else /* !CONFIG_CPU_SUP_AMD */
+static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf) { return -ENODEV; }
 static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
 #endif /* !CONFIG_CPU_SUP_AMD */
 
-- 
2.43.0


