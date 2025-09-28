Return-Path: <linux-acpi+bounces-17377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328CEBA6709
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AE63C0D85
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507F255E34;
	Sun, 28 Sep 2025 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TxkO2Kh7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01E2550A4;
	Sun, 28 Sep 2025 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029890; cv=none; b=cHIbyfVBZUoodztTvDqGuZHydRcn5LKFGEXe+KvnBKQZD3xEGh28unvs8e4qkId+m3AyQ2qcFhp7RaZRE6MKS/L1hHdYRKrMJBcRZ0zmHw2ygtfgrSCnQhxvNT9j6YN8oojnVGMVt62tc5u0KN0pt10BkCaYiaMTAh0CnEkszag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029890; c=relaxed/simple;
	bh=TWmhlvIWxfUJ6FpEK14T98mwbqozPpRlHWEu0H3w9V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYRNb2pM3tny4N1dubpXlcHBnEO09tMIh/i6CiPJP4T+ZsoqkOeO5Bm7R3OpnD4kSVVQGHWPRUH+aY17ktUm3bcJH6xljTGbx7M2RpjHX4ufbT5GCkqA5lBQc8XDbqJvzduG47LQdm7gG8U+XQ/q/0iVzJVX9vbuqqHYnrFkbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TxkO2Kh7; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+0zMhTc6UmTn8nHcjcW7yaUfPpkltRIjpHMr/T4Ct9M=;
	b=TxkO2Kh7+KkFu3mUH40GrngtNucmX2IFrrX03WyLL4fZEFN/FJDFPd/qNBG9Zg
	NZpXTgv+TReQ9PjoMI90OxGKKM19FvexgtQlyDZWk+3uyWIJMiA2fWQc296rQNOD
	GXb/lFBnZRzcWgEsJyid8cr5t7NVyKhh4GxPj1cM7FUag=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnFdtOqthoBYWDBQ--.42004S3;
	Sun, 28 Sep 2025 11:24:00 +0800 (CST)
Date: Sun, 28 Sep 2025 11:23:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH v3 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
Message-ID: <aNiqTYZai83Yguqt@dragon>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
 <2264949.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2264949.irdbgypaU6@rafael.j.wysocki>
X-CM-TRANSID:Ms8vCgCnFdtOqthoBYWDBQ--.42004S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFyUZrW7ZF4DKrWUCw4DArb_yoWxtrWfpF
	WUXw42ya4kJa1qgw1Ikw48u34FvanrZ347Ka4j9wnYvrW7JFn0ga4qgay5tFZ8C34kAws0
	qFyqy347GF4UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URKZAUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxfWZWjYN8nd5wAAsb

On Fri, Sep 26, 2025 at 12:12:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
> transition_delay_us") caused platforms where cpuinfo.transition_latency
> is CPUFREQ_ETERNAL to get a very large transition latency whereas
> previously it had been capped at 10 ms (and later at 2 ms).
> 
> This led to a user-observable regression between 6.6 and 6.12 as
> described by Shawn:
> 
> "The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
>  6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
>  because the default transition delay was dropped [...].
> 
>  It slows down dbs governor's reacting to CPU loading change
>  dramatically.  Also, as transition_delay_us is used by schedutil
>  governor as rate_limit_us, it shows a negative impact on device
>  idle power consumption, because the device gets slightly less time
>  in the lowest OPP."
> 
> Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
> cpuinfo.transition_latency was that it would be capped by the core,
> but they may as well return a default transition latency value instead
> of CPUFREQ_ETERNAL and the core need not do anything with it.
> 
> Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
> all of the drivers in question use it instead of CPUFREQ_ETERNAL.  Also
> update the related Rust binding.
> 
> Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
> Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v3:
>    * Add updates of the Rust version of cpufreq-dt and Rust binding
>    * Update the changelog
>    * Add tags from Mario Limonciello and Jie Zhan
> 
> ---
>  drivers/cpufreq/cpufreq-dt.c          |    2 +-
>  drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
>  drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
>  drivers/cpufreq/rcpufreq_dt.rs        |    2 +-
>  drivers/cpufreq/scmi-cpufreq.c        |    2 +-
>  drivers/cpufreq/scpi-cpufreq.c        |    2 +-
>  drivers/cpufreq/spear-cpufreq.c       |    2 +-
>  include/linux/cpufreq.h               |    3 +++
>  rust/kernel/cpufreq.rs                |    7 ++++---
>  9 files changed, 14 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
>  
>  	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
>  	if (!transition_latency)
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	cpumask_copy(policy->cpus, priv->cpus);
>  	policy->driver_data = priv;
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -442,7 +442,7 @@ soc_opp_out:
>  	}
>  
>  	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	/*
>  	 * Calculate the ramp time for max voltage change in the
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
>  
>  	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  	policy->fast_switch_possible = true;
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -123,7 +123,7 @@ impl cpufreq::Driver for CPUFreqDTDriver
>  
>          let mut transition_latency = opp_table.max_transition_latency_ns() as u32;
>          if transition_latency == 0 {
> -            transition_latency = cpufreq::ETERNAL_LATENCY_NS;
> +            transition_latency = cpufreq::DEFAULT_TRANSITION_LATENCY_NS;
>          }
>  
>          policy
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
>  
>  	latency = perf_ops->transition_latency_get(ph, domain);
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
>  
>  	latency = scpi_ops->get_transition_latency(cpu_dev);
>  	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
>  
>  	if (of_property_read_u32(np, "clock-latency",
>  				&spear_cpufreq.transition_latency))
> -		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
> +		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
>  	if (cnt <= 0) {
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -32,6 +32,9 @@
>   */
>  
>  #define CPUFREQ_ETERNAL			(-1)
> +
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC

Typo of TANSITION, should be CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS.

Shawn

> +
>  #define CPUFREQ_NAME_LEN		16
>  /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>  #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -39,7 +39,8 @@ use macros::vtable;
>  const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
>  
>  /// Default transition latency value in nanoseconds.
> -pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
> +pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
> +        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
>  
>  /// CPU frequency driver flags.
>  pub mod flags {
> @@ -400,13 +401,13 @@ impl TableBuilder {
>  /// The following example demonstrates how to create a CPU frequency table.
>  ///
>  /// ```
> -/// use kernel::cpufreq::{ETERNAL_LATENCY_NS, Policy};
> +/// use kernel::cpufreq::{DEFAULT_TRANSITION_LATENCY_NS, Policy};
>  ///
>  /// fn update_policy(policy: &mut Policy) {
>  ///     policy
>  ///         .set_dvfs_possible_from_any_cpu(true)
>  ///         .set_fast_switch_possible(true)
> -///         .set_transition_latency_ns(ETERNAL_LATENCY_NS);
> +///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
>  ///
>  ///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
>  /// }
> 
> 
> 


