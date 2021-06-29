Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF53B6F9F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 10:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhF2IsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhF2IsD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 04:48:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569BC061766
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 01:45:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r16so29932070ljk.9
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVomD5CDSzti+kcx9erz3179RCoXuLxodIbdBfuqC7Y=;
        b=eA2IXxgbmvglmGogH7AQXjkdXiemY2anQRa1JPpPkWllxjzb41GnayaTE8m89ZHEZr
         nMt427rkS6e7Y9IMpx/UWMdeh2B93rBA5C8mSU9Yc1yvW9RUmCjWVzmvqau2eEDTKzWZ
         EuRURuvbZM2jl6hn6btJPb4UMdZ57dqhjTqJ96UvsMftE2q/LCKVhuvtnkV9OBubvKai
         NJPs5HTjVHUot3RkZbxocO99PlwHk1cD2xZnvbBAFXI/s2/3f6D0CV3B1XegnsyPJfOY
         JZBSqs6w2JLoUTSu9SBIIVbOMN4TJUQL5aALAaurfQnimJqHsJcHt4iok801qj0gQ1NY
         /MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVomD5CDSzti+kcx9erz3179RCoXuLxodIbdBfuqC7Y=;
        b=XThKx7BuPe1WfJkLzLYE9yZm7pJdIQNZQ4xLNdjdCVxzRd1Jc/8tvnTIbAk2UEamyF
         JeKuEqaCZUBsBVb3GxMdeNd+I0vCdCU+KfYYXMaEInC5bc5renDD2D2EDSOU8JcHv249
         RHzx5cgWai/kiIX9Tq9NwRlFTE0oQXIkN3nsxJFoO78rYEBuQjWteiq+8gBpO11892cL
         K4SiJEXHi4NYnqa/KLhbaXwpdaM6YQ3849+h42tPhPnIaaAgolMc9oNQmY7SVFapWNtM
         5QqDoaWCuIzlIn6gVU4IJ9mvbI123rqdl7cX5SIm7m+LOyvNelJzmDMBE1jW2EDFR8gX
         XKFw==
X-Gm-Message-State: AOAM533EM+sXSTLTNv4yv07Cy0nxivH78tnpbfGFIPZjqYD/YUb4wAs3
        xYX8tBUIM61dh8r1jURTYulPzfv6Ckl7NBbCYb16dQ==
X-Google-Smtp-Source: ABdhPJzahPwNth63hBm7bfM3ezTdrLmxxfJSIcFPGmKIkdTq7lJJCdti55q9ZN7prwKILocgGrUAD+dPcQtnl2kufsg=
X-Received: by 2002:a2e:9a8a:: with SMTP id p10mr3105876lji.221.1624956333911;
 Tue, 29 Jun 2021 01:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624266901.git.viresh.kumar@linaro.org> <20210628115452.GA28797@arm.com>
 <CAKfTPtAtE1WHA19=BrWyekHgFYVn0+LdTLROJzYRdshp-EYOWA@mail.gmail.com>
 <20210628130813.GA18112@arm.com> <20210628213739.GA8222@arm.com>
In-Reply-To: <20210628213739.GA8222@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Jun 2021 10:45:22 +0200
Message-ID: <CAKfTPtAyJFgDejbx3eJRTGhcx_Yr325L49nNXsrNpmYEdzHxMA@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
        Qian Cai <quic_qiancai@quicinc.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 28 Jun 2021 at 23:37, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Monday 28 Jun 2021 at 14:08:13 (+0100), Ionela Voinescu wrote:
