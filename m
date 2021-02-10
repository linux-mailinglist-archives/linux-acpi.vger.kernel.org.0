Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCED1316AAE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBJQEn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 11:04:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2534 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhBJQEh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 11:04:37 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbPbw3NzSz67bth;
        Thu, 11 Feb 2021 00:00:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 17:03:53 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 16:03:52 +0000
Date:   Wed, 10 Feb 2021 16:02:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Natu, Mahesh" <mahesh.natu@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
Message-ID: <20210210160252.00003a31@Huawei.com>
In-Reply-To: <BN6PR11MB17324DD5B5E3B96BD022D8BBF58D9@BN6PR11MB1732.namprd11.prod.outlook.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
        <20210210112330.00003e74@Huawei.com>
        <BN6PR11MB17324DD5B5E3B96BD022D8BBF58D9@BN6PR11MB1732.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 10 Feb 2021 15:18:38 +0000
"Natu, Mahesh" <mahesh.natu@intel.com> wrote:

> Hi Jonathan,
Hi Mahesh,

> 
> First of all, it is a two-way problem because of the possibility of peer to peer traffic between root ports.

Good point.  So in that case it seems we need to be able to report characteristics between pairs
of CXL ports (in generic terms 'boundaries' of the system where stuff might be connected later.)
As such they need to be represented in topology as something that can be both
a target and initiator (or a bridge to targets and initiators anyway).

> 
> CDAT works very well for enumerable components with clean boundaries. It was not designed to handle Root complex objects. For example, it would have to account for CPU vendor specific coherent links between CPUs and at that point it starts looking like "HMAT".

Agreed.  Clear distinction between what 'could' be done and what makes sense
to do in CDAT.  It's definitely feels like the wrong solution here.

Jonathan

