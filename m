Return-Path: <linux-acpi+bounces-19667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F608CCBC12
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBDCC30155CD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824532E6A5;
	Thu, 18 Dec 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqTCY3LZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E532E14F;
	Thu, 18 Dec 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060011; cv=none; b=FYFf3JCwufksYiLrxti5re7guJS55fVkYo91YUh+/CB0d2eUZxoRdXGrrYlfxpsOhFyllJjRhJDmHl0MNFtUMOhd3e6NyzphWxnKpPWSQipN81sYgwp/zDYEnahmPSh4ZqULX+9H2guU4Ag9gVFWDHQli0Pi6xde+ftg1ZpXdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060011; c=relaxed/simple;
	bh=QjcyqYgAAiCVwktzssjIvKksa8RRHKln7unjqaGozug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulH4+7QMT33w3339ksYEAGDAdALIoWO7Ds1EckQuzt+xYALBDV0LzLmGjcWDEp/5Ttspf/xr/ipzLIIyBWlDq+rtuOuRaO6WAdGSkNJ3mpJRcASyJqkzZ4xveSLsi1F1/CAscmdt/xhrmzWNwbBgTqvFdU8Ct0jeAjFtZlYdvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqTCY3LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB30C4CEFB;
	Thu, 18 Dec 2025 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766060011;
	bh=QjcyqYgAAiCVwktzssjIvKksa8RRHKln7unjqaGozug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqTCY3LZvoQPHjGcorl9DXffWz6ePn53FCjtqjWN+Lk3rtHtrsab4QLd2aT+Tygv7
	 UZHbk8n4YTGjKfSaiN+Sk6tDk3Rr5Z4amciKYFjyj0vf9FO8o8ZMpZJwiVTr5xPJK/
	 iXhqbj82swpKH+BwHcMtpl9MoZpOapQu822X4DvBynPxv75i9eCiaAEyZkQXyJ1KjB
	 lh4BbbWNQGFcXUyxFS0Lq/fgY8gBENJ7fdLqIrIo8HrFEgfNUnz8h8ci5ty8B60W75
	 arKbFNHHlyfpLosVXe6kUxPRFwSoHeTVPtaVohyLzY4ek7B6h5wt4depCLldeyIjks
	 8OGMl3sx8v09w==
Date: Thu, 18 Dec 2025 12:13:25 +0000
From: Will Deacon <will@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, bp@alien8.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 11/12] ras: add DeviceTree estatus provider driver
Message-ID: <aUPv5UfBByVoLbRV@willie-the-truck>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
 <20251217112845.1814119-12-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112845.1814119-12-ahmed.tiba@arm.com>

On Wed, Dec 17, 2025 at 11:28:44AM +0000, Ahmed Tiba wrote:
> Introduce a platform driver that maps the CPER status block described
> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
> driver can safely map the shared buffer while copying records.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  MAINTAINERS                     |   1 +
>  arch/arm64/include/asm/fixmap.h |   5 +
>  drivers/ras/Kconfig             |  14 ++
>  drivers/ras/Makefile            |   1 +
>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
>  include/linux/estatus.h         |   3 +-
>  6 files changed, 341 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ras/estatus-dt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b2ef2ddc0c7..5567d5e82053 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
>  M:	Ahmed Tiba <ahmed.tiba@arm.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> +F:	drivers/ras/estatus-dt.c
>  F:	drivers/firmware/efi/estatus.c
>  F:	include/linux/estatus.h
>  
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 65555284446e..85ffba87bab9 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -64,6 +64,11 @@ enum fixed_addresses {
>  #endif
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
> +#ifdef CONFIG_RAS_ESTATUS_DT
> +	/* Used for ESTATUS mapping from assorted contexts */
> +	FIX_ESTATUS_IRQ,
> +#endif /* CONFIG_RAS_ESTATUS_DT */

Why do we need this in addition to the four existing GHES slots? The DT
code doesn't use it and I was assuming that the ACPI code would continue
to use the existing irq; is that not the case?

Will