> > On Monday 28 Jun 2021 at 14:14:14 (+0200), Vincent Guittot wrote:
> > > On Mon, 28 Jun 2021 at 13:54, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > > >
> > > > Hi guys,
> > > >
> > > > On Monday 21 Jun 2021 at 14:49:33 (+0530), Viresh Kumar wrote:
> > > > > Hello,
> > > > >
> > > > > Changes since V2:
> > > > >
> > > > > - We don't need start_cpu() and stop_cpu() callbacks anymore, we can make it
> > > > >   work using policy ->init() and exit() alone.
> > > > >
> > > > > - Two new cleanup patches 1/4 and 2/4.
> > > > >
> > > > > - Improved commit log of 3/4.
> > > > >
> > > > > - Dropped WARN_ON(local_freq_scale > 1024), since this can occur on counter's
> > > > >   overlap (seen with Vincent's setup).
> > > > >
> > > >
> > > > If you happen to have the data around, I would like to know more about
> > > > your observations on ThunderX2.
> > > >
> > > >
> > > > I tried ThunderX2 as well, with the following observations:
> > > >
> > > > Booting with userspace governor and all CPUs online, the CPPC frequency
> > > > scale factor was all over the place (even much larger than 1024).
> > > >
> > > > My initial assumptions:
> > > >  - Counters do not behave properly in light of SMT
> > > >  - Firmware does not do a good job to keep the reference and core
> > > >    counters monotonic: save and restore at core off.
> > > >
> > > > So I offlined all CPUs with the exception of 0, 32, 64, 96 - threads of
> > > > a single core (part of policy0). With this all works very well:
> > > >
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1056000 > scaling_setspeed
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > > > [ 1863.095370] CPU96: cppc scale: 697.
> > > > [ 1863.175370] CPU0: cppc scale: 492.
> > > > [ 1863.215367] CPU64: cppc scale: 492.
> > > > [ 1863.235366] CPU96: cppc scale: 492.
> > > > [ 1863.485368] CPU32: cppc scale: 492.
> > > >
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 1936000 > scaling_setspeed
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > > > [ 1891.395363] CPU96: cppc scale: 558.
> > > > [ 1891.415362] CPU0: cppc scale: 595.
> > > > [ 1891.435362] CPU32: cppc scale: 615.
> > > > [ 1891.465363] CPU96: cppc scale: 635.
> > > > [ 1891.495361] CPU0: cppc scale: 673.
> > > > [ 1891.515360] CPU32: cppc scale: 703.
> > > > [ 1891.545360] CPU96: cppc scale: 738.
> > > > [ 1891.575360] CPU0: cppc scale: 779.
> > > > [ 1891.605360] CPU96: cppc scale: 829.
> > > > [ 1891.635360] CPU0: cppc scale: 879.
> > > >
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0# echo 2200000 > scaling_setspeed
> > > > root@target:/sys/devices/system/cpu/cpufreq/policy0#
> > > > [ 1896.585363] CPU32: cppc scale: 1004.
> > > > [ 1896.675359] CPU64: cppc scale: 973.
> > > > [ 1896.715359] CPU0: cppc scale: 1024.
> > > >
> > > > I'm doing a rate limited printk only for increase/decrease values over
> > > > 64 in the scale factor value.
> > > >
> > > > This showed me that SMT is handled properly.
> > > >
> > > > Then, as soon as I start onlining CPUs 1, 33, 65, 97, the scale factor
> > > > stops being even close to correct, for example:
> > > >
> > > > [238394.770328] CPU96: cppc scale: 22328.
> > > > [238395.628846] CPU96: cppc scale: 245.
> > > > [238516.087115] CPU96: cppc scale: 930.
> > > > [238523.385009] CPU96: cppc scale: 245.
> > > > [238538.767473] CPU96: cppc scale: 936.
> > > > [238538.867546] CPU96: cppc scale: 245.
> > > > [238599.367932] CPU97: cppc scale: 2728.
> > > > [238599.859865] CPU97: cppc scale: 452.
> > > > [238647.786284] CPU96: cppc scale: 1438.
> > > > [238669.604684] CPU96: cppc scale: 27306.
> > > > [238676.805049] CPU96: cppc scale: 245.
> > > > [238737.642902] CPU97: cppc scale: 2035.
> > > > [238737.664995] CPU97: cppc scale: 452.
> > > > [238788.066193] CPU96: cppc scale: 2749.
> > > > [238788.110192] CPU96: cppc scale: 245.
> > > > [238817.231659] CPU96: cppc scale: 2698.
> > > > [238818.083687] CPU96: cppc scale: 245.
> > > > [238845.466850] CPU97: cppc scale: 2990.
> > > > [238847.477805] CPU97: cppc scale: 452.
> > > > [238936.984107] CPU97: cppc scale: 1590.
> > > > [238937.029079] CPU97: cppc scale: 452.
> > > > [238979.052464] CPU97: cppc scale: 911.
> > > > [238980.900668] CPU97: cppc scale: 452.
> > > > [239149.587889] CPU96: cppc scale: 803.
> > > > [239151.085516] CPU96: cppc scale: 245.
> > > > [239303.871373] CPU64: cppc scale: 956.
> > > > [239303.906837] CPU64: cppc scale: 245.
> > > > [239308.666786] CPU96: cppc scale: 821.
> > > > [239319.440634] CPU96: cppc scale: 245.
> > > > [239389.978395] CPU97: cppc scale: 4229.
> > > > [239391.969562] CPU97: cppc scale: 452.
> > > > [239415.894738] CPU96: cppc scale: 630.
> > > > [239417.875326] CPU96: cppc scale: 245.
> > > >
> > >
> > > With the counter being 32bits and the freq scaling being update at
> > > tick, you can easily get a overflow on it in idle system. I can easily
> > > imagine that when you unplug CPUs there is enough activity on the CPU
> > > to update it regularly whereas with all CPUs, the idle time is longer
> > > that the counter overflow
>
> For sane counters, how long the CPU is idle should not matter (please
> see below my definition of sane counters).
>
> > >
> >
> > Thanks! Yes, given the high wraparound time I thought they were 64 bit.
> > All variables in software are 64 bit, but looking at bit width in the
> > _CPC entries, the platform counters are 32 bit counters.
> >
>
> I've looked a bit more over the code, and considering this particular
> system (32 bit counters, maximum frequency of CPUs = 2.2GHz), I believe
> the wraparound is considered, and this should not cause these strange
> values in the scale factor.
>
> I consider the counters sane if both stop during idle - either they stop
> when CPU is clock gated, or some firmware does save/restore at core off.
> Therefore, in all idle cases they seem to have stopped, from the point of
> view of the OS. The ACPI spec mentions that both count "any time the
> processor is active".
>
> After the cores return from idle, the counters will wraparound at a
> minimum of 1.95s. So with a tick every 4ms at most 1 wraparound would
> have happened which allows the getDelta() function in cppc_cpufreq
> driver to get the proper difference in values.
>
> Let me know what you think.

This is not what I can see on my THX2. Counter are always increasing
at the same pace even if the system is idle (nothing running except
background activity)

As long as you read counter often enough, the results is coherent with
the freq that has been set by the governor

>
> Thanks,
> Ionela.
>
> > > There are 32bits and the overflow need to be handled by cppc_cpufreq
> > > driver
> >
> > I'm wondering if this would be best handled in the function that reads
> > the counters or in the cppc_cpufreq driver that uses them. Probably the
> > latter, as you say, as the read function should only return the raw
> > values, but it does complicate things.
> >
> > Thanks,
> > Ionela.
> >
> >
> >
> > > > The counter values shown by feedback_ctrs do not seem monotonic even
> > > > when only core 0 threads are online.
> > > >
> > > > ref:2812420736 del:166051103
> > > > ref:3683620736 del:641578595
> > > > ref:1049653440 del:1548202980
> > > > ref:2099053440 del:2120997459
> > > > ref:3185853440 del:2714205997
> > > > ref:712486144  del:3708490753
> > > > ref:3658438336 del:3401357212
> > > > ref:1570998080 del:2279728438
> > > >
> > > > For now I was just wondering if you have seen the same and whether you
> > > > have an opinion on this.
> > > >
> > > > > This is tested on my Hikey platform (without the actual read/write to
> > > > > performance counters), with this script for over an hour:
> > > > >
> > > > > while true; do
> > > > >     for i in `seq 1 7`;
> > > > >     do
> > > > >         echo 0 > /sys/devices/system/cpu/cpu$i/online;
> > > > >     done;
> > > > >
> > > > >     for i in `seq 1 7`;
> > > > >     do
> > > > >         echo 1 > /sys/devices/system/cpu/cpu$i/online;
> > > > >     done;
> > > > > done
> > > > >
> > > > >
> > > > > The same is done by Vincent on ThunderX2 and no issues were seen.
> > > >
> > > > Hotplug worked fine for me as well on both platforms I tested (Juno R2
> > > > and ThunderX2).
> > > >
> > > > Thanks,
> > > > Ionela.
