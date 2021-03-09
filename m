Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A9332A85
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCIPd1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCIPdR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:33:17 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A570C06175F
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 07:33:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t9so21166244ljt.8
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GueXWEXYhGgyYi6RS/iDIZfnWgS+3C26tBBCX7qsJZ4=;
        b=z2Y+Gz1eD/yQaUstRQIfbWCXO4frrvNYGP64q9xoN7I+ftNHuKnfMiLaKKarVDldsr
         ksiKhYOs+YQAIA+o7mJ4jo8GQ3ExfzIIg2l7auI14Eo1bTAYTdD8FGTDlse27T9hpgW3
         r/uDAZb2mUztArRDC42qzZCFznzG2qD7HORJhDjB32RqT475lwOXdMqJAf6RQDx6slQh
         jF2KVKvMvHjcCDxtchWOYHF6SPUQRp9HFC/x5N2COkqY82uIt8oSXChvNwZVL0LOR+hj
         dt2Vh8cub/3nTsv9Oi29tgWHzrWg6vLoopEEaa/DlvzR6vGCJst059Ye6a8RFS9Zyn1i
         /J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GueXWEXYhGgyYi6RS/iDIZfnWgS+3C26tBBCX7qsJZ4=;
        b=Dmfs/9M8OFHxKITOlf24Lt1eb6WCZuygyn6e1Gr833j0wu3t73vxKF8g9nRALSJTct
         UT7hHUFb/LyiHVJbKznDTlkxKP6lNttaB0YQODlMvf4xeYLKNZZUuOemwXrmWor2LPpQ
         fvMp8X4UxjEhMdXxyVSvEDnUhObPkA/OzsDN/odSOJvN8vdeStebZuBSHpdGRBwt2zH4
         enviZkPC8a4t2C8sVQcUiAvIWeBbeNA9hCDEyAqbGpIxqVcssu2DBEe03zts05YLIytr
         U8z3h5uBE4noTQ3T4rWxZjVaHQD/IPmksRS7xv0cf2180NIO42hlaz2K86GBD0PAkHw3
         lASw==
X-Gm-Message-State: AOAM5317O8L4ikB6LlWhvi6FWertYbwzRloCBpgzCRwywlkO2Xp3pwYq
        QpbMyIo0CIT6IoNfQ5OwQY9bZDLFiwSxfRQp36n9VQ==
X-Google-Smtp-Source: ABdhPJwdiYjJdqBFXdRtFhpC8nmjCUSyb8p3FKa6ytdypXh//VwloAzsouYK1AjcyrQSDABBs6/mkeh/pmupWOxegwo=
X-Received: by 2002:a05:651c:124b:: with SMTP id h11mr17357819ljh.401.1615303994941;
 Tue, 09 Mar 2021 07:33:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614580695.git.viresh.kumar@linaro.org> <f72383d451710fc4bc36e7e3015deba40fbe28f3.1614580695.git.viresh.kumar@linaro.org>
 <20210309151017.GA25243@arm.com>
