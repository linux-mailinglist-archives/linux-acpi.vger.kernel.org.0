Return-Path: <linux-acpi+bounces-11477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F245DA44DD5
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4B165F08
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279218A6A8;
	Tue, 25 Feb 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnKSovsW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192E20C46B;
	Tue, 25 Feb 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515742; cv=none; b=CGdSKOrS6YSG48wZya6i3PLxITHxLeG64KXK37q75aHdCxOSUc97zH4DXBMML5p5EPAsr0u8gh/1/bwH2emw59jhuOBsQEuMHBSkYqltw50V8B3MuixOXJt97VBxXdNLuDe094sSqMW7pL18Nf+7NwzlAPAoXO9Bi0NlJ8K3VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515742; c=relaxed/simple;
	bh=2E1PhlxnKJqJ5tITsq3SqYNLWLrm1dHU9bVkcFq7VwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4trwdqeYu9tF2Gfr4dBFkLh+TbbeA9ZDdsbF/DROenfItKscfdkP7YokMdTaR3EBTV+jkqHKnMp5HO7iowwH1XfA2oXWc5O+aKVc4sS0Sv7OYPDJv0qGerU/zluuaux2Qn5hBSJ8wz2I1O6ZdgvB03rWSy8eB9RC+JgHUhVdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnKSovsW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740515741; x=1772051741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2E1PhlxnKJqJ5tITsq3SqYNLWLrm1dHU9bVkcFq7VwI=;
  b=dnKSovsWxodAgEfvV500xhS2BAxrk1Rh/KJdHb6JqY1LPBSx/MBMimgW
   lZ5vBUpw9n5Eix9LL3hN/WBYDYBrWgz/KpECLnOc1NoqDeQsUM7CI2di4
   2YjUTxN6/1sLzU8k6+9mbP3LfeerqkvkTUf/N704wo02BaYkVuAGZvbBp
   ln8XNWLY1zAe34byg51NbhbqUwbCJXY9Eg+E9/CLk7FSvOx+3MJKmBXyQ
   wVHeb5AP+co8TjyxOFzz5W9vuHvk1dU7seTVJhVOCIF5KhbNHBvuYp2F5
   4tlNteCv4smUkkc1GoE30W7X8J/saWvh34JKSxBk6HGvunn3hrS2uON6Z
   w==;
X-CSE-ConnectionGUID: ChQWCkdySXCjrIo1sDmIZA==
X-CSE-MsgGUID: HAHt1OEaRA+CVI/KbBEFtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28934297"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="28934297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:35:40 -0800
X-CSE-ConnectionGUID: eLS6B6hFRzGtfA09e63G+g==
X-CSE-MsgGUID: SO7UbDaITFCxhipfKmVEUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116512009"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.168]) ([10.125.111.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:35:39 -0800
Message-ID: <987b39f0-fc61-44eb-8ac7-6a3d11b6c497@intel.com>
Date: Tue, 25 Feb 2025 13:35:36 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
 ming.li@zohomail.com
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-3-dave.jiang@intel.com>
 <Z74haZFA80TKeCUH@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z74haZFA80TKeCUH@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/25 1:00 PM, Alison Schofield wrote:
