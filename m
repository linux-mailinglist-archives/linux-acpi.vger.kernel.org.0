Return-Path: <linux-acpi+bounces-984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B137D75BF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BDC281CB6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60234198
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011128680
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:13:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 975BEDC;
	Wed, 25 Oct 2023 13:13:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CF62F4;
	Wed, 25 Oct 2023 13:14:00 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A543F738;
	Wed, 25 Oct 2023 13:13:13 -0700 (PDT)
Message-ID: <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
Date: Wed, 25 Oct 2023 22:13:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com,
 pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linuxfoundation.org
Cc: conor.dooley@microchip.com, suagrfillet@gmail.com,
 ajones@ventanamicro.com, lftan@kernel.org
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231018162540.667646-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2023 18:25, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilization.
> 
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 458d359f5991..6e4030482ae8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  	}
>  }
>  
> +/**
> + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that

s/cpufreq_get_capacity_ref_freq/get_capacity_ref_freq

s/of a given CPU/for a given cpufreq policy ? (of which the CPU managing
it is used for the arch_scale_freq_ref() call in the function.

> + * has been used to correlate frequency and compute capacity.
> + * @policy: the cpufreq policy of the CPU in question.
> + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.

Looks like use_current does not exists as a parameter.

> + *
> + * Return: the reference CPU frequency to compute a capacity.
> + */
> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +	unsigned int freq = arch_scale_freq_ref(policy->cpu);
> +
> +	if (freq)
> +		return freq;
> +
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +	return policy->cur;
> +}

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>




