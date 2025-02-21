Return-Path: <linux-acpi+bounces-11362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737FA3EB13
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 04:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D461162675
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B21D5CC2;
	Fri, 21 Feb 2025 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx+ZcxCj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972971C174A;
	Fri, 21 Feb 2025 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107388; cv=none; b=Rb56chU4xCyPDOfgWe1DeTlb2FHDvIib+73BCl3YiwPPj/pnGLLqd+utGiisN0sLzrhiZ1YctGBA3uacUQvBJVUC3cH47/1hUgbWrUuLxGoiYV8qYzaxieuASRK6E0ltz89WWQrtDxEryTv4u0UlH2LM355PR3U6OokpeBRYTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107388; c=relaxed/simple;
	bh=1+B/4VE/za/3YpuuyZLzlStYFYW3Xnl3VC44Uz/gpCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6phBV3F6Ntnjq2P5BadoWh/YkfLzOhvWQ0SKhmDbhvNi4RLwnVLuqyarJ0dV4aBrRkDtvYOZe5stSxHSzpp/JLOMgLDnuMWC3y/lx2HDeXStcMHuoRrkS+idaQtyBYau3jG0F5apovH3r0V2RnUYst6o4ny25zUw4OhYyCOwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx+ZcxCj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740107386; x=1771643386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+B/4VE/za/3YpuuyZLzlStYFYW3Xnl3VC44Uz/gpCE=;
  b=mx+ZcxCjOf0F9muyRHJcKUCl1xj2iyhHhhDsVhO8tuwwc8KA6sAPpmiu
   tXTt2HPi8Ci/YLkByTQqzQr+tudcX5CwhHqwHrqYTBl8U8XYrxQe9YyH0
   o1YeiCOdy0Qs0NyTsGqEQK6UcpI7TM29VRKmOh2NkmqcaCGuqiD7jxA4l
   haKVCPwVZHiVrH+7nNgtZKtxJxkZAlKfI0JQFXeNC1EuPGWb4dv2hULrU
   U4OrY2NhEgoMbuw0b0w+AwhLUGA9kz6H6Y4UkzVw02a6M0UPMuBQt4PuB
   l3RnVjpkqkYv7mpIXu5MFMWFjMmUb8K30kQc+PET8wBI+H8fXGEQbFuy0
   Q==;
X-CSE-ConnectionGUID: MHK4vYK0Ste4SumUY/A/Pw==
X-CSE-MsgGUID: P0mCguGGRGe1Xauv+OMd5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40928167"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40928167"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 19:09:46 -0800
X-CSE-ConnectionGUID: xMmV4tt5SPKJ5KlRLcqp3w==
X-CSE-MsgGUID: YgPCUFpKQbCw9vaS9Xaokw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116136774"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.117])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 19:09:44 -0800
Date: Thu, 20 Feb 2025 19:09:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v3 2/4] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <Z7fudpMdKOSef8TH@aschofie-mobl2.lan>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117173054.4147877-3-dave.jiang@intel.com>

On Fri, Jan 17, 2025 at 10:28:31AM -0700, Dave Jiang wrote:
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

This reads like we are inflating the region size by cache size, and then
changing region set up code to account for the inflation. So, I'm going
to question where we need to do that inflation.

When the new region param p->cache_size is calculated it is added directly
to the p->res and that leads to much of the other work in region.c

Could p->cache_size be used as an addend when needed, like:
- Add it to the insert_resource in construct_region().
- Add it to the sysfs show's for region resource start and resource size.

Then when we get to dpa to hpa address translation, the p->res start
doesn't need adjusting either. As it is now, it's the cache start
and I think it should be the cxl resource start.

The touchpoints may grow in the direction I'm suggesting that make
it a poorer choice than what is here now. Maybe its time for the
something like a cxl_resource and a non_cxl_resource that add together
to make the region_resource.

I haven't been following this patch set all along, just started looking
yesterday, so I'm prepared to be  way off base. Figure blurting it out
at this point is the faster path forward. 

More comments related below...


> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
snip

> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
snip

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b98b1ccffd1c..2d8699a86b24 100644
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
> +	 * If an extended linear cache region then the CXL range is assumed
> +	 * to be fronted by the DRAM range in current known implementation.
> +	 * This assumption will be made until a variant implementation exists.
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

if we don't change p->res directly, this isn't needed.

>  	return 0;
> @@ -1424,8 +1439,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||

similar

>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> @@ -1949,7 +1963,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> +	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
>  	    resource_size(p->res)) {

similar

>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
> @@ -3221,6 +3235,45 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> +					    struct resource *res)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
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
> +	if (size != cache_size) {
> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Move the start of the range to where the cache range starts. The
> +	 * implementation assumes that the cache range is in front of the
> +	 * CXL range. This is not dictated by the HMAT spec but is how the
> +	 * current known implementation is configured.
> +	 *
> +	 * The cache range is expected to be within the CFMWS. The adjusted
> +	 * res->start should not be less than cxlrd->res->start.

Check for 'cache range is expected to be within the CFMWS' ?


> +	 */
> +	res->start -= cache_size;
> +	p->cache_size = cache_size;
> +
> +	return 0;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3267,6 +3320,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	rc = cxl_extended_linear_cache_resize(cxlr, res);
> +	if (rc) {
> +		/*
> +		 * Failing to support extended linear cache region resize does not
> +		 * prevent the region from functioning. Only causes cxl list showing
> +		 * incorrect region size.

Also cxlr_hpa_cache_alias() lookups will fail for cxl events, so no
hpa_alias in trace events.

> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "Failed to support extended linear cache.\n");

Maybe more specifics of what is/isn't present.

> +	}
> +
>  	rc = insert_resource(cxlrd->res, res);

Cut off in this diff is the "p->res = res" assignment that follows,
which then makes all the previous changes regarding matching decoder
ranges necessary.


>  	if (rc) {
>  		/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
snip

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
snip

> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
snip


