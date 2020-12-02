Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26D2CBA69
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgLBKRg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 05:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbgLBKRg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 05:17:36 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6503AC0613D6
        for <linux-acpi@vger.kernel.org>; Wed,  2 Dec 2020 02:16:55 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so2756809ljo.11
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2020 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJG5/KacGVTrqGFMculHNYU5a3Jxd+d8SfWz0noUXyI=;
        b=bRjn6evMULWybkLc6+IAkcQb+1DFIliB1JT7HBp67DLIbBvBKqcC4097sEpCg/RKQe
         CCzIubYwcX0oJvYBgYmrXTcJK598HzFRwrZe2c3kv7X+qEV6F62BqoABCGZCH2plBcVY
         kD/aDfHWSpy5/DFzS7OBXw7GkRWhluR37GjgtfRW8XqJ9bTTpOiOwT/s5UQZuMzxzV/O
         IhI5hPyE9csTMPXsprmjByNjedyNhKhuU9j/ynFTpZtvx1eOmJAxalciFAhyJWds0dOF
         v/UL0okqUw/13Gc23RhK/0hVHTybXTzlw9k1ZWYRO8ridMUxXLnKZyisaK3DfS36tFnD
         6G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJG5/KacGVTrqGFMculHNYU5a3Jxd+d8SfWz0noUXyI=;
        b=BWjP1CMfuaNHPSmE0lqo9sMaf3sc7t93lkXNX3dls+YP2/wcGLRtAjvXH13QCDmLFy
         7/cBPURpuI6C1KTlitxiilLTi4o4msV+YikEi5cX0gllYtOlruK1rbTvVjZGnWMK4DbZ
         tz/Gr4Nneui86Mc4pehCfE9K+TKxfA9HMVbF22ihiCCDUFWaQtif2CD9/oXmYCFwMkId
         48U+Nc0iLck9TPhnklnVBVhmEH8RVFuhfzjKJHTp/doz57pNCw6ovU94pqSDfnfI1svO
         8gjNHkGbm90brsKEkr3KPY0pZ0qNzdq2Qx6Yy8EVBLW5tQqJ8O06CsMHbjFKPVrGjLrS
         sbmQ==
X-Gm-Message-State: AOAM531j+eLW4ln17N+qUbtQEV+WtDIbRjOENn6HDiIkzBbyf0oUwoXs
        +xLCzk66GBBSALoe1ceTsdn8oeal6pUa+GNzqjQHsA==
X-Google-Smtp-Source: ABdhPJz5lgBjrcJwHCw0uePgnT+dyNYbrWcqX8vmebUId4Q5zZ47HwMVAVs1xZnz/LLjpfw6s60shkEUxR1bXKJxjok=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr821119ljg.156.1606904213600;
 Wed, 02 Dec 2020 02:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com> <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
