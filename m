Return-Path: <linux-acpi+bounces-1320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C17E3E7E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC81C20492
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96130CE1
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8DR9XQV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F927171D1
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 10:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2C9C433C7;
	Tue,  7 Nov 2023 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699353497;
	bh=vJRAI9RGy/58A+FlzWE10PI0MfMhXjXb/jXWE3sfgoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8DR9XQVqGWE/jSsPbBMbBE96MY+i3o2DaeBsP5f6BDjvx/DOhiZNZZkcqIWdiFKJ
	 TQMPoAXJ0x2TtXE67Y62VjspTbRGAOufa4CRGNzTRwseWqPxAx2JnJvge/Pd8SFd/C
	 652UC6kbexqs2g1LA//blK+R2I/ceR0tGVIZOvphJyLJCKGKy/GV+1hSXjmqkt/xhR
	 QmDw9YouENrjpbSlFvRNGZ4uqm5R6SOn8pBYci5FtRJOl5X53LgfZP6jDSFRzvsNRb
	 AqCng9dzoPE8U7OlzHAE3pB05STFWs0eE49/RyTVp5RDEpT6znfC9+1yYkxANs1vFN
	 9OLw0jdWTTD0A==
Date: Tue, 7 Nov 2023 10:38:09 +0000
From: Will Deacon <will@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, beata.michalska@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v5 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
Message-ID: <20231107103808.GF18944@willie-the-truck>
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
 <20231104105907.1365392-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104105907.1365392-8-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 04, 2023 at 11:59:07AM +0100, Vincent Guittot wrote:
> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> computing the arch_scale_freq_capacity().
> This helps to keep everything aligned using the same reference for
> computing CPUs capacity.
> 
> The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
> ensures that arch_scale_freq_capacity() returns max capacity until it is
> set to its correct value with the cpu capacity and capacity_ref_freq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm64/kernel/topology.c  | 26 ++++++++++++++------------
>  drivers/base/arch_topology.c  | 12 +++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 817d788cd866..615c1a20129f 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
>  #undef pr_fmt
>  #define pr_fmt(fmt) "AMU: " fmt
>  
> -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> +/*
> + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
> + * the CPU capacity and its associated frequency have been correctly
> + * initialized.
> + */
> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);

This doesn't seem to match the comment? SCHED_CAPACITY_SCALE doesn't have
the '2 *' multiplier.

>  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>  static cpumask_var_t amu_fie_cpus;
> @@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cpu)
>  	return true;
>  }
>  
> -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> +void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>  {
> -	u64 ratio;
> +	u64 ratio, ref_rate = arch_timer_get_rate();
>  
>  	if (unlikely(!max_rate || !ref_rate)) {
> -		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
> +		WARN_ONCE(1, "CPU%d: invalid maximum or reference frequency.\n",
>  			 cpu);
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	/*
> @@ -139,12 +144,12 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
>  	ratio = div64_u64(ratio, max_rate);
>  	if (!ratio) {
>  		WARN_ONCE(1, "Reference frequency too low.\n");
> -		return -EINVAL;
> +		return;
>  	}
>  
> -	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> +	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);

Why is WRITE_ONCE() now needed?

> -	return 0;
> +	return;

Pointless 'return;' statement.

Will

