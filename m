Return-Path: <linux-acpi+bounces-11403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF287A42A23
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0533A7246
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6931A704B;
	Mon, 24 Feb 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsfCwUOU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D920170A13;
	Mon, 24 Feb 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418982; cv=none; b=kLa6o/fj6x1g1APlefvvz3P1V/A3+tZoaaNPkvDdTyl3vIec7jxzvqhCl8klHHs9Fcg5tFAKLPaLN2xI1lZMaB8QPyIXqriQ0VAHWj+Ir2gTNrr21aUs19D4oUJ0KViahKP0M2ytqpUCPVVx8dlOS80fJvklqba+V/XrK9cEtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418982; c=relaxed/simple;
	bh=/FUvw7XYwn0qNqcLkrfaYzsdpAoFB4FS51Xw/H2tBJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeBu5BQrQZYGA57eMVBQxKF+Zq6Kf90rbhph/T19F8UQNBdoLDAEf98SPRAot/yt2j0zyBshZHXBpZbsjUBGyn4hMbw1PU7SeyGj1oxnOnRon3QqVHsWdWfYj77QQN37/TRI9TSkQx2mROjx6O4tBW4rERISOkt4oPRpNjMILB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsfCwUOU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418980; x=1771954980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/FUvw7XYwn0qNqcLkrfaYzsdpAoFB4FS51Xw/H2tBJk=;
  b=lsfCwUOUcxYTU6I4Hqps3RgDGQtUE2AEWiWXgkO3a/rJ8gYTMuLJHXTc
   C1gxR181hqV61cyFGGb3bY29Q/jQpNlNAHnrnzVxfSPFL1W7iQ5TYpa2Z
   NF0nIcplibgSwDM4imn1jb7egvNI4Vo6NHzDnKNnycSV9RCFmNY3Ghq/a
   mzMYUof17tHRvHgQuqtceGneWD5Qru5HsgoTHkykQhzHhdjt4bb/PF5Pm
   QW1z9aUQ2R/e3mz0BNVInCU4cPCXksqSk486/oM7nKz6TIEygPz+LYGfY
   fn1dG0z4qfIZQ6m6+4+JW4NwVzItgCjIUEYYxnBuhKS0l23Jng4CD2xHb
   g==;
X-CSE-ConnectionGUID: 8r0/JlvfQYmvNUpKjoqoIQ==
X-CSE-MsgGUID: P8pvnb61RKGR0whQB1gAxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66556656"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66556656"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:32:46 -0800
X-CSE-ConnectionGUID: 5vP1Awm+RCuzKtptHqGkhQ==
X-CSE-MsgGUID: RNPeUYYLQNGIJlAfVA7p4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115876582"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.71]) ([10.125.111.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:32:45 -0800
Message-ID: <e3ac044f-f3d2-439b-82c2-6044a3a7769c@intel.com>
Date: Mon, 24 Feb 2025 10:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
 ming.li@zohomail.com
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-4-dave.jiang@intel.com>
 <Z7fXIQKTG9pCRtS7@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z7fXIQKTG9pCRtS7@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 6:30 PM, Alison Schofield wrote:
> On Fri, Jan 17, 2025 at 10:28:32AM -0700, Dave Jiang wrote:
>> Add the aliased address of extended linear cache when emitting event
>> trace for DRAM and general media of CXL events.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Drop unused region to nid function
>> - Make sure hpa_alias defaults to ~0ULL. (Jonathan)
>> ---
>>  drivers/cxl/core/mbox.c  | 28 ++++++++++++++++++++++++----
>>  drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
>>  2 files changed, 40 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 548564c770c0..f42c4c56dc43 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -856,6 +856,23 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>>  
>> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
>> +{
>> +	struct cxl_region_params *p;
>> +
>> +	if (!cxlr)
>> +		return ~0ULL;
>> +
>> +	p = &cxlr->params;
>> +	if (!p->cache_size)
>> +		return ~0ULL;
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
>> @@ -871,7 +888,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>  	}
>>  
>>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>> -		u64 dpa, hpa = ULLONG_MAX;
>> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ~0ULL;
> 
> A bit odd to use 2 different notations for same thing.
> Prefer ULLONG_MAX here and in previous function.

Will fix

