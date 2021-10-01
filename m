Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485041EB13
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJAKlw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJAKlv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 06:41:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C0C061775
        for <linux-acpi@vger.kernel.org>; Fri,  1 Oct 2021 03:40:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r1so19490878ybo.10
        for <linux-acpi@vger.kernel.org>; Fri, 01 Oct 2021 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTpyvjJyVNu8XozDEIR7HsP3cfnqDo8Pt0LnamcmL/Q=;
        b=kgrQxVSc691NrPgCPfmHuGhY/JuLICiRpPrKdQFu1wWnzVrv0JabtPMX+RUvnoF86Z
         GWFcaROhib8XltExNEDPIbW7VBvPEtqvYC2qLRidfUqdByu00RzDcVWfZt9LLB5tb0Vt
         kKNd1XnnJkAWnY5wQzAzCnKKz5CES22devP2ps4U0E0S9G/ycdS3mxM6jLKtSj8hH/0M
         kc5Ykf611OMvNtbA1mTuJGHS7vDHBriDvu3n0WNxzgpvY1o6QzKUDp5ZF0VApA7Qy0UW
         +EA+MQfy+gCKAVFNaODJA7IKFlj9dzL2eVdOTv1uH+XbYSt8AKMKbDD8o+ShG5LXt2rg
         GDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTpyvjJyVNu8XozDEIR7HsP3cfnqDo8Pt0LnamcmL/Q=;
        b=UmO1TMPQH6dCRyhbf3jly0ThYOLJK4s5gHb9a7VDs6LWZ1/bckRowPJ/dSkxlYxgzm
         QQ66KJGONoyG2bZImrs8ousvvTU2aOThCgNpm015N/BYa6Cucmg2VQYbnciKaiKl5pPA
         iVp1LjXyH7H9cmLq9NwjvgQYpyvX9PlH3+TwJyV+De+IpL0jtp6IAbzSy5+5BTCRpXJj
         NGgUhkrideEpLxtVWbyW1UozV0nWt/7df3pTMcZnhNqzVekQQYG6iSmqmNwrtBrkDSJG
         M6Oqh3605rSsRn5bVMM3/GW3XWX/tS1LnfnqUSmZO+CrjbjKeGvtnYXY874XQbYJO4FO
         ke6Q==
X-Gm-Message-State: AOAM5306s1qt7NN5B9YCbFUGL0t0oE6u7KzV+rfnGG9tSFO2z4TPqhTM
        F+HQN1c3y8UXRR+q3FVam2qX6Jx1qsHW4WGH93RJiw==
X-Google-Smtp-Source: ABdhPJwZy8hVBdYy+6i08tUsQiGEzXmhLEhduBXjwFsxu3VAiNBQrYA7xad17fwwYOW7hlku1dUiSaWE6F+obrb+t9E=
X-Received: by 2002:a25:ed0d:: with SMTP id k13mr5140316ybh.191.1633084806978;
 Fri, 01 Oct 2021 03:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 1 Oct 2021 12:39:56 +0200
Message-ID: <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
To:     Barry Song <21cnbao@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Cc: Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Barry,

On Fri, 1 Oct 2021 at 12:32, Barry Song <21cnbao@gmail.com> wrote:
>
> Hi Vincent, Dietmar, Peter, Ingo,
> Do you have any comment on this first series which exposes cluster topology
> of ARM64 kunpeng 920 & x86 Jacobsville and supports load balance only for
> the 1st stage?
> I will be very grateful for your comments so that things can move forward in the
> right direction. I think Tim also looks forward to bringing up cluster
> support in
> Jacobsville.

This patchset makes sense to me and the addition of a new scheduling
level to better reflect the HW topology goes in the right direction.

>
> Best Regards
> Barry
>
> On Fri, Sep 24, 2021 at 8:51 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > ARM64 machines like kunpeng920 and x86 machines like Jacobsville have a
> > level of hardware topology in which some CPU cores, typically 4 cores,
> > share L3 tags or L2 cache.
> >
> > That means spreading those tasks between clusters will bring more memory
> > bandwidth and decrease cache contention. But packing tasks might help
> > decrease the latency of cache synchronization.
> >
> > We have three series to bring up cluster level scheduler in kernel.
> > This is the first series.
> >
> > 1st series(this one): make kernel aware of cluster, expose cluster to sysfs
> > ABI and add SCHED_CLUSTER which can make load balance between clusters to
> > benefit lots of workload.
> > Testing shows this can hugely boost the performance, for example, this
> > can increase 25.1% of SPECrate mcf on Jacobsville and 13.574% of mcf
> > on kunpeng920.
> >
> > 2nd series(wake_affine): modify the wake_affine and let kernel select CPUs
> > within cluster first before scanning the whole LLC so that we can benefit
> > from the lower latency of cache coherence within one single cluster. This
> > series is much more tricky. so we would like to send it after we build
> > the base of cluster by the 1st series. Prototype for 2nd series is here:
> > https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-June/000219.html
> >
> > 3rd series: a sysctl to permit users to enable or disable cluster scheduler
> > from Tim Chen. Prototype here:
> > Add run time sysctl to enable/disable cluster scheduling
> > https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-July/000258.html
> >
> > This series is resent and rebased on 5.15-rc2.
> >
> > -V1:
> >  differences with RFC v6
> >  * removed wake_affine path modifcation, which will be separately second series
> >  * cluster_id is gotten by detecting valid ID before falling back to use offset
> >  * lots of benchmark data from both x86 Jacobsville and ARM64 kunpeng920
> >
> > -RFC v6:
> > https://lore.kernel.org/lkml/20210420001844.9116-1-song.bao.hua@hisilicon.com/
> >
> > Barry Song (1):
> >   scheduler: Add cluster scheduler level in core and related Kconfig for
> >     ARM64
> >
> > Jonathan Cameron (1):
> >   topology: Represent clusters of CPUs within a die
> >
> > Tim Chen (1):
> >   scheduler: Add cluster scheduler level for x86
> >
> >  Documentation/ABI/stable/sysfs-devices-system-cpu | 15 +++++
> >  Documentation/admin-guide/cputopology.rst         | 12 ++--
> >  arch/arm64/Kconfig                                |  7 +++
> >  arch/arm64/kernel/topology.c                      |  2 +
> >  arch/x86/Kconfig                                  |  8 +++
> >  arch/x86/include/asm/smp.h                        |  7 +++
> >  arch/x86/include/asm/topology.h                   |  3 +
> >  arch/x86/kernel/cpu/cacheinfo.c                   |  1 +
> >  arch/x86/kernel/cpu/common.c                      |  3 +
> >  arch/x86/kernel/smpboot.c                         | 44 ++++++++++++++-
> >  drivers/acpi/pptt.c                               | 67 +++++++++++++++++++++++
> >  drivers/base/arch_topology.c                      | 14 +++++
> >  drivers/base/topology.c                           | 10 ++++
> >  include/linux/acpi.h                              |  5 ++
> >  include/linux/arch_topology.h                     |  5 ++
> >  include/linux/sched/topology.h                    |  7 +++
> >  include/linux/topology.h                          | 13 +++++
> >  kernel/sched/topology.c                           |  5 ++
> >  18 files changed, 223 insertions(+), 5 deletions(-)
> >
> > --
> > 1.8.3.1
> >
