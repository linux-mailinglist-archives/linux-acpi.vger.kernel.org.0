Return-Path: <linux-acpi+bounces-9102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF199B5579
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780E71C20CD9
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942B2076A3;
	Tue, 29 Oct 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4sjPXWi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A619258A;
	Tue, 29 Oct 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239491; cv=none; b=NyBcl9Ty0WfKxGFKsTpJfNLAaiiFmFYXIzSzwk50dw3Eij5wZr+vt/RcITD1F2uv9oucrBURKV5zuTv/58OfZo6F6UGMsvdpUfl+PZruTHKJtZpPDpOSgfT1aeLDMVSZhAtjiziVrZHDMIEYhbdW9QTTlM0TfKtGIxWYZPi38pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239491; c=relaxed/simple;
	bh=y8KWKuxGkL/BPjBMtM814TiJ8OGP9rJD9m+ed2dzyhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7//sHmCAkyV+7foQirp8d4RrAocLeNDksi8RL9tf5tRtxPfZTarHZuPgaTyA4FUaSdaCW4JMHyjeqR/MjcsGnIiu6l0KIaZw+zobPGb0ACZZHDCvM+82HpOJNZauNvL1jwca7AevxETd+aHiRxhpzeBZoXAwru7EA7cnpWpikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4sjPXWi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730239489; x=1761775489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y8KWKuxGkL/BPjBMtM814TiJ8OGP9rJD9m+ed2dzyhM=;
  b=I4sjPXWioShy//J10SU1cmCVaG7zVhJN4EUruMzXa1XBE0PjmOJqbioE
   pn7JSyHe3zD9DJtYZnT+SoGRhXbQuWIo5bkOICZONdjQ3xFBpmorE4Slg
   Oc1ebtxczmWORpqqbQIYPbkuNpu42fkxT0c5QwIj5a1PeadoYdBuGMqoK
   6GLV8DzN7UtTY0H+qc33Q6EZ93ia8G0IT/BO1ByISVnfzr7cAQBif4ZP0
   FQgcE7eNSxtP0rr7ikbfxuaq+zpOyDTwZ0tjPHIlfKMhZR1fE3KFNmPd7
   5fZg/XJ8mQjHWvoEh57b9N3D8AmFi1361XzHfxW7UFczfsW+rr369eELt
   w==;
X-CSE-ConnectionGUID: L7eqO+BSSc6xcnvLi402CA==
X-CSE-MsgGUID: 0RgoaKarQe+FSbjBJKAu8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30059658"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30059658"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:04:43 -0700
X-CSE-ConnectionGUID: OqhCiiaKTouNofd1lmU0DA==
X-CSE-MsgGUID: Cexjwj4VQGG9tJWqr0I9uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="86714574"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:04:41 -0700
Message-ID: <53690802-4d65-412b-b70a-7502574e9b4a@intel.com>
Date: Tue, 29 Oct 2024 15:04:40 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] acpi/hmat / cxl: Add extended linear cache
 support for CXL
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-4-dave.jiang@intel.com>
 <20241017172059.000056e9@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017172059.000056e9@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:20 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:55 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The current cxl region size only indicates the size of the CXL memory region
>> without accounting for the extended linear cache size. Retrieve the cache
>> size from HMAT and append that to the cxl region size for the cxl region
>> range that matches the SRAT range that has extended linear cache enabled.
>>
>> The SRAT defines the whole memory range that inclues the extended linear
> 
> includes
> 
>> cache and the CXL memory region. The new HMAT update to the Memory Side
> 
> ECN/ECR, not update.  After all update might mean _HMA
> 
>> Cache Information Structure defines the size of the extended linear cache
>> size and matches to the SRAT Memory Affinity Structure by the memory proxmity
>> domain. Add a helper to match the cxl range to the SRAT memory range in order
>> to retrieve the cache size.
>>
>> There are several places that checks the cxl region range against the
>> decoder range. Use new helper to check between the two ranges and address
>> the new cache size.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Various comments inline.
>> ---
>>  drivers/acpi/numa/hmat.c  | 44 +++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/Makefile |  1 +
>>  drivers/cxl/core/acpi.c   | 11 +++++++++
>>  drivers/cxl/core/core.h   |  3 +++
>>  drivers/cxl/core/region.c | 51 ++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/cxl.h         |  2 ++
>>  include/linux/acpi.h      |  8 ++++++
>>  tools/testing/cxl/Kbuild  |  1 +
>>  8 files changed, 117 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 39524f36be5b..d299f8d7af8c 100644
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
> Why is finding the first one appropriate?  Maybe you have more than one?
> I'd move the code bellow up here then carry on to see if there is another
> entry if resource_contains fails.

