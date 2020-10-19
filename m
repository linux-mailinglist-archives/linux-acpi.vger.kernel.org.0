Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A512292802
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgJSNQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 19 Oct 2020 09:16:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2989 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbgJSNQZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 09:16:25 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1C9D932FDD75741903FF;
        Mon, 19 Oct 2020 14:16:24 +0100 (IST)
Received: from localhost (10.52.126.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 14:16:23 +0100
Date:   Mon, 19 Oct 2020 14:14:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <guohanjun@huawei.com>, "Will Deacon" <will@kernel.org>,
        <linuxarm@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019131427.00006f40@Huawei.com>
In-Reply-To: <20201019100100.GA12908@bogus>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <20201019100100.GA12908@bogus>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.130]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 19 Oct 2020 11:01:00 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> +Morten

Hi Sudeep,
> 
> On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:
> > Both ACPI and DT provide the ability to describe additional layers of
> > topology between that of individual cores and higher level constructs
> > such as the level at which the last level cache is shared.
> > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > Node Structure [1] that is the parent of the CPU cores and in turn
> > has a parent Processor Hierarchy Nodes Structure representing
> > a higher level of topology.
> >
> > For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> > any cache resources, but the interconnect topology is such that
> > the cost to transfer ownership of a cacheline between CPUs within
> > a cluster is lower than between CPUs in different clusters on the same
> > die.   Hence, it can make sense to deliberately schedule threads
> > sharing data to a single cluster.
> >  
> 
> This is very SoC specific and hard to generalise, hence LLC is chosen
> as one of the main factor to decide.

I absolutely agree. It is very hard to modify the kernel scheduler to
take into account this information.  Chances are we'll help some workloads
and hurt others.  However, it is good to at least expose that it exists.

> 
> Are there any scheduler topology related changes to achieve the same ?
> If so, we need their opinion on that.

So far no.  We have done a few experiments with adding this knowledge
into the scheduler but it is still very much a work in progress.

However, we do have micro benchmarks showing clearly that can make a
substantial difference.  Our intent was to first expose this information to
user space and get experience of using it in applications via HWLOC
before we tried to propose any scheduler changes.

> 
> > This patch simply exposes this information to userspace libraries
> > like hwloc by providing cluster_cpus and related sysfs attributes.
> > PoC of HWLOC support at [2].
> >  
> 
> OK, cluster is too Arm specific with no definition for it whatsoever.

It does get used by others (ACPI for example), but I agree there may be
a naming issue here.  Brice observed that hwloc uses the term group to cover
the somewhat obscure drawer and book levels that powerpc uses.
Perhaps that is a better name?

> How do you plan to support clusters of clusters or higher level of
> hierarchy present in PPTT.

Right now I don't.   I was hoping that question would come up,
but didn't want to complicate the first version of this proposal.
Guess I got that wrong ;)

As Brice suggested, probably adding an index makes sense.
I'm not sure if we bother implementing more than one layer for now, but
we definitely want a naming scheme that allows for it. If anyone has
a CPU that already uses another layer let us know!

On another note, we are thinking of an ACPI PPTT addition to add a flag
for die, if anyone has another suggestions on how to match the x86
CPUID part for that, it would be great to align.  At least die is
fairly well defined...  Tile and Module not so much...

> 
> > Note this patch only handle the ACPI case.
> >  
> 
> If we decide to add this to sysfs, I prefer to keep DT implementation
> also in sync. The bindings are in sync, just matter of implementation.

Ok, happy to look at DT that if we seem to be moving forwards with this
in general.

> 
> > Special consideration is needed for SMT processors, where it is
> > necessary to move 2 levels up the hierarchy from the leaf nodes
> > (thus skipping the processor core level).
> >
> > Currently the ID provided is the offset of the Processor
> > Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> > it is not terribly elegant so alternative suggestions welcome.
> >  
> 
> That is firmware choice. May be your firmware just fills in mandatory
> fields and doesn't care about anything and everything optional. We do
> check for valid UID fields and if that is not set, offset is used as
> unique ID in kernel implementation. So if you enhance the firmware, the
> kernel sysfs will become elegant as you expect 😉 

Fair enough that there is a way to improve it, but it would be nice if
the default solution was also elegant!  I'll add the processor container
DSDT stuff to one or two of my test cases and make sure we can get
that working.  There are a lot of combinations that need testing and
I get bored quickly writing firmware tables by hand.

> 
> > Note that arm64 / ACPI does not provide any means of identifying
> > a die level in the topology but that may be unrelate to the cluster
> > level.
> >  
> 
> Indeed. It can be cluster of clusters on some platform. If we need that
> info, we should add it. My assumption was that generally each die forms
> a NUMA node and hence the information is available there. I may be wrong.

There are architectures that have exposed multiple NUMA nodes on one die.
Given steady increase in number of cores, I'd be surprised if it didn't happen
again.

An example would be the Haswell cluster on die. This pages suggests they
were exposed as NUMA nodes via SRAT proximity domains.

https://www.dell.com/support/article/en-uk/sln315049/intel-cluster-on-die-cod-technology-on-vmware-esxi?lang=en

So that isn't sufficient information.  If we want to expose it it needs
to be explicit.

> 
> > RFC questions:
> > 1) Naming
> > 2) Related to naming, do we want to represent all potential levels,
> >    or this enough?  On Kunpeng920, the next level up from cluster happens
> >    to be covered by llc cache sharing, but in theory more than one
> >    level of cluster description might be needed by some future system.  
> 
> That is my question above. Can't recall the terminology used in ACPI
> PPTT, but IIRC "cluster" is not used to keep it generic. May be we need
> to do the same here as the term "cluster" is ill-defined on Arm and I
> would avoid using it if possible.

In example text, ACPI uses the term cluster. Of course that may
reflect that the author was an ARM person (I have no idea)
E.g. The Cache Type Cluster Example Fig 5.13  Various other places in
description of power management use cluster to mean similar things.

> 
> > 3) Do we need DT code in place? I'm not sure any DT based ARM64
> >    systems would have enough complexity for this to be useful.  
> 
> I prefer to keep the implementation in sync

Fair enough.  Once we are sure this is going somewhere I'll get that
implemented (mostly writing test cases *sigh*)

> 
> > 4) Other architectures?  Is this useful on x86 for example?
> >  
> 
> AMD had multi-die within socket IIRC. IIUC, cpuid will provide the info
> and nothing more is needed from ACPI ? I may be wrong, just guessing/asking.

I'm not sure if any x86 platforms use PPTT.   However, the CPUID value,
if provided would still need to be hooked up to the sysfs files
etc.  As mentioned in another branch in this thread my guess is the
equivalent is 'tile'.

Thanks,

Jonathan

> 
> --
> Regards,
> Sudeep