> On Mon, Feb 24, 2025 at 11:21:00AM -0700, Dave Jiang wrote:
>> The current cxl region size only indicates the size of the CXL memory
>> region without accounting for the extended linear cache size. Retrieve the
>> cache size from HMAT and append that to the cxl region size for the cxl
>> region range that matches the SRAT range that has extended linear cache
>> enabled.
>>
>> The SRAT defines the whole memory range that includes the extended linear
>> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
>> Cache Information Structure defines the size of the extended linear cache
>> size and matches to the SRAT Memory Affinity Structure by the memory
>> proxmity domain. Add a helper to match the cxl range to the SRAT memory
>> range in order to retrieve the cache size.
>>
>> There are several places that checks the cxl region range against the
>> decoder range. Use new helper to check between the two ranges and address
>> the new cache size.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Add adjustment for cxl_dpa_to_hpa() (Alison)
>> - Add check of adjusted region start against CFMWS. (Alison)
>> - Update dev_warn() to be more precise. (Alison)
>> ---
>>  drivers/acpi/numa/hmat.c  | 39 +++++++++++++++++++
>>  drivers/cxl/core/Makefile |  1 +
>>  drivers/cxl/core/acpi.c   | 11 ++++++
>>  drivers/cxl/core/core.h   |  3 ++
>>  drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/cxl.h         |  2 +
>>  include/linux/acpi.h      | 11 ++++++
>>  tools/testing/cxl/Kbuild  |  1 +
>>  8 files changed, 143 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 2630511937f5..9d9052258e92 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -108,6 +108,45 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>>  	return NULL;
>>  }
>>  
>> +/**
>> + * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
>> + * @backing_res: resource from the backing media
>> + * @nid: node id for the memory region
>> + * @cache_size: (Output) size of extended linear cache.
>> + *
>> + * Return: 0 on success. Errno on failure.
>> + *
>> + */
>> +int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>> +					resource_size_t *cache_size)
>> +{
>> +	unsigned int pxm = node_to_pxm(nid);
>> +	struct memory_target *target;
>> +	struct target_cache *tcache;
>> +	struct resource *res;
>> +
>> +	target = find_mem_target(pxm);
>> +	if (!target)
>> +		return -ENOENT;
> 
> Remember this -ENOENT 
> 
>> +
>> +	list_for_each_entry(tcache, &target->caches, node) {
>> +		if (tcache->cache_attrs.address_mode !=
>> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR)
>> +			continue;
>> +
>> +		res = &target->memregions;
>> +		if (!resource_contains(res, backing_res))
>> +			continue;
>> +
>> +		*cache_size = tcache->cache_attrs.size;
>> +		return 0;
>> +	}
>> +
>> +	*cache_size = 0;
>> +	return 0;
>> +}
> 
> snip
> 
>> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>> +					    struct resource *res)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	int nid = phys_to_target_node(res->start);
>> +	resource_size_t size, cache_size, start;
>> +	int rc;
>> +
>> +	size = resource_size(res);
>> +	if (!size)
>> +		return -EINVAL;
>> +
>> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>> +	if (rc)
>> +		return rc;
> 
> Remember this - passing thru the -ENOENT
> 
> 
>> +
>> +	if (!cache_size)
>> +		return 0;
>> +
>> +	if (size != cache_size) {
>> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
> 
> maybe emit the numbers, so in the next step we know what the mismatch was,
> and how much cache goes unused.
> 
>> +		return -EOPNOTSUPP;
> 
> EOPNOTSUPP is only other possible rc
> 
> 
>> +	}
>> +
>> +	/*
>> +	 * Move the start of the range to where the cache range starts. The
>> +	 * implementation assumes that the cache range is in front of the
>> +	 * CXL range. This is not dictated by the HMAT spec but is how the
>> +	 * current known implementation is configured.
>> +	 *
>> +	 * The cache range is expected to be within the CFMWS. The adjusted
>> +	 * res->start should not be less than cxlrd->res->start.
>> +	 */
>> +	start = res->start - cache_size;
>> +	if (start < cxlrd->res->start)
>> +		return -ENXIO;
>> +
>> +	res->start = start;
>> +	p->cache_size = cache_size;
>> +
>> +	return 0;
>> +}
>> +
>>  /* Establish an empty region covering the given HPA range */
>>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  					   struct cxl_endpoint_decoder *cxled)
>> @@ -3270,6 +3328,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> +
>> +	rc = cxl_extended_linear_cache_resize(cxlr, res);
>> +	if (rc) {
>> +		/*
>> +		 * Failing to support extended linear cache region resize does not
>> +		 * prevent the region from functioning. Only causes cxl list showing
>> +		 * incorrect region size.
>> +		 */
>> +		dev_warn(cxlmd->dev.parent,
>> +			 "Extended linear cache calculation failed.\n");
>> +	}
>> +
> 
> Do you want to handle ENOENT same as EOPNOTSUPP?
> Include rc in error message. 

I think it's ok to consider all errnos as no support for extended cache. All memory are usable as intended. You just won't get the correct region size in 'cxl list' or get MCE notification for the aliased address. So there is no loss of resources. Mainly you just lose full RAS support. 

> 
> I'm still confused about this message and the state behind it.
> 
> Is this saying the region functions but only at it's lesser cxl resource
> size, or is it saying the region functions at its extended size?
> 
> Is there any 'thanks for the cache but we cannot use it' type
> response to acpi. Wondering if it can be reclaimed.
> 
> 
> snip


