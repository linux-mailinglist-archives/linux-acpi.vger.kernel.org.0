Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4215388B00
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbhESJsO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 05:48:14 -0400
Received: from foss.arm.com ([217.140.110.172]:56714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241573AbhESJsN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 05:48:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C22911B3;
        Wed, 19 May 2021 02:46:53 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0F8E3F719;
        Wed, 19 May 2021 02:46:52 -0700 (PDT)
Date:   Wed, 19 May 2021 10:46:51 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arch_topology: obtain cpu capacity using information
 from CPPC
Message-ID: <20210519094651.GA21501@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
 <20210514095339.12979-3-ionela.voinescu@arm.com>
 <3c3f6d32-3560-2c54-beae-36f53d2572e7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3f6d32-3560-2c54-beae-36f53d2572e7@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dietmar,

Many thanks for the review!

On Friday 14 May 2021 at 18:16:50 (+0200), Dietmar Eggemann wrote:
> On 14/05/2021 11:53, Ionela Voinescu wrote:
> 
> [...]
> 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index c1179edc0f3b..f710d64f125b 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -291,6 +291,45 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >  	return !ret;
> >  }
> >  
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +#include <acpi/cppc_acpi.h>
> 
> init_cpu_capacity_cppc() shares a lot of functionality with the existing
> DT/CPUfreq-based approach (topology_parse_cpu_capacity(),
> register_cpufreq_notifier(), init_cpu_capacity_callback()). It looks
> like that the different ways of invocation (two steps per cpu vs. one
> step for all cpus) makes it hard to restructure the code to create more
> common bits.
> 

Yes, I looked at ways to reuse more of the DT-based functionality, but I
did not find a better way. We reuse the normalization functionality and
the rebuild of the scheduling domains, but I'm not sure there's room for
much more, as the rest is specific to each source of capacity
information, DT+cpufreq or CPPC.

I also did not want to tie the new CPPC based functionality to cpufreq.
While the DT-based path needs cpufreq policies initialized as it needs
information on maximum frequency to obtain capacity, this is not needed
in the new code. This results in simpler code and ensures support even
for systems that do not have a cpufreq driver.

> > +void init_cpu_capacity_cppc(void)
> > +{
> > +	struct cppc_perf_caps perf_caps;
> > +	int cpu;
> > +
> > +	if (likely(acpi_disabled || !acpi_cpc_valid()))
> 
> likely(acpi_disabled) ?
> 

likely (acpi_disabled || !acpi_cpc_valid()) :)

It's "likely" useless, but this function gets called for each CPU from
acpi_cppc_processor_probe(), but it only continues with setting the
cpu_scale after all possible CPUs have their _CPC objects populated.

Therefore it's a lot more likely we return here.

> > +		return;
> > +
> > +	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> > +			       GFP_KERNEL);
> > +	if (!raw_capacity)
> > +		return;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> > +			raw_capacity[cpu] = perf_caps.highest_perf;
> > +			pr_debug("%s: CPU%d cpu_capacity=%u (raw).\n",
> > +				 __func__, cpu, raw_capacity[cpu]);
> 
> There is quite a variety in the layout of the pr_xxx() log messages in
> this file. Originally the 'cpu_capacity:' was used to indicate that this
> log is from drivers/base/arch_topology.c. Now the GCC __func__
> identifier is used. Maybe this can be aligned better? Especially since
> the functionality used in the existing DT-driven and now in the new
> CPPC-driven functionality is quite similar. Debugging is so much easier
> with consistent log strings.
> 

Right! My intention was to keep the prints relatively similar, but my
wanting to reduce the line length got the better of me. I'll keep the
prints consistent.

> 
> > +		} else {
> > +			pr_err("%s: CPU%d missing highest performance.\n",
> > +				 __func__, cpu);
> > +			pr_err("%s: fallback to 1024 for all CPUs\n",
> > +				 __func__);
> > +			goto exit;
> > +		}
> > +	}
> > +
> > +	topology_normalize_cpu_scale();
> > +	schedule_work(&update_topology_flags_work);
> > +	pr_debug("%s: cpu_capacity initialization done\n", __func__);
> > +
> > +exit:
> > +	free_raw_capacity();
> > +}
> > +#endif
> 
> In case a system has CONFIG_ACPI_CPPC_LIB what does this mean for the
> DT-based approach via `register_cpufreq_notifier()`?
> 

CONFIG_ACPI_CPPC_LIB is enabled by default on arm64. This only ensures
that we have the functionality to parse and work with the ACPI _CPC
objects and it does not guarantee that ACPI will be used.

> Looks like we rely on:
> 
> 376 static int __init register_cpufreq_notifier(void)
> ...
> 385         if (!acpi_disabled || ...)
> 386                 return -EINVAL;
> 
> to disable the CPUfreq part of the DT/CPUfreq-based approach on an ACPI
> system.
> 

It's both acpi_disabled and raw_capacity that guard the DT path. You
need both to not use ACPI (therefore using DT) and to have valid
capacity-dmips-mhz in DT for the cpufreq notifier that will eventually
populate the cpu_scale variables to be registered.

Thank you,
Ionela.
> [...]
