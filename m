Return-Path: <linux-acpi+bounces-9054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4119B37AA
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D506E28261D
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285A1DE8BC;
	Mon, 28 Oct 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DilTPWI2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9441DE4D1;
	Mon, 28 Oct 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136679; cv=none; b=spKtT/S0OqX8EJGnpOVdc1lUHWgi7G1YQ4WaB50YJSBGAnH8p3YfRop9Qy19UD1P8iFX16J5PRocVGbGqp0IWgv5Su+zFXG5a8CiZcQBETcAJ4NY3RAQesb27WqxqX/5SoLMSiZjOb0LaM3HP1ns8ixWU8rBW3kHskoaOvaLNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136679; c=relaxed/simple;
	bh=RW3lMh/hj64PO7Sxfncf66yFZBftog/9Sb9K431heYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuqAv06Ue86D784ElbVuZ0Ync3SRk+/OIb9CmO+H5VBCx+8eDlNvcWfoifqvYO+X3Rne9tdocXJFSp9aUmk715vlVUfHM8X7JtxOA6mAmkyg20b4j6OKPYKKP+j2iKCo9gfCFoq9wgFIv3PaM7D9oIaNMCnaWT+Uero90Zv2yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DilTPWI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4873EC4CEC3;
	Mon, 28 Oct 2024 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136679;
	bh=RW3lMh/hj64PO7Sxfncf66yFZBftog/9Sb9K431heYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DilTPWI2rFgKWdJkDIDILeTnqKWiYmCXqWlmb54U6CJf8qTHZG7M+r6aRuSON/xE/
	 j2SBn7YoNdGJlf6/tm5g4S+P46+f3B7MDcjGb2dYnqkOwgsX7cmojrKu+dhc7jZObe
	 /ssvsoriqq/SeLAZCqUIMMrZjbPGDlPJhf3Ll6eSJQRHzh2A/gkb8t6WIqiw/HYh3K
	 r8mymXC0YzRE8HzAAeU9r6SJrJtiYmdcuKTlzPCabdY5yoye0XK3SGLZUzZOV8M/gR
	 3MtR2Vlgj9jVkkfzVJE/zAx3eosYhNyyuM+A8js5cNEtUdYEQqKXGaqAp5zve5MES0
	 QvS50wM/odG7A==
Date: Mon, 28 Oct 2024 19:27:21 +0200
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
Subject: Re: [PATCH v3 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <Zx_JeZcugENuStCd@kernel.org>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213450.15041-2-gourry@gourry.net>

Hi,

On Tue, Oct 22, 2024 at 05:34:48PM -0400, Gregory Price wrote:
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
>  drivers/base/memory.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/memory.h | 10 ++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 67858eeb92ed..a0fd9e1451aa 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -110,6 +110,49 @@ static void memory_block_release(struct device *dev)
>  	kfree(mem);
>  }
>  
> +/*

If the intention for this to be a kernel-doc comment it should start with
/**, should be placed right before the documented function and start with a
brief function description

> + * @size: suggestion for maximum block size. must be aligned on power of 2.
> + *
> + * Early boot software (pre-allocator init) may advise archs on the max block
> + * size.This value can only decrease after initialization, as the intent is to
> + * identify the largest supported alignment for all sources.
> + *
> + * Use of this value is arch dependent, as is min/max block size.
> + *
> + * Returns: 0 on success
> + *	    -EINVAL if size is 0 or not pow2 aligned
> + *	    -EBUSY if value has already been probed
> + */
> +static size_t memory_block_advised_sz;
> +static bool memory_block_size_probed;
> +int memory_block_advise_max_size(size_t bz)

size seems to me a better parameter name :)

> +{
> +	if (!bz || (bz & (bz - 1)) != 0)

we have is_power_of_2()

> +		return -EINVAL;
> +
> +	if (memory_block_size_probed)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_sz)
> +		memory_block_advised_sz = min(bz, memory_block_advised_sz);
> +	else
> +		memory_block_advised_sz = bz;
> +
> +	return 0;
> +}
> +
> +/*

should it be kernel-doc?

> + * memory_block_probe_max_size provides a suggested maximum memory block
> + * size value. After the first call, the value can never change.
> + *
> + * Returns: advised size in bytes, or 0 if never set.
> + */
> +size_t memory_block_probe_max_size(void)
> +{
> +	memory_block_size_probed = true;
> +	return memory_block_advised_sz;
> +}
> +
>  unsigned long __weak memory_block_size_bytes(void)
>  {
>  	return MIN_MEMORY_BLOCK_SIZE;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c0afee5d126e..47c00d6e1165 100644
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
> +static inline size_t memory_block_probe_max_size(void)
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
> +size_t memory_block_probe_max_size(void);
>  #endif	/* CONFIG_MEMORY_HOTPLUG */
>  
>  /*
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

