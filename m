Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369C31C52B
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 02:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBPBuo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 20:50:44 -0500
Received: from rome.phoronix.com ([192.211.48.82]:18312 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBPBuP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 20:50:15 -0500
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:38846 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@phoronix.com>)
        id 1lBpUM-0002Wb-Ek; Mon, 15 Feb 2021 20:49:18 -0500
Subject: Re: [RFT][PATCH v1] cpufreq: ACPI: Set cpuinfo.max_freq directly if
 max boost is known
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1974978.nRy8TqEeLZ@kreacher>
From:   Michael Larabel <Michael@phoronix.com>
Message-ID: <5eefbda4-5135-c445-1b9d-a35dc2bec9e1@phoronix.com>
Date:   Mon, 15 Feb 2021 19:49:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1974978.nRy8TqEeLZ@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - phoronix.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@phoronix.com
X-Authenticated-Sender: rome.phoronix.com: michael@phoronix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2/15/21 1:24 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> boost frequencies") attempted to address a performance issue involving
> acpi-cpufreq, the schedutil governor and scale-invariance on x86 by
> extending the frequency tables created by acpi-cpufreq to cover the
> entire range of "turbo" (or "boost") frequencies, but that caused
> frequencies reported via /proc/cpuinfo and the scaling_cur_freq
> attribute in sysfs to change which may confuse users and monitoring
> tools.
>
> For this reason, revert the part of commit 3c55e94c0ade adding the
> extra entry to the frequency table and use the observation that
> in principle cpuinfo.max_freq need not be equal to the maximum
> frequency listed in the frequency table for the given policy.
>
> Namely, modify cpufreq_frequency_table_cpuinfo() to allow cpufreq
> drivers to set their own cpuinfo.max_freq above that frequency and
> change  acpi-cpufreq to set cpuinfo.max_freq to the maximum boost
> frequency found via CPPC.
>
> This should be sufficient to let all of the cpufreq subsystem know
> the real maximum frequency of the CPU without changing frequency
> reporting.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=211305
> Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> Reported-by: Matt McDonald <gardotd426@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Michael, Giovanni,
>
> The fix for the EPYC performance regression that was merged into 5.11 introduced
> an undesirable side-effect by distorting the CPU frequency reporting via
> /proc/cpuinfo and scaling_cur_freq (see the BZ link above for details).
>
> The patch below is reported to address this problem and it should still allow
> schedutil to achieve desirable performance, because it simply sets
> cpuinfo.max_freq without extending the frequency table of the CPU.
>
> Please test this one and let me know if it adversely affects performance.
>
> Thanks!


When carrying out tests so far today on an EPYC 7F72 2P and Ryzen 9 
5900X with workloads seeing impact from the prior patches, everything is 
looking good when comparing v5.11 to v5.11 + this patch. Not seeing any 
measurable difference on either of those systems as a result of this patch.

Running some additional tests and on a few more boxes that should wrap 
up tomorrow but at least so far the patch isn't showing any measurable 
changes to performance.

Michael


