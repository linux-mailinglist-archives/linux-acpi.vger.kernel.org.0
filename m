Return-Path: <linux-acpi+bounces-19968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00418CF59D2
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 22:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B80C30336A1
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 21:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD42DF128;
	Mon,  5 Jan 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/xj8TW9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C12DEA6B;
	Mon,  5 Jan 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647374; cv=none; b=URZY6sNyTDBA2imd7QguSAq3U4DNyjTzrph/bm68Z+l444YBRtqrnT6JogG0rXUymETcMDTYmIN/PfhQtalCbZQCCcr199pGAGIgHAKkas2Feqo543m29rYYOR5PBdA/Cqy1UzmU0fnbqGH8sZaauWUdXQzoZuFO1AV2/96lkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647374; c=relaxed/simple;
	bh=Bo2mz1wPMluDbvj1elOIEegGzA0WmkT7yrJG4cxsqlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBJYqwlsjmMH5JkGVFs368dYtiXEZc0MgjdLL5CLK070b+tqd+v7YkoIBAgQD4hEQSlF5dPobVAkVAZo8RFmP4pxiyDa2VxnmolINQmqB0gw3UYhtiMOZRF56wFYlYyzKuOtHL0zKgeUuTcCwxv5op3ZEjIWNxCWytsZ/5TtioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/xj8TW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA6C116D0;
	Mon,  5 Jan 2026 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647374;
	bh=Bo2mz1wPMluDbvj1elOIEegGzA0WmkT7yrJG4cxsqlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/xj8TW9LZABZbPiV5Okvvz+WY5plTAtOdalIV5ynCNGDES3JCEsjtoJi9NZRcpBg
	 LWyYlPwBSFpXOC2nsLK8QoWZ4y33dgumC+x4WuN6i2TK79Q2DW08eqggs80VJk7j7W
	 rsXNzHWATKyFdDyHFtfmLo+V7nhGB1wvLOJMLpj/Cydrfk+zH5ecgUJvqGbaFkBk+z
	 H5CbaKUIlk/sCPfXhnNI6qxk1kZZ3pOzNEnPT+g4LLnWR9+uVyBl3YrEKbP8ped7ZV
	 yfOUo8h8cTRef2xs5GJkVgIpz4KrDSzqLTkPhLdbM/aqs18755zZjg7Sa9nXqWLeGT
	 Dwd87DjLyPJ1g==
Date: Mon, 5 Jan 2026 21:09:28 +0000
From: Will Deacon <will@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, bp@alien8.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 11/12] ras: add DeviceTree estatus provider driver
Message-ID: <aVwoiM9bCFe2Zqn_@willie-the-truck>
References: <aUVMWMMmiG8_I2I2@willie-the-truck>
 <20251219172212.2844694-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219172212.2844694-1-ahmed.tiba@arm.com>

On Fri, Dec 19, 2025 at 05:21:54PM +0000, Ahmed Tiba wrote:
> On Fri, 19 Dec 2025 13:00:08 +0000, Will Deacon wrote:
> >On Fri, Dec 19, 2025 at 09:02:35AM +0000, Ahmed Tiba wrote:
> >> On Thu, 18 Dec 2025 03:19:17PM +0000, Will Deacon wrote:
> >> > On Thu, Dec 18, 2025 at 01:42:47PM +0000, Ahmed Tiba wrote:
> >> >> On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
> >> >> >> Introduce a platform driver that maps the CPER status block described
> >> >> >> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
> >> >> >> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
> >> >> >> driver can safely map the shared buffer while copying records.
> >> >> >>
> >> >> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> >> >> >> ---
> >> >> >>  MAINTAINERS                     |   1 +
> >> >> >>  arch/arm64/include/asm/fixmap.h |   5 +
> >> >> >>  drivers/ras/Kconfig             |  14 ++
> >> >> >>  drivers/ras/Makefile            |   1 +
> >> >> >>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
> >> >> >>  include/linux/estatus.h         |   3 +-
> >> >> >>  6 files changed, 341 insertions(+), 1 deletion(-)
> >> >> >>  create mode 100644 drivers/ras/estatus-dt.c
> >> >> >>
> >> >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> >> index 6b2ef2ddc0c7..5567d5e82053 100644
> >> >> >> --- a/MAINTAINERS
> >> >> >> +++ b/MAINTAINERS
> >> >> >> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
> >> >> >>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
> >> >> >>  S:   Maintained
> >> >> >>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> >> >> >> +F:   drivers/ras/estatus-dt.c
> >> >> >>  F:   drivers/firmware/efi/estatus.c
> >> >> >>  F:   include/linux/estatus.h
> >> >> >>
> >> >> >> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> >> >> >> index 65555284446e..85ffba87bab9 100644
> >> >> >> --- a/arch/arm64/include/asm/fixmap.h
> >> >> >> +++ b/arch/arm64/include/asm/fixmap.h
> >> >> >> @@ -64,6 +64,11 @@ enum fixed_addresses {
> >> >> >>  #endif
> >> >> >>  #endif /* CONFIG_ACPI_APEI_GHES */
> >> >> >>
> >> >> >> +#ifdef CONFIG_RAS_ESTATUS_DT
> >> >> >> +     /* Used for ESTATUS mapping from assorted contexts */
> >> >> >> +     FIX_ESTATUS_IRQ,
> >> >> >> +#endif /* CONFIG_RAS_ESTATUS_DT */
> >> >> >
> >> >> > Why do we need this in addition to the four existing GHES slots? The DT
> >> >> > code doesn't use it and I was assuming that the ACPI code would continue
> >> >> > to use the existing irq; is that not the case?
> >> >>
> >> >>
> >> >> We still need a dedicated slot when only the DT provider is built.
> >> >> All four GHES slots are defined as part of the ACPI implementation,
> >> >> so they are not present in a DT-only configuration.
> >> >>
> >> >> The estatus core always requests a fixmap index from each provider
> >> >> before copying a CPER record. As a result, the DT driver must supply
> >> >> its own slot to return a valid enum value to satisfy the common code.
> >> >
> >> > Sorry, but I still don't follow this. The DT code doesn't use the fixmap,
> >> > does it? It looks like it maps the buffer ahead of time using
> >> > devm_ioremap_resource() and then the accessors don't use the fixmap
> >> > index at all, hence the horrible '(void)fixmap_idx;' cast which presumably
> >> > stops the compiler from complaining about an unused variable.
> >> 
> >> Correct. The current DT driver keeps the CPER buffer permanently mapped with
> >> devm_ioremap_resource() and that (void)fixmap_idx; line is just silencing
> >> the warning. I’ll fix that by dropping the permanent mapping and copying the
> >> status block via the fixmap entry, so the DT implementation mirrors GHES. That
> >> gets rid of the cast and makes FIX_ESTATUS_IRQ do real work.
> 
> > Why can't you just drop FIX_ESTATUS_IRQ entirely? Your original
> > justification was:
> >
> >> We still need a dedicated slot when only the DT provider is built.
> >
> > but as above, the DT driver doesn't actually need it.
> 
> The DT provider is intended to mirror the GHES path, so both need to supply a
> fixmap slot to satisfy the estatus core interface.

If the fixmap slot isn't needed, we should either change the core code
not to require it or you should reuse the ACPI slots. There's no
justification at all for allocating new VA space in the fixmap area that
is never used to map anything at runtime.

Will

