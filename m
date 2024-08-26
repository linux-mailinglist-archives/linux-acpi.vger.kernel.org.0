Return-Path: <linux-acpi+bounces-7843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB795FB63
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1F1F230E7
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157B019D8A3;
	Mon, 26 Aug 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPuyBUsi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEB19CCF4;
	Mon, 26 Aug 2024 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706851; cv=none; b=KD8C5MpjDH4K0hlvvqzfBMAScVZHqi4SlBwNBOC0FouoOM0TkrBLtOtMjRv5jdSyEXQkBJVdlZmcSnNt/GUSDkOi+uGnTWPchb1iK3qvmA2LoWHrmihbKt9N9Cg3DfQLnpWr83zN8PWw/34uHKAQ+gNG1qLgcUJep8V5LRK/pnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706851; c=relaxed/simple;
	bh=Itv5dSKp4O0Rg5AN7sFQ7TVZQjPLIr3am5lKRK636nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s47NAub3ThJxKVllEQ7psG2v8X8vK7uUzH/YXuf1qxhgbTfg9jBS4X0NI7QHewtgcM/bAtJshL7rAEGP3lETNe/bp4SpxClkOer5LdkrEC7B/u01vo+JTjak28J+EzgkvSkihgF+q7Uw+Oucao7AQbr2rlU/TvdjLRidkbGuT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPuyBUsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A18C4FEB2;
	Mon, 26 Aug 2024 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706850;
	bh=Itv5dSKp4O0Rg5AN7sFQ7TVZQjPLIr3am5lKRK636nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPuyBUsi9JDB/jB5x+bBYHr/MwBApafpILumh0LKIRbblDsCu20XlFCljMJApVsMH
	 DCGCFxTMiGcuGtGrSj4AD4gjQ6TIPeVcRN52i4vgcV6/CvIdRRrlOYNGHY9XnheTv4
	 XcMLzl+J/YQev/jbaoXnKYMte6LS79guhJ14qcCV5C5ZsyVmL3MZ9U7O2+xwHOx52I
	 nt8Jay1q0f68H193HC9bCDq1GP5jDt2GHe+tgT5hT4Tog01aW8vrnn13wUF+DmiLk2
	 1Zypwano+V30SOLP0YqbUqhvy6hiTGHZAXTA9o1/4xXqcRNFc9prnMurjY5yUruG4l
	 YyhuFPi+yhO7Q==
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
Subject: [PATCH 6/8] cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Date: Mon, 26 Aug 2024 16:13:56 -0500
Message-ID: <20240826211358.2694603-7-superm1@kernel.org>
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

The special case in amd_pstate_highest_perf_set() is the value used
for calculating the boost numerator.  Merge this into
amd_get_boost_ratio_numerator() and then use that to calculate boost
ratio.

This allows dropping more special casing of the highest perf value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c  | 16 ++++++++++++
 drivers/cpufreq/amd-pstate.c | 49 +++++++-----------------------------
 2 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 729b35e84f5eb..44b13a4e28740 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/topology.h>
 
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_PREFCORE	166
 
 enum amd_pref_core {
@@ -244,6 +245,21 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 		*numerator = boost_numerator;
 		return 0;
 	}
+
+	/*
+	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
+	 * the highest performance level is set to 196.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+		switch (boot_cpu_data.x86_model) {
+		case 0x70 ... 0x7f:
+			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+			return 0;
+		default:
+			break;
+		}
+	}
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ec32c830abc1d..75568d0f84623 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -52,8 +52,6 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
-#define CPPC_HIGHEST_PERF_PERFORMANCE	196
-#define CPPC_HIGHEST_PERF_DEFAULT	166
 
 #define AMD_CPPC_EPP_PERFORMANCE		0x00
 #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
@@ -372,43 +370,17 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
-static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
-{
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	/*
-	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
-	 * the highest performance level is set to 196.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
-	 */
-	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
-		return CPPC_HIGHEST_PERF_PERFORMANCE;
-
-	return CPPC_HIGHEST_PERF_DEFAULT;
-}
-
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
-	u32 highest_perf;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
 
-	/* For platforms that do not support the preferred core feature, the
-	 * highest_pef may be configured with 166 or 255, to avoid max frequency
-	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
-	 * the default max perf.
-	 */
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
-	else
-		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
-
-	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
+	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
@@ -426,12 +398,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
-	else
-		highest_perf = cppc_perf.highest_perf;
-
-	WRITE_ONCE(cpudata->highest_perf, highest_perf);
+	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
 	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
@@ -905,8 +872,8 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
-	u32 min_freq;
-	u32 highest_perf, max_freq;
+	u32 min_freq, max_freq;
+	u64 numerator;
 	u32 nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
 	u32 boost_ratio, lowest_nonlinear_ratio;
@@ -928,8 +895,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
+	if (ret)
+		return ret;
+	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
 	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-- 
2.43.0


