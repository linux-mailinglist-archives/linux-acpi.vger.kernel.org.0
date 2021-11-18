Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827C1455C63
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhKRNPY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:15:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4105 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKRNPY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:15:24 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw0ZK093yz685Z9;
        Thu, 18 Nov 2021 21:12:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 14:12:22 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 13:12:21 +0000
Date:   Thu, 18 Nov 2021 13:12:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <rafael.j.wysocki@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 6/6] ACPI: NUMA: Add a node and memblk for each CFMWS
 not in SRAT
Message-ID: <20211118131218.00005645@Huawei.com>
In-Reply-To: <163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163553711933.2509508.2203471175679990.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Fri, 29 Oct 2021 12:51:59 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> During NUMA init, CXL memory defined in the SRAT Memory Affinity
> subtable may be assigned to a NUMA node. Since there is no
> requirement that the SRAT be comprehensive for CXL memory another
> mechanism is needed to assign NUMA nodes to CXL memory not identified
> in the SRAT.
> 
> Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> Early Discovery Table (CEDT) to find all CXL memory ranges.
> Create a NUMA node for each CFMWS that is not already assigned to
> a NUMA node. Add a memblk attaching its host physical address
> range to the node.
> 
> Note that these ranges may not actually map any memory at boot time.
> They may describe persistent capacity or may be present to enable
> hot-plug.
> 
> Consumers can use phys_to_target_node() to discover the NUMA node.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi,

I was just discussing this with one of our firmware / ACPI experts and he asked
an interesting question.   If you want to have CFMWS regions correspond to
new NUMA nodes, why not put them in SRAT as hotpluggable memory, but have none
present in the memory map (whichever route you use to get that)?
We do this for normal memory hotplug as (via the other discussion on qemu virtio-mem
nodes) apparently does qemu. 

https://lore.kernel.org/all/655c65af-fd7a-8007-37b3-a56c60a0ec5b@redhat.com/

This doesn't solve the question of whether we have enough nodes, but it's
not worse than if we use CFMWS regions and fits within existing ACPI spec.

The only reason I can immediately think of to not do this, is that it might be
a pain to later change over to dynamic numa node allocation in a fashion that
then ignores SRAT entries.  Probably a solvable problem.

Jonathan


> ---
>  drivers/acpi/numa/srat.c |   59 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/acpi.c       |    3 ++
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index b8795fc49097..66a0142dc78c 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -298,6 +298,47 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  out_err:
>  	return -EINVAL;
>  }
> +
> +static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> +				   void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_cfmws *cfmws;
> +	int *fake_pxm = arg;
> +	u64 start, end;
> +	int node;
> +
> +	cfmws = (struct acpi_cedt_cfmws *)header;
> +	start = cfmws->base_hpa;
> +	end = cfmws->base_hpa + cfmws->window_size;
> +
> +	/* Skip if the SRAT already described the NUMA details for this HPA */
> +	node = phys_to_target_node(start);
> +	if (node != NUMA_NO_NODE)
> +		return 0;
> +
> +	node = acpi_map_pxm_to_node(*fake_pxm);
> +
> +	if (node == NUMA_NO_NODE) {
> +		pr_err("ACPI NUMA: Too many proximity domains while processing CFMWS.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (numa_add_memblk(node, start, end) < 0) {
> +		/* CXL driver must handle the NUMA_NO_NODE case */
> +		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> +			node, start, end);
> +	}
> +
> +	/* Set the next available fake_pxm value */
> +	(*fake_pxm)++;
> +	return 0;
> +}
> +#else
> +static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> +				   void *arg, const unsigned long table_end)
> +{
> +	return 0;
> +}
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
> @@ -442,7 +483,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
>  
>  int __init acpi_numa_init(void)
>  {
> -	int cnt = 0;
> +	int i, fake_pxm, cnt = 0;
>  
>  	if (acpi_disabled)
>  		return -EINVAL;
> @@ -478,6 +519,22 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/*
> +	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
> +	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
> +	 * are defined in the CFMWS and not already defined in the SRAT.
> +	 * Initialize a fake_pxm as the first available PXM to emulate.
> +	 */
> +
> +	/* fake_pxm is the next unused PXM value after SRAT parsing */
> +	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES - 1; i++) {
> +		if (node_to_pxm_map[i] > fake_pxm)
> +			fake_pxm = node_to_pxm_map[i];
> +	}
> +	fake_pxm++;
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> +			      &fake_pxm);
> +
>  	if (cnt < 0)
>  		return cnt;
>  	else if (!parsed_numa_memblks)
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 91e4072e7649..3163167ecc3a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -125,7 +125,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  			cfmws->base_hpa + cfmws->window_size - 1);
>  		return 0;
>  	}
> -	dev_dbg(dev, "add: %s range %#llx-%#llx\n", dev_name(&cxld->dev),
> +	dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
> +		dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
>  		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
>  
>  	return 0;
> 

