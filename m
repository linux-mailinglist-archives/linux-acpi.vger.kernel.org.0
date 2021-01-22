Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDD3005BE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbhAVOnf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 09:43:35 -0500
Received: from foss.arm.com ([217.140.110.172]:51162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbhAVOm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 09:42:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB90D11B3;
        Fri, 22 Jan 2021 06:42:07 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9853F66E;
        Fri, 22 Jan 2021 06:42:05 -0800 (PST)
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from
 firmware
To:     Moritz Fischer <mdf@kernel.org>, lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210122012419.95010-1-mdf@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e01e2fd6-7f78-354e-374c-f93a5d1b8fd6@arm.com>
Date:   Fri, 22 Jan 2021 14:42:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122012419.95010-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-01-22 01:24, Moritz Fischer wrote:
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
>   drivers/acpi/arm64/iort.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d4eac6d7e9fb..2494138a6905 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1107,6 +1107,11 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>   
>   	ncomp = (struct acpi_iort_named_component *)node->node_data;
>   
> +	if (!ncomp->memory_address_limit) {
> +		pr_warn(FW_BUG "Named component missing memory address limit\n");
> +		return -EINVAL;
> +	}
> +
>   	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
>   			1ULL<<ncomp->memory_address_limit;
>   
> @@ -1126,6 +1131,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>   
>   	rc = (struct acpi_iort_root_complex *)node->node_data;
>   
> +	if (!rc->memory_address_limit) {
> +		pr_warn(FW_BUG "Root complex missing memory address limit\n");
> +		return -EINVAL;
> +	}
> +
>   	*size = rc->memory_address_limit >= 64 ? U64_MAX :
>   			1ULL<<rc->memory_address_limit;
>   
> @@ -1173,8 +1183,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   		end = dmaaddr + size - 1;
>   		mask = DMA_BIT_MASK(ilog2(end) + 1);
>   		dev->bus_dma_limit = end;
> -		dev->coherent_dma_mask = mask;
> -		*dev->dma_mask = mask;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);

Oops, I got so distracted by the "not_zero" aspect in v1 that I ended up 
thinking purely about smaller-than-default masks, but of course this 
*does* matter the other way round. And it is what we've always done on 
the DT side, so at least it makes us consistent.

FWIW I've already started writing up a patch to kill off this bit 
entirely, but either way we still can't meaningfully interpret a 
supposed DMA limit of 0 bits in a table describing DMA-capable devices, 
so for this patch as a fix,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

>   	}
>   
>   	*dma_addr = dmaaddr;
> 
