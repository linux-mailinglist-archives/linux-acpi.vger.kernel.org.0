Return-Path: <linux-acpi+bounces-10424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C0A04A60
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E393A67C3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282681F63D7;
	Tue,  7 Jan 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtisyryQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AB225D6;
	Tue,  7 Jan 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278919; cv=none; b=reVeN5QN2F/6hzWP9+M9u3ChzcpYCjvwsq4hJn6gkB/UfEi5lgBxha6K43jhDbbNTVCxBfJmAKOXUaqxyN2ZGSnJvzXip02ULM8JLFYkW9LLGj+kdy8wFzt02u9vpkgfWr+FRpZZNx6LYGl4HJ1Xo7pcD/4GtzsjCC3AZyHPjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278919; c=relaxed/simple;
	bh=1J5prhZ3jGF82gvD2e/zn0E3vSX9GmnJU3BCB4h//Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb1XozjVtuy5u4OrYQl3KNgi+I9oVlG7gDZXClMziKQERNuijRlUVg7g1oWPSXdlNIzjXrOEtaHyinMWXFtF3sPG7zZuyVUvyOuVYHSHhTOHEvpJv2FSLRh0n1R0gT79klt792dvh2bk5xJu3dHs/OG2c4DZ9tCwi2hnYUPlJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtisyryQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736278916; x=1767814916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1J5prhZ3jGF82gvD2e/zn0E3vSX9GmnJU3BCB4h//Io=;
  b=BtisyryQm1sNU9w//+/KVgGGcgid5NN1ebvu9b1ZpvUgjhteBbhFjDnU
   h9MAVvOIhtX8MzQhOtlnKhlQWVmeEfzZ/bCE1WzAXOKoxz7QUa84PN3ka
   Qr+eFsD3ponn533O4r3K6wUC/y8PThU5TPHH288Q+F+HpnzhQs2EOH4Yz
   EsaDHCOoQe6HYQAycbw0A+p3RC2fZc+VPePAG91UuuUIiUhgjMtfgolul
   FpyXAMS/o302o3l7fra4qMLQv1wRx9YZh8U3V8RIq3hS+KR3TiijRIO8o
   rLKk6VI4iLTDZOLF+Q8f5tQUpIjHzYKyoq/BcPODhRQZ8LTwGojA8e6ZI
   A==;
X-CSE-ConnectionGUID: zo6po55GTsKCs5cavGiGRQ==
X-CSE-MsgGUID: 3zVTq9WsQ22SwDJNqq9j1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="53899857"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="53899857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:41:49 -0800
X-CSE-ConnectionGUID: EScFaYF8TBS0c3XQlqMXqQ==
X-CSE-MsgGUID: 77pSGjfbQvaJNKpSVOlaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106881440"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:41:47 -0800
Message-ID: <f3d1b01f-9ed8-4c56-9bb3-409b51b59291@intel.com>
Date: Tue, 7 Jan 2025 12:41:46 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl: Add extended linear cache address alias emission
 for cxl events
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20241204224827.2097263-1-dave.jiang@intel.com>
 <20241204224827.2097263-4-dave.jiang@intel.com>
 <20241224121113.00007eec@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241224121113.00007eec@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/24/24 5:11 AM, Jonathan Cameron wrote:
> On Wed, 4 Dec 2024 15:46:48 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add the aliased address of extended linear cache when emitting event
>> trace for DRAM and general media of CXL events.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> I wonder if you want to future proof the hpa_alias for potential case
> of there being more than 1?  hpa_alias0 or similar so that we can add
> more as needed?

Do you mean when emitting via the trace? Yeah I can change it to hpa_alias0 in the output string.


> 
> 
> Otherwise, looks like there is either a null point dereference or
> overly paranoid existing code. I haven't checked which but changes
> needed either way.

I'll move it under the if (cxlr) and also add a check for cxlr in the helper function.

DJ


> 
> Jonathan
> 
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 5175138c4fb7..4017b7afa78a 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -856,6 +856,24 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>  
>> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
>> +{
>> +	struct cxl_region_params *p = &cxlr->params;
> 
> Bad idea to unconditionally dereference I think. See below.
> 
>> +	int nid;
>> +
>> +	if (!p->cache_size)
>> +		return ~0ULL;
>> +
>> +	nid = cxl_region_nid(cxlr);
>> +	if (nid == NUMA_NO_NODE)
>> +		nid = 0;
>> +
>> +	if (hpa >= p->res->start + p->cache_size)
>> +		return hpa - p->cache_size;
>> +
>> +	return hpa + p->cache_size;
>> +}
>> +
>>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  			    enum cxl_event_log_type type,
>>  			    enum cxl_event_type event_type,
>> @@ -871,7 +889,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  	}
>>  
>>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>> -		u64 dpa, hpa = ULLONG_MAX;
>> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias;
>>  		struct cxl_region *cxlr;
>>  
>>  		/*
>> @@ -887,11 +905,14 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  		if (cxlr)
>>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>>  
>> +		hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
> 
> If there is no region, and hence no hpa does it make sense to call this?
> Particularly as first thing done in this is to dereference cxlr.
> 
> 
>> +
>>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>> -						&evt->gen_media);
>> +						hpa_alias, &evt->gen_media);
>>  		else if (event_type == CXL_CPER_EVENT_DRAM)
>> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
>> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
>> +				       &evt->dram);
>>  	}
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> 


