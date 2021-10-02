Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6341FA2F
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Oct 2021 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJBHL5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 Oct 2021 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhJBHL4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Oct 2021 03:11:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D8C061775;
        Sat,  2 Oct 2021 00:10:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so43006180edt.7;
        Sat, 02 Oct 2021 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uya+S2oyhnbkuHTWONszE5UZOsIwnMCwXNyK7u9GIz4=;
        b=RaBYpuL/bugZIPxIQop7OOGWQJ3os0RXhaZYqSH7X6Eq8SKjy6nukbWLymaEeygt+a
         8abEBOcQ8GRHpJjSSKhq/QxMRsZ71P31OZZihc/ZX4h7cmF/gg8iw7Geqa0gg+odtAD/
         5a6g1C0mq98DQxpO+mJg4a8DdInJMgcgY+r595tU8ZFZYBV8qQUZoh4ejThhT0HiNajW
         wowbsegiKoKf4QYHNfNzp7JNzHoXywwe2SSoUt8P5CrMpP3EJu3vp8MhB6fNfCALqy+2
         F1mi8UtmA8zjZcbAkNAfDX9M4qV4OUNN7NLWmyc9+sjBlrrW+Fr5bwwQGjuBnkcH9+NG
         5yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uya+S2oyhnbkuHTWONszE5UZOsIwnMCwXNyK7u9GIz4=;
        b=sfg+2Ic41fvAyS5bhkYVarJd+LN6v77JokvdF9r5gAtSeBVMBaZ6w0GL7jQm6JW4Bw
         D1mPGtzMx7HZObT/8fnqFapIrlU8jSvxiLi/5oeEVU0JN4s/qs7wdUGEIuxdZEmG0l/Z
         Ou2FHwNX59oTDdi/EvjEhSeTR6LMyi/TT+JqARcQEmybZD9d3u9i9fJjVGrIwSbETlkD
         IUVlvukqslmUgIxE09WvIYPS0y2WHQQgBgKChL0ISSvNQHsosNFmopatb6zjnx63YUeM
         UbyAWNdQtPNp302AVYjR+IH7HGbWr5F0eapyt5+uCJiJzUVvUaHw4Ht0RFCkLu5g6BRf
         1NSQ==
X-Gm-Message-State: AOAM53218AxoENyrUvnMK5encdFEGnf4ThmbpmZW6Fxhiv0dJAuBMEjK
        IHnyOoS0ZAkWB4FKYRqbbnqm429AL0AMXq0nWKk=
X-Google-Smtp-Source: ABdhPJytWM/UfVWwpCpa3LaCakRZEviBUoJmjYVE+NvaVqmU5GB68aEvf0Ihpc58SJjTGvlXnYNLo72dSTrf1KIdf4E=
X-Received: by 2002:a50:dacf:: with SMTP id s15mr2402763edj.385.1633158609542;
 Sat, 02 Oct 2021 00:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net> <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
In-Reply-To: <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 2 Oct 2021 20:09:58 +1300
Message-ID: <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Sat, Oct 2, 2021 at 12:22 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2021-10-01 at 16:57 +0200, Peter Zijlstra wrote:
> > On Fri, Oct 01, 2021 at 12:39:56PM +0200, Vincent Guittot wrote:
> > > Hi Barry,
> > >
> > > On Fri, 1 Oct 2021 at 12:32, Barry Song <21cnbao@gmail.com> wrote:
> > > > Hi Vincent, Dietmar, Peter, Ingo,
> > > > Do you have any comment on this first series which exposes
> > > > cluster topology
> > > > of ARM64 kunpeng 920 & x86 Jacobsville and supports load balance
> > > > only for
> > > > the 1st stage?
> > > > I will be very grateful for your comments so that things can move
> > > > forward in the
> > > > right direction. I think Tim also looks forward to bringing up
> > > > cluster
> > > > support in
> > > > Jacobsville.
> > >
> > > This patchset makes sense to me and the addition of a new
> > > scheduling
> > > level to better reflect the HW topology goes in the right
> > > direction.
> >
> > So I had a look, dreading the selecti-idle-sibling changes, and was
> > pleasantly surprised they're gone :-)

Thanks, Peter and Vincent for reviewing.

My tiny scheduler team is still hardly working on the
select-idle-sibling changes.
And that one will be sent as a separate series as an improvement to this series.
I promise the wake-affine series won't be that scary when you see it
next time :-)

