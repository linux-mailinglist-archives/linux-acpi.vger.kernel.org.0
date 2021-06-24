Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CA3B2CD0
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jun 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhFXKu3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Jun 2021 06:50:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhFXKu2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Jun 2021 06:50:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90EA231B;
        Thu, 24 Jun 2021 03:48:09 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9173F718;
        Thu, 24 Jun 2021 03:48:09 -0700 (PDT)
Date:   Thu, 24 Jun 2021 11:48:07 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
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
Message-ID: <20210624104734.GA11487@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

On Thursday 24 Jun 2021 at 11:49:53 (+0200), Vincent Guittot wrote:
> On Thu, 24 Jun 2021 at 04:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 23-06-21, 08:57, Qian Cai wrote:
> > > Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in
> > > development, and will provide an update once ready.
> >
> > Oh sure, np.
> >
> > > Also, I noticed the delivered perf is even smaller than lowest_perf (100).
> >
> > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > >  ref:103377547901 del:54540736873
> > > # cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
> > >  ref:103379170101 del:54541599117
> > >
> > > 100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53
> 
> I'm not sure that I understand your point. The formula above says that
> cpu8 run @ 53% of nominal performance
> 

I think this is based on a previous example Qian had where:

/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
300
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
1000
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
100
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
100

..so the 100 is not from obtaining percentage, is the reference
performance.

The logic of the formula is to obtain the delivered performance when
knowing the number of ticks for each counter, so:

So if one gets (103379170101 - 103377547901) ticks for the counter at
running at 1GHz(perf 100), what is the frequency of the core, if its
counter ticked (54541599117 - 54540736873) times in the same interval
of time?

The answer is 530MHz(perf 53), which is lower than the lowest frequency
at 1GHz(perf 100).


> > >
> > > My understanding is that the delivered perf should fail into the range between
> > > lowest_perf and highest_perf. Is that assumption correct? This happens on
> > > 5.4-based kernel, so I am in process running your series on that system to see
> > > if there is any differences. In any case, if it is a bug it is pre-existing,
> > > but I'd like to understand a bit better in that front first.
> >
> > Vincent:
> >
> > Can that happen because of CPU idle ?
> >

Not if the counters are implemented properly. The kernel considers that
both reference and delivered performance counters should stop or reset
during idle. The kernel would not account for idle itself.

If the reference performance counter does not stop during idle, while
the core performance counter (delivered) does stop, the behavior above
should be seen very often.

Qian, do you see these small delivered performance values often or
seldom?

Thanks,
Ionela.

> > --
> > viresh
