Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D447C29291A
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgJSOQ7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 10:16:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgJSOQ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 10:16:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B5AD6E;
        Mon, 19 Oct 2020 07:16:57 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8738E3F66E;
        Mon, 19 Oct 2020 07:16:55 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:16:53 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Len Brown <len.brown@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, guohanjun@huawei.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Brice Goglin <Brice.Goglin@inria.fr>,
        linux-acpi@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, valentin.schneider@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019141653.GE8004@e123083-lin>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
 <20201019103522.GK2628@hirez.programming.kicks-ass.net>
 <20201019123226.00006705@Huawei.com>
 <20201019131052.GC8004@e123083-lin>
 <20201019134157.00001c97@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019134157.00001c97@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 19, 2020 at 02:41:57PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2020 15:10:52 +0200
> Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Mon, Oct 19, 2020 at 01:32:26PM +0100, Jonathan Cameron wrote:
> > > On Mon, 19 Oct 2020 12:35:22 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:  
> > > > > Both ACPI and DT provide the ability to describe additional layers of
> > > > > topology between that of individual cores and higher level constructs
> > > > > such as the level at which the last level cache is shared.
> > > > > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > > > > Node Structure [1] that is the parent of the CPU cores and in turn
> > > > > has a parent Processor Hierarchy Nodes Structure representing
> > > > > a higher level of topology.
> > > > > 
> > > > > For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> > > > > any cache resources, but the interconnect topology is such that
> > > > > the cost to transfer ownership of a cacheline between CPUs within
> > > > > a cluster is lower than between CPUs in different clusters on the same
> > > > > die.   Hence, it can make sense to deliberately schedule threads
> > > > > sharing data to a single cluster.
> > > > > 
> > > > > This patch simply exposes this information to userspace libraries
> > > > > like hwloc by providing cluster_cpus and related sysfs attributes.
> > > > > PoC of HWLOC support at [2].
> > > > > 
> > > > > Note this patch only handle the ACPI case.
> > > > > 
> > > > > Special consideration is needed for SMT processors, where it is
> > > > > necessary to move 2 levels up the hierarchy from the leaf nodes
> > > > > (thus skipping the processor core level).    
> > > 
> > > Hi Peter,
> > >   
> > > > 
> > > > I'm confused by all of this. The core level is exactly what you seem to
> > > > want.  
> > > 
> > > It's the level above the core, whether in an multi-threaded core
> > > or a single threaded core.   This may correspond to the level
> > > at which caches are shared (typically L3).  Cores are already well
> > > represented via thread_siblings and similar.  Extra confusion is that
> > > the current core_siblings (deprecated) sysfs interface, actually reflects
> > > the package level and ignores anything in between core and
> > > package (such as die on x86)
> > > 
> > > So in a typical system with a hierarchical interconnect you would have
> > > 
> > > thread
> > > core
> > > cluster (possibly multiple layers as mentioned in Brice's reply).
> > > die
> > > package
> > > 
> > > Unfortunately as pointed out in other branches of this thread, there is
> > > no consistent generic name.  I'm open to suggestions!  
> > 
> > IIUC, you are actually proposing another "die" level? I'm not sure if we
> > can actually come up with a generic name since interconnects are highly
> > implementation dependent.
> 
> Brice mentioned hwloc is using 'group'.  That seems generic enough perhaps.
> 
> > 
> > How is you memory distributed? Do you already have NUMA nodes? If you
> > want to keep tasks together, it might make sense to define the clusters
> > (in your case) as NUMA nodes.
> 
> We already have all of the standard levels.  We need at least one more.
> On a near future platform we'll have full set (kunpeng920 is single thread)
> 
> So on kunpeng 920 we have
> cores
> (clusters)
> die / llc shared at this level

IIRC, LLC sharing isn't tied to a specific level in the user-space
topology description. On some Arm systems LLC is per cluster while the
package has a single die with two clusters.

I'm slightly confused about the cache sharing. You said above that your
clusters don't share cache resources? This list says LLC is at die
level, which is above cluster level?

> package (multiple NUMA nodes in each package) 

What is your NUMA node span? Couldn't you just make it equivalent to
your clusters?

> > > For example, in zen2 this would correspond to a 'core complex' consisting
> > > 4 CPU cores (each one 2 threads) sharing some local L3 cache.
> > > https://en.wikichip.org/wiki/amd/microarchitectures/zen_2
> > > In zen3 it looks like this level will be the same as that for the die.
> > > 
> > > Given they used the name in knights landing (and as is pointed out in
> > > another branch of this thread, it's the CPUID description) I think Intel
> > > calls these 'tiles' (anyone confirm that?) 
> > > 
> > > A similar concept exists for some ARM processors. 
> > > https://en.wikichip.org/wiki/hisilicon/microarchitectures/taishan_v110
> > > CCLs in the diagram on that page.
> > > 
> > > Centriq 2400 had 2 core 'duplexes' which shared l2.
> > > https://www.anandtech.com/show/11737/analyzing-falkors-microarchitecture-a-deep-dive-into-qualcomms-centriq-2400-for-windows-server-and-linux/3
> > > 
> > > From the info release at hotchips, it looks like the thunderx3 deploys
> > > a similar ring interconnect with groups of cores, each with 4 threads.
> > > Not sure what they plan to call them yet though or whether they will chose
> > > to represent that layer of the topology in their firmware tables.
> > > 
> > > Arms CMN600 interconnect also support such 'clusters' though I have no idea
> > > if anyone has used it in this form yet.  In that case, they are called
> > > "processor compute clusters"
> > > https://developer.arm.com/documentation/100180/0103/
> > > 
> > > Xuantie-910 is cluster based as well (shares l2).
> > > 
> > > So in many cases the cluster level corresponds to something we already have
> > > visibility of due to cache sharing etc, but that isn't true in kunpeng 920.  
> > 
> > The problem I see is that the benefit of keeping tasks together due to
> > the interconnect layout might vary significantly between systems. So if
> > we introduce a new cpumask for cluster it has to have represent roughly
> > the same system properties otherwise generic software consuming this
> > information could be tricked.
> 
> Agreed.  Any software would currently have to do it's own benchmarking
> to work out how to use the presented information.  It would imply that
> you 'want to look at this group of CPUs' rather than providing any hard
> rules.  The same is true of die, which we already have.  What
> that means will vary enormously between different designs in a fashion
> that may or may not be independent of NUMA topology. Note,
> there are people who do extensive benchmarking of NUMA topology as
> the information provided is either inaccurate / missing, or not of
> sufficient detail to do their scheduling.  It's not a big load to
> do that sort of stuff on startup of software on an HPC system.

With an undefined CPU grouping mask, you would still have to do some
benchmarking to figure out if it is useful for managing your particular
workload. It would certainly make the profiling simpler though.

> 
> > 
> > If there is a provable benefit of having interconnect grouping
> > information, I think it would be better represented by a distance matrix
> > like we have for NUMA.
> 
> There have been some discussions in various forums about how to
> describe the complexity of interconnects well enough to actually be
> useful.  Those have mostly floundered on the immense complexity of
> designing such a description in a fashion any normal software would actually
> use.  +cc Jerome who raised some of this in the kernel a while back.

I agree that representing interconnect details is hard. I had hoped that
a distance matrix would be better than nothing and more generic than
inserting extra group masks.

> 
> Add this cluster / group layer seems moderately safe as it just says
> 'something here you should consider', rather than making particular
> statements on expected performance etc.
> 
> So I fully agree it would be good to have that info, if we can figure
> out how to do it!  However, that is never going to be a short term thing.

A new sysfs entry could live for a long time :-)

Morten
