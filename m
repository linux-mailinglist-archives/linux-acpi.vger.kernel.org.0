Return-Path: <linux-acpi+bounces-17317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C6ABA0D0D
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBED23A82F3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BB130C371;
	Thu, 25 Sep 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxM8MUMP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1D30C343;
	Thu, 25 Sep 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820994; cv=none; b=JG6rotD5UekE63bjTyVkYsQR+Y7d5EkScaZgLIO9775e9uOLQLSxZ0Y6DUSMq7f42wpzKSkdKYJyfkJOLaxokMK4mopoK1Wh6aRgVXRdO5p6Zzma8KoTj6qO10l1sFYW8CradDWoPZxC3rXBBJxOTvZqii9YOxiaELbcKiI7rRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820994; c=relaxed/simple;
	bh=t2//roIbCIlmxsTNxuZSq0Qg7Row5ASpt4n46USYK/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDCYwsfJGIk+TH21BNs6KZ4iPguhdl66vyQBAa071oQGfDGDVy21BV3SWL/5TDqTdg+R4FJKSXQOIYbxgppK0eIn3jm8EbrwL5bVpn58hC4CCOL3SXQsTppTVlyQWvLSJVKVDnTI+/aBLdHQj01Qhvrm2U0MqXeihUcMI6rbeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxM8MUMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12286C4CEF0;
	Thu, 25 Sep 2025 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820994;
	bh=t2//roIbCIlmxsTNxuZSq0Qg7Row5ASpt4n46USYK/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxM8MUMPcGIFn0l+Zb4XXihEFJ9xl6DLBjOgFiZ6tOHuO4lBMZQ3nlT4YBiIyb+wH
	 FskHTARFVpYLUvxdlDRqjE7cJkI27l7ZHPKAZU0YkS0Zfc/kWKsGoIagPuZbXFWZnR
	 HFwqsLnsIuQV1Q6P7nGWmX99BikNNCxMqVPCafvEmj7JSfBhq4v8V5HBAarzt8/mIu
	 9SO71Cp8MMusWESVxcX5jus30ZABRZ0/AXV/O+drKl8zHMl/u/xZbGYS33s5cfvLNt
	 EddkirD6zJe++vaKp/uzwHOrEaqjcbPY3fEOsN8uyafJ6HvOXNpTKF+pIYOJBpcHVD
	 8U3P5+yIO/txw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v2 3/4] ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error value
Date: Thu, 25 Sep 2025 19:23:09 +0200
Message-ID: <12773788.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3925838.kQq0lBPeGt@rafael.j.wysocki>
References:
 <8605612.T7Z3S40VBb@rafael.j.wysocki> <3925838.kQq0lBPeGt@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using CPUFREQ_ETERNAL for signaling an error condition
in cppc_get_transition_latency(), change the return value type of
that function to int and make it return a proper negative error
code on failures.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Change cppc_get_transition_latency() return value data type to int
   * Make it return -ENODATA on errors (Mario)
   * Update its callers accordingly
   * Adjust the subject and changelog
   * Add a missing empty code line to cppc_get_transition_latency()

The modifications of this patch don't affect any other patches in the series:

https://lore.kernel.org/linux-pm/8605612.T7Z3S40VBb@rafael.j.wysocki/

---
 drivers/acpi/cppc_acpi.c       |   15 ++++++++-------
 drivers/cpufreq/amd-pstate.c   |    8 ++++----
 drivers/cpufreq/cppc_cpufreq.c |    4 ++--
 include/acpi/cppc_acpi.h       |    6 +++---
 4 files changed, 17 insertions(+), 16 deletions(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1876,7 +1876,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
  * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
  * then assume there is no latency.
  */
-unsigned int cppc_get_transition_latency(int cpu_num)
+int cppc_get_transition_latency(int cpu_num)
 {
 	/*
 	 * Expected transition latency is based on the PCCT timing values
@@ -1889,31 +1889,32 @@ unsigned int cppc_get_transition_latency
 	 *              completion of a command before issuing the next command,
 	 *              in microseconds.
 	 */
-	unsigned int latency_ns = 0;
 	struct cpc_desc *cpc_desc;
 	struct cpc_register_resource *desired_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu_num);
 	struct cppc_pcc_data *pcc_ss_data;
+	int latency_ns = 0;
 
 	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
 	if (!cpc_desc)
-		return CPUFREQ_ETERNAL;
+		return -ENODATA;
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
 		return 0;
+
 	else if (!CPC_IN_PCC(desired_reg))
-		return CPUFREQ_ETERNAL;
+		return -ENODATA;
 
 	if (pcc_ss_id < 0)
-		return CPUFREQ_ETERNAL;
+		return -ENODATA;
 
 	pcc_ss_data = pcc_data[pcc_ss_id];
 	if (pcc_ss_data->pcc_mpar)
 		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_ss_data->pcc_mpar);
 
-	latency_ns = max(latency_ns, pcc_ss_data->pcc_nominal * 1000);
-	latency_ns = max(latency_ns, pcc_ss_data->pcc_mrtt * 1000);
+	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_nominal * 1000);
+	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_mrtt * 1000);
 
 	return latency_ns;
 }
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -872,10 +872,10 @@ static void amd_pstate_update_limits(str
  */
 static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 {
-	u32 transition_delay_ns;
+	int transition_delay_ns;
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
-	if (transition_delay_ns == CPUFREQ_ETERNAL) {
+	if (transition_delay_ns < 0) {
 		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
 			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
 		else
@@ -891,10 +891,10 @@ static u32 amd_pstate_get_transition_del
  */
 static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 {
-	u32 transition_latency;
+	int transition_latency;
 
 	transition_latency = cppc_get_transition_latency(cpu);
-	if (transition_latency  == CPUFREQ_ETERNAL)
+	if (transition_latency < 0)
 		return AMD_PSTATE_TRANSITION_LATENCY;
 
 	return transition_latency;
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -310,9 +310,9 @@ static int cppc_verify_policy(struct cpu
 
 static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
 {
-	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
+	int transition_latency_ns = cppc_get_transition_latency(cpu);
 
-	if (transition_latency_ns == CPUFREQ_ETERNAL)
+	if (transition_latency_ns < 0)
 		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
 
 	return transition_latency_ns / NSEC_PER_USEC;
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -160,7 +160,7 @@ extern unsigned int cppc_khz_to_perf(str
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
-extern unsigned int cppc_get_transition_latency(int cpu);
+extern int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
@@ -216,9 +216,9 @@ static inline bool cppc_allow_fast_switc
 {
 	return false;
 }
-static inline unsigned int cppc_get_transition_latency(int cpu)
+static inline int cppc_get_transition_latency(int cpu)
 {
-	return CPUFREQ_ETERNAL;
+	return -ENODATA;
 }
 static inline bool cpc_ffh_supported(void)
 {




