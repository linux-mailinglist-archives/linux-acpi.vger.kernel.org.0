Return-Path: <linux-acpi+bounces-11498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1669DA467DB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264793A935B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D48223324;
	Wed, 26 Feb 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZV6zol1b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A569224894;
	Wed, 26 Feb 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590386; cv=none; b=n6wAHaqYVAEFHD7bH0DDOSOUsSBgf0S+5UgpZAgbqjtogNa1pBfQB+JwCW04PUJD7uJXtko8iuP6VpYNZMjNjOrw0DdETOes+s7wocZfK36Oy665w957Rl98/gpJVl5mMVPJ2nSYURL6UnX2l8OAu5+FmkV3hg7cAZQkua6wkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590386; c=relaxed/simple;
	bh=tOMKMg9Sz5uVMUCdiY0dXxB4kCwyCuUnvgQiXCSDxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbZ8Vzixd/wyEUG5IRF4bbhRh6ts4DOjiBUi/hWpnm9fyciWcOJanVFHAOIJbPyPBE22krbM+5e9cWSEJEbCrBznnTO9MQMtwMFUM4b/cCtYLoxsXs+QyMa/6d59kdr3NbEuIkpf81tjJCAIHR3G63ZynPzdn1waGAFwNis6z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZV6zol1b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740590384; x=1772126384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOMKMg9Sz5uVMUCdiY0dXxB4kCwyCuUnvgQiXCSDxmA=;
  b=ZV6zol1bNSzDzMqZRJ8ytdJERbmEm0VzFULUOpbi+Aj6oW+8u4dePL2T
   OoaJdIn5spwQSwVa+bp5BGB9OTDctsSV2a4eVzKs+P1GAkiemffRvtGV8
   sEFjVCCpNqL96NHFxpy+vMEQKT2bLhDTtWhnaotFoH5G4nt6VV6oMwY8t
   PkXwIcbDiLRtZquHeZCciNXBlznhAPIykfHflO0lA6w52HdKxoq0sNm+k
   S9ltPdcH0ygEQjRKnXZ0N1WWmMg7agXeE2zSmoHyXEbbrQFtTiC22LPgN
   c0pXTPYn9f21Z3VaW8IXuG2J5XppO3loFCn2BgjYF8XsCx5zzOl4krq5p
   A==;
X-CSE-ConnectionGUID: lDkhIlsITIiSRf/Ku05f+A==
X-CSE-MsgGUID: H5+Q28OLRMeclCAk5seRlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40628752"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40628752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:19:44 -0800
X-CSE-ConnectionGUID: n3wNHOw9SqG92jvzOtF0wQ==
X-CSE-MsgGUID: EEKkHNbdRpuM/KgKZGd9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121372068"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:19:43 -0800
Date: Wed, 26 Feb 2025 09:19:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v5 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <Z79NLEcv3D_6DL15@aschofie-mobl2.lan>
References: <20250226162224.3633792-1-dave.jiang@intel.com>
 <20250226162224.3633792-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226162224.3633792-4-dave.jiang@intel.com>

On Wed, Feb 26, 2025 at 09:21:20AM -0700, Dave Jiang wrote:
> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.

and poison events.

> 
snip

> @@ -870,6 +876,7 @@ TRACE_EVENT(cxl_poison,
>  		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
>  		__field(u64, overflow_ts)
>  		__field(u64, hpa)
> +		__field(u64, hpa_alias0)
>  		__field(u64, dpa)
>  		__field(u32, dpa_length)
>  		__array(char, uuid, 16)
> @@ -892,16 +899,19 @@ TRACE_EVENT(cxl_poison,
>  			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
>  			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
>  						      __entry->dpa);
> +			__entry->hpa_alias0 = cxlr->params.cache_size ?
> +				__entry->hpa + cxlr->params.cache_size : ULLONG_MAX;

check for cxl_dpa_to_hpa() returning ULLONG_MAX before doing alias math.

>  		} else {
>  			__assign_str(region);
>  			memset(__entry->uuid, 0, 16);
>  			__entry->hpa = ULLONG_MAX;
> +			__entry->hpa_alias0 = ULLONG_MAX;
>  		}
>  	    ),

snip


