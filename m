Return-Path: <linux-acpi+bounces-11378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A2A403A8
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 00:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9AC19C6B4C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC22066FC;
	Fri, 21 Feb 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU+7D4ta"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4C1B0406;
	Fri, 21 Feb 2025 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181523; cv=none; b=IbcshsW51HY9uJ4OU4Ej5J+ulEcRT3pBCgxBOdY/SGsc/XVY3x2j0VsYNs3hVzCvFuoU6yC5C3MYgK5q7aTz7FZ6iZGNil89pOirxvAQJ1fNUacmVoGJGJJiH3nNoOHpOC1bfHcpoBb9/WCw+BHUz+iaQgwe1CWSnLrd5FVQUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181523; c=relaxed/simple;
	bh=n1uOkd2WTyFLnabtKo8iPrPj0R4GF47XIeQXJkTYGDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBXQDONaVEEZfoZbapM7+Ba84tszmQxAHoy7uakWaba2160yNojR/g5QvZCeiJi7DuYL0kSrjfQTEP3H6rEfd4l+uYcJTo5ySoZO0uAPyTz7GKBss8ebcnEbS7f9KdDh3o9XeS0vM0YLDNN6KfH7gitc5LvxxnN8ZRYrmEQyAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU+7D4ta; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740181521; x=1771717521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n1uOkd2WTyFLnabtKo8iPrPj0R4GF47XIeQXJkTYGDM=;
  b=gU+7D4taR06/2gvwyz/hK8I13Yn/ArFBFunSNPYdjRgzJaHZvT0HqUkS
   8God1pk9eLYJ6j3sykyOXdR62XFwEDkpbUAdd+MWddoOTzYLLkUqr7bGn
   e29pst/C4400KFJmKODud2XpG2IR2ZhlaOuDHVOsuSffr3m1EPS5kQMkg
   sxOU28o11VnCCTLUEIPQ/2ZZj+pUCeLCoT4yvtceUiAOFrPjOhU1pWHV6
   EtdZg7NjNMBy0HY0dtxDsQ0+gQo6wZZbjLVfGRVcugFNDd4jxCgIky3UJ
   vIYzLWs9fw5phPp3ZsNUFbh0hikxMHW+y6VFDtlmqqy45q1DLot0lIt/F
   Q==;
X-CSE-ConnectionGUID: lq2+6vQgQwuiQFa5qFZUfA==
X-CSE-MsgGUID: K+6JRHNgTKaQVF5UsSp73A==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44924717"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44924717"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 15:45:20 -0800
X-CSE-ConnectionGUID: gKjhdNyrTASknoP4/hi5Rg==
X-CSE-MsgGUID: KlhlnnSfTiepEJlmviWwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115518467"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.110.216]) ([10.125.110.216])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 15:45:19 -0800
Message-ID: <cbf6d9d3-eadc-40ad-be41-70a80a4aa6b1@intel.com>
Date: Fri, 21 Feb 2025 16:45:18 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] acpi: numa: Add support to enumerate and store
 extended linear address mode
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
 ming.li@zohomail.com
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-2-dave.jiang@intel.com>
 <Z7faINPWuDaWtq1C@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z7faINPWuDaWtq1C@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 6:42 PM, Alison Schofield wrote:
> On Fri, Jan 17, 2025 at 10:28:30AM -0700, Dave Jiang wrote:
>> Store the address mode as part of the cache attriutes. Export the mode
>> attribute to sysfs as all other cache attributes.
>>
>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  Documentation/ABI/stable/sysfs-devices-node | 6 ++++++
>>  drivers/acpi/numa/hmat.c                    | 5 +++++
>>  drivers/base/node.c                         | 2 ++
>>  include/linux/node.h                        | 7 +++++++
>>  4 files changed, 20 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
>> index 402af4b2b905..c46b910dfe00 100644
>> --- a/Documentation/ABI/stable/sysfs-devices-node
>> +++ b/Documentation/ABI/stable/sysfs-devices-node
>> @@ -177,6 +177,12 @@ Description:
>>  		The cache write policy: 0 for write-back, 1 for write-through,
>>  		other or unknown.
>>  
>> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/address_mode
>> +Date:		December 2024
>> +Contact:	Dave Jiang <dave.jiang@intel.com>
>> +Description:
>> +		The address mode: 0 for reserved, 1 for extended-linear.
>> +
> 
> I was going to say something about the brevity of the description,
> but when I looked in the file, I see this is like all the other
> memory_side_cache descriptions.
> 
> So - I'll just say - update that Date :)
> 
> 
>>  What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>>  Date:		November 2021
>>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 80a3481c0470..a9172cf90002 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -506,6 +506,11 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
>>  		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>> +		/* Extended Linear mode is only valid if cache is direct mapped */
>> +		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR) {
>> +			tcache->cache_attrs.address_mode =
>> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR;
>> +		}
>>  		break;
>>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>>  		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 0ea653fa3433..cd13ef287011 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
>>  CACHE_ATTR(line_size, "%u")
>>  CACHE_ATTR(indexing, "%u")
>>  CACHE_ATTR(write_policy, "%u")
>> +CACHE_ATTR(address_mode, "%#x")
> 
> why not "%u" fmt ?

It's a bitfield value and not decimal. 

DJ

> 
>>  
>>  static struct attribute *cache_attrs[] = {
>>  	&dev_attr_indexing.attr,
>>  	&dev_attr_size.attr,
>>  	&dev_attr_line_size.attr,
>>  	&dev_attr_write_policy.attr,
>> +	&dev_attr_address_mode.attr,
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(cache);
>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 9a881c2208b3..2b7517892230 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -57,6 +57,11 @@ enum cache_write_policy {
>>  	NODE_CACHE_WRITE_OTHER,
>>  };
>>  
>> +enum cache_mode {
>> +	NODE_CACHE_ADDR_MODE_RESERVED,
>> +	NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR,
>> +};
>> +
>>  /**
>>   * struct node_cache_attrs - system memory caching attributes
>>   *
>> @@ -65,6 +70,7 @@ enum cache_write_policy {
>>   * @size:		Total size of cache in bytes
>>   * @line_size:		Number of bytes fetched on a cache miss
>>   * @level:		The cache hierarchy level
>> + * @address_mode:		The address mode
>>   */
>>  struct node_cache_attrs {
>>  	enum cache_indexing indexing;
>> @@ -72,6 +78,7 @@ struct node_cache_attrs {
>>  	u64 size;
>>  	u16 line_size;
>>  	u8 level;
>> +	u16 address_mode;
>>  };
>>  
>>  #ifdef CONFIG_HMEM_REPORTING
>> -- 
>> 2.47.1
>>


