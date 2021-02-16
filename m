Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1131C965
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBPLJR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 06:09:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2567 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBPLIf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 06:08:35 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dfyjs6GCmz67pC4;
        Tue, 16 Feb 2021 19:02:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 12:07:50 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 11:07:49 +0000
Date:   Tue, 16 Feb 2021 11:06:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210216110643.000071f0@Huawei.com>
In-Reply-To: <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
        <20210211094222.000048ae@Huawei.com>
        <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
        <20210212122438.00003621@Huawei.com>
        <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
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

On Fri, 12 Feb 2021 15:51:42 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Feb 12, 2021 at 4:26 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 11 Feb 2021 09:06:51 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Thu, Feb 11, 2021 at 1:44 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Wed, 10 Feb 2021 08:24:51 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  
> > > > > On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:  
> > > > > >
> > > > > > On Tue, 9 Feb 2021 19:55:05 -0800
> > > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > >  
> > > > > > > While the platform BIOS is able to describe the performance
> > > > > > > characteristics of CXL memory that is present at boot, it is unable to
> > > > > > > statically enumerate the performance of CXL memory hot inserted
> > > > > > > post-boot. The OS can enumerate most of the characteristics from link
> > > > > > > registers and CDAT, but the performance from the CPU to the host
> > > > > > > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > > > > > > ACPI mechanism for this purpose. Critically this is achieved with a
> > > > > > > small tweak to how the existing Generic Initiator proximity domain is
> > > > > > > utilized in the HMAT.  
> > > > > >
> > > > > > Hi Dan,
> > > > > >
> > > > > > Agree there is a hole here, but I think the proposed solution has some
> > > > > > issues for backwards compatibility.
> > > > > >
> > > > > > Just to clarify, I believe CDAT from root ports is sufficient for the
> > > > > > other direction (GI on CXL, memory in host).  I wondered initially if
> > > > > > this was a two way issue, but after a reread, I think that is fine
> > > > > > with the root port providing CDAT or potentially treating the root
> > > > > > port as a GI (though that runs into the same naming / representation issue
> > > > > > as below and I think would need some clarifying text in UEFI GI description)
> > > > > >
> > > > > > http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> > > > > >
> > > > > > For the case you are dealing with here potentially we 'could' add something
> > > > > > to CDAT as alternative to changing SRAT, but it would be more complex
> > > > > > so your approach here makes more sense to me.  
> > > > >
> > > > > CDAT seems the wrong mechanism because it identifies target
> > > > > performance once you're at the front door of the device, not
> > > > > performance relative to a given initiator.  
> > > >
> > > > I'd argue you could make CDAT a more symmetric representation, but it would
> > > > end up replicating a lot of info already in HMAT.  Didn't say it was a good
> > > > idea!  
> > >
> > > CDAT describes points, HMAT describes edges on the performance graph,
> > > it would be confusing if CDAT tried to supplant HMAT.  
> >
> > Entirely agreed.  Note I'm not disagreeing with approach here at all, simply
> > trying to point out where I think you'll get questions taking this to ACPI.  
> 
> Understood.
> 
> >  
> > >  
> > > >
> > > > That's an odd situation that it sort of 'half' manages it in the BIOS.
> > > > We probably need some supplementary additional docs around this topic
> > > > as the OS would need to be aware of that possibility and explicitly check
> > > > for it before doing its normal build based on CDAT + what you are proposing
> > > > here.  Maybe code is enough but given this is cross OS stuff I'd argue
> > > > it probably isn't.
> > > >
> > > > I guess could revisit this draft Uefi white paper perhaps and add a bunch
> > > > of examples around this usecase https://github.com/hisilicon/acpi-numa-whitepaper  
> > >
> > > Thanks for the reference, I'll take a look.
> > >  
> > > >  
> > > > >  
> > > > > >  
> > > > > > >
> > > > > > > # Impact of the Change
> > > > > > > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > > > > > > 5.2.16.6) already contains all the fields necessary to enumerate a
> > > > > > > generic target proximity domain. All that is missing is the
> > > > > > > interpretation of that proximity domain optionally as a target
> > > > > > > identifier in the HMAT.
> > > > > > >
> > > > > > > Given that the OS still needs to dynamically enumerate and instantiate
> > > > > > > the memory ranges behind the host bridge. The assumption is that
> > > > > > > operating systems that do not support native CXL enumeration will ignore
> > > > > > > this data in the HMAT, while CXL native enumeration aware environments
> > > > > > > will use this fragment of the performance path to calculate the
> > > > > > > performance characteristics.  
> > > > > >
> > > > > > I don't think it is true that OS not supporting native CXL will ignore the
> > > > > > data.  
> > > > >
> > > > > True, I should have chosen more careful words like s/ignore/not
> > > > > regress upon seeing/  
> > > >
> > > > It's a sticky corner and I suspect likely to come up at in ACPI WG - what is
> > > > being proposed here isn't backwards compatible  
> > >
> > > It seems our definitions of backwards compatible are divergent. Please
> > > correct me if I'm wrong, but I understand your position to be "any
> > > perceptible OS behavior change breaks backwards compatibility",
> > > whereas I'm advocating that backwards compatibility is relative
> > > regressing real world use cases. That said, I do need to go mock this
> > > up in QEMU and verify how much disturbance it causes.
> > >  
> > > > even if the impacts in Linux are small.  
> > >
> > > I'd note the kernel would grind to a halt if the criteria for
> > > "backwards compatible" was zero perceptible behavior change.  
> >
> > Key thing here is the difference between Linux backwards compatibility and
> > ACPI backwards compatibility.  Linux impacts are easily understood because
> > we can go look.  ACPI change impacts in general are rather trickier to
> > define.
> >
> > Note currently I'm fine with this change, though think perhaps it could
> > be improved - simply raising that others may not be.  
> 
> I appreciate that, and as the originator of GI I hold your feedback in
> high regard.
> 
> Yes, the criteria that it needs to be a functional regression vs a
> behavior change may be difficult argument to carry with others.
> 
> >  
> > >  
> > > > Mostly it's infrastructure bring up that won't get used
> > > > (fallback lists and similar for a node which will never be specified in
> > > > allocations) and some confusing userspace ABI (which is more than a little
> > > > confusing already).  
> > >
> > > Fallback lists are established relative to online nodes. These generic
> > > targets are not onlined as memory.  
> >
> > This doesn't really matter beyond the point that there is stuff done for
> > a GI only node currently that doesn't make any sense for this new usecase.
> >
> > Still, you got me digging...
> >
> > I may have the  wrong term there, but GI nodes have a zone list
> > generated that reflects where an allocation will go if an allocation
> > happens that is requested on the the GI node.
> >
> > devm_kzalloc() for example for a device in one of these nodes has to know
> > where to allocate memory from.  Similar true for other resources that don't
> > exist in the GI node.
> >
> > Check this worked as expected led me down a rabbit hole.  I knew the end
> > to end test did what I expected but wasn't certainly why...
> >
> > Anyhow, at least for my test case on x86 doing an 8k devm_kzalloc() it works
> > as follows.
> >
> > Some way down the nest of calls we get a call to
> > __alloc_pages_nodemask()  
> > -> prepare_alloc_pages() // this finds the zonelist
> >    -> node_listlist(gi_node, ...)
> >       -> NODE_DATA(gi_node)->node_zonelists + gfp_zonelist(flags)  
> >          node_data[gi_node]->node_zonelists + gfp_zonelist(flags)
> >
> > The node_data entry for the gi_node has it's own zonelist which is used in this
> > path.  The first entry of which is an appropriate zone on the nearest node which
> > actually has some memory.
> >
> > The build is referenced by a comment in x86/mm/numa.c under init_memory_less_node()
> > "All zonelists will be built later in start_kernel() after per cpu areas are initialized"
> >
> > build_zonelists() does the expected building based on SLIT distances.  
> 
> Ugh, I had been holding onto the mental model  that GI support was
> limited to the HMAT sysfs representation. What is the use case for
> init_gi_nodes()? I would expect GI information is only useful for
> performance calculations and that can be done without touching the
> node infrastructure.
> 
> At first glance that metadata manipulation looks like a mistake to me,
> I wish I had paid more attention as that went in... regardless this
> does indeed change my thoughts of Generic Target being a minor impact.