> 
> 
>>  		struct cxl_region *cxlr;
>>  
>>  		/*
>> @@ -884,14 +901,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
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
>>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 8389a94adb1a..257f60f16e4c 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -316,9 +316,10 @@ TRACE_EVENT(cxl_generic_event,
>>  TRACE_EVENT(cxl_general_media,
>>  
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
>> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
>> +		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
>> +		 struct cxl_event_gen_media *rec),
>>  
>> -	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>> +	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
>>  
>>  	TP_STRUCT__entry(
>>  		CXL_EVT_TP_entry
>> @@ -332,6 +333,7 @@ TRACE_EVENT(cxl_general_media,
>>  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>>  		/* Following are out of order to pack trace record */
>>  		__field(u64, hpa)
>> +		__field(u64, hpa_alias)
> 
> I saw Jonathan's ask for hpa_alias to be hpa_alias0 or something?
> That's done in the CXL_EVT_TP_printk output below. It needs to be
> used here in the field name to be picked up in the trace event.
> (same for cxl_dram event)
> 
> But...what's the deal with hpa_alias0. If we anticipate an array
> of aliases, then maybe an array like is done for comp_id would
> work. Expect that's overkill at the moment.

So basically the spec language allows for multiple aliases, but the current implementation only has 1. So this is basically allowing for that happen in the future but not doing much more than that until actual implementation happens.

> 
> 
>>  		__field_struct(uuid_t, region_uuid)
>>  		__field(u16, validity_flags)
>>  		__field(u8, rank)
>> @@ -358,6 +360,7 @@ TRACE_EVENT(cxl_general_media,
>>  			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
>>  		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
>>  		__entry->hpa = hpa;
>> +		__entry->hpa_alias = hpa_alias;
>>  		if (cxlr) {
>>  			__assign_str(region_name);
>>  			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
>> @@ -370,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
>>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
>>  		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
>>  		"device=%x comp_id=%s validity_flags='%s' " \
>> -		"hpa=%llx region=%s region_uuid=%pUb",
>> +		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
>>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>>  		show_event_desc_flags(__entry->descriptor),
>>  		show_gmer_mem_event_type(__entry->type),
>> @@ -378,7 +381,8 @@ TRACE_EVENT(cxl_general_media,
>>  		__entry->channel, __entry->rank, __entry->device,
>>  		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
>>  		show_valid_flags(__entry->validity_flags),
>> -		__entry->hpa, __get_str(region_name), &__entry->region_uuid
>> +		__entry->hpa, __entry->hpa_alias, __get_str(region_name),
>> +		&__entry->region_uuid
>>  	)
>>  );
>>  
>> @@ -424,9 +428,10 @@ TRACE_EVENT(cxl_general_media,
>>  TRACE_EVENT(cxl_dram,
>>  
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
>> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
>> +		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
>> +		 struct cxl_event_dram *rec),
>>  
>> -	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>> +	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
>>  
>>  	TP_STRUCT__entry(
>>  		CXL_EVT_TP_entry
>> @@ -442,6 +447,7 @@ TRACE_EVENT(cxl_dram,
>>  		__field(u32, row)
>>  		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
>>  		__field(u64, hpa)
>> +		__field(u64, hpa_alias)
>>  		__field_struct(uuid_t, region_uuid)
>>  		__field(u8, rank)	/* Out of order to pack trace record */
>>  		__field(u8, bank_group)	/* Out of order to pack trace record */
>> @@ -472,6 +478,7 @@ TRACE_EVENT(cxl_dram,
>>  		memcpy(__entry->cor_mask, &rec->correction_mask,
>>  			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
>>  		__entry->hpa = hpa;
>> +		__entry->hpa_alias = hpa_alias;
>>  		if (cxlr) {
>>  			__assign_str(region_name);
>>  			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
>> @@ -485,7 +492,7 @@ TRACE_EVENT(cxl_dram,
>>  		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
>>  		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
>>  		"validity_flags='%s' " \
>> -		"hpa=%llx region=%s region_uuid=%pUb",
>> +		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
>>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>>  		show_event_desc_flags(__entry->descriptor),
>>  		show_dram_mem_event_type(__entry->type),
>> @@ -495,7 +502,8 @@ TRACE_EVENT(cxl_dram,
>>  		__entry->row, __entry->column,
>>  		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
>>  		show_dram_valid_flags(__entry->validity_flags),
>> -		__entry->hpa, __get_str(region_name), &__entry->region_uuid
>> +		__entry->hpa_alias, __entry->hpa, __get_str(region_name),
> 
> Needs swapping -  hpa then hpa_alias

Will fix
> 
> 
>> +		&__entry->region_uuid
>>  	)
>>  );
>>  
>> -- 
>> 2.47.1
>>


