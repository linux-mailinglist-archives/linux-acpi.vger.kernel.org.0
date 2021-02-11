Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906931875E
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhBKJsc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 04:48:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2541 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhBKJoP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 04:44:15 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dbs4y2tvTz67mWv;
        Thu, 11 Feb 2021 17:38:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 10:43:23 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 09:43:23 +0000
Date:   Thu, 11 Feb 2021 09:42:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210211094222.000048ae@Huawei.com>
In-Reply-To: <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 10 Feb 2021 08:24:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 9 Feb 2021 19:55:05 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > While the platform BIOS is able to describe the performance
> > > characteristics of CXL memory that is present at boot, it is unable to
> > > statically enumerate the performance of CXL memory hot inserted
> > > post-boot. The OS can enumerate most of the characteristics from link
> > > registers and CDAT, but the performance from the CPU to the host
> > > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > > ACPI mechanism for this purpose. Critically this is achieved with a
> > > small tweak to how the existing Generic Initiator proximity domain is
> > > utilized in the HMAT.  
> >
> > Hi Dan,
> >
> > Agree there is a hole here, but I think the proposed solution has some
> > issues for backwards compatibility.
> >
> > Just to clarify, I believe CDAT from root ports is sufficient for the
> > other direction (GI on CXL, memory in host).  I wondered initially if
> > this was a two way issue, but after a reread, I think that is fine
> > with the root port providing CDAT or potentially treating the root
> > port as a GI (though that runs into the same naming / representation issue
> > as below and I think would need some clarifying text in UEFI GI description)
> >
> > http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> >
> > For the case you are dealing with here potentially we 'could' add something
> > to CDAT as alternative to changing SRAT, but it would be more complex
> > so your approach here makes more sense to me.  
> 
> CDAT seems the wrong mechanism because it identifies target
> performance once you're at the front door of the device, not
> performance relative to a given initiator.

I'd argue you could make CDAT a more symmetric representation, but it would
end up replicating a lot of info already in HMAT.  Didn't say it was a good
idea!

> 
> >  
> > >
> > > ---
> > >
> > > # Title: Introduce a Generic Target for CXL
> > >
> > > # Status: Draft
> > >
> > > # Document: ACPI Specification 6.4
> > >
> > > # License
> > > SPDX-License Identifier: CC-BY-4.0
> > >
> > > # Submitter:
> > > * Sponsor: Dan Williams, Intel
> > > * Creators/Contributors:
> > >     * Mahesh Natu, Intel
> > >     * Chet Douglas, Intel
> > >     * Deepak Shivakumar, Intel
> > >
> > > # Summary of the Change
> > > Introduce a "Generic Target" concept to the SRAT to describe the root
> > > performance parameters in the path to dynamically discovered (outside of
> > > ACPI enumeration) CXL memory target endpoints.
> > >
> > > # Benefits of the Change
> > > Consider the case of a system with a set of CXL host bridges (ACPI0016),  
> >
> > Superficially feels like this new SRAT entry might reference the CXL 2.0 Root
> > ports or the host bridge.
> >  
> > > and no devices attached at initial system power-on. In this scenario
> > > platform firmware is unable to perform the end-to-end enumeration
> > > necessary to populate SRAT and HMAT for the endpoints that may be
> > > hot-inserted behind those bridges post power-on. The address-range is
> > > unknown so SRAT can not be pre-populated, the performance is unknown (no
> > > CDAT nor interleave configuration) so HMAT can not be pre-populated.
> > >
> > > However, what is known to platform firmware that generates the SRAT and
> > > HMAT is the performance characteristics of the path between CPU and
> > > Generic Initiators to the CXL host bridge target. With either
> > > CPU-to-Generic-Target, or Generic-Initiator-to-Generic-Target entries in
> > > the HMAT the OS CXL subsystem can enumerate the remaining details (PCIE
> > > link status, device CDAT, interleave configuration) to calculate the
> > > bandwidth and latency of a dynamically discovered CXL memory target.  
> >
> > I'm wondering if the term "generic target" is a good name.
> > Would something like "generic target bridge" be clearer?
> > The point being this isn't an actual target but a point along the way.
> > Mind you this is close to bike shedding.
> >
> > As mentioned above, maybe "generic bridge" that can give us a node to hang
> > data off for both, a) GI on CXL to host memory, and b) Initiator in host to CXL memory
> > and hence give cleaner representation.  
> 
> "Target" in the sense of its role in the HMAT. This is conceptually
> not limited to bridges. Imagine a CXL endpoint that the BIOS lets the
> OS map into the memory address space, but describes the performance in
> HMAT.

That's an odd situation that it sort of 'half' manages it in the BIOS.
We probably need some supplementary additional docs around this topic
as the OS would need to be aware of that possibility and explicitly check
for it before doing its normal build based on CDAT + what you are proposing
here.  Maybe code is enough but given this is cross OS stuff I'd argue
it probably isn't.

I guess could revisit this draft Uefi white paper perhaps and add a bunch
of examples around this usecase https://github.com/hisilicon/acpi-numa-whitepaper

