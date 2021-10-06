Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D4423FA8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhJFN6Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhJFN6O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 09:58:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8CC061749;
        Wed,  6 Oct 2021 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E5FS5KeYsBA2zglyqvar557fDUOETk9K+8At4cmpf7k=; b=VfvWhA8dhnyfU6ojtqgYy99v0v
        kb9spvMYBeJiBeJo/qRdFTkCMLgM8qy5ridzVPhwl9OaF6nS5ygGJ6AknOupO7REEYzSKKcCRA9o2
        H1iZhQYzHaVirMottGI3WPjiNNNSUZ0Y4ThmIgFD5ln0wUWBg4u4Jq2XabjqmkjQUXhCaRvl5sySu
        yzdEErWXOEvCMSN3QlYVodwBnC9Oduldwq6WtBz707sgpXyxb6tRBOT6nUkZZdN+wQiv/d2q3yENY
        D1W2BtBjlv+gmg1Nn3cHT3vejT8en8J33Q5qLPk+yi/MgB4/N8Fzzft4BCbndkC2Y+PA+/sAYxE3K
        Wo3rvbqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY7Oh-008HuP-7x; Wed, 06 Oct 2021 13:55:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF66B98623A; Wed,  6 Oct 2021 15:55:50 +0200 (CEST)
Date:   Wed, 6 Oct 2021 15:55:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
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
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a
 die
Message-ID: <20211006135550.GJ174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com>
 <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
 <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
 <20211006121858.GI174703@worktop.programming.kicks-ass.net>
 <CAGsJ_4zdr-Y5=TckNELoxgHDzNKhJuRsF5YAfEep24Ga7Y5ENg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zdr-Y5=TckNELoxgHDzNKhJuRsF5YAfEep24Ga7Y5ENg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 07, 2021 at 01:50:43AM +1300, Barry Song wrote:
> On Thu, Oct 7, 2021 at 1:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 06, 2021 at 11:50:35PM +1300, Barry Song wrote:
> >
> > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > index 7cb31d959f33..fc0836f460fb 100644
> > > > --- a/drivers/base/arch_topology.c
> > > > +++ b/drivers/base/arch_topology.c
> > > > @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
> > > >                 if (cpuid_topo->package_id != cpu_topo->package_id)
> > > >                         continue;
> > > >
> > > > -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > > > +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> > > > +                   cpuid_topo->cluster_id != -1) {
> > > >                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > > >                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > > >                 }
> > > >
> > >
> > > Hi Peter,
> > > Would you like to change this line in your tree?
> >
> > Can you please double check:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/next
> 
> yes. It is correct for patch 1/3, thanks!
> 
> BTW, patch2/3  is missing some benchmark data and tested-by/SOB tags, i guess
> it is because you are still editing?

Urgh, no, that's my script thinking one of the many

--------------

lines you got in there was a terminator. Fixed it, should be pushed out
again in a few minutes.