It's still fairly minor I think, but definitely a harder case to sell to
the ACPI WG.  Unused infrastructure shouldn't be a major issue.  No
worse than creating a GI node with say a NIC in it but never loading the
NIC driver.

> 
> Why does GI need anything more than acpi_map_pxm_to_node() to have a
> node number assigned?

It might have been possible (with limitations) to do it by making multiple
proximity domains map to a single numa node, along with some additional
functionality to allow it to retrieve the real node for aware drivers,
but seeing as we already had the memoryless node infrastructure in place,
it fitted more naturally into that scheme.  GI introduction to the
ACPI spec, and indeed the kernel was originally driven by the needs of
CCIX (before CXL was public) with CCIX's symmetric view of initiators
(CPU or other) + a few other existing situations where we'd been
papering over the topology for years and paying a cost in custom
load balancing in drivers etc. That more symmetric view meant that the
natural approach was to treat these as memoryless nodes.

The full handling of nodes is needed to deal with situations like
the following contrived setup. With a few interconnect
links I haven't bothered drawing, there are existing systems where
a portion of the topology looks like this:


    RAM                              RAM             RAM
     |                                |               |
 --------        ---------        --------        --------
| a      |      | b       |      | c      |      | d      |
|   CPUs |------|  PCI RC |------| CPUs   |------|  CPUs  |
|        |      |         |      |        |      |        |
 --------        ---------        --------        --------
                     |
                  PCI EP

We need the GI representation to allow an "aware" driver to understand
that the PCI EP is equal distances from CPUs and RAM on (a) and (c),
(and that using allocations from (d) is a a bad idea).  This would be
the same as a driver running on an PCI RC attached to a memoryless
CPU node (you would hope no one would build one of those, but I've seen
them occasionally).  Such an aware driver carefully places both memory
and processing threads / interrupts etc to balance the load.

In pre GI days, can just drop (b) into (a or c) and not worry about it, but
that comes with a large performance cost (20% plus on network throughput
on some of our more crazy systems, due to it appearing that balancing
memory load across (a) and (c) doesn't make sense).  Also, if we happened
to drop it into (c) then once we run out of space on (c) we'll start
using (d) which is a bad idea.

With GI nodes, you need an unaware PCI driver to work well and they
will use allocations linked to the particular NUMA node that are in.
The kernel needs to know a reasonable place to shunt them to and in
more complex topologies the zone list may not correspond to that of
any other node.  In a CCIX world for example, a GI can sit between
a pair of Home Agents with memory, and the host on the other side of
them.  We had a lot of fun working through these cases back when drawing
up the ACPI changes to support them. :)

There are corner cases where you have to tweak a driver to
make it more aware though or you can get unhelpful things like all memory
use on (a) and all interrupts on (c) - if things filled up in a particularly
pathological case.  However that can happen anyway whenever memory runs out
on the local node.

Jonathan