> 
> >  
> > >
> > > # Impact of the Change
> > > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > > 5.2.16.6) already contains all the fields necessary to enumerate a
> > > generic target proximity domain. All that is missing is the
> > > interpretation of that proximity domain optionally as a target
> > > identifier in the HMAT.
> > >
> > > Given that the OS still needs to dynamically enumerate and instantiate
> > > the memory ranges behind the host bridge. The assumption is that
> > > operating systems that do not support native CXL enumeration will ignore
> > > this data in the HMAT, while CXL native enumeration aware environments
> > > will use this fragment of the performance path to calculate the
> > > performance characteristics.  
> >
> > I don't think it is true that OS not supporting native CXL will ignore the
> > data.  
> 
> True, I should have chosen more careful words like s/ignore/not
> regress upon seeing/

It's a sticky corner and I suspect likely to come up at in ACPI WG - what is
being proposed here isn't backwards compatible, even if the impacts in Linux
are small.  Mostly it's infrastructure bring up that won't get used
(fallback lists and similar for a node which will never be specified in
allocations) and some confusing userspace ABI (which is more than a little
confusing already). 

> 
> >
> > Linux will create a small amount of infrastructure to reflect them (more or
> > less the same as a memoryless node) and also they will appear in places
> > like access0 as a possible initiator of transactions.  It's small stuff,
> > but I'd rather the impact on legacy was zero.  
> 
> I'm failing to see that small collision as fatal to the proposal. The
> HMAT parsing had a significant bug for multiple kernel releases and no
> one noticed. This quirk is minor in comparison.

True, there is a lag in HMAT adoption - though for ACPI tables, not that long
(only a couple of years :)

> 
> >
> > So my gut feeling here is we shouldn't reuse the generic initiator, but
> > should invent something new.  Would look similar to GI, but with a different
> > ID - to ensure legacy OS ignores it.  
> 
> A new id introduces more problems than it solves. Set aside the ACPICA
> thrash, it does not allow a clean identity mapping of a point in a
> system topology being both initiator and target. The SRAT does not
> need more data structures to convey this information. At most I would
> advocate for an OSC bit for the OS to opt into allowing this new usage
> in the HMAT, but that still feels like overkill absent a clear
> regression in legacy environments.

OSC for this case doesn't work. You can't necessarily evaluate it
early enough in the boot - in Linux the node setup is before AML parsing
comes up.  HMAT is evaluated a lot later, but SRAT is too early.  + in theory
another OS is allowed to evaluate HMAT before OSC is available.
 
> The fact that hardly anyone is
> using HMAT (as indicated by the bug I mentioned) gives me confidence
> that perfection is more "enemy of the good" than required here.

How about taking this another way

1) Assume that the costs of 'false' GI nodes on legacy system as a result
   of this is minor - so just live with it.  (probably true, but as ever
   need to confirm with other OS)

2) Try to remove the cost of pointless infrastructure on 'aware' kernels.
   Add a flag to the GI entry to say it's a bridge and not expected to,
   in of itself, represent an initiator or a target.
   In Linux we then don't create the node intrastructure etc or assign
   any devices to have the non existent NUMA node.

The information is still there to combine with device info (CDAT) etc
and build what we eventually want in the way of a representation of
the topology that Linux can use.

Now we just have the 'small' problem of figuring out how actually implement
hotplugging of NUMA nodes.

Jonathan

> 
> >
> > Unfortunately we can't just add a flag because backwards compatibility
> > with old OS would mean it was ignored.  Hence I think this needs to be
> > a new type.
> >
> > If we define a new node type rather than extend GI, we need to be careful
> > around the same issue with _PXM that we had when introducing Generic
> > Initiators (not sure the protections on that made it back to stable)
> > so might need to modify DSDT _PXM responses based on appropriate _OSC.
> > May well be fine but I'm not convinced yet.  Perhaps we need to say
> > that using _PXM to place anything in a node defined only via this new means
> > is not valid.
> >
> > Jonathan
> >  
> > >
> > > # References
> > > * Compute Express Link Specification v2.0,
> > > <https://www.computeexpresslink.org/>
> > >
> > > # Detailed Description of the Change
> > >
> > > * Replace "Generic Initiator" with "Generic Initiator / Target" in all
> > > locations except where an "initiator" or "target" is implied.
> > > Specifically 5.2.27.3 "Memory Proximity Domain Attributes Structure"
> > > need not replace occurrences of "generic initiator" in field: "Proximity
> > > Domain for Attached Initiator". Additionally field: "Proximity Domain
> > > for the Memory" must be renamed to "Proximity Domain for the Memory /
> > > Generic Target" with a new description "Integer that represents the
> > > memory / generic target proximity domain to which this memory belongs."
> > >
> > > * Revise "5.2.16.6 Generic Initiator Affinity Structure" to make it
> > >   consistent with being referenced as either a target or initiator.
> > >
> > >         * Description: (replace all text)
> > >  
> > >         > The Generic Initiator / Target Affinity Structure provides the
> > >         > association between a Generic Initiator and a Memory Proximity
> > >         > Domain, or another Generic Target Proximity Domain. The
> > >         > distinction as to whether this structure represents an
> > >         > Initiator, a Target, or both depends on how it is referenced
> > >         > in the HMAT. See Section 5.2.27.3 for details.  
> > >  
> > >         > Support of Generic Initiator / Target Affinity Structures by
> > >         > OSPM is optional, and the platform may query whether the OS
> > >         > supports it via the _OSC method. See Section 6.2.11.2.  
> > >
> > >         * Architectural transactions: (append after current text)
> > >  
> > >         > If this proximity domain is referenced as a target then it
> > >         > supports all the transaction types inferred above.  
> > >
> > >         * Other updates are simple Initiator => Initiator / Target
> > >           replacements.  
> >
> >  

