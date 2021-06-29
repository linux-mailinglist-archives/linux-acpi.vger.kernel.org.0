Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815F43B6FA1
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhF2It0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 04:49:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhF2ItZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 04:49:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4121D6E;
        Tue, 29 Jun 2021 01:46:57 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53DC83F694;
        Tue, 29 Jun 2021 01:46:57 -0700 (PDT)
Date:   Tue, 29 Jun 2021 09:46:55 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210629084655.GA2425@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <20210628115452.GA28797@arm.com>
 <20210629052028.srt6metmtylsxukw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629052028.srt6metmtylsxukw@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Tuesday 29 Jun 2021 at 10:50:28 (+0530), Viresh Kumar wrote:
> On 28-06-21, 12:54, Ionela Voinescu wrote:
> > If you happen to have the data around, I would like to know more about
> > your observations on ThunderX2.
> > 
> > 
> > I tried ThunderX2 as well, with the following observations:
> > 
> > Booting with userspace governor and all CPUs online, the CPPC frequency
> > scale factor was all over the place (even much larger than 1024).
> > 
> > My initial assumptions:
> >  - Counters do not behave properly in light of SMT
> >  - Firmware does not do a good job to keep the reference and core
> >    counters monotonic: save and restore at core off.
> > 
> > So I offlined all CPUs with the exception of 0, 32, 64, 96 - threads of
> > a single core (part of policy0). With this all works very well:
> 
> Interesting.
> 
> > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1056000 > scaling_setspeed
> > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > [ 1863.095370] CPU96: cppc scale: 697.
> > [ 1863.175370] CPU0: cppc scale: 492.
> > [ 1863.215367] CPU64: cppc scale: 492.
> > [ 1863.235366] CPU96: cppc scale: 492.
> > [ 1863.485368] CPU32: cppc scale: 492.
> > 
> > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1936000 > scaling_setspeed
> > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > [ 1891.395363] CPU96: cppc scale: 558.
> > [ 1891.415362] CPU0: cppc scale: 595.
> > [ 1891.435362] CPU32: cppc scale: 615.
> > [ 1891.465363] CPU96: cppc scale: 635.
> > [ 1891.495361] CPU0: cppc scale: 673.
> > [ 1891.515360] CPU32: cppc scale: 703.
> > [ 1891.545360] CPU96: cppc scale: 738.
> > [ 1891.575360] CPU0: cppc scale: 779.
> > [ 1891.605360] CPU96: cppc scale: 829.
> > [ 1891.635360] CPU0: cppc scale: 879.
> > 
> > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 2200000 > scaling_setspeed
> > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > [ 1896.585363] CPU32: cppc scale: 1004.
> > [ 1896.675359] CPU64: cppc scale: 973.
> > [ 1896.715359] CPU0: cppc scale: 1024.
> > 
> > I'm doing a rate limited printk only for increase/decrease values over
> > 64 in the scale factor value.
> > 
> > This showed me that SMT is handled properly.
> > 
> > Then, as soon as I start onlining CPUs 1, 33, 65, 97, the scale factor
> > stops being even close to correct, for example:
> > 
> > [238394.770328] CPU96: cppc scale: 22328.
> > [238395.628846] CPU96: cppc scale: 245.
> > [238516.087115] CPU96: cppc scale: 930.
> > [238523.385009] CPU96: cppc scale: 245.
> > [238538.767473] CPU96: cppc scale: 936.
> > [238538.867546] CPU96: cppc scale: 245.
> > [238599.367932] CPU97: cppc scale: 2728.
> > [238599.859865] CPU97: cppc scale: 452.
> > [238647.786284] CPU96: cppc scale: 1438.
> > [238669.604684] CPU96: cppc scale: 27306.
> > [238676.805049] CPU96: cppc scale: 245.
> > [238737.642902] CPU97: cppc scale: 2035.
> > [238737.664995] CPU97: cppc scale: 452.
> > [238788.066193] CPU96: cppc scale: 2749.
> > [238788.110192] CPU96: cppc scale: 245.
> > [238817.231659] CPU96: cppc scale: 2698.
> > [238818.083687] CPU96: cppc scale: 245.
> > [238845.466850] CPU97: cppc scale: 2990.
> > [238847.477805] CPU97: cppc scale: 452.
> > [238936.984107] CPU97: cppc scale: 1590.
> > [238937.029079] CPU97: cppc scale: 452.
> > [238979.052464] CPU97: cppc scale: 911.
> > [238980.900668] CPU97: cppc scale: 452.
> > [239149.587889] CPU96: cppc scale: 803.
> > [239151.085516] CPU96: cppc scale: 245.
> > [239303.871373] CPU64: cppc scale: 956.
> > [239303.906837] CPU64: cppc scale: 245.
> > [239308.666786] CPU96: cppc scale: 821.
> > [239319.440634] CPU96: cppc scale: 245.
> > [239389.978395] CPU97: cppc scale: 4229.
> > [239391.969562] CPU97: cppc scale: 452.
> > [239415.894738] CPU96: cppc scale: 630.
> > [239417.875326] CPU96: cppc scale: 245.
> > 
> > The counter values shown by feedback_ctrs do not seem monotonic even
> > when only core 0 threads are online.
> > 
> > ref:2812420736 del:166051103
> > ref:3683620736 del:641578595
> > ref:1049653440 del:1548202980
> > ref:2099053440 del:2120997459
> > ref:3185853440 del:2714205997
> > ref:712486144  del:3708490753
> > ref:3658438336 del:3401357212
> > ref:1570998080 del:2279728438
> > 
> > For now I was just wondering if you have seen the same and whether you
> > have an opinion on this.
> 
> I think we also saw numbers like this, which didn't explain a lot on
> ThunderX2. We thought they may be due to rounding issues, but the
> offlining stuff adds an interesting factor to that.
> 

More testing last night showed that having 1 core (with all 4 threads)
online per socket works fine, while having 2 cores online per socket
gives these bad values. My assumption is that the counters reset to 0
at core off which introduces the behavior. When there is a single core
per socket, this single core cannot be turned off.

I tried to boot with less CPUs and cpuidle.off=1 but it did not make a
difference. I expect much of the idle control to be in
hardware/firmware, so possibly cores were still turned off.

I'll do more research on idle state management for SMT and debugging
to see if it explains more, but it will take longer as I've ignored a
few other responsibilities in the meantime.

Thanks,
Ionela.

> -- 
> viresh
