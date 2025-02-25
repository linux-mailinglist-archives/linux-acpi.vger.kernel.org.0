Return-Path: <linux-acpi+bounces-11471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58446A44BE9
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E2F19C6D3C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55519D071;
	Tue, 25 Feb 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKZWxbaO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943119B5A3;
	Tue, 25 Feb 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513647; cv=none; b=j7YG/LoF4F2triyfTPobt7bQzEzH2ZMIDUz41tCOTuL7h6jtiBP9OO1Aca5/69vlvtW867YoQaERvyapobqz+HwWTD3y4t7ZKAe2ueOjDD0n2SbwIuPrjMN1JYSfhiMmQ+6NUQvWJYqdL/nT2Uk81npI+XW7QG7qfiY60cWSOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513647; c=relaxed/simple;
	bh=QBdo7qVG+CWgP4+1WWNENaiFva/r2JtUBnLhUNznoP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5yLfYFrGj0n/UWafJ3Vmd61HYJjMtK2kKiOEDL5QMVouoOfz2K/FQ+23euDLyy7GfSBfxetQBiGHXtwS+jyIFI1HsgXQtFn50TDUjL1qFZn/K2T7m7eZ82uVttN1aRrCSxiSSGDp0sSi7IkTZv/XYE7izeM4VOSNqpJGpCCzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKZWxbaO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740513646; x=1772049646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QBdo7qVG+CWgP4+1WWNENaiFva/r2JtUBnLhUNznoP4=;
  b=JKZWxbaOxWmjQZWcAbrp245nVZNcmqreF0n8TE0mEPHGYSGay1a/abOh
   mlTS+2lOyKzl9SrdeUV6SSy7H9r0sKdbSnw0bQRH6soGAAHlLQTaTPMWc
   P2HKnvLT73H1Ahw2iwGEoRDYE7+q7KvsNoJnRJBNWAz2ZoFpD+bmCMfUp
   ANQRDc0eXqAu5zzA1bMD0RbmyoUuzoM/fyepQ+H/g/l1yAruf1JoqFEJW
   rtLr77W9nYkaVod3Yd4QH9VJpUNRXihKD0f6kMp+vknnLMakwC8iapbuW
   6rMzK9okDf+c918TSUKNEFKqE5dX9+zZlX3DG4W2eCo1uTQ81rTZF1KA8
   A==;
X-CSE-ConnectionGUID: DFzAB4e/TMO5dba9BxjKqA==
X-CSE-MsgGUID: +nZumI3HRYmkLnopX321Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52760245"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52760245"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:00:44 -0800
X-CSE-ConnectionGUID: rQp3OqC6RommgQIfU4r7fQ==
X-CSE-MsgGUID: qg7FR9bGRGOgZi6r6ZH8Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116981353"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.175])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:00:43 -0800
Date: Tue, 25 Feb 2025 12:00:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v4 2/4] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <Z74haZFA80TKeCUH@aschofie-mobl2.lan>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182202.1683380-3-dave.jiang@intel.com>

On Mon, Feb 24, 2025 at 11:21:00AM -0700, Dave Jiang wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Add adjustment for cxl_dpa_to_hpa() (Alison)
> - Add check of adjusted region start against CFMWS. (Alison)
> - Update dev_warn() to be more precise. (Alison)
> ---
>  drivers/acpi/numa/hmat.c  | 39 +++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/acpi.c   | 11 ++++++
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  2 +
>  include/linux/acpi.h      | 11 ++++++
>  tools/testing/cxl/Kbuild  |  1 +
>  8 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2630511937f5..9d9052258e92 100644
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

Remember this -ENOENT 

> +
> +	list_for_each_entry(tcache, &target->caches, node) {
> +		if (tcache->cache_attrs.address_mode !=
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

snip

> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> +					    struct resource *res)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int nid = phys_to_target_node(res->start);
> +	resource_size_t size, cache_size, start;
> +	int rc;
> +
> +	size = resource_size(res);
> +	if (!size)
> +		return -EINVAL;
> +
> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (rc)
> +		return rc;

Remember this - passing thru the -ENOENT


> +
> +	if (!cache_size)
> +		return 0;
> +
> +	if (size != cache_size) {
> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");

maybe emit the numbers, so in the next step we know what the mismatch was,
and how much cache goes unused.

> +		return -EOPNOTSUPP;

EOPNOTSUPP is only other possible rc


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
> +	 */
> +	start = res->start - cache_size;
> +	if (start < cxlrd->res->start)
> +		return -ENXIO;
> +
> +	res->start = start;
> +	p->cache_size = cache_size;
> +
> +	return 0;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3270,6 +3328,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "Extended linear cache calculation failed.\n");
> +	}
> +

Do you want to handle ENOENT same as EOPNOTSUPP?
Include rc in error message. 

I'm still confused about this message and the state behind it.

Is this saying the region functions but only at it's lesser cxl resource
size, or is it saying the region functions at its extended size?

Is there any 'thanks for the cache but we cannot use it' type
response to acpi. Wondering if it can be reclaimed.


snip