In-Reply-To: <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Dec 2020 11:16:42 +0100
Message-ID: <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2 Dec 2020 at 10:20, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
> > Sent: Wednesday, December 2, 2020 9:27 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>; Catalin Marinas
> > <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>; Cc: Len Brown <lenb@kernel.org>;
> > gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Juri
> > Lelli <juri.lelli@redhat.com>; Dietmar Eggemann <dietmar.eggemann@arm.com>;
> > Steven Rostedt <rostedt@goodmis.org>; Ben Segall <bsegall@google.com>; Mel
> > Gorman <mgorman@suse.de>; Mark Rutland <mark.rutland@arm.com>; LAK
> > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; ACPI Devel Maling List
> > <linux-acpi@vger.kernel.org>; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> > <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
> > Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
> >
> > On Tue, 1 Dec 2020 at 04:04, Barry Song <song.bao.hua@hisilicon.com> wrote:
> > >
> > > ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
> > > cluster has 4 cpus. All clusters share L3 cache data, but each cluster
> > > has local L3 tag. On the other hand, each clusters will share some
> > > internal system bus. This means cache coherence overhead inside one cluster
> > > is much less than the overhead across clusters.
> > >
> > > +-----------------------------------+                          +---------+
> > > |  +------+    +------+            +---------------------------+         |
> > > |  | CPU0 |    | cpu1 |             |    +-----------+         |         |
> > > |  +------+    +------+             |    |           |         |         |
> > > |                                   +----+    L3     |         |         |
> > > |  +------+    +------+   cluster   |    |    tag    |         |         |
> > > |  | CPU2 |    | CPU3 |             |    |           |         |         |
> > > |  +------+    +------+             |    +-----------+         |         |
> > > |                                   |                          |         |
> > > +-----------------------------------+                          |         |
> > > +-----------------------------------+                          |         |
> > > |  +------+    +------+             +--------------------------+         |
> > > |  |      |    |      |             |    +-----------+         |         |
> > > |  +------+    +------+             |    |           |         |         |
> > > |                                   |    |    L3     |         |         |
> > > |  +------+    +------+             +----+    tag    |         |         |
> > > |  |      |    |      |             |    |           |         |         |
> > > |  +------+    +------+             |    +-----------+         |         |
> > > |                                   |                          |         |
> > > +-----------------------------------+                          |   L3    |
> > >                                                                |   data  |
> > > +-----------------------------------+                          |         |
> > > |  +------+    +------+             |    +-----------+         |         |
> > > |  |      |    |      |             |    |           |         |         |
> > > |  +------+    +------+             +----+    L3     |         |         |
> > > |                                   |    |    tag    |         |         |
> > > |  +------+    +------+             |    |           |         |         |
> > > |  |      |    |      |            ++    +-----------+         |         |
> > > |  +------+    +------+            |---------------------------+         |
> > > +-----------------------------------|                          |         |
> > > +-----------------------------------|                          |         |
> > > |  +------+    +------+            +---------------------------+         |
> > > |  |      |    |      |             |    +-----------+         |         |
> > > |  +------+    +------+             |    |           |         |         |
> > > |                                   +----+    L3     |         |         |
> > > |  +------+    +------+             |    |    tag    |         |         |
> > > |  |      |    |      |             |    |           |         |         |
> > > |  +------+    +------+             |    +-----------+         |         |
> > > |                                   |                          |         |
> > > +-----------------------------------+                          |         |
> > > +-----------------------------------+                          |         |
> > > |  +------+    +------+             +--------------------------+         |
> > > |  |      |    |      |             |   +-----------+          |         |
> > > |  +------+    +------+             |   |           |          |         |
> > > |                                   |   |    L3     |          |         |
> > > |  +------+    +------+             +---+    tag    |          |         |
> > > |  |      |    |      |             |   |           |          |         |
> > > |  +------+    +------+             |   +-----------+          |         |
> > > |                                   |                          |         |
> > > +-----------------------------------+                          |         |
> > > +-----------------------------------+                         ++         |
> > > |  +------+    +------+             +--------------------------+         |
> > > |  |      |    |      |             |  +-----------+           |         |
> > > |  +------+    +------+             |  |           |           |         |
> > > |                                   |  |    L3     |           |         |
> > > |  +------+    +------+             +--+    tag    |           |         |
> > > |  |      |    |      |             |  |           |           |         |
> > > |  +------+    +------+             |  +-----------+           |         |
> > > |                                   |                          +---------+
> > > +-----------------------------------+
> > >
> > > This patch adds the sched_domain for clusters. On kunpeng 920, without
> > > this patch, domain0 of cpu0 would be MC for cpu0-cpu23 with
> > > min_interval=24, max_interval=48; with this patch, MC becomes domain1,
> > > a new domain0 "CL" including cpu0-cpu3 is added with min_interval=4 and
> > > max_interval=8.
> > > This will affect load balance. For example, without this patch, while cpu0
> > > becomes idle, it will pull a task from cpu1-cpu15. With this patch, cpu0
> > > will try to pull a task from cpu1-cpu3 first. This will have much less
> > > overhead of task migration.
> > >
> > > On the other hand, while doing WAKE_AFFINE, this patch will try to find
> > > a core in the target cluster before scanning the llc domain.
> > > This means it will proactively use a core which has better affinity with
> > > target core at first.
> >
> > Which is at the opposite of what we are usually trying to do in the
> > fast wakeup path: trying to minimize resource sharing by finding an
> > idle core with all smt idle as an example
>
> In wake_affine case, I guess we are actually want some kind of
> resource sharing such as LLC to get waker and wakee get closer

In wake_affine, we don't want to move outside the LLC  but then in the
LLC we tries to minimize resource sharing like looking for a core
fully idle for SMT

> to each other. find_idlest_cpu() is really opposite.
>
> So the real question is that LLC is always the right choice of
> idle sibling?

That's the eternal question: spread or gather

