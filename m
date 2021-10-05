Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84EB4221AE
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEJIe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhJEJIe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 05:08:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182EC061745;
        Tue,  5 Oct 2021 02:06:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f9so13214992edx.4;
        Tue, 05 Oct 2021 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSFeclzRnwoQe2g5vZuTvAXMAyEYQaztfOLftQqfUtM=;
        b=YmNaz1joJZn98bJslZ8JvRfZjSlvIUIZwh+wPVIkvi2EyNDOil4zbt3q6VYFsiDfSR
         hZxtkS1GCZ4harzY1cNsetvftMwSeCLPw8BllbmesZ0hkOouYIE3YJeX7FWfP77P2KKg
         cxN6ApVdJeA5IB0iRVV22irbru5DPS85ffV/dDNO/gsNe8hslgkwXpJnTW6sbFJZFvkq
         I40VQZrsHepvtk37i+dXWGBxXXI1T4+N+WdVAa4ds+5f7qwoRrwDZaUja+Ferh7Nvc3n
         GZMq/4z4Li/fR4vEeBQU0qOSSsafs5hJtPbftfkPDlXj/gwpLpvqKPCTayNxATjLQq32
         591Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSFeclzRnwoQe2g5vZuTvAXMAyEYQaztfOLftQqfUtM=;
        b=QLXFLKjr3NmVa4oFEiE/oMggj6XxBKZrxsGQngzhgLh6TOiChfbH5jYO399WE6qjLw
         Tbt7Zuulv4jINI9APhP2STT6MtIeG3F5Gbxqkfwd2b9TzrEOnif7aHs5D6Lb6zH+/tff
         SkECNZUdtJu/1817ebj6qsesttbH2JXfwi+FWH1nQAi5SRvNijUxQD3eXX/dyFSzwM+o
         Y3GccAtVU/HayYdfo50OfV9XpRPDWZv2T1RXQZjsWiuEy+DM2FHfL1yzSzpvB5oOHnL8
         iyrHnN0dZwXjgv59+v3KX26f2f7sBrwdPQMjwBAdAU3GrXZLByHTbY03CNxq4/qDCST2
         D6mQ==
X-Gm-Message-State: AOAM531G0Ho9fngCPF8heWNkawCfYQMO4Gn2Jzxs85t6AsodJp7SgiUp
        VnotVCxqyFd+6dB8NxRDNFIBZ0wCUBINCW96Zpk=
X-Google-Smtp-Source: ABdhPJxKIjvjMGKHK4XqSHN8WgAXsuEOAR6flGcTg0VSrubjWT2cwGhKMbfk3K4O98PlTBJtbVQLqCWEQsknDVf/9XU=
X-Received: by 2002:a17:907:767a:: with SMTP id kk26mr22828213ejc.134.1633424802040;
 Tue, 05 Oct 2021 02:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net> <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
 <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com> <20211005080413.GL4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005080413.GL4323@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Oct 2021 22:06:30 +1300
Message-ID: <CAGsJ_4zgYcne+pOTfLV-pvgQ6R=n4n2Vmc6rC9En_9VGs+BM_w@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 5, 2021 at 9:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Oct 02, 2021 at 08:09:58PM +1300, Barry Song wrote:
>
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 7e4651a1aaf4..86821e83b935 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -993,8 +993,13 @@ config SCHED_CLUSTER
> >         bool "Cluster scheduler support"
> >         help
> >           Cluster scheduler support improves the CPU scheduler's decision
> > +         making when dealing with machines that have clusters of CPUs.
> > +         Cluster usually means a couple of CPUs which are placed closely
> > +         by sharing mid-level caches, last-level cache tags or internal
> > +         busses. For example, on Hisilicon Kunpeng920, each 4 CPUs share
> > +         LLC cache tags. This feature isn't a universal win because it
> > +         can bring a cost of slightly increased overhead in some places.
> > +         If unsure say N here.
> >
> >  config SCHED_SMT
> >         bool "SMT scheduler support"
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index bd27b1cdac34..940eb1fe0abb 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1002,12 +1002,17 @@ config NR_CPUS
> >           to the kernel image.
> >
> >  config SCHED_CLUSTER
> > +       def_bool y
> > +       prompt "Cluster scheduler support"
> >         help
> >          Cluster scheduler support improves the CPU scheduler's decision
> > +        making when dealing with machines that have clusters of CPUs.
> > +        Cluster usually means a couple of CPUs which are placed closely
> > +        by sharing mid-level caches, last-level cache tags or internal
> > +        busses. For example, on x86 Jacobsville, each 4 CPUs share one
> > +        L2 cache.
>
>                         This feature isn't a universal win because it can bring
> > +        a cost of slightly increased overhead in some places. If unsure
> > +        say N here.
>
> That is a really odd addition to a default-y feature.
>
> How about I make both:
>
>         help
>           Cluster scheduler support improves the CPU scheduler's decision
>           making when dealing with machines that have clusters of CPUs.
>           Cluster usually means a couple of CPUs which are placed closely
>           by sharing mid-level caches, last-level cache tags or internal
>           busses.

looks good to me. thanks!

barry
