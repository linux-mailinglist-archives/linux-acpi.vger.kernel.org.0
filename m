Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC230DB8A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhBCNlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 08:41:08 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:32872 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhBCNkz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 08:40:55 -0500
Received: by mail-oo1-f45.google.com with SMTP id u7so6020490ooq.0;
        Wed, 03 Feb 2021 05:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAG2ORrJOSGIc7ykt4Jaj4cXkoSE9ZmRI1sEKOlUH8E=;
        b=PhpseIQ7HbXBQPVzhJGTrmZsOPUGXkFxLjtqmdsonvWN1W4F0ODYkz2MrJ1fU4fpKL
         lvuyw6BVuvxSE493fTLJD8QUKdHrS5FG1tmlycFNMDzAd5/z03/iHRETertE7lpivV1H
         C7mahhx7N2iJ8KKFxE/+EHaZRLuzMHuMijgxpaX3Yj9FVx0a0tU28/NUqlGw7i6/zACM
         Mb+qFJAWn+WMam2YuFR4lJ6aN8oqIlbnAkd9WV6GpnSBshbILoa5h7dHjRRFNGLhE5tI
         KfpBoK4dqd5SKEGozATzV+7gHZllgouN0OYT6eTZmaZBd1dVBmejQxf7uEjt1tJKNldl
         rJsw==
X-Gm-Message-State: AOAM532zfnnsP7CuFqvESHDNnBe7Vfvx9WIIAssoYXD+cHWPCTOcn9ux
        C0npWapnTiha6pct+bo155+jnqhJL3+bHfRHEK0=
X-Google-Smtp-Source: ABdhPJznq67sM7X2NqxYyznZ/cNjiEpWbWJjVSPRblRmQj7rDdHbTumwwKR+SgAw1TSA8/C7nESxIFPERtQAnrzcSTw=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr2107388ooi.44.1612359614153;
 Wed, 03 Feb 2021 05:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <CAJZ5v0hQ_r3th5upo-X5fNBG0tUNbLbhQN-cqmDd1FGwhGx4dg@mail.gmail.com>
 <CAJZ5v0jsF-_8GzQgqZH10bf0oUTmALiT1kVcjDqYgGPqx9iKZg@mail.gmail.com> <1612341564.3640.14.camel@suse.cz>
In-Reply-To: <1612341564.3640.14.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Feb 2021 14:40:01 +0100
Message-ID: <CAJZ5v0jdcxFBxqYjvTfO64v3Vij1ATp4_GMJKdQCvAysM4gbjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 3, 2021 at 9:39 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Hello,
>
> both Rafael and Viresh make a similar remark: why adding a new "max_boost"
> variable, since "max_freq" is already available and could be used instead.
>
> Replying here to both.
>
> On Tue, 2021-02-02 at 20:26 +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 2, 2021 at 7:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 9:47 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > >
> > > [cut]
> > > > @@ -779,15 +829,25 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > >                     freq_table[valid_states-1].frequency / 1000)
> > > >                         continue;
> > > >
> > > > +               freq = perf->states[i].core_frequency * 1000;
> > > >                 freq_table[valid_states].driver_data = i;
> > > > -               freq_table[valid_states].frequency =
> > > > -                   perf->states[i].core_frequency * 1000;
> > > > +               freq_table[valid_states].frequency = freq;
> > > > +
> > > > +               if (freq > max_freq)
> > > > +                       max_freq = freq;
> > > > +
> > > >                 valid_states++;
> > > >         }
> > > >         freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> > > >         policy->freq_table = freq_table;
> > > >         perf->state = 0;
> > > >
> > > > +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> > > > +           amd_max_boost(max_freq, &max_boost)) {
> > > > +               policy->cpuinfo.max_boost = max_boost;
> > >
> > > Why not to set max_freq to max_boost instead?
> >
> > I mean, would setting the frequency in the last table entry to max_boost work?
> >
> > Alternatively, one more (artificial) entry with the frequency equal to
> > max_boost could be added.
>
> On Wed, 2021-02-03 at 11:34 +0530, Viresh Kumar wrote:
> > [cut]
> >
> > On 22-01-21, 21:40, Giovanni Gherdovich wrote:
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 6931f0cdeb80..541f3db3f576 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -159,8 +159,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > >                               unsigned long util, unsigned long max)
> > >  {
> > >     struct cpufreq_policy *policy = sg_policy->policy;
> > > -   unsigned int freq = arch_scale_freq_invariant() ?
> > > -                           policy->cpuinfo.max_freq : policy->cur;
> > > +   unsigned int freq, max_freq;
> > > +
> > > +   max_freq = cpufreq_driver_has_max_boost() ?
> > > +                   policy->cpuinfo.max_boost : policy->cpuinfo.max_freq;
> >
> > Also, can't we update max_freq itself from the cpufreq driver? What
> > troubles will it cost ?
>
> I could add the max boost frequency to the frequency table (and
> policy->cpuinfo.max_freq would follow), yes, but that would trigger the
> following warning from acpi-cpufreq.c:
>
> static void acpi_cpufreq_cpu_ready(struct cpufreq_policy *policy)
> {
>         struct acpi_processor_performance *perf = per_cpu_ptr(acpi_perf_data,
>                                                               policy->cpu);
>
>         if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
> }

This check can be changed, though.

> so I thought that to stay out of troubles I'd supply a different variable,
> max_boost, to be used only in the schedutil formula.

Which is not necessary and the extra static branch is not necessary.

Moreover, there is no reason whatsoever to believe that EPYC is the
only affected processor model.  If I'm not mistaken, the regression
will be visible on every CPU where the scale invariance algorithm uses
the max frequency greater than the max frequency used acpi_cpufreq.

Also, AFAICS, it should be sufficient to modify acpi_cpufreq to remedy
this for all of the affected CPUs, not just EPYC.

> After schedutil figures out a desired next_freq then the usual comparison with the
> firmware-supplied frequency table could take place.
>
> Altering the frequency table seemed more invasive because once a freq value is
> in there, it's going to be actually requested by the driver to the platform.

This need not be the case if the control structure for the new entry
is copied from an existing one.

> I only want my max_boost to stretch the range of schedutil's next_freq.

Right, but that can be done in a different way which would be cleaner too IMO.

I'm going to send an alternative patch to fix this problem.

> On Tue, 2021-02-02 at 19:59 +0100, Rafael J. Wysocki wrote:
> >
> > [cut]
> > Also notice that the static branch is global and the max_boost value
> > for different CPUs may be different, at least in theory.
>
> In theory yes, but I'm guarding the code with two conditions:
>
> * vendor is X86_VENDOR_AMD
> * cppc_get_perf_caps() returns success
>
> this identifies AMD EPYC cpus with model 7xx2 and later, where max_boost is
> the same on all cores. I may have added synchronization so that only one cpu
> sets the value, but I didn't in the interest of simplicity for an -rc patch
> (I'd have to consider hotplug, the maxcpus= command line param, ecc).

And what about the other potentially affected processors?

I wouldn't worry about the -rc time frame too much.  If we can do a
better fix now, let's do it.
