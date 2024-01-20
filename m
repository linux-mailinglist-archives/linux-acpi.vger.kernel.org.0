Return-Path: <linux-acpi+bounces-2956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8618332A5
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jan 2024 04:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C596F1F21E2F
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jan 2024 03:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3C10F8;
	Sat, 20 Jan 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rlbokw1B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D010E1;
	Sat, 20 Jan 2024 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705722962; cv=none; b=bC6OtRlaGvxfbCYr9fbTgpO73M8J36AxPndop3PPXxaG/jjt//wQard7KxyLNoHFiURCQSde6lhJ6ymhxG4W1qcwpq+niK9DwqSpveQf3FcTf7EVJKoEcCyx6ZrXleN2kVpcUlIqealorLENetSQmecEeMiLtFzvDOCXxTd1W9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705722962; c=relaxed/simple;
	bh=pGB5nmxhFnbdZLUKVfuwMI8Dc5xK3iJrSQJUO+WIC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwbD3xRVwITg12okQ4mlWZCQcaOh6kiwpr1EzYnG6WVHOb80xG0Teze2Lhonkq23QsvWxsuUdRb9fQg6LHYnDwrBxD8TbN/Zz4bCAtP/T8JxTsnw0lXejpO2a5mGo1XulmZl3+4QeXxiYV3//QOZWndvKMv+tel1DbEJfIas0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rlbokw1B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705722960; x=1737258960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pGB5nmxhFnbdZLUKVfuwMI8Dc5xK3iJrSQJUO+WIC0M=;
  b=Rlbokw1B22Yu/jbOPhcgqQMwfAWlMqB+lRxXSxw/JtH0Gd8JuBl3v8mb
   ddfE+353Cd9SzE/WfpWNinWAUpQVnkQStuvwc8oR9uiKt8dIQSXPS+3Ke
   a44yj/uGMh2nfzYbt/ki00JYk+51I0NTFEc4gSuLwwg59hWG8RDkPPnzP
   6OWzdhKqNZgYRPV7Juf6z9czOdk3p3ZeaXs125M60RZvvblzF+5M+7Iak
   dLZBj1oj2Y631T+jj0mO9+6+xF6G4dh2Wl1OkTefwEF5EnmBPxEPjvXRa
   DpdsqwsGJ5LRio3s9/mH3eZwRgTa6saoCe/Uj6CLCQfx6LyuBwgK54b98
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="8007174"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="8007174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 19:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="33559693"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 19:55:57 -0800
Date: Fri, 19 Jan 2024 19:55:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net,
	brice.goglin@gmail.com, nifan.cxl@gmail.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 11/11] cxl: Deal with numa nodes not enumarated by SRAT
Message-ID: <ZatES+jZFfdfNowf@aschofie-mobl2>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
 <170568505106.1008395.11049680010287891282.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170568505106.1008395.11049680010287891282.stgit@djiang5-mobl3>

On Fri, Jan 19, 2024 at 10:24:11AM -0700, Dave Jiang wrote:
> For the numa nodes that are not created by SRAT, no memory_target is
> allocated and is not managed by the HMAT_REPORTING code. Therefore
> hmat_callback() memory hotplug notifier will exit early on those NUMA
> nodes. The CXL memory hotplug notifier will need to call
> node_set_perf_attrs() directly in order to setup the access sysfs
> attributes.
> 
> In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
> stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
> check if a NUMA node id is defined by SRAT or created by CFMWS or some
> other methods.

I'm thinking the 'or some other methods' can be dropped. In chat,
we mentioned emulated nodes, but they don't make PXM assignments.
Maybe I misunderstand, but I thought NUMA emulation can only be
enabled when there is no physical NUMA architecture.

Aside from clearing up the emulated or other nodes story...LGTM.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> for a node. The sysfs path of
> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> to the NUMA node of the CXL region.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/srat.c  |   11 +++++++++++
>  drivers/base/node.c       |    1 +
>  drivers/cxl/core/cdat.c   |    5 +++++
>  drivers/cxl/core/core.h   |    1 +
>  drivers/cxl/core/region.c |    7 ++++++-
>  include/linux/acpi.h      |    1 +
>  6 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..2f6f15b3891d 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -29,6 +29,8 @@ static int node_to_pxm_map[MAX_NUMNODES]
>  unsigned char acpi_srat_revision __initdata;
>  static int acpi_numa __initdata;
>  
> +static int last_real_pxm;
> +
>  void __init disable_srat(void)
>  {
>  	acpi_numa = -1;
> @@ -536,6 +538,7 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> +	last_real_pxm = fake_pxm;
>  	fake_pxm++;
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>  			      &fake_pxm);
> @@ -547,6 +550,14 @@ int __init acpi_numa_init(void)
>  	return 0;
>  }
>  
> +bool acpi_node_backed_by_real_pxm(int nid)
> +{
> +	int pxm = node_to_pxm(nid);
> +
> +	return pxm <= last_real_pxm;
> +}
> +EXPORT_SYMBOL_GPL(acpi_node_backed_by_real_pxm);
> +
>  static int acpi_get_pxm(acpi_handle h)
>  {
>  	unsigned long long pxm;
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index b4a449f07f2a..8d0b09769b77 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>  
>  /**
>   * struct node_cache_info - Internal tracking for memory node caches
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 3556c897ece4..7d7163f999e8 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -626,3 +626,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  {
>  	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
>  }
> +
> +bool cxl_need_node_perf_attrs_update(int nid)
> +{
> +	return !acpi_node_backed_by_real_pxm(nid);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e19800a7ce06..bc5a95665aa0 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -92,5 +92,6 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>  
>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
> +bool cxl_need_node_perf_attrs_update(int nid);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae1f34e1cd05..66f126067bda 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3084,7 +3084,12 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
> +			rc = 0;
> +			if (cxl_need_node_perf_attrs_update(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
> +
>  			if (rc == 0)
>  				cset++;
>  		}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c664948b2ae..3067c6aad431 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -447,6 +447,7 @@ static inline int hmat_update_target_coordinates(int nid,
>  #ifdef CONFIG_ACPI_NUMA
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +bool acpi_node_backed_by_real_pxm(int nid);
>  
>  /**
>   * pxm_to_online_node - Map proximity ID to online node
> 
> 

