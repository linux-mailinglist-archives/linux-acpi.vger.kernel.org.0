Return-Path: <linux-acpi+bounces-11331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB792A3CA5C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960F61885D48
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D224CEFC;
	Wed, 19 Feb 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OuA3um8a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194C24CED5;
	Wed, 19 Feb 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998215; cv=none; b=d8H08NEy1FVNFs0kOe8kSDjio+fXZBmGVV6knn7LQS2USVTj9sXBvOyupU+UJVDuMIufDv3NwoYlDNnwCToSTBg+2abCDPGaWVSBopDG+LoV1089xX09Z6u7Q6O5Dqy0HKAhK1lrxPDNrQj/ZyHbE+R0Td2Df3q8CpF6yXmbibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998215; c=relaxed/simple;
	bh=ZLyFZBzqrsgnKcvrGUwR8JD9fWxbGDJy+LYm8X4cAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqtA13ZWL1UNZ1Bi4uM+Rpi0Cb5zJLoGgeA1SvwJ4pTzJsFQF+n0X/a834l5bY3LgoaQV8VVXO6rP75fktLgQ1RRla5Qxh1crIYFkn6asQbeySLwbzBInbbGmOOAd+8YX5c6BXlAC76uQpCZzoJLVUnkkxRN0r5Y8wnYNHlE5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OuA3um8a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9445D40E0202;
	Wed, 19 Feb 2025 20:50:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D-KgR2PAqKU0; Wed, 19 Feb 2025 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739998206; bh=VsMO0GXil4Y39VGyYS3yPNRKTq+vkTy7NUC6d/1AgqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuA3um8aGktrJ32KgcNJizRtEgCUunE+Gmrari3ssYwlFLPY/NuNsg8hsyP+eQ7Rf
	 mkta1lEX8k2ThRL9bF6sjiro1J8rpqOpV9Q/DrU4K88okgGBpId1SYN+DZSPPuqZqk
	 lYvsE2zZ4YqhXctYCS4VPTNQ3N4SjRtWH9VzQ+qIGBenTIvMSm9iyQ8fkRoCt61YaD
	 JR+ebQkmUi1iUA4IR4DheIl06djzfI2623hNtFYEmKmkGDNRgMg0kDJEiAMnoPOQWc
	 Y9IL5K0PCAIQzJfNVYttfXRPtEBRIe6WdxiozGYQrtZl1NTdhtviOedDv4tUkmQC/D
	 Ei0LQoNIJq6FdtMcxNka8dxHeqBV9+dORJ2ee+vYFPqJi6zotxhkQ5eKpQ6kI0rOYn
	 8zPPdrVMnJ86svwMWX1fSljG8bNZJ76Fedw7NO4mkZcoL4fglzxtkGxW9HU9cai3gD
	 vmGTPjBHcOhrjg21Rd6tUlb1UUmgTrxN6j2t9pkjj4VPFcOAtkli8475l86oufjWhb
	 C/pyDq4Pp5xcT4G9qJja+R3fGl423SPj6j2IQYH23jmNuIn8hzL7S3+Ft1gEbIkOP6
	 BeS6UKU9n83RonNjFfFOPCmVCl+qjVQenS8aY5EHILsa6KN4cql99ojVsC9lgKbo20
	 C+XiLETYHCTntRzas46ZWMeo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B87040E0191;
	Wed, 19 Feb 2025 20:49:50 +0000 (UTC)
Date: Wed, 19 Feb 2025 21:49:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	Tyler Baicar <baicar@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
Message-ID: <20250219204945.GRZ7ZD6a4tEBboxYrH@fat_crate.local>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
 <20250115084228.107573-2-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-2-tianruidong@linux.alibaba.com>

Just some cursory review...

On Wed, Jan 15, 2025 at 04:42:24PM +0800, Ruidong Tian wrote:
> Add support for parsing the ARM Error Source Table and basic handling of
> errors reported through both memory mapped and system register interfaces.
> 
> Assume system register interfaces are only registered with private
> peripheral interrupts (PPIs); otherwise there is no guarantee the
> core handling the error is the core which took the error and has the
> syndrome info in its system registers.
> 
> In kernel-first mode, all configuration is controlled by kernel, include
> CE ce_threshold and interrupt enable/disable.
> 
> All detected errors will be processed as follow:
>   - CE, DE: use a workqueue to log this hare errors.
>   - UER, UEO: log it and call memory_failun workquee.
>   - UC, UEU: panic in irq context.


Use a spellchecker for all your text.

In addition, use AI to check your English formulations.

> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>

Who's the author: Tyler or you?

That's denoted with the From: field.

Make sure you go over Documentation/process/submitting-patches.rst for basic
mistakes.

> ---
>  MAINTAINERS                  |  10 +
>  arch/arm64/include/asm/ras.h |  95 ++++
>  drivers/acpi/arm64/Kconfig   |  11 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  drivers/acpi/arm64/aest.c    | 335 ++++++++++++
>  drivers/acpi/arm64/init.c    |   2 +
>  drivers/acpi/arm64/init.h    |   1 +
>  drivers/ras/Kconfig          |   1 +
>  drivers/ras/Makefile         |   1 +
>  drivers/ras/aest/Kconfig     |  17 +
>  drivers/ras/aest/Makefile    |   5 +
>  drivers/ras/aest/aest-core.c | 976 +++++++++++++++++++++++++++++++++++
>  drivers/ras/aest/aest.h      | 323 ++++++++++++
>  include/linux/acpi_aest.h    |  68 +++
>  include/linux/cpuhotplug.h   |   1 +
>  include/linux/ras.h          |   8 +
>  16 files changed, 1855 insertions(+)

This patch is huuge and unreviewable: split it.

Also, I see issues like:

check_for_todos: WARNING: drivers/ras/aest/aest-core.c:207: Hunk contains unfinished TODO:
+               /* TODO: translate Logical Addresses to System Physical Addresses */


check_for_todos: WARNING: drivers/ras/aest/aest-core.c:446: Hunk contains unfinished TODO:
+       //TODO: Support 32B CEC threshold.

A TODO tells me that patch is not ready for upstream.

Also, get rid of all // comments in drivers/ras/ and use normal /* style.

Enough for now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

