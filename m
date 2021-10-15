Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8042F982
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbhJORBy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 13:01:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3991 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbhJORBy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2021 13:01:54 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWC8T35TLz67f5n;
        Sat, 16 Oct 2021 00:56:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:59:45 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:59:44 +0100
Date:   Fri, 15 Oct 2021 17:59:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in
 SRAT
Message-ID: <20211015175943.000070b8@Huawei.com>
In-Reply-To: <20211009015339.400383-1-alison.schofield@intel.com>
References: <20211009015339.400383-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 Oct 2021 18:53:39 -0700
<alison.schofield@intel.com> wrote:

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
Hi Alison,

I'm not sure that a CFMWS entry should map to a single NUMA node...

Each entry corresponds to a contiguous HPA range into which CXL devices
below a set of ports (if interleaved) or one port should be mapped.

That could be multiple devices, each with it's own performance characteristics,
or potentially a mix of persistent and volatile memory on a system with limited
qtg groups.

Maybe it's the best we can do though given information available
before any devices are present.

Jonathan

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