In-Reply-To: <20210309151017.GA25243@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Mar 2021 16:33:03 +0100
Message-ID: <CAKfTPtBQ2Y249LMQOep5HdfmkOQknP0jom=6RpDOFv_TajZLWQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] cpufreq: CPPC: Add support for frequency invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 9 Mar 2021 at 16:10, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hey,
>
> On Monday 01 Mar 2021 at 12:21:18 (+0530), Viresh Kumar wrote:
> > The Frequency Invariance Engine (FIE) is providing a frequency scaling
> > correction factor that helps achieve more accurate load-tracking.
> >
> > Normally, this scaling factor can be obtained directly with the help of
> > the cpufreq drivers as they know the exact frequency the hardware is
> > running at. But that isn't the case for CPPC cpufreq driver.
> >
> > Another way of obtaining that is using the arch specific counter
> > support, which is already present in kernel, but that hardware is
> > optional for platforms.
> >
> > This patch updates the CPPC driver to register itself with the topology
> > core to provide its own implementation (cppc_scale_freq_tick()) of
> > topology_scale_freq_tick() which gets called by the scheduler on every
> > tick. Note that the arch specific counters have higher priority than
> > CPPC counters, if available, though the CPPC driver doesn't need to have
> > any special handling for that.
> >
> > On an invocation of cppc_scale_freq_tick(), we schedule an irq work
> > (since we reach here from hard-irq context), which then schedules a
> > normal work item and cppc_scale_freq_workfn() updates the per_cpu
> > freq_scale variable based on the counter updates since the last tick.
> >
> > To allow platforms to disable frequency invariance support if they want,
>                                ^
>                                this CPPC counter-based frequency invariance
>                                support..
>
> (disabling this config will not disable cpufreq or arch counter-based FIE)
>
> > this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE, which is enabled by
> > default.
> >
> > This also exports sched_setattr_nocheck() as the CPPC driver can be
> > built as a module.
> >
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm    |   9 ++
> >  drivers/cpufreq/cppc_cpufreq.c | 244 +++++++++++++++++++++++++++++++--
> >  include/linux/arch_topology.h  |   1 +
> >  kernel/sched/core.c            |   1 +
> >  4 files changed, 243 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index e65e0a43be64..a3e2d6dfea70 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -19,6 +19,15 @@ config ACPI_CPPC_CPUFREQ
> >
> >         If in doubt, say N.
> >
> > +config ACPI_CPPC_CPUFREQ_FIE
> > +     bool "Frequency Invariance support for CPPC cpufreq driver"
> > +     depends on ACPI_CPPC_CPUFREQ
>
> It also depends on GENERIC_ARCH_TOPOLOGY.
>
> > +     default y
> > +     help
> > +       This enables frequency invariance support for CPPC cpufreq driver.
>                                                     ^^^^^^^^^^^^^^^^^^^^^^^^
>                                                     s//based on CPPC counters.
>
> .. or more detailed: This extends frequency invariance support in the
> CPPC cpufreq driver, by using CPPC delivered and reference performance
> counters.
>
> > +
> > +       If in doubt, say N.
> > +
> >  config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
> >       tristate "Allwinner nvmem based SUN50I CPUFreq driver"
> >       depends on ARCH_SUNXI
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 8a482c434ea6..c4580a37a1b1 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> [..]
> > +static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
> > +                                          struct cppc_cpudata *cpu_data)
> > +{
> > +     struct cppc_freq_invariance *cppc_fi;
> > +     int i;
> > +
> > +     if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +             return;
> > +
> > +     for_each_cpu(i, policy->cpus) {
> > +             cppc_fi = &per_cpu(cppc_freq_inv, i);
> > +             cppc_fi->cpu = i;
> > +             cppc_fi->cpu_data = cpu_data;
> > +             kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> > +             init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> > +     }
> > +}
> > +
> > +static void cppc_freq_invariance_exit(void)
> > +{
> > +     struct cppc_freq_invariance *cppc_fi;
> > +     int i;
> > +
> > +     if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +             return;
> > +
> > +     topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
> > +
> > +     for_each_possible_cpu(i) {
> > +             cppc_fi = &per_cpu(cppc_freq_inv, i);
> > +             irq_work_sync(&cppc_fi->irq_work);
> > +     }
> > +
> > +     kthread_destroy_worker(kworker_fie);
> > +     kworker_fie = NULL;
> > +}
> > +
> > +static void __init cppc_freq_invariance_init(void)
> > +{
> > +     struct cppc_perf_fb_ctrs fb_ctrs = {0};
> > +     struct cppc_freq_invariance *cppc_fi;
> > +     struct sched_attr attr = {
> > +             .size           = sizeof(struct sched_attr),
> > +             .sched_policy   = SCHED_DEADLINE,
> > +             .sched_nice     = 0,
> > +             .sched_priority = 0,
> > +             /*
> > +              * Fake (unused) bandwidth; workaround to "fix"
> > +              * priority inheritance.
> > +              */
> > +             .sched_runtime  = 1000000,
> > +             .sched_deadline = 10000000,
> > +             .sched_period   = 10000000,
> > +     };
> > +     int i, ret;
> > +
> > +     if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +             return;
> > +
> > +     kworker_fie = kthread_create_worker(0, "cppc_fie");
> > +     if (IS_ERR(kworker_fie))
> > +             return;
> > +
> > +     ret = sched_setattr_nocheck(kworker_fie->task, &attr);
> > +     if (ret) {
> > +             pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
> > +                     ret);
> > +             kthread_destroy_worker(kworker_fie);
> > +             return;
> > +     }
> > +
>
> Nit: to me it makes more sense to move the code below to
> cppc_freq_invariance_policy_init(). It seems a bit strange to do part of
> the initialization of the per-cpu information there, and part here. But
> I do understand the reasons for it. Moving the code below would also
> save some cycles going through the CPUs again and will mimic the
> frequency invariance setup process in the arm64 topology, where we do
> amu_fie_setup() at policy creation time.
>
> It's not a big deal so I'll leave it up to you.
>
> > +     for_each_possible_cpu(i) {
> > +             cppc_fi = &per_cpu(cppc_freq_inv, i);
> > +
> > +             /* A policy failed to initialize, abort */
> > +             if (unlikely(!cppc_fi->cpu_data))
> > +                     return cppc_freq_invariance_exit();
> > +
> > +             ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> > +             if (ret) {
> > +                     pr_warn("%s: failed to read perf counters: %d\n",
> > +                             __func__, ret);
> > +                     return cppc_freq_invariance_exit();
> > +             }
> > +
> > +             cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> > +     }
> > +
> > +     /* Register for freq-invariance */
> > +     topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
> > +}
>
> After another very quick round of testing:
>
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>
> I did not get the chance to test on ThunderX2 yet, but if you are happy
> with your testing on it, I won't delay this any further.

I have just run some functional  tests on thx2 with rt-app: I have run
a periodic task (6ms running / 30ms periods) at different frequencies
(2.5Ghz, 2Ghz, 1.5Ghz, 1.333Ghz, 1Ghz) and the PELT signals stays the
same for all frequencies.

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>


>
> Thanks,
> Ionela.
