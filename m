Return-Path: <linux-acpi+bounces-10510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD872A0947F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F88E188D816
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D33210F65;
	Fri, 10 Jan 2025 14:59:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449ED20DD74;
	Fri, 10 Jan 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521165; cv=none; b=l2lx1MgDt6M5pD4tvpWuwGzBn6GcVHVhrnpNlj65MJ4tuK4VrjkNFAm5Tch0mNMCq7Hw5E6ZAHWAWr/9G+q8Vqhp9yFlhXo2VK1jvlG54SOz1bkEPHz1CTSrOvJTSKC55MvgJ/pIC0+BqJuhYzg+SOZw0gL1Hfcvx+RgqXlCW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521165; c=relaxed/simple;
	bh=qoN4csxcH42JEKIUwkPsIuRENnJhK9htZfI1jnoH3+s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkulwvQzcfNIX9P+ib9CrqABemCzwNPbGe9eRSrspFDsChJ9FVhXYyTzZ3WKaqBYQYE7XFdpYiAVAClOU8E0vktkfe+qkZM1KNmLRIUkc83ZVL2FQ4t0qA1aKC+qcE4SaPMsTE0DOmkzOmvVJeS7qv76UMdhuIkwpnjUZJF6mFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV4Wn6WSVz6D9CW;
	Fri, 10 Jan 2025 22:57:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C32001403D2;
	Fri, 10 Jan 2025 22:59:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 15:59:19 +0100
Date: Fri, 10 Jan 2025 14:59:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20250110145917.00006541@huawei.com>
In-Reply-To: <f3d1b01f-9ed8-4c56-9bb3-409b51b59291@intel.com>
References: <20241204224827.2097263-1-dave.jiang@intel.com>
	<20241204224827.2097263-4-dave.jiang@intel.com>
	<20241224121113.00007eec@huawei.com>
	<f3d1b01f-9ed8-4c56-9bb3-409b51b59291@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 12:41:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 12/24/24 5:11 AM, Jonathan Cameron wrote:
> > On Wed, 4 Dec 2024 15:46:48 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Add the aliased address of extended linear cache when emitting event
> >> trace for DRAM and general media of CXL events.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > I wonder if you want to future proof the hpa_alias for potential case
> > of there being more than 1?  hpa_alias0 or similar so that we can add
> > more as needed?  
> 
> Do you mean when emitting via the trace? Yeah I can change it to hpa_alias0 in the output string.
> 

err. Can't entirely remember what I meant but that seems sensible ;)

> 
> > 
> > 
> > Otherwise, looks like there is either a null point dereference or
> > overly paranoid existing code. I haven't checked which but changes
> > needed either way.  
> 
> I'll move it under the if (cxlr) and also add a check for cxlr in the helper function.
> 
> DJ
> 
> 
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 5175138c4fb7..4017b7afa78a 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -856,6 +856,24 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >>  
> >> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
> >> +{
> >> +	struct cxl_region_params *p = &cxlr->params;  
> > 
> > Bad idea to unconditionally dereference I think. See below.
> >   
> >> +	int nid;
> >> +
> >> +	if (!p->cache_size)
> >> +		return ~0ULL;
> >> +
> >> +	nid = cxl_region_nid(cxlr);
> >> +	if (nid == NUMA_NO_NODE)
> >> +		nid = 0;
> >> +
> >> +	if (hpa >= p->res->start + p->cache_size)
> >> +		return hpa - p->cache_size;
> >> +
> >> +	return hpa + p->cache_size;
> >> +}
> >> +
> >>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >>  			    enum cxl_event_log_type type,
> >>  			    enum cxl_event_type event_type,
> >> @@ -871,7 +889,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >>  	}
> >>  
> >>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> >> -		u64 dpa, hpa = ULLONG_MAX;
> >> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias;
> >>  		struct cxl_region *cxlr;
> >>  
> >>  		/*
> >> @@ -887,11 +905,14 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >>  		if (cxlr)
> >>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
> >>  
> >> +		hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);  
> > 
> > If there is no region, and hence no hpa does it make sense to call this?
> > Particularly as first thing done in this is to dereference cxlr.
> > 
> >   
> >> +
> >>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> >>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> >> -						&evt->gen_media);
> >> +						hpa_alias, &evt->gen_media);
> >>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> >> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> >> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
> >> +				       &evt->dram);
> >>  	}
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);  
> >   
> 
> 