>
> In this case, 6 clusters are in same LLC, but hardware has different
> behavior for inside single cluster and across multiple clusters.
>
>
> >
> > >
> > > Not much benchmark has been done yet. but here is a rough hackbench
> > > result.
> > > we run the below command with different -g parameter to increase system load
> > > by changing g from 1 to 4, for each one of 1-4, we run the benchmark ten times
> > > and record the data to get the average time:
> > >
> > > First, we run hackbench in only one NUMA node(cpu0-cpu23):
> > > $ numactl -N 0 hackbench -p -T -l 100000 -g $1
> >
> > What is your ref tree ? v5.10-rcX or tip/sched/core ?
>
> Actually I was using 5.9 release.  That must be weird.
> But the reason is that disk driver is getting hang
> in my hardware in 5.10-rcx.

In fact there are several changes in v5.10 and tip/sched/core that
could help your topology

>
> >
> > >
> > > g=1 (seen cpu utilization around 50% for each core)
> > > Running in threaded mode with 1 groups using 40 file descriptors
> > > Each sender will pass 100000 messages of 100 bytes
> > > w/o: 7.689 7.485 7.485 7.458 7.524 7.539 7.738 7.693 7.568 7.674=7.5853
> > > w/ : 7.516 7.941 7.374 7.963 7.881 7.910 7.420 7.556 7.695 7.441=7.6697
> > > performance improvement w/ patch: -1.01%
> > >
> > > g=2 (seen cpu utilization around 70% for each core)
> > > Running in threaded mode with 2 groups using 40 file descriptors
> > > Each sender will pass 100000 messages of 100 bytes
> > > w/o: 10.127 10.119 10.070 10.196 10.057 10.111 10.045 10.164 10.162
> > 9.955=10.1006
> > > w/ : 9.694 9.654 9.612 9.649 9.686 9.734 9.607 9.842 9.690 9.710=9.6878
> > > performance improvement w/ patch: 4.08%
> > >
> > > g=3 (seen cpu utilization around 90% for each core)
> > > Running in threaded mode with 3 groups using 40 file descriptors
> > > Each sender will pass 100000 messages of 100 bytes
> > > w/o: 15.885 15.254 15.932 15.647 16.120 15.878 15.857 15.759 15.674
> > 15.721=15.7727
> > > w/ : 14.974 14.657 13.969 14.985 14.728 15.665 15.191 14.995 14.946
> > 14.895=14.9005
> > > performance improvement w/ patch: 5.53%
> > >
> > > g=4
> > > Running in threaded mode with 4 groups using 40 file descriptors
> > > Each sender will pass 100000 messages of 100 bytes
> > > w/o: 20.014 21.025 21.119 21.235 19.767 20.971 20.962 20.914 21.090
> > 21.090=20.8187
> > > w/ : 20.331 20.608 20.338 20.445 20.456 20.146 20.693 20.797 21.381
> > 20.452=20.5647
> > > performance improvement w/ patch: 1.22%
> > >
> > > After that, we run the same hackbench in both NUMA nodes(cpu0-cpu47):
> > > g=1
> > > w/o: 7.351 7.416 7.486 7.358 7.516 7.403 7.413 7.411 7.421 7.454=7.4229
> > > w/ : 7.609 7.596 7.647 7.571 7.687 7.571 7.520 7.513 7.530 7.681=7.5925
> > > performance improvement by patch: -2.2%
> > >
> > > g=2
> > > w/o: 9.046 9.190 9.053 8.950 9.101 8.930 9.143 8.928 8.905 9.034=9.028
> > > w/ : 8.247 8.057 8.258 8.310 8.083 8.201 8.044 8.158 8.382 8.173=8.1913
> > > performance improvement by patch: 9.3%
> > >
> > > g=3
> > > w/o: 11.664 11.767 11.277 11.619 12.557 12.760 11.664 12.165 12.235
> > 11.849=11.9557
> > > w/ : 9.387 9.461 9.650 9.613 9.591 9.454 9.496 9.716 9.327 9.722=9.5417
> > > performance improvement by patch: 20.2%
> > >
> > > g=4
> > > w/o: 17.347 17.299 17.655 18.775 16.707 18.879 17.255 18.356 16.859
> > 18.515=17.7647
> > > w/ : 10.416 10.496 10.601 10.318 10.459 10.617 10.510 10.642 10.467
> > 10.401=10.4927
> > > performance improvement by patch: 40.9%
> > >
> > > g=5
> > > w/o: 27.805 26.633 24.138 28.086 24.405 27.922 30.043 28.458 31.073
> > 25.819=27.4382
> > > w/ : 13.817 13.976 14.166 13.688 14.132 14.095 14.003 13.997 13.954
> > 13.907=13.9735
> > > performance improvement by patch: 49.1%
> > >
> > > It seems the patch can bring a huge increase on hackbench especially when
> > > we bind hackbench to all of cpu0-cpu47, comparing to 5.53% while running
> > > on single NUMA node(cpu0-cpu23)
> >
> > Interesting that this patch mainly impacts the numa case
> >
> > >
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > ---
> > >  arch/arm64/Kconfig       |  7 +++++++
> > >  arch/arm64/kernel/smp.c  | 17 +++++++++++++++++
> > >  include/linux/topology.h |  7 +++++++
> > >  kernel/sched/fair.c      | 35 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 66 insertions(+)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 6d23283..3583c26 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -938,6 +938,13 @@ config SCHED_MC
> > >           making when dealing with multi-core CPU chips at a cost of slightly
> > >           increased overhead in some places. If unsure say N here.
> > >
> > > +config SCHED_CLUSTER
> > > +       bool "Cluster scheduler support"
> > > +       help
> > > +         Cluster scheduler support improves the CPU scheduler's decision
> > > +         making when dealing with machines that have clusters(sharing internal
> > > +         bus or sharing LLC cache tag). If unsure say N here.
> > > +
> > >  config SCHED_SMT
> > >         bool "SMT scheduler support"
> > >         help
> > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > index 355ee9e..5c8f026 100644
> > > --- a/arch/arm64/kernel/smp.c
> > > +++ b/arch/arm64/kernel/smp.c
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/irq_work.h>
> > >  #include <linux/kexec.h>
> > >  #include <linux/kvm_host.h>
> > > +#include <linux/sched/topology.h>
> > >
> > >  #include <asm/alternative.h>
> > >  #include <asm/atomic.h>
> > > @@ -726,6 +727,20 @@ void __init smp_init_cpus(void)
> > >         }
> > >  }
> > >
> > > +static struct sched_domain_topology_level arm64_topology[] = {
> > > +#ifdef CONFIG_SCHED_SMT
> > > +        { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
> > > +#endif
> > > +#ifdef CONFIG_SCHED_CLUSTER
> > > +       { cpu_clustergroup_mask, cpu_core_flags, SD_INIT_NAME(CL) },
> > > +#endif
> > > +#ifdef CONFIG_SCHED_MC
> > > +        { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
> > > +#endif
> > > +       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> > > +        { NULL, },
> > > +};
> > > +
> > >  void __init smp_prepare_cpus(unsigned int max_cpus)
> > >  {
> > >         const struct cpu_operations *ops;
> > > @@ -735,6 +750,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> > >
> > >         init_cpu_topology();
> > >
> > > +       set_sched_topology(arm64_topology);
> > > +
> > >         this_cpu = smp_processor_id();
> > >         store_cpu_topology(this_cpu);
> > >         numa_store_cpu_info(this_cpu);
> > > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > > index 5f66648..2c823c0 100644
> > > --- a/include/linux/topology.h
> > > +++ b/include/linux/topology.h
> > > @@ -211,6 +211,13 @@ static inline const struct cpumask *cpu_smt_mask(int
> > cpu)
> > >  }
> > >  #endif
> > >
> > > +#ifdef CONFIG_SCHED_CLUSTER
> > > +static inline const struct cpumask *cpu_cluster_mask(int cpu)
> > > +{
> > > +       return topology_cluster_cpumask(cpu);
> > > +}
> > > +#endif
> > > +
> > >  static inline const struct cpumask *cpu_cpu_mask(int cpu)
> > >  {
> > >         return cpumask_of_node(cpu_to_node(cpu));
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 1a68a05..ae8ec910 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6106,6 +6106,37 @@ static inline int select_idle_smt(struct task_struct
> > *p, int target)
> > >
> > >  #endif /* CONFIG_SCHED_SMT */
> > >
> > > +#ifdef CONFIG_SCHED_CLUSTER
> > > +/*
> > > + * Scan the local CLUSTER mask for idle CPUs.
> > > + */
> > > +static int select_idle_cluster(struct task_struct *p, int target)
> > > +{
> > > +       int cpu;
> > > +
> > > +       /* right now, no hardware with both cluster and smt to run */
> > > +       if (sched_smt_active())
> >
> > don't use smt static key but a dedicated one if needed
>
> Sure.
>
> >
> > > +               return -1;
> > > +
> > > +       for_each_cpu_wrap(cpu, cpu_cluster_mask(target), target) {
> > > +               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> > > +                       continue;
> > > +               if (available_idle_cpu(cpu))
> > > +                       return cpu;
> > > +       }
> > > +
> > > +       return -1;
> > > +}
> > > +
> > > +#else /* CONFIG_SCHED_CLUSTER */
> > > +
> > > +static inline int select_idle_cluster(struct task_struct *p, int target)
> > > +{
> > > +       return -1;
> > > +}
> > > +
> > > +#endif /* CONFIG_SCHED_CLUSTER */
> > > +
> > >  /*
> > >   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> > >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against
> > the
> > > @@ -6270,6 +6301,10 @@ static int select_idle_sibling(struct task_struct *p,
> > int prev, int target)
> > >         if ((unsigned)i < nr_cpumask_bits)
> > >                 return i;
> > >
> > > +       i = select_idle_cluster(p, target);
> > > +       if ((unsigned)i < nr_cpumask_bits)
> > > +               return i;
> >
> > This is yet another loop in the fast wake up path.
> >
> > I'm curious to know which part of this patch really gives the perf improvement ?
> > -Is it the new sched domain level with a shorter interval that is then
> > used by Load balance to better spread task in the cluster and between
> > clusters ?
> > -Or this new loop in the wake up path which tries to keep threads in
> > the same cluster ? which is at the opposite of the rest of the
> > scheduler which tries to spread
>
> If I don't scan cluster first for wake_affine, I almost don't see large
> hackbench change by the new sche_domain.
> For example:
> g=4 in hackbench on cpu0-cpu47(two numa)
> w/o patch: 17.7647 (average time in 10 times of hackbench)
> w/ the full patch: 10.4927
> w/ patch but drop select_idle_cluster(): 15.0931

And for the case with one numa node ?

I'd like to understand why this patch impacts much the numa case but
not the  one numa node case.

>
> So I don't think the hackbench increase mainly comes from the shorter
> interval of load balance of the new cluster domain.
>
> What does really matter is select_idle_cluster() according to my tests.
>
> >
> > Also could the sched_feat(SIS_PROP) impacts significantly your
> > topology because it  breaks before looking for all cores in the LLC ?
> > And this new loop extends the number of tested core ?
>
> In this case, cluster must belong to LLC. Cluster is the child of LLC.

Yes . My point is: in select_idle_cpu, we don't always loop on all
CPUs especially when you have a large number of CPUs in the LLC.
Instead, the loop can break after testing only 4 CPUs in some cases of
shart idle time (like hackbench). I don't know how the CPUs are
numbered but I can easily imagine that select_idle_cluster doesn't
loop on the same CPUs as the few ones that are then tested in
select_idle_cpu when it doesn't test all CPUs of the LLC

>
> Maybe the code Valentin suggested in his reply is a good way to
> keep the code align with the existing select_idle_cpu():
>
> static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       struct sched_domain *this_sd;
> +       struct sched_domain *this_sd, *child = NULL;
>         u64 avg_cost, avg_idle;
>         u64 time;
>         int this = smp_processor_id();
> @@ -6150,14 +6150,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       do {
> +               /* XXX: sd should start as SMT's parent */
> +               cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +               if (child)
> +                       cpumask_andnot(cpus, cpus, sched_domain_span(child));
> +
> +               for_each_cpu_wrap(cpu, cpus, target) {
> +                       if (!--nr)
> +                               return -1;
> +                       if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +                               break;
> +               }
>
> -       for_each_cpu_wrap(cpu, cpus, target) {
> -               if (!--nr)
> -                       return -1;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       break;
> -       }
> +               child = sd;
> +               sd = sd->parent;
> +       } while (sd && sd->flags & SD_SHARE_PKG_RESOURCES);
>
> >
> > > +
> > >         i = select_idle_cpu(p, sd, target);
> > >         if ((unsigned)i < nr_cpumask_bits)
> > >                 return i;
> > > --
> > > 2.7.4
> > >
>
> Thanks
> Barry
>
