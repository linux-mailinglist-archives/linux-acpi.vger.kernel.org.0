Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3E3119DD
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBFDWK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 22:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhBFDMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 22:12:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE4C0613D6
        for <linux-acpi@vger.kernel.org>; Fri,  5 Feb 2021 19:11:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o21so4472441pgn.12
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2021 19:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03Irav0Kn7d3PmwdWltq8yhVeaa7+Yo6U0jt6YgZEOM=;
        b=DFmxgNlGvwe3ViCthiyT2nkSLaQNiDYG62IdcIyg60j76khiIWkG7ZL85g/T/7FKrU
         OgrzGWOdftRv8IHcr0+PsU/nRTlgiC8Au4wV7DUkVkE9mtP/wAReUXv9qtUtxV3a7crt
         8Ili36d2Ox8kFn/d1XX2mw2XaAaWF5VckKs4EIkTebWbOgDfZzt4tiLHbZSkIsEg6C1l
         FS8z8PWGIAIWh6ISTUTF+C6vHzMxBihpLduERWDRf3sx1iCQu0WS+a1KiB61ZL3OnreY
         9nbgDin9ULICHYmKKpMUikJ4PqhKYl5AIEWMejBekc/JGZNFhYlRs6d55dOA3LPjTQgZ
         xLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03Irav0Kn7d3PmwdWltq8yhVeaa7+Yo6U0jt6YgZEOM=;
        b=bFTmC021aSkEOgxPvIDeRyp+b5bwl9L989Pe5JSpPNeAZ5ZD4lvOpfrw3jHJFSbBIC
         /oM6tQjIeL1I0CaoXFBhr0I3yhWsJijgvt2QRVIZoHVXM2Vy20QwrbaAY+ytDVbHblsh
         K99xTf+e80bvOGHGwmjbHuPpFouPozytphfA32uzQaP7xE3coG9hFIIqOCddjQokJyiS
         8Nma3KVx7aYMrfO5LzISmLC7TLKT4w/b3FkoMNpi3LsR9gatAbsGK6T8vf1EagewEKOt
         rZlOeui0b60E2nJjSBradJ3rLjtFWnzhorsHryGFuPwDs+Pn6mn35Nc4//2HD0VcPDyQ
         nncg==
X-Gm-Message-State: AOAM532PMXi/2vLSL3lWdjND1+rMzj1BsGv5Yff2jSjVwNNzYKu7rHPv
        9FOBQGouIs76KDioC685L6Qggw==
X-Google-Smtp-Source: ABdhPJwrsGW2P1pW+WkekABo8xTR+L+k0eCCXm8bQCwQQOAOFnKsiA1f6hb8gX5zfR74LatrZKR/7A==
X-Received: by 2002:a62:5e44:0:b029:1a4:daae:e765 with SMTP id s65-20020a625e440000b02901a4daaee765mr7426181pfb.8.1612581113257;
        Fri, 05 Feb 2021 19:11:53 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id cq2sm9725597pjb.55.2021.02.05.19.11.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Feb 2021 19:11:52 -0800 (PST)
Date:   Sat, 6 Feb 2021 11:11:46 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/acpi: disallow writeable AML opregion
 mapping for EFI code regions
Message-ID: <20210206031145.GA27503@dragon>
References: <20200626155832.2323789-1-ardb@kernel.org>
 <20200626155832.2323789-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626155832.2323789-3-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard,

On Fri, Jun 26, 2020 at 05:58:32PM +0200, Ard Biesheuvel wrote:
> Given that the contents of EFI runtime code and data regions are
> provided by the firmware, as well as the DSDT, it is not unimaginable
> that AML code exists today that accesses EFI runtime code regions using
> a SystemMemory OpRegion. There is nothing fundamentally wrong with that,
> but since we take great care to ensure that executable code is never
> mapped writeable and executable at the same time, we should not permit
> AML to create writable mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I'm booting Lenovo Flex 5G laptop with ACPI, and seeing this change
causes a memory abort[1] when upgrading ACPI tables via initrd[2].
Dropping this change seems to fix the issue for me.  But does that
looks like a correct fix to you?

Shawn

[1] https://fileserver.linaro.org/s/iDe9SaZeNNkyNxG
[2] Documentation/admin-guide/acpi/initrd_table_override.rst

> ---
>  arch/arm64/kernel/acpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 01b861e225b0..455966401102 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -301,6 +301,15 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
>  			return NULL;
>  
> +		case EFI_RUNTIME_SERVICES_CODE:
> +			/*
> +			 * This would be unusual, but not problematic per se,
> +			 * as long as we take care not to create a writable
> +			 * mapping for executable code.
> +			 */
> +			prot = PAGE_KERNEL_RO;
> +			break;
> +
>  		case EFI_ACPI_RECLAIM_MEMORY:
>  			/*
>  			 * ACPI reclaim memory is used to pass firmware tables
> -- 
> 2.27.0
