Return-Path: <linux-acpi+bounces-19672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F9CCC164
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01BC03064BE6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE333358A8;
	Thu, 18 Dec 2025 13:43:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F41330321;
	Thu, 18 Dec 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065409; cv=none; b=lRYaK9kD9yfmYY79zeqOlUAsMhSjLRVrWbHhUbfK4oxTEmiPqRlH5n1/msZmfP6itBWijiHz5XrgY7etRf3U4Nx5FfN00W5YXGzVqMmdCcKy/hREftxq/EOqpcAwLevdlKfr4M4QcqXJtBcrKmgLjJ50weTZ+ENbRXplOknHTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065409; c=relaxed/simple;
	bh=/AaIDgKuALtCg10abo9vm26ltNIsWu9j839w7R1WVlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th6QybUr+RlaJNBRuM8gmToelsJ2Ssunv54BmX4mf3J3GP80q7ZhMVED5qdoPaJmLC8U1YPNg/RDAQNpa5YoLA1rTYQKKjWJqQfm9XGXtivLhScCbFx1FELgXEzz3e75HWQK52vPfmsM7+JR1nQ7yf0XEY9IWiH7S4eDGpDAe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BD6FEC;
	Thu, 18 Dec 2025 05:43:19 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45493F73F;
	Thu, 18 Dec 2025 05:43:24 -0800 (PST)
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
Date: Thu, 18 Dec 2025 13:42:47 +0000
Message-ID: <20251218134311.2309421-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aUPv5UfBByVoLbRV@willie-the-truck>
References: <aUPv5UfBByVoLbRV@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 12:13:25PM +0000, Will Deacon wrote:
>> Introduce a platform driver that maps the CPER status block described
>> in DeviceTree, feeds it into the estatus core and handles either IRQ- or
>> poll-driven notifications. Arm64 gains a FIX_ESTATUS_IRQ slot so the
>> driver can safely map the shared buffer while copying records.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>  MAINTAINERS                     |   1 +
>>  arch/arm64/include/asm/fixmap.h |   5 +
>>  drivers/ras/Kconfig             |  14 ++
>>  drivers/ras/Makefile            |   1 +
>>  drivers/ras/estatus-dt.c        | 318 ++++++++++++++++++++++++++++++++
>>  include/linux/estatus.h         |   3 +-
>>  6 files changed, 341 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/ras/estatus-dt.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6b2ef2ddc0c7..5567d5e82053 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21761,6 +21761,7 @@ RAS ERROR STATUS
>>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
>>  S:   Maintained
>>  F:   Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
>> +F:   drivers/ras/estatus-dt.c
>>  F:   drivers/firmware/efi/estatus.c
>>  F:   include/linux/estatus.h
>> 
>> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> index 65555284446e..85ffba87bab9 100644
>> --- a/arch/arm64/include/asm/fixmap.h
>> +++ b/arch/arm64/include/asm/fixmap.h
>> @@ -64,6 +64,11 @@ enum fixed_addresses {
>>  #endif
>>  #endif /* CONFIG_ACPI_APEI_GHES */
>> 
>> +#ifdef CONFIG_RAS_ESTATUS_DT
>> +     /* Used for ESTATUS mapping from assorted contexts */
>> +     FIX_ESTATUS_IRQ,
>> +#endif /* CONFIG_RAS_ESTATUS_DT */
>
> Why do we need this in addition to the four existing GHES slots? The DT
> code doesn't use it and I was assuming that the ACPI code would continue
> to use the existing irq; is that not the case?


We still need a dedicated slot when only the DT provider is built.
All four GHES slots are defined as part of the ACPI implementation,
so they are not present in a DT-only configuration.

The estatus core always requests a fixmap index from each provider
before copying a CPER record. As a result, the DT driver must supply
its own slot to return a valid enum value to satisfy the common code.

The ACPI/GHES path continues to use the existing four slots exactly as
before. This change simply ensures that the DT provider does not depend
on ACPI being enabled solely to satisfy the estatus core interface.

Best regards,
Ahmed

