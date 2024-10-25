Return-Path: <linux-acpi+bounces-8959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E989B0484
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CED2284B62
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB281D54E1;
	Fri, 25 Oct 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wm244Aud"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71651632E2;
	Fri, 25 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864292; cv=none; b=c4fPMGLOzFi5gOc2/wPjN5DXWRFEQP04tViTj00y449vkGCfG6l+2WX4z27glbeotqcgyk/J+yaAbrPV5bm5cBLYkernWMCFaB2VXzHVATkE0U+7Lc3zs0TjS839rhmuOHP9keWXp7L83EjdMK3ZZhpGQNngcDEWXwYG//nCQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864292; c=relaxed/simple;
	bh=/9gpRT1rrvW3/WnQ2D+/OotZc6CUH9P9u7DC+yvQo0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTXI9+x3g+Tzwfo78ev8X/oNX0IKmVT8CR3z97jQargA8nW20ggDVOuSayUV/AjxSNaL7o9nEFmmiPsLkRbOqys5RllYYojdfAVvhNEYjXbbp8migWQAurW90tqS6Fh/MCN1OVRF0DOWkDedhNL6Qs5fD9142PMAbsAX4xHbyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Wm244Aud; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6566540E0285;
	Fri, 25 Oct 2024 13:51:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id psED-3lxfWbY; Fri, 25 Oct 2024 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729864284; bh=m0hkEZxpeJr7ugV2LE9WQ9YG0cnThgfQkWBRiVT0HMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wm244Audxi0pyKbQM9vE0pe6KwRVFb93PK0Zg+Fxr1VAf3KSQ8wtBi06quKksUluq
	 uxRcfYbIJxe00xpsK9IStHxk4IoJUnLCUdkMvZ3EmDLD3soCdwP3ggqMTnXeu+fc6H
	 9exfXwEIpzOZ2FuyX/QLOZVGAQ8T95lMQeUpxyuaC2OJDB9yNSSREUOz9fkGsFOnxP
	 v1Tx/mJcktzJq4y0TYMBI3nWT6e3p9+XiVFI5a/gZX3Bsewj0PQshljp1yxdN7xP9G
	 YQg7GLDwXYZLThYCfXpMWaqMNctPrwIVsYFKuSrrm6pRNF/XcQryLJXveRvabr38JG
	 YieXVOkuggdCrZZJ6aycV9fILCwLzsfvkOQvr2CVHAyk9BmeE0nOpE5Zl1tRw3q/rW
	 cWSi7riAOf0WxK4csFkozcblzWp4CAixYHc04aEoQfgA1pWhhyo9R3K02WeYsQbrg9
	 Gk18qzVWHs/lOtkjnzU49+WUcBbQIJrG5DUIwqlFnZc44TnNuzJWMafPF9ODnPwDDW
	 Qund2KTfFNDvJKlzO7JJIlSlgdfamjOYgY0UEHpJ+QUGrzP8mqREijha5iTeKLN6T9
	 r0vLJd2BbrlX/Z5I8AzezUjKPzivCKlmY2ylEzFHXHE1+HPbBjEiLTGGA9xmCT0rgA
	 O0gpo5AlblMIMalCkfk94944=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ED2640E0284;
	Fri, 25 Oct 2024 13:51:08 +0000 (UTC)
Date: Fri, 25 Oct 2024 15:51:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v3 5/5] x86/amd: Use heterogeneous core topology for
 identifying boost numerator
Message-ID: <20241025135107.GPZxuiS38_s3KWe8xj@fat_crate.local>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
 <20241023174357.34338-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023174357.34338-6-mario.limonciello@amd.com>

On Wed, Oct 23, 2024 at 12:43:57PM -0500, Mario Limonciello wrote:
>  int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  {
> +	enum x86_topology_cpu_type core_type = get_topology_generic_cpu_type(&cpu_data(cpu));
>  	bool prefcore;
>  	int ret;
> +	u32 tmp;
>  
>  	ret = amd_detect_prefcore(&prefcore);
>  	if (ret)
> @@ -261,6 +263,27 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  			break;
>  		}
>  	}
> +

What's the difference between this case:

> +	/* detect if running on heterogeneous design */
> +	switch (core_type) {
> +	case TOPO_CPU_TYPE_UNKNOWN:
	     ^^^^^^^^^^^^^^^^^^^^^^^

> +		break;
> +	case TOPO_CPU_TYPE_PERFORMANCE:
> +		/* use the max scale for performance cores */
> +		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
> +		return 0;
> +	case TOPO_CPU_TYPE_EFFICIENCY:
> +		/* use the highest perf value for efficiency cores */
> +		ret = amd_get_highest_perf(cpu, &tmp);
> +		if (ret)
> +			return ret;
> +		*numerator = tmp;
> +		return 0;
> +	default:

... and this case and why aren't you warning if TOPO_CPU_TYPE_UNKNOWN?

I think for that you need to check X86_FEATURE_AMD_HETEROGENEOUS_CORES and
warn if set but still CPU type unknown or?

> +		pr_warn("WARNING: Undefined core type %d found\n", core_type);
> +		break;
> +	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

