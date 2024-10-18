Return-Path: <linux-acpi+bounces-8858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345FF9A45D4
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3E11F24CFD
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67385200C8C;
	Fri, 18 Oct 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d+hcj/vc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D517D346
	for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275898; cv=none; b=GU/WbBAYFs2ubcaxL7YUnfJ/kQXYGEaudVS7Vm34DKcxze/HwsIOPsMiF6P/R/w7ZKpkLhmLoqalAfChjAO3/B/OaMr5RhTrmrwwyKM+dcHRG8++yRSmyB1qUDDXdCTyz3CkTjBqax4EThYbdsc5a5M9aIAazqtCCIWmBYbZCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275898; c=relaxed/simple;
	bh=/1bKiB9E1wY/3hxVbO569QVcWm8bx9n3VDcJPVERc2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp99GxFXgDhAsCvjHDS2sj9Jjya4/GtAAxHbTd+aup7ACF6kg7GPS+WL+N2yK8Yc5mhkce+OEcVjS+7L2fduOC5/Tc48JUw3Yz2U0w4p6IfpPwK0wxKuidkHdn9MbMtLd6l4vwyB1AvfC3+6LEAiFNxVmBFqDSTlCPhMiPO6lGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d+hcj/vc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A143140E015F;
	Fri, 18 Oct 2024 18:24:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZJf30srqbUdT; Fri, 18 Oct 2024 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729275888; bh=AuXC4rWqd07yWDisTcmNwmwUXyocSGnMgI5W518kEDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+hcj/vcCYNosqy20OPsQrpcoCNN2Mb9408YOC1U81++oohhZNOnuVY5oMULWqigO
	 uJ+k4lf8ksu67cBy8JJ2vb/MuzW+GQvPDBFXJXcmIYgvjCzg9ODuYK3wyYvj79RmW/
	 iUz50wQXkYbQGSMyH5KpwUsdrg0POlf4hBbsck/3aQi00etP7YP5ky6qMDbdFuVrmG
	 VagRtW87SZGeSgdwBhdkq1PmS46U/LMUZncATo9rpET5r7cM0rDbRXlTExv3HGZmfh
	 HsHebq6iYOBsmcbbCm+bpRSWTlTNkF2a5wO/yoQGnmX5K/x6z3zKdceQ6SsQ78q7MQ
	 hHhmIKS8LKi+8FQDdEIspj9N8e0eGTzbUe2iSGxL9sVUfCblK49IwN3nL+n/c5vFbF
	 z3NAYob2sftXLkwmt80nMiCCUoLO9+rlDc1H2PvcSx5ce4xpLg1kBGV/HYyEBAJkdf
	 qGv9AgZQ6pu0Bnhu/9mC3khCUcRYmCbA41XYNo1ocR/FdLJydewvHKCTnNGTub6xPj
	 E+CtJkUpLwbEqYbbs/0rH6XInEJ9heJGXPqI3BPf5RAaH5CH3xXMpxC9L1Lcb2xbXq
	 RCHDN4EA2zsPJyc2nbcm79wSXOGa1cb7qn96GAijaxpYvzzFqCf9NA9OL+XHW4jaf/
	 5Obc+/cRJGdybv7AHZIjSz0s=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A4C440E0263;
	Fri, 18 Oct 2024 18:24:40 +0000 (UTC)
Date: Fri, 18 Oct 2024 20:24:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003213759.3038862-2-superm1@kernel.org>

On Thu, Oct 03, 2024 at 04:37:58PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> CPUID leaf 0x80000026 advertises core types with different efficiency
> rankings.
> 
> Bit 30 indicates the heterogeneous core topology feature, if the bit
> set, it means not all instances at the current hierarchical level have
> the same core topology.
> 
> This is described in the AMD64 Architecture Programmers Manual Volume
> 2 and 3, doc ID #25493 and #25494.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd4682857c12..cea1ed82aeb4 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -473,6 +473,7 @@
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
> +#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */

So this is an AMD-specific feature bit and so it should have "AMD" in the
name:

#define X86_FEATURE_AMD_HETERO_CORE_TOPOLOGY (21*32 + 6) /* Heterogeneous Core Topology */

Also, as clarified offlist, please do not take x86 patches without an Ack at
least through some other tree.

> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index c84c30188fdf..3bba55323163 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },

So my APM calls this bit: "HeterogeneousCores".

Why aren't you calling it this?

IOW: X86_FEATURE_AMD_HETEROGENEOUS_CORES

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

