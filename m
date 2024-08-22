Return-Path: <linux-acpi+bounces-7792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0995C065
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55BF1F23B6B
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF091D173E;
	Thu, 22 Aug 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs2zFAA9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A6A933;
	Thu, 22 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363058; cv=none; b=VFaMXfWm4t+lvj1TlLw8+6W5UZFU5p0xbiowHsdf4zUlcCOEQQ1Ex+u+Vss56HX53wpf6jiPQyG1NDNuGh9RdCbGBarWV0hkfyrusgyLWmnpo07GcEWgBE+oPwdSRkxndrhjxZ4aNcLoC746rUW2YCigipZGXRP3uJoWIxI5L1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363058; c=relaxed/simple;
	bh=wouLQ1NMCmEgVtTZfpizED4KYxY6busZQVGhvu31U9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W4RSLzu9n9EgXuuhgBMFMkKQyEJCCSgszBJInKN8vhLAy/i8oYSzjhPZo7ufCXnNuCfLsvBI6flQWx/Ta4aQ9d4H0vVsx+a1v8GbiV59iCSSdISQI2DUnVFXu+fibgL+UhXyTSTbXtr/Mz0QwgGO3rjnVA7doBZlljZjJfHpXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs2zFAA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396D8C32782;
	Thu, 22 Aug 2024 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724363057;
	bh=wouLQ1NMCmEgVtTZfpizED4KYxY6busZQVGhvu31U9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xs2zFAA9+v+tdLOs3jXLguv9xMVkhnYJ59w6LWKQLse0VkgpY4n3M9GfnAqMgUxgg
	 mNQgmv2j5woLX2DsJDcZWJtxsWxnZVNLcQR3pLujkDw/ccz0d5tabsnuK/iD6TBGsB
	 t6sXdIdz+6bLGcQqNRCzCRhpIqLFDYniLxrB8/L+wpQtGPGmvs+j/2iANc7GyIs+Hl
	 cDGTOu9lQTSkUNeYComLCaJ5NUiIQBlMmJScKnb/2i64YGpmxy1cQVdiCZjBJd6vtr
	 O+bq13w1mDVy67a72wMbT+OsLDdhhGwPMprv02UfNs2rIRUeKc3Sl1v8pgSefHlAsE
	 01Ok7tLTOSowg==
Date: Thu, 22 Aug 2024 16:44:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <20240822214415.GA351762@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812005929.113499-9-sunilvl@ventanamicro.com>

On Mon, Aug 12, 2024 at 06:29:20AM +0530, Sunil V L wrote:
> RISC-V platforms need to use dependencies between PCI host bridge, Link
> devices and the interrupt controllers to ensure probe order. The
> dependency is like below.
> 
> Interrupt controller <-- Link Device <-- PCI Host bridge.
> 
> If there is no dependency between Link device and PCI Host Bridge,
> then PCI devices may be probed prior to Link devices.  If a PCI
> device is probed before its Link device, we won't be able to find
> its INTx mapping.

This seems to explain why we want these dependencies, which is useful,
but *this* patch only removes the dependencies.

Maybe this description should be in the patch that *adds* the
dependencies, e.g., "ACPI: RISC-V: Implement function to add implicit
dependencies"?

> So, add the link device's HID to dependency honor list and clear the
> dependency after probe is done so that the dependent devices are
> unblocked to probe.

This still claims this patch adds HID, which I don't think it does.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> ---
>  drivers/acpi/pci_link.c | 2 ++
>  drivers/acpi/scan.c     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index aa1038b8aec4..b727db968f33 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
>  	if (result)
>  		kfree(link);
>  
> +	acpi_dev_clear_dependencies(device);
> +
>  	return result < 0 ? result : 1;
>  }
>  
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 28a221f956d7..753539a1f26b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
>  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
>  	"RSCV0001", /* RISC-V PLIC */
>  	"RSCV0002", /* RISC-V APLIC */
> +	"PNP0C0F",  /* PCI Link Device */
>  	NULL
>  };
>  
> -- 
> 2.43.0
> 

