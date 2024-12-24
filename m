Return-Path: <linux-acpi+bounces-10291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B69FBD23
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 13:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A6B7A1D58
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4B1BD00C;
	Tue, 24 Dec 2024 12:11:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D61B85E2;
	Tue, 24 Dec 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042281; cv=none; b=DOw/sz0J3deiq7/8EHlMz67FNmuftVMxYK36rk35yvAZJiO5Q/NekfAk2N8GUnxOquWlahSaG+siY6DRpvRiTtschtbhHbQmD0bLk8UVhaH7sKCIEVMERB0Gd8ozAbOQ4wzupfYwO2uSUwfifdB1+Dk5t92ygisPA9XDSjpZWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042281; c=relaxed/simple;
	bh=Iixqwo6z6VER9i70Il5t0g7oxOZRmnkUCb1oBVl5ELc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Url0s1l7ueXqbfJ25EOEmVx8Tdh0WCq/Xvit5d9cjlsXqCXjfxXk4geQGaNdEP4VO8GNjOa1DRgYWSKkjMDipU/OgCNAt87cp6HWXgBFcWy6PKmMYQfOOuZydPrM6SRHwgduLAAq5mXD3hAke9BeaAODoSCbX43MEML3U6tgG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHYY73sysz6K93D;
	Tue, 24 Dec 2024 20:07:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A779140A70;
	Tue, 24 Dec 2024 20:11:16 +0800 (CST)
Received: from localhost (10.126.171.172) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 13:11:15 +0100
Date: Tue, 24 Dec 2024 12:11:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20241224121113.00007eec@huawei.com>
In-Reply-To: <20241204224827.2097263-4-dave.jiang@intel.com>
References: <20241204224827.2097263-1-dave.jiang@intel.com>
	<20241204224827.2097263-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 4 Dec 2024 15:46:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I wonder if you want to future proof the hpa_alias for potential case
of there being more than 1?  hpa_alias0 or similar so that we can add
more as needed?


Otherwise, looks like there is either a null point dereference or
overly paranoid existing code. I haven't checked which but changes
needed either way.

Jonathan

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5175138c4fb7..4017b7afa78a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -856,6 +856,24 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
> +{
> +	struct cxl_region_params *p = &cxlr->params;

Bad idea to unconditionally dereference I think. See below.

> +	int nid;
> +
> +	if (!p->cache_size)
> +		return ~0ULL;
> +
> +	nid = cxl_region_nid(cxlr);
> +	if (nid == NUMA_NO_NODE)
> +		nid = 0;
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
> @@ -871,7 +889,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	}
>  
>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> -		u64 dpa, hpa = ULLONG_MAX;
> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias;
>  		struct cxl_region *cxlr;
>  
>  		/*
> @@ -887,11 +905,14 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>  
> +		hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);

If there is no region, and hence no hpa does it make sense to call this?
Particularly as first thing done in this is to dereference cxlr.


> +
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
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);


