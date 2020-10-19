Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976E2927EE
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgJSNNg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 09:13:36 -0400
Received: from foss.arm.com ([217.140.110.172]:57386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSNNf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 09:13:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05118D6E;
        Mon, 19 Oct 2020 06:13:35 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043063F719;
        Mon, 19 Oct 2020 06:13:32 -0700 (PDT)
Date:   Mon, 19 Oct 2020 15:13:30 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019131330.GD8004@e123083-lin>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
 <20201019103522.GK2628@hirez.programming.kicks-ass.net>
 <20201019123226.00006705@Huawei.com>
 <20201019125053.GM2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019125053.GM2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 19, 2020 at 02:50:53PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 01:32:26PM +0100, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2020 12:35:22 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > I'm confused by all of this. The core level is exactly what you seem to
> > > want.
> > 
> > It's the level above the core, whether in an multi-threaded core
> > or a single threaded core.   This may correspond to the level
> > at which caches are shared (typically L3).  Cores are already well
> > represented via thread_siblings and similar.  Extra confusion is that
> > the current core_siblings (deprecated) sysfs interface, actually reflects
> > the package level and ignores anything in between core and
> > package (such as die on x86)
> 
> That seems wrong. core-mask should be whatever cores share L3. So on a
> Intel Core2-Quad (just to pick an example) you should have 4 CPU in a
> package, but only 2 CPUs for the core-mask.
> 
> It just so happens that L3 and package were the same for a long while in
> x86 land, although recent chips started breaking that trend.
> 
> And I know nothing about the core-mask being depricated; it's what the
> scheduler uses. It's not going anywhere.

Don't get confused over the user-space topology and the scheduler
topology, they are _not_ the same despite having similar names for some
things :-)

> So if your 'cluster' is a group of single cores (possibly with SMT) that
> do not share cache but have a faster cache connection and you want them
> to behave as-if they were a multi-core group that did share cache, then
> core-mask it is.

In the scheduler, yes. There is no core-mask exposed to user-space.

We have to be clear about whether we discuss scheduler or user-space
topology :-)
