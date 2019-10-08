Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E60CF7F6
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJHLR7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 07:17:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbfJHLR7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 07:17:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 440B2A04CF488C9331FE;
        Tue,  8 Oct 2019 19:17:56 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 19:17:47 +0800
Date:   Tue, 8 Oct 2019 12:17:29 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V5 3/4] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20191008121729.00005ee9@huawei.com>
In-Reply-To: <20191007145505.GB88143@gmail.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
        <20191004114330.104746-4-Jonathan.Cameron@huawei.com>
        <20191007145505.GB88143@gmail.com>
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

On Mon, 7 Oct 2019 16:55:05 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Done in a somewhat different fashion to arm64.
> > Here the infrastructure for memoryless domains was already
> > in place.  That infrastruture applies just as well to
> > domains that also don't have a CPU, hence it works for
> > Generic Initiator Domains.
> > 
> > In common with memoryless domains we only register GI domains
> > if the proximity node is not online. If a domain is already
> > a memory containing domain, or a memoryless domain there is
> > nothing to do just because it also contains a Generic Initiator.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  arch/x86/include/asm/numa.h |  2 ++
> >  arch/x86/kernel/setup.c     |  1 +
> >  arch/x86/mm/numa.c          | 14 ++++++++++++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> > index bbfde3d2662f..f631467272a3 100644
> > --- a/arch/x86/include/asm/numa.h
> > +++ b/arch/x86/include/asm/numa.h
> > @@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
> >  extern void __init init_cpu_to_node(void);
> >  extern void numa_add_cpu(int cpu);
> >  extern void numa_remove_cpu(int cpu);
> > +extern void init_gi_nodes(void);
> >  #else	/* CONFIG_NUMA */
> >  static inline void numa_set_node(int cpu, int node)	{ }
> >  static inline void numa_clear_node(int cpu)		{ }
> >  static inline void init_cpu_to_node(void)		{ }
> >  static inline void numa_add_cpu(int cpu)		{ }
> >  static inline void numa_remove_cpu(int cpu)		{ }
> > +static inline void init_gi_nodes(void)			{ }
> >  #endif	/* CONFIG_NUMA */
> >  
> >  #ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index cfb533d42371..b6c977907ea5 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1264,6 +1264,7 @@ void __init setup_arch(char **cmdline_p)
> >  	prefill_possible_map();
> >  
> >  	init_cpu_to_node();
> > +	init_gi_nodes();
> >  
> >  	io_apic_init_mappings();
> >  
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 4123100e0eaf..50bf724a425e 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -733,6 +733,20 @@ static void __init init_memory_less_node(int nid)
> >  	 */
> >  }
> >  
> > +/*
> > + * Generic Initiator Nodes may have neither CPU nor Memory.
> > + * At this stage if either of the others were present we would
> > + * already be online.
> > + */
> > +void __init init_gi_nodes(void)
> > +{
> > +	int nid;
> > +
> > +	for_each_node_state(nid, N_GENERIC_INITIATOR)
> > +		if (!node_online(nid))
> > +			init_memory_less_node(nid);
> > +}  
> 
> Nit: missing curly braces.

Good point.

> 
> How do these work in practice, will a system that only had nodes 0-1 
> today grow a third node '2' that won't have any CPUs on memory on them?

Yes. Exactly that.  The result is that fallback lists etc work when
_PXM is used to assign a device into that new node.  The interesting
bit comes when a driver does something more interesting and queries
the numa distances from SLIT.  At that point the driver can elect to
do load balancing across multiple nodes at similar distances.

In theory you can also specify a device you wish to put into the node
via the SRAT entry (IIRC using segment + BDF for PCI devices), but
for now I haven't implemented that method.

> 
> Thanks,
> 
> 	Ingo

Thanks,

Jonathan

