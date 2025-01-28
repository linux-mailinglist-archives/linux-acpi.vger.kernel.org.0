Return-Path: <linux-acpi+bounces-10853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350EA208FD
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A911684E6
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7D19E98D;
	Tue, 28 Jan 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdHDlTnw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97C19E971;
	Tue, 28 Jan 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061461; cv=none; b=r8L0qPY266OECiXmdQ0j+f58hktkZjGUsY6OoA9GOV0rdbsCoLh8NxoLTgjeGBUEd3RPV/X7LrMD4AsVqBeaRnKKAuLsdU17CbT1rYwgYK+t8uaoV2FnWlTRvb1GpLUR13McqkSGSvf4MYjCteAvAiRR0/vRRDJb49QCregbNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061461; c=relaxed/simple;
	bh=CbE7VaYsCScvQSvzHBNrm7SCEjIu6kV93dcFx8P3ahY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPxI2omVvcWvfbo+cDXA2r9Iw8ppgRG54MXmf1gV/9+lPkzky8A5g+K35ol6YGWwLMmdwH1hb+ZM+KSxEoAy51QrTlvryJLwgIIJ2kMFAJLB7tu1xk14JCJpri8Uu8Lq2j7/CyCTAYBRIVLZDpxY5uSnUorUjoTKQ7wxsPKEC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdHDlTnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89DCC4CED3;
	Tue, 28 Jan 2025 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738061460;
	bh=CbE7VaYsCScvQSvzHBNrm7SCEjIu6kV93dcFx8P3ahY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdHDlTnwB4+fm1W39i9KCCxvRU+q7Alfr1jUUmDAREgEW87zYjBlIQmawYHyjGKJT
	 +uqlwxWPptQMD9O69KOvqFGvtPNjXGC7cy3iic0MHhxR8UCGA1+p4T9Qd08RFkM87M
	 eSYx3uX+gs2vR1HtjjrOjZW9SOXGF+GbHltx2grWkaRbl7Nm6X3ydKYPHAQxk3Exg2
	 HHzcwjxaPPkm3ae5/0XYlbXV0EPHfvDbHEHdgeevPVqDxyhYdaP98/jUJGnWzhlpjN
	 71l9Pkbgs/es38EsoWRu2HVjmnIYwQC/f1SFyMp3FTFWPIlHIXa6SQUEnC0lnGoqV+
	 Ic+eNeUG9cbhA==
Date: Tue, 28 Jan 2025 11:50:55 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers
 array count
Message-ID: <Z5i2j9gFB2iyN9g4@lpieralisi>
References: <20250128001749.3132656-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128001749.3132656-1-oliver.upton@linux.dev>

On Tue, Jan 28, 2025 at 12:17:49AM +0000, Oliver Upton wrote:
> Perhaps unsurprisingly there are some platforms where the GTDT isn't

https://lore.kernel.org/lkml/Zw6b3V5Mk2tIGmy5@lpieralisi

An accident waiting to happen :)

> quite right and the Platforms Timer array overflows the length of the
> overall table.
> 
> While the recently-added sanity checking isn't wrong, it makes it
> impossible to boot the kernel on offending platforms. Try to hobble
> along and limit the Platform Timer count to the bounds of the table.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Zheng Zengkai <zhengzengkai@huawei.com>
> Cc: stable@vger.kernel.org
> Fixes: 263e22d6bd1f ("ACPI: GTDT: Tighten the check for the array of platform timer structures")
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  drivers/acpi/arm64/gtdt.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 3561553eff8b..70f8290b659d 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -163,7 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  {
>  	void *platform_timer;
>  	struct acpi_table_gtdt *gtdt;
> -	int cnt = 0;
> +	u32 cnt = 0;
>  
>  	gtdt = container_of(table, struct acpi_table_gtdt, header);
>  	acpi_gtdt_desc.gtdt = gtdt;
> @@ -188,13 +188,17 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  		cnt++;
>  
>  	if (cnt != gtdt->platform_timer_count) {
> +		cnt = min(cnt, gtdt->platform_timer_count);

Thank you for reporting this.

There is something I need to understand.

What's wrong cnt (because platform_timer_valid() fails for some
reason on some entries whereas before the commit we
are fixing was applied we *were* parsing those entries) or
gtdt->platform_timer_count ?

I *guess* the issue is the following:

gtdt->platform_timer_count reports the number of GT blocks in the
GTDT not including Arm generic watchdogs, whereas cnt counts both
structure types (and that's what gtdt->platform_timer_count should
report too if it was correct).

I am asking just to understand if platform_timer_valid() forced skipping
some entries that we were parsing before the commit we are fixing
was applied I doubt it but it is worth checking.

> +		pr_err(FW_BUG "limiting Platform Timer count to %d\n", cnt);
> +	}`
> +
> +	if (!cnt) {
>  		acpi_gtdt_desc.platform_timer = NULL;
> -		pr_err(FW_BUG "invalid timer data.\n");
> -		return -EINVAL;
> +		return 0;
>  	}
>  
>  	if (platform_timer_count)
> -		*platform_timer_count = gtdt->platform_timer_count;
> +		*platform_timer_count = cnt;

I think this should be fine as things stand (but see above).

It is used in:

gtdt_sbsa_gwdt_init() - just to check if there are platform timers entries

arch_timer_mem_acpi_init() - to create a temporary array to init arch mem timer
			     entries (the array is oversized because it
			     includes watchdog entries in the count)

In both cases taking the

min(cnt, gtdt->platform_timer_count);

should work AFAICS (hard to grok though, we - as in ACPI maintainers -
need to clean this up).

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  
>  	return 0;
>  }
> 
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 

