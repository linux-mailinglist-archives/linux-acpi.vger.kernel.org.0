Return-Path: <linux-acpi+bounces-10564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BDA0BF5D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699893A6AA9
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE31C3BF0;
	Mon, 13 Jan 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpcI2ppQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629A1C3BE1;
	Mon, 13 Jan 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790867; cv=none; b=qO0mKQlkuROFp5i/Ix6PX5/Bgw2a4oXRcqqm04J4B95vhsGyDXHODyjOaJLp91QQo2J7Odo8EzjYBji+AN81R3nTkO6Qi9C4ThIdX6y0e6zykIgxIVkaoi5enSpoIcQNi5R8UnSXslwaslu0/fq2dp+2TfaFy6cNbtqXRKxjOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790867; c=relaxed/simple;
	bh=qbfx+mav1u6T6IB9/NLILO24YtsBrtA7avIwUOUjJrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIYPklI46yJeDCwBnNsnobUzzrKCKgPE73PRqvDzq8h/qumBuJ1ASVHO8rrlyu3J+3/u3pNtvbg6aoViSUzXWC1yzsh6d7jGf1i+PS5KPQAXPXnDYlBXpKCMmOQe+H6d+wlgJ0I8hblCdJ+Ko7V6/l8AVsl8XObO3gdLQuV99cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpcI2ppQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736790866; x=1768326866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qbfx+mav1u6T6IB9/NLILO24YtsBrtA7avIwUOUjJrc=;
  b=XpcI2ppQhfaDWgtuNxjwlIsMprLvrzDwmExqSpF1xkUn60ZTLewPTMSZ
   zZ0gyT5kQaA/o/a2QvcjkU8OtxeSoOIyO1eojZOLwwRXpa2VGkVfOi9/Q
   9EU3izfAhd/kR8mJeBp1iUxNYo9LEBBXFEfjtEhbcHL5YMbEv1j7Zj44B
   xYqXkmTFSMb3ENTgxMFSXQhNNFqBBEaQnMX9Nk/Jt9km3/regc4yyWre9
   EXY1kY/k4yP/dmfSV6ZgZE/WtPMVdCTe3UcIKKAY/sB1bfGLfXSDxVk9w
   cDi4ytMRi4OHbVAa3dVZdzOjdS5Upwo4Z9InrzaZCKnm1qw1Q9185QUqq
   w==;
X-CSE-ConnectionGUID: IkA1JM3wS5SFTL+w8WDvmw==
X-CSE-MsgGUID: 2klOMxkFQmO56qsA5YuFGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37226935"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37226935"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:54:25 -0800
X-CSE-ConnectionGUID: YIR9Xgu1ROe27QTzTKrknA==
X-CSE-MsgGUID: pHJvHRA2QJu2bG7Nypc0Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104733715"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.41]) ([10.125.108.41])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:54:24 -0800
Message-ID: <c2345da3-54d7-485a-b878-8e74a8a93a75@intel.com>
Date: Mon, 13 Jan 2025 10:54:23 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20250110151913.3462283-1-dave.jiang@intel.com>
 <20250110151913.3462283-4-dave.jiang@intel.com>
 <20250110163234.00004c6f@huawei.com>
 <26ca18aa-6f77-4991-8cfd-42262dfa9f1a@intel.com>
 <20250113125308.000016f9@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250113125308.000016f9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/25 5:53 AM, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 10:27:52 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 1/10/25 9:32 AM, Jonathan Cameron wrote:
>>> On Fri, 10 Jan 2025 08:17:46 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> Add the aliased address of extended linear cache when emitting event
>>>> trace for DRAM and general media of CXL events.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
>>> I think the value set when there isn't a value differs between no
>>> cache and no region. That seems an odd bit of ABI.  Maybe go with ~0ULL in
>>> both cases?  
>>
>> Not sure I follow. Currently both cases do return ~0ULL.
> 
> See inline.  I don't think they do... In the no region case
> hpa is ~0ULL, hpa_alias is 0

