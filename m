Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60992425112
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhJGKcs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbhJGKcs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 06:32:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC6C061746;
        Thu,  7 Oct 2021 03:30:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v18so21287029edc.11;
        Thu, 07 Oct 2021 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mY64fv5z2ogFhndQ+OIlGH9TZ8lF/cAOTOOGKeTfLw=;
        b=IV75uUEO7ve3jcFTQQ6a0Hr/G1GyiMzZzVnGSB7EfvQMJ5tIWrRC4wF6dETgBP4aDw
         l26+4R5zB9K6adNvVf9SVfyBAsgFP8lbqeUHJvfvuAYiSSQkwm8m+SkeHYD8tHk5mup5
         SaK99WGZ+f09FzfaOoX3ifT96Zb3j0QaIBe9rUIRX/GusHmqapUI5FCmZn9gZ6fFbPV8
         DNU0yTuvia/M83FHOsFokMOfUvhxRoWNmwhtlYgaPrqhnIoV/hb+sg3gao2eWTy5A82D
         xo5dZHxTHTL/hajBtitEialaqAsDyE/gPdPJOPq7XAeaU9sykqpOHKixZnA/Ac++g4nu
         LgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mY64fv5z2ogFhndQ+OIlGH9TZ8lF/cAOTOOGKeTfLw=;
        b=PAKVYZ2jjv7k56TgDOpyLUGobPHlbvqISxfKh2j3MSWwfHK57V/2cS7TKW7FZVCywq
         iGRKz3tUcmpxhJJtcucy0R03oORjFy/sDcESdiPF06MdI6NgyMe0bxCB67FFg5aakTD1
         BBodVpFvwaQAkQevqc0hGtpxFhQx0CVPNryevet2JER2QZB0uzssUyveNybA/0HcZXZX
         FxVd8tGG+Z2ummwHGoNoYlwHattkB7hd7Me/iB5/oaOpvRlFr3ey6SAZP8Hphxkzdbls
         LlID424mxP42r/VhThMzW5CXkaxovmQDsdc1vy9zD0AUqLtj4ugQKuqxXnlR/QNXMXjU
         o8yA==
X-Gm-Message-State: AOAM532KB3vP5LaTqmMgZyK14lzWZC1BDuYP1RW+cgm4dkzxE1bAf8in
        kvGKOtI6KA24Fk2KgkMAUbRttMZQ9tKiJtluk8A=
X-Google-Smtp-Source: ABdhPJzrxcI8+MEuid+j/nPlF6m0fxTDB9iXiOL8Z0cef8F4m1dbX18KPjmL0x/le3rVHgOioxp/v891RcG75XEOdZA=
X-Received: by 2002:a17:906:3383:: with SMTP id v3mr4674165eja.213.1633602648062;
 Thu, 07 Oct 2021 03:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com> <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
 <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
 <20211006121858.GI174703@worktop.programming.kicks-ass.net>
 <CAGsJ_4zdr-Y5=TckNELoxgHDzNKhJuRsF5YAfEep24Ga7Y5ENg@mail.gmail.com> <20211006135550.GJ174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211006135550.GJ174703@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Oct 2021 23:30:36 +1300
Message-ID: <CAGsJ_4xvNCQ=sPzdhmsXbbjsOn4R1+bxYwLvrRNi1wiium5O7g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 7, 2021 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 01:50:43AM +1300, Barry Song wrote:
> > On Thu, Oct 7, 2021 at 1:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Oct 06, 2021 at 11:50:35PM +1300, Barry Song wrote:
> > >
> > > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > > index 7cb31d959f33..fc0836f460fb 100644
> > > > > --- a/drivers/base/arch_topology.c
> > > > > +++ b/drivers/base/arch_topology.c
> > > > > @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
> > > > >                 if (cpuid_topo->package_id != cpu_topo->package_id)
> > > > >                         continue;
> > > > >
> > > > > -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > > > > +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> > > > > +                   cpuid_topo->cluster_id != -1) {
> > > > >                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > > > >                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > > > >                 }
> > > > >
> > > >
> > > > Hi Peter,
> > > > Would you like to change this line in your tree?
> > >
> > > Can you please double check:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/next
> >
> > yes. It is correct for patch 1/3, thanks!

oops, there is a typo there:
+ if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
+ cpuid_topo->clister_id != -1) {

clister should be cluster.

> >
> > BTW, patch2/3  is missing some benchmark data and tested-by/SOB tags, i guess
> > it is because you are still editing?
>
> Urgh, no, that's my script thinking one of the many
>
> --------------
>
> lines you got in there was a terminator. Fixed it, should be pushed out
> again in a few minutes.

Thanks
barry
