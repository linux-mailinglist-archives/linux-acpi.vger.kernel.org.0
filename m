Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B905310574
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 08:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBEHIZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 02:08:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:41556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhBEHIU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Feb 2021 02:08:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D16EACBA;
        Fri,  5 Feb 2021 07:07:38 +0000 (UTC)
Message-ID: <1612508857.19825.7.camel@suse.cz>
Subject: Re: [PATCH v1 2/2] cpufreq: ACPI: Update arch scale-invariance max
 perf ratio if CPPC is not there
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Larabel <Michael@phoronix.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 05 Feb 2021 08:07:37 +0100
In-Reply-To: <9510730.kuOQ4KzHjt@kreacher>
References: <13690581.X0sz4iL7V8@kreacher> <9510730.kuOQ4KzHjt@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-02-04 at 18:34 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the maximum performance level taken for computing the
> arch_max_freq_ratio value used in the x86 scale-invariance code is
> higher than the one corresponding to the cpuinfo.max_freq value
> coming from the acpi_cpufreq driver, the scale-invariant utilization
> falls below 100% even if the CPU runs at cpuinfo.max_freq or slightly
> faster, which causes the schedutil governor to select a frequency
> below cpuinfo.max_freq.  That frequency corresponds to a frequency
> table entry below the maximum performance level necessary to get to
> the "boost" range of CPU frequencies which prevents "boost"
> frequencies from being used in some workloads.
> 
> While this issue is related to scale-invariance, it may be amplified
> by commit db865272d9c4 ("cpufreq: Avoid configuring old governors as
> default with intel_pstate") from the 5.10 development cycle which
> made it extremely easy to default to schedutil even if the preferred
> driver is acpi_cpufreq as long as intel_pstate is built too, because
> the mere presence of the latter effectively removes the ondemand
> governor from the defaults.  Distro kernels are likely to include
> both intel_pstate and acpi_cpufreq on x86, so their users who cannot
> use intel_pstate or choose to use acpi_cpufreq may easily be
> affectecd by this issue.
> 
> If CPPC is available, it can be used to address this issue by
> extending the frequency tables created by acpi_cpufreq to cover the
> entire available frequency range (including "boost" frequencies) for
> each CPU, but if CPPC is not there, acpi_cpufreq has no idea what
> the maximum "boost" frequency is and the frequency tables created by
> it cannot be extended in a meaningful way, so in that case make it
> ask the arch scale-invariance code to to use the "nominal" performance
> level for CPU utilization scaling in order to avoid the issue at hand.
> 
> Fixes: db865272d9c4 ("cpufreq: Avoid configuring old governors as default with intel_pstate")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/smpboot.c      |    1 +
>  drivers/cpufreq/acpi-cpufreq.c |    8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -806,6 +806,14 @@ static int acpi_cpufreq_cpu_init(struct
>  		state_count++;
>  		valid_states++;
>  		data->first_perf_state = valid_states;
> +	} else {
> +		/*
> +		 * If the maximum "boost" frequency is unknown, ask the arch
> +		 * scale-invariance code to use the "nominal" performance for
> +		 * CPU utilization scaling so as to prevent the schedutil
> +		 * governor from selecting inadequate CPU frequencies.
> +		 */
> +		arch_set_max_freq_ratio(true);
>  	}
>  
>  	freq_table = kcalloc(state_count, sizeof(*freq_table), GFP_KERNEL);
> Index: linux-pm/arch/x86/kernel/smpboot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/smpboot.c
> +++ linux-pm/arch/x86/kernel/smpboot.c
> @@ -1833,6 +1833,7 @@ void arch_set_max_freq_ratio(bool turbo_
>  	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
>  					arch_turbo_freq_ratio;
>  }
> +EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
>  
>  static bool turbo_disabled(void)
>  {

Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>

Thanks,
Giovanni
