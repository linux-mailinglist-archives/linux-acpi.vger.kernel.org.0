Return-Path: <linux-acpi+bounces-19690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C611DCCF135
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 10:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D39E3007694
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3EE2EB5AF;
	Fri, 19 Dec 2025 09:02:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E620B212;
	Fri, 19 Dec 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134968; cv=none; b=dlE77flt4DBJKH84Pvcotksxoei2ei6MKh1IvkT74Qp4UQsx8hWcFWXK+nKJvPhcyb294KXA1s+UxHJKlY9GVPXuakXfcALmeuxucVPx9WaonbDitTostnqDM8p5QVPBiPrqjTtspsMpqSUhEBNLEKkGqfHrhRlNzwWFaWselwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134968; c=relaxed/simple;
	bh=zhllQ8Zcx/Tc0SP1HXazq5bAp/XnRul0Eb+KeWR/JFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIwcJFBy/++E2nn78eLfJnAKk/UE/0N7hERDW193Zct3Dte/MI54ijmTcGimUaXW9vIeOO3pK1tds6setMvirbu0cZyQzUk7W89tsWFzBMi/i1RxT9GN0L8uPguYD9Q4Di62FiFc1zUhOFtlJmfOxBUjlxvhG4iKpGP/FI73ZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9578EFEC;
	Fri, 19 Dec 2025 01:02:36 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865ED3F73F;
	Fri, 19 Dec 2025 01:02:41 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: will@kernel.org
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
Date: Fri, 19 Dec 2025 09:02:35 +0000
Message-ID: <20251219090239.2692458-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aUQbdZHkzumTnwVP@willie-the-truck>
References: <aUQbdZHkzumTnwVP@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 03:19:17PM +0000, Will Deacon wrote:
> On Thu, Dec 18, 2025 at 01:42:47PM +0000, Ahmed Tiba wrote:
>> On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
>> >> Introduce a platform driver that maps the CPER status block described
>> >> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
>> >> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
>> >> driver can safely map the shared buffer while copying records.
>> >>
>> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> >> ---
>> >>  MAINTAINERS                     |   1 +
>> >>  arch/arm64/include/asm/fixmap.h |   5 +
>> >>  drivers/ras/Kconfig             |  14 ++
>> >>  drivers/ras/Makefile            |   1 +
>> >>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
>> >>  include/linux/estatus.h         |   3 +-
>> >>  6 files changed, 341 insertions(+), 1 deletion(-)
>> >>  create mode 100644 drivers/ras/estatus-dt.c
>> >>
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index 6b2ef2ddc0c7..5567d5e82053 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
>> >>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
>> >>  S:   Maintained
>> >>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
>> >> +F:   drivers/ras/estatus-dt.c
>> >>  F:   drivers/firmware/efi/estatus.c
>> >>  F:   include/linux/estatus.h
>> >>
>> >> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> >> index 65555284446e..85ffba87bab9 100644
>> >> --- a/arch/arm64/include/asm/fixmap.h
>> >> +++ b/arch/arm64/include/asm/fixmap.h
>> >> @@ -64,6 +64,11 @@ enum fixed_addresses {
>> >>  #endif
>> >>  #endif /* CONFIG_ACPI_APEI_GHES */
>> >>
>> >> +#ifdef CONFIG_RAS_ESTATUS_DT
>> >> +     /* Used for ESTATUS mapping from assorted contexts */
>> >> +     FIX_ESTATUS_IRQ,
>> >> +#endif /* CONFIG_RAS_ESTATUS_DT */
>> >
>> > Why do we need this in addition to the four existing GHES slots? The DT
>> > code doesn't use it and I was assuming that the ACPI code would continue
>> > to use the existing irq; is that not the case?
>>
>>
>> We still need a dedicated slot when only the DT provider is built.
>> All four GHES slots are defined as part of the ACPI implementation,
>> so they are not present in a DT-only configuration.
>>
>> The estatus core always requests a fixmap index from each provider
>> before copying a CPER record. As a result, the DT driver must supply
>> its own slot to return a valid enum value to satisfy the common code.
>
> Sorry, but I still don't follow this. The DT code doesn't use the fixmap,
> does it? It looks like it maps the buffer ahead of time using
> devm_ioremap_resource() and then the accessors don't use the fixmap
> index at all, hence the horrible '(void)fixmap_idx;' cast which presumably
> stops the compiler from complaining about an unused variable.

Correct. The current DT driver keeps the CPER buffer permanently mapped with
devm_ioremap_resource() and that (void)fixmap_idx; line is just silencing
the warning. I’ll fix that by dropping the permanent mapping and copying the
status block via the fixmap entry, so the DT implementation mirrors GHES. That
gets rid of the cast and makes FIX_ESTATUS_IRQ do real work.


Thanks,
Ahmed

