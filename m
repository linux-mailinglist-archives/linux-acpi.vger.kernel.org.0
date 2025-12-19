Return-Path: <linux-acpi+bounces-19723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73ECD11E0
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77E3303E5DE
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EE24468B;
	Fri, 19 Dec 2025 17:22:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBFC23EA82;
	Fri, 19 Dec 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164948; cv=none; b=F147PIf6tS/jYUjHYxaq6Ieud46nrOVA7sfvXhQ77srafGrbb9/eeWe0v0UitQ9ubJ0SswL6h84P1vUQ4wQUJAJ6Xu9ui672b5H5cUJ6f2Zm2gRcXqNrj7ideG1+sXEHF6v5bDNifGOsRdD2oW4BwGvjhTaeZWLWhkovBLAFbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164948; c=relaxed/simple;
	bh=5adtQGEsmql7kNYZuPJLKOR3AirF0fKcZftpFBcrCPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb/WnvHhRxjBhRhcdfmbmDMJcD1uyke7JdbTlZEnx6uCUZRdf8dtyqGZ4BlgaRZNnE33rM6R1D1ZCDmMHSqLPvbiiloJDXjyiOKyzi9cxBfANn8LSjhuqLzRvWqa4vSW1awApj7+nj400uPaaL2OOtBAf+cE4325ww3U6rdbZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC2DFEC;
	Fri, 19 Dec 2025 09:22:17 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 421CB3F73F;
	Fri, 19 Dec 2025 09:22:22 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	Ahmed.Tiba@arm.com
Subject: Re: [PATCH 11/12] ras: add DeviceTree estatus provider driver
Date: Fri, 19 Dec 2025 17:21:54 +0000
Message-ID: <20251219172212.2844694-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aUVMWMMmiG8_I2I2@willie-the-truck>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 13:00:08 +0000, Will Deacon wrote:
>On Fri, Dec 19, 2025 at 09:02:35AM +0000, Ahmed Tiba wrote:
>> On Thu, 18 Dec 2025 03:19:17PM +0000, Will Deacon wrote:
>> > On Thu, Dec 18, 2025 at 01:42:47PM +0000, Ahmed Tiba wrote:
>> >> On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
>> >> >> Introduce a platform driver that maps the CPER status block described
>> >> >> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
>> >> >> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
>> >> >> driver can safely map the shared buffer while copying records.
>> >> >>
>> >> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> >> >> ---
>> >> >>  MAINTAINERS                     |   1 +
>> >> >>  arch/arm64/include/asm/fixmap.h |   5 +
>> >> >>  drivers/ras/Kconfig             |  14 ++
>> >> >>  drivers/ras/Makefile            |   1 +
>> >> >>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
>> >> >>  include/linux/estatus.h         |   3 +-
>> >> >>  6 files changed, 341 insertions(+), 1 deletion(-)
>> >> >>  create mode 100644 drivers/ras/estatus-dt.c
>> >> >>
>> >> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> >> index 6b2ef2ddc0c7..5567d5e82053 100644
>> >> >> --- a/MAINTAINERS
>> >> >> +++ b/MAINTAINERS
>> >> >> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
>> >> >>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
>> >> >>  S:   Maintained
>> >> >>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
>> >> >> +F:   drivers/ras/estatus-dt.c
>> >> >>  F:   drivers/firmware/efi/estatus.c
>> >> >>  F:   include/linux/estatus.h
>> >> >>
>> >> >> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> >> >> index 65555284446e..85ffba87bab9 100644
>> >> >> --- a/arch/arm64/include/asm/fixmap.h
>> >> >> +++ b/arch/arm64/include/asm/fixmap.h
>> >> >> @@ -64,6 +64,11 @@ enum fixed_addresses {
>> >> >>  #endif
>> >> >>  #endif /* CONFIG_ACPI_APEI_GHES */
>> >> >>
>> >> >> +#ifdef CONFIG_RAS_ESTATUS_DT
>> >> >> +     /* Used for ESTATUS mapping from assorted contexts */
>> >> >> +     FIX_ESTATUS_IRQ,
>> >> >> +#endif /* CONFIG_RAS_ESTATUS_DT */
>> >> >
>> >> > Why do we need this in addition to the four existing GHES slots? The DT
>> >> > code doesn't use it and I was assuming that the ACPI code would continue
>> >> > to use the existing irq; is that not the case?
>> >>
>> >>
>> >> We still need a dedicated slot when only the DT provider is built.
>> >> All four GHES slots are defined as part of the ACPI implementation,
>> >> so they are not present in a DT-only configuration.
>> >>
>> >> The estatus core always requests a fixmap index from each provider
>> >> before copying a CPER record. As a result, the DT driver must supply
>> >> its own slot to return a valid enum value to satisfy the common code.
>> >
>> > Sorry, but I still don't follow this. The DT code doesn't use the fixmap,
>> > does it? It looks like it maps the buffer ahead of time using
>> > devm_ioremap_resource() and then the accessors don't use the fixmap
>> > index at all, hence the horrible '(void)fixmap_idx;' cast which presumably
>> > stops the compiler from complaining about an unused variable.
>> 
>> Correct. The current DT driver keeps the CPER buffer permanently mapped with
>> devm_ioremap_resource() and that (void)fixmap_idx; line is just silencing
>> the warning. I’ll fix that by dropping the permanent mapping and copying the
>> status block via the fixmap entry, so the DT implementation mirrors GHES. That
>> gets rid of the cast and makes FIX_ESTATUS_IRQ do real work.

> Why can't you just drop FIX_ESTATUS_IRQ entirely? Your original
> justification was:
>
>> We still need a dedicated slot when only the DT provider is built.
>
> but as above, the DT driver doesn't actually need it.

The DT provider is intended to mirror the GHES path, so both need to supply a
fixmap slot to satisfy the estatus core interface.

I could drop FIX_ESTATUS_IRQ entirely, but that would require relaxing the
estatus core so a provider can explicitly indicate that it does not use a
fixmap and instead relies on a permanent mapping. If we want to stay aligned
with the ACPI/GHES model, keeping the fixmap-based approach seems preferable.

Thanks,
Ahmed

