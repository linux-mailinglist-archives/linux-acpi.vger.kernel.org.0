Return-Path: <linux-acpi+bounces-16300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C77B40E17
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CA21B654E8
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61135084D;
	Tue,  2 Sep 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM21A8Eq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF707342CA5;
	Tue,  2 Sep 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842492; cv=none; b=Olsc74HPWy+DX5SN8LupJf2Q7R8rRdynvWw1+PLH1WBfNWgSdctu8bFj+bj8iczBtqIFcc2N3f4oTAS5Xbi4tQdPMHjtQc+j1W8nEp7X8ghXS0XkIAyYWeOU9qEn5gopogbzWDlXT2aG7x4ZlBZxGXJSRGra7R1cYHKQPnT94Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842492; c=relaxed/simple;
	bh=zpo0LfmwxyVWeY+SLgON3XGbp12XD/VDfJvwqrln8kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+nN7DWDvnN2gbtC3FFibE5ZJ/dYy1ar2EV8fNpQQj2+Rjr5TTeC/IgFMbHjx2zx9qkU1kPpx8gAWyx120Yer1g3bpntjldcC0hJ/pmX0T9rJzYBlSqWGT16K46eHU9El07+ZKFZ2TRxNBGaL6eazVQzUMIFLFcxaqQ+Ej23IuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM21A8Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353B0C4CEED;
	Tue,  2 Sep 2025 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756842491;
	bh=zpo0LfmwxyVWeY+SLgON3XGbp12XD/VDfJvwqrln8kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DM21A8EqyRTJsduYnMXLa+1Ki4G/laXH+KbDq2ncmjw/z/tUhbquM8fsLgzuW/HU1
	 wwJOYjmlhl0Qc3nW8LFcex/d02WMKEAqwR8tmwu/U5/kqp0P0hLDRuqluFsAmUnZ6K
	 /Ghw87c20Tqm9I0mOCgXJu77E/wQnrrm0O4GXwREwm2+eHQVAABDkBukPKgxNFz+g2
	 QVqANSUeq1WgJ8kKWKSd0cNbpfWUKTUmLQBcaADA33N1AcB0PbnAz5zRCPPk9Jr8tl
	 LP4u5TKMjU2DJHD1rjMLYGO3eQ0v2GHvA1C5exEp3L9UF6HrVkXJwecMcGnvsc6WO0
	 1muNtpfiBlSng==
Message-ID: <64a744bd-0f62-498b-8886-a5338fd8410c@kernel.org>
Date: Tue, 2 Sep 2025 14:48:06 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
 <507095d6-512a-4561-bc90-12a34a43302a@amd.com>
 <30b46202-d377-4455-9551-5874e1e9f104@nvidia.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <30b46202-d377-4455-9551-5874e1e9f104@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/2025 8:37 AM, Sumit Gupta wrote:
