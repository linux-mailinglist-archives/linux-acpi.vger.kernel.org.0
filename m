Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCBE4561D7
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhKRR4s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 12:56:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4107 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhKRR4s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 12:56:48 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw6q04Khrz67n9B;
        Fri, 19 Nov 2021 01:53:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 18:53:46 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 17:53:45 +0000
Date:   Thu, 18 Nov 2021 17:53:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 6/6] ACPI: NUMA: Add a node and memblk for each CFMWS
 not in SRAT
Message-ID: <20211118175343.00006526@Huawei.com>
In-Reply-To: <CAPcyv4j9fpKVjJ3as0jVLEDouUF1ai0iOknuGSx_r9B6E2KGzw@mail.gmail.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20211118131218.00005645@Huawei.com>
        <CAPcyv4j9fpKVjJ3as0jVLEDouUF1ai0iOknuGSx_r9B6E2KGzw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 18 Nov 2021 09:14:07 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Nov 18, 2021 at 5:12 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 29 Oct 2021 12:51:59 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > subtable may be assigned to a NUMA node. Since there is no
> > > requirement that the SRAT be comprehensive for CXL memory another
> > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > in the SRAT.
> > >
> > > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > > Create a NUMA node for each CFMWS that is not already assigned to
> > > a NUMA node. Add a memblk attaching its host physical address
> > > range to the node.
> > >
> > > Note that these ranges may not actually map any memory at boot time.
> > > They may describe persistent capacity or may be present to enable
> > > hot-plug.
> > >
> > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > Hi,
> >
> > I was just discussing this with one of our firmware / ACPI experts and he asked
> > an interesting question.   If you want to have CFMWS regions correspond to
> > new NUMA nodes, why not put them in SRAT as hotpluggable memory, but have none
> > present in the memory map (whichever route you use to get that)?
> > We do this for normal memory hotplug as (via the other discussion on qemu virtio-mem
> > nodes) apparently does qemu.
> >
> > https://lore.kernel.org/all/655c65af-fd7a-8007-37b3-a56c60a0ec5b@redhat.com/
> >
> > This doesn't solve the question of whether we have enough nodes, but it's
> > not worse than if we use CFMWS regions and fits within existing ACPI spec.
> >
> > The only reason I can immediately think of to not do this, is that it might be
> > a pain to later change over to dynamic numa node allocation in a fashion that
> > then ignores SRAT entries.  Probably a solvable problem.  
> 
> Interesting, yes, that works for expanding the NUMA node number space.
> However, if you populate SRAT what do you put in the corresponding
> HMAT entries? In the case of dynamic CXL regions the driver is going
> to generate the equivalent of the corresponding HMAT data based on
> what devices it decides to place in that range. I actually do not know
> what happens with HMAT today for memory hotplug, but I suspect there
> are less degrees of freedom of what might populate those ranges than
> what CXL allows, and there is a chance to pre-populate the HMAT for
> future hotplug.

So... There are two answers to that question as I understand it.

1) What Linux does is nothing.  You get whatever was in HMAT to start with.
   Worth noting that HMAT doesn't need to be in any sense 'complete' so it
   is possible there was nothing there with a target in this NUMA node.

2) What ACPI intends to happen if anyone implements it.  There is an event
notification for this..

"Heterogeneous Memory Attributes Update. Dynamic reconfiguration of
the system may cause existing latency, bandwidth or memory side caching
attribute to change. The platform software issues the Heterogeneous
Memory Attributes Update notification to a point on a device tree to
indicate to OSPM that it needs to invoke the _HMA objects associated
with the Heterogeneous Memory Attributes on the device tree starting
from the point notified."

So call an AML method in DSDT for which ever device has a notification event.
A similar dance is actually implemented for NFIT updates and Linux
actually implements that handling for that one.

> 
> All that said, if an ACPI platform did do that population it would not
> collide with the scheme proposed in this patch because this is
> checking SRAT for the range before padding the proximity domain number
> space for CFMWS entries.

Good point and that probably answers our concern.

Jonathan


