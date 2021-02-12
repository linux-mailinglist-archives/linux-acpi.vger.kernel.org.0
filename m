Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1A319E69
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhBLM1z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 07:27:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2558 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhBLM0d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 07:26:33 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcXdh5VPxz67kw9;
        Fri, 12 Feb 2021 20:20:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 13:25:40 +0100
Received: from localhost (10.47.28.230) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 12:25:39 +0000
Date:   Fri, 12 Feb 2021 12:24:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210212122438.00003621@Huawei.com>
In-Reply-To: <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
        <20210211094222.000048ae@Huawei.com>
        <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.28.230]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 11 Feb 2021 09:06:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Feb 11, 2021 at 1:44 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 10 Feb 2021 08:24:51 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Tue, 9 Feb 2021 19:55:05 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  
> > > > > While the platform BIOS is able to describe the performance
> > > > > characteristics of CXL memory that is present at boot, it is unable to
> > > > > statically enumerate the performance of CXL memory hot inserted
> > > > > post-boot. The OS can enumerate most of the characteristics from link
> > > > > registers and CDAT, but the performance from the CPU to the host
> > > > > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > > > > ACPI mechanism for this purpose. Critically this is achieved with a
> > > > > small tweak to how the existing Generic Initiator proximity domain is
> > > > > utilized in the HMAT.  
> > > >
> > > > Hi Dan,
> > > >
> > > > Agree there is a hole here, but I think the proposed solution has some
> > > > issues for backwards compatibility.
> > > >
> > > > Just to clarify, I believe CDAT from root ports is sufficient for the
> > > > other direction (GI on CXL, memory in host).  I wondered initially if
> > > > this was a two way issue, but after a reread, I think that is fine
> > > > with the root port providing CDAT or potentially treating the root
> > > > port as a GI (though that runs into the same naming / representation issue
> > > > as below and I think would need some clarifying text in UEFI GI description)
> > > >
> > > > http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> > > >
> > > > For the case you are dealing with here potentially we 'could' add something
> > > > to CDAT as alternative to changing SRAT, but it would be more complex
> > > > so your approach here makes more sense to me.  
> > >
> > > CDAT seems the wrong mechanism because it identifies target
> > > performance once you're at the front door of the device, not
> > > performance relative to a given initiator.  
> >
> > I'd argue you could make CDAT a more symmetric representation, but it would
> > end up replicating a lot of info already in HMAT.  Didn't say it was a good
> > idea!  
> 
> CDAT describes points, HMAT describes edges on the performance graph,
> it would be confusing if CDAT tried to supplant HMAT.

Entirely agreed.  Note I'm not disagreeing with approach here at all, simply
trying to point out where I think you'll get questions taking this to ACPI.

> 
> >
> > That's an odd situation that it sort of 'half' manages it in the BIOS.
> > We probably need some supplementary additional docs around this topic
> > as the OS would need to be aware of that possibility and explicitly check
> > for it before doing its normal build based on CDAT + what you are proposing
> > here.  Maybe code is enough but given this is cross OS stuff I'd argue
> > it probably isn't.
> >
> > I guess could revisit this draft Uefi white paper perhaps and add a bunch
> > of examples around this usecase https://github.com/hisilicon/acpi-numa-whitepaper  
> 
> Thanks for the reference, I'll take a look.
> 
> >  
> > >  
> > > >  
> > > > >
> > > > > # Impact of the Change
> > > > > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > > > > 5.2.16.6) already contains all the fields necessary to enumerate a
> > > > > generic target proximity domain. All that is missing is the
> > > > > interpretation of that proximity domain optionally as a target
> > > > > identifier in the HMAT.
> > > > >
> > > > > Given that the OS still needs to dynamically enumerate and instantiate
> > > > > the memory ranges behind the host bridge. The assumption is that
> > > > > operating systems that do not support native CXL enumeration will ignore
> > > > > this data in the HMAT, while CXL native enumeration aware environments
> > > > > will use this fragment of the performance path to calculate the
> > > > > performance characteristics.  
> > > >
> > > > I don't think it is true that OS not supporting native CXL will ignore the
> > > > data.  
> > >
> > > True, I should have chosen more careful words like s/ignore/not
> > > regress upon seeing/  
> >
> > It's a sticky corner and I suspect likely to come up at in ACPI WG - what is
> > being proposed here isn't backwards compatible  
> 
> It seems our definitions of backwards compatible are divergent. Please
> correct me if I'm wrong, but I understand your position to be "any
> perceptible OS behavior change breaks backwards compatibility",
> whereas I'm advocating that backwards compatibility is relative
> regressing real world use cases. That said, I do need to go mock this
> up in QEMU and verify how much disturbance it causes.
> 
> > even if the impacts in Linux are small.  
> 
> I'd note the kernel would grind to a halt if the criteria for
> "backwards compatible" was zero perceptible behavior change.

Key thing here is the difference between Linux backwards compatibility and
ACPI backwards compatibility.  Linux impacts are easily understood because
we can go look.  ACPI change impacts in general are rather trickier to
define.

Note currently I'm fine with this change, though think perhaps it could
be improved - simply raising that others may not be.

> 
> > Mostly it's infrastructure bring up that won't get used
> > (fallback lists and similar for a node which will never be specified in
> > allocations) and some confusing userspace ABI (which is more than a little
> > confusing already).  
> 
> Fallback lists are established relative to online nodes. These generic
> targets are not onlined as memory.

This doesn't really matter beyond the point that there is stuff done for
a GI only node currently that doesn't make any sense for this new usecase.