Ah I see what you are saying now. Thanks! I'll fix that. 

DJ

> 
> 
>>
>> DJ
>>
>>>
>>> Other than tidying that up this looks fine to me.
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>   
>>>> ---
>>>> v2:
>>>> - Emit hpa_alias0 instead of hpa_alias. (Jonathan)
>>>> - Check valid cxlr before dereference. (Jonathan)
>>>> ---
>>>>  drivers/cxl/core/core.h   |  5 +++++
>>>>  drivers/cxl/core/mbox.c   | 33 +++++++++++++++++++++++++++++----
>>>>  drivers/cxl/core/region.c | 12 ++++++++++++
>>>>  drivers/cxl/core/trace.h  | 24 ++++++++++++++++--------
>>>>  4 files changed, 62 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>>> index 0fb779b612d1..afbefc72c8fa 100644
>>>> --- a/drivers/cxl/core/core.h
>>>> +++ b/drivers/cxl/core/core.h
>>>> @@ -30,8 +30,13 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>>>>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>>>>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>>>>  		   u64 dpa);
>>>> +int cxl_region_nid(struct cxl_region *cxlr);
>>>>  
>>>>  #else
>>>> +static inline int cxl_region_nid(struct cxl_region *cxlr)
>>>> +{
>>>> +	return NUMA_NO_NODE;
>>>> +}
>>>>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>>>>  				 const struct cxl_memdev *cxlmd, u64 dpa)
>>>>  {
>>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>>> index 548564c770c0..d7999260f004 100644
>>>> --- a/drivers/cxl/core/mbox.c
>>>> +++ b/drivers/cxl/core/mbox.c
>>>> @@ -856,6 +856,28 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>>>>  
>>>> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
>>>> +{
>>>> +	struct cxl_region_params *p;
>>>> +	int nid;
>>>> +
>>>> +	if (!cxlr)
>>>> +		return ~0ULL;  
>>>   
>>>> +	p = &cxlr->params;
>>>> +	if (!p->cache_size)
>>>> +		return ~0ULL;  
>>>
>>> So no cache is all 1s. .. See below.
>>>   
>>>> +
>>>> +	nid = cxl_region_nid(cxlr);
>>>> +	if (nid == NUMA_NO_NODE)
>>>> +		nid = 0;
>>>> +
>>>> +	if (hpa >= p->res->start + p->cache_size)
>>>> +		return hpa - p->cache_size;
>>>> +
>>>> +	return hpa + p->cache_size;
>>>> +}
>>>> +
>>>>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>>>  			    enum cxl_event_log_type type,
>>>>  			    enum cxl_event_type event_type,
>>>> @@ -871,7 +893,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>>>  	}
>>>>  
>>>>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>>>> -		u64 dpa, hpa = ULLONG_MAX;
>>>> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = 0;  
>>>
>>> If I read this right if there is a region but no alias then the hpa_alias is
>>> ~0ULL but if there no region it is 0.  Seems a tiny bit inconsistent.
> 
> Here you set hpa_alias to 0.
> 
>>>   
>>>>  		struct cxl_region *cxlr;
>>>>  
>>>>  		/*
>>>> @@ -884,14 +906,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>>>  
>>>>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
>>>>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>>> -		if (cxlr)
>>>> +		if (cxlr) {
> 
> If no region, nothing changes hpa_alias.
> 
>>>>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>>>> +			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
>>>> +		}
>>>>  
>>>>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>>>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>>> -						&evt->gen_media);
>>>> +						hpa_alias, &evt->gen_media);
>>>>  		else if (event_type == CXL_CPER_EVENT_DRAM)
>>>> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
>>>> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
>>>> +				       &evt->dram);
>>>>  	}
>>>>  }  
>>>
>>>   
>>
>>
> 


