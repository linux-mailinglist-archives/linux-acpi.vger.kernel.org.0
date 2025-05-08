Return-Path: <linux-acpi+bounces-13623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005BAAF08C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 03:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138B69C7BB7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E078F29;
	Thu,  8 May 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bW6IJR9T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667C28F4;
	Thu,  8 May 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667033; cv=none; b=QsAGiX9gKCBG10c3muzpPqEmL34At6zubBvLTJRLkdqBJAFXSjm98cp+pxcU5X1kDZGBHadvA2mkm+VMxp1aRylEwudvuhQEi8SzNGZSxMhwqFS/1Gnu3XMedmYNt86BjR90E1I9/cuUwyJnzYDLfqp0hL60VpFN0oLd+o9VP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667033; c=relaxed/simple;
	bh=37Xyc+/nftgdtxlpcfHPBKuu5cIvJQHLf541DJ3NwoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm7kO0pI93A5SQiUVL80umguX2vVVqVGM8+GpkJqIhbr0069s8NcX1frZdWpxHoRJJG020sKhoE35G7eRQjZAZGZjEQ0JgAewisWHDFEU0khWxo6fSMCELFIs6nqAkkaO46Qv/11CFaKMx2v6IZQutuNqncx5ukfoB7ObTlyhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bW6IJR9T; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746667021; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tW62iOPUC5gBFt1aqH+RWrFlUGzaF/8Z02g9y3LTJjQ=;
	b=bW6IJR9Tc+v0OIhwhH1X1dhEI7g1p3nmKljB/tVuajEVQ7YAvDyLROSjGl33ERwnOk68OpRc0KWnQIxxMHvzL7sbHuqFO7ViVQYXhgRABmTgvpBsUhfWDJoN+EiSpl7yvHRE3lXBxhX25cigaDj5vKgaV3iyTWyfs5/wDAzHOF0=
Received: from 30.246.160.110(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WZy-uMo_1746666700 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 May 2025 09:11:41 +0800
Message-ID: <750e66eb-f5c8-4127-8c02-14b8928f7a28@linux.alibaba.com>
Date: Thu, 8 May 2025 09:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: SDEI: Allow sdei initialization without
 ACPI_APEI_GHES
To: Huang Yiwei <quic_hyiwei@quicinc.com>, will@kernel.org,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de
Cc: quic_aiquny@quicinc.com, quic_satyap@quicinc.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
 kernel@oss.qualcomm.com
References: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/7 12:57, Huang Yiwei 写道:
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
> This patch corrects the dependency in Kconfig and splits sdei_init()
> into two separate functions: sdei_init() and acpi_sdei_init().
> sdei_init() will be called by arch_initcall and will only initialize
> the platform driver, while acpi_sdei_init() will initialize the
> device from acpi_ghes_init() when ACPI is ready. This allows the
> initialization of SDEI without ACPI_APEI_GHES enabled.
> 
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
>   drivers/acpi/apei/Kconfig   |  1 +
>   drivers/acpi/apei/ghes.c    |  2 +-
>   drivers/firmware/Kconfig    |  1 -
>   drivers/firmware/arm_sdei.c | 11 ++++++++---
>   include/linux/arm_sdei.h    |  4 ++--
>   5 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 3cfe7e7475f2..070c07d68dfb 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -23,6 +23,7 @@ config ACPI_APEI_GHES
>   	select ACPI_HED
>   	select IRQ_WORK
>   	select GENERIC_ALLOCATOR
> +	select ARM_SDE_INTERFACE if ARM64
>   	help
>   	  Generic Hardware Error Source provides a way to report
>   	  platform hardware errors (such as that from chipset). It
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 289e365f84b2..0f3c663c1b0a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1715,7 +1715,7 @@ void __init acpi_ghes_init(void)
>   {
>   	int rc;
>   
> -	sdei_init();
> +	acpi_sdei_init();
>   
>   	if (acpi_disabled)
>   		return;
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index aadc395ee168..7df19d82aa68 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -31,7 +31,6 @@ config ARM_SCPI_PROTOCOL
>   config ARM_SDE_INTERFACE
>   	bool "ARM Software Delegated Exception Interface (SDEI)"
>   	depends on ARM64
> -	depends on ACPI_APEI_GHES
>   	help
>   	  The Software Delegated Exception Interface (SDEI) is an ARM
>   	  standard for registering callbacks from the platform firmware
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 3e8051fe8296..71e2a9a89f6a 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1062,13 +1062,12 @@ static bool __init sdei_present_acpi(void)
>   	return true;
>   }
>   
> -void __init sdei_init(void)
> +void __init acpi_sdei_init(void)
>   {
>   	struct platform_device *pdev;
>   	int ret;
>   
> -	ret = platform_driver_register(&sdei_driver);
> -	if (ret || !sdei_present_acpi())
> +	if (!sdei_present_acpi())
>   		return;
>   
>   	pdev = platform_device_register_simple(sdei_driver.driver.name,
> @@ -1081,6 +1080,12 @@ void __init sdei_init(void)
>   	}
>   }
>   
> +static int __init sdei_init(void)
> +{
> +	return platform_driver_register(&sdei_driver);
> +}
> +arch_initcall(sdei_init);
> +
>   int sdei_event_handler(struct pt_regs *regs,
>   		       struct sdei_registered_event *arg)
>   {
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 255701e1251b..f652a5028b59 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -46,12 +46,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
>   /* For use by arch code when CPU hotplug notifiers are not appropriate. */
>   int sdei_mask_local_cpu(void);
>   int sdei_unmask_local_cpu(void);
> -void __init sdei_init(void);
> +void __init acpi_sdei_init(void);
>   void sdei_handler_abort(void);
>   #else
>   static inline int sdei_mask_local_cpu(void) { return 0; }
>   static inline int sdei_unmask_local_cpu(void) { return 0; }
> -static inline void sdei_init(void) { }
> +static inline void acpi_sdei_init(void) { }
>   static inline void sdei_handler_abort(void) { }
>   #endif /* CONFIG_ARM_SDE_INTERFACE */
>   

LGTM. Thanks.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Shuai


