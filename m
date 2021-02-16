Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE431CFE2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPSI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 13:08:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2575 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBPSIX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 13:08:23 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dg82H61gpz67n75;
        Wed, 17 Feb 2021 02:02:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Feb 2021 19:07:40 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 18:07:40 +0000
Date:   Tue, 16 Feb 2021 18:06:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210216180634.00007178@Huawei.com>
In-Reply-To: <CAPcyv4iv9kFLU7U9=VpYJZOiahUWJAZ_J_ZWCrGy1Lgqq+07kg@mail.gmail.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
        <20210211094222.000048ae@Huawei.com>
        <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
        <20210212122438.00003621@Huawei.com>
        <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
        <20210216110643.000071f0@Huawei.com>
        <CAPcyv4iv9kFLU7U9=VpYJZOiahUWJAZ_J_ZWCrGy1Lgqq+07kg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 16 Feb 2021 08:29:01 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Feb 16, 2021 at 3:08 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]
> > > Why does GI need anything more than acpi_map_pxm_to_node() to have a
> > > node number assigned?  
> >
> > It might have been possible (with limitations) to do it by making multiple
> > proximity domains map to a single numa node, along with some additional
> > functionality to allow it to retrieve the real node for aware drivers,
> > but seeing as we already had the memoryless node infrastructure in place,
> > it fitted more naturally into that scheme.  GI introduction to the
> > ACPI spec, and indeed the kernel was originally driven by the needs of
> > CCIX (before CXL was public) with CCIX's symmetric view of initiators
> > (CPU or other) + a few other existing situations where we'd been
> > papering over the topology for years and paying a cost in custom
> > load balancing in drivers etc. That more symmetric view meant that the
> > natural approach was to treat these as memoryless nodes.
> >
> > The full handling of nodes is needed to deal with situations like
> > the following contrived setup. With a few interconnect
> > links I haven't bothered drawing, there are existing systems where
> > a portion of the topology looks like this:
> >
> >
> >     RAM                              RAM             RAM
> >      |                                |               |
> >  --------        ---------        --------        --------
> > | a      |      | b       |      | c      |      | d      |
> > |   CPUs |------|  PCI RC |------| CPUs   |------|  CPUs  |
> > |        |      |         |      |        |      |        |
> >  --------        ---------        --------        --------
> >                      |
> >                   PCI EP
> >
> > We need the GI representation to allow an "aware" driver to understand
> > that the PCI EP is equal distances from CPUs and RAM on (a) and (c),
> > (and that using allocations from (d) is a a bad idea).  This would be
> > the same as a driver running on an PCI RC attached to a memoryless
> > CPU node (you would hope no one would build one of those, but I've seen
> > them occasionally).  Such an aware driver carefully places both memory
> > and processing threads / interrupts etc to balance the load.  
> 
> That's an explanation for why GI exists, not an explanation for why a
> GI needs to be anything more than translated to a Linux numa node
> number and an api to lookup distance.

Why should a random driver need to know it needs to do something special?

Random drivers don't lookup distance, they just allocate memory based on their
current numa_node. devm_kzalloc() does this under the hood (an optimization
that rather took me by surprise at the time).
Sure we could add a bunch of new infrastructure to solve that problem
but why not use what is already there?

> 
> >
> > In pre GI days, can just drop (b) into (a or c) and not worry about it, but
> > that comes with a large performance cost (20% plus on network throughput
> > on some of our more crazy systems, due to it appearing that balancing
> > memory load across (a) and (c) doesn't make sense).  Also, if we happened
> > to drop it into (c) then once we run out of space on (c) we'll start
> > using (d) which is a bad idea.
> >
> > With GI nodes, you need an unaware PCI driver to work well and they
> > will use allocations linked to the particular NUMA node that are in.
> > The kernel needs to know a reasonable place to shunt them to and in
> > more complex topologies the zone list may not correspond to that of
> > any other node.  
> 
> The kernel "needs", no it doesn't. Look at the "target_node" handling
> for PMEM. Those nodes are offline, the distance can be determined, and
> only when they become memory does the node become online.

Indeed, custom code for specific cases can work just fine (we've carried
plenty of it in the past to get best performance from systems), but for GIs
the intent was they would just work.  We don't want to have to go and change
stuff in PCI drivers every time we plug a new card into such a system.

> 
> The only point I can see GI needing anything more than the equivalent
> of "target_node" is when the scheduler can submit jobs to GI
> initiators like a CPU. Otherwise, GI is just a seed for a node number
> plus numa distance.

That would be true if Linux didn't already make heavy use of numa_node
for driver allocations.  We could carry a parallel value of 'real_numa_node'
or something like that, but you can't safely use numa_node without the
node being online and zone lists present.
Another way of looking at it is that zone list is a cache solving the
question of where to allocate memory, which you could also solve using
the node number and distances (at the cost of custom handling).

It is of course advantageous to do cleverer things for particular drivers
but the vast majority need to just work.

> 
> >   In a CCIX world for example, a GI can sit between
> > a pair of Home Agents with memory, and the host on the other side of
> > them.  We had a lot of fun working through these cases back when drawing
> > up the ACPI changes to support them. :)
> >  
> 
> Yes, I can imagine several interesting ACPI cases, but still
> struggling to justify the GI zone list metadata.

It works. It solves the problem. It's very little extra code and it
exercises zero paths not already exercised by memoryless nodes.
We certainly wouldn't have invented something as complex as zone lists
if we couldn't leverage what was there of course.

So I have the opposite view point. I can't see why the minor overhead
of zone list metadata for GIs isn't a sensible choice vs cost of
maintaining something entirely different.  This only changes with the
intent to use them to represent something different.

Jonathan



