Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69B292AFF
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgJSQCT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 12:02:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2993 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730335AbgJSQCT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 12:02:19 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6DF842B7FF7FBCE7BDF8;
        Mon, 19 Oct 2020 17:02:17 +0100 (IST)
Received: from localhost (10.52.126.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 17:02:16 +0100
Date:   Mon, 19 Oct 2020 17:00:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>, <linuxarm@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019160020.000013d6@Huawei.com>
In-Reply-To: <jhjft6aqko1.mognet@arm.com>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <20201019103522.GK2628@hirez.programming.kicks-ass.net>
        <20201019123226.00006705@Huawei.com>
        <20201019131052.GC8004@e123083-lin>
        <jhjh7qqqqct.mognet@arm.com>
        <20201019142715.00005fb1@huawei.com>
        <jhjft6aqko1.mognet@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.130]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 19 Oct 2020 16:51:06 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 19/10/20 15:27, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2020 14:48:02 +0100
> > Valentin Schneider <valentin.schneider@arm.com> wrote:  
> >>
> >> That's my queue to paste some of that stuff I've been rambling on and off
> >> about!
> >>
> >> With regards to cache / interconnect layout, I do believe that if we
> >> want to support in the scheduler itself then we should leverage some
> >> distance table rather than to create X extra scheduler topology levels.
> >>
> >> I had a chat with Jeremy on the ACPI side of that sometime ago. IIRC given
> >> that SLIT gives us a distance value between any two PXM, we could directly
> >> express core-to-core distance in that table. With that (and if that still
> >> lets us properly discover NUMA node spans), we could let the scheduler
> >> build dynamic NUMA-like topology levels representing the inner quirks of
> >> the cache / interconnect layout.  
> >
> > You would rapidly run into the problem SLIT had for numa node description.
> > There is no consistent description of distance and except in the vaguest
> > sense or 'nearer' it wasn't any use for anything.   That is why HMAT
> > came along. It's far from perfect but it is a step up.
> >  
> 
> I wasn't aware of HMAT; my feeble ACPI knowledge is limited to SRAT / SLIT
> / PPTT, so thanks for pointing this out.
> 
> > I can't see how you'd generalize those particular tables to do anything
> > for intercore comms without breaking their use for NUMA, but something
> > a bit similar might work.
> >  
> 
> Right, there's the issue of still being able to determine NUMA node
> boundaries.

Backwards compatibility will break you there. I'd definitely look at a separate
table.  Problem with SLIT etc is that, as static tables, we can't play games
with OSC bits to negotiate what the OS and the firmware both understand.

> 
> > A lot of thought has gone in (and meeting time) to try an improve the
> > situation for complex topology around NUMA.  Whilst there are differences
> > in representing the internal interconnects and caches it seems like a somewhat
> > similar problem.  The issue there is it is really really hard to describe
> > this stuff with enough detail to be useful, but simple enough to be usable.
> >
> > https://lore.kernel.org/linux-mm/20181203233509.20671-1-jglisse@redhat.com/
> >  
> 
> Thanks for the link!
> 
> >>
> >> It's mostly pipe dreams for now, but there seems to be more and more
> >> hardware where that would make sense; somewhat recently the PowerPC guys
> >> added something to their arch-specific code in that regards.  
> >
> > Pipe dream == something to work on ;)
> >
> > ACPI has a nice code first model of updating the spec now, so we can discuss
> > this one in public, and propose spec changes only once we have an implementation
> > proven.
> >  
> 
> FWIW I blabbered about a "generalization" of NUMA domains & distances
> within the scheduler at LPC19 (and have been pasting that occasionally,
> apologies for the broken record):
> 
> https://linuxplumbersconf.org/event/4/contributions/484/
> 
> I've only pondered about the implementation, but if (big if; also I really
> despise advertising "the one solution that will solve all your issues"
> which this is starting to sound like) it would help I could cobble together
> an RFC leveraging a separate distance table.

It would certainly be interesting.

> 
> It doesn't solve the "funneling cache properties into a single number"
> issue, which as you just pointed out in a parallel email is a separate
> discussion altogether.
> 
> > Note I'm not proposing we put the cluster stuff in the scheduler, just
> > provide it as a hint to userspace.
> >  
> 
> The goal being to tweak tasks' affinities, right? Other than CPU pinning
> and rare cases, IMO if the userspace has to mess around with affinities it
> is due to the failings of the underlying scheduler. Restricted CPU
> affinities is also something the load-balancer struggles with; I have and
> have been fighting over such issues where just a single per-CPU kworker
> waking up at the wrong time can mess up load-balance for quite some time. I
> tend to phrase it as: "if you're rude to the scheduler, it can and will
> respond in kind".
> 
> Now yes, it's not the same timescale nor amount of work, but this is
> something the scheduler itself should leverage, not userspace.

Ideally I absolutely agree, but then we get into the games of trying to
classify the types of workload which would benefit.  Much like with
NUMA spreading, it is going to be hard to come up with a one true
solution (nice though that would be!)

Not getting regressions with anything in this area is going to be
really tricky.   

J


> 
> > Jonathan  


