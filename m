Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9B425140
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhJGKkZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbhJGKkV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 06:40:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C3AC061762;
        Thu,  7 Oct 2021 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z0HFg8la3obAWV2GGdEJBj4YtmyT7c3u08WRq35X0fo=; b=iRFJNOzhmcmh/dAkVO9P881YVq
        86hGzZgtuBXX8iNGtm5OzclBT6NslnMwl9H3R5sb5/Lwe0supJf8CaF0mM4FDLrf/Eg6yrxbgMHZ3
        Py44t3TottmnEdhwKDGGH1VzQn6tLcpASoiodCpI860AsXYGFay7QeKxB6OY4KsALjQP1PQtxaJYu
        mmvrdvMoltaAxf0eo3YBMycRPBw7X3HhivxTMwtOYPtk48PjrD6hloR4Zg4iP3uu5hT+p+8JchnPb
        NDhOItF9JFmq9KpBgibmgNtWkzCV2eLmJaRQb8h7hBuEGH/zPR3yjcrC92pwx/adGzsH3tixw0GLr
        MUYR9FGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYQkI-001l03-C6; Thu, 07 Oct 2021 10:35:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 508D29811BB; Thu,  7 Oct 2021 12:35:26 +0200 (CEST)
Date:   Thu, 7 Oct 2021 12:35:26 +0200
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
Message-ID: <20211007103526.GS174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com>
 <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
 <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
 <20211006121858.GI174703@worktop.programming.kicks-ass.net>
 <CAGsJ_4zdr-Y5=TckNELoxgHDzNKhJuRsF5YAfEep24Ga7Y5ENg@mail.gmail.com>
 <20211006135550.GJ174703@worktop.programming.kicks-ass.net>
 <CAGsJ_4xvNCQ=sPzdhmsXbbjsOn4R1+bxYwLvrRNi1wiium5O7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xvNCQ=sPzdhmsXbbjsOn4R1+bxYwLvrRNi1wiium5O7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 07, 2021 at 11:30:36PM +1300, Barry Song wrote:
> On Thu, Oct 7, 2021 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 07, 2021 at 01:50:43AM +1300, Barry Song wrote:
> > > On Thu, Oct 7, 2021 at 1:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Oct 06, 2021 at 11:50:35PM +1300, Barry Song wrote:
> > > >
> > > > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > > > index 7cb31d959f33..fc0836f460fb 100644
> > > > > > --- a/drivers/base/arch_topology.c
> > > > > > +++ b/drivers/base/arch_topology.c
> > > > > > @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
> > > > > >                 if (cpuid_topo->package_id != cpu_topo->package_id)
> > > > > >                         continue;
> > > > > >
> > > > > > -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > > > > > +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> > > > > > +                   cpuid_topo->cluster_id != -1) {
> > > > > >                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > > > > >                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > > > > >                 }
> > > > > >
> > > > >
> > > > > Hi Peter,
> > > > > Would you like to change this line in your tree?
> > > >
> > > > Can you please double check:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/next
> > >
> > > yes. It is correct for patch 1/3, thanks!
> 
> oops, there is a typo there:
> + if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> + cpuid_topo->clister_id != -1) {
> 
> clister should be cluster.

Yeah, my bad, typing so hard... :-) Already fixed.
