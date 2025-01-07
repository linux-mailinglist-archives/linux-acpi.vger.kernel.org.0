Return-Path: <linux-acpi+bounces-10413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C90A04819
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E4164CD5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF891F63C4;
	Tue,  7 Jan 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHDmZd+i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E111CAF;
	Tue,  7 Jan 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270665; cv=none; b=L8NXKcyQsAzCqP1W6yXlTbWQt04Lh3ayhS1H2Ki/LuMPwapnxrjOY065AJHhcDrOlaRIV1+3ND/CcySsV//1IFqHphbsrc5EgggazCIbyDAEotxwupiXH9rWwyVgDsuKkn63x3oOvJGjXXpguBdK/iiCDIy84Qf/kpGbzQh2A+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270665; c=relaxed/simple;
	bh=PT2xxIgbqNizwbPrGMRRavfZUi+HmmVCJloYmVkGeuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peLcVwKMT6PRqQxpe7wYxZdMUZ28F54u+lzOa1DL2/56PEg8VfxMqaLkGyLBz9yFC8m7OYV8Z+O/GLEv7BA5xzgzGFuD+/T1l6rq3/FtpH3MNu17k/QtRT0YqU+2LvfuthJX+c9HUq6Z7rNHQUjH4fwrEPg55+2ItzSpdjMMZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHDmZd+i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736270662; x=1767806662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PT2xxIgbqNizwbPrGMRRavfZUi+HmmVCJloYmVkGeuE=;
  b=XHDmZd+i/FnGatJNfjnHxj5wngVsctMQvgaiogKQEzgZZYSZzzVvDOuy
   I+US2wJADfKGetAT00FqXMqzihMrNPta/cO2DvwGrlqmwbF7GRxfb1kjC
   UdZAXnU7fXOOdqmWhh37VzG6wka4rJkw0WhZ6B544tnY547ojJDzKfdtS
   H33VzzU/cg1QbQnRa608ygDR7c/M9ovPASLQ4o4tzijBBWfwMM0szcsIW
   kNphaQ9dgwrt9n1MIMmoEQ6K8YXKIvzht7sn8bNz19ZLZedOD0ccEqlT3
   HuEqjK8zkl0Vqiy/8o0PJfnZ7E5Yt2LEtAcOku8EKZQ4ehq7EPUb39mtx
   g==;
X-CSE-ConnectionGUID: 4dSkKwu0Rd+qnrTdt4lCLA==
X-CSE-MsgGUID: x1d+8aW+RJW8xCt+X3XmKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35698043"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="35698043"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 09:24:22 -0800
X-CSE-ConnectionGUID: LN4/mm43Q9qVk2LtRzldpw==
X-CSE-MsgGUID: Y9HV7T9bQJOhKhxz0o8QDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="107702950"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 09:24:21 -0800
Message-ID: <accbbbc1-fd0f-4bba-bc0e-300a8edb270e@intel.com>
Date: Tue, 7 Jan 2025 10:24:19 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20241204224827.2097263-1-dave.jiang@intel.com>
 <20241204224827.2097263-3-dave.jiang@intel.com>
 <20241224120535.000077e9@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241224120535.000077e9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/24/24 5:05 AM, Jonathan Cameron wrote:
> On Wed, 4 Dec 2024 15:46:47 -0700
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
> A few minor comments inline given you are going around again for the issue
> Li Ming spotted.
> 
> Jonathan
> 
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
>> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
> 
> Needs quotes around "CXL" now I think.

Yep. That was a fun surprise coming back from the holidays.

> 
>> +
>>  static struct memory_target *acpi_find_genport_target(u32 uid)
>>  {
>>  	struct memory_target *target;
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 9259bcc6773c..1a0c9c6ca818 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>>  cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>> +cxl_core-y += acpi.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 70d0a017e99c..72ede9842dab 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -824,6 +824,21 @@ static int match_free_decoder(struct device *dev, void *data)
>>  	return 1;
>>  }
>>  
>> +static bool region_res_match_cxl_range(struct cxl_region_params *p,
>> +				       struct range *range)
>> +{
>> +	if (!p->res)
>> +		return false;
>> +
>> +	/*
>> +	 * The CXL range is assumed to be fronted by the DRAM range in
>> +	 * current known implementation. This assumption will be made
>> +	 * until a variant implementation exists.
> Start with:
> If an extended linear cache region then the CXL range is...
> 
> Otherwise the comment sounds more general that it is.

ok

> 
>> +	 */
>> +	return p->res->start + p->cache_size == range->start &&
>> +		p->res->end == range->end;
>> +}
>> +
>>  static int match_auto_decoder(struct device *dev, void *data)
>>  {
>>  	struct cxl_region_params *p = data;
>> @@ -836,7 +851,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>>  	cxld = to_cxl_decoder(dev);
>>  	r = &cxld->hpa_range;
>>  
>> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
>> +	if (region_res_match_cxl_range(p, r))
>>  		return 1;
>>  
>>  	return 0;
>> @@ -1413,8 +1428,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>  		if (cxld->interleave_ways != iw ||
>>  		    cxld->interleave_granularity != ig ||
>> -		    cxld->hpa_range.start != p->res->start ||
>> -		    cxld->hpa_range.end != p->res->end ||
>> +		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
>>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>>  			dev_err(&cxlr->dev,
>>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> 
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
> 
> Only causes cxl list to show incorrect region size

thank you
> 
>> +		 * incorrect region size.
>> +		 */
>> +		dev_warn(cxlmd->dev.parent,
>> +			 "Failed to support extended linear cache.\n");
>> +	}
>> +
>>  	rc = insert_resource(cxlrd->res, res);
>>  	if (rc) {
>>  		/*
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index f6015f24ad38..61df87a31e02 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -492,6 +492,7 @@ enum cxl_config_state {
>>   * @res: allocated iomem capacity for this region
>>   * @targets: active ordered targets in current decoder configuration
>>   * @nr_targets: number of targets
>> + * @cache_size: extended linear cache size, if exists
> 
> otherwise zero. (as you don't check for existence - or remove "if exists"
> and just have "extended linear cache size"
> 

ok


>>   *
>>   * State transitions are protected by the cxl_region_rwsem
>>   */
>> @@ -503,6 +504,7 @@ struct cxl_region_params {
>>  	struct resource *res;
>>  	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
>>  	int nr_targets;
>> +	resource_size_t cache_size;
>>  };
>>  
>>  /*
> 


