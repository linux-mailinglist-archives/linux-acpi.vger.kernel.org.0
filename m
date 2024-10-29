Return-Path: <linux-acpi+bounces-9101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8739B54A3
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709A01C229B1
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739D1B0F1B;
	Tue, 29 Oct 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d05sFa7I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1271DE892;
	Tue, 29 Oct 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235697; cv=none; b=Ahogd6h5XkVd6CGUMymYoBS8jZHMkepDA1AsfOfhGP47DKvKuK+/QDf4Wyww2Em2yne1J6fIHTAvrL4oAsqCBVLxzqqGZqhz8NKeb9YJmWqC3IzFHCK/HSgANHWbcDizJ3zvgeNB1lVCCVppckMegJcvPHsXWhb2A+A5G46hfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235697; c=relaxed/simple;
	bh=cWwQZz5X+k5zYq/5Ls0hUi5+V7Q3QNCgVd+WIsKuI9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdcrdlGkOXz3QuVnv6e1o/SXG7CeciUcczGMT1KBE/p15cMe1QjkReElkwMpBVTjwg2EpZPqVNdAsxyc/6sBcCcI35cyJUIVdkEimys/vqtscnQUIIcTu9G5iA6qgAVHsv6pC8uCzyuNOfd5++zowabvBWh6OGAeImIShBSaA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d05sFa7I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730235694; x=1761771694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cWwQZz5X+k5zYq/5Ls0hUi5+V7Q3QNCgVd+WIsKuI9g=;
  b=d05sFa7IbOgFJeGzINZnyIbfVF4bL8mPOPllwcJ1f1yOo8DffjlPvWha
   ULhd1ctb/1V+ApDUiOH6zsdsT8xTI8e8j74SXZ/Lde5yBHXeUWTlptc0u
   6zxEAXFxKCYS1264C/oK/xDy+Li5vW9e4lvCyqJNrwFokQSeRssPki0Mu
   QfhMvBaKIyJSMgw08c0T6lu7797I1z+ZA6hTId1S5xmK+ec0Dmibiud5A
   aBw3bNx6N3WYKPHe45qykA9oilHXuSq7wcBUjQx81zExDvfs8i7sY/EJU
   2fNeZCm9bwv17m4MusLIDRyalTYiNWBJO5Erc8fdJCvdNvoVlRrJH+pHg
   A==;
X-CSE-ConnectionGUID: Y0v6d8LGTDSGWgjQlLBzgA==
X-CSE-MsgGUID: PbJRAxkUTsG0hJuODEIRrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40520628"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="40520628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:01:34 -0700
X-CSE-ConnectionGUID: VgvcmNy/T32fK1x/EZNZLA==
X-CSE-MsgGUID: J23KM/50RfKcqeCLAG0J/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82014265"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:01:33 -0700
Message-ID: <effa2250-4385-464f-b377-b2143b754cf4@intel.com>
Date: Tue, 29 Oct 2024 14:01:32 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] acpi: numa: Add support to enumerate and store
 extended linear address mode
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-3-dave.jiang@intel.com>
 <20241017170055.00003547@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017170055.00003547@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:00 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:54 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Store the address mode as part of the cache attriutes. Export the mode
>> attribute to sysfs as all other cache attributes.
>>
>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Minor things inline. Basically looks fine.
> 
> Jonathan
> 
>> ---
>>  Documentation/ABI/stable/sysfs-devices-node | 7 +++++++
>>  drivers/acpi/numa/hmat.c                    | 3 +++
>>  drivers/base/node.c                         | 2 ++
>>  include/linux/node.h                        | 7 +++++++
>>  4 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
>> index 402af4b2b905..9016cc4f027c 100644
>> --- a/Documentation/ABI/stable/sysfs-devices-node
>> +++ b/Documentation/ABI/stable/sysfs-devices-node
>> @@ -177,6 +177,13 @@ Description:
>>  		The cache write policy: 0 for write-back, 1 for write-through,
>>  		other or unknown.
>>  
>> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/mode
>> +Date:		September 2024
>> +Contact:	Dave Jiang <dave.jiang@intel.com>
>> +Description:
>> +		The address mode: 0 for reserved, 1 for extended-lniear,
> 
> linear
> 
> also, is 0 reserved or unknown? I'm confused.

It's labeled Reserved and indicates unknown in the document.

0 - Reserved (Unknown Address Mode)

I'll just remove "others unknown" line and have 0 as reserved and as well have the define as RESERVED below.

DJ

> 
> 
>> +		other unknown.
>> +
>>  What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>>  Date:		November 2021
>>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 1a902a02390f..39524f36be5b 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -506,6 +506,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
>>  		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>> +		/* Extended Linear mode is only valid if cache is direct mapped */
>> +		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR)
>> +			tcache->cache_attrs.mode = NODE_CACHE_MODE_EXTENDED_LINEAR;
>>  		break;
>>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>>  		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index eb72580288e6..744be5470728 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
>>  CACHE_ATTR(line_size, "%u")
>>  CACHE_ATTR(indexing, "%u")
>>  CACHE_ATTR(write_policy, "%u")
>> +CACHE_ATTR(mode, "%u")
>>  
>>  static struct attribute *cache_attrs[] = {
>>  	&dev_attr_indexing.attr,
>>  	&dev_attr_size.attr,
>>  	&dev_attr_line_size.attr,
>>  	&dev_attr_write_policy.attr,
>> +	&dev_attr_mode.attr,
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(cache);
>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 9a881c2208b3..589951c5e36f 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -57,6 +57,11 @@ enum cache_write_policy {
>>  	NODE_CACHE_WRITE_OTHER,
>>  };
>>  
>> +enum cache_mode {
>> +	NODE_CACHE_MODE_UNKOWN,
> UNKNOWN
> 
>> +	NODE_CACHE_MODE_EXTENDED_LINEAR,
>> +};
>> +
>>  /**
>>   * struct node_cache_attrs - system memory caching attributes
>>   *
>> @@ -65,6 +70,7 @@ enum cache_write_policy {
>>   * @size:		Total size of cache in bytes
>>   * @line_size:		Number of bytes fetched on a cache miss
>>   * @level:		The cache hierarchy level
>> + * @mode:		The address mode
>>   */
>>  struct node_cache_attrs {
>>  	enum cache_indexing indexing;
>> @@ -72,6 +78,7 @@ struct node_cache_attrs {
>>  	u64 size;
>>  	u16 line_size;
>>  	u8 level;
>> +	u16 mode;
>>  };
>>  
>>  #ifdef CONFIG_HMEM_REPORTING
> 


