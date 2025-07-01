Return-Path: <linux-acpi+bounces-14882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C09AEF797
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6DE3AAFE8
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF970273D9F;
	Tue,  1 Jul 2025 11:53:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3242273816;
	Tue,  1 Jul 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370808; cv=none; b=YHlt6w5LCGuUAMFHZ6s8acR1Z+XcII8SPd20DNIvCNnR0ETJpU7+kSbGUSUH8SoQvjus5axly679PVgpJFvxhbluf3C+XVMcULNUTQk8D92VgB8RkajgTL3QNJE83ApE1ZC+of+3pDkTplUruTL1OxIzLg6cqdrM3IMZGa0E4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370808; c=relaxed/simple;
	bh=C1e0NPrMRKSal2Xyocx28xd/iI/iJcEEAFn8lphPZaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juV8LFuwGMyeDI9LYs4xfn8JoJ+e4GkqhdxHiMDMynaqrPyRDjvD+FkXUXI8Ro++T5CXGQqtKJBGlUJict2Sfjf434JbygjdkNtx82usPmCHj6tHFzuGWtno8+KPHBjE6QmBG+nZvymnprOoFpxIQIP+Whd/2424lvuFYsLG8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E77BC4CEEB;
	Tue,  1 Jul 2025 11:53:26 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:53:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Li Chen <me@linux.beauty>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Will Deacon <will@kernel.org>,
	Len Brown <lenb@kernel.org>, Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ACPI: Return -ENODEV from acpi_parse_spcr() when
 SPCR support is disabled
Message-ID: <aGPMM9Nw2-99sWRL@arm.com>
References: <20250620131309.126555-1-me@linux.beauty>
 <20250620131309.126555-2-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620131309.126555-2-me@linux.beauty>

On Fri, Jun 20, 2025 at 09:13:07PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> If CONFIG_ACPI_SPCR_TABLE is disabled, acpi_parse_spcr()
> currently returns 0, which may incorrectly suggest that
> SPCR parsing was successful. This patch changes the behavior
> to return -ENODEV to clearly indicate that SPCR support
> is not available.
> 
> This prepares the codebase for future changes that depend
> on acpi_parse_spcr() failure detection, such as suppressing
> misleading console messages.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f102c0fe34318..71e692f952905 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1503,7 +1503,7 @@ int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
>  #else
>  static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>  {
> -	return 0;
> +	return -ENODEV;
>  }
>  #endif

Rafael, are you ok with this patch going via the arm64 tree?

Thanks.

-- 
Catalin

