Return-Path: <linux-acpi+bounces-11333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12BA3CAAB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413E816AD44
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC20253351;
	Wed, 19 Feb 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EVaSHjwW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C32528E9;
	Wed, 19 Feb 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998828; cv=none; b=Tis9ryQtz3bS5mkfZqvGAfyRdONiL4uVJH0lgtmIONKM6U6PrypydQGUapC134CfsAnKQ8+jGGGauvS/WYZsqkyR2FANyQV1CAMc9x6lAEevab5xN0gXeVwpVo2iccu+FrKKryHU2Sg5WdftYUbSTiTUWYrg+yIaYQwCNa1ExJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998828; c=relaxed/simple;
	bh=aX+a5w8XmINtfH48IXldc+6paaSi1c9fznZYSx8wZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYTo5b+rbcbtmo2t1sQ0Z19ejc0vG4sAgxS9+emUQBagOxswKy+3Kprj1u5STp0HVnm4SwSl840SXmxIjld0eG5zUbnyuSKGgrn2V3jHSocwZNn2CI00NV5dlSLsfTGc9EjsmM7M9u7nQ2aGLLd2GP2EWVj22ZWp1/5DtK/SMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EVaSHjwW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3034E40E01B2;
	Wed, 19 Feb 2025 21:00:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YHqz74H1AW0s; Wed, 19 Feb 2025 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739998820; bh=rjW6me5aey9H48hEN1KtzxQxnDbPM7NZTegKHKqDCWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVaSHjwW22P+vF1AXfgkrBhlqKcMY6aPZjkYzyb3Unn8wSfHBuGpF82KiHzKcs4rD
	 RDgZ5NMMlqYe7usuGitbOeZfiy0LnFMAG62t1TmjMOGJWLabXTN+fDd3EkQOMnIcgz
	 2+WnZC0xl5sQyvk6K8DWKM+qaBoyDFlPc6qEDFXVI9XdvN2NWV7MvREVFd0fHJIy/Z
	 WnCv00w94vrVDjP4gtCAiEaXTcxqs3DBPSti9J9SsjALQJnPFdT6DyTcSN59tm90vt
	 E0HYdr/quNZQGlyGhtu+kD0yMY0//XgLYKJAqgzgV9EiTjZxcZkH6pk1P9lWsu4taV
	 D4zie+Afwgyto4ZhBITYkFdUdv5NwKBu2K0VOj1nvFQNFBwopzE9quJJ9Tdji8iC5F
	 tKidpAX1COfflmtwTh6rNfD0hcVR9CBeY9vVgMUlIYFbvkCJIJH/Ek5aXbPScoxGMj
	 tE5fS4e8Gg2kRytdJLcZFsPFoEKk/D0bZPCwDX/Vj34PWrI36wjIpXw7ot5+dBEfu+
	 Bluv0CdgiJ0SXPqLkhq7Rli/xZ5AILx+FCLEWT5cD9OKWJRFP99WeJrNUI54UhDnzq
	 SVI0x2SXGK6iLvrWcvyuUel83sC5J7mNvJ5wXSOKu+PkzttmWsuZO9psynAwdch3Ja
	 V6oZ+n7VGPb+FQCC2FcPNvIE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6459040E015D;
	Wed, 19 Feb 2025 21:00:05 +0000 (UTC)
Date: Wed, 19 Feb 2025 22:00:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 4/5] RAS/ATL: Unified ATL interface for ARM64 and AMD
Message-ID: <20250219210004.GTZ7ZGVHn9h5h88_fJ@fat_crate.local>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
 <20250115084228.107573-5-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-5-tianruidong@linux.alibaba.com>

On Wed, Jan 15, 2025 at 04:42:27PM +0800, Ruidong Tian wrote:
> Subject: Re: [PATCH v3 4/5] RAS/ATL: Unified ATL interface for ARM64 and AMD

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.


> Translate device normalize address in AMD, also named logical address,
> to system physical address is a common interface in RAS. Provides common
> interface both for AMD and ARM.

This needs a lot more explanation.

> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  drivers/edac/amd64_edac.c      |  2 +-
>  drivers/ras/aest/aest-core.c   | 12 ++++++------
>  drivers/ras/amd/atl/core.c     |  4 ++--
>  drivers/ras/amd/atl/internal.h |  2 +-
>  drivers/ras/amd/atl/umc.c      |  3 ++-
>  drivers/ras/ras.c              | 24 +++++++++++-------------
>  include/linux/ras.h            |  9 ++++-----
>  7 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ddfbdb66b794..1e9c96e4daa8 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2832,7 +2832,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	a_err.ipid = m->ipid;
>  	a_err.cpu  = m->extcpu;
>  
> -	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
> +	sys_addr = convert_ras_la_to_spa(&a_err);

No, this is not how all this is done. You don't rename functions and make them
generic - you *extract* generic functionality into generic functions and have
other functions which use them, call them.

And you do that when there are users, not before.

Ok, that should be enough feedback for now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

