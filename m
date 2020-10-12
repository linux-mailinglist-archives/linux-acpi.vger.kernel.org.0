Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDF28B189
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgJLJ21 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 05:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387393AbgJLJ20 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Oct 2020 05:28:26 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172F12080D;
        Mon, 12 Oct 2020 09:28:23 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:28:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        will@kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Message-ID: <20201012092821.GB9844@gaia>
References: <20201010093153.30177-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010093153.30177-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 10, 2020 at 11:31:53AM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f0599ae73b8d..829fa63c3d72 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  
>  #ifdef CONFIG_ZONE_DMA
> +	if (IS_ENABLED(CONFIG_ACPI)) {
> +		extern unsigned int acpi_iort_get_zone_dma_size(void);

Nitpick: can we add this prototype to include/linux/acpi_iort.h?

> +
> +		zone_dma_bits = min(zone_dma_bits,
> +				    acpi_iort_get_zone_dma_size());
> +		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	}
> +
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);

I think we should initialise zone_dma_bits slightly earlier via
arm64_memblock_init(). We'll eventually have reserve_crashkernel()
called before this and it will make use of arm64_dma_phys_limit for
"low" reservations:

https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-7-chenzhou10@huawei.com/

-- 
Catalin
