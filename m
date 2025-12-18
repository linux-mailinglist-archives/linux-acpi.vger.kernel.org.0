Return-Path: <linux-acpi+bounces-19673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF9CCC74D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 093963002FCE
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B89350A19;
	Thu, 18 Dec 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh9vl8cO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C034FF7E;
	Thu, 18 Dec 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071163; cv=none; b=n/f8qcKCL/8N4CNwK5WsZr8FQfPF8xgw3QU4TeIutuErNfoqgTy/ABamhCj0JoZCH6IM+tyTMbiXmhkWQ+2s+QDqNOu5lwjLnxZxzivywqy5hBQ9rAPfy7GRnEFH8hK0sKbRLb9uu6LOMlEY+FUzmirIAPAMmSjlIhrYxjnb+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071163; c=relaxed/simple;
	bh=lNs6h/Tn6npet126alMraOzQWAdHEXctBs9xqAtaI9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+a/lgjDJysMn/VQch1pPb9fnlYGqFrvgERtjbotp3iczuPQwCQRM9xuhK2e57JvmjkT7SUjlVIwZfRLw6Z75oF+dYXop2x6mKGl8uXDqorL9ceNUTsXDtvjbFFSbonI6gYe6R819bWvZLPCd+lJgHeLHq9psi6qTuCtgxau0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh9vl8cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7037CC4CEFB;
	Thu, 18 Dec 2025 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766071163;
	bh=lNs6h/Tn6npet126alMraOzQWAdHEXctBs9xqAtaI9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mh9vl8cO8g3zNkwI0qQEywi4S51l7RjjDFD+/NdoNaLkGqyRx/m6rMMWhNUAe/f7p
	 ayNsqjF0dga4H1hM0eBbT33xWsC3nBBDkCMb7NkPrqoSg4v74duc9/Q2XD17wHljdm
	 yojfvvwp03tfkXiwRvLb2udPhmZpeXD5MFNHzWHzDxSj0GvUIms23wcwgZC2ISjAcM
	 k1paKBb6BaFYcG4p5jQMYoICzy5HtZwhZLJ07d6szQNEo9aHjh1dO3uVvrc+DZy+9Z
	 SPQMmbht7uYv8YsFigMu2U/9a4X5PAY02AWgZ98AhbxtK9EMCcOShNkr0uzeJPImFd
	 MlBo/i78fGf2Q==
Date: Thu, 18 Dec 2025 15:19:17 +0000
From: Will Deacon <will@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, bp@alien8.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 11/12] ras: add DeviceTree estatus provider driver
Message-ID: <aUQbdZHkzumTnwVP@willie-the-truck>
References: <aUPv5UfBByVoLbRV@willie-the-truck>
 <20251218134311.2309421-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218134311.2309421-1-ahmed.tiba@arm.com>

On Thu, Dec 18, 2025 at 01:42:47PM +0000, Ahmed Tiba wrote:
> On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
> >> Introduce a platform driver that maps the CPER status block described
> >> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
> >> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
> >> driver can safely map the shared buffer while copying records.
> >>
> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> >> ---
> >>  MAINTAINERS                     |   1 +
> >>  arch/arm64/include/asm/fixmap.h |   5 +
> >>  drivers/ras/Kconfig             |  14 ++
> >>  drivers/ras/Makefile            |   1 +
> >>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
> >>  include/linux/estatus.h         |   3 +-
> >>  6 files changed, 341 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/ras/estatus-dt.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6b2ef2ddc0c7..5567d5e82053 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
> >>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
> >>  S:   Maintained
> >>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> >> +F:   drivers/ras/estatus-dt.c
> >>  F:   drivers/firmware/efi/estatus.c
> >>  F:   include/linux/estatus.h
> >> 
> >> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> >> index 65555284446e..85ffba87bab9 100644
> >> --- a/arch/arm64/include/asm/fixmap.h
> >> +++ b/arch/arm64/include/asm/fixmap.h
> >> @@ -64,6 +64,11 @@ enum fixed_addresses {
> >>  #endif
> >>  #endif /* CONFIG_ACPI_APEI_GHES */
> >> 
> >> +#ifdef CONFIG_RAS_ESTATUS_DT
> >> +     /* Used for ESTATUS mapping from assorted contexts */
> >> +     FIX_ESTATUS_IRQ,
> >> +#endif /* CONFIG_RAS_ESTATUS_DT */
> >
> > Why do we need this in addition to the four existing GHES slots? The DT
> > code doesn't use it and I was assuming that the ACPI code would continue
> > to use the existing irq; is that not the case?
> 
> 
> We still need a dedicated slot when only the DT provider is built.
> All four GHES slots are defined as part of the ACPI implementation,
> so they are not present in a DT-only configuration.
> 
> The estatus core always requests a fixmap index from each provider
> before copying a CPER record. As a result, the DT driver must supply
> its own slot to return a valid enum value to satisfy the common code.

Sorry, but I still don't follow this. The DT code doesn't use the fixmap,
does it? It looks like it maps the buffer ahead of time using
devm_ioremap_resource() and then the accessors don't use the fixmap
index at all, hence the horrible '(void)fixmap_idx;' cast which presumably
stops the compiler from complaining about an unused variable.

Will

