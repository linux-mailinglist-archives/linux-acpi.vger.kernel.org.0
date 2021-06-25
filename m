Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C2F3B4179
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFYKXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 06:23:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhFYKXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 06:23:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBCD4ED1;
        Fri, 25 Jun 2021 03:21:15 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0933F719;
        Fri, 25 Jun 2021 03:21:15 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:21:14 +0100
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
Message-ID: <20210625102113.GB15540@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Qian,

On Thursday 24 Jun 2021 at 11:17:55 (-0400), Qian Cai wrote:
> 
> 
> On 6/24/2021 6:48 AM, Ionela Voinescu wrote:
> > Not if the counters are implemented properly. The kernel considers that
> > both reference and delivered performance counters should stop or reset
> > during idle. The kernel would not account for idle itself.
> > 
> > If the reference performance counter does not stop during idle, while
> > the core performance counter (delivered) does stop, the behavior above
> > should be seen very often.
> > 
> > Qian, do you see these small delivered performance values often or
> > seldom?
> 
> Ionela, so I managed to upgrade the kernel on the system to today's
> linux-next which suppose to include this series. The delivered perf
> is now 280. However, scaling_min_freq (200 MHz) is not equal to
> lowest_perf (100).
> 
> scaling_driver: acpi_cppc
                  ^^^^^^^^^
I suppose you mean "cppc-cpufreq"?

"acpi_cppc" is not a scaling driver option.


> scaling_governor: schedutil
> 
> Is that normal because lowest_nonlinear_perf is 200? 
> 

Yes, that is right : [1]

> Also, on this pretty idle system, 158 of 160 CPUs are always running
> in max freq (280 MHz). The other 2 are running in 243 and 213 MHz
> according to scaling_cur_freq. Apparently, "schedutil" does not work
> proper on this system. I am going to try other governors to narrow
> down the issue a bit.

So your CPUs run at frequencies between 200MHz and 280MHz?
Based on your acpi_cppc information below I would have assumed 2GHz as
lowest nonlinear and 2.8GHz as nominal. The reason for this is that
according to the ACPI spec the frequency values in the _CPC objects are
supposed to be in MHz, so 2800 MHz for nominal frequency would be
2.8GHz.

When you try more governors, make sure to check out the difference
between scaling_cur_freq and cpuinfo_cur_freq at [2]. The first gives
you the frequency that the governor (schedutil) is asking for, while the
second is giving you the current frequency obtained from the counters.

So to check the actual frequency the cores are running at, please check
cpuinfo_cur_freq.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/cppc_cpufreq.c?h=v5.13-rc7#n296
[2] https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt

Thanks,
Ionela.

> 
> FYI, here is the acpi_cppc registers reading:
> 
> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs
> ref:160705801 del:449594095
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
> 300
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 1000
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
> 200
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
> 100
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
> 2800
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf
> 280
> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
> 100
> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time
> 18446744073709551615
