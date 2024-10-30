Return-Path: <linux-acpi+bounces-9141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD599B700F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C326D1F2245F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293A91E9065;
	Wed, 30 Oct 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4HVkxjb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352161CF5E0;
	Wed, 30 Oct 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328806; cv=none; b=ennAZ20FhVZGxzVHuQgppK4mJW+j/0nyvPSSkOQyQFTgsIc9rlk/WuSHCXbPdR4Rw10AkHbxtxfIOAYykBjH22l++JhmSN25HNawCcTv40dhfylSsZaDRN5E5r1h7tERwbsNcGXOPypvIr0HHy170KPlhnOQB38++HxgzpRuzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328806; c=relaxed/simple;
	bh=ta/3mu/K6XLdk9iyl+3tE+uEvy7rkf8Tqkm1e4chglE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1zmGhoJx9A/UGMdhJ57sarPKwp7M1RabWD1Fqx6XThZ56p0yqdU2GWMjUH2PfHffZrmieyABOtilwCVTBtkNp+xOOmVV7ozstSm4/6eb8Bnu5i5uVRZdgYIk0TNtkiQGnHpVSrejh6UEJoUQzVkI1JLuegJca9+jlMA+6QoD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4HVkxjb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730328804; x=1761864804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ta/3mu/K6XLdk9iyl+3tE+uEvy7rkf8Tqkm1e4chglE=;
  b=Y4HVkxjbTVjM/t/IdImsXyU4ClYfWVLUm3saVXCK3Hg1Rncpt6QcG0/i
   3ya5RTteXcj+NRzHgRW/jWXzquAEkkEN8HkHuIlfVBh81r5rofczEePUu
   AcnuANtaqqauk67nY2PTokXlw0kVy2ZNNLrZhp831z0gm7UeiFPnRbjk8
   157MLiOF4x0bLs7ahCENjBkfyxZA5RBwGTaoGtXyJSPK954hwSwEpk2Ty
   kFAko0hjKkLGe5UxFvc1Ba4EV6nghKbdtEQThDNF/cYnAUDBSqBFkLyUM
   PN8fP6e+NKc/e4GpiGKwLwvtGeeiImkkE9MtAs1L28dwtbilviLYBf2hY
   A==;
X-CSE-ConnectionGUID: lE0pxd0ORKW9lV8gtne3fQ==
X-CSE-MsgGUID: sNDDlxC4RqKINYyCR+86rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30208206"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30208206"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 15:53:23 -0700
X-CSE-ConnectionGUID: vSiz8NTnT5eA58POIRiUYA==
X-CSE-MsgGUID: IQ/eeVpJSzyznBT1fLTPKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="105776749"
Received: from nnlnb-sb-019.ccr.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 15:53:21 -0700
Message-ID: <773c3a60-22eb-4719-84dd-64d642926230@intel.com>
Date: Wed, 30 Oct 2024 15:53:20 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-5-dave.jiang@intel.com>
 <20241017173326.0000191a@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017173326.0000191a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:33 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:56 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add helper functions to help do address translation for either the address
