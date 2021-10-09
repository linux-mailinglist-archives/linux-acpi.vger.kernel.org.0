Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED2427580
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbhJIByZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 21:54:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:15128 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhJIByZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Oct 2021 21:54:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="290119750"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="290119750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 18:52:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="489690829"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 18:52:28 -0700
Date:   Fri, 8 Oct 2021 19:00:45 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in
 SRAT
Message-ID: <20211009020045.GA400525@alison-desk>
References: <20211009015339.400383-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009015339.400383-1-alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 08, 2021 at 06:53:39PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> During NUMA init, CXL memory defined in the SRAT Memory Affinity
> subtable may be assigned to a NUMA node. Since there is no
> requirement that the SRAT be comprehensive for CXL memory another
> mechanism is needed to assign NUMA nodes to CXL memory not identified
> in the SRAT.
> 
> Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> NUMA node for each range that is not already assigned to a NUMA node.
> Add a memblk attaching its host physical address range to the node.
> 
> Note that these ranges may not actually map any memory at boot time.
> They may describe persistent capacity or may be present to enable
> hot-plug.
> 
> Consumers can use phys_to_target_node() to discover the NUMA node.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.c       |  8 +++---
>  2 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index b8795fc49097..568e033e6c3f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,61 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
> +/* Add a NUMA node and memblk for each node-less CFMWS */
> +static int __init acpi_parse_cfmws(struct acpi_table_header *acpi_cedt)
> +{
> +	struct acpi_cedt_cfmws *cfmws;
> +	acpi_size len, cur = 0;
> +	void *cedt_subtable;
> +	int i, pxm, node;
> +	u64 start, end;
> +
> +	/* Use fake PXM values starting after the max PXM found in the SRAT */
> +	for (i = 0; i < MAX_PXM_DOMAINS - 1; i++)

s/MAX_PXM_DOMAINS/MAX_NUMNODES
I'll fix that in a v2, but will await feedback before reving.

Alison

> +		if (node_to_pxm_map[i] > pxm)
> +			pxm = node_to_pxm_map[i];
> +	pxm++;
> +
> +	len = acpi_cedt->length - sizeof(*acpi_cedt);
> +	cedt_subtable = acpi_cedt + 1;
> +
> +	while (cur < len) {
> +		struct acpi_cedt_header *c = cedt_subtable + cur;
> +
> +		if (c->type != ACPI_CEDT_TYPE_CFMWS)
> +			goto next;
> +
> +		cfmws = cedt_subtable + cur;
> +		if (cfmws->header.length < sizeof(*cfmws)) {
> +			pr_warn_once("CFMWS entry skipped:invalid length:%u\n",
> +				     cfmws->header.length);
> +			goto next;
> +		}
> +
> +		start = cfmws->base_hpa;
> +		end = cfmws->base_hpa + cfmws->window_size;
> +
> +		/* Skip if the HPA is already assigned to a NUMA node */
> +		node = phys_to_target_node(start);
> +		if (node != NUMA_NO_NODE)
> +			goto next;
> +
> +		node = acpi_map_pxm_to_node(pxm);
> +		if (node == NUMA_NO_NODE) {
> +			pr_err("ACPI NUMA: Too many proximity domains.\n");
> +			return -EINVAL;
> +		}
> +		if (numa_add_memblk(node, start, end) < 0) {
> +			pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> +				node, start, end);
> +		}
> +		pxm++;
> +next:
> +		cur += c->length;
> +	}
> +	return 0;
> +}
> +
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
>  	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
> @@ -478,6 +533,9 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/* CEDT: CXL Early Discovery Table */
> +	acpi_table_parse(ACPI_SIG_CEDT, acpi_parse_cfmws);
> +
>  	if (cnt < 0)
>  		return cnt;
>  	else if (!parsed_numa_memblks)
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index dadc7f64b9ff..3798841c3418 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -144,9 +144,11 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>  				cfmws->window_size - 1);
>  			goto next;
>  		}
> -		dev_dbg(dev, "add: %s range %#llx-%#llx\n",
> -			dev_name(&cxld->dev), cfmws->base_hpa,
> -			cfmws->base_hpa + cfmws->window_size - 1);
> +		dev_dbg(dev, "add:%s node:%d range:%#llx-%#llx restrict:%#x\n",
> +			dev_name(&cxld->dev),
> +			phys_to_target_node(cxld->range.start),
> +			cxld->range.start, cxld->range.end,
> +			cfmws->restrictions);
>  next:
>  		cur += c->length;
>  	}
> -- 
> 2.31.1
> 
