Return-Path: <linux-acpi+bounces-11360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D774CA3EA09
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 02:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FEB1716C1
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624DB7080D;
	Fri, 21 Feb 2025 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJ9Az+Nz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C15156CA;
	Fri, 21 Feb 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101415; cv=none; b=EOvzuqmznJlBSfOh/1QITOtMu3xSfr0TSiw+oiBbJxp1Boyj57J6xE2HnvZSTUUy26Imy0vVWiVuInXubxyQOo464gY1nTuT59KrCVl3dnfhir3YmgYKRWYjjpkXgPxK0TFl1EooCKoE3S66zwVBbT1UQv97Xl0Ggd49BCl8wDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101415; c=relaxed/simple;
	bh=TylAkjyZ/Mrio1T0XJzQhjNWcDz4osUS7nibUACN/24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqfhrX5cYfO85kzXZHpbhUR+rH40/BgbO6wdUzpFM4+B9ofpSPInIX2IueshpVZO1j9dZtBeeClP9GwbmAmp3YyfDhJvWBdeQmUMf5VZtxe9Mq9wjzQBJNjiU5LIv/vfAhFXIihh7ptmRi6zb1SIgHOgvxrTk3zHqipBxtYN7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJ9Az+Nz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740101413; x=1771637413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TylAkjyZ/Mrio1T0XJzQhjNWcDz4osUS7nibUACN/24=;
  b=AJ9Az+NzYh2o4KGR+9x5TN7rUHQe/G/P0A1KKW7n6zThbXxsVGf2GGP+
   75lpLqSWKfS1voK62xxNUHO/AReocz1ttW6lKU+dv+Y1TonLfCQx35BnI
   2yDlwlqXora7OC3SV+snIn7pTWFdGR1cNztZQOFaxrFo+dhq6m6dh9gTa
   71G+rTrhULopZOmF1W9KQNzebaHKBQVZ1kJQbgvATvubJ4guhN2Jomulo
   4W/eHQVDeQn+Ybeovgnu7uRsGFluXMNkKddCKMIYMk8YZYCN06fhjkKbE
   WJNCFnEe2yqvQWIk1jf/SHeK9OmUHFlkf3s7NbxhsCjC9CNwsabiaItpS
   A==;
X-CSE-ConnectionGUID: kyIC6N5yTcmQ/Lk2q5uEtQ==
X-CSE-MsgGUID: pw7IR1fMRKywmTiC3dAVgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40921023"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40921023"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:30:12 -0800
X-CSE-ConnectionGUID: iuT9FOiSQPGAQ9L8BWEE5g==
X-CSE-MsgGUID: ydfAOs4oRWGwbrUJW3IeQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115875231"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.117])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:30:11 -0800
Date: Thu, 20 Feb 2025 17:30:09 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v3 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <Z7fXIQKTG9pCRtS7@aschofie-mobl2.lan>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117173054.4147877-4-dave.jiang@intel.com>

On Fri, Jan 17, 2025 at 10:28:32AM -0700, Dave Jiang wrote:
> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Drop unused region to nid function
> - Make sure hpa_alias defaults to ~0ULL. (Jonathan)
> ---
>  drivers/cxl/core/mbox.c  | 28 ++++++++++++++++++++++++----
>  drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..f42c4c56dc43 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -856,6 +856,23 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>  
> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
> +{
> +	struct cxl_region_params *p;
> +
> +	if (!cxlr)
> +		return ~0ULL;
> +
> +	p = &cxlr->params;
> +	if (!p->cache_size)
> +		return ~0ULL;
> +
> +	if (hpa >= p->res->start + p->cache_size)
> +		return hpa - p->cache_size;
> +
> +	return hpa + p->cache_size;
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -871,7 +888,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	}
>  
>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> -		u64 dpa, hpa = ULLONG_MAX;
> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ~0ULL;

A bit odd to use 2 different notations for same thing.
Prefer ULLONG_MAX here and in previous function.


