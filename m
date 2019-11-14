Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D422EFC53F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfKNL04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 06:26:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfKNL0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 06:26:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 44CA1140E50BECD4D86A;
        Thu, 14 Nov 2019 19:26:52 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 19:26:44 +0800
Date:   Thu, 14 Nov 2019 11:26:37 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Tao Xu <tao3.xu@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, "Keith Busch" <keith.busch@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
Message-ID: <20191114112504.00005b61@huawei.com>
In-Reply-To: <CAPcyv4g5xUBp871+T26+se8WH9154g7V81qsToYAbXAALMuhKQ@mail.gmail.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
        <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
        <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
        <20191113094742.00000dc4@huawei.com>
        <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
        <20191113174845.000009d3@huawei.com>
        <CAPcyv4g5xUBp871+T26+se8WH9154g7V81qsToYAbXAALMuhKQ@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 13 Nov 2019 15:20:01 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Nov 13, 2019 at 9:49 AM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Wed, 13 Nov 2019 21:57:24 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >  
> > > On 11/13/2019 5:47 PM, Jonathan Cameron wrote:  
> > > > On Tue, 12 Nov 2019 09:55:17 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  
> > > >> [ add Tao Xu ]
> > > >>
> > > >> On Fri, Oct 4, 2019 at 4:45 AM Jonathan Cameron
> > > >> <Jonathan.Cameron@huawei.com> wrote:  
> > > >>>
> > > >>> Generic Initiators are a new ACPI concept that allows for the
> > > >>> description of proximity domains that contain a device which
> > > >>> performs memory access (such as a network card) but neither
> > > >>> host CPU nor Memory.
> > > >>>
> > > >>> This patch has the parsing code and provides the infrastructure
> > > >>> for an architecture to associate these new domains with their
> > > >>> nearest memory processing node.  
> > > >>
> > > >> Thanks for this Jonathan. May I ask how this was tested? Tao has been
> > > >> working on qemu support for HMAT [1]. I have not checked if it already
> > > >> supports generic initiator entries, but it would be helpful to include
> > > >> an example of how the kernel sees these configurations in practice.
> > > >>
> > > >> [1]: http://patchwork.ozlabs.org/cover/1096737/  
> > > >
> > > > Tested against qemu with SRAT and SLIT table overrides from an
> > > > initrd to actually create the node and give it distances
> > > > (those all turn up correctly in the normal places).  DSDT override
> > > > used to move an emulated network card into the GI numa node.  That
> > > > currently requires the PCI patch referred to in the cover letter.
> > > > On arm64 tested both on qemu and real hardware (overrides on tables
> > > > even for real hardware as I can't persuade our BIOS team to implement
> > > > Generic Initiators until an OS is actually using them.)
> > > >
> > > > Main real requirement is memory allocations then occur from one of
> > > > the nodes at the minimal distance when you are do a devm_ allocation
> > > > from a device assigned. Also need to be able to query the distances
> > > > to allow load balancing etc.  All that works as expected.
> > > >
> > > > It only has a fairly tangential connection to HMAT in that HMAT
> > > > can provide information on GI nodes.  Given HMAT code is quite happy
> > > > with memoryless nodes anyway it should work.  QEMU doesn't currently
> > > > have support to create GI SRAT entries let alone HMAT using them.
> > > >
> > > > Whilst I could look at adding such support to QEMU, it's not
> > > > exactly high priority to emulate something we can test easily
> > > > by overriding the tables before the kernel reads them.
> > > >
> > > > I'll look at how hard it is to build an HMAT tables for my test
> > > > configs based on the ones I used to test your HMAT patches a while
> > > > back.  Should be easy if tedious.
> > > >
> > > > Jonathan
> > > >  
> > > Indeed, HMAT can support Generic Initiator, but as far as I know, QEMU
> > > only can emulate a node with cpu and memory, or memory-only. Even if we
> > > assign a node with cpu only, qemu will raise error. Considering
> > > compatibility, there are lots of work to do for QEMU if we change NUMA
> > > or SRAT table.
> > >  
> >
> > I faked up a quick HMAT table.
> >
> > Used a configuration with 3x CPU and memory nodes, 1x memory only node
> > and 1x GI node.  Two test cases, one where the GI initiator is further than
> > the CPU containing nodes from the memory only node (realistic case for
> > existing hardware). That behaves as expected and there are no
> > /sys/node/bus/nodeX/access0 entries for the GI node
> > + appropriate ones for the memory only node as normal.
> >
> > The other case is more interesting we have the memory only node nearer
> > to the GI node than to any of the CPUs.  In that case for x86 at least
> > the HMAT code is happy to put an access0 directory GI in the GI node
> > with empty access0/initiators and the memory node under access0/targets
> >
> > The memory only node is node4 and the GI node node3.
> >
> > So relevant dirs under /sys/bus/nodes/devices
> >
> > node3/access0/initators/ Empty
> > node3/access0/targets/node4  
> 
> This makes sense node3 is an initiator, no other nodes can initiate to it.
> 
> > node4/access0/initators/[node3 read_bandwidth write_bandwith etc]
> > node4/access0/targets/ Empty
> >
> > So the result current (I think - the HMAT interface still confuses
> > me :) is that a GI node is treated like a CPU node.  This might mean
> > there is no useful information available if you want to figure out
> > which CPU containing node is nearest to Memory when the GI node is
> > nearer still.
> >
> > Is this a problem?  I'm not sure...
> >
> > If we don't want to include GI nodes then we can possibly
> > use the node_state(N_CPU, x) method to check before considering
> > them, or I guess parse SRAT to extract that info directly.
> >
> > I tried this and it seems to work so can add patch doing this
> > next version if we think this is the 'right' thing to do.
> >
> > So what do you think 'should' happen?  
> 
> I think this might be our first case for adding an "access1" instance
> by default. I.e. in the case when access0 is not a cpu, then access1
> is there to at least show the "local" cpu and let userspace see the
> performance difference of cpu vs a specific-initiator access.


Hi Dan,

Agreed that it makes sense to expand how we describe these cases a bit.
To make sure I've understood correctly let me paraphrase what you
are proposing (and tweak it a bit ;)

Assuming for this purpose we don't put GIs in CPU nodes as that makes
for really fiddly explanation. In reality the code will need to handle
that.

1) Leave access0 as it currently is with this series - so continue to
   not distinguish between CPU nodes and Generic Initator containing ones?
2) Add access 1 which is effectively access0 ignoring Generic Initiators?

My feeling is that any existing users of access0 are definitely not going
to be expecting generic initiators, so we might want to do this the other
way around. access0 is only CPUs and memory, access1 is including
generic initiators.  If there are no GIs don't expose access1 at all?

For now we could simply block the GI visibility in access0 and deal
with access1 as a separate series.  I suspect we will get push back
as there are no known users of our new access1 so it may take a while
to prove utility and get it accepted.

Thanks,

Jonathan

