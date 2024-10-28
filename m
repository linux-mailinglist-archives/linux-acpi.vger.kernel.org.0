Return-Path: <linux-acpi+bounces-9052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844019B37A4
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D9FB20E78
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79F1DEFEE;
	Mon, 28 Oct 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT3xRtho"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0C1DD533;
	Mon, 28 Oct 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136537; cv=none; b=gFTyMBl1vhfxyU97JyN/P3X+N3DQ5bALJHRODT4Nv3Is3+W18BodOYUXT+J9X/4n6ur5XW/lDY43AnjjSVVtxMg31V+xaex3qI8HyRemkUTsZIATmn2V0saZ93EzIEWwg9PzUcCWYeKz3NM24aElF361LEGurXHorVGn0q/Z1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136537; c=relaxed/simple;
	bh=GMw9tnIqWm+cDbQ2JkNYh5ueM+04Z5tH7xQN/ccSh5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU8Ib8iN00Ky1PQ8V7qsAraa7jyqpc0Hx193bPNHPM0S94UHay+k8iPQoh2xmkHYb04U/7ePgp5jWx6aA9YqZaJnOv08G39e+dfOExB0rn/M65hAT4EL9ZBTNK3Qh68xk/8YSfRp5mEd2gDaA4tK9znaZDpT9DZ0OT0fMwwVSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT3xRtho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E37C4CEC3;
	Mon, 28 Oct 2024 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136537;
	bh=GMw9tnIqWm+cDbQ2JkNYh5ueM+04Z5tH7xQN/ccSh5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT3xRtho1COzvSIOKQ/DHwqhHI8WdIzYDPMeDHykv1W41JcyXeKtj8lrwTEmKOLHJ
	 S8veFLIU1f9GOWpAGSGNubqH7/bda9doKyx0ezzIhz5ZKDEzB5NbDnnXuce3zw3fjL
	 ZTtlM49KXRqpsegh0Y4QxZZGL8T0hvurAN0ThaKmKeoDzFwYHSISRBPEiO+6eYsqsB
	 boLj8ue2yCIk4Bbplv9CgaaxEHyjZ98fZR0O/MBZsMkQvZH/OKmuPpwCc4/5dsEySZ
	 ywdQrCi552PYCON4EWI2l9MsLovmXRUnPsnUrXs5i0RwOmCHq452fKcN6rCWS4Jpq4
	 bxmP9GRDxhZBg==
Date: Mon, 28 Oct 2024 19:24:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <Zx_I5vPrXmZhQNj0@kernel.org>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-4-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213450.15041-4-gourry@gourry.net>

On Tue, Oct 22, 2024 at 05:34:50PM -0400, Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> After the alignment, the acpi code begins populating numa nodes with
> memblocks, so probe the value just prior to lock it in.  All future
> callers should be providing advice prior to this point.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/acpi/numa/srat.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 44f91f2c6c5d..35e6f7c17f60 100644
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
> @@ -333,6 +334,29 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +/* Advise memblock on maximum block size to avoid stranded capacity. */
> +static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
> +				   void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> +	u64 start = cfmws->base_hpa;
> +	u64 size = cfmws->window_size;
> +	unsigned long bz;

Maybe unsigned long size?

> +
> +	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
> +		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
> +			break;
> +	}
> +
> +	if (bz >= SZ_256M) {
> +		if (memory_block_advise_max_size(bz) < 0)
> +			pr_warn("CFMWS: memblock size advise failed\n");
> +	} else

Nit: braces needed for else arm as well

> +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> +
> +	return 0;
> +}
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -545,6 +569,15 @@ int __init acpi_numa_init(void)
>  	 * Initialize a fake_pxm as the first available PXM to emulate.
>  	 */
>  
> +	/* Align memblock size to CFMW regions if possible */
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, NULL);
> +
> +	/*
> +	 * Nodes start populating with blocks after this, so probe the max
> +	 * block size to prevent it from changing in the future.
> +	 */
> +	memory_block_probe_max_size();
> +

It won't change, but how drivers/base/memory.c will know about the probed
size if architecture does not override memory_block_size_bytes()?

>  	/* fake_pxm is the next unused PXM value after SRAT parsing */
>  	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
>  		if (node_to_pxm_map[i] > fake_pxm)
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

