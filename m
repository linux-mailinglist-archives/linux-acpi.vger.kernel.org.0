Return-Path: <linux-acpi+bounces-8183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4396DFC2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D7F28A8F9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884401A7274;
	Thu,  5 Sep 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDNcmz93"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A31A7267;
	Thu,  5 Sep 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553827; cv=none; b=SBW2PoQTI253MHvkYp23M2I5KLY2aToB7KobS+m4n73e8cMr6uYRHOP5r7bDqBPGIOTSiLzfgjOr6to6ze4jv06Hdl/3Qu6P0tfrZfodsyB/uz2OWcJ54bLe8DBLa9tVBsTVdotprjbVCrj55MKkWjHV7CI/PugN/PetjD+rfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553827; c=relaxed/simple;
	bh=Y54jxoqOwq9hafYzm3zMRq3v1cZWWr87gVCbSOuKlsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+9s9UO7Vve+RYxPNkG7lTC9p+Mam39ANzJXyjHoXyLZjMhcBBHK0hr/L05k/lMWZz9rwnENnRIh6waomtL1pDhQcA+kqlEZptgJZyz8T73SDWn1T9EFmIGmM//8l5Z/vBroZrngOx0Kx0/8dmU1S5D+EoO1cKiNK5G1wKiuUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDNcmz93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A1C4CEC7;
	Thu,  5 Sep 2024 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553827;
	bh=Y54jxoqOwq9hafYzm3zMRq3v1cZWWr87gVCbSOuKlsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDNcmz93dGLHlQYH5aM5GF5k/Tky8bDBKfLN9eO4ruqvluJRiScIQq6IArnImzqYV
	 k4YkSmmms/RzdE2aUe6Or+ZddrmABbQIENRKQLKm9R8f5a/VQHh2ORAPA7F0fUsLgy
	 U5veu6HuLJAnPhHUpp3/S0hifVUv129b3cL1ZxpmiPX4bsDO5TwMornrm+fJdlIZwG
	 78Lu1T62MztnYOW/4Ohw59jqo39XQKkgZ1WILIr43IHzEPPSh0N0sdofJ6qUtLhZmX
	 8jQZ23Di/UjMbCnFb2VA/RfTQ9WeyYMeQVp/RYdxuhh0vqWZGisAs1UQBZsnIPrYzX
	 9vqhCGkqdul6g==
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
Subject: [PATCH v3 08/11] cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
Date: Thu,  5 Sep 2024 11:30:04 -0500
Message-ID: <20240905163007.1350840-9-superm1@kernel.org>
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

The special case in amd_pstate_highest_perf_set() is the value used
for calculating the boost numerator.  Merge this into
amd_get_boost_ratio_numerator() and then use that to calculate boost
ratio.

This allows dropping more special casing of the highest perf value.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tag
v1->v2:
 * Document that preferred cores will have different values for highest
   perf.
 * Fix an uninitialized variable caused by merge
---
 Documentation/admin-guide/pm/amd-pstate.rst |  3 +-
 arch/x86/kernel/acpi/cppc.c                 | 16 +++++++
 drivers/cpufreq/amd-pstate.c                | 52 ++++-----------------
 3 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index d0324d44f5482..e13915c540648 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -251,7 +251,8 @@ performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
 In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
 table, so we need to expose it to sysfs. If boost is not active, but
 still supported, this maximum frequency will be larger than the one in
-``cpuinfo``.
+``cpuinfo``. On systems that support preferred core, the driver will have
+different values for some cores than others.
 This attribute is read-only.
 
 ``amd_pstate_lowest_nonlinear_freq``
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index df367bc359308..956984054bf30 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/topology.h>
 
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_PREFCORE	166
 
 enum amd_pref_core {
@@ -245,6 +246,21 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
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
index c29cdf2d3882c..3ae41af6f041e 100644
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
@@ -420,19 +392,13 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 static int cppc_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
-	u32 highest_perf;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
-	else
-		highest_perf = cppc_perf.highest_perf;
-
-	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
+	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
+	WRITE_ONCE(cpudata->max_limit_perf, cppc_perf.highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
@@ -905,8 +871,8 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
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
@@ -928,8 +894,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
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


