Return-Path: <linux-acpi+bounces-19711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72412CCFF07
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2615C3038AFD
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55E2DF701;
	Fri, 19 Dec 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdDR0Iz2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F828726E;
	Fri, 19 Dec 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149215; cv=none; b=Q6uyxGsf5CVS3s3ykOFTzaOtOJTzYtJoy2x/Xs7RwamGqU45aQ7zNly1znd1DizjVLpt0q36B3U9m1L/JPG/YzfA8ocDxf5zI85YTPZS76aKnd/9wBM6mG/iR6a/AU2QJ+SKcVXA6z4bUoHFgo+IXnE7EWJzqmYDeSa8q4ivmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149215; c=relaxed/simple;
	bh=E1H9BqH+g14za3jaZiHkm73npLmISjQWVm0QNQCmXXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFywHQcRK63p99yR98E/GM8Qy1LXKkEbIrykTLa6lpgDN8k7G17nhwYGWty5ANmywtHBd35hDjNu3H6lAGfCoc7grfOGfGccBfjLJ9SgMDoKbJ5MOvgMW+J1HCDMmWzdvFpWi59byHYru+fZ9ks6HZRqB70zrOZJQd433eHZuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdDR0Iz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3BDC4CEF1;
	Fri, 19 Dec 2025 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766149214;
	bh=E1H9BqH+g14za3jaZiHkm73npLmISjQWVm0QNQCmXXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdDR0Iz28N5oUNg9bIT7XwJBY2IGAwSnpuHZ260vwBHj0jXvZwGQDC6H7g3scs+Y8
	 Rw0OXzA/9ATIlHvHYioB0rP4eyrjmpzcoQeArJ0GnWZqqKhfuHCec6ceKKfH1Yoogv
	 RwQMDXfLGMn3FMeryeJYuUKfEZuBSS5WcBK1HssLYjxSincWZ2wUfC9MuQ/lG1QYNO
	 nLnCxOgSaRy52WiOHuQAcIuTjCALk2IfFEFpHD/kHkBM0lgvyxeG8+IPLioaS0U+EI
	 BrU1f0D/Gs2K+kdDOfblvsg1G0f/AS56BKLvkxkPbL7P+XO/XBwK2PpjLx7prmWxue
	 DbPh/7K3NNbZA==
Date: Fri, 19 Dec 2025 13:00:08 +0000
From: Will Deacon <will@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, bp@alien8.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 11/12] ras: add DeviceTree estatus provider driver
Message-ID: <aUVMWMMmiG8_I2I2@willie-the-truck>
References: <aUQbdZHkzumTnwVP@willie-the-truck>
 <20251219090239.2692458-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219090239.2692458-1-ahmed.tiba@arm.com>

On Fri, Dec 19, 2025 at 09:02:35AM +0000, Ahmed Tiba wrote:
> On Thu, 18 Dec 2025 03:19:17PM +0000, Will Deacon wrote:
> > On Thu, Dec 18, 2025 at 01:42:47PM +0000, Ahmed Tiba wrote:
> >> On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
> >> >> Introduce a platform driver that maps the CPER status block described
> >> >> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
> >> >> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
> >> >> driver can safely map the shared buffer while copying records.
> >> >>
> >> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> >> >> ---
> >> >>  MAINTAINERS                     |   1 +
> >> >>  arch/arm64/include/asm/fixmap.h |   5 +
> >> >>  drivers/ras/Kconfig             |  14 ++
> >> >>  drivers/ras/Makefile            |   1 +
> >> >>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
> >> >>  include/linux/estatus.h         |   3 +-
> >> >>  6 files changed, 341 insertions(+), 1 deletion(-)
> >> >>  create mode 100644 drivers/ras/estatus-dt.c
> >> >>
> >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> index 6b2ef2ddc0c7..5567d5e82053 100644
> >> >> --- a/MAINTAINERS
> >> >> +++ b/MAINTAINERS
> >> >> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
> >> >>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
> >> >>  S:   Maintained
> >> >>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> >> >> +F:   drivers/ras/estatus-dt.c
> >> >>  F:   drivers/firmware/efi/estatus.c
> >> >>  F:   include/linux/estatus.h
> >> >>
> >> >> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> >> >> index 65555284446e..85ffba87bab9 100644
> >> >> --- a/arch/arm64/include/asm/fixmap.h
> >> >> +++ b/arch/arm64/include/asm/fixmap.h
> >> >> @@ -64,6 +64,11 @@ enum fixed_addresses {
> >> >>  #endif
> >> >>  #endif /* CONFIG_ACPI_APEI_GHES */
> >> >>
> >> >> +#ifdef CONFIG_RAS_ESTATUS_DT
> >> >> +     /* Used for ESTATUS mapping from assorted contexts */
> >> >> +     FIX_ESTATUS_IRQ,
> >> >> +#endif /* CONFIG_RAS_ESTATUS_DT */
> >> >
> >> > Why do we need this in addition to the four existing GHES slots? The DT
> >> > code doesn't use it and I was assuming that the ACPI code would continue
> >> > to use the existing irq; is that not the case?
> >>
> >>
> >> We still need a dedicated slot when only the DT provider is built.
> >> All four GHES slots are defined as part of the ACPI implementation,
> >> so they are not present in a DT-only configuration.
> >>
> >> The estatus core always requests a fixmap index from each provider
> >> before copying a CPER record. As a result, the DT driver must supply
> >> its own slot to return a valid enum value to satisfy the common code.
> >
> > Sorry, but I still don't follow this. The DT code doesn't use the fixmap,
> > does it? It looks like it maps the buffer ahead of time using
> > devm_ioremap_resource() and then the accessors don't use the fixmap
> > index at all, hence the horrible '(void)fixmap_idx;' cast which presumably
> > stops the compiler from complaining about an unused variable.
> 
> Correct. The current DT driver keeps the CPER buffer permanently mapped with
> devm_ioremap_resource() and that (void)fixmap_idx; line is just silencing
> the warning. I’ll fix that by dropping the permanent mapping and copying the
> status block via the fixmap entry, so the DT implementation mirrors GHES. That
> gets rid of the cast and makes FIX_ESTATUS_IRQ do real work.

Why can't you just drop FIX_ESTATUS_IRQ entirely? Your original
justification was:

> We still need a dedicated slot when only the DT provider is built.

but as above, the DT driver doesn't actually need it.

Will

