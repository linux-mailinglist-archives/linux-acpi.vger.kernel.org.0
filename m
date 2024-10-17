Return-Path: <linux-acpi+bounces-8846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3D9A2875
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2312860D5
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731151DF250;
	Thu, 17 Oct 2024 16:21:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8B1DE2C9;
	Thu, 17 Oct 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182070; cv=none; b=Z++hI4vXQ6UfyZhHiNIsvIMgYun8Mmj5hT59rvhqkidYhCHwFK6mnx6ck5I+OLJ2HzwE5qPeFRewbdyxJmZT7noPkL03lHwQhBdC5gHfhQhunBtF6eGXM8O3SlRN5NRgmYoeDr92VFyTCxhj6pm0yBuFm5GQOpP4bO45MMpxl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182070; c=relaxed/simple;
	bh=DQDyBdQKRQoN1NmfbbGGxetstnSZ5DbCKL45YGn84tU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSr4zFFXFxRp+245jDMau5zUYCYexylr/S0nHQQwZr3TjP8RhTc7DcSJgPq9W/W85vRaC9Yl3ofcjEL6G8fYpWKhrQ8YWj8qP7PfqwdoXblXirn26dMAmxP7DY93x2TozIF+Qvv/C1UQfmoRAPNnL+qHnhi5Ix9pcvpO2RleajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTtM94xVRz6FGth;
	Fri, 18 Oct 2024 00:19:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4127E14011A;
	Fri, 18 Oct 2024 00:21:02 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:21:01 +0200
Date: Thu, 17 Oct 2024 17:20:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 3/6] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <20241017172059.000056e9@Huawei.com>
In-Reply-To: <20240927142108.1156362-4-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-4-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Sep 2024 07:16:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current cxl region size only indicates the size of the CXL memory region
> without accounting for the extended linear cache size. Retrieve the cache
> size from HMAT and append that to the cxl region size for the cxl region
> range that matches the SRAT range that has extended linear cache enabled.
> 
> The SRAT defines the whole memory range that inclues the extended linear

includes

> cache and the CXL memory region. The new HMAT update to the Memory Side

ECN/ECR, not update.  After all update might mean _HMA

> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory proxmity
> domain. Add a helper to match the cxl range to the SRAT memory range in order
> to retrieve the cache size.
> 
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Various comments inline.
> ---
>  drivers/acpi/numa/hmat.c  | 44 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/acpi.c   | 11 +++++++++
>  drivers/cxl/core/core.h   |  3 +++
>  drivers/cxl/core/region.c | 51 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  2 ++
>  include/linux/acpi.h      |  8 ++++++
>  tools/testing/cxl/Kbuild  |  1 +
>  8 files changed, 117 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 39524f36be5b..d299f8d7af8c 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -108,6 +108,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
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
> +	bool cache_found = false;
> +	struct resource *res;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -ENOENT;
> +
> +	list_for_each_entry(tcache, &target->caches, node) {
> +		if (tcache->cache_attrs.mode == NODE_CACHE_MODE_EXTENDED_LINEAR) {

Why is finding the first one appropriate?  Maybe you have more than one?
I'd move the code bellow up here then carry on to see if there is another
entry if resource_contains fails.


> +			cache_found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!cache_found) {
> +		*cache_size = 0;
> +		return 0;
> +	}
> +
> +	res = &target->memregions;
> +	if (!resource_contains(res, backing_res))
> +		return -ENOENT;
> +
> +	*cache_size = tcache->cache_attrs.size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
> +
>  static struct memory_target *acpi_find_genport_target(u32 uid)
>  {
>  	struct memory_target *target;

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..ddfb1e1a8909 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -816,6 +816,17 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static bool region_res_match_range(struct cxl_region_params *p,

This is a little odd. So comment on what it is doing needed.
I think it is patching the CXL backed bit of the region
by offsetting the start back to where it was before you
subtracted the dram cache size.

> +				   struct range *range)
> +{
> +	if (p->res &&
I'd break the
	if (!p->res)
		return false;
off then
	return p->res->start + p->cache_size == range->start &&
	       p->res->end == range->end;

> +	    p->res->start + p->cache_size == range->start &&
> +	    p->res->end == range->end)
> +		return true;
> +
> +	return false;
> +}
Reasonable to factor this out first.
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -828,7 +839,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +	if (region_res_match_range(p, r))
>  		return 1;
>  
>  	return 0;
> @@ -1406,8 +1417,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    !region_res_match_range(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> @@ -1931,7 +1941,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> +	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
>  	    resource_size(p->res)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
> @@ -3226,6 +3236,34 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int cxl_extended_linear_cache_resize(struct cxl_region_params *p,
> +					    struct resource *res)
> +{
> +	int nid = phys_to_target_node(res->start);
> +	resource_size_t size, cache_size;
> +	int rc;
> +
> +	size = resource_size(res);
> +	if (!size)
> +		return -EINVAL;
> +
> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (rc)
> +		return rc;
> +
> +	if (!cache_size)
> +		return 0;
> +
> +	if (size != cache_size)
> +		return -EINVAL;
> +
> +	res->start -= cache_size;

I don't recall the ECN saying which way round they were (and it didn't
occur to me at the time) i.e. local dram first or CXL dram first.
Did I miss that?  I was kind of thinking extra capacity at higher
addresses but no particularly reason why...

> +	p->cache_size = cache_size;
> +
> +	return 0;
> +}
> +
Trivial but 1 blank line probably appropriate.
> +
>  /* Establish an empty region covering the given HPA range */

