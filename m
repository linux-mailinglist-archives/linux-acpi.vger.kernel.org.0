Return-Path: <linux-acpi+bounces-17337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA964BA35B8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32CC1C04E08
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C62F49E2;
	Fri, 26 Sep 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Ku2OXw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D12D5410;
	Fri, 26 Sep 2025 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882735; cv=none; b=fzUXrVyjiCMb5eXng+CJ9HD/1wxcKp76YBMSffhM6YLygS6jcln3CJN0x0saoBjUT6THv9KIgnUGaBx1m48CTwA4s2tZq0R0LFcIlEmvIYrueLmKd10PHJFwwXqbQ8a7f+GBBYtQTuS0NgJWdEoZ0+7rAJyldt2mFxdpzvSoFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882735; c=relaxed/simple;
	bh=nvfO/ihARasVkSEkSuTvDx8ZpG635NgjIs3JtfpG71o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6qE6EsAj9Yj7jMKYqz8MbBftXSilRgxZBNP1HpvKEFJQV11kAbjKHf3Ul3lHpZ6lB06t2ohItK/putq43pyF7ha1JwHQuOe250L+z/WIuAFHFdzigCF+v73HmLVqp+kA7xkfqNkcSiT5mRWuvL9NdTCJau9TePgcoFf7/o8uRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Ku2OXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AD7C4CEF7;
	Fri, 26 Sep 2025 10:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882735;
	bh=nvfO/ihARasVkSEkSuTvDx8ZpG635NgjIs3JtfpG71o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2Ku2OXwVpOYqXMt3WPthb+TFuPePw8jtwVKejrXUHLnXQpkTlKZ5URNeS7a5zctT
	 eC1CqIkbtbC6D1Ny/FInFzHvf27qkBzkDWGowSDSyAE4to8x3ZtYu5oxE4txcJROF0
	 7RHcIdixEe5FYwSpJ/4po1oR4GDvTfXyROFR3oXHYNbNra+Qni6GfmHjJdK50d/BiW
	 SGPyTEf3IH2l+5YfWjKuw7+YJAGTcOfVkJ7KAFJAFNaeNxIB8XvcQXHQg4PccS7cFc
	 v4Uq8uwlUYs+lmxzDBoGa47PW0sv0217H21DwW32iABgD0IcehXHT7qrWuGaXU+D+I
	 hYVh12ogPrmPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>
Subject:
 [PATCH v3 3/4] ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error value
Date: Fri, 26 Sep 2025 12:29:50 +0200
Message-ID: <7882184.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5069803.31r3eYUQgx@rafael.j.wysocki>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
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

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Combine two if () statements in cppc_get_transition_latency() (Jie Zhan)
   * Add tags from Mario Limonciello and Jie Zhan

v1 -> v2:
   * Change cppc_get_transition_latency() return value data type to int
   * Make it return -ENODATA on errors (Mario)
   * Update its callers accordingly
   * Adjust the subject and changelog
   * Add a missing empty code line to cppc_get_transition_latency()

---
 drivers/acpi/cppc_acpi.c       |   16 +++++++---------
 drivers/cpufreq/amd-pstate.c   |    8 ++++----
 drivers/cpufreq/cppc_cpufreq.c |    4 ++--
 include/acpi/cppc_acpi.h       |    6 +++---
 4 files changed, 16 insertions(+), 18 deletions(-)

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
@@ -1889,31 +1889,29 @@ unsigned int cppc_get_transition_latency
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
-	else if (!CPC_IN_PCC(desired_reg))
-		return CPUFREQ_ETERNAL;
 
-	if (pcc_ss_id < 0)
-		return CPUFREQ_ETERNAL;
+	if (!CPC_IN_PCC(desired_reg) || pcc_ss_id < 0)
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
 
 static unsigned int __cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
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




