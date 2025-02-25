Return-Path: <linux-acpi+bounces-11472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31397A44C10
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F497A2030
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CF220E32B;
	Tue, 25 Feb 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4xgsujB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2B20DD79;
	Tue, 25 Feb 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514273; cv=none; b=YtxRPbh11PiuAHLuzDMjJ3VYPQOPqYzI2E/lSXmP438AH2AfwkjdChEBbvCQt4yL90HLEUNnlvcOj2nGIflQMt6nhObJOWi8lGP8UCYVZF4dmCZu0qYnKNBxMi2c5VBG4AJF8gyxFja6VzJOw3/8J3DCia099QhkId43nFNjbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514273; c=relaxed/simple;
	bh=DdDqk2Z2Hrl4FOy6YQnAYyODnlggw7XDfQs4VFw/ZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtECf/Y4/mu1m+yr73+Tv3JHBMOFsjBCcKhcKk5QWa2K+T0p/1jdXrZTYSMh6cSPFn0GfjP/Dw+1z9wZHsZnEC2dQZpwipwZYTpWv4duWeCFQBeRy+RttAAdSt6x1j1KNH/E1Z5WtRnSpQGayr+HP9rCQ79PRN3qDEmt3el6JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4xgsujB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740514272; x=1772050272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdDqk2Z2Hrl4FOy6YQnAYyODnlggw7XDfQs4VFw/ZyY=;
  b=e4xgsujBDOHgy1u1+NZkPlqHks0QshmPTG7El9PZJQCam5YwHLeiEZDf
   kwWqF2fI+siKpw4gwpt7cQINdTlZjnPkXkrhpc1y3zq/Zx5Ex+noZPSM8
   wVjs6kYHeGF7h9y46MJMGnho7ODrlIhMTmDd9dTOxq4bfo8V4dlk0paKk
   +fnvFZkUWjfIK1fShbppopVPy/UxvQwHjBt5KcR6VKckd1OeEkBQF6MNN
   LVZ2LZQyC86ZBHtttOyfb9YVqYStQ8n+qP6el5aEW3KOHpE4bLk/jler3
   LgJVSKY0huF/vQqSEDCitGPbuaXXbe46cuR3zbJTwkgpp52lC6es09JIC
   w==;
X-CSE-ConnectionGUID: 3grGumGjSoOaHcfb+tObvQ==
X-CSE-MsgGUID: gzXGkVLPTvy5+W9Xk3JugQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51977375"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51977375"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:11:11 -0800
X-CSE-ConnectionGUID: oTi7FKmqTHS6RNkcKn4SeA==
X-CSE-MsgGUID: 5O33ic4hTDSdchjwE1AALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121576450"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.175])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:11:11 -0800
Date: Tue, 25 Feb 2025 12:11:09 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v4 2/4] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <Z74j3U_60B2YEDQS@aschofie-mobl2.lan>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182202.1683380-3-dave.jiang@intel.com>

On Mon, Feb 24, 2025 at 11:21:00AM -0700, Dave Jiang wrote:

snip to a dev_dbg message of interest -
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e8d11a988fd9..cd7b0c31ebf7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

snip
> @@ -1951,7 +1965,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> +	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
>  	    resource_size(p->res)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",

Add cache to this message since used in calculation above.
Took the liberty of trimming 'decoder-size' to '-size' since the decoder name
already precedes '-size'.



 		dev_dbg(&cxlr->dev,
-			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
+			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			(u64)resource_size(cxled->dpa_res), p->interleave_ways,
-			(u64)resource_size(p->res));
+			(u64)p->cache_size, (u64)resource_size(p->res));
 		return -EINVAL;
 	}
 

snip

