Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE23F8D54
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhHZRw2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 13:52:28 -0400
Received: from foss.arm.com ([217.140.110.172]:51222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243206AbhHZRw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Aug 2021 13:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF38131B;
        Thu, 26 Aug 2021 10:51:39 -0700 (PDT)
Received: from localhost (unknown [10.1.198.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FD243F5A1;
        Thu, 26 Aug 2021 10:51:39 -0700 (PDT)
Date:   Thu, 26 Aug 2021 18:51:38 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
Message-ID: <20210826175138.GA22165@arm.com>
References: <20210824105651.28660-1-ionela.voinescu@arm.com>
 <20210824105651.28660-3-ionela.voinescu@arm.com>
 <CAJZ5v0hkgWQqOzfdv4kr6rxz9eMsOgHkMYj0cZpO7yC+=SnQfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hkgWQqOzfdv4kr6rxz9eMsOgHkMYj0cZpO7yC+=SnQfg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for the review, Rafael!

On Wednesday 25 Aug 2021 at 19:54:26 (+0200), Rafael J. Wysocki wrote:
> On Tue, Aug 24, 2021 at 12:57 PM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> >
> > Define topology_init_cpu_capacity_cppc() to use highest performance
> > values from _CPC objects to obtain and set maximum capacity information
> > for each CPU. acpi_cppc_processor_probe() is a good point at which to
> > trigger the initialization of CPU (u-arch) capacity values, as at this
> > point the highest performance values can be obtained from each CPU's
> > _CPC objects. Architectures can therefore use this functionality
> > through arch_init_invariance_cppc().
> >
> > The performance scale used by CPPC is a unified scale for all CPUs in
> > the system. Therefore, by obtaining the raw highest performance values
> > from the _CPC objects, and normalizing them on the [0, 1024] capacity
> > scale, used by the task scheduler, we obtain the CPU capacity of each
> > CPU.
> >
> > While an ACPI Notify(0x85) could alert about a change in the highest
> > performance value, which should in turn retrigger the CPU capacity
> > computations, this notification is not currently handled by the ACPI
> > processor driver. When supported, a call to arch_init_invariance_cppc()
> > would perform the update.
> >
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/arch_topology.c  | 37 +++++++++++++++++++++++++++++++++++
> >  include/linux/arch_topology.h |  4 ++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 921312a8d957..358e22cd629e 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -306,6 +306,43 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >         return !ret;
> >  }
> >
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +#include <acpi/cppc_acpi.h>
> > +
> > +void topology_init_cpu_capacity_cppc(void)
> > +{
> > +       struct cppc_perf_caps perf_caps;
> > +       int cpu;
> > +
> > +       if (likely(acpi_disabled || !acpi_cpc_valid()))
> > +               return;
> > +
> > +       raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> > +                              GFP_KERNEL);
> > +       if (!raw_capacity)
> > +               return;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> > +                       raw_capacity[cpu] = perf_caps.highest_perf;
> 
> From experience, I would advise doing some sanity checking on the
> per_caps values before using them here.
> 

cppc_get_perf_caps() already returns -EFAULT if highest_perf is 0, and
I'm not sure if I can make any other assumptions about what a sane
highest_perf value would need to be here.

Did you have anything else in mind for sanity checking?

> Also note that highest_perf may not be sustainable, so would using
> highest_perf as raw_capacity[] always work as expected?
> 

Yes, in my opinion using it is better than the alternative, using the
nominal performance value. This highest performance value helps obtain
the maximum capacity of a CPU on a scale [0, 1024] when referenced to
the highest performance of the biggest CPU in the system. There is no
assumption in the task scheduler that this capacity is sustainable.
Using lower values (nominal performance) would shorten the scale and
make smaller CPUs seem bigger than they are. Also, using highest
performance gives a better indication of micro-architectural
differences in performance between CPUs, which plays a role in scaling
utilization, even if some of the performance levels are not sustainable
(which is platform dependent).

Thanks,
Ionela.

> > +                       pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
> > +                                cpu, raw_capacity[cpu]);
> > +               } else {
> > +                       pr_err("cpu_capacity: CPU%d missing highest performance.\n", cpu);
> > +                       pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
> > +                       goto exit;
> > +               }
> > +       }
> > +
> > +       topology_normalize_cpu_scale();
> > +       schedule_work(&update_topology_flags_work);
> > +       pr_debug("cpu_capacity: cpu_capacity initialization done\n");
> > +
> > +exit:
> > +       free_raw_capacity();
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_CPU_FREQ
> >  static cpumask_var_t cpus_to_visit;
> >  static void parsing_done_workfn(struct work_struct *work);
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index f180240dc95f..9cf1a17938f0 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -11,6 +11,10 @@
> >  void topology_normalize_cpu_scale(void);
> >  int topology_update_cpu_topology(void);
> >
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +void topology_init_cpu_capacity_cppc(void);
> > +#endif
> > +
> >  struct device_node;
> >  bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> >
> > --
> > 2.29.2.dirty
> >