> >
> > As is, this does indeed look like something mergable without too much
> > hassle.
> >
> > The one questino I have is, do we want default y?
>
> I also agree that default y is preferable.

Thanks, Tim, for your comments.
I am ok to make it default "Y" for x86 after having a better doc as below:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bd27b1cdac34..940eb1fe0abb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1002,12 +1002,17 @@ config NR_CPUS
          to the kernel image.

 config SCHED_CLUSTER
-       bool "Cluster scheduler support"
-       default n
+       def_bool y
+       prompt "Cluster scheduler support"
        help
         Cluster scheduler support improves the CPU scheduler's decision
-        making when dealing with machines that have clusters of CPUs
-        sharing L2 cache. If unsure say N here.
+        making when dealing with machines that have clusters of CPUs.
+        Cluster usually means a couple of CPUs which are placed closely
+        by sharing mid-level caches, last-level cache tags or internal
+        busses. For example, on x86 Jacobsville, each 4 CPUs share one
+        L2 cache. This feature isn't a universal win because it can bring
+        a cost of slightly increased overhead in some places. If unsure
+        say N here.

This also aligns well with SCHED_MC and SCHED_SMT in arch/x86/kconfig:
config SCHED_MC
    def_bool y
    prompt "Multi-core scheduler support"

config SCHED_SMT
    def_bool y if SMP

But ARM64 is running in a different tradition, arch/arm64/Kconfig has
SCHED_MC and SCHED_SMT as below:
   config SCHED_MC
   bool "Multi-core scheduler support"
   help
    ...

config SCHED_SMT
  bool "SMT scheduler support"
  help
  ...

I don't want to be an odd man :-)  So for ARM64, I vote keeping the
Kconfig file as is.  And I am planning to modify arch/arm64/defconfig
in second patchset(select-idle-sibling) by adding
CONFIG_SCHED_CLUSTR=y
as load-balance plus wake-affine changes seem to make cluster
scheduler much more widely win on kunpeng920 while doing load-
balance only can sometimes hurt. so I don't mind holding "N" for
a while on the ARM64 platform.

>
> >
> > The one nit I have is the Kconfig text, I'm not really sure that's
> > clarifying what a cluster is.
>
> Do you have a preference of a different name other than cluster?
> Or simply better documentation on what a cluster is for ARM64
> and x86 in Kconfig?

Anyway, naming is really a hard thing. cluster seems not a bad name for
ARM SoCs as besides kunpeng, some other ARM SoCs are also using this
name in specifications, for example, neoverse-n1, phytium etc.

Will we use the same name between x86 and ARM and just refine the document
as below? Does the below doc explain what is "cluster" better?

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e4651a1aaf4..86821e83b935 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -993,8 +993,13 @@ config SCHED_CLUSTER
        bool "Cluster scheduler support"
        help
          Cluster scheduler support improves the CPU scheduler's decision
-         making when dealing with machines that have clusters(sharing internal
-         bus or sharing LLC cache tag). If unsure say N here.
+         making when dealing with machines that have clusters of CPUs.
+         Cluster usually means a couple of CPUs which are placed closely
+         by sharing mid-level caches, last-level cache tags or internal
+         busses. For example, on Hisilicon Kunpeng920, each 4 CPUs share
+         LLC cache tags. This feature isn't a universal win because it
+         can bring a cost of slightly increased overhead in some places.
+         If unsure say N here.

 config SCHED_SMT
        bool "SMT scheduler support"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bd27b1cdac34..940eb1fe0abb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1002,12 +1002,17 @@ config NR_CPUS
          to the kernel image.

 config SCHED_CLUSTER
-       bool "Cluster scheduler support"
-       default n
+       def_bool y
+       prompt "Cluster scheduler support"
        help
         Cluster scheduler support improves the CPU scheduler's decision
-        making when dealing with machines that have clusters of CPUs
-        sharing L2 cache. If unsure say N here.
+        making when dealing with machines that have clusters of CPUs.
+        Cluster usually means a couple of CPUs which are placed closely
+        by sharing mid-level caches, last-level cache tags or internal
+        busses. For example, on x86 Jacobsville, each 4 CPUs share one
+        L2 cache. This feature isn't a universal win because it can bring
+        a cost of slightly increased overhead in some places. If unsure
+        say N here.

 config SCHED_SMT
        def_bool y if SMP


>
> Thanks.
>
> Tim
>

Thanks
barry