>  		struct cxl_region *cxlr;
>  
>  		/*
> @@ -884,14 +901,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  
>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> -		if (cxlr)
> +		if (cxlr) {
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
> +			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
> +		}
>  
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> -						&evt->gen_media);
> +						hpa_alias, &evt->gen_media);
>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
> +				       &evt->dram);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 8389a94adb1a..257f60f16e4c 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -316,9 +316,10 @@ TRACE_EVENT(cxl_generic_event,
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
> +		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
> +		 struct cxl_event_gen_media *rec),
>  
> -	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
> +	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
>  
>  	TP_STRUCT__entry(
>  		CXL_EVT_TP_entry
> @@ -332,6 +333,7 @@ TRACE_EVENT(cxl_general_media,
>  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>  		/* Following are out of order to pack trace record */
>  		__field(u64, hpa)
> +		__field(u64, hpa_alias)

I saw Jonathan's ask for hpa_alias to be hpa_alias0 or something?
That's done in the CXL_EVT_TP_printk output below. It needs to be
used here in the field name to be picked up in the trace event.
(same for cxl_dram event)

But...what's the deal with hpa_alias0. If we anticipate an array
of aliases, then maybe an array like is done for comp_id would
work. Expect that's overkill at the moment.


>  		__field_struct(uuid_t, region_uuid)
>  		__field(u16, validity_flags)
>  		__field(u8, rank)
> @@ -358,6 +360,7 @@ TRACE_EVENT(cxl_general_media,
>  			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
>  		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
>  		__entry->hpa = hpa;
> +		__entry->hpa_alias = hpa_alias;
>  		if (cxlr) {
>  			__assign_str(region_name);
>  			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
> @@ -370,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
>  		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
>  		"device=%x comp_id=%s validity_flags='%s' " \
> -		"hpa=%llx region=%s region_uuid=%pUb",
> +		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
>  		show_gmer_mem_event_type(__entry->type),
> @@ -378,7 +381,8 @@ TRACE_EVENT(cxl_general_media,
>  		__entry->channel, __entry->rank, __entry->device,
>  		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
>  		show_valid_flags(__entry->validity_flags),
> -		__entry->hpa, __get_str(region_name), &__entry->region_uuid
> +		__entry->hpa, __entry->hpa_alias, __get_str(region_name),
> +		&__entry->region_uuid
>  	)
>  );
>  
> @@ -424,9 +428,10 @@ TRACE_EVENT(cxl_general_media,
>  TRACE_EVENT(cxl_dram,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
> +		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
> +		 struct cxl_event_dram *rec),
>  
> -	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
> +	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
>  
>  	TP_STRUCT__entry(
>  		CXL_EVT_TP_entry
> @@ -442,6 +447,7 @@ TRACE_EVENT(cxl_dram,
>  		__field(u32, row)
>  		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
>  		__field(u64, hpa)
> +		__field(u64, hpa_alias)
>  		__field_struct(uuid_t, region_uuid)
>  		__field(u8, rank)	/* Out of order to pack trace record */
>  		__field(u8, bank_group)	/* Out of order to pack trace record */
> @@ -472,6 +478,7 @@ TRACE_EVENT(cxl_dram,
>  		memcpy(__entry->cor_mask, &rec->correction_mask,
>  			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
>  		__entry->hpa = hpa;
> +		__entry->hpa_alias = hpa_alias;
>  		if (cxlr) {
>  			__assign_str(region_name);
>  			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
> @@ -485,7 +492,7 @@ TRACE_EVENT(cxl_dram,
>  		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
>  		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
>  		"validity_flags='%s' " \
> -		"hpa=%llx region=%s region_uuid=%pUb",
> +		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
>  		show_dram_mem_event_type(__entry->type),
> @@ -495,7 +502,8 @@ TRACE_EVENT(cxl_dram,
>  		__entry->row, __entry->column,
>  		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
>  		show_dram_valid_flags(__entry->validity_flags),
> -		__entry->hpa, __get_str(region_name), &__entry->region_uuid
> +		__entry->hpa_alias, __entry->hpa, __get_str(region_name),

Needs swapping -  hpa then hpa_alias


> +		&__entry->region_uuid
>  	)
>  );
>  
> -- 
> 2.47.1
> 

