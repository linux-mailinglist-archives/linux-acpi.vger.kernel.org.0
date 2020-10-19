Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1B2927E8
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgJSNK6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 09:10:58 -0400
Received: from foss.arm.com ([217.140.110.172]:57322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgJSNK6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 09:10:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D7C5D6E;
        Mon, 19 Oct 2020 06:10:57 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CA9B3F719;
        Mon, 19 Oct 2020 06:10:55 -0700 (PDT)
Date:   Mon, 19 Oct 2020 15:10:52 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019131052.GC8004@e123083-lin>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
 <20201019103522.GK2628@hirez.programming.kicks-ass.net>
 <20201019123226.00006705@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019123226.00006705@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan,

On Mon, Oct 19, 2020 at 01:32:26PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2020 12:35:22 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:
> > > Both ACPI and DT provide the ability to describe additional layers of
> > > topology between that of individual cores and higher level constructs
> > > such as the level at which the last level cache is shared.
> > > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > > Node Structure [1] that is the parent of the CPU cores and in turn
> > > has a parent Processor Hierarchy Nodes Structure representing
> > > a higher level of topology.
> > > 
> > > For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> > > any cache resources, but the interconnect topology is such that
> > > the cost to transfer ownership of a cacheline between CPUs within
> > > a cluster is lower than between CPUs in different clusters on the same
> > > die.   Hence, it can make sense to deliberately schedule threads
> > > sharing data to a single cluster.
> > > 
> > > This patch simply exposes this information to userspace libraries
> > > like hwloc by providing cluster_cpus and related sysfs attributes.
> > > PoC of HWLOC support at [2].
> > > 
> > > Note this patch only handle the ACPI case.
> > > 
> > > Special consideration is needed for SMT processors, where it is
> > > necessary to move 2 levels up the hierarchy from the leaf nodes
> > > (thus skipping the processor core level).  
> 
> Hi Peter,
> 
> > 
> > I'm confused by all of this. The core level is exactly what you seem to
> > want.
> 
> It's the level above the core, whether in an multi-threaded core
> or a single threaded core.   This may correspond to the level
> at which caches are shared (typically L3).  Cores are already well
> represented via thread_siblings and similar.  Extra confusion is that
> the current core_siblings (deprecated) sysfs interface, actually reflects
> the package level and ignores anything in between core and
> package (such as die on x86)
> 
> So in a typical system with a hierarchical interconnect you would have
> 
> thread
> core
> cluster (possibly multiple layers as mentioned in Brice's reply).
> die
> package
> 
> Unfortunately as pointed out in other branches of this thread, there is
> no consistent generic name.  I'm open to suggestions!

IIUC, you are actually proposing another "die" level? I'm not sure if we
can actually come up with a generic name since interconnects are highly
implementation dependent.

How is you memory distributed? Do you already have NUMA nodes? If you
want to keep tasks together, it might make sense to define the clusters
(in your case) as NUMA nodes.

> Both ACPI PPTT and DT provide generic structures to represent layers of
> topology.   They don't name as such, but in ACPI there are flags to indicate
> package, core, thread.

I think that is because those are the only ones that a fairly generic
:-) It is also the only ones that scheduler cares about (plus NUMA).

> 
> For example, in zen2 this would correspond to a 'core complex' consisting
> 4 CPU cores (each one 2 threads) sharing some local L3 cache.
> https://en.wikichip.org/wiki/amd/microarchitectures/zen_2
> In zen3 it looks like this level will be the same as that for the die.
> 
> Given they used the name in knights landing (and as is pointed out in
> another branch of this thread, it's the CPUID description) I think Intel
> calls these 'tiles' (anyone confirm that?) 
> 
> A similar concept exists for some ARM processors. 
> https://en.wikichip.org/wiki/hisilicon/microarchitectures/taishan_v110
> CCLs in the diagram on that page.
> 
> Centriq 2400 had 2 core 'duplexes' which shared l2.
> https://www.anandtech.com/show/11737/analyzing-falkors-microarchitecture-a-deep-dive-into-qualcomms-centriq-2400-for-windows-server-and-linux/3
> 
> From the info release at hotchips, it looks like the thunderx3 deploys
> a similar ring interconnect with groups of cores, each with 4 threads.
> Not sure what they plan to call them yet though or whether they will chose
> to represent that layer of the topology in their firmware tables.
> 
> Arms CMN600 interconnect also support such 'clusters' though I have no idea
> if anyone has used it in this form yet.  In that case, they are called
> "processor compute clusters"
> https://developer.arm.com/documentation/100180/0103/
> 
> Xuantie-910 is cluster based as well (shares l2).
> 
> So in many cases the cluster level corresponds to something we already have
> visibility of due to cache sharing etc, but that isn't true in kunpeng 920.

The problem I see is that the benefit of keeping tasks together due to
the interconnect layout might vary significantly between systems. So if
we introduce a new cpumask for cluster it has to have represent roughly
the same system properties otherwise generic software consuming this
information could be tricked.

If there is a provable benefit of having interconnect grouping
information, I think it would be better represented by a distance matrix
like we have for NUMA.

Morten
