Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F218030D576
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhBCIkf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 03:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhBCIkH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Feb 2021 03:40:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B919AC9B;
        Wed,  3 Feb 2021 08:39:25 +0000 (UTC)
Message-ID: <1612341564.3640.14.camel@suse.cz>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Wed, 03 Feb 2021 09:39:24 +0100
In-Reply-To: <CAJZ5v0jsF-_8GzQgqZH10bf0oUTmALiT1kVcjDqYgGPqx9iKZg@mail.gmail.com>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <CAJZ5v0hQ_r3th5upo-X5fNBG0tUNbLbhQN-cqmDd1FGwhGx4dg@mail.gmail.com>
         <CAJZ5v0jsF-_8GzQgqZH10bf0oUTmALiT1kVcjDqYgGPqx9iKZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

both Rafael and Viresh make a similar remark: why adding a new "max_boost"
variable, since "max_freq" is already available and could be used instead.

Replying here to both.

On Tue, 2021-02-02 at 20:26 +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 2, 2021 at 7:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > 
> > On Fri, Jan 22, 2021 at 9:47 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > 
> > [cut]
> > > @@ -779,15 +829,25 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > >                     freq_table[valid_states-1].frequency / 1000)
> > >                         continue;
> > > 
> > > +               freq = perf->states[i].core_frequency * 1000;
> > >                 freq_table[valid_states].driver_data = i;
> > > -               freq_table[valid_states].frequency =
> > > -                   perf->states[i].core_frequency * 1000;
> > > +               freq_table[valid_states].frequency = freq;
> > > +
> > > +               if (freq > max_freq)
> > > +                       max_freq = freq;
> > > +
> > >                 valid_states++;
> > >         }
> > >         freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> > >         policy->freq_table = freq_table;
> > >         perf->state = 0;
> > > 
> > > +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> > > +           amd_max_boost(max_freq, &max_boost)) {
> > > +               policy->cpuinfo.max_boost = max_boost;
> > 
> > Why not to set max_freq to max_boost instead?
> 
> I mean, would setting the frequency in the last table entry to max_boost work?
> 
> Alternatively, one more (artificial) entry with the frequency equal to
> max_boost could be added.

On Wed, 2021-02-03 at 11:34 +0530, Viresh Kumar wrote:
> [cut]
> 
> On 22-01-21, 21:40, Giovanni Gherdovich wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 6931f0cdeb80..541f3db3f576 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -159,8 +159,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  				  unsigned long util, unsigned long max)
> >  {
> >  	struct cpufreq_policy *policy = sg_policy->policy;
> > -	unsigned int freq = arch_scale_freq_invariant() ?
> > -				policy->cpuinfo.max_freq : policy->cur;
> > +	unsigned int freq, max_freq;
> > +
> > +	max_freq = cpufreq_driver_has_max_boost() ?
> > +			policy->cpuinfo.max_boost : policy->cpuinfo.max_freq;
> 
> Also, can't we update max_freq itself from the cpufreq driver? What
> troubles will it cost ?

I could add the max boost frequency to the frequency table (and
policy->cpuinfo.max_freq would follow), yes, but that would trigger the
following warning from acpi-cpufreq.c:

static void acpi_cpufreq_cpu_ready(struct cpufreq_policy *policy)
{
        struct acpi_processor_performance *perf = per_cpu_ptr(acpi_perf_data,
                                                              policy->cpu);

        if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
                pr_warn(FW_WARN "P-state 0 is not max freq\n");
}

so I thought that to stay out of troubles I'd supply a different variable,
max_boost, to be used only in the schedutil formula. After schedutil
figures out a desired next_freq then the usual comparison with the
firmware-supplied frequency table could take place.

Altering the frequency table seemed more invasive because once a freq value is
in there, it's going to be actually requested by the driver to the platform. I
only want my max_boost to stretch the range of schedutil's next_freq.

On Tue, 2021-02-02 at 19:59 +0100, Rafael J. Wysocki wrote:
> 
> [cut]
> Also notice that the static branch is global and the max_boost value
> for different CPUs may be different, at least in theory.

In theory yes, but I'm guarding the code with two conditions:

* vendor is X86_VENDOR_AMD
* cppc_get_perf_caps() returns success

this identifies AMD EPYC cpus with model 7xx2 and later, where max_boost is
the same on all cores. I may have added synchronization so that only one cpu
sets the value, but I didn't in the interest of simplicity for an -rc patch
(I'd have to consider hotplug, the maxcpus= command line param, ecc).


Giovanni
