Return-Path: <linux-acpi+bounces-11476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A57A44DBB
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134D63B6575
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA02214A62;
	Tue, 25 Feb 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yg8Wadpe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1B21019A;
	Tue, 25 Feb 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515648; cv=none; b=gLKnI65BvQ4wuFGH4aXtAMRevC5U1zABwSxNqnIVRi9h5n5FAI5C1PT12MxnumJe87ZxxjxqED0H1kd9ABENGl1qFGCYavNyyBPIUmUicI/vqnxCWj+21/rPf2q2LgNVMc/12QEBpF3I6Hx2Ej5CeNe1YmenPRvamLlYQFDjFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515648; c=relaxed/simple;
	bh=8dfBXFcm2KXc+38ebzZPgXW5cc2mMwtUf+GAA5/SQCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTorgEY9q8U9ltSZlMDhgFbxvA20u7fKNyRnssh7KpJYENLTKH9vaSBUAZKDl5srRM/Fk6rBDjekVqPbewyWBej+tRIXTW4zeFiTOtRLU+kBbhYGRxK+2Mv7vyZ3MuoTDOSXsLfSR0IypImsOn2crLlxGIXOcZHioqdICcnXxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yg8Wadpe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740515646; x=1772051646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dfBXFcm2KXc+38ebzZPgXW5cc2mMwtUf+GAA5/SQCs=;
  b=Yg8WadpeMBDJRp6bNv1X/LhA9jVA+4ozO2kUyz6yzq1f5MZLnCg2afIj
   QanK3NB7Bifyym8IbhMYkRdb7iWlTwyX39b0S4KAYg1/ArwGEpFf4zXmK
   ISNZQSTJBRgl6I+fUQH1P0OLKVy9FbtjBbz17UwagwB5oH5URROJSz4Zj
   x9Is6QQ4EfII3ICMTrQuzr00jjEYvQ7iHn5aAiln5atzsBIOSNDNFYUjk
   Gzt+qoOrGVkq1EcNwQBWWGz4rrd56HRNGOgcayQoc4EEiY8uuOWzDbvbU
   qzWl3GhxO/zyWjjuK7kiLCK2NWFSs93rQzUNB265SinmxG07g7D99Ki94
   g==;
X-CSE-ConnectionGUID: geG8jLD4S9mbfPeYDUPQgA==
X-CSE-MsgGUID: KxLfY4EpTCay0EVx3hLRfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41470384"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41470384"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:34:05 -0800
X-CSE-ConnectionGUID: W3lKAR7/T8CiLK0rPVRKtQ==
X-CSE-MsgGUID: hjM7KtZfROK2aRmC3f4wKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116990410"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.175])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:34:06 -0800
Date: Tue, 25 Feb 2025 12:34:03 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v4 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <Z74pO6m10psBdJns@aschofie-mobl2.lan>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182202.1683380-4-dave.jiang@intel.com>

On Mon, Feb 24, 2025 at 11:21:01AM -0700, Dave Jiang wrote:
> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.

What about cxl_poison trace events?

When cxl device poison lists are read, or poison is injected
or cleared, an HPA is included in the trace event. Seems the
hpa_alias0 belong there too. 


> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Make error using ULLONG_MAX consistently. (Alison)
> - Make hpa_alias0 naming consistent. (Alison)
> - Swap incorrect position of hpa and hpa_alias0. (Alison)
> ---
>  drivers/cxl/core/mbox.c  | 28 ++++++++++++++++++++++++----
>  drivers/cxl/core/trace.h | 22 ++++++++++++++--------
>  2 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..808b6a3c577b 100644
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
> +		return ULLONG_MAX;

checked cxlr in caller

> +
> +	p = &cxlr->params;
> +	if (!p->cache_size)
> +		return ULLONG_MAX;
> +
> +	if (hpa >= p->res->start + p->cache_size)
> +		return hpa - p->cache_size;
> +
> +	return hpa + p->cache_size;

Since a DPA can only be in the cxl resource half of the p->res, not in
the extended cache, is alias always hpa - cache.


>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -871,7 +888,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	}
>  
>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> -		u64 dpa, hpa = ULLONG_MAX;
> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
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

How about something like this to eliminate cxlr_hpa_cache_alias():
 
 	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
-		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
+		u64 dpa, cache_size, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
 		struct cxl_region *cxlr;
 
 		/*
@@ -904,7 +887,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr) {
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
-			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
+			cache_size = cxlr->params.cache_size;
+			if (cache_size)
+				hpa_alias = hpa - cache_size;
 		}


snip


