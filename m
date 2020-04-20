Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6351B05AB
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Apr 2020 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTJbD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Apr 2020 05:31:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgDTJbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 05:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06ECD30E;
        Mon, 20 Apr 2020 02:31:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13BB23F73D;
        Mon, 20 Apr 2020 02:31:01 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:30:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        sudeep.holla@arm.com, guohanjun@huawei.com, robin.murphy@arm.com
Subject: Re: [PATCH] acpi: arm64/iort: Ensure DMA mask does not exceed device
 limit
Message-ID: <20200420093055.GA7393@e121166-lin.cambridge.arm.com>
References: <20200420081131.16822-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420081131.16822-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+Robin]

On Mon, Apr 20, 2020 at 10:11:31AM +0200, Ard Biesheuvel wrote:
> When calculating the DMA mask from the address limit provided by the
> firmware, we add one to the ilog2() of the end address, and pass the
> result to DMA_BIT_MASK().
> 
> For an end address that is not a power-of-2 minus 1, this will result
> in the mask to be wider than the limit, and cover memory that is not
> addressable by the device. Instead, we should add 1 to 'end' before
> taking the log, so that a limit of, say, 0x3fffffff gets translated
> to a mask of 30, but any value below it gets translated to 29.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Need Robin's feedback on this - I was looking at:

a7ba70f1787f ("dma-mapping: treat dev->bus_dma_mask as a DMA limit")

I assume current code is *intended* but I shall let Robin comment
on this.

Thanks,
Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7d04424189df..aab2f51eff14 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1162,7 +1162,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  		 * firmware.
>  		 */
>  		end = dmaaddr + size - 1;
> -		mask = DMA_BIT_MASK(ilog2(end) + 1);
> +		mask = DMA_BIT_MASK(ilog2(end + 1));
>  		dev->bus_dma_limit = end;
>  		dev->coherent_dma_mask = mask;
>  		*dev->dma_mask = mask;
> -- 
> 2.17.1
> 
