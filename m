Return-Path: <linux-acpi+bounces-9244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E39B94EC
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 17:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817921C20DE2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C121C7B6F;
	Fri,  1 Nov 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDyiwIPV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFDC186E40;
	Fri,  1 Nov 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477228; cv=none; b=XdvEYz7GfiBOIKgwJF/c7q4vU03HRN2EhsMLmrtN/WJ8+Xuv7PxBacTy0Aaow7kuZispglParHZdC+16aRHZwB/LHsdbGieT2T6kw8rrSKw/UCQcEtme2ZEIp4gcYORJXR/NCuuPR+2rcdlwm9COGkIBAbRObHz9tnlPDwNCWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477228; c=relaxed/simple;
	bh=puI0SDs+qW0sm7zOSrd3QmW6U6V6nJKwF+V/Ey016WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY9plZ8FzLrbyyX4mXcdd/qL89zVaKQWh9jVyFkMPFM2u9Th7mAP91PpRtMR2Zrf8H7f6Uvx0rJ2/tvAv3MyIwnqPXf6/oHyw6RyGFGh64WxjxtObOXDOr2OWiwyFi4+CejEEHLPRcBJXT7p4d7DTftComph2TKdZnmMHPQ1LQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDyiwIPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C7AC4CECD;
	Fri,  1 Nov 2024 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477227;
	bh=puI0SDs+qW0sm7zOSrd3QmW6U6V6nJKwF+V/Ey016WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDyiwIPVC+I0nepW1fG1JKltB1CDBSghPhStdMSDm3fSS1h4EYVT7zmYznBKN8cdQ
	 0HATH/bViuo8VFAwcd4LEv/8SVwknLLhAM5/oC2xitEW26DiRlgDbM1k4xhtJEUO12
	 Sb18c6Aq+tCK57mEyQ36LH+AvqZdYdTp5M1htgSLxZ8oABFvrJut73RH8KEYGtoDcG
	 FRyfBxx8pdeBb76UIR0lOKwpiq5b8OdCXpxGPJ9Xz/g43jHzqSoHNm3D0Fbls8akED
	 35bn2xh0gnSSBcYWCucb3JZmSGGr5cxanroAWQDN93Qb+K72jt+e2tCZt2Wj8NyO7t
	 4L1wXfBiK/83g==
Date: Fri, 1 Nov 2024 18:03:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v5 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZyT7ttLG-_eGMDmx@kernel.org>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-4-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101134706.1185-4-gourry@gourry.net>

On Fri, Nov 01, 2024 at 09:47:05AM -0400, Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  drivers/acpi/numa/srat.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 44f91f2c6c5d..34b6993e7d6c 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/acpi.h>
>  #include <linux/memblock.h>
> +#include <linux/memory.h>
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> @@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  {
>  	struct acpi_cedt_cfmws *cfmws;
>  	int *fake_pxm = arg;
> -	u64 start, end;
> +	u64 start, end, align;
>  	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	/* Align memblock size to CFMW regions if possible */
> +	align = 1UL << __ffs(start | end);
> +	if (align >= SZ_256M) {
> +		if (memory_block_advise_max_size(align) < 0)
> +			pr_warn("CFMWS: memblock size advise failed\n");
> +	} else {
> +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> +	}
> +
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
>  	 * or a portion of, this CFMWS HPA range. Extend the memblks
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