> 
> Thank you,
> Mahesh Natu
> Datacenter Platform Architect
> Intel Corporation
> 
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com> 
> Sent: Wednesday, February 10, 2021 3:24 AM
> To: Williams, Dan J <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org; Linux ACPI <linux-acpi@vger.kernel.org>; Natu, Mahesh <mahesh.natu@intel.com>; Douglas, Chet R <chet.r.douglas@intel.com>; Widawsky, Ben <ben.widawsky@intel.com>; Verma, Vishal L <vishal.l.verma@intel.com>
> Subject: Re: [RFC] ACPI Code First ECR: Generic Target
> 
> On Tue, 9 Feb 2021 19:55:05 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > While the platform BIOS is able to describe the performance 
> > characteristics of CXL memory that is present at boot, it is unable to 
> > statically enumerate the performance of CXL memory hot inserted 
> > post-boot. The OS can enumerate most of the characteristics from link 
> > registers and CDAT, but the performance from the CPU to the host 
> > bridge, for example, is not enumerated by PCIE or CXL. Introduce an 
> > ACPI mechanism for this purpose. Critically this is achieved with a 
> > small tweak to how the existing Generic Initiator proximity domain is 
> > utilized in the HMAT.  
> 
> Hi Dan,
> 
> Agree there is a hole here, but I think the proposed solution has some issues for backwards compatibility.
> 
> Just to clarify, I believe CDAT from root ports is sufficient for the other direction (GI on CXL, memory in host).  I wondered initially if this was a two way issue, but after a reread, I think that is fine with the root port providing CDAT or potentially treating the root port as a GI (though that runs into the same naming / representation issue as below and I think would need some clarifying text in UEFI GI description)
> 
> http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> 
> For the case you are dealing with here potentially we 'could' add something to CDAT as alternative to changing SRAT, but it would be more complex so your approach here makes more sense to me.
> 
> > 
> > ---
> > 
> > # Title: Introduce a Generic Target for CXL
> > 
> > # Status: Draft
> > 
> > # Document: ACPI Specification 6.4
> > 
> > # License
> > SPDX-License Identifier: CC-BY-4.0
> > 
> > # Submitter:
> > * Sponsor: Dan Williams, Intel
> > * Creators/Contributors:
> >     * Mahesh Natu, Intel
> >     * Chet Douglas, Intel
> >     * Deepak Shivakumar, Intel
> > 
> > # Summary of the Change
> > Introduce a "Generic Target" concept to the SRAT to describe the root 
> > performance parameters in the path to dynamically discovered (outside 
> > of ACPI enumeration) CXL memory target endpoints.
> > 
> > # Benefits of the Change
> > Consider the case of a system with a set of CXL host bridges 
> > (ACPI0016),  
> 
> Superficially feels like this new SRAT entry might reference the CXL 2.0 Root ports or the host bridge.
> 
> > and no devices attached at initial system power-on. In this scenario 
> > platform firmware is unable to perform the end-to-end enumeration 
> > necessary to populate SRAT and HMAT for the endpoints that may be 
> > hot-inserted behind those bridges post power-on. The address-range is 
> > unknown so SRAT can not be pre-populated, the performance is unknown 
> > (no CDAT nor interleave configuration) so HMAT can not be pre-populated.
> > 
> > However, what is known to platform firmware that generates the SRAT 
> > and HMAT is the performance characteristics of the path between CPU 
> > and Generic Initiators to the CXL host bridge target. With either 
> > CPU-to-Generic-Target, or Generic-Initiator-to-Generic-Target entries 
> > in the HMAT the OS CXL subsystem can enumerate the remaining details 
> > (PCIE link status, device CDAT, interleave configuration) to calculate 
> > the bandwidth and latency of a dynamically discovered CXL memory target.  
> 
> I'm wondering if the term "generic target" is a good name.
> Would something like "generic target bridge" be clearer?
> The point being this isn't an actual target but a point along the way.
> Mind you this is close to bike shedding.
> 
> As mentioned above, maybe "generic bridge" that can give us a node to hang data off for both, a) GI on CXL to host memory, and b) Initiator in host to CXL memory and hence give cleaner representation.
> 
> > 
> > # Impact of the Change
> > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > 5.2.16.6) already contains all the fields necessary to enumerate a 
> > generic target proximity domain. All that is missing is the 
> > interpretation of that proximity domain optionally as a target 
> > identifier in the HMAT.
> > 
> > Given that the OS still needs to dynamically enumerate and instantiate 
> > the memory ranges behind the host bridge. The assumption is that 
> > operating systems that do not support native CXL enumeration will 
> > ignore this data in the HMAT, while CXL native enumeration aware 
> > environments will use this fragment of the performance path to 
> > calculate the performance characteristics.  
> 
> I don't think it is true that OS not supporting native CXL will ignore the data.
> 
> Linux will create a small amount of infrastructure to reflect them (more or less the same as a memoryless node) and also they will appear in places like access0 as a possible initiator of transactions.  It's small stuff, but I'd rather the impact on legacy was zero.
> 
> So my gut feeling here is we shouldn't reuse the generic initiator, but should invent something new.  Would look similar to GI, but with a different ID - to ensure legacy OS ignores it.
> 
> Unfortunately we can't just add a flag because backwards compatibility with old OS would mean it was ignored.  Hence I think this needs to be a new type.
> 
> If we define a new node type rather than extend GI, we need to be careful around the same issue with _PXM that we had when introducing Generic Initiators (not sure the protections on that made it back to stable) so might need to modify DSDT _PXM responses based on appropriate _OSC.
> May well be fine but I'm not convinced yet.  Perhaps we need to say that using _PXM to place anything in a node defined only via this new means is not valid.
> 
> Jonathan
> 
> > 
> > # References
> > * Compute Express Link Specification v2.0, 
> > <https://www.computeexpresslink.org/>
> > 
> > # Detailed Description of the Change
> > 
> > * Replace "Generic Initiator" with "Generic Initiator / Target" in all 
> > locations except where an "initiator" or "target" is implied.
> > Specifically 5.2.27.3 "Memory Proximity Domain Attributes Structure"
> > need not replace occurrences of "generic initiator" in field: 
> > "Proximity Domain for Attached Initiator". Additionally field: 
> > "Proximity Domain for the Memory" must be renamed to "Proximity Domain 
> > for the Memory / Generic Target" with a new description "Integer that 
> > represents the memory / generic target proximity domain to which this memory belongs."
> > 
> > * Revise "5.2.16.6 Generic Initiator Affinity Structure" to make it
> >   consistent with being referenced as either a target or initiator.
> > 
> >         * Description: (replace all text)
> >   
> >         > The Generic Initiator / Target Affinity Structure provides the
> >         > association between a Generic Initiator and a Memory Proximity
> >         > Domain, or another Generic Target Proximity Domain. The
> >         > distinction as to whether this structure represents an
> >         > Initiator, a Target, or both depends on how it is referenced
> >         > in the HMAT. See Section 5.2.27.3 for details.    
> >   
> >         > Support of Generic Initiator / Target Affinity Structures by
> >         > OSPM is optional, and the platform may query whether the OS
> >         > supports it via the _OSC method. See Section 6.2.11.2.    
> > 
> >         * Architectural transactions: (append after current text)
> >   
> >         > If this proximity domain is referenced as a target then it
> >         > supports all the transaction types inferred above.    
> > 
> >         * Other updates are simple Initiator => Initiator / Target
> >           replacements.  
> 
> 

