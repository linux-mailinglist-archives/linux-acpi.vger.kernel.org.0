Return-Path: <linux-acpi+bounces-10020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5669E9B87
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D41886531
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D835954;
	Mon,  9 Dec 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaamEh0u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B1142900;
	Mon,  9 Dec 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761484; cv=none; b=AypuFBCRsi3r4eh8txR9RvlJESD5FTaQnBwDtmFim5GU1q4q9Lq/LuHWDpzMa+8c0QUrCtXgbs2TMweYtkuOTXhgakHWgmreeQC78nyPz7GTW0C3CV9mMhCk2ICSCbRKlPeTPBp2U6ryJSY2tqwKlHH9Rx885YKlkojFXFx/0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761484; c=relaxed/simple;
	bh=rgn6j/NKYUAyB26u9BoV+hmK429fwJ4jKkrWFcP2PAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkHKAf+8/3qHfNo5pmsvARo9fv25IcYj1YadH/Fyc+XG6OpRqxzU8lroYKisHocqsHnQps2sDVJ9S5tqvcVVkOoaAKp8D6U2JjMhoNkMQGc/pZkd+L3tSzFN0c+wpZl4n3DJ9rpjj40nFNfkgUvbV2GOxgxHNu2craXztfuwZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaamEh0u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733761482; x=1765297482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rgn6j/NKYUAyB26u9BoV+hmK429fwJ4jKkrWFcP2PAQ=;
  b=PaamEh0uTRmqNPc/8MxcfoKcZ8/fAgl0dsMpTM4IZ29B54202I5nyFs6
   77B8BS2CJNaU59U0jKLolJNrI3ylYvd4Yv6oAAZvF6co/HVBQZ3+OTHsd
   YPxGMDqXbRsJAQkzGiCc3vFxRmhtCsPI2+StuaYOxuMF0L5qLQYQAcGrT
   SMaDrYvFe76e4Xrt9S1cQK+tCp7utuOsCKO/JLH5j2nHkUgmNK8Mbun84
   jzDgwvQa54Ge93sIy6kL7t1oslopwTZSY/3Yxg76IGGhSy8LV57L0fyVN
   I4AjDoxw2b7A3he6DEdcn+v6cowXb4clJyusGmW+Rvge5lmA1eOSZ4m3B
   Q==;
X-CSE-ConnectionGUID: 2iHHxMA6T1mFdjapbGW2sg==
X-CSE-MsgGUID: dLJsVXKBRVm31+2D1e4KXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34305843"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34305843"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:24:41 -0800
X-CSE-ConnectionGUID: jznLnHpXQzCpMyUmtz3hJw==
X-CSE-MsgGUID: 4fJkQigkR42U2mmLona3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="100165096"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.87]) ([10.125.109.87])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:24:41 -0800
Message-ID: <e84bdd4a-7d5d-4f23-9b92-110a99db3609@intel.com>
Date: Mon, 9 Dec 2024 09:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20241204224827.2097263-1-dave.jiang@intel.com>
 <20241204224827.2097263-3-dave.jiang@intel.com>
 <abdb787d-81a7-47a7-8ee4-da250aa5355d@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <abdb787d-81a7-47a7-8ee4-da250aa5355d@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/24 1:32 AM, Li Ming wrote:
> On 12/5/2024 6:46 AM, Dave Jiang wrote:
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
>> ---
>> RFC:
>> - Minor refactors (Jonathan)
>> - Fix grammar (Jonathan)
>> ---
>>  drivers/acpi/numa/hmat.c  | 39 ++++++++++++++++++++++
>>  drivers/cxl/core/Makefile |  1 +
>>  drivers/cxl/core/acpi.c   | 11 ++++++
>>  drivers/cxl/core/core.h   |  3 ++
>>  drivers/cxl/core/region.c | 70 ++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/cxl.h         |  2 ++
>>  include/linux/acpi.h      | 19 +++++++++++
>>  tools/testing/cxl/Kbuild  |  1 +
>>  8 files changed, 142 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 976b3e1a6c2a..1c5b3c37ac29 100644
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
>> +
>> +	list_for_each_entry(tcache, &target->caches, node) {
>> +		if (tcache->cache_attrs.address_mode ==
>> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR)
>> +			continue;
> 
> Should continue only when "tcache->cache_attrs.address_mode" is NOT "NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR"?
> 
> [snip]

yes thanks. editing mistake. :(

> 
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
>> +	 * current known implementation is configured.
>> +	 */
>> +	res->start -= cache_size;
>> +	p->cache_size = cache_size;
>> +
>> +	return 0;
>> +}
>> +
>>  /* Establish an empty region covering the given HPA range */
>>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  					   struct cxl_endpoint_decoder *cxled)
>> @@ -3256,6 +3306,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> +
>> +	rc = cxl_extended_linear_cache_resize(cxlr, res);
>> +	if (rc) {
>> +		/*
>> +		 * Failing to support extended linear cache region resize does not
>> +		 * prevent the region from functioning. Only cause cxl list showing
>> +		 * incorrect region size.
>> +		 */
>> +		dev_warn(cxlmd->dev.parent,
>> +			 "Failed to support extended linear cache.\n");
>> +	}
>> +
> 
> cxl_extended_linear_cache_resize() will adjust res->start if there is an available cache_size.
> 
> Is it possible that below insert_resource() failed because "res->start" is less than "cxlrd->res->start"?
> 
> My understanding is that the address range of cxlrd->res comes from CFMWS, I don't find any description in patchset about the address range defined in CFMWS including extended linear cache size. So I guess that a CFMWS will not expose a address range with extended linear cache size?

The CFMWS window is expected to include the extended cache range. res->start should not to be less than cxlrd->res->start after adjustment. It's been the case in testing. I'll add a comment to address that. 

> 
> I'm studying this patchset, please correct me if I'm wrong. Thank you.
> 
>>  	rc = insert_resource(cxlrd->res, res);
>>  	if (rc) {
>>  		/*
> [snip]
> 
> Ming
> 


