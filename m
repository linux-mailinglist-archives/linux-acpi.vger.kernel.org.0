Return-Path: <linux-acpi+bounces-1149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B977DF00E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD26B20C51
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6F1426F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D16FC5
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 09:07:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC2012E;
	Thu,  2 Nov 2023 02:07:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC0E02F4;
	Thu,  2 Nov 2023 02:07:42 -0700 (PDT)
Received: from [10.34.100.114] (e126645.nice.arm.com [10.34.100.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7638D3F67D;
	Thu,  2 Nov 2023 02:06:56 -0700 (PDT)
Message-ID: <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
Date: Thu, 2 Nov 2023 10:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] cpufreq/cppc: set the frequency used for computing
 the capacity
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
 lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
 ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linuxfoundation.org
Cc: conor.dooley@microchip.com, suagrfillet@gmail.com,
 ajones@ventanamicro.com, lftan@kernel.org
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-7-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231027080400.56703-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 10/27/23 10:03, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/base/arch_topology.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 9a073c2d2086..d4bef370feb3 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>   
>   void topology_init_cpu_capacity_cppc(void)
>   {
> +	u64 capacity, capacity_scale = 0;
>   	struct cppc_perf_caps perf_caps;
>   	int cpu;
>   
> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
>   		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
>   		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
>   			raw_capacity[cpu] = perf_caps.highest_perf;
> +			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
> +
> +			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> +

To continue Beata's point, I think there is an issue with the following:
cppc_perf_to_khz() and cppc_khz_to_perf() were previously used with a struct containing
frequencies in KHz, cf. [1].
In the original _CPC object, frequencies are in MHz. It means that the perf_caps struct
here contains frequencies in MHz, and per_cpu(capacity_ref_freq, cpu) is in MHz aswell.

[1] https://github.com/torvalds/linux/blob/master/drivers/cpufreq/cppc_cpufreq.c#L682


>   			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
>   				 cpu, raw_capacity[cpu]);
>   			continue;
> @@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
>   		goto exit;
>   	}
>   
> -	topology_normalize_cpu_scale();
> +	for_each_possible_cpu(cpu) {
> +		capacity = raw_capacity[cpu];
> +		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> +				     capacity_scale);
> +		topology_set_cpu_scale(cpu, capacity);
> +		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> +			cpu, topology_get_cpu_scale(cpu));
> +	}
> +
>   	schedule_work(&update_topology_flags_work);
>   	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
>   