>
> ---
>   drivers/cpufreq/acpi-cpufreq.c |   62 ++++++++++-------------------------------
>   drivers/cpufreq/freq_table.c   |    8 ++++-
>   2 files changed, 23 insertions(+), 47 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -54,7 +54,6 @@ struct acpi_cpufreq_data {
>   	unsigned int resume;
>   	unsigned int cpu_feature;
>   	unsigned int acpi_perf_cpu;
> -	unsigned int first_perf_state;
>   	cpumask_var_t freqdomain_cpus;
>   	void (*cpu_freq_write)(struct acpi_pct_register *reg, u32 val);
>   	u32 (*cpu_freq_read)(struct acpi_pct_register *reg);
> @@ -223,10 +222,10 @@ static unsigned extract_msr(struct cpufr
>   
>   	perf = to_perf_data(data);
>   
> -	cpufreq_for_each_entry(pos, policy->freq_table + data->first_perf_state)
> +	cpufreq_for_each_entry(pos, policy->freq_table)
>   		if (msr == perf->states[pos->driver_data].status)
>   			return pos->frequency;
> -	return policy->freq_table[data->first_perf_state].frequency;
> +	return policy->freq_table[0].frequency;
>   }
>   
>   static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
> @@ -365,7 +364,6 @@ static unsigned int get_cur_freq_on_cpu(
>   	struct cpufreq_policy *policy;
>   	unsigned int freq;
>   	unsigned int cached_freq;
> -	unsigned int state;
>   
>   	pr_debug("%s (%d)\n", __func__, cpu);
>   
> @@ -377,11 +375,7 @@ static unsigned int get_cur_freq_on_cpu(
>   	if (unlikely(!data || !policy->freq_table))
>   		return 0;
>   
> -	state = to_perf_data(data)->state;
> -	if (state < data->first_perf_state)
> -		state = data->first_perf_state;
> -
> -	cached_freq = policy->freq_table[state].frequency;
> +	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
>   	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
>   	if (freq != cached_freq) {
>   		/*
> @@ -680,7 +674,6 @@ static int acpi_cpufreq_cpu_init(struct
>   	struct cpuinfo_x86 *c = &cpu_data(cpu);
>   	unsigned int valid_states = 0;
>   	unsigned int result = 0;
> -	unsigned int state_count;
>   	u64 max_boost_ratio;
>   	unsigned int i;
>   #ifdef CONFIG_SMP
> @@ -795,28 +788,8 @@ static int acpi_cpufreq_cpu_init(struct
>   		goto err_unreg;
>   	}
>   
> -	state_count = perf->state_count + 1;
> -
> -	max_boost_ratio = get_max_boost_ratio(cpu);
> -	if (max_boost_ratio) {
> -		/*
> -		 * Make a room for one more entry to represent the highest
> -		 * available "boost" frequency.
> -		 */
> -		state_count++;
> -		valid_states++;
> -		data->first_perf_state = valid_states;
> -	} else {
> -		/*
> -		 * If the maximum "boost" frequency is unknown, ask the arch
> -		 * scale-invariance code to use the "nominal" performance for
> -		 * CPU utilization scaling so as to prevent the schedutil
> -		 * governor from selecting inadequate CPU frequencies.
> -		 */
> -		arch_set_max_freq_ratio(true);
> -	}
> -
> -	freq_table = kcalloc(state_count, sizeof(*freq_table), GFP_KERNEL);
> +	freq_table = kcalloc(perf->state_count + 1, sizeof(*freq_table),
> +			     GFP_KERNEL);
>   	if (!freq_table) {
>   		result = -ENOMEM;
>   		goto err_unreg;
> @@ -851,27 +824,25 @@ static int acpi_cpufreq_cpu_init(struct
>   	}
>   	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
>   
> +	max_boost_ratio = get_max_boost_ratio(cpu);
>   	if (max_boost_ratio) {
> -		unsigned int state = data->first_perf_state;
> -		unsigned int freq = freq_table[state].frequency;
> +		unsigned int freq = freq_table[0].frequency;
>   
>   		/*
>   		 * Because the loop above sorts the freq_table entries in the
>   		 * descending order, freq is the maximum frequency in the table.
>   		 * Assume that it corresponds to the CPPC nominal frequency and
> -		 * use it to populate the frequency field of the extra "boost"
> -		 * frequency entry.
> +		 * use it to set cpuinfo.max_freq.
>   		 */
> -		freq_table[0].frequency = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
> +		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
> +	} else {
>   		/*
> -		 * The purpose of the extra "boost" frequency entry is to make
> -		 * the rest of cpufreq aware of the real maximum frequency, but
> -		 * the way to request it is the same as for the first_perf_state
> -		 * entry that is expected to cover the entire range of "boost"
> -		 * frequencies of the CPU, so copy the driver_data value from
> -		 * that entry.
> +		 * If the maximum "boost" frequency is unknown, ask the arch
> +		 * scale-invariance code to use the "nominal" performance for
> +		 * CPU utilization scaling so as to prevent the schedutil
> +		 * governor from selecting inadequate CPU frequencies.
>   		 */
> -		freq_table[0].driver_data = freq_table[state].driver_data;
> +		arch_set_max_freq_ratio(true);
>   	}
>   
>   	policy->freq_table = freq_table;
> @@ -947,8 +918,7 @@ static void acpi_cpufreq_cpu_ready(struc
>   {
>   	struct acpi_processor_performance *perf = per_cpu_ptr(acpi_perf_data,
>   							      policy->cpu);
> -	struct acpi_cpufreq_data *data = policy->driver_data;
> -	unsigned int freq = policy->freq_table[data->first_perf_state].frequency;
> +	unsigned int freq = policy->freq_table[0].frequency;
>   
>   	if (perf->states[0].core_frequency * 1000 != freq)
>   		pr_warn(FW_WARN "P-state 0 is not max freq\n");
> Index: linux-pm/drivers/cpufreq/freq_table.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/freq_table.c
> +++ linux-pm/drivers/cpufreq/freq_table.c
> @@ -52,7 +52,13 @@ int cpufreq_frequency_table_cpuinfo(stru
>   	}
>   
>   	policy->min = policy->cpuinfo.min_freq = min_freq;
> -	policy->max = policy->cpuinfo.max_freq = max_freq;
> +	policy->max = max_freq;
> +	/*
> +	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
> +	 * it as is.
> +	 */
> +	if (policy->cpuinfo.max_freq < max_freq)
> +		policy->max = policy->cpuinfo.max_freq = max_freq;
>   
>   	if (policy->min == ~0)
>   		return -EINVAL;
>
>
>
