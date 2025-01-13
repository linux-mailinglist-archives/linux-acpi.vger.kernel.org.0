Return-Path: <linux-acpi+bounces-10551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63CA0B787
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708143A0616
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34F22A4C6;
	Mon, 13 Jan 2025 12:53:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE422AE7E;
	Mon, 13 Jan 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772795; cv=none; b=UA84886UFSIdtY6vCFEtwZjNQbHT0mfudVvBFjwqmYpxegTAr+2Qa9Dy8nX7lidKkEGgHyLPVGWHd8yeSXJHRhrsQLvgaMthrK/yRaT21Zesf1iZyYSBijSROMZ1LZ1NnmWNPBov8Kb9QDKKArHmzA97+rcGBnfMu1MMxT5PmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772795; c=relaxed/simple;
	bh=AA8jZnFmdoGbUCUabODJ9HmGqKlbVQE6we7iGv5E3VU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwV33iCorRo4BnK/zm2pSfctAg/M1DmkcnV0kTc/Ivk+d1laJTrG7F0Mx7zwt3MW2kluZwGEkn6QFjyd5A/02v0JVK0zo3/ip3Hrv904KuKvR0bvhBnKqnfMi8QkDMXaavbRhY7dT539DkVOVMCkLaDXLK/LKHQLn7zRiB75zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWsZm1Vs7z6M4qx;
	Mon, 13 Jan 2025 20:51:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 60FC2140A70;
	Mon, 13 Jan 2025 20:53:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 13:53:09 +0100
Date: Mon, 13 Jan 2025 12:53:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20250113125308.000016f9@huawei.com>
In-Reply-To: <26ca18aa-6f77-4991-8cfd-42262dfa9f1a@intel.com>
References: <20250110151913.3462283-1-dave.jiang@intel.com>
	<20250110151913.3462283-4-dave.jiang@intel.com>
	<20250110163234.00004c6f@huawei.com>
	<26ca18aa-6f77-4991-8cfd-42262dfa9f1a@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 10 Jan 2025 10:27:52 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/10/25 9:32 AM, Jonathan Cameron wrote:
> > On Fri, 10 Jan 2025 08:17:46 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Add the aliased address of extended linear cache when emitting event
> >> trace for DRAM and general media of CXL events.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > I think the value set when there isn't a value differs between no
> > cache and no region. That seems an odd bit of ABI.  Maybe go with ~0ULL in
> > both cases?  
> 
> Not sure I follow. Currently both cases do return ~0ULL.

See inline.  I don't think they do... In the no region case
hpa is ~0ULL, hpa_alias is 0


> 
> DJ
> 
> > 
> > Other than tidying that up this looks fine to me.
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> >> ---
> >> v2:
> >> - Emit hpa_alias0 instead of hpa_alias. (Jonathan)
> >> - Check valid cxlr before dereference. (Jonathan)
> >> ---
> >>  drivers/cxl/core/core.h   |  5 +++++
> >>  drivers/cxl/core/mbox.c   | 33 +++++++++++++++++++++++++++++----
> >>  drivers/cxl/core/region.c | 12 ++++++++++++
> >>  drivers/cxl/core/trace.h  | 24 ++++++++++++++++--------
> >>  4 files changed, 62 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> >> index 0fb779b612d1..afbefc72c8fa 100644
> >> --- a/drivers/cxl/core/core.h
> >> +++ b/drivers/cxl/core/core.h
> >> @@ -30,8 +30,13 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
> >>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> >>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >>  		   u64 dpa);
> >> +int cxl_region_nid(struct cxl_region *cxlr);
> >>  
> >>  #else
> >> +static inline int cxl_region_nid(struct cxl_region *cxlr)
> >> +{
> >> +	return NUMA_NO_NODE;
> >> +}
> >>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> >>  				 const struct cxl_memdev *cxlmd, u64 dpa)
> >>  {
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 548564c770c0..d7999260f004 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -856,6 +856,28 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
> >>  
> >> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
> >> +{
> >> +	struct cxl_region_params *p;
> >> +	int nid;
> >> +
> >> +	if (!cxlr)
> >> +		return ~0ULL;  
> >   
> >> +	p = &cxlr->params;
> >> +	if (!p->cache_size)
> >> +		return ~0ULL;  
> > 
> > So no cache is all 1s. .. See below.
> >   
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
> >> @@ -871,7 +893,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >>  	}
> >>  
> >>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> >> -		u64 dpa, hpa = ULLONG_MAX;
> >> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = 0;  
> > 
> > If I read this right if there is a region but no alias then the hpa_alias is
> > ~0ULL but if there no region it is 0.  Seems a tiny bit inconsistent.

Here you set hpa_alias to 0.

> >   
> >>  		struct cxl_region *cxlr;
> >>  
> >>  		/*
> >> @@ -884,14 +906,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >>  
> >>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
> >>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> >> -		if (cxlr)
> >> +		if (cxlr) {

If no region, nothing changes hpa_alias.

> >>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
> >> +			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
> >> +		}
> >>  
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
> > 
> >   
> 
> 


