Return-Path: <linux-acpi+bounces-9242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28D9B94E7
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3041F224D3
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C91BB6B3;
	Fri,  1 Nov 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5zELRtH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200D81ACA;
	Fri,  1 Nov 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477167; cv=none; b=XcJETzJh0Sdu+w8TY4EuUvgLpJaMD+nPXzQ0b5AGFtRPxUCSAqRfEY9oRo83N/RKvzEasN7Wb56a3+fqGn5gN+SjRtxQxVeBeNTG49iOh/2aA0tgtkz/9EUmNJkRzAwxCEqNp02FfKLJkSdq9ynlaDVQo/9S6tsu4OoY4dp7Uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477167; c=relaxed/simple;
	bh=4S+pRg+jKAU5U0sHcwkK0/Iq9498uZZRXnJEb+oAdv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1YNSKkTdrk7qdAgQRHbHvEke+DhFytNjR+mi3WC3OxS+gSR94Sjw1zxvBbz1AqGzPzR06hjo5Q2mpumLpMXkccp7w+dW0ZuFNBOJvUCuHvwWl27ybTb0JEOZO5XTRspyV5tY2zSQtE9EWQnnANeJElupYhCP8NGkhLThsuHEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5zELRtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1221EC4CECD;
	Fri,  1 Nov 2024 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477167;
	bh=4S+pRg+jKAU5U0sHcwkK0/Iq9498uZZRXnJEb+oAdv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5zELRtHls8OA0jW/I9NJV8QWjJ25s4S0RI4BX4gGobl98QHmHNj6seEnbtduRhhV
	 dWzfY1RwUvQxPDeNU710rOM+ApwCThagAjmbno04oYmX0zqhVOGAm5mDfhDB0vtTiB
	 6kziyYtZX6/UcfOpGPcDzifMAsm06Y2F0axjmnb77Z7srcZHAN/+LIP+zvLjZB483J
	 HZQcpn8RNgYY0d7THaCXPeyUYT0sBEnJzaA69GeOh/3ytpkGfYfozenx/mZFkHyT1a
	 ayDJfiy+S6FyOWW8a1djQtUWTqcSe1keIn/JarTwH53P4uES4GTM/YBPBCjm/Yw+ru
	 rEhoCg2PP1bpw==
Date: Fri, 1 Nov 2024 18:02:03 +0200
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
Subject: Re: [PATCH v5 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyT7e3xS2p6DqGYO@kernel.org>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101134706.1185-2-gourry@gourry.net>

On Fri, Nov 01, 2024 at 09:47:03AM -0400, Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be 256MB with a matching alignment. If this size/alignment
> is smaller than the block size, it can result in stranded capacity.
> 
> Implement memory_block_advise_max_size for use prior to allocator init,
> for software to advise the system on the max block size.
> 
> Implement memory_block_probe_max_size for use by arch init code to
> calculate the best block size. Use of advice is architecture defined.
> 
> The probe value can never change after first probe. Calls to advise
> after probe will return -EBUSY to aid debugging.
> 
> On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  drivers/base/memory.c  | 53 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/memory.h | 10 ++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 67858eeb92ed..835793150b41 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -110,6 +110,59 @@ static void memory_block_release(struct device *dev)
>  	kfree(mem);
>  }
>  
> +
> +/* Max block size to be set by memory_block_advise_max_size */
> +static unsigned long memory_block_advised_size;
> +static bool memory_block_advised_size_queried;
> +
> +/**
> + * memory_block_advise_max_size() - advise memory hotplug on the max suggested
> + *				    block size, usually for alignment.
> + * @size: suggestion for maximum block size. must be aligned on power of 2.
> + *
> + * Early boot software (pre-allocator init) may advise archs on the max block
> + * size. This value can only decrease after initialization, as the intent is
> + * to identify the largest supported alignment for all sources.
> + *
> + * Use of this value is arch-defined, as is min/max block size.
> + *
> + * Return: 0 on success
> + *	   -EINVAL if size is 0 or not pow2 aligned
> + *	   -EBUSY if value has already been probed
> + */
> +int __init memory_block_advise_max_size(unsigned long size)
> +{
> +	if (!size || !is_power_of_2(size))
> +		return -EINVAL;
> +
> +	if (memory_block_advised_size_queried)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_size) {
> +		memory_block_advised_size = min(memory_block_advised_size,
> +						size);
> +	} else {
> +		memory_block_advised_size = size;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * memory_block_advised_max_size() - query advised max hotplug block size.
> + *
> + * After the first call, the value can never change. Callers looking for the
> + * actual block size should use memory_block_size_bytes. This interface is
> + * intended for use by arch-init when initializing the hotplug block size.
> + *
> + * Return: advised size in bytes, or 0 if never set.
> + */
> +unsigned long memory_block_advised_max_size(void)
> +{
> +	memory_block_advised_size_queried = true;
> +	return memory_block_advised_size;
> +}
> +
>  unsigned long __weak memory_block_size_bytes(void)
>  {
>  	return MIN_MEMORY_BLOCK_SIZE;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126e..8202d0efbf46 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
>  {
>  	return 0;
>  }
> +static inline int memory_block_advise_max_size(unsigned long size)
> +{
> +	return -ENODEV;
> +}
> +static inline unsigned long memory_block_advised_max_size(void)
> +{
> +	return 0;
> +}
>  #else /* CONFIG_MEMORY_HOTPLUG */
>  extern int register_memory_notifier(struct notifier_block *nb);
>  extern void unregister_memory_notifier(struct notifier_block *nb);
> @@ -181,6 +189,8 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  void memory_block_add_nid(struct memory_block *mem, int nid,
>  			  enum meminit_context context);
>  #endif /* CONFIG_NUMA */
> +int memory_block_advise_max_size(unsigned long size);
> +unsigned long memory_block_advised_max_size(void);
>  #endif	/* CONFIG_MEMORY_HOTPLUG */
>  
>  /*
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

