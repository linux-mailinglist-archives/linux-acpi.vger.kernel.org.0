Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF02D3F8DE1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhHZSdv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 14:33:51 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:38763 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbhHZSdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 14:33:51 -0400
Received: by mail-oo1-f53.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso1235306ooe.5;
        Thu, 26 Aug 2021 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ya+v4Lbe3Hdm7fi6ACeoXpsGHbI6u8FRdwtXSRzvWUM=;
        b=p2NAkkE8ZW44K7PjO/dt0AG7lQPNPmuk/6NDUA7ujCvDOqK4XULThnPgeZuqiVTktw
         ER04qCu2Z2hzosOyKOXJWSG7n1ryUHVC/MRUItyindPrMdYzknEYB8eI7SFSOF1n6op1
         TyQEd2QSSG4ix4ExQjJ2+mAB7nYQCQwzZY9jJ1109jmsMeuMv8Clcwbfz58SPhqHdnL6
         4hhLMqvvPAE36SoHSeiZYTceJgGB7lKUGgtA6ol4mgYxRDo2w26qh6T37CBZKeUg2n8w
         +yt2RXjRhbZndc0nm//WmPWrQFMjgiD7+PLe9jzX/C/y31hDmy8G7KHRZ2KC1ZK5ONoh
         ejbw==
X-Gm-Message-State: AOAM533bNODSZlMwRE0PDW29do82+fVg3AfYdf5T5oTrI8vl6cx5VA4B
        oO38/lENJEhpX3h2dXdWlrko+w9D5mwaUMBpGD8=
X-Google-Smtp-Source: ABdhPJzUQuZjJM0zzn0KBbVdBCzgQnqD6BCNGwsJokRB0DFgy74dZoRHnbNoaGdp9y2mwqBHWzhgViNY6O+z5QATbM0=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr4448669oom.1.1630002783323;
 Thu, 26 Aug 2021 11:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210824105651.28660-1-ionela.voinescu@arm.com>
 <20210824105651.28660-3-ionela.voinescu@arm.com> <CAJZ5v0hkgWQqOzfdv4kr6rxz9eMsOgHkMYj0cZpO7yC+=SnQfg@mail.gmail.com>
 <20210826175138.GA22165@arm.com>
In-Reply-To: <20210826175138.GA22165@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Aug 2021 20:32:52 +0200
Message-ID: <CAJZ5v0i9Ys67E8TvWzJG+NaODKsEMsJiHrF9KM77Lk4L-3OOsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 26, 2021 at 7:51 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Thanks for the review, Rafael!
>
> On Wednesday 25 Aug 2021 at 19:54:26 (+0200), Rafael J. Wysocki wrote:
> > On Tue, Aug 24, 2021 at 12:57 PM Ionela Voinescu
> > <ionela.voinescu@arm.com> wrote:
> > >
> > > Define topology_init_cpu_capacity_cppc() to use highest performance
> > > values from _CPC objects to obtain and set maximum capacity information
> > > for each CPU. acpi_cppc_processor_probe() is a good point at which to
> > > trigger the initialization of CPU (u-arch) capacity values, as at this
> > > point the highest performance values can be obtained from each CPU's
> > > _CPC objects. Architectures can therefore use this functionality
> > > through arch_init_invariance_cppc().
> > >
> > > The performance scale used by CPPC is a unified scale for all CPUs in
> > > the system. Therefore, by obtaining the raw highest performance values
> > > from the _CPC objects, and normalizing them on the [0, 1024] capacity
> > > scale, used by the task scheduler, we obtain the CPU capacity of each
> > > CPU.
> > >
> > > While an ACPI Notify(0x85) could alert about a change in the highest
> > > performance value, which should in turn retrigger the CPU capacity
> > > computations, this notification is not currently handled by the ACPI
> > > processor driver. When supported, a call to arch_init_invariance_cppc()
> > > would perform the update.
> > >
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/base/arch_topology.c  | 37 +++++++++++++++++++++++++++++++++++
> > >  include/linux/arch_topology.h |  4 ++++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > index 921312a8d957..358e22cd629e 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -306,6 +306,43 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> > >         return !ret;
> > >  }
> > >
> > > +#ifdef CONFIG_ACPI_CPPC_LIB
> > > +#include <acpi/cppc_acpi.h>
> > > +
> > > +void topology_init_cpu_capacity_cppc(void)
> > > +{
> > > +       struct cppc_perf_caps perf_caps;
> > > +       int cpu;
> > > +
> > > +       if (likely(acpi_disabled || !acpi_cpc_valid()))
> > > +               return;
> > > +
> > > +       raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> > > +                              GFP_KERNEL);
> > > +       if (!raw_capacity)
> > > +               return;
> > > +
> > > +       for_each_possible_cpu(cpu) {
> > > +               if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> > > +                       raw_capacity[cpu] = perf_caps.highest_perf;
> >
> > From experience, I would advise doing some sanity checking on the
> > per_caps values before using them here.
> >
>
> cppc_get_perf_caps() already returns -EFAULT if highest_perf is 0, and
> I'm not sure if I can make any other assumptions about what a sane
> highest_perf value would need to be here.

Well, it cannot be less than lowest_perf or nominal_perf or
guaranteed_perf, for instance.

> Did you have anything else in mind for sanity checking?
>
> > Also note that highest_perf may not be sustainable, so would using
> > highest_perf as raw_capacity[] always work as expected?
> >
>
> Yes, in my opinion using it is better than the alternative, using the
> nominal performance value. This highest performance value helps obtain
> the maximum capacity of a CPU on a scale [0, 1024] when referenced to
> the highest performance of the biggest CPU in the system. There is no
> assumption in the task scheduler that this capacity is sustainable.

That's true, but there are consequences if it is the case.  Namely,
you may find that the big CPUs run at the highest performance for a
small fraction of time, so most of the time they may appear to be
underutilized no matter how many tasks are packed on them, which then
will influence the utilization metrics of those tasks.

It may be better to use guaranteed_perf or some value between it at
the highest for this reason.

> Using lower values (nominal performance) would shorten the scale and
> make smaller CPUs seem bigger than they are. Also, using highest
> performance gives a better indication of micro-architectural
> differences in performance between CPUs, which plays a role in scaling
> utilization, even if some of the performance levels are not sustainable
> (which is platform dependent).