> 
> On 26/08/25 00:10, Mario Limonciello wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/23/2025 3:01 PM, Sumit Gupta wrote:
>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>> autonomous performance selection at system startup. When autonomous mode
>>> is enabled, the hardware automatically adjusts CPU performance based on
>>> workload demands using Energy Performance Preference (EPP) hints from
>>> the OS.
>>>
>>> This parameter allows to configure the autonomous mode on all CPUs
>>> without requiring runtime sysfs manipulation if the 'auto_sel' register
>>> is present.
>>>
>>> When auto_sel_mode=1:
>>> - All CPUs are configured for autonomous operation during driver init
>>> - EPP is set to performance preference (0x0) by default
>>> - Min/max performance bounds use defaults
>>> - CPU frequency scaling is handled by hardware rather than OS
>>>
>>> Also ensure that when autonomous mode is active, the set_target callback
>>> returns early since hardware controls frequency scaling directly.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
>>>   2 files changed, 168 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ 
>>> Documentation/admin-guide/kernel-parameters.txt
>>> index 86f395f2933b..ea58deb88c36 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -911,6 +911,18 @@
>>>                       Format:
>>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>>
>>> +     cppc_cpufreq.auto_sel_mode=
>>> +                     [CPU_FREQ] Autonomous Performance Level Selection.
>>> +                     When Autonomous selection is enabled, then the 
>>> hardware is
>>> +                     allowed to autonomously select the CPU frequency.
>>> +                     In Autonomous mode, Energy Performance 
>>> Preference(EPP)
>>> +                     provides input to the hardware to favour 
>>> performance (0x0)
>>> +                     or energy efficiency (0xff).
>>> +                     Format: <bool>
>>> +                     Default: disabled.
>>> +                     0: force disabled
>>> +                     1: force enabled
>>
>> I don't think you can actually force enable.  If the hardware doesn't
>> support it, setting 1 won't do anything.
>>
>> IoW really setting 1 is "enable if supported".
>>
> 
> Yes, will change in v3.
> 
> 
>>> +
>>>       cpuidle.off=1   [CPU_IDLE]
>>>                       disable the cpuidle sub-system
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/ 
>>> cppc_cpufreq.c
>>> index 5e1bbb5f67b8..bbf654c56ff9 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -27,6 +27,8 @@
>>>   #include <acpi/cppc_acpi.h>
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>> +/* Autonomous Selection */
>>> +static bool auto_sel_mode;
>>>
>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>   static enum {
>>> @@ -272,6 +274,14 @@ static int cppc_cpufreq_set_target(struct 
>>> cpufreq_policy *policy,
>>>       freqs.old = policy->cur;
>>>       freqs.new = target_freq;
>>>
>>> +     /*
>>> +      * In autonomous mode, hardware handles frequency scaling directly
>>> +      * based on workload demands and EPP hints, so OS frequency 
>>> requests
>>> +      * are not needed.
>>> +      */
>>> +     if (cpu_data->perf_caps.auto_sel)
>>> +             return ret;
>>> +
>>>       cpufreq_freq_transition_begin(policy, &freqs);
>>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>> @@ -555,6 +565,12 @@ static struct cppc_cpudata 
>>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>               goto free_mask;
>>>       }
>>>
>>> +     ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>> +     if (ret) {
>>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, 
>>> ret);
>>> +             goto free_mask;
>>> +     }
>>> +
>>>       return cpu_data;
>>>
>>>   free_mask:
>>> @@ -642,6 +658,79 @@ static int cppc_cpufreq_set_max_perf(struct 
>>> cpufreq_policy *policy, u64 val,
>>>       return (ret == -EOPNOTSUPP) ? 0 : ret;
>>>   }
>>>
>>> +static int cppc_cpufreq_update_autosel_epp(struct cpufreq_policy 
>>> *policy, int auto_sel, u32 epp)
>>> +{
>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>> +     unsigned int cpu = policy->cpu;
>>> +     int ret;
>>> +
>>> +     pr_debug("cpu%d: curr epp:%u, curr mode:%u, new epp:%u, new 
>>> mode:%d\n", cpu,
>>> +              cpu_data->perf_ctrls.energy_perf, cpu_data- 
>>> >perf_caps.auto_sel, epp, auto_sel);
>>> +
>>> +     mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
>>
>> As I noticed below a case you missed the mutex unlock, this feels like a
>> good candidate for
>>
>> guard(mutex)();
>>
> 
> I will check about 'guard(mutex)()' and change accordingly in v3.
> 
>>> +
>>> +     ret = cppc_set_epp(cpu, epp);
>>> +     if (ret) {
>>> +             pr_warn("failed to set energy_perf for cpu:%d (%d)\n", 
>>> cpu, ret);
>>> +             goto out;
>>> +     }
>>> +     cpu_data->perf_ctrls.energy_perf = epp;
>>> +
>>> +     ret = cppc_set_auto_sel(cpu, auto_sel);
>>> +     if (ret) {
>>> +             pr_warn("failed to set auto_sel for cpu:%d (%d)\n", 
>>> cpu, ret);
>>> +             return ret;
>>
>> Looks like a case that you didn't unlock the mutex.
> 
> ACK.
> 
>>
>>> +     }
>>> +     cpu_data->perf_caps.auto_sel = auto_sel;
>>> +
>>> +out:
>>> + mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
>>> +     return ret;
>>> +}
>>> +
>>> +static int cppc_cpufreq_update_autosel_mperf_ctrls(struct 
>>> cpufreq_policy *policy, u32 min_p,
>>> +                                                u32 max_p, bool 
>>> update_reg, bool update_policy)
>>> +{
>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>> +     unsigned int cpu = policy->cpu;
>>> +     int ret;
>>> +
>>> +     pr_debug("cpu%d: curr max_perf:%u, curr min_perf:%u, new 
>>> max_perf:%u, new min_perf:%u\n",
>>> +              cpu, cpu_data->perf_ctrls.max_perf, cpu_data- 
>>> >perf_ctrls.min_perf, max_p, min_p);
>>> +
>>> +     ret = cppc_cpufreq_set_min_perf(policy, min_p, update_reg, 
>>> update_policy);
>>> +     if (ret) {
>>> +             pr_debug("failed to set min_perf for cpu:%d (%d)\n", 
>>> cpu, ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = cppc_cpufreq_set_max_perf(policy, max_p, update_reg, 
>>> update_policy);
>>> +     if (ret) {
>>> +             pr_debug("failed to set max_perf for cpu:%d (%d)\n", 
>>> cpu, ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int cppc_cpufreq_update_autosel_configs(struct cpufreq_policy 
>>> *policy, int auto_sel,
>>> +                                            u32 epp, u32 min_perf, 
>>> u32 max_perf,
>>> +                                            bool update_reg, bool 
>>> update_policy)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, 
>>> max_perf,
>>> +                                                   update_reg, 
>>> update_policy);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = cppc_cpufreq_update_autosel_epp(policy, auto_sel, epp);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>   {
>>>       unsigned int cpu = policy->cpu;
>>> @@ -710,11 +799,28 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>
>>> -     ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>> -     if (ret) {
>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -                      caps->highest_perf, cpu, ret);
>>> -             goto out;
>>> +     if (cpu_data->perf_caps.auto_sel) {
>>> +             ret = cppc_set_enable(cpu, true);
>>> +             if (ret) {
>>> +                     pr_err("Failed to enable CPPC on cpu%d (%d)\n", 
>>> cpu, ret);
>>> +                     goto out;
>>> +             }
>>> +
>>> +             ret = cppc_cpufreq_update_autosel_configs(policy, true,
>>> + CPPC_EPP_PERFORMANCE_PREF,
>>> + caps->lowest_nonlinear_perf,
>>> + caps->nominal_perf, true, false);
>>> +             if (ret) {
>>> +                     pr_debug("Failed to update autosel configs on 
>>> CPU%d(%d)\n", cpu, ret);
>>> +                     goto out;
>>> +             }
>>> +     } else {
>>> +             ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret) {
>>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>>> ret:%d\n",
>>> +                              caps->highest_perf, cpu, ret);
>>> +                     goto out;
>>> +             }
>>>       }
>>>
>>>       cppc_cpufreq_cpu_fie_init(policy);
>>> @@ -736,6 +842,13 @@ static void cppc_cpufreq_cpu_exit(struct 
>>> cpufreq_policy *policy)
>>>
>>>       cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
>>>
>>> +     if (cpu_data->perf_caps.auto_sel) {
>>> +             ret = cppc_cpufreq_update_autosel_epp(policy, false,
>>> + CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>>> +             if (ret)
>>> +                     return;
>>> +     }
>>> +
>>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>       if (ret)
>>>               pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> @@ -920,17 +1033,10 @@ static ssize_t store_auto_select(struct 
>>> cpufreq_policy *policy,
>>>        * On enabling auto_select: set min/max_perf register and 
>>> update policy.
>>>        * On disabling auto_select: update only policy.
>>>        */
>>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg, 
>>> true);
>>> -     if (ret) {
>>> -             pr_warn("failed to %s update min policy for cpu:%d 
>>> (%d)\n",
>>> -                     val > 0 ? "set min_perf and" : "", cpu, ret);
>>> -             return ret;
>>> -     }
>>> -
>>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg, 
>>> true);
>>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, 
>>> max_perf, update_reg, true);
>>>       if (ret) {
>>> -             pr_warn("failed to %s update max policy for cpu:%d 
>>> (%d)\n",
>>> -                     val > 0 ? "set max_perf and" : "", cpu, ret);
>>> +             pr_warn("failed to %s update policy for cpu:%d (%d)\n",
>>> +                     val > 0 ? "set min/max_perf and" : "", cpu, ret);
>>>               return ret;
>>>       }
>>>
>>> @@ -1139,13 +1245,44 @@ static struct cpufreq_driver 
>>> cppc_cpufreq_driver = {
>>>       .name = "cppc_cpufreq",
>>>   };
>>>
>>> +static void cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 
>>> epp)
>>> +{
>>> +     int cpu, ret;
>>> +
>>> +     for_each_present_cpu(cpu) {
>>> +             ret = cppc_set_epp(cpu, epp);
>>> +             if (ret)
>>> +                     pr_debug("failed to set energy_perf for cpu:%d 
>>> (%d)\n", cpu, ret);
>>> +
>>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>>> +             if (ret)
>>> +                     pr_debug("failed to set auto_sel for cpu:%d 
>>> (%d)\n", cpu, ret);
>>> +     }
>>> +}
>>> +
>>>   static int __init cppc_cpufreq_init(void)
>>>   {
>>> +     bool auto_sel;
>>>       int ret;
>>>
>>>       if (!acpi_cpc_valid())
>>>               return -ENODEV;
>>>
>>> +     if (auto_sel_mode) {
>>> +             /*
>>> +              * Check if autonomous selection is supported by 
>>> testing CPU 0.
>>> +              * If supported, enable autonomous mode on all CPUs.
>>> +              */
>>> +             ret = cppc_get_auto_sel(0, &auto_sel);
>>> +             if (!ret) {
>>> +                     pr_info("Enabling autonomous mode on all CPUs\n");
>>> +                     cppc_cpufreq_set_epp_autosel_allcpus(true, 
>>> CPPC_EPP_PERFORMANCE_PREF);
>>> +             } else {
>>> +                     pr_warn("Autonomous selection not supported, 
>>> disabling auto_sel_mode\n");
>>> +                     auto_sel_mode = false;
>>> +             }
>>> +     }
>>> +
>>>       cppc_freq_invariance_init();
>>>       populate_efficiency_class();
>>>
>>> @@ -1160,8 +1297,12 @@ static void __exit cppc_cpufreq_exit(void)
>>>   {
>>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>>       cppc_freq_invariance_exit();
>>> +     auto_sel_mode = 0;
>>>   }
>>>
>>> +module_param(auto_sel_mode, bool, 0000);
>>> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level 
>>> Selection");
>>
>> Why default to disabled?  As a precaution?  We enable EPP by default in
>> the *-pstate drivers if the hardware supports it, I would think it makes
>> sense here too.
>>
> 
> Kept disabled by default both as precaution and to enable it based on 
> preference.
> Someone may want to try different config values during bringup, 
> verification etc.

I personally don't think that bringup software should dictate the steady 
state decision.  Bringup can trivially have a custom kernel command line 
that disables it.

Otherwise this means that the "worries of stability" translate into a 
custom kernel command line option on all production hardware.

So I feel once you're happy with it on a variety of hardware you should 
consider a patch for enabling it by default at some point.




