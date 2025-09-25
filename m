Return-Path: <linux-acpi+bounces-17308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C653BA06E2
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 17:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2124C06A0
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34CA30499D;
	Thu, 25 Sep 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmnUukSv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB73043C8;
	Thu, 25 Sep 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815287; cv=none; b=PBiblx1dEdr8SUZtWsZfRtbd72CRCBy7974CIUzpRYKCCXeEpXU5xOMN4jxIBSxxqSLQMkNmbYBwbiwjbvacQdI/UBqDjJKyuuazPSiDeuHT14K7sa01ZOW8Q5t3uyvSq89SFmj0yQEnbP8npVXlVtddlVk+o6fEAXWcdnMkRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815287; c=relaxed/simple;
	bh=IjHqcP+tfTKbtRDj+etlmWk5c8fXs0oldILjBTpHqn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idbz/5NDDTaOYktyZcoR1RSt/mOInRD9J3sUJ0d0iYBo22X8n3RqJTCdhKJy3xStmUKNkFos6WgTZa5sBxKb6+TOLQZf337F4RjokiRZXdVQ5XkIaOnvbNh7HlkhFaUiuc5fCoAiDNeLMe9r5hDIuB2JgYCkq8pJbABuRr+jl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmnUukSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B19C4CEF5;
	Thu, 25 Sep 2025 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815287;
	bh=IjHqcP+tfTKbtRDj+etlmWk5c8fXs0oldILjBTpHqn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmnUukSvnxM5e5X/6mrcfpWCnesEheSf7qb5OqG4Na8njDhwm9MyI7+Woe7zlZy4G
	 Phd88cmY6rD/NANadylXCuuX1kkYp1dB+UjhMjnAhDIObkAK773+qpSrTWb83tu4BH
	 u6M07ldiU9hc6ulkVltwLM8nsp5fS1gVNfy71LNXU0bQ2JlnyLT9xeJBVs3n5vrIVn
	 3Kf0GJ1fk3rdG08hC7ezs/O/pc/BoYk2EzFdLiiZxR0I5lIlOoAuLCy1Wvo54VDUW2
	 pQWLdbL09krjhpT7RrD/Jmd1+jCtsnx4oZ6iWH1aOHmYpN0u+VamcZlWdsmlN2fKGw
	 ABN59Rr5B2GFA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 3/4] ACPI: CPPC: Replace CPUFREQ_ETERNAL with CPPC-specific symbol
Date: Thu, 25 Sep 2025 17:46:27 +0200
Message-ID: <3925838.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using CPUFREQ_ETERNAL for signaling error conditions in
cppc_get_transition_latency(), introduce CPPC_NO_DATA specifically
for this purpose and update all of the callers of this function to
use it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c       |    6 +++---
 drivers/cpufreq/amd-pstate.c   |    4 ++--
 drivers/cpufreq/cppc_cpufreq.c |    2 +-
 include/acpi/cppc_acpi.h       |    4 +++-
 include/linux/cpufreq.h        |    3 ---
 5 files changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1897,16 +1897,16 @@ unsigned int cppc_get_transition_latency
 
 	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
 	if (!cpc_desc)
-		return CPUFREQ_ETERNAL;
+		return CPPC_NO_DATA;
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
 		return 0;
 	else if (!CPC_IN_PCC(desired_reg))
-		return CPUFREQ_ETERNAL;
+		return CPPC_NO_DATA;
 
 	if (pcc_ss_id < 0)
-		return CPUFREQ_ETERNAL;
+		return CPPC_NO_DATA;
 
 	pcc_ss_data = pcc_data[pcc_ss_id];
 	if (pcc_ss_data->pcc_mpar)
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -875,7 +875,7 @@ static u32 amd_pstate_get_transition_del
 	u32 transition_delay_ns;
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
-	if (transition_delay_ns == CPUFREQ_ETERNAL) {
+	if (transition_delay_ns == CPPC_NO_DATA) {
 		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
 			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
 		else
@@ -894,7 +894,7 @@ static u32 amd_pstate_get_transition_lat
 	u32 transition_latency;
 
 	transition_latency = cppc_get_transition_latency(cpu);
-	if (transition_latency  == CPUFREQ_ETERNAL)
+	if (transition_latency  == CPPC_NO_DATA)
 		return AMD_PSTATE_TRANSITION_LATENCY;
 
 	return transition_latency;
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -312,7 +312,7 @@ static unsigned int get_transition_laten
 {
 	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
 
-	if (transition_latency_ns == CPUFREQ_ETERNAL)
+	if (transition_latency_ns == CPPC_NO_DATA)
 		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
 
 	return transition_latency_ns / NSEC_PER_USEC;
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -41,6 +41,8 @@
 
 #define CPPC_ENERGY_PERF_MAX	(0xFF)
 
+#define CPPC_NO_DATA	(unsigned int)(-1)
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -218,7 +220,7 @@ static inline bool cppc_allow_fast_switc
 }
 static inline unsigned int cppc_get_transition_latency(int cpu)
 {
-	return CPUFREQ_ETERNAL;
+	return CPPC_NO_DATA;
 }
 static inline bool cpc_ffh_supported(void)
 {




