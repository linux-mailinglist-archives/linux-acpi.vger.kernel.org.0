Return-Path: <linux-acpi+bounces-8870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8F9A65A0
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 13:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B381F23E36
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC761E1A3F;
	Mon, 21 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jwyiUtm0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D51E1C19
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508299; cv=none; b=gZ8vIXH2XQGZXagyVjoZxxnTZ/XCkzNpuGYRbOTvm4lOPQaZt3b7EjbJD0jJtKyaCSRwHAe2SD1tE1+Ukd+BTYg6iF4iLya4kPPR1kJ6TDWr7FGpx8jUxGMJJSnPqRd5FQWKy7q+x90vp/3lopkTq40XDLK9VASsTumQeiwEP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508299; c=relaxed/simple;
	bh=8RlwJOg8u/l3jZODm2E0opSQYzSt5GQ/wK/ZegBaFwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm8QHnfa0VSei++QahfVMxhZQMqZ3Wr9VFeHuT44d4VcEqRnbGizKNFOG6lgNoVNpLjk7X6oDTjTU1Tw1UsyM9OfEWoAiDMC30EKt4eWpR9CGNuFHJYn7fL41OzbJeUfDuKetf4YzzBOWCYVjcahRPfqbSLpCGPT9Cqn5xfUZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jwyiUtm0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B078340E01A5;
	Mon, 21 Oct 2024 10:58:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mqVSH153HXAU; Mon, 21 Oct 2024 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729508291; bh=daxnWHe1+aEU0Ct2DWQA60OyDK5gaQGD1AxcrKI2wks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwyiUtm0G/HYbK7WOPJulzcin2qE0ZUsgiBlyv+oQ5iJJ846tnt8xVKv7c2kCtO+z
	 LLfmFf4at9o4t1KVCV8tEgf+jrwK15ouiXUaagL3PrV0+Uof8unQn94FjnLq+IBlmz
	 nZCDqSd11IibdrzbVh+nNfTf0GJQ6ZNktc29OovS5b0zjPCZJVxQtfIGkyJyQY9LFr
	 8VD1Ap1DB9V5zh5/6wddnUVHcqluKrwMjeMKnvChHCoMrTGL63MBdRQx8EC1FrSLFH
	 TZ2KDfFLIX7Eg62wIJ2T41Pc88Lhsj0VU1MBYB2pdGVzdv7WBJyK0XyfhBTfxwYcTa
	 OF3DoSQZWizGwBk1Zg5FjaeSjaxDd4sahnKxLK3OtgO4Mw1zaqsUVk12EWlL3d7GMd
	 kWcR5WwtWJ0kOcYHzeXufU5yLdpeYrJ3mxlk4mGt/9AI1Oz1pOe5JDCjaiRXTFCyeP
	 rM69VhLkq+8FzCPbWc8sz1xnczsbK4Bv0He0obmN+u4tEwPhweQQyyX8rzSOm51ZhY
	 8y0rC+DQNAt66NB1j5uksU4TAkErrxEg7KKzPZoZjWSGfBZ1qn11EtItKIZx9SllqS
	 RRvE35d1TEgsl7jKf5R8G4vewosT6ya1hOcfNfkZXultjYbQohnF01dSskzSOtJDeq
	 MT9Kdqqs4Rhn71P78TvmmH68=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EB4540E0169;
	Mon, 21 Oct 2024 10:58:04 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:58:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] CPPC: Use heterogeneous core topology for
 identifying boost numerator
Message-ID: <20241021105803.GEZxYzu3hfAUp2Sblh@fat_crate.local>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003213759.3038862-3-superm1@kernel.org>

On Thu, Oct 03, 2024 at 04:37:59PM -0500, Mario Limonciello wrote:
> Subject: Re: [PATCH 2/2] CPPC: Use heterogeneous core topology for identifying boost numerator

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..d81a6efa81bb 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -691,6 +691,14 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  	return per_cpu(cpu_info.topo.l2c_id, cpu);
>  }
>  
> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
> +enum amd_core_type {
> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,

Why?

Why isn't this the last value in the enum without explicitly enumerating them?

> +	CPU_CORE_TYPE_PERFORMANCE = 0,
> +	CPU_CORE_TYPE_EFFICIENCY = 1,
> +	CPU_CORE_TYPE_UNDEFINED = 2,
> +};

That thing goes...

> +
>  #ifdef CONFIG_CPU_SUP_AMD

... in here.

>  /*
>   * Issue a DIV 0/1 insn to clear any division data from previous DIV

...

> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 015971adadfc..8ad5f1385f0e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1204,3 +1204,32 @@ void amd_check_microcode(void)
>  
>  	on_each_cpu(zenbleed_check_cpu, NULL, 1);
>  }
> +
> +/**
> + * amd_get_core_type - Heterogeneous core type identification
> + *
> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> + * a CPU in the processor.
> + *
> + * If the processor has no core type support, returns
> + * CPU_CORE_TYPE_NO_HETERO_SUP.
> + */
> +enum amd_core_type amd_get_core_type(void)
> +{
> +	struct {
> +		u32  num_processors             :16,
> +		     power_efficiency_ranking   :8,
> +		     native_model_id            :4,
> +		     core_type                  :4;
> +	} props;

So this thing wants to use this stuff here:

https://lore.kernel.org/r/20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com

and add the AMD part to the union. Instead of calling CPUID each time and
adding an ugly export...

> +
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return CPU_CORE_TYPE_NO_HETERO_SUP;
> +
> +	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
> +	if (props.core_type >= CPU_CORE_TYPE_UNDEFINED)
> +		return CPU_CORE_TYPE_UNDEFINED;
> +
> +	return props.core_type;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_core_type);
> -- 
> 2.43.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

