Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3130E771
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 00:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhBCXgo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 18:36:44 -0500
Received: from rome.phoronix.com ([192.211.48.82]:44970 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhBCXgm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 18:36:42 -0500
Received: from c-73-176-63-28.hsd1.il.comcast.net ([73.176.63.28]:37276 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@phoronix.com>)
        id 1l7RgP-0002T9-IL; Wed, 03 Feb 2021 18:35:37 -0500
Subject: Re: [PATCH v3 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210203135321.12253-1-ggherdovich@suse.cz>
 <20210203135321.12253-2-ggherdovich@suse.cz>
 <CAJZ5v0g1SWRnV1QfZG3o+hvBg9akakhDMomGCFjwERyG2ENKww@mail.gmail.com>
 <5470319.60Xv9dOaFs@kreacher>
From:   Michael Larabel <Michael@phoronix.com>
Message-ID: <563fec57-6417-e875-1788-3773cbfb34be@phoronix.com>
Date:   Wed, 3 Feb 2021 17:35:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5470319.60Xv9dOaFs@kreacher>
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

On 2/3/21 12:25 PM, Rafael J. Wysocki wrote:
> On Wednesday, February 3, 2021 3:11:37 PM CET Rafael J. Wysocki wrote:
>> On Wed, Feb 3, 2021 at 2:53 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>> [cut]
>>
>>> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
>>> Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
>>> Reported-by: Michael Larabel <Michael@phoronix.com>
>>> Tested-by: Michael Larabel <Michael@phoronix.com>
>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>> ---
>>>   drivers/cpufreq/acpi-cpufreq.c   | 61 ++++++++++++++++++++++++++++++--
>>>   drivers/cpufreq/cpufreq.c        |  3 ++
>>>   include/linux/cpufreq.h          |  5 +++
>>>   kernel/sched/cpufreq_schedutil.c |  8 +++--
>> I don't really think that it is necessary to modify schedutil to
>> address this issue.
> So below is a prototype of an alternative fix for the issue at hand.
>
> I can't really test it here, because there's no _CPC in the ACPI tables of my
> test machines, so testing it would be appreciated.  However, AFAICS these
> machines are affected by the performance issue related to the scale-invariance
> when they are running acpi-cpufreq, so what we are doing here is not entirely
> sufficient.


I have benchmarks running on several Ryzen and EPYC systems with this 
patch. The full batch of tests won't be done until tomorrow, but in 
looking at the data so far from an AMD EPYC 7F72 2P server over the past 
few hours, this patch does provide fairly comparable numbers to 
Giovanni's patch. There were a few outliers so far but waiting to see 
with the complete set of results. At the very least it's clear enough 
already this new patch is at least an improvement over the current 5.11 
upstream state with schedutil on AMD.

Michael


>
> It looks like the scale-invariance code should ask the cpufreq driver about
> the maximum frequency and note that cpufreq drivers may be changed on the
> fly.
>
> What the patch below does is to add an extra entry to the frequency table for
> each CPU to represent the maximum "boost" frequency, so as to cause that
> frequency to be used as cpuinfo.max_freq.
>
> The reason why I think it is better to extend the frequency tables instead
> of simply increasing the frequency for the "P0" entry is because the latter
> may cause "turbo" frequency to be asked for less often.
>
> ---
>   drivers/cpufreq/acpi-cpufreq.c |  107 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 95 insertions(+), 12 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -26,6 +26,7 @@
>   #include <linux/uaccess.h>
>   
>   #include <acpi/processor.h>
> +#include <acpi/cppc_acpi.h>
>   
>   #include <asm/msr.h>
>   #include <asm/processor.h>
> @@ -53,6 +54,7 @@ struct acpi_cpufreq_data {
>   	unsigned int resume;
>   	unsigned int cpu_feature;
>   	unsigned int acpi_perf_cpu;
> +	unsigned int first_perf_state;
>   	cpumask_var_t freqdomain_cpus;
>   	void (*cpu_freq_write)(struct acpi_pct_register *reg, u32 val);
>   	u32 (*cpu_freq_read)(struct acpi_pct_register *reg);
> @@ -221,10 +223,10 @@ static unsigned extract_msr(struct cpufr
>   
>   	perf = to_perf_data(data);
>   
> -	cpufreq_for_each_entry(pos, policy->freq_table)
> +	cpufreq_for_each_entry(pos, policy->freq_table + data->first_perf_state)
>   		if (msr == perf->states[pos->driver_data].status)
>   			return pos->frequency;
> -	return policy->freq_table[0].frequency;
> +	return policy->freq_table[data->first_perf_state].frequency;
>   }
>   
>   static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
> @@ -363,6 +365,7 @@ static unsigned int get_cur_freq_on_cpu(
>   	struct cpufreq_policy *policy;
>   	unsigned int freq;
>   	unsigned int cached_freq;
> +	unsigned int state;
>   
>   	pr_debug("%s (%d)\n", __func__, cpu);
>   
> @@ -374,7 +377,11 @@ static unsigned int get_cur_freq_on_cpu(
>   	if (unlikely(!data || !policy->freq_table))
>   		return 0;
>   
> -	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
> +	state = to_perf_data(data)->state;
> +	if (state < data->first_perf_state)
> +		state = data->first_perf_state;
> +
> +	cached_freq = policy->freq_table[state].frequency;
>   	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
>   	if (freq != cached_freq) {
>   		/*
> @@ -628,16 +635,54 @@ static int acpi_cpufreq_blacklist(struct
>   }
>   #endif
>   
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static u64 get_max_boost_ratio(unsigned int cpu)
> +{
> +	struct cppc_perf_caps perf_caps;
> +	u64 highest_perf, nominal_perf;
> +	int ret;
> +
> +	if (acpi_pstate_strict)
> +		return 0;
> +
> +	ret = cppc_get_perf_caps(cpu, &perf_caps);
> +	if (ret) {
> +		pr_debug("CPU%d: Unable to get performance capabilities (%d)\n",
> +			 cpu, ret);
> +		return 0;
> +	}
> +
> +	highest_perf = perf_caps.highest_perf;
> +	nominal_perf = perf_caps.nominal_perf;
> +
> +	if (!highest_perf || !nominal_perf) {
> +		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
> +		return 0;
> +	}
> +
> +	if (highest_perf < nominal_perf) {
> +		pr_debug("CPU%d: nominal performance above highest\n", cpu);
> +		return 0;
> +	}
> +
> +	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> +}
> +#else
> +static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
> +#endif
> +
>   static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   {
> -	unsigned int i;
> -	unsigned int valid_states = 0;
> -	unsigned int cpu = policy->cpu;
> +	struct cpufreq_frequency_table *freq_table;
> +	struct acpi_processor_performance *perf;
>   	struct acpi_cpufreq_data *data;
> +	unsigned int cpu = policy->cpu;
> +	struct cpuinfo_x86 *c = &cpu_data(cpu);
> +	unsigned int valid_states = 0;
>   	unsigned int result = 0;
> -	struct cpuinfo_x86 *c = &cpu_data(policy->cpu);
> -	struct acpi_processor_performance *perf;
> -	struct cpufreq_frequency_table *freq_table;
> +	unsigned int state_count;
> +	u64 max_boost_ratio;
> +	unsigned int i;
>   #ifdef CONFIG_SMP
>   	static int blacklisted;
>   #endif
> @@ -750,8 +795,20 @@ static int acpi_cpufreq_cpu_init(struct
>   		goto err_unreg;
>   	}
>   
> -	freq_table = kcalloc(perf->state_count + 1, sizeof(*freq_table),
> -			     GFP_KERNEL);
> +	state_count = perf->state_count + 1;
> +
> +	max_boost_ratio = get_max_boost_ratio(cpu);
> +	if (max_boost_ratio) {
> +		/*
> +		 * Make a room for one more entry to represent the highest
> +		 * available "boost" frequency.
> +		 */
> +		state_count++;
> +		valid_states++;
> +		data->first_perf_state = valid_states;
> +	}
> +
> +	freq_table = kcalloc(state_count, sizeof(*freq_table), GFP_KERNEL);
>   	if (!freq_table) {
>   		result = -ENOMEM;
>   		goto err_unreg;
> @@ -785,6 +842,30 @@ static int acpi_cpufreq_cpu_init(struct
>   		valid_states++;
>   	}
>   	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> +
> +	if (max_boost_ratio) {
> +		unsigned int state = data->first_perf_state;
> +		unsigned int freq = freq_table[state].frequency;
> +
> +		/*
> +		 * Because the loop above sorts the freq_table entries in the
> +		 * descending order, freq is the maximum frequency in the table.
> +		 * Assume that it corresponds to the CPPC nominal frequency and
> +		 * use it to populate the frequency field of the extra "boost"
> +		 * frequency entry.
> +		 */
> +		freq_table[0].frequency = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
> +		/*
> +		 * The purpose of the extra "boost" frequency entry is to make
> +		 * the rest of cpufreq aware of the real maximum frequency, but
> +		 * the way to request it is the same as for the first_perf_state
> +		 * entry that is expected to cover the entire range of "boost"
> +		 * frequencies of the CPU, so copy the driver_data value from
> +		 * that entry.
> +		 */
> +		freq_table[0].driver_data = freq_table[state].driver_data;
> +	}
> +
>   	policy->freq_table = freq_table;
>   	perf->state = 0;
>   
> @@ -858,8 +939,10 @@ static void acpi_cpufreq_cpu_ready(struc
>   {
>   	struct acpi_processor_performance *perf = per_cpu_ptr(acpi_perf_data,
>   							      policy->cpu);
> +	struct acpi_cpufreq_data *data = policy->driver_data;
> +	unsigned int freq = policy->freq_table[data->first_perf_state].frequency;
>   
> -	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
> +	if (perf->states[0].core_frequency * 1000 != freq)
>   		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>   }
>   
>
>
>
