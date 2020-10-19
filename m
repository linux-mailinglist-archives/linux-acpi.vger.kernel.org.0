Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2C292A76
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 17:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgJSPas convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 19 Oct 2020 11:30:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729910AbgJSPar (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 11:30:47 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 08E31D18AB0B0ABB99CD;
        Mon, 19 Oct 2020 16:30:46 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 16:30:45 +0100
Date:   Mon, 19 Oct 2020 16:30:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
CC:     Len Brown <len.brown@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <x86@kernel.org>, <guohanjun@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        <linux-acpi@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, <valentin.schneider@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019153044.00004149@huawei.com>
In-Reply-To: <20201019141653.GE8004@e123083-lin>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <20201019103522.GK2628@hirez.programming.kicks-ass.net>
        <20201019123226.00006705@Huawei.com>
        <20201019131052.GC8004@e123083-lin>
        <20201019134157.00001c97@Huawei.com>
        <20201019141653.GE8004@e123083-lin>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 19 Oct 2020 16:16:53 +0200
Morten Rasmussen <morten.rasmussen@arm.com> wrote:

> On Mon, Oct 19, 2020 at 02:41:57PM +0100, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2020 15:10:52 +0200
> > Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >   
> > > Hi Jonathan,
> > > 
> > > On Mon, Oct 19, 2020 at 01:32:26PM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 19 Oct 2020 12:35:22 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > >     
> > > > > On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:    
> > > > > > Both ACPI and DT provide the ability to describe additional layers of
> > > > > > topology between that of individual cores and higher level constructs
> > > > > > such as the level at which the last level cache is shared.
> > > > > > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > > > > > Node Structure [1] that is the parent of the CPU cores and in turn
> > > > > > has a parent Processor Hierarchy Nodes Structure representing
> > > > > > a higher level of topology.
> > > > > > 
> > > > > > For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> > > > > > any cache resources, but the interconnect topology is such that
> > > > > > the cost to transfer ownership of a cacheline between CPUs within
> > > > > > a cluster is lower than between CPUs in different clusters on the same
> > > > > > die.   Hence, it can make sense to deliberately schedule threads
> > > > > > sharing data to a single cluster.
> > > > > > 
> > > > > > This patch simply exposes this information to userspace libraries
> > > > > > like hwloc by providing cluster_cpus and related sysfs attributes.
> > > > > > PoC of HWLOC support at [2].
> > > > > > 
> > > > > > Note this patch only handle the ACPI case.
> > > > > > 
> > > > > > Special consideration is needed for SMT processors, where it is
> > > > > > necessary to move 2 levels up the hierarchy from the leaf nodes
> > > > > > (thus skipping the processor core level).      
> > > > 
> > > > Hi Peter,
> > > >     
> > > > > 
> > > > > I'm confused by all of this. The core level is exactly what you seem to
> > > > > want.    
> > > > 
> > > > It's the level above the core, whether in an multi-threaded core
> > > > or a single threaded core.   This may correspond to the level
> > > > at which caches are shared (typically L3).  Cores are already well
> > > > represented via thread_siblings and similar.  Extra confusion is that
> > > > the current core_siblings (deprecated) sysfs interface, actually reflects
> > > > the package level and ignores anything in between core and
> > > > package (such as die on x86)
> > > > 
> > > > So in a typical system with a hierarchical interconnect you would have
> > > > 
> > > > thread
> > > > core
> > > > cluster (possibly multiple layers as mentioned in Brice's reply).
> > > > die
> > > > package
> > > > 
> > > > Unfortunately as pointed out in other branches of this thread, there is
> > > > no consistent generic name.  I'm open to suggestions!    
> > > 
> > > IIUC, you are actually proposing another "die" level? I'm not sure if we
> > > can actually come up with a generic name since interconnects are highly
> > > implementation dependent.  
> > 
> > Brice mentioned hwloc is using 'group'.  That seems generic enough perhaps.
> >   
> > > 
> > > How is you memory distributed? Do you already have NUMA nodes? If you
> > > want to keep tasks together, it might make sense to define the clusters
> > > (in your case) as NUMA nodes.  
> > 
> > We already have all of the standard levels.  We need at least one more.
> > On a near future platform we'll have full set (kunpeng920 is single thread)
> > 
> > So on kunpeng 920 we have
> > cores
> > (clusters)
> > die / llc shared at this level  
> 
> IIRC, LLC sharing isn't tied to a specific level in the user-space
> topology description. On some Arm systems LLC is per cluster while the
> package has a single die with two clusters.

That was just an example of this system where it happens to sit at that level.
Nothing stops per core private LLC with the right coherence protocol.
Basically LLC can sit at any level.

It is indirectly exposed and used by userspace - though which level it attaches
to or whether it defines it own varies.
So in cpuX/topology there is no mention of caches, but if you are using hwloc
it also uses
cpuX/cache/indexX
and from that it will happily add more layers of topology to 
reflect cache sharing.  It will merge the cache levels with existing levels
from cpuX/topology if they happen to match.

So it may not have been the intent of the sysfs design, but a commonly
used library is figuring it out anyway.

> 
> I'm slightly confused about the cache sharing. You said above that your
> clusters don't share cache resources? This list says LLC is at die
> level, which is above cluster level?

Yes. Cluster is below the level at which the l3 is shared.
It's more complex than that in reality but at the coarse scale
we can describe at all, the l3 is at the die level.

From lstopo (heavily cropped obviously, it's a 128 core 2 socket system)

Machine (1006GB total)
  Package L#0
    L3 L#0 (32MB)
      NUMANode L#0 (P#0 252GB)
      Cluster L#0
        L2 L#0 (512KB) + L1d L#0 (64KB) + L1i L#0 (64KB) + Core L#0 + PU L#0 (P#0)
        L2 L#1 (512KB) + L1d L#1 (64KB) + L1i L#1 (64KB) + Core L#1 + PU L#1 (P#1)
        L2 L#2 (512KB) + L1d L#2 (64KB) + L1i L#2 (64KB) + Core L#2 + PU L#2 (P#2)
        L2 L#3 (512KB) + L1d L#3 (64KB) + L1i L#3 (64KB) + Core L#3 + PU L#3 (P#3)
      Cluster L#1
        L2 L#4 (512KB) + L1d L#4 (64KB) + L1i L#4 (64KB) + Core L#4 + PU L#4 (P#4)
        L2 L#5 (512KB) + L1d L#5 (64KB) + L1i L#5 (64KB) + Core L#5 + PU L#5 (P#5)
        L2 L#6 (512KB) + L1d L#6 (64KB) + L1i L#6 (64KB) + Core L#6 + PU L#6 (P#6)
        L2 L#7 (512KB) + L1d L#7 (64KB) + L1i L#7 (64KB) + Core L#7 + PU L#7 (P#7)
...
    L3 L#1 (32MB)
      NUMANode L#1 (P#1 252GB)
      Cluster L#8
        L2 L#32 (512KB) + L1d L#32 (64KB) + L1i L#32 (64KB) + Core L#32 + PU L#32 (P#32)
        L2 L#33 (512KB) + L1d L#33 (64KB) + L1i L#33 (64KB) + Core L#33 + PU L#33 (P#33)
        L2 L#34 (512KB) + L1d L#34 (64KB) + L1i L#34 (64KB) + Core L#34 + PU L#34 (P#34)
        L2 L#35 (512KB) + L1d L#35 (64KB) + L1i L#35 (64KB) + Core L#35 + PU L#35 (P#35)
...

  Package L#1                                                                                                                                                    
    L3 L#2 (32MB)                                                                                                                                                  
      NUMANode L#2 (P#2 252GB)                                                                                                                                     
      Cluster L#16
        L2 L#64 (512KB) + L1d L#64 (64KB) + L1i L#64 (64KB) + Core L#64 + PU L#64 (P#64)
        L2 L#65 (512KB) + L1d L#65 (64KB) + L1i L#65 (64KB) + Core L#65 + PU L#65 (P#65)
        L2 L#66 (512KB) + L1d L#66 (64KB) + L1i L#66 (64KB) + Core L#66 + PU L#66 (P#66)
        L2 L#67 (512KB) + L1d L#67 (64KB) + L1i L#67 (64KB) + Core L#67 + PU L#67 (P#67)
etc


> > package (multiple NUMA nodes in each package)   
> 
> What is your NUMA node span? Couldn't you just make it equivalent to
> your clusters?

Nope can't do that. System has 2 nodes per package, multiple packages per system and
interconnect hangs off one end of the each package. It's one of the platforms that has been
causing Valentin issues with span.  (span 3 I think?) 2 socket system basically looks like

[a]-[b]-----[c]-[d] 

where dash length reflects distance and there isn't a direct [a] to [d] path.

We have tried messing around with dropping the die level of NUMA description
in favour of representing cluster in the past, but it worked worse than going
for NUMA at the die level (which is where the memory controllers are anyway).
The cluster affects are generally more minor than NUMA.  Hence I'm not proposing
putting them anywhere they'd current affect the kernel scheduler.

> 
> > > > For example, in zen2 this would correspond to a 'core complex' consisting
> > > > 4 CPU cores (each one 2 threads) sharing some local L3 cache.
> > > > https://en.wikichip.org/wiki/amd/microarchitectures/zen_2
> > > > In zen3 it looks like this level will be the same as that for the die.
> > > > 
> > > > Given they used the name in knights landing (and as is pointed out in
> > > > another branch of this thread, it's the CPUID description) I think Intel
> > > > calls these 'tiles' (anyone confirm that?) 
> > > > 
> > > > A similar concept exists for some ARM processors. 
> > > > https://en.wikichip.org/wiki/hisilicon/microarchitectures/taishan_v110
> > > > CCLs in the diagram on that page.
> > > > 
> > > > Centriq 2400 had 2 core 'duplexes' which shared l2.
> > > > https://www.anandtech.com/show/11737/analyzing-falkors-microarchitecture-a-deep-dive-into-qualcomms-centriq-2400-for-windows-server-and-linux/3
> > > > 
> > > > From the info release at hotchips, it looks like the thunderx3 deploys
> > > > a similar ring interconnect with groups of cores, each with 4 threads.
> > > > Not sure what they plan to call them yet though or whether they will chose
> > > > to represent that layer of the topology in their firmware tables.
> > > > 
> > > > Arms CMN600 interconnect also support such 'clusters' though I have no idea
> > > > if anyone has used it in this form yet.  In that case, they are called
> > > > "processor compute clusters"
> > > > https://developer.arm.com/documentation/100180/0103/
> > > > 
> > > > Xuantie-910 is cluster based as well (shares l2).
> > > > 
> > > > So in many cases the cluster level corresponds to something we already have
> > > > visibility of due to cache sharing etc, but that isn't true in kunpeng 920.    
> > > 
> > > The problem I see is that the benefit of keeping tasks together due to
> > > the interconnect layout might vary significantly between systems. So if
> > > we introduce a new cpumask for cluster it has to have represent roughly
> > > the same system properties otherwise generic software consuming this
> > > information could be tricked.  
> > 
> > Agreed.  Any software would currently have to do it's own benchmarking
> > to work out how to use the presented information.  It would imply that
> > you 'want to look at this group of CPUs' rather than providing any hard
> > rules.  The same is true of die, which we already have.  What
> > that means will vary enormously between different designs in a fashion
> > that may or may not be independent of NUMA topology. Note,
> > there are people who do extensive benchmarking of NUMA topology as
> > the information provided is either inaccurate / missing, or not of
> > sufficient detail to do their scheduling.  It's not a big load to
> > do that sort of stuff on startup of software on an HPC system.  
> 
> With an undefined CPU grouping mask, you would still have to do some
> benchmarking to figure out if it is useful for managing your particular
> workload. It would certainly make the profiling simpler though.

Absolutely.  Playing guess for the scale of clusters is not going to be
pretty.  I suppose you'd probably catch most systems if you brute forced
2,4 and 8 and hoped your CPUs were in sane order (optimistic).

> 
> >   
> > > 
> > > If there is a provable benefit of having interconnect grouping
> > > information, I think it would be better represented by a distance matrix
> > > like we have for NUMA.  
> > 
> > There have been some discussions in various forums about how to
> > describe the complexity of interconnects well enough to actually be
> > useful.  Those have mostly floundered on the immense complexity of
> > designing such a description in a fashion any normal software would actually
> > use.  +cc Jerome who raised some of this in the kernel a while back.  
> 
> I agree that representing interconnect details is hard. I had hoped that
> a distance matrix would be better than nothing and more generic than
> inserting extra group masks.

Short of affectively mapping it to groups (which is basically what SLIT ends
up being used for) I'm not sure how on earth we'd define it.

Distance for what operation?
Shared access to a cacheline?
Get exclusive? (with all the fun of chatting to directories and possible DCT)

There are whole set of possibilities and we might potentially want bandwidth.
All come with a bunch of questions around access patterns etc (probably
- I've not really thought about this that much for this case!)

Basically we'd be trying to wrap up all the complex stuff those interconnect
and cache specialists work on in a single number.   It's going to just become
and ordered list of who is nearer..  So another way of representing the
groupings we can already describe in firmware.

> 
> > 
> > Add this cluster / group layer seems moderately safe as it just says
> > 'something here you should consider', rather than making particular
> > statements on expected performance etc.
> > 
> > So I fully agree it would be good to have that info, if we can figure
> > out how to do it!  However, that is never going to be a short term thing.  
> 
> A new sysfs entry could live for a long time :-)

Agreed.  But it if it is generic and easy to support from existing description
(which this is) then that shouldn't be a problem.  Definitely good to get
it as good as we can at the start though.

If something better comes along that is more useful people can transition to
that and it doesn't matter if the burden of maintaining the old route is trivial.

I'm absolutely in favour of better description and happy to work with people on
that but it's a multi year job at the very least.  We all love standards bodies :)

Biggest job here would be proving the info was useful and generic across
many 'interesting' system architectures.  Many of which also have more than one
mode in which you can run the caches.

> 
> Morten

Jonathan

