Return-Path: <linux-acpi+bounces-9907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15889E2F87
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 00:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8A2164A73
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721D1EF096;
	Tue,  3 Dec 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULLyg7me"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA928460;
	Tue,  3 Dec 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267332; cv=none; b=mATviOIdyFgokgp7PsPlpg0yubT92ZmyBeMiiYONCv2P1nPVj7aQgH/UExwJGTNsW7d1PReLns856o/lnn9PqvHDdcboyKRujupZf+0sbq3OiiLN9PHz8s7C4v1bv1ES2+ik1JC//RODj4+rmJrWwFzr4m/jXtphGqsaZQM8rlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267332; c=relaxed/simple;
	bh=rkEp1O41NocrRkA4h9ZAwh5CCEMQ39biIWMtOUQkeSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLSrWUtRxKspTJaJDLuL3DTxFK6Y901NXr020sqdsf8wnC4sNHrCfkqR5ZsIauYgIEbf8pg7+UyvZQhLFn8Ayj774jA+Ne4+349hbn7aEkompAECJ+g0LYQh4l2/vz63XPsF8aQBlYosn8HP2eMdBHX5q4TfYLo2ewSlP+tATyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULLyg7me; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733267331; x=1764803331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rkEp1O41NocrRkA4h9ZAwh5CCEMQ39biIWMtOUQkeSU=;
  b=ULLyg7meGhb3/C8jKPzx+6rxa0L+TWYj/hPTAmAc2LXm0sPVlomCXCHt
   y/8przoRYLiSQUGpS4XMRaUZEBe0dBtXHCzGxUQoeWm5WSvA/Eo1MCR1F
   ar+NGr8aLGNaz0bI0n8mWlrVDli1rzgiHUXD22EachV3xmcsKuwYr4d2Z
   0gB3M8rnmG73aMEA2PspLVsarWdBMHbjXUc5G92YlpeiSR7KdGnJmg3lZ
   mC9uRGTdJuVZl9WNAJtEhsmbpluTxafRtbLS3j1NgLJnrO61N5qa6VBXg
   WSXeFw2BKABFJGOlRhSFvxaLWLpYD2J8iexDRaF9iVh2PQNlcSbrBf9ia
   A==;
X-CSE-ConnectionGUID: PvD/9QI5RNehTiNpkKIT/Q==
X-CSE-MsgGUID: X0upzJVwRRCaj1oH+xt5FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44893517"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44893517"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:08:50 -0800
X-CSE-ConnectionGUID: u6eN/TqeSuyW+5LeSvCW8w==
X-CSE-MsgGUID: wa36mqrvSiSq6WFtyviRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93471388"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.238]) ([10.125.111.238])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:08:49 -0800
Message-ID: <8d591c40-7954-441a-886d-8621fac16094@intel.com>
Date: Tue, 3 Dec 2024 16:08:48 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/5] acpi/hmat / cxl: Add extended linear cache
 support for CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20241112221335.432583-1-dave.jiang@intel.com>
 <20241112221335.432583-3-dave.jiang@intel.com>
 <20241126162301.0000090c@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241126162301.0000090c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/24 9:23 AM, Jonathan Cameron wrote:
> On Tue, 12 Nov 2024 15:12:34 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
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
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave,
> 
> A few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/acpi/numa/hmat.c  | 44 ++++++++++++++++++++++++
>>  drivers/cxl/core/Makefile |  1 +
>>  drivers/cxl/core/acpi.c   | 11 ++++++
>>  drivers/cxl/core/core.h   |  3 ++
>>  drivers/cxl/core/region.c | 70 ++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/cxl.h         |  2 ++
>>  include/linux/acpi.h      | 19 +++++++++++
>>  tools/testing/cxl/Kbuild  |  1 +
>>  8 files changed, 147 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 39524f36be5b..92b818b72ecc 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -108,6 +108,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
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
>> +	bool cache_found = false;
>> +	struct resource *res;
>> +
>> +	target = find_mem_target(pxm);
>> +	if (!target)
>> +		return -ENOENT;
>> +
>> +	list_for_each_entry(tcache, &target->caches, node) {
>> +		if (tcache->cache_attrs.mode == NODE_CACHE_MODE_EXTENDED_LINEAR) {
> 
> I'd flip this for slightly better readability.

ok

> 		if (tcache->cache_attrs.mode != NODE_CACHE_MODE_EXTENDED_LINEAR)
> 			continue;
> 
> 		res = ...
> 
> 
>> +			res = &target->memregions;
>> +			if (!resource_contains(res, backing_res))
>> +				continue;
>> +
>> +			cache_found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!cache_found) {
>> +		*cache_size = 0;
>> +		return 0;
>> +	}
>> +
>> +	*cache_size = tcache->cache_attrs.size;
> 
> Why not set this and return in the loop?
> That way no need to have a local variable.

ok

> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
> 
>> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
>> new file mode 100644
>> index 000000000000..f13b4dae6ac5
>> --- /dev/null
>> +++ b/drivers/cxl/core/acpi.c
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> +#include <linux/acpi.h>
>> +#include "cxl.h"
>> +#include "core.h"
> 
> Why do you need the cxl headers?  Maybe a forwards def of
> struct resource, but I'm not seeing anything else being needed.

The prototype is declared in core.h, and it seems core.h needs cxl.h. I wonder if core.h should just include cxl.h.
> 
> 
>> +
>> +int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>> +					    int nid, resource_size_t *size)
>> +{
>> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>> +}
> 
> 
>> @@ -3215,6 +3229,42 @@ static int match_region_by_range(struct device *dev, void *data)
>>  	return rc;
>>  }
>>  
>> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>> +					    struct resource *res)
>> +{
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	int nid = phys_to_target_node(res->start);
>> +	resource_size_t size, cache_size;
>> +	int rc;
>> +
>> +	size = resource_size(res);
>> +	if (!size)
>> +		return -EINVAL;
>> +
>> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!cache_size)
>> +		return 0;
>> +
>> +	if (size != cache_size) {
>> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	/*
>> +	 * Move the start of the range to where the cache range starts. The
>> +	 * implementation assumes that the cache range is in front of the
>> +	 * CXL range. This is not dictated by the HMAT spec but is how the
>> +	 * currently known implementation configured.
> 
> is configured

will fix

> 
>> +	 */
>> +	res->start -= cache_size;
>> +	p->cache_size = cache_size;
>> +
>> +	return 0;
>> +}
> 
> 


