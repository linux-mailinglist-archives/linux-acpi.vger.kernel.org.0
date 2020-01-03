Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC112F69A
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 11:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgACKJY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 3 Jan 2020 05:09:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACKJY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 05:09:24 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6369F35EAC12E5808DA;
        Fri,  3 Jan 2020 10:09:22 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Jan 2020 10:09:22 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 10:09:21 +0000
Date:   Fri, 3 Jan 2020 10:09:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brice Goglin <brice.goglin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <kbusch@kernel.org>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V6 0/7] ACPI: Support Generic Initiator proximity
 domains
Message-ID: <20200103100920.00006a18@Huawei.com>
In-Reply-To: <b428d231-4879-4462-ac42-900b5d094eee@gmail.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
        <dc5f5502-09c6-d476-db0e-0af3412bb031@gmail.com>
        <20191218145041.00005a11@Huawei.com>
        <1867024e-b0c4-c291-7190-262cc4b297a8@gmail.com>
        <20200102152604.000039f1@Huawei.com>
        <b428d231-4879-4462-ac42-900b5d094eee@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2 Jan 2020 22:37:04 +0100
Brice Goglin <brice.goglin@gmail.com> wrote:

> Le 02/01/2020 à 16:27, Jonathan Cameron a écrit :
> >  
> >> However the HMAT table gets ignored because find_mem_target() fails in
> >> hmat_parse_proximity_domain(). The target should have been allocated in
> >> alloc_memory_target() which is called in srat_parse_mem_affinity(), but
> >> it seems to me that this function isn't called for GI nodes. Or should
> >> SRAT also contain a normal Memory node with same PM as the GI?
> >>  
> > Hi Brice,
> >
> > Yes you should see a node with 0kB memory.  Same as you get for a processor
> > only node I believe.
> >
> > srat_parse_mem_affinity shouldn't call alloc_memory_target for the GI nodes
> > as they don't have any memory.   The hmat table should only refer to
> > GI domains as initiators.  Just to check, do you have them listed as
> > a target node?  Or perhaps in some hmat proximity entry as memory_PD?
> >  
> 
> Thanks, I finally got things to work. I am on x86. It's a dual-socket
> machine with SubNUMA clusters (2 nodes per socket) and NVDIMMs (one
> dax-kmem node per socket). Before adding a GI, initiators look like this:
> 
> node0 -> node0 and node4
> 
> node1 -> node1 and node5
> 
> node2 -> node2 and node4
> 
> node3 -> node3 and node5
> 
> I added a GI with faster access to node0, node2, node4 (first socket).
> 
> The GI node becomes an access0 initiator for node4, and node0 and node2
> remain access1 initiators.
> 
> The GI node doesn't become access0 initiator for node0 and node2, likely
> because of this test :
> 
>         /*
>          * If the Address Range Structure provides a local processor pxm, link
>          * only that one. Otherwise, find the best performance attributes and
>          * register all initiators that match.
>          */
>         if (target->processor_pxm != PXM_INVAL) {
> 
> I guess I should split node0-3 into separate CPU nodes and memory nodes
> in SRAT?

It sounds like it's working as expected.  There are a few assumptions made about
'sensible' hmat configurations.

1) If the memory and processor are in the same domain, that should mean the
access characteristics within that domain are the best in the system.
It is possible to have a setup with very low latency access
from a particular processor but also low bandwidth.  Another domain may have
high bandwidth but long latency.   Such systems may occur, but they are probably
going to not be for 'normal memory the OS can just use'.

2) If we have a relevant "Memory Proximity Domain Attributes Structure"
Note this was renamed in acpi 6.3 from "Address Range Structure" as
it no longer has any address ranges.
(which are entirely optional btw) that indicates that the memory controller
for a given memory lies in the proximity domain of the Initiator specified.
If that happens we ignore cases where hmat says somewhere else is nearer
via bandwidth and latency.

For case 1) I'm not sure we actually enforce it.
I think you've hit case 2).  

Removing the address range structures should work, or as you say you can
move that memory into separate memory nodes.  It will be a bit of a strange
setup though.  Assuming node4 is an NVDIMM then that would be closer to a
potential real system.  With a suitable coherent bus (CCIX is most familiar
to me and can do this) You might have

 _______       ________    _______
|       |     |        |   |       |
| Node0 |     | Node4  |---| Node6 |
| CPU   |-----| Mem +  |---| GI    |
| Mem   |     | CCHome |---|       |
|_______|     |________|   |_______|
   |                          |
   |__________________________|

CCHome Cache Coherency directory location to avoid the need for more
esoteric cache coherency short cut methods etc.

Idea being the GI node is some big fat DB accelerator or similar doing
offloaded queries.  It has a fat pipe to the NVDIMMs.  

Lets ignore that, to actually justify the use of a GI only node,
you need some more elements as this situation could be represented
by fusing node4 and node6 and having asymmetric HMAT between Node0
and the fused Node4.

So in conclusion, with your setup, only the NVDIMM nodes look like the
sort of memory that might be in a node nearer to a GI than the host.
> 
> Brice

Thanks again for looking at this!

Jonathan
> 
> 
> 
> 


