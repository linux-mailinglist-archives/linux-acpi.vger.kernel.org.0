Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DA3B45DC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFYOkD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 10:40:03 -0400
Received: from foss.arm.com ([217.140.110.172]:57492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhFYOjg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E6D61042;
        Fri, 25 Jun 2021 07:37:15 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F26903F694;
        Fri, 25 Jun 2021 07:37:14 -0700 (PDT)
Date:   Fri, 25 Jun 2021 15:37:13 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210625143713.GA7092@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

On Friday 25 Jun 2021 at 09:31:58 (-0400), Qian Cai wrote:
> 
> 
> On 6/25/2021 6:21 AM, Ionela Voinescu wrote:
> >> scaling_driver: acpi_cppc
> >                   ^^^^^^^^^
> > I suppose you mean "cppc-cpufreq"?
> > 
> > "acpi_cppc" is not a scaling driver option.
> 
> Ionela, yes. Sorry about that.
> 
> > So your CPUs run at frequencies between 200MHz and 280MHz?
> 
> 2000 to 2800 MHz.
> 

Thank you for the clarification.

> > Based on your acpi_cppc information below I would have assumed 2GHz as
> > lowest nonlinear and 2.8GHz as nominal. The reason for this is that
> > according to the ACPI spec the frequency values in the _CPC objects are
> > supposed to be in MHz, so 2800 MHz for nominal frequency would be
> > 2.8GHz.
> > 
> > When you try more governors, make sure to check out the difference
> > between scaling_cur_freq and cpuinfo_cur_freq at [2]. The first gives
> > you the frequency that the governor (schedutil) is asking for, while the
> > second is giving you the current frequency obtained from the counters.
> > 
> > So to check the actual frequency the cores are running at, please check
> > cpuinfo_cur_freq.
> 
> The problem is that all CPUs are never scaling down. "cpuinfo_cur_freq"
> and "scaling_cur_freq" are always the 2800 MHz on all CPUs on this idle
> system. This looks like a regression somewhere as in 5.4-based kernel,
> I can see "cpuinfo_cur_freq" can go down to 2000 MHz in the same
> scenario. I'll bisect a bit unless you have better ideas?

Quick questions for you:

1. When you say you tried a 5.4 kernel, did you try it with these
patches backported? They also have some dependencies with the recent
changes in the arch topology driver and cpufreq so they would not be
straight forward to backport.

If the 5.4 kernel you tried did not have these patches, it might be best
to try next/master that has these patches, but with
CONFIG_ACPI_CPPC_CPUFREQ_FIE=n, just to eliminate the possibility that
an incorrect frequency scale factor here would affect utilization that
would then affect the schedutil frequency selection. I would not expect
this behavior even if the scale factor was wrong, but it would be good
to rule out.

2. Is your platform booting with all CPUs? Are any hotplug operations
done in your scenario?

Thanks,
Ionela.
