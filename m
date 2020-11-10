Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95052ADEA6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgKJSp2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 13:45:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:49622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJSp2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 13:45:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ABCCABD1;
        Tue, 10 Nov 2020 18:45:26 +0000 (UTC)
Message-ID: <1605033925.14855.15.camel@suse.cz>
Subject: Re: [PATCH 1/3] x86, sched: Calculate frequency invariance for AMD
 systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Tue, 10 Nov 2020 19:45:25 +0100
In-Reply-To: <20201110094956.GZ2594@hirez.programming.kicks-ass.net>
References: <20201110083936.31994-1-ggherdovich@suse.cz>
         <20201110083936.31994-2-ggherdovich@suse.cz>
         <20201110094956.GZ2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2020-11-10 at 10:49 +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 09:39:34AM +0100, Giovanni Gherdovich wrote:
> 
> > +#ifdef CONFIG_ACPI
> > +void init_freq_invariance_cppc(void)
> > +{
> > +	init_freq_invariance(false, true);
> > +
> > +	if (static_branch_likely(&arch_scale_freq_key))
> > +		on_each_cpu(init_counter_refs, NULL, 0);
> > +}
> > +#endif
> > +
> >  static void disable_freq_invariance_workfn(struct work_struct *work)
> >  {
> >  	static_branch_disable(&arch_scale_freq_key);
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 7a99b19bb893..e1969ff876ff 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/ktime.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/wait.h>
> > +#include <linux/topology.h>
> >  
> >  #include <acpi/cppc_acpi.h>
> >  
> > @@ -850,6 +851,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >  		goto out_free;
> >  	}
> >  
> > +	/* Only needed once, so call on CPU0 */
> > +	if (pr->id == 0)
> > +		init_freq_invariance_cppc();
> > +
> 
> This seems broken vs lovely things like booting with maxcpus= or
> physical hotplug where you add logical CPUs.

Right.

> 
> Given the latter hunk limits it to one invocation (is phys_id 0
> guaranteed to exist? Can a BIOS monkey screw us over?) only to then call
> it on all CPUs, shouldn't this be changed to let
> acpi_cppc_processor_probe() call it for every CPU that comes online?

I sent a V2 that basically does that, it just makes sure that
"init_freq_invariance(secondary=false)" is called only once (the first CPU
that gets there), and init_counter_refs() instead is called by all.

Which makes me think, I could make better use of the "secondary" argument
to init_freq_invariance() and trim a couple of lines from
init_freq_invariance_cppc().


Giovanni





