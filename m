Return-Path: <linux-acpi+bounces-17339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE194BA35CA
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F3D3B41BD
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AA2F5A03;
	Fri, 26 Sep 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrpqPPpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A552F360E;
	Fri, 26 Sep 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882746; cv=none; b=cc/NeZppLsWiVDuBhaZKkA29Vcx1s2UjoeAChfrFj65rGQ6P7zBPm9E4jwS3WJy5VBa6vOeD5GfvhXibSvHmo30kfo8aLnVwqxBUBs72TDrtNpLqlX0lQX6LeTLBDnuMvJy4T1/IiuosURY2Eq7exEAB6Y9svNxDxRXJ2Wb3qPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882746; c=relaxed/simple;
	bh=U4FIBXw04WyBJ+8RnALdG085PokeSoXyATd74JqI6FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Myy7K9OSt7G6zYJOse4q0B0QkGaejvy1zLL5sNzTKTdJx0p9tb5/+kTCjBa29DpVSxApSFFBOBTWvkYb94N55L0WEyauSCZ3qq7MldUbnmEgw7LqntfqWDXpoie+lZ5zZPn3CsjtFYONoi+PZvGU0+avYx4FkJ/BtqUIn3YBjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrpqPPpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ECEC4CEF4;
	Fri, 26 Sep 2025 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882746;
	bh=U4FIBXw04WyBJ+8RnALdG085PokeSoXyATd74JqI6FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrpqPPpCMDa/SNxmKjWVZjURZvFxZ2nen3pArK2eN6nHmotHcYC3NXMgpUDHVpRY7
	 4hK3tcKeOxHsl+STKUflRIyPFYdmo1LZJW8spYfp0cRTOelaGDffEpxCtcPqxgLu0K
	 k4w474D0k92LWBXF+T/Mmaw3wTrgAjLLFjxKeDorDmaQ4BB1dUFkcDpbmF5Nb5p5R3
	 BnfvQaCqTJLCquEnhlP1el7/cxZ/iU8DtTOUyPXafWlcZiUQwuJko37ZPNHmTzw09Z
	 69aEVU05bQGgpfrutk/hUXwovDFvjkBVvS3ZSRzyaaWdvGdevJ15Ga/jxzk7DcuECG
	 hwAfhi9m1QQ7g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>
Subject:
 [PATCH v3 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition
 latency
Date: Fri, 26 Sep 2025 12:12:37 +0200
Message-ID: <2264949.irdbgypaU6@rafael.j.wysocki>
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

Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
transition_delay_us") caused platforms where cpuinfo.transition_latency
is CPUFREQ_ETERNAL to get a very large transition latency whereas
previously it had been capped at 10 ms (and later at 2 ms).

This led to a user-observable regression between 6.6 and 6.12 as
described by Shawn:

"The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
 because the default transition delay was dropped [...].

 It slows down dbs governor's reacting to CPU loading change
 dramatically.  Also, as transition_delay_us is used by schedutil
 governor as rate_limit_us, it shows a negative impact on device
 idle power consumption, because the device gets slightly less time
 in the lowest OPP."

Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
cpuinfo.transition_latency was that it would be capped by the core,
but they may as well return a default transition latency value instead
of CPUFREQ_ETERNAL and the core need not do anything with it.

Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
all of the drivers in question use it instead of CPUFREQ_ETERNAL.  Also
update the related Rust binding.

Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
Reported-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3:
   * Add updates of the Rust version of cpufreq-dt and Rust binding
   * Update the changelog
   * Add tags from Mario Limonciello and Jie Zhan

---
 drivers/cpufreq/cpufreq-dt.c          |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |    2 +-
 drivers/cpufreq/scmi-cpufreq.c        |    2 +-
 drivers/cpufreq/scpi-cpufreq.c        |    2 +-
 drivers/cpufreq/spear-cpufreq.c       |    2 +-
 include/linux/cpufreq.h               |    3 +++
 rust/kernel/cpufreq.rs                |    7 ++++---
 9 files changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -442,7 +442,7 @@ soc_opp_out:
 	}
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	/*
 	 * Calculate the ramp time for max voltage change in the
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
 
 	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 	policy->fast_switch_possible = true;
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -123,7 +123,7 @@ impl cpufreq::Driver for CPUFreqDTDriver
 
         let mut transition_latency = opp_table.max_transition_latency_ns() as u32;
         if transition_latency == 0 {
-            transition_latency = cpufreq::ETERNAL_LATENCY_NS;
+            transition_latency = cpufreq::DEFAULT_TRANSITION_LATENCY_NS;
         }
 
         policy
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
 
 	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
 
 	latency = scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
 
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
-		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <= 0) {
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -39,7 +39,8 @@ use macros::vtable;
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
+        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
 
 /// CPU frequency driver flags.
 pub mod flags {
@@ -400,13 +401,13 @@ impl TableBuilder {
 /// The following example demonstrates how to create a CPU frequency table.
 ///
 /// ```
-/// use kernel::cpufreq::{ETERNAL_LATENCY_NS, Policy};
+/// use kernel::cpufreq::{DEFAULT_TRANSITION_LATENCY_NS, Policy};
 ///
 /// fn update_policy(policy: &mut Policy) {
 ///     policy
 ///         .set_dvfs_possible_from_any_cpu(true)
 ///         .set_fast_switch_possible(true)
-///         .set_transition_latency_ns(ETERNAL_LATENCY_NS);
+///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
 ///
 ///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
 /// }




