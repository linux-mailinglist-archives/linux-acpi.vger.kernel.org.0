Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225824357F4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Oct 2021 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJUAys (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 20:54:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:34194 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUAyr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 20:54:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="315120390"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="315120390"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 17:52:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="444574922"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 17:52:32 -0700
Date:   Wed, 20 Oct 2021 18:00:23 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Message-ID: <20211021010023.GA457926@alison-desk>
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2653CF7BEF1DA0A97B029396BDBE9@SN6PR12MB2653.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 20, 2021 at 10:03:58PM +0000, Vikram Sethi wrote:
> Hi Alison, 
> 
> > -----Original Message-----
> > From: alison.schofield@intel.com <alison.schofield@intel.com>
> > Sent: Tuesday, October 19, 2021 12:09 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> > Vishal Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>;
> > Ben Widawsky <ben.widawsky@intel.com>; Dan Williams
> > <dan.j.williams@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>; linux-cxl@vger.kernel.org;
> > linux-acpi@vger.kernel.org
> > Subject: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS
> > not in SRAT
> > 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no requirement
> > that the SRAT be comprehensive for CXL memory another mechanism is
> > needed to assign NUMA nodes to CXL memory not identified in the SRAT.
> > 
> > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL Early
> > Discovery Table (CEDT) to find all CXL memory ranges.
> > Create a NUMA node for each CFMWS that is not already assigned to a
> > NUMA node. Add a memblk attaching its host physical address range to the
> > node.
> > 
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable hot-plug.
> > 
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> 
> Does this patch work for CXL type 2 memory which is not in SRAT? A type 2 driver 
> can find its HDM BASE physical address from its CXL registers and figure out 
> its NUMA node id by calling phys_to_target_node?

Yes. This adds the nodes for the case where the BIOS doesn't fully describe
everything in CFMWS in the SRAT. And, yes, that is how the NUMA node can be
discovered.

> Or is type 2 HDM currently being skipped altogether?

Not sure what you mean by 'being skipped altogether'? The BIOS may describe
(all or none or some) of CXL Memory in the SRAT. In the case where BIOS
describes it all, NUMA nodes will already exist, and no new nodes will be
added here.

Alison

> 
> Thanks
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > Changes in v3:
> > - Initial variable pxm (Ben)
> > 
> > Changes in v2:
> > - Use MAX_NUMNODES as max value when searching node_to_pxm_map()
> > (0-day)
> > - Add braces around single statement for loop (coding style)
> > - Rename acpi_parse_cfmws() to acpi_cxl_cfmws_init to be more like other
> >   functions in this file doing similar work.
> > - Comments: remove superflous and state importance of the init order,
> >   CFMWS after SRAT, (Ira, Dan)
> > - Add prototype for numa_add_memblk() (0-day)
> > 
> >  drivers/acpi/numa/srat.c | 70
> > ++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/acpi.c       |  8 +++--
> >  include/linux/acpi.h     |  1 +
> >  3 files changed, 76 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c index
> > b8795fc49097..daaaef58f1e6 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -300,6 +300,67 @@ acpi_numa_memory_affinity_init(struct
> > acpi_srat_mem_affinity *ma)  }  #endif /* defined(CONFIG_X86) || defined
> > (CONFIG_ARM64) */
> > 
> > +static int __init acpi_cxl_cfmws_init(struct acpi_table_header
> > +*acpi_cedt) {
> > +       struct acpi_cedt_cfmws *cfmws;
> > +       acpi_size len, cur = 0;
> > +       int i, node, pxm = 0;
> > +       void *cedt_subtable;
> > +       u64 start, end;
> > +
> > +       /* Find the max PXM defined in the SRAT */
> > +       for (i = 0; i < MAX_NUMNODES - 1; i++) {
> > +               if (node_to_pxm_map[i] > pxm)
> > +                       pxm = node_to_pxm_map[i];
> > +       }
> > +       /* Start assigning fake PXM values after the SRAT max PXM */
> > +       pxm++;
> > +
> > +       len = acpi_cedt->length - sizeof(*acpi_cedt);
> > +       cedt_subtable = acpi_cedt + 1;
> > +
> > +       while (cur < len) {
> > +               struct acpi_cedt_header *c = cedt_subtable + cur;
> > +
> > +               if (c->type != ACPI_CEDT_TYPE_CFMWS)
> > +                       goto next;
> > +
> > +               cfmws = cedt_subtable + cur;
> > +               if (cfmws->header.length < sizeof(*cfmws)) {
> > +                       pr_warn_once("CFMWS entry skipped:invalid length:%u\n",
> > +                                    cfmws->header.length);
> > +                       goto next;
> > +               }
> > +
> > +               start = cfmws->base_hpa;
> > +               end = cfmws->base_hpa + cfmws->window_size;
> > +
> > +               /*
> > +                * Skip if the SRAT already described
> > +                * the NUMA details for this HPA.
> > +                */
> > +               node = phys_to_target_node(start);
> > +               if (node != NUMA_NO_NODE)
> > +                       goto next;
> > +
> > +               node = acpi_map_pxm_to_node(pxm);
> > +               if (node == NUMA_NO_NODE) {
> > +                       pr_err("ACPI NUMA: Too many proximity domains.\n");
> > +                       return -EINVAL;
> > +               }
> > +
> > +               if (numa_add_memblk(node, start, end) < 0) {
> > +                       /* CXL driver must handle the NUMA_NO_NODE case */
> > +                       pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node
> > %d [mem %#llx-%#llx]\n",
> > +                               node, start, end);
> > +               }
> > +               pxm++;
> > +next:
> > +               cur += c->length;
> > +       }
> > +       return 0;
> > +}
> > +
> >  static int __init acpi_parse_slit(struct acpi_table_header *table)  {
> >         struct acpi_table_slit *slit = (struct acpi_table_slit *)table; @@ -478,6
> > +539,15 @@ int __init acpi_numa_init(void)
> >         /* SLIT: System Locality Information Table */
> >         acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
> > 
> > +       /*
> > +        * CEDT: CXL Fixed Memory Window Structures (CFMWS)
> > +        * must be parsed after the SRAT. It creates NUMA
> > +        * Nodes for CXL memory ranges not already defined
> > +        * in the SRAT and it assigns PXMs after the max PXM
> > +        * defined in the SRAT.
> > +        */
> > +       acpi_table_parse(ACPI_SIG_CEDT, acpi_cxl_cfmws_init);
> > +
> >         if (cnt < 0)
> >                 return cnt;
> >         else if (!parsed_numa_memblks)
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c index
> > 10120e4e0b9f..ccf73f0a59a7 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -122,9 +122,11 @@ static void cxl_add_cfmws_decoders(struct device
> > *dev,
> >                                 cfmws->base_hpa, cfmws->base_hpa +
> >                                 cfmws->window_size - 1);
> >                 } else {
> > -                       dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> > -                               dev_name(&cxld->dev), cfmws->base_hpa,
> > -                                cfmws->base_hpa + cfmws->window_size - 1);
> > +                       dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
> > +                               dev_name(&cxld->dev),
> > +                               phys_to_target_node(cxld->range.start),
> > +                               cfmws->base_hpa,
> > +                               cfmws->base_hpa + cfmws->window_size -
> > + 1);
> >                 }
> >                 cur += c->length;
> >         }
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> > 974d497a897d..f837fd715440 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -426,6 +426,7 @@ extern bool acpi_osi_is_win8(void);  #ifdef
> > CONFIG_ACPI_NUMA  int acpi_map_pxm_to_node(int pxm);  int
> > acpi_get_node(acpi_handle handle);
> > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > 
> >  /**
> >   * pxm_to_online_node - Map proximity ID to online node
> > 
> > base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> > prerequisite-patch-id: f09c67c6b3801f511521fd29c1cc01f5c5b1e9de
> > --
> > 2.31.1
> 
