Return-Path: <linux-acpi+bounces-12033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAAA5A1CB
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D600B7A618A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627A233735;
	Mon, 10 Mar 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoAgzEgV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E57230BF9;
	Mon, 10 Mar 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630417; cv=none; b=Wm2y0f5avb0/B0l9axvvpEOVJj5FfjnRtRv5lAopdXHPqYusjspA6YPe34rtwUVXu+Pny4vn/sLuNuTr7lvZIgDiJ6D4gCKwZzyjIOttUf4tG8n+mocg9hkEPXNlaE2Dv2gCtH/ljHOYAa1pJ/Tx7R4T+pteTn+NHxVeazctNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630417; c=relaxed/simple;
	bh=pkpqewpbgxEh7ma1+ZejMEFp24f6ykqtKcqE2J2ebB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8z6boHdl0tgs0Q70AR4d0prAShYwixr3IoNDtBkzVQdybReDrBkliKu8e0lid7UuSWZ69nzPYQaawAIv54OJOZQiXjnNXxeBdxT5jdNPBx3yLQFfE6xJJAnrIS2RwDK1be1aAHTzpoFJl5nE/pMdi3ZhCquryiRfKAEjicAXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoAgzEgV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741630415; x=1773166415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkpqewpbgxEh7ma1+ZejMEFp24f6ykqtKcqE2J2ebB8=;
  b=QoAgzEgVrvc6fZAKwM/BNI+9BcMFlLRO0b7q/TiqQCyTAufdY6YvN3N2
   WdHU/PjIUCOi1zr4uaUBNedCY/I+cNqBBMZcIkIZNex1lCSkHc+fLyx7R
   l4U7f+H47x2m1tbvVWpBu2X1/jz3R/rLWRLqwxV0IEKd+0rDXzpa9i6Fe
   C+kL3EvoWJhIVNFA/3cAOovDP9psxQpl1WgzrbNhHANEIeMa5TFQSbIZR
   C6K5nAX4PnvSVpiTvmsyjWR0vhDdXPyIjIMauRYj+W1hVrdoDxTCcE6fy
   FYdRN0edZVjjr+IBuAGpqQ8HbAlo2kZS1aN6A5PqWmUvZqengRgwxV6XU
   w==;
X-CSE-ConnectionGUID: LFUih3/rTBGc5YT10APZWg==
X-CSE-MsgGUID: vXgFkblaTguyBUiXD2qRkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46425212"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46425212"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:13:34 -0700
X-CSE-ConnectionGUID: DKAOwpsiSKyJIe7vibJd5w==
X-CSE-MsgGUID: GyCPBIdNTE2zQ9gTGDxp0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119999632"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.66])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:13:35 -0700
Date: Mon, 10 Mar 2025 11:13:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rafael@kernel.org, lenb@kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, dave.jiang@intel.com, rppt@kernel.org,
	gourry@gourry.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z88rzKHrqlCXQOTb@aschofie-mobl2.lan>
References: <20250310093910.1752126-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310093910.1752126-1-wangyuquan1236@phytium.com.cn>

On Mon, Mar 10, 2025 at 05:39:10PM +0800, Yuquan Wang wrote:
> The absence of SRAT would cause the fake_pxm to be -1 and increment
> to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> ranges that are defined in the CFMWS and not already defined in the
> SRAT, the new node (node0) for the CXL memory would be invalid, as
> node0 is already in "used".


If no SRAT or bad SRAT, then all memory is at node:0, and first fake
node for CFMWs should start at 1. Right?

If so, might it be safest to always start the the CFMWS fake nodes at
at a minimum of node[1]. Maybe srat_disabled() can be used to decide.

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/acpi/numa/srat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..eb8628e217fa 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -646,6 +646,9 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> +	if (fake_pxm == PXM_INVAL)
> +		pr_warn("Failed to find the next unused PXM value for CFMWs\n");
> +

How come it is sufficient to just warn?
As per my comment above, can we adjust?



>  	last_real_pxm = fake_pxm;
>  	fake_pxm++;
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> -- 
> 2.34.1
> 

