Return-Path: <linux-acpi+bounces-12217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA0A5FBBA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49CC1886ECF
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E12260A4B;
	Thu, 13 Mar 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fazykuw/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E32690E6;
	Thu, 13 Mar 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883341; cv=none; b=XkjmbZm9fN2N58M8DYM00rM1RVnCzI6/Ph27pDD1fbNXRm0yNEuKZyECTQYJW6hUNpBUvnnMKROEQ2Zh0rVzaaEIy0hf3hqtZ7IyQsTnorLFObQLD4gqfRavNmTCFII+vY5i6qFCFlZfkA9FL5e0hwsCou7uVarr4vTzEU8Lq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883341; c=relaxed/simple;
	bh=3Y/eakNnsmh65MrzAH4cER1Z1Z+jb7p5eK8T1XTASY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH3dzKM8eougF7pQJZWq53pPh9aXYqoIs60VZXh6OdjoCzxst8B6DhNZpg9WRt8pxp7XO7JYSCItP+ec6TKBHvKsm/iVcwtok5HyVsqg+qLppu2aL2p8EtSnvEfXtcGZlNEuFNpBKbdCX42xdNy6lzNAJfuSwylnl6TmsSu9mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fazykuw/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741883340; x=1773419340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Y/eakNnsmh65MrzAH4cER1Z1Z+jb7p5eK8T1XTASY4=;
  b=Fazykuw/T0uga3mLbAWmWHU/VtL1Q+Y9H4hduhtbTpeVsuiTQa+hmIj+
   74vK/60P63GqSle+mNqYtVE0ogpMRY5VIktnWSpGVtjK78yLFTTcEBI0j
   fp1qGOaW9LZUWzissv3RuqLHdpL5TlcBuXPZKan2ys4GUPpcULvr7+tJm
   D/21L8GiHlJGFu/ldYA6qVC9ZGqZFUJdqPBSpa15NJfVjhiLbaqayUvNf
   RzUAJDbbzCBjw3thX6KAzwaagzTqVstDevdZc1nDgy0Gac2yjEl4SMLza
   KM4j07V0rTD9fdJnwF/jcgn00+6YILgoiuFoiUtF9h83RhhptY77XdpBj
   w==;
X-CSE-ConnectionGUID: p+BgED3QRYCzzxtwzmTLxA==
X-CSE-MsgGUID: 2uUcfhD0RNym+PqX+0l9wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42897193"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42897193"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:28:49 -0700
X-CSE-ConnectionGUID: 5mNvFJCwSGiCj+4H9GUFsQ==
X-CSE-MsgGUID: 27ex/FQqQ2+R9CovM2FI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="144198762"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.96])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:28:49 -0700
Date: Thu, 13 Mar 2025 09:28:46 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	rppt@kernel.org, haibo1.xu@intel.com, chenbaozi@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9MHvp6GA_iGwfg0@aschofie-mobl2.lan>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>

On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> The absence of SRAT would cause the fake_pxm to be -1 and increment
> to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> ranges that are defined in the CFMWS and not already defined in the
> SRAT, the new node (node0) for the CXL memory would be invalid, as
> node0 is already in "used".
> 
> This utilizes disable_srat() & srat_disabled() to fail CXL init.

Seems like this fixup has drifted from adjusting the fake_pxm to 
shutting down CXL parsing. More below -

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
> 
> Changes in v2:
> - Add disable_srat() when fake_pxm is invalid
> - Add srat_disabled() check in cxl_acpi_probe() and acpi_parse_cfmws()
> 
> 
>  drivers/acpi/numa/srat.c | 10 ++++++++++
>  drivers/cxl/acpi.c       |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..2dac25c9258a 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	if (srat_disabled()) {
> +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> +		return -EINVAL;
> +	}
> +

This goes too far by shutting down cfmws parsing for lack of SRAT.

>  	/*
>  	 * The SRAT may have already described NUMA details for all,
>  	 * or a portion of, this CFMWS HPA range. Extend the memblks
> @@ -646,6 +651,11 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> +
> +	/* Make sure CFMWs fake nodes start at node[1] */
> +	if (fake_pxm < 0)
> +		disable_srat();
> +

How does the code above make sure fake node starts at node[1]?
Would an explicit adjustment like this work?

-       last_real_pxm = fake_pxm;
-       fake_pxm++;
+       fake_pxm = max(fake_pxm, 1);
+       last_real_pxm = fake_pxm--;

>  	last_real_pxm = fake_pxm;
>  	fake_pxm++;
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..e75a8ead99f6 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -829,6 +829,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	/* CXL must be in a NUMA system */
> +	if (srat_disabled())
> +		return -EINVAL;
> +
>  	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
>  	if (!cxl_res)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 

