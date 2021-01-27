Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E709E305981
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhA0LWB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 06:22:01 -0500
Received: from foss.arm.com ([217.140.110.172]:40224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236492AbhA0LUB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 06:20:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB23E31B;
        Wed, 27 Jan 2021 03:19:14 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24303F66B;
        Wed, 27 Jan 2021 03:19:13 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:19:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, moritzf@google.com, will@kernel.org
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from
 firmware
Message-ID: <20210127111908.GA9766@e121166-lin.cambridge.arm.com>
References: <20210122012419.95010-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122012419.95010-1-mdf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 05:24:19PM -0800, Moritz Fischer wrote:
> Address issue observed on real world system with suboptimal IORT table
> where DMA masks of PCI devices would get set to 0 as result.
> 
> iort_dma_setup() would query the root complex'/named component IORT
> entry for a DMA mask, and use that over the one the device has been
> configured with earlier.
> 
> Ideally we want to use the minimum mask of what the IORT contains for
> the root complex and what the device was configured with.
> 
> Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes from v1:
> - Changed warning to FW_BUG
> - Warn for both Named Component or Root Complex
> - Replaced min_not_zero() with min()
> 
> ---
>  drivers/acpi/arm64/iort.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d4eac6d7e9fb..2494138a6905 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1107,6 +1107,11 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>  
>  	ncomp = (struct acpi_iort_named_component *)node->node_data;
>  
> +	if (!ncomp->memory_address_limit) {
> +		pr_warn(FW_BUG "Named component missing memory address limit\n");
> +		return -EINVAL;
> +	}
> +
>  	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
>  			1ULL<<ncomp->memory_address_limit;
>  
> @@ -1126,6 +1131,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>  
>  	rc = (struct acpi_iort_root_complex *)node->node_data;
>  
> +	if (!rc->memory_address_limit) {
> +		pr_warn(FW_BUG "Root complex missing memory address limit\n");
> +		return -EINVAL;
> +	}
> +
>  	*size = rc->memory_address_limit >= 64 ? U64_MAX :
>  			1ULL<<rc->memory_address_limit;
>  
> @@ -1173,8 +1183,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  		end = dmaaddr + size - 1;
>  		mask = DMA_BIT_MASK(ilog2(end) + 1);
>  		dev->bus_dma_limit = end;
> -		dev->coherent_dma_mask = mask;
> -		*dev->dma_mask = mask;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);
>  	}
>  
>  	*dma_addr = dmaaddr;
> -- 
> 2.30.0
> 
