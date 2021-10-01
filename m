Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73A41EAFC
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353037AbhJAKeS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353576AbhJAKeQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 06:34:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA365C061775;
        Fri,  1 Oct 2021 03:32:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g7so32350795edv.1;
        Fri, 01 Oct 2021 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/buWv3Asqx8kW1gsPhKrBHjVU5mWPxYIQpwpvJXtO0o=;
        b=jkNGWFz2YH8ckrY4qu9+JqawpfR9nQh9JqHvJSEXgqn1wW0ZqIAbp6wo8e4k53JWie
         PG9Vl/qlhKghLtsUQHFZTjw5395tiJ/a0y8S9aMSfdbEWOD0fhmg2Pyxlh/SYSRYd8lO
         hewjNYNlzym7OcG29daZZMJI7ErWYNY98p3S6t8RHLMRYCgGg4n7vSEvnKTzov1agQYe
         3B7IoGlPn2nCL+jkulnRVHDy4VgrgfiBWCjEoFml1pCRxm5iFS/EgzaToz2VmELnhBWN
         379viRefrQzQvoc/N3tg342WCw41fgkxK95RPcV9CrH21lYNW8NfvC+ADhE2T71YmDKX
         m3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/buWv3Asqx8kW1gsPhKrBHjVU5mWPxYIQpwpvJXtO0o=;
        b=FTRWLOw65SJI7xbEniNKV18EXsl0HbD929Y7bMBh6u274BwstXeknAQOe7w0Mk9JYg
         uDS2r4PrGEO0sziPh300UbzbsiaLHCeA1FaEoJTUk/KugCvboGcjKQVd/Lpx/R4mxz2S
         dqyhF1O7qIlT5NGK3L3JjKdKQKtabSmcBKMBZCEWNla76/BzrXuI8+y0cNFE3kIRm4d9
         7tRqzi2WldRVtxZBy8ffviOYgiD4iKKBXY7T5CJT3n1AxY5Un5ddK4OkC0mt9QMUhRX3
         P7bCFI1ZZ3zVInITh3Iglff1TSegRUkbmXEVAmnzBd3d53ktKT3OcYfyCSF5qRwzHW4G
         zWfw==
X-Gm-Message-State: AOAM5326+vHZ/fizqNgMJum8/7RoseEX40zI2jWtCFHDicYkSTboD5zb
        R1ifQa9e6qComCJb2YrMiH3Kz4qIDpcA9vlX/hQ=
X-Google-Smtp-Source: ABdhPJwxMEKjDnhtc7obFtfk3VPIDqJzotNggMPqjw2PjpIwccXrdXetUdUPm3NaN4beRUzAv+miPPxECSjF74GLHPY=
X-Received: by 2002:a17:906:2345:: with SMTP id m5mr5190628eja.557.1633084350266;
 Fri, 01 Oct 2021 03:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com>
In-Reply-To: <20210924085104.44806-1-21cnbao@gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 1 Oct 2021 23:32:18 +1300
Message-ID: <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     aubrey.li@linux.intel.com, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, rafael@kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        will@kernel.org, x86@kernel.org, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Vincent, Dietmar, Peter, Ingo,
Do you have any comment on this first series which exposes cluster topology
of ARM64 kunpeng 920 & x86 Jacobsville and supports load balance only for
the 1st stage?
I will be very grateful for your comments so that things can move forward in the
right direction. I think Tim also looks forward to bringing up cluster
support in
Jacobsville.

Best Regards
Barry

On Fri, Sep 24, 2021 at 8:51 PM Barry Song <21cnbao@gmail.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
> ARM64 machines like kunpeng920 and x86 machines like Jacobsville have a
> level of hardware topology in which some CPU cores, typically 4 cores,
> share L3 tags or L2 cache.
>
> That means spreading those tasks between clusters will bring more memory
> bandwidth and decrease cache contention. But packing tasks might help
> decrease the latency of cache synchronization.
>
> We have three series to bring up cluster level scheduler in kernel.
> This is the first series.
>
> 1st series(this one): make kernel aware of cluster, expose cluster to sysfs
> ABI and add SCHED_CLUSTER which can make load balance between clusters to
> benefit lots of workload.
> Testing shows this can hugely boost the performance, for example, this
> can increase 25.1% of SPECrate mcf on Jacobsville and 13.574% of mcf
> on kunpeng920.
>
> 2nd series(wake_affine): modify the wake_affine and let kernel select CPUs
> within cluster first before scanning the whole LLC so that we can benefit
> from the lower latency of cache coherence within one single cluster. This
> series is much more tricky. so we would like to send it after we build
> the base of cluster by the 1st series. Prototype for 2nd series is here:
> https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-June/000219.html
>
> 3rd series: a sysctl to permit users to enable or disable cluster scheduler
> from Tim Chen. Prototype here:
> Add run time sysctl to enable/disable cluster scheduling
> https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-July/000258.html
>
> This series is resent and rebased on 5.15-rc2.
>
> -V1:
>  differences with RFC v6
>  * removed wake_affine path modifcation, which will be separately second series
>  * cluster_id is gotten by detecting valid ID before falling back to use offset
>  * lots of benchmark data from both x86 Jacobsville and ARM64 kunpeng920
>
> -RFC v6:
> https://lore.kernel.org/lkml/20210420001844.9116-1-song.bao.hua@hisilicon.com/
>
> Barry Song (1):
>   scheduler: Add cluster scheduler level in core and related Kconfig for
>     ARM64
>
> Jonathan Cameron (1):
>   topology: Represent clusters of CPUs within a die
>
> Tim Chen (1):
>   scheduler: Add cluster scheduler level for x86
>
>  Documentation/ABI/stable/sysfs-devices-system-cpu | 15 +++++
>  Documentation/admin-guide/cputopology.rst         | 12 ++--
>  arch/arm64/Kconfig                                |  7 +++
>  arch/arm64/kernel/topology.c                      |  2 +
>  arch/x86/Kconfig                                  |  8 +++
>  arch/x86/include/asm/smp.h                        |  7 +++
>  arch/x86/include/asm/topology.h                   |  3 +
>  arch/x86/kernel/cpu/cacheinfo.c                   |  1 +
>  arch/x86/kernel/cpu/common.c                      |  3 +
>  arch/x86/kernel/smpboot.c                         | 44 ++++++++++++++-
>  drivers/acpi/pptt.c                               | 67 +++++++++++++++++++++++
>  drivers/base/arch_topology.c                      | 14 +++++
>  drivers/base/topology.c                           | 10 ++++
>  include/linux/acpi.h                              |  5 ++
>  include/linux/arch_topology.h                     |  5 ++
>  include/linux/sched/topology.h                    |  7 +++
>  include/linux/topology.h                          | 13 +++++
>  kernel/sched/topology.c                           |  5 ++
>  18 files changed, 223 insertions(+), 5 deletions(-)
>
> --
> 1.8.3.1
>
