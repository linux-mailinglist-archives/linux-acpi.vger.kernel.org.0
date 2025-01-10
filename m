Return-Path: <linux-acpi+bounces-10521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA4A09882
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17DE3A0732
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64522139C4;
	Fri, 10 Jan 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxNDNxNw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788D213E6F;
	Fri, 10 Jan 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530075; cv=none; b=fgEgU3uc8tMrCLioZRkX3BIN9t7IlZELoza1wr/dxpYiXF8c4wKBlXss/+3yXk0Na+CswujFFJiHAqJHBayOHRNc7rUnC91o9UdMD8lJ+31/SehmlYIqRtvRKJjk0BRlUCvLP+GXAdLN3+wisI+IS2F7tR1N8rT8Y/+Hi6s6YOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530075; c=relaxed/simple;
	bh=BJtdf5/sQhm76y60n0tGsHTAinSe/Inq7e+xB9MyaoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKf595w6RHEjukScX5kV3O8kERJDZdcCHsJ131oEhyGPONTB6NWfR+86zdjrqF5xzq0iP30OcsY+P6vw/lcWb30ZiIdX76fr2iraCG+UwNB/Zh9KjQOQMkGJgCr5k0xDSjqMNwjMWHM/9T6eM+j7UOjFA+5JkZo3K4Y3bTPo7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxNDNxNw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736530074; x=1768066074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BJtdf5/sQhm76y60n0tGsHTAinSe/Inq7e+xB9MyaoA=;
  b=jxNDNxNw01ZxUUQ/c2JGtvQf3MoY142dD1qeQS/5JhUMk7EuYOpbSKZ5
   SvEhyMMPWDbN3jHVgw3rO0EXlKlFW2+ql2WL5Thg5ga+UjDKrIurQ/NRi
   t8h38ZaTNkSsgeARPtdEvWZFLWcZIeNhrehczm+wE2Eaut8zgKuXKN+Gl
   o8YSWZw249YZ6IiPBeBq3Qsv0ZXFN9sf2a6l9N5ab25k3T5/wt8aZ3yeX
   jd4B9K4+bIeYNmqN5RF9iTPoi1MKtccFgaF+n0tpQMQZsBTcfV1AAFyNy
   P6BwBBCRDaUzx4oEN0A6NGR3JZB/CKAzjYHD3+gQHSmVcgswvyUZZ7nJJ
   g==;
X-CSE-ConnectionGUID: x3hy3e+lRCuO/F9sfqGlhQ==
X-CSE-MsgGUID: IP6AOvwJRq6Jtew8T/PDsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="48196248"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="48196248"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:27:54 -0800
X-CSE-ConnectionGUID: 2OLAI82aQQ6SB7wEJUPZog==
X-CSE-MsgGUID: dwGX5y5PQKOxq3YXWvzVYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103566381"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:27:53 -0800
Message-ID: <26ca18aa-6f77-4991-8cfd-42262dfa9f1a@intel.com>
Date: Fri, 10 Jan 2025 10:27:52 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250110163234.00004c6f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 9:32 AM, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 08:17:46 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add the aliased address of extended linear cache when emitting event
>> trace for DRAM and general media of CXL events.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> I think the value set when there isn't a value differs between no
> cache and no region. That seems an odd bit of ABI.  Maybe go with ~0ULL in
> both cases?

Not sure I follow. Currently both cases do return ~0ULL.

DJ

> 
> Other than tidying that up this looks fine to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v2:
>> - Emit hpa_alias0 instead of hpa_alias. (Jonathan)
>> - Check valid cxlr before dereference. (Jonathan)
>> ---
>>  drivers/cxl/core/core.h   |  5 +++++
>>  drivers/cxl/core/mbox.c   | 33 +++++++++++++++++++++++++++++----
>>  drivers/cxl/core/region.c | 12 ++++++++++++
>>  drivers/cxl/core/trace.h  | 24 ++++++++++++++++--------
>>  4 files changed, 62 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 0fb779b612d1..afbefc72c8fa 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -30,8 +30,13 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>>  		   u64 dpa);
>> +int cxl_region_nid(struct cxl_region *cxlr);
>>  
>>  #else
>> +static inline int cxl_region_nid(struct cxl_region *cxlr)
>> +{
>> +	return NUMA_NO_NODE;
>> +}
>>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>>  				 const struct cxl_memdev *cxlmd, u64 dpa)
>>  {
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 548564c770c0..d7999260f004 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -856,6 +856,28 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>>  
>> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
>> +{
>> +	struct cxl_region_params *p;
>> +	int nid;
>> +
>> +	if (!cxlr)
>> +		return ~0ULL;
> 
>> +	p = &cxlr->params;
>> +	if (!p->cache_size)
>> +		return ~0ULL;
> 
> So no cache is all 1s. .. See below.
> 
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
>> @@ -871,7 +893,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  	}
>>  
>>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>> -		u64 dpa, hpa = ULLONG_MAX;
>> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = 0;
> 
> If I read this right if there is a region but no alias then the hpa_alias is
> ~0ULL but if there no region it is 0.  Seems a tiny bit inconsistent.
> 
>>  		struct cxl_region *cxlr;
>>  
>>  		/*
>> @@ -884,14 +906,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  
>>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
>>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>> -		if (cxlr)
>> +		if (cxlr) {
>>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>> +			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
>> +		}
>>  
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
> 
> 