>> of the extended linear cache or its alias address. The translation function
>> attempt to detect an I/O hole in the proximity domain and adjusts the address
>> if the hole impacts the aliasing of the address. The range of the I/O hole
>> is retrieved by walking through the associated memory target resources.
> 
> What does the I/O hole correspond to in the system?
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/acpi/numa/hmat.c | 136 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h     |  14 ++++
>>  2 files changed, 150 insertions(+)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index d299f8d7af8c..834314582f4c 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -152,6 +152,142 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
>>  
>> +static int alias_address_find_iohole(struct memory_target *target,
>> +				     u64 address, u64 alias, struct range *hole)
>> +{
>> +	struct resource *alias_res = NULL;
>> +	struct resource *res, *prev;
>> +
>> +	*hole = (struct range) {
>> +		.start = 0,
>> +		.end = -1,
>> +	};
>> +
>> +	/* First find the resource that the address is in */
>> +	prev = target->memregions.child;
>> +	for (res = target->memregions.child; res; res = res->sibling) {
>> +		if (alias >= res->start && alias <= res->end) {
>> +			alias_res = res;
>> +			break;
>> +		}
>> +		prev = res;
>> +	}
>> +	if (!alias_res)
> 
> 	if (!res) and you can just use res instead of alias_res for the following
> as you exit the loop with it set to the right value.
>
Ok will do that
 
> 
> 
>> +		return -EINVAL;
>> +
>> +	/* No memory hole */
>> +	if (alias_res == prev)
>> +		return 0;
>> +
>> +	/* If address is within the current resource, no need to deal with memory hole */
>> +	if (address >= alias_res->start)
>> +		return 0;
>> +
>> +	*hole = (struct range) {
>> +		.start = prev->end + 1,
>> +		.end = alias_res->start - 1,
>> +	};
> Ordering assumption should be avoided in such a generic
> sounding function.  Can the hole be first?

Do you mean if the address mapping starts out with an MMIO range and then memory range? I'm not sure if such an implementation exists in the x86 world. And if the hole is behind all the ranges, then it shouldn't impact the address calculations. 

> 
> or rename the function to include preceding_hole or something like that.
>> +
>> +	return 0;
>> +}
>> +
>> +int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
>> +{
>> +	unsigned int pxm = node_to_pxm(nid);
>> +	struct memory_target *target;
>> +	struct range iohole;
>> +	int rc;
>> +
>> +	target = find_mem_target(pxm);
>> +	if (!target)
>> +		return -EINVAL;
>> +
>> +	rc = alias_address_find_iohole(target, address, *alias, &iohole);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!range_len(&iohole))
>> +		return 0;
>> +
> Maybe reformat like this and add comments on each condition.
> 
> 	if (address >= iohole.start)
> 		return 0;
> 
> 	if (*alias <= iohole.start)
> 		return 0;
> 
> 	*alias += range_len(&iohole);
> 
> 	return 0;
> 
>

Will change to that and add comments.
 	
>> +	if (address < iohole.start) {
>> +		if (*alias > iohole.start) {
>> +			*alias = *alias + range_len(&iohole);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_alias_xlat, CXL);
>> +
>> +static int target_address_find_iohole(struct memory_target *target,
>> +				      u64 address, u64 alias,
>> +				      struct range *hole)
>> +{
>> +	struct resource *addr_res = NULL;
>> +	struct resource *res, *next;
>> +
>> +	*hole = (struct range) {
>> +		.start = 0,
>> +		.end = -1,
>> +	};
>> +
>> +	/* First find the resource that the address is in */
>> +	for (res = target->memregions.child; res; res = res->sibling) {
>> +		if (address >= res->start && address <= res->end) {
>> +			addr_res = res;
> 
> Could just use res as it's scope is outside the loop.

Will update.

> 
>> +			break;
>> +		}
>> +	}
>> +	if (!addr_res)
>> +		return -EINVAL;
>> +
>> +	next = res->sibling;
>> +	/* No memory hole after the region */
>> +	if (!next)
>> +		return 0;
>> +
>> +	/* If alias is within the current resource, no need to deal with memory hole */
>> +	if (alias <= addr_res->end)
>> +		return 0;
>> +
>> +	*hole = (struct range) {
>> +		.start = addr_res->end + 1,
>> +		.end = next->start - 1,
>> +	};
>> +
>> +	return 0;
>> +}
>> +
>> +int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
>> +{
>> +	unsigned int pxm = node_to_pxm(nid);
>> +	struct memory_target *target;
>> +	struct range iohole;
>> +	int rc;
>> +
>> +	target = find_mem_target(pxm);
>> +	if (!target)
>> +		return -EINVAL;
>> +
>> +	rc = target_address_find_iohole(target, *address, alias, &iohole);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!range_len(&iohole))
>> +		return 0;
>> +
> 
> Similar to above, maybe break into multiple reasons to exit early.
> 

Will update.

>> +	if (alias > iohole.end) {
>> +		if (*address < iohole.end) {
>> +			*address = *address - range_len(&iohole);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_address_xlat, CXL);
>>
> 
> Jonathan


