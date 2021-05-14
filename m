Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3129D380DF8
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhENQSK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 12:18:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhENQSK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 12:18:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC651713;
        Fri, 14 May 2021 09:16:58 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AB033F73B;
        Fri, 14 May 2021 09:16:56 -0700 (PDT)
Subject: Re: [PATCH 2/3] arch_topology: obtain cpu capacity using information
 from CPPC
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
 <20210514095339.12979-3-ionela.voinescu@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3c3f6d32-3560-2c54-beae-36f53d2572e7@arm.com>
Date:   Fri, 14 May 2021 18:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210514095339.12979-3-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14/05/2021 11:53, Ionela Voinescu wrote:

[...]

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index c1179edc0f3b..f710d64f125b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -291,6 +291,45 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  	return !ret;
>  }
>  
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +#include <acpi/cppc_acpi.h>

init_cpu_capacity_cppc() shares a lot of functionality with the existing
DT/CPUfreq-based approach (topology_parse_cpu_capacity(),
register_cpufreq_notifier(), init_cpu_capacity_callback()). It looks
like that the different ways of invocation (two steps per cpu vs. one
step for all cpus) makes it hard to restructure the code to create more
common bits.

> +void init_cpu_capacity_cppc(void)
> +{
> +	struct cppc_perf_caps perf_caps;
> +	int cpu;
> +
> +	if (likely(acpi_disabled || !acpi_cpc_valid()))

likely(acpi_disabled) ?

> +		return;
> +
> +	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> +			       GFP_KERNEL);
> +	if (!raw_capacity)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> +			raw_capacity[cpu] = perf_caps.highest_perf;
> +			pr_debug("%s: CPU%d cpu_capacity=%u (raw).\n",
> +				 __func__, cpu, raw_capacity[cpu]);

There is quite a variety in the layout of the pr_xxx() log messages in
this file. Originally the 'cpu_capacity:' was used to indicate that this
log is from drivers/base/arch_topology.c. Now the GCC __func__
identifier is used. Maybe this can be aligned better? Especially since
the functionality used in the existing DT-driven and now in the new
CPPC-driven functionality is quite similar. Debugging is so much easier
with consistent log strings.


> +		} else {
> +			pr_err("%s: CPU%d missing highest performance.\n",
> +				 __func__, cpu);
> +			pr_err("%s: fallback to 1024 for all CPUs\n",
> +				 __func__);
> +			goto exit;
> +		}
> +	}
> +
> +	topology_normalize_cpu_scale();
> +	schedule_work(&update_topology_flags_work);
> +	pr_debug("%s: cpu_capacity initialization done\n", __func__);
> +
> +exit:
> +	free_raw_capacity();
> +}
> +#endif

In case a system has CONFIG_ACPI_CPPC_LIB what does this mean for the
DT-based approach via `register_cpufreq_notifier()`?

Looks like we rely on:

376 static int __init register_cpufreq_notifier(void)
...
385         if (!acpi_disabled || ...)
386                 return -EINVAL;

to disable the CPUfreq part of the DT/CPUfreq-based approach on an ACPI
system.

[...]
