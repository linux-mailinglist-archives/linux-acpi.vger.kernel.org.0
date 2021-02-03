Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9930D604
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhBCJOb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 04:14:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:42128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhBCJMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Feb 2021 04:12:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B1E8AC9B;
        Wed,  3 Feb 2021 09:12:07 +0000 (UTC)
Message-ID: <1612343526.3640.23.camel@suse.cz>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Date:   Wed, 03 Feb 2021 10:12:06 +0100
In-Reply-To: <CAJZ5v0hQ_r3th5upo-X5fNBG0tUNbLbhQN-cqmDd1FGwhGx4dg@mail.gmail.com>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <CAJZ5v0hQ_r3th5upo-X5fNBG0tUNbLbhQN-cqmDd1FGwhGx4dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2021-02-02 at 19:59 +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 22, 2021 at 9:47 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > 
> 
> [cut]
> 
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 1e4fbb002a31..2378bc1bf2c4 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -27,6 +27,10 @@
> > 
> >  #include <acpi/processor.h>
> > 
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> 
> Why is the #ifdef needed here?
> 

Right, it isn't needed. The guard is necessary only later when the function
cppc_get_perf_caps() is used. I'll send a v3 with this correction.


Giovanni


> > +#include <acpi/cppc_acpi.h>
> > +#endif
> > +
> >  #include <asm/msr.h>
> >  #include <asm/processor.h>
> >  #include <asm/cpufeature.h>