Still, you got me digging...

I may have the  wrong term there, but GI nodes have a zone list
generated that reflects where an allocation will go if an allocation
happens that is requested on the the GI node.

devm_kzalloc() for example for a device in one of these nodes has to know
where to allocate memory from.  Similar true for other resources that don't
exist in the GI node.
 
Check this worked as expected led me down a rabbit hole.  I knew the end
to end test did what I expected but wasn't certainly why...

Anyhow, at least for my test case on x86 doing an 8k devm_kzalloc() it works
as follows. 

Some way down the nest of calls we get a call to
__alloc_pages_nodemask()
-> prepare_alloc_pages() // this finds the zonelist
   -> node_listlist(gi_node, ...)
      -> NODE_DATA(gi_node)->node_zonelists + gfp_zonelist(flags)
	 node_data[gi_node]->node_zonelists + gfp_zonelist(flags)

The node_data entry for the gi_node has it's own zonelist which is used in this
path.  The first entry of which is an appropriate zone on the nearest node which
actually has some memory.

The build is referenced by a comment in x86/mm/numa.c under init_memory_less_node()
"All zonelists will be built later in start_kernel() after per cpu areas are initialized"

build_zonelists() does the expected building based on SLIT distances.


> 
> > > > Linux will create a small amount of infrastructure to reflect them (more or
> > > > less the same as a memoryless node) and also they will appear in places
> > > > like access0 as a possible initiator of transactions.  It's small stuff,
> > > > but I'd rather the impact on legacy was zero.  
> > >
> > > I'm failing to see that small collision as fatal to the proposal. The
> > > HMAT parsing had a significant bug for multiple kernel releases and no
> > > one noticed. This quirk is minor in comparison.  
> >
> > True, there is a lag in HMAT adoption - though for ACPI tables, not that long
> > (only a couple of years :)
> >  
> > >  
> > > >
> > > > So my gut feeling here is we shouldn't reuse the generic initiator, but
> > > > should invent something new.  Would look similar to GI, but with a different
> > > > ID - to ensure legacy OS ignores it.  
> > >
> > > A new id introduces more problems than it solves. Set aside the ACPICA
> > > thrash, it does not allow a clean identity mapping of a point in a
> > > system topology being both initiator and target. The SRAT does not
> > > need more data structures to convey this information. At most I would
> > > advocate for an OSC bit for the OS to opt into allowing this new usage
> > > in the HMAT, but that still feels like overkill absent a clear
> > > regression in legacy environments.  
> >
> > OSC for this case doesn't work. You can't necessarily evaluate it
> > early enough in the boot - in Linux the node setup is before AML parsing
> > comes up.  HMAT is evaluated a lot later, but SRAT is too early.  + in theory
> > another OS is allowed to evaluate HMAT before OSC is available.  
> 
> The Linux node setup for online memory is before OSC parsing, but
> there's nothing to "online" with a GI/GT entry. Also, if this was a
> problem, it would already be impacting the OS today because this
> proposal only changes HMAT, not SRAT.

It is not just changing HMAT - you've just redefined the meaning of a GI
which is an entry in SRAT.  So there may be impacts in early boot..
None of them are fatal as far as I can see, but they are undesirable
(in the sense that they are pointless for this new use).
 
> Lastly there *is* an OSC bit for
> GI, so either that's vestigial and needs to be removed, or OSC is
> relevant for this case.

No. The GI OSC bit has a very specific purpose and is absolutely necessary.

It's not about presenting GI in SRAT.  We can always present GI in SRAT
irrespective of whether the OS has a clue what it is because an OS is guaranteed
to not take any notice of entries it doesn't understand. (anything else is
just a bug). Note that in this proposal the issue is the OS 'thinks' it understands
the node, but is wrong...

The GI OSC is to allow DSDT _PXM entries to be modified (which are AML obviously
so can be modified based on _OSC).  Thus if we don't support GI we can move
the apparent location of the initiator to the best node of a type we do support.
(it also worked around Linux crashing if you supplied a _PXM for a proximity
 domain it didn't now about).

Similar case doesn't apply here because what we'd need to modify if the OS
didn't understand this new usecase would be static tables, not AML.

> 
> >  
> > > The fact that hardly anyone is
> > > using HMAT (as indicated by the bug I mentioned) gives me confidence
> > > that perfection is more "enemy of the good" than required here.  
> >
> > How about taking this another way
> >
> > 1) Assume that the costs of 'false' GI nodes on legacy system as a result
> >    of this is minor - so just live with it.  (probably true, but as ever
> >    need to confirm with other OS)
> >
> > 2) Try to remove the cost of pointless infrastructure on 'aware' kernels.
> >    Add a flag to the GI entry to say it's a bridge and not expected to,
> >    in of itself, represent an initiator or a target.
> >    In Linux we then don't create the node intrastructure etc or assign
> >    any devices to have the non existent NUMA node.
> >
> > The information is still there to combine with device info (CDAT) etc
> > and build what we eventually want in the way of a representation of
> > the topology that Linux can use.
> >
> > Now we just have the 'small' problem of figuring out how actually implement
> > hotplugging of NUMA nodes.  
> 
> I think it's tiny. Just pad the "possible" nodes past what SRAT enumerates.

Maybe, not tried it yet.  Neither _HMA nor _SLI have ever been implemented
in Linux (as far as I know) which are the ACPI equivalents of the updates
we need to make on such a hotplug.  Might not be too bad, but needs some prototyping
fun once we get the emulation up and running to provide all the info needed
+ changes like you have here to fill in the gaps.

Jonathan

