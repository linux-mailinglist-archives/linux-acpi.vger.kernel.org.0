Return-Path: <linux-acpi+bounces-9243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E857E9B94EA
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC38B283FEF
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0941C7B6F;
	Fri,  1 Nov 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peaNE9x+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C301BB6B3;
	Fri,  1 Nov 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477198; cv=none; b=Wr+qWn41v7s0Cm4cuYZ5F9stOJg5gY0OC8YOkhjAV0n3eY5GUVx2c88FkA9n/GH4epyzPNcjVy9dsiCua110ZyhLohzE/CgQ3JUFcByom4ghMsEf64aZNscZD/ncikKhrr2Vac9f6ioL5r5k1GPeoxHMdmzLL+AYcVx8BSYQJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477198; c=relaxed/simple;
	bh=YdyDW2gcScZ/BdqJfnTtYadsfL8y75bS0poEUfdXiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfRC4WrkzOXwSBXB7fabGsJn0NoGkG/xNZwhi7gai6+UxD2/PbsuaQh5rddpd0g71ecQZlWHRWqUZ/CtED4fhtdO+VtYMJXAKEkx2KygGsSvm4bK+Qr5VgLUXYENGdlwLTNP6WXv+mPL8woeJZGQVp/qY+Armm0+NzYk/6V6OGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peaNE9x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B135C4CECD;
	Fri,  1 Nov 2024 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477197;
	bh=YdyDW2gcScZ/BdqJfnTtYadsfL8y75bS0poEUfdXiUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peaNE9x+uUJuwo6gX2ZdWtag2VzEWukSKKq6/Q6bJa4yKYnZXKotkurQAfcW8FEmT
	 m65zJDr/cHp4Bfc3L5cbJgBEj8x3vIISQyvRQ8VEPw7U8WqKOykKzvg3bT/0rfc+iy
	 oFcEKy2T12/LpWThDDEYlcMIdt4uDmFLFy/quQntzXAB8aD2yA7nW/i4GSrDhe3yAV
	 OBm5HE58IbELIOvshb7bOguI8YMLLl6Juyq2tb+9HweY3rH1gRHrsEaDQLgwgPDzLD
	 5CZrKERAhofgk+shQAZW1BxLwoJvwWesV/0wnTK3DqPO3fwFG6du+q39UMOv3DVP1n
	 +DkHfA4PAFBuQ==
Date: Fri, 1 Nov 2024 18:02:32 +0200
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
Subject: Re: [PATCH v5 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <ZyT7mPPP1rxVJtxC@kernel.org>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101134706.1185-3-gourry@gourry.net>

On Fri, Nov 01, 2024 at 09:47:04AM -0400, Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) if no hotplug advice: Max block size if system is bare-metal,
>    otherwise use end of memory alignment.
> 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/x86/mm/init_64.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..f1a495e998ce 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
>  	}
>  
>  	/*
> -	 * Use max block size to minimize overhead on bare metal, where
> -	 * alignment for memory hotplug isn't a concern.
> +	 * When hotplug alignment is not a concern, maximize blocksize
> +	 * to minimize overhead. Otherwise, align to the lesser of advice
> +	 * alignment and end of memory alignment.
>  	 */
> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +	bz = memory_block_advised_max_size();
> +	if (!bz) {
>  		bz = MAX_BLOCK_SIZE;
> -		goto done;
> +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +			goto done;
> +	} else {
> +		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
>  	}
>  
>  	/* Find the largest allowed block size that aligns to memory end */
> -	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> +	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
>  		if (IS_ALIGNED(boot_mem_end, bz))
>  			break;
>  	}
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

