Return-Path: <linux-acpi+bounces-9906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6089E2F7F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74922282E9E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073A1E25E3;
	Tue,  3 Dec 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P69f/2Kg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B38460;
	Tue,  3 Dec 2024 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267157; cv=none; b=BldsYSqcZGZPL0kd8aQjAxk8ghe1sRICkuXkeTaw9VUn9pmpQq2aamdd8sSSYrEZMopNRyKOOLjBXSxnsxl3k8kmaNuBkydwK0aD0O1oCwq9xiIO597VoZ7dn8BHCTMgi5M3Wzp4F3qcOBKx6BX/Ds+zbIwW+XaYP6XGOeYwaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267157; c=relaxed/simple;
	bh=rVT526fNSvIbb/Xk1Um21/qmPnAbW+h/jglS+K/QzgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqnevpTRTIKFhVJGsAbfiGFxMfWC+UM0vAhLmLdgF4VwqZgxxkhNhFcfnqhJhT8U1flCrhUf16z4emluH1Fvi0SeD7AWtxBVXTbhz0BGjz0vTNw7ySHhhiJcN2taHAy8jFN6GE11IZuk//yondRNxyWMRpGN1gvYbIvZ9AYSzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P69f/2Kg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733267156; x=1764803156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rVT526fNSvIbb/Xk1Um21/qmPnAbW+h/jglS+K/QzgM=;
  b=P69f/2KgGM6WQhGKP9P7RX7f8MTWeol8cuHygfPhxS5MHlnzgWIfgoN/
   70GE+wvVbQXUwpNLWDD539LRQJzFO1mztTeIREmlZa7Ez6DEp2w9fjgt0
   CEBOLpkQxZCKzK/iv5naW98Iiat8CPsOzK2XEy/wr9n+TJ+W7oRbNaN+e
   XiykPOkklrXHHrOfw129ta1S0Plr+M0Ws6ygedE8gcrGXDUOO4DuG/qc6
   QKaYHPR1uTP5M7ykxVe1pdg++7fQTbtDptY/O4lo6gHXHqbYhkytMX23L
   GGYXjOT/k1wwvOPJUttva6h9A8s5uB+s8dsq+eBAmbHWZius5hEsgXVxf
   w==;
X-CSE-ConnectionGUID: cxgLy57tTrKhtVoRg3rEDA==
X-CSE-MsgGUID: uOqAvVhBSvGki6ZXsBRXlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33388177"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33388177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:05:56 -0800
X-CSE-ConnectionGUID: HbQHPJKAQP6CewLMWTB50Q==
X-CSE-MsgGUID: iM48SLyrQ1+0i9xLBpawBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93669878"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.238]) ([10.125.111.238])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:05:55 -0800
Message-ID: <f5d12829-5a2d-4522-a66b-e32794c97797@intel.com>
Date: Tue, 3 Dec 2024 16:05:54 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] acpi: numa: Add support to enumerate and store
 extended linear address mode
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20241112221335.432583-1-dave.jiang@intel.com>
 <20241112221335.432583-2-dave.jiang@intel.com>
 <20241126161622.00005ee8@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241126161622.00005ee8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/24 9:16 AM, Jonathan Cameron wrote:
> On Tue, 12 Nov 2024 15:12:33 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Store the address mode as part of the cache attriutes. Export the mode
>> attribute to sysfs as all other cache attributes.
>>
>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> One trivial suggestion that I don't care that much about.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v2:
>> - Fix spelling errors (Jonathan)
>> - Change UNKNOWN to RESERVED (Jonathan)
>> ---
>>  Documentation/ABI/stable/sysfs-devices-node | 6 ++++++
>>  drivers/acpi/numa/hmat.c                    | 3 +++
>>  drivers/base/node.c                         | 2 ++
>>  include/linux/node.h                        | 7 +++++++
>>  4 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
>> index 402af4b2b905..725ef0e1e01f 100644
>> --- a/Documentation/ABI/stable/sysfs-devices-node
>> +++ b/Documentation/ABI/stable/sysfs-devices-node
>> @@ -177,6 +177,12 @@ Description:
>>  		The cache write policy: 0 for write-back, 1 for write-through,
>>  		other or unknown.
>>  
>> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/mode
> 
> Mode feels perhaps a bit to vague.  Maybe address_mode?

ok

DJ
> 
>> +Date:		September 2024
>> +Contact:	Dave Jiang <dave.jiang@intel.com>
>> +Description:
>> +		The address mode: 0 for reserved, 1 for extended-linear.
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
> 


