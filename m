Return-Path: <linux-acpi+bounces-9197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A09B7CFC
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E52C28189A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2661A073F;
	Thu, 31 Oct 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzERKkIR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920219DF99;
	Thu, 31 Oct 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385307; cv=none; b=YeFMOElMj5F7DFSqHuZpSF7y4vBVRl64VfqogF3oy4SJGB3Bgqlo5gnCqgkAasfW/mSeeu82Nsc+rtkMM+ml+jh+J3gUmwg5VoFDgVHmo5O+5tm2B3iAErhqeftF1CYSgLMswcbuuBRbNDT5f1Aos+ULftLG8KknzxbPWDYNiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385307; c=relaxed/simple;
	bh=908GH7IBG1XfA0L7MNM6eq8gsxx7GOrv1X37ET8DUyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ0VvXxEUGkrJyO4bOPGNnUZUQA/9/2U0NOJaX8Y0Lc1D9KWE/vVv144CMm/uZgREIVaxrfq0fGitNMXxYq2B5GkKxxhfjgILW1DJuGAd6wVHYAXCBmgET98XFGehKiwljRR0e0QuA1DSSGq6l9pCkPMPKlgUayNp9KWnLiAgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzERKkIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EEAC4AF1B;
	Thu, 31 Oct 2024 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730385306;
	bh=908GH7IBG1XfA0L7MNM6eq8gsxx7GOrv1X37ET8DUyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzERKkIRwC/O4kQ8lXH0L4xaw8lcCpG9teRlnbXLQORdNS/jid5oXobAIqrFBvnMj
	 8TavotafNAjfch6gf0LzZd7t4y0STCY6OrBp4+pmufLdZw1Fob2IJ4RKCx1QlAfwV9
	 igjdjueqvbXLikgcF2avFhhxK4GjtzcQFneRgzqKo5j+kDvdftzhJhDxhFK67/RAo3
	 ZZnTPKmuxzBoEiw+4Nr6Ej07BMw2Avy0n+cNU0B+udrtpRzcAdUbRXmmbF8dH36io5
	 ZNTxQC63JDz1vnx9yl/KoBYUc48LeRNVURbhd+I75R8XMmmDJU2+T05l6ZtsAZv4qg
	 xvwr8D+8DX0Bg==
Date: Thu, 31 Oct 2024 16:31:03 +0200
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
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyOUp5Juz5x3Ivrn@kernel.org>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029202041.25334-2-gourry@gourry.net>

On Tue, Oct 29, 2024 at 04:20:39PM -0400, Gregory Price wrote:
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
> ---
>  drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/memory.h | 10 +++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 67858eeb92ed..099a972c52dc 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
>  	kfree(mem);
>  }
>  
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
> +static size_t memory_block_advised_sz;
> +static bool memory_block_advised_size_queried;

kernel-doc will be unhappy about variable declarations between the doc
block and the function it describes

> +int memory_block_advise_max_size(size_t size)
> +{
> +	if (!size || !is_power_of_2(size))
> +		return -EINVAL;
> +
> +	if (memory_block_advised_size_queried)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_sz)
> +		memory_block_advised_sz = min(size, memory_block_advised_sz);
> +	else
> +		memory_block_advised_sz = size;
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
> +size_t memory_block_advised_max_size(void)
> +{
> +	memory_block_advised_size_queried = true;
> +	return memory_block_advised_sz;
> +}
> +
>  unsigned long __weak memory_block_size_bytes(void)
>  {
>  	return MIN_MEMORY_BLOCK_SIZE;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126e..07e20a77b717 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
>  {
>  	return 0;
>  }
> +static inline int memory_block_advise_max_size(size_t size)
> +{
> +	return -ENODEV;
> +}
> +static inline size_t memory_block_advised_max_size(void)
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
> +int memory_block_advise_max_size(size_t size);
> +size_t memory_block_advised_max_size(void);
>  #endif	/* CONFIG_MEMORY_HOTPLUG */
>  
>  /*
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

