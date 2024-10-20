Return-Path: <linux-acpi+bounces-8865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B19A5331
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Oct 2024 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05762283929
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Oct 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CAB2B9DD;
	Sun, 20 Oct 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me/8UH54"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259251754B;
	Sun, 20 Oct 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729414881; cv=none; b=PO41d2N6Pm9TOFuyJsMiaYANuScEWEi8DYD7tOp41Sbzqih6lX8bkHHTNgc3bRxWoVFeWHhuY6gEDhAwhOuViFwMKGERyWyHpapNFN+zXDeZotPV2S86cc9M/vGrcudFFbbCxpNukAu2IrODk3QiQa0vc4sbo72wY+5lMDfrt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729414881; c=relaxed/simple;
	bh=bNi3UlAVbvyjJRic/L8UHdlKecEsBMV+KKUYX3mNmjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0+Q81px9j+6rofC/QHqz2mUUNPD9ibDo9Sh79eroe3+GBsYfS/P75AEM7as9QoP3A9n+wPREd9Ant689mfMDjXz16HPOvZrumg34j3Xtz9dVU1vihrOtXpjXWghE6C3/cWPvyNVec1i8H3GyI6M9qXyI7qIsrn6V/0wFz67Nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me/8UH54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76D5C4CEC6;
	Sun, 20 Oct 2024 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729414877;
	bh=bNi3UlAVbvyjJRic/L8UHdlKecEsBMV+KKUYX3mNmjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me/8UH54qRnC+ERDPuiR1P7Zp2rZ/4bVI3px3v7Yb+Y9y3meIcbxCccI6W0A8KFL6
	 EO3/2ejVig4WM28hIiIXRwNIzdX3iekW7difUgiZNLBZQpS7vp6pw6mcqFq0g652XP
	 vILbUPh5cG9uVP7G0KDLii2BGUi/zsnQMEMFMTNPR59ml7eA6gYZu5LmsFIwRS5NzS
	 qJjwkS2eX3X083+Z+zZCMzeB8SDasACC1y4EOUFWMGMbByNLMZGKYCOikrJohkF32R
	 yFFNug3+nuDwqDsS9slWoyIww/KwzjfG5JcRoqlk5rA65qllTwXs8w7YwNeyoOgZ5d
	 f/QZxp6KlN7Dw==
Date: Sun, 20 Oct 2024 11:57:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com, david@redhat.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	rrichter@amd.com, ytcoode@gmail.com, haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v2 1/3] mm/memblock: implement memblock_advise_size_order
 and probe functions
Message-ID: <ZxTF93VzRiygScA1@kernel.org>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016192445.3118-2-gourry@gourry.net>

On Wed, Oct 16, 2024 at 03:24:43PM -0400, Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be as small as 256MB with a matching physical alignment.
> 
> Implement memblock_advise_size_order for use during early init, prior
> to allocator and smp init, for software to advise the system as to what
> the preferred block size should be.
> 
> The probe function is meant for arch_init code to fetch this value
> once during memblock size calculation. Use of the advisement value
> is arch-specific, and no guarantee is made that it will be used.

I'm confused.
 
Aren't we talking about memory blocks for hotplugable memory here?
This functionality rather belongs to drivers/base/memory.c, doesn't it?

> Calls to either function after probe results in -EBUSY to signal that
> advisement is ignored or that memblock_get_size_bytes should be used.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/memblock.h |  2 ++
>  mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index fc4d75c6cec3..efb1f7cfbd58 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -111,6 +111,8 @@ static inline void memblock_discard(void) {}
>  #endif
>  
>  void memblock_allow_resize(void);
> +int memblock_advise_size_order(int order);
> +int memblock_probe_size_order(void);
>  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
>  		      enum memblock_flags flags);
>  int memblock_add(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3b9dc2d89b8a..e0bdba011564 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2009,6 +2009,55 @@ void __init memblock_allow_resize(void)
>  	memblock_can_resize = 1;
>  }
>  
> +/*
> + * @order: bit-order describing the preferred minimum block size
> + *
> + * Intended for use by early-boot software prior to smp and allocator init to
> + * advise the architecture what the minimum block size should be. Should only
> + * be called during arch init before allocator and smp init.
> + *
> + * This value can only decrease after it has been initially set, the intention
> + * is to identify the smallest supported alignment across all opinions.
> + *
> + * Use of this advisement value is arch-specific.
> + *
> + * Returns: 0 on success, -EINVAL if order is <=0, and -EBUSY if already probed
> + */
> +static int memblock_sz_order;
> +#define MEMBLOCK_SZO_PROBED (-1)
> +int memblock_advise_size_order(int order)
> +{
> +	if (order <= 0)
> +		return -EINVAL;
> +
> +	if (memblock_sz_order == MEMBLOCK_SZO_PROBED)
> +		return -EBUSY;
> +
> +	if (memblock_sz_order)
> +		memblock_sz_order = min(order, memblock_sz_order);
> +	else
> +		memblock_sz_order = order;
> +
> +	return 0;
> +}
> +
> +/*
> + * memblock_probe_size_order is intended for arch init code to probe one time,
> + * for a suggested memory block size.  After the first call, the result will
> + * always be -EBUSY. A late user should call memory_block_size_bytes instead to
> + * determine the actual block size in use.
> + *
> + * Should only be called during arch init prior to allocator and smp init.
> + *
> + * Returns: block size order, 0 if never set, or -EBUSY if previously probed.
> + */
> +int memblock_probe_size_order(void)
> +{
> +	int rv = xchg(&memblock_sz_order, -1);
> +
> +	return (rv == -1) ? -EBUSY : rv;
> +}
> +
>  static int __init early_memblock(char *p)
>  {
>  	if (p && strstr(p, "debug"))
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

