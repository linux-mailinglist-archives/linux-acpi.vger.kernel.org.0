Return-Path: <linux-acpi+bounces-13382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEEDAA4838
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13454C6AD0
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B924679E;
	Wed, 30 Apr 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChGWKdLZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A7246798;
	Wed, 30 Apr 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008687; cv=none; b=Z1HUCJ02CXhcDxHzJsyMeYb0HHNZZkR1nnacXz9vFck2Pz6VGO+MkPBp7SXl3TVMPVvUrm3Q0gXxdRIk5Znr7R5WwSzVMZgRHrmMy2i8CRbt+MJ/8jrymLNFWYSYu90r2EPtI8oVFxGHxFs9vHLxJsXwLTV/1oNumAZnl4cOnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008687; c=relaxed/simple;
	bh=eKfkflY+nlOOGx+pGhNBk8yKSaGeuwtY9rXz667lGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3MmKTxq2rKZ8HMZfw4IWrzxFss8ZfVrUOYiszyzVB+FSUUpJiydF/DkxjBSY3To9dnzD883SvUrfofidE0VWRyIg2w88ourqVU5akAsBzo2hKVFF2lr5d1mk26QwL82iaLByaX6xJevM314ygeoe3ypfwFzw4N6DBShSgoWOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChGWKdLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E059C4CEE9;
	Wed, 30 Apr 2025 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746008687;
	bh=eKfkflY+nlOOGx+pGhNBk8yKSaGeuwtY9rXz667lGQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChGWKdLZiwptIeQqo75HXMnKHrLSjUzG8gnKD0Z/AGwMy78QJLAlaCyl9xEsZdB7S
	 Quk0LZWc38anQYBG5auFKXvoBAPGFb65qK6f5yYvCERVi6lYKf3ptVMPtdaI0vhhQ7
	 AOnE6dSuvFUCw3Cr5rZtZ8e6tEvW/fCvruKRhaMedCAF28eyMxuwXRIiB+1eK25ywI
	 NoIwiXsPpBUS23NoX7WUqzJpkAVPzO0+tKg4DLlTV64eLbMPW3Af/xWutS+xyX0vmI
	 d6jlH6WTV04jIcMyMVmpfsiC2BzNOu0ymCgcccM2z7ooC06RdUIiXzy7tUCF7fu2ea
	 3i6hLKToK/3Ug==
Date: Wed, 30 Apr 2025 11:24:41 +0100
From: Will Deacon <will@kernel.org>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, xueshuai@linux.alibaba.com,
	quic_aiquny@quicinc.com, quic_satyap@quicinc.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
	kernel@oss.qualcomm.com
Subject: Re: [PATCH] firmware: SDEI: Allow sdei initialization without
 ACPI_APEI_GHES
Message-ID: <20250430102440.GA27570@willie-the-truck>
References: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 28, 2025 at 05:56:23PM +0800, Huang Yiwei wrote:
> SDEI usually initialize with the ACPI table, but on platforms where
> ACPI is not used, the SDEI feature can still be used to handle
> specific firmware calls or other customized purposes. Therefore, it
> is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.
> 
> In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
> in acpi_init()"), to make APEI ready earlier, sdei_init was moved
> into acpi_ghes_init instead of being a standalone initcall, adding
> ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
> flexibility and usability of SDEI.
> 
> This patch corrects the dependency in Kconfig and allows the
> initialization of SDEI without ACPI_APEI_GHES enabled.
> 
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
> Link: https://lore.kernel.org/all/20230906130900.12218-1-schspa@gmail.com/
> 
> Current patch has been verified in the following scenarios:
>   - ACPI_APEI_GHES enabled and ARM_SDE_INTERFACE enabled
>   - ACPI_APEI_GHES disabled and ARM_SDE_INTERFACE enabled
>   - ACPI_APEI_GHES disabled and ARM_SDE_INTERFACE disabled
>   - SDEI works well with DT node and compatiable firmware when
>     ACPI_APEI_GHES disabled
> 
> The scenario where CONFIG_ACPI enabled but not used has not been
> considered in this patch due to the absence of such platform.
> 
>  drivers/acpi/apei/Kconfig   | 1 +
>  drivers/firmware/Kconfig    | 1 -
>  drivers/firmware/arm_sdei.c | 9 +++++++--
>  include/linux/arm_sdei.h    | 4 ++--
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 3cfe7e7475f2..070c07d68dfb 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -23,6 +23,7 @@ config ACPI_APEI_GHES
>  	select ACPI_HED
>  	select IRQ_WORK
>  	select GENERIC_ALLOCATOR
> +	select ARM_SDE_INTERFACE if ARM64
>  	help
>  	  Generic Hardware Error Source provides a way to report
>  	  platform hardware errors (such as that from chipset). It
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index aadc395ee168..7df19d82aa68 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -31,7 +31,6 @@ config ARM_SCPI_PROTOCOL
>  config ARM_SDE_INTERFACE
>  	bool "ARM Software Delegated Exception Interface (SDEI)"
>  	depends on ARM64
> -	depends on ACPI_APEI_GHES
>  	help
>  	  The Software Delegated Exception Interface (SDEI) is an ARM
>  	  standard for registering callbacks from the platform firmware
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 3e8051fe8296..ddb10389b340 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1062,14 +1062,14 @@ static bool __init sdei_present_acpi(void)
>  	return true;
>  }
>  
> -void __init sdei_init(void)
> +int __init sdei_init(void)
>  {
>  	struct platform_device *pdev;
>  	int ret;
>  
>  	ret = platform_driver_register(&sdei_driver);
>  	if (ret || !sdei_present_acpi())
> -		return;
> +		return ret;
>  
>  	pdev = platform_device_register_simple(sdei_driver.driver.name,
>  					       0, NULL, 0);
> @@ -1079,7 +1079,12 @@ void __init sdei_init(void)
>  		pr_info("Failed to register ACPI:SDEI platform device %d\n",
>  			ret);
>  	}
> +
> +	return ret;
>  }
> +#ifndef CONFIG_ACPI_APEI_GHES
> +subsys_initcall_sync(sdei_init);
> +#endif

Using an initcall purely for the non-ACPI case feels like a hack to me.
Could we instead just call sdei_init() from the arch code (and remove
the call from acpi_ghes_init()) so that the platform device is
registered at the same time, regardless of the firmware?

Will

