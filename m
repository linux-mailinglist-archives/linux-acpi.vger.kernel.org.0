Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3868142992C
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhJKVyo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 17:54:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:16923 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235423AbhJKVyn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 17:54:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="225750209"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="225750209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 14:52:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="490649743"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 14:52:42 -0700
Date:   Mon, 11 Oct 2021 15:00:53 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in
 SRAT
Message-ID: <20211011220053.GA412964@alison-desk>
References: <20211009015339.400383-1-alison.schofield@intel.com>
 <20211011171315.GL3114988@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011171315.GL3114988@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for the review Ira!

On Mon, Oct 11, 2021 at 10:13:16AM -0700, Ira Weiny wrote:
> On Fri, Oct 08, 2021 at 06:53:39PM -0700, Schofield, Alison wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> > 
> > Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> > NUMA node for each range that is not already assigned to a NUMA node.
> > Add a memblk attaching its host physical address range to the node.
> > 
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> > 
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/acpi/numa/srat.c | 58 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/acpi.c       |  8 +++---
> >  2 files changed, 63 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index b8795fc49097..568e033e6c3f 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -300,6 +300,61 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> >  }
> >  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
> >  
> > +/* Add a NUMA node and memblk for each node-less CFMWS */
> 
> IMO this comment does not make sense for a function called 'parse cfmws'.  I
> would just drop it.
> 

Agree. Dropping comment. 

You made me stare at this func name more, and it can be better.
I'll try this: acpi_cxl_cfmws_init()
to be more like the others in this file, doing similar work.

> > +static int __init acpi_parse_cfmws(struct acpi_table_header *acpi_cedt)
> > +{

snip


> > +		if (numa_add_memblk(node, start, end) < 0) {
> > +			pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > +				node, start, end);
> 
> Is there anything which could go wrong if the block is not added to the numa
> node?
> 
> Ira
> 

I intended, but failed, to mimic the adding of nodes & memblocks based
on the SRAT Memory Affinity table. There, a failure from numa_add_memblk()
causes the entire SRAT parsing to fail, and IIUC entire acpi_numa init fails.

FYI: numa_add_memblk() only completely fails (-EINVAL) if we've used up all
the NR_NODE_MEMBLKS (which is set to MAX_NUMNODE*2)

My first guess would be to follow the pattern and fail the entire
acpi_numa init. ie make acpi_numa = -1; I'll pursue that.

Now, back to your specific question: "Is there anything which could
go wrong if the block is not added to the numa node?"

numa_add_memblk(_to) can actually return success without adding a memblock.
Like this:
/* whine about and ignore invalid blks */
if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
        pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
                nid, start, end - 1);
        return 0;
}

So, I'm going to make an assumption that it can be handled, and see if
someone else chimes in here with more knowledge of why we can quietly
ignore.

Alison

>
>
snip
