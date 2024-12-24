Return-Path: <linux-acpi+bounces-10290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40179FBD14
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4563718818B8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F11192D76;
	Tue, 24 Dec 2024 12:05:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D51ADFE3;
	Tue, 24 Dec 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041942; cv=none; b=MY2AIl4J7sol3giZwhU15BN/LGJwZGi2FRz9oLZriJg5UKNcYWXdGUo10S6mBz2iBElN2W33XS9tgkqKIoIY+cXInKeTRmgx9p+3kFXykgxTDA15526MN0qrBES5Tt2Tv63gaJmXFcWu1wXo8rUVdpZR2SPP1r1KQyFD4RMHkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041942; c=relaxed/simple;
	bh=V3n67r58pwosXRN28AM1JcBaMG5cuc69mF88WXz0Huc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SswVoKk9HNX1HU94erkcKL2npoU2oXtnHOD49x09DalnTaIKwGFqCwif0dYaTlMKC18Y7aga1LreN3xDCLt4PQ455ls7I4baf4E78XARqj5j9EsQCCT7Z6dk0FHSUqEVaFDBVkk/Y3d31henUUxZgvauQ2uBcGtwPea0Du2tL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHYVk1qfyz67DqF;
	Tue, 24 Dec 2024 20:05:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA0CF14038F;
	Tue, 24 Dec 2024 20:05:37 +0800 (CST)
Received: from localhost (10.126.171.172) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 13:05:37 +0100
Date: Tue, 24 Dec 2024 12:05:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
Message-ID: <20241224120535.000077e9@huawei.com>
In-Reply-To: <20241204224827.2097263-3-dave.jiang@intel.com>
References: <20241204224827.2097263-1-dave.jiang@intel.com>
	<20241204224827.2097263-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 4 Dec 2024 15:46:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current cxl region size only indicates the size of the CXL memory
> region without accounting for the extended linear cache size. Retrieve the
> cache size from HMAT and append that to the cxl region size for the cxl
> region range that matches the SRAT range that has extended linear cache
> enabled.
> 
> The SRAT defines the whole memory range that includes the extended linear
> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory
> proxmity domain. Add a helper to match the cxl range to the SRAT memory
> range in order to retrieve the cache size.
> 
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

A few minor comments inline given you are going around again for the issue
Li Ming spotted.

Jonathan

> ---
> RFC:
> - Minor refactors (Jonathan)
> - Fix grammar (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c  | 39 ++++++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/acpi.c   | 11 ++++++
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/region.c | 70 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  2 ++
>  include/linux/acpi.h      | 19 +++++++++++
>  tools/testing/cxl/Kbuild  |  1 +
>  8 files changed, 142 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 976b3e1a6c2a..1c5b3c37ac29 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -108,6 +108,45 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  	return NULL;
>  }
>  
> +/**
> + * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
> + * @backing_res: resource from the backing media
> + * @nid: node id for the memory region
> + * @cache_size: (Output) size of extended linear cache.
> + *
> + * Return: 0 on success. Errno on failure.
> + *
> + */
> +int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> +					resource_size_t *cache_size)
> +{
> +	unsigned int pxm = node_to_pxm(nid);
> +	struct memory_target *target;
> +	struct target_cache *tcache;
> +	struct resource *res;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -ENOENT;
> +
> +	list_for_each_entry(tcache, &target->caches, node) {
> +		if (tcache->cache_attrs.address_mode ==
> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR)
> +			continue;
> +
> +		res = &target->memregions;
> +		if (!resource_contains(res, backing_res))
> +			continue;
> +
> +		*cache_size = tcache->cache_attrs.size;
> +		return 0;
> +	}
> +
> +	*cache_size = 0;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);

Needs quotes around "CXL" now I think.

> +
>  static struct memory_target *acpi_find_genport_target(u32 uid)
>  {
>  	struct memory_target *target;
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..1a0c9c6ca818 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> +cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 70d0a017e99c..72ede9842dab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -824,6 +824,21 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 1;
>  }
>  
> +static bool region_res_match_cxl_range(struct cxl_region_params *p,
> +				       struct range *range)
> +{
> +	if (!p->res)
> +		return false;
> +
> +	/*
> +	 * The CXL range is assumed to be fronted by the DRAM range in
> +	 * current known implementation. This assumption will be made
> +	 * until a variant implementation exists.
Start with:
If an extended linear cache region then the CXL range is...

Otherwise the comment sounds more general that it is.

> +	 */
> +	return p->res->start + p->cache_size == range->start &&
> +		p->res->end == range->end;
> +}
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -836,7 +851,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +	if (region_res_match_cxl_range(p, r))
>  		return 1;
>  
>  	return 0;
> @@ -1413,8 +1428,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",

> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3256,6 +3306,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	rc = cxl_extended_linear_cache_resize(cxlr, res);
> +	if (rc) {
> +		/*
> +		 * Failing to support extended linear cache region resize does not
> +		 * prevent the region from functioning. Only cause cxl list showing

Only causes cxl list to show incorrect region size

> +		 * incorrect region size.
> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "Failed to support extended linear cache.\n");
> +	}
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..61df87a31e02 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -492,6 +492,7 @@ enum cxl_config_state {
>   * @res: allocated iomem capacity for this region
>   * @targets: active ordered targets in current decoder configuration
>   * @nr_targets: number of targets
> + * @cache_size: extended linear cache size, if exists

otherwise zero. (as you don't check for existence - or remove "if exists"
and just have "extended linear cache size"

>   *
>   * State transitions are protected by the cxl_region_rwsem
>   */
> @@ -503,6 +504,7 @@ struct cxl_region_params {
>  	struct resource *res;
>  	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
>  	int nr_targets;
> +	resource_size_t cache_size;
>  };
>  
>  /*