Yes I'll move that.

> 
> 
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
>> +	res = &target->memregions;
>> +	if (!resource_contains(res, backing_res))
>> +		return -ENOENT;
>> +
>> +	*cache_size = tcache->cache_attrs.size;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
>> +
>>  static struct memory_target *acpi_find_genport_target(u32 uid)
>>  {
>>  	struct memory_target *target;
> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..ddfb1e1a8909 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -816,6 +816,17 @@ static int match_free_decoder(struct device *dev, void *data)
>>  	return 0;
>>  }
>>  
>> +static bool region_res_match_range(struct cxl_region_params *p,
> 
> This is a little odd. So comment on what it is doing needed.
> I think it is patching the CXL backed bit of the region
> by offsetting the start back to where it was before you
> subtracted the dram cache size.

Does it make it more clear if I rename it to region_res_match_cxl_range()? Regardless I'll add some comments.

> 
>> +				   struct range *range)
>> +{
>> +	if (p->res &&
> I'd break the
> 	if (!p->res)
> 		return false;
> off then
> 	return p->res->start + p->cache_size == range->start &&
> 	       p->res->end == range->end;
> 
>> +	    p->res->start + p->cache_size == range->start &&
>> +	    p->res->end == range->end)
>> +		return true;
>> +
>> +	return false;
>> +}
> Reasonable to factor this out first.
>> +
>>  static int match_auto_decoder(struct device *dev, void *data)
>>  {
>>  	struct cxl_region_params *p = data;
>> @@ -828,7 +839,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>>  	cxld = to_cxl_decoder(dev);
>>  	r = &cxld->hpa_range;
>>  
>> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
>> +	if (region_res_match_range(p, r))
>>  		return 1;
>>  
>>  	return 0;
>> @@ -1406,8 +1417,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>  		if (cxld->interleave_ways != iw ||
>>  		    cxld->interleave_granularity != ig ||
>> -		    cxld->hpa_range.start != p->res->start ||
>> -		    cxld->hpa_range.end != p->res->end ||
>> +		    !region_res_match_range(p, &cxld->hpa_range) ||
>>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>>  			dev_err(&cxlr->dev,
>>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>> @@ -1931,7 +1941,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  		return -ENXIO;
>>  	}
>>  
>> -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
>> +	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
>>  	    resource_size(p->res)) {
>>  		dev_dbg(&cxlr->dev,
>>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
>> @@ -3226,6 +3236,34 @@ static int match_region_by_range(struct device *dev, void *data)
>>  	return rc;
>>  }
>>  
>> +static int cxl_extended_linear_cache_resize(struct cxl_region_params *p,
>> +					    struct resource *res)
>> +{
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
>> +	if (size != cache_size)
>> +		return -EINVAL;
>> +
>> +	res->start -= cache_size;
> 
> I don't recall the ECN saying which way round they were (and it didn't
> occur to me at the time) i.e. local dram first or CXL dram first.
> Did I miss that?  I was kind of thinking extra capacity at higher
> addresses but no particularly reason why...

No the spec does not dictate that. However the current implementation by Intel firmware always puts local DRAM first as cache and CXL at the higher address. I just coded up the simple case for now. Not sure if we want to support the complex variation detection or just leave it to what's being implemented until someone shows up with a variation. I'll add some comments.

> 
>> +	p->cache_size = cache_size;
>> +
>> +	return 0;
>> +}
>> +
> Trivial but 1 blank line probably appropriate.

thank you for spotting that.

>> +
>>  /* Establish an empty region covering the given HPA range */


