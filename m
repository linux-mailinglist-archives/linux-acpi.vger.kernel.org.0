Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610E544058F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Oct 2021 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhJ2Wol (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 18:44:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:16865 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhJ2Wok (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 18:44:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="231030420"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="231030420"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:41:41 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448273530"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:41:41 -0700
Date:   Fri, 29 Oct 2021 15:49:14 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
Message-ID: <20211029224914.GA500689@alison-desk>
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <CAPcyv4hdC4Uj8YdePMZGFkxgP10VSkX1tiY+ApPctyjfURPSOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hdC4Uj8YdePMZGFkxgP10VSkX1tiY+ApPctyjfURPSOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 07:47:32PM -0700, Dan Williams wrote:
> On Mon, Oct 18, 2021 at 10:01 PM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> >
> > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > Create a NUMA node for each CFMWS that is not already assigned to
> > a NUMA node. Add a memblk attaching its host physical address
> > range to the node.
> >
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> >
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---

The next version of this patch is now included in this patchset that
adds helpers for parsing the CEDT subtables:
https://lore.kernel.org/linux-cxl/163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com/T/#mf40d84e1ad4c01f69f794d591b07774255993185

It addresses Dan's comments below.

>> snip

> > +{
> > +       struct acpi_cedt_cfmws *cfmws;
> > +       acpi_size len, cur = 0;
> > +       int i, node, pxm = 0;
> 
> Shouldn't this be -1, on the idea that the first numa node to assign
> if none are set is zero?
> 
> I don't think the way you have it is a problem in practice because
> SRAT should always be there in a NUMA system. However, the first CFMWS
> pxm should start after the last SRAT entry, or 0 if no SRAT entries.
> 
> > +       void *cedt_subtable;
> > +       u64 start, end;
> > +
> > +       /* Find the max PXM defined in the SRAT */
> > +       for (i = 0; i < MAX_NUMNODES - 1; i++) {
> 
> How about:
> 
>     for (i = 0, pxm = -1; i < MAX_NUMNODES -1; i++)
> 
> ...just to keep the initialization close to the use, but that's just a
> personal style preference.

Done.

> 
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
> 
> Similarly to above I wonder if this would be cleaner as a for loop
> then you could use typical "continue" statements rather than goto. I
> took a stab at creating a for_each_cedt() helper which ended up a
> decent cleanup for drivers/cxl/
> 
>  drivers/cxl/acpi.c |   48 +++++++++++++++---------------------------------
>  1 file changed, 15 insertions(+), 33 deletions(-)
> 
> ...however, I just realized this NUMA code is running at init time, so
> it can just use the acpi_table_parse_entries_array() helper to walk
> the CFMWS like the othe subtable walkers in acpi_numa_init(). You
> would need to update the subtable helpers (acpi_get_subtable_type() et
> al) to recognize the CEDT case.
> 
> [ Side note for the implications of acpi_table_parse_entries_array()
> for drivers/cxl/acpi.c ]
> 
> Rafael, both the NFIT driver and now the CXL ACPI driver have open
> coded subtable parsing. Any philosophical reason to keep the subtable
> parsing code as __init? It can still be __init and thrown away if
> those drivers are not build-time enabled.
> 

The updated patch (in the greater patchset) now uses the new helpers.


> snip
> > +               node = acpi_map_pxm_to_node(pxm);
> > +               if (node == NUMA_NO_NODE) {
> > +                       pr_err("ACPI NUMA: Too many proximity domains.\n");
> 
> I would add "while processing CFMWS" to make it clear that the BIOS
> technically did not declare too many PXMs; it was the Linux heuristic
> for opportunistically emulating more PXMs.
> 

Done.

> > snip
> >         }
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 974d497a897d..f837fd715440 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -426,6 +426,7 @@ extern bool acpi_osi_is_win8(void);
> >  #ifdef CONFIG_ACPI_NUMA
> >  int acpi_map_pxm_to_node(int pxm);
> >  int acpi_get_node(acpi_handle handle);
> > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> 
> This doesn't belong here.
> 
> There is already a declaration for this in
> arch/x86/include/asm/numa.h. I think what you are missing is that your
> new code needs to be within the same ifdef guards as the other helpers
> in srat.c that call numa_add_memblk(). See the line that has:
> 
> #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
> 
> ...above acpi_numa_slit_init()

Done.
