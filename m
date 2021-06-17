Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5C3AB170
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhFQKg3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 06:36:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhFQKgZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 06:36:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD5031B;
        Thu, 17 Jun 2021 03:34:17 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE7E3F694;
        Thu, 17 Jun 2021 03:34:17 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:34:15 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210617103415.GA29877@arm.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Many thanks for the details!

On Thursday 17 Jun 2021 at 08:54:16 (+0530), Viresh Kumar wrote:
> On 16-06-21, 13:48, Ionela Voinescu wrote:
> > I was looking forward to the complete removal of stop_cpu() :).
> 
> No one wants to remove more code than I do :)
> 
> > I'll only comment on this for now as I should know the rest.
> > 
> > Let's assume we don't have these, what happens now is the following:
> > 
> > 1. We hotplug out the last CPU in a policy, we call the
> >    .stop_cpu()/exit() function which will free the cppc_cpudata structure.
> > 
> >    The only vulnerability is if we have a last tick on that last CPU,
> >    after the above callback was called.
> > 
> > 2. When the CPU at 1. gets hotplugged back in, the cppc_fi->cpu_data is
> >    stale.
> > 
> > We do not have a problem when removing the CPPC cpufreq module as we're
> > doing cppc_freq_invariance_exit() before unregistering the driver and
> > freeing the data.
> > 
> > Are 1. and 2 the only problems we have, or have I missed any?
> 
> There is more to it. For simplicity, lets assume a quad-core setup,
> with all 4 CPUs sharing the cpufreq policy. And here is what happens
> without the new changes:
> 
> - On CPPC cpufreq driver insertion, we start 4 kthreads/irq-works (1
>   for each CPU as it fires from tick) from the ->init() callback.
> 
> - Now lets say we offline CPU3. The CPPC cpufreq driver isn't notified
>   by anyone and it hasn't registered itself to hotplug notifier as
>   well. So, the irq-work/kthread isn't stopped. This results in the
>   issue reported by Qian earlier.
> 

I might be missing something, but when you offline a single CPU in a
policy, the worse that can happen is that a last call to
cppc_scale_freq_tick() would have sneaked in before irqs and the tick
are disabled. But even if we have a last call to
cppc_scale_freq_workfn(), the counter read methods would know how to
cope with hotplug, and the cppc_cpudata structure would still be
allocated and have valid desired_perf and highest_perf values.

Worse case, the last scale factor set for the CPU will be meaningless,
but it's already meaningless as the CPU is going down.

When you are referring to the issue reported by Qian I suppose you are
referring to this [1]. I think this is the case where you hotplug the
last CPU in a policy and free cppc_cpudata.

[1] https://lore.kernel.org/linux-pm/41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com/

>   The very same thing happens with schedutil governor too, which uses
>   very similar mechanisms, and the cpufreq core takes care of it there
>   by stopping the governor before removing the CPU from policy->cpus
>   and starting it again. So there we stop irq-work/kthread for all 4
>   CPUs, then start them only for remaining 3.
> 

Things are different for sugov: you have to stop the governor when one
CPU in the policy goes down, and it's normal for sugov not to allow its
hooks to be called while the governor is down so it has to do a full
cleanup when going down and a full bringup when going back up.

The difference for CPPC invariance is that only a CPU can trigger the
work to update its own scale factor, through the tick. No other CPU x
can trigger a scale factor update for CPU y, but x can carry out the
work for CPU y (x can run the cppc_scale_freq_workfn(y)).

So when y goes down, it won't have a tick to queue any irq or kthread
work any longer until it's brought back up. So I believe that the only
cleanup that needs to be done when a CPU goes offline, is to ensure
that the work triggered by that last tick is done safely.

>   I thought about that approach as well, but it was too heavy to stop
>   everyone and start again in this case. And so I invented start_cpu()
>   and stop_cpu() callbacks.
> 

> - In this case, because the CPU is going away, we need to make sure we
>   don't queue any more irq-work or kthread to it and this is one of
>   the main reasons for adding synchronization in the topology core,
>   because we need a hard guarantee here that irq-work won't fire
>   again, as the CPU won't be there or will not be in a sane state.
> 

We can't queue any more work for it as there's no tick for the offline
CPU.

> - The same sequence of events is true for the case where the last CPU
>   of a policy goes away (not in this example, but lets say quad-core
>   setup with separate policies for each CPU).
> 
> - Not just the policy, but the CPU may be going away as well.
> 
> I hope I was able to clarify a bit here.
> 

Thanks! I do agree it is better to be cautious, but I initially wanted to
understand we don't see the problem bigger than it actually is.

Thanks,
Ionela.

P.S. I'll give more thought to the rcu use in the arch_topology driver.
I'm the boring kind that likes to err on the side of caution, so I tend
to agree that it might be good to have even if the current problem could
be solved in this driver.


> -- 
> viresh
