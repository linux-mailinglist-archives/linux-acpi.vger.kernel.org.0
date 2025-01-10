Return-Path: <linux-acpi+bounces-10518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F2A09789
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB24D188156E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82673207E1A;
	Fri, 10 Jan 2025 16:32:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FE2063E3;
	Fri, 10 Jan 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526761; cv=none; b=RxHVIijqS5gRUbVTOisJ9KH/uKdIEx3mnG+KdARYVPj8XlrPJWguwQFxRP4hWc5eCIWnWhuSz7Xn6h69SQ3FEv4DdVM0eAidw0V5WptXJ0+UHl/hyZzY9bvI/krfsUDUQrESlf323TOSDwZcxXxowRnXSHH8B+jxS9xd5OX3fgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526761; c=relaxed/simple;
	bh=1dpNA0QI0Sdu4au1dF7U1RsGgFMloa+rYy7LkGWF9K8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMswSw2dBn0oZpT4KiZSm4x/quwAz2ZpqsLjQ1cfSdkBsA9p5faGmM4E0Kv1YOcze5HoaNqaaYVvPA7XEtEKujYhNeq5CX8XbHnkYalVMi1tA3EQrrWXBZr+bZoUu0gg837pkioUhYNiaeB+ghY5zwN5twCdWGz2brWaL2J6mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV6bQ4r0yz6M4Kq;
	Sat, 11 Jan 2025 00:30:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D009140A35;
	Sat, 11 Jan 2025 00:32:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 17:32:36 +0100
Date: Fri, 10 Jan 2025 16:32:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20250110163234.00004c6f@huawei.com>
In-Reply-To: <20250110151913.3462283-4-dave.jiang@intel.com>
References: <20250110151913.3462283-1-dave.jiang@intel.com>
	<20250110151913.3462283-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 10 Jan 2025 08:17:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I think the value set when there isn't a value differs between no
cache and no region. That seems an odd bit of ABI.  Maybe go with ~0ULL in
both cases?

Other than tidying that up this looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Emit hpa_alias0 instead of hpa_alias. (Jonathan)
> - Check valid cxlr before dereference. (Jonathan)
> ---
>  drivers/cxl/core/core.h   |  5 +++++
>  drivers/cxl/core/mbox.c   | 33 +++++++++++++++++++++++++++++----
>  drivers/cxl/core/region.c | 12 ++++++++++++
>  drivers/cxl/core/trace.h  | 24 ++++++++++++++++--------
>  4 files changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 0fb779b612d1..afbefc72c8fa 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -30,8 +30,13 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int cxl_region_nid(struct cxl_region *cxlr);
>  
>  #else
> +static inline int cxl_region_nid(struct cxl_region *cxlr)
> +{
> +	return NUMA_NO_NODE;
> +}
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>  				 const struct cxl_memdev *cxlmd, u64 dpa)
>  {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..d7999260f004 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -856,6 +856,28 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>  
> +static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
> +{
> +	struct cxl_region_params *p;
> +	int nid;
> +
> +	if (!cxlr)
> +		return ~0ULL;

> +	p = &cxlr->params;
> +	if (!p->cache_size)
> +		return ~0ULL;

So no cache is all 1s. .. See below.

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
> @@ -871,7 +893,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	}
>  
>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> -		u64 dpa, hpa = ULLONG_MAX;
> +		u64 dpa, hpa = ULLONG_MAX, hpa_alias = 0;

If I read this right if there is a region but no alias then the hpa_alias is
~0ULL but if there no region it is 0.  Seems a tiny bit inconsistent.

>  		struct cxl_region *cxlr;
>  
>  		/*
> @@ -884,14 +906,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
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



