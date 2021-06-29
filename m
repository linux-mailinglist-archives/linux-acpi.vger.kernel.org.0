Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256273B6FDD
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhF2JIa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 05:08:30 -0400
Received: from foss.arm.com ([217.140.110.172]:46732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhF2JIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 05:08:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BCAED6E;
        Tue, 29 Jun 2021 02:06:03 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6143F694;
        Tue, 29 Jun 2021 02:06:02 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:06:01 +0100
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
Message-ID: <20210629090553.GC2425@arm.com>
References: <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
 <20210625143713.GA7092@arm.com>
 <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Qian,

Sorry for the delay. I was trying to run tests on ThunderX2 as well, as
it can give me more control over testing, to get more insight on this.

On Friday 25 Jun 2021 at 22:29:26 (-0400), Qian Cai wrote:
> 
> 
> On 6/25/2021 10:37 AM, Ionela Voinescu wrote:
> > Quick questions for you:
> > 
> > 1. When you say you tried a 5.4 kernel, did you try it with these
> > patches backported? They also have some dependencies with the recent
> > changes in the arch topology driver and cpufreq so they would not be
> > straight forward to backport.
> > 
> > If the 5.4 kernel you tried did not have these patches, it might be best
> > to try next/master that has these patches, but with
> > CONFIG_ACPI_CPPC_CPUFREQ_FIE=n, just to eliminate the possibility that
> > an incorrect frequency scale factor here would affect utilization that
> > would then affect the schedutil frequency selection. I would not expect
> > this behavior even if the scale factor was wrong, but it would be good
> > to rule out.
> > 
> > 2. Is your platform booting with all CPUs? Are any hotplug operations
> > done in your scenario?
> 
> Ionela, I found that set ACPI_PROCESSOR=y instead of ACPI_PROCESSOR=m
> will fix the previous mentioned issues here (any explanations of that?)
> even though the scaling down is not perfect. Now, we have the following
> on this idle system:
> 

I don't see how this would have played a role. The cppc cpufreq driver
depends on functionality gated by CONFIG_ACPI_CPPC_LIB which in turn
needs CONFIG_ACPI_PROCESSOR to trigger the parsing of the _CPC objects.
If CONFIG_ACPI_PROCESSOR functionality is not built in or loaded, the
cppc cpufreq driver could not be used at all.

> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
>  	79 1000000
>   	1 1160000
>  	73 1400000
>   	1 2000000
>   	4 2010000
>   	1 2800000
>   	1 860000
> 
> Even if I rerun a few times, there could still have a few CPUs running
> lower than lowest_perf (1GHz). Also, even though I set all CPUs to use
> "userspace" governor and set freq to the lowest. A few CPUs keep changing
> at will.
> 

I do not believe getting values lower than lowest is worrying as long as
they are not much much lower and they don't happen very often. First of
all firmware has control over CPU frequencies and it can decide to
select a lower frequency if it wishes.

Looking at the fact that it only happens rarely in your tests, it's also
possible that this is introduced by the fact that the CPU only spends
only a few cycles in active state. That would reduce the resolution of
the computed current performance level, which results in a lower value
when converted to frequency.

Hope it helps,
Ionela.

> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
> 	156 1000000
>   	3 2000000
>   	1 760000
