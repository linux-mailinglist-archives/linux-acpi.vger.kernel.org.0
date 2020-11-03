Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21832A4F67
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 19:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgKCSvy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 13:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgKCSvx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 13:51:53 -0500
Received: from C02TF0J2HF1T.local (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781942074B;
        Tue,  3 Nov 2020 18:51:47 +0000 (UTC)
Date:   Tue, 3 Nov 2020 18:51:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/7] arm64: Default to 32-bit wide ZONE_DMA
Message-ID: <20201103185143.GC81026@C02TF0J2HF1T.local>
References: <20201029172550.3523-1-nsaenzjulienne@suse.de>
 <20201030181134.GE23196@gaia>
 <0fc240575aad6a538fdc282e419411a615ba93f3.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc240575aad6a538fdc282e419411a615ba93f3.camel@suse.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 03, 2020 at 06:00:33PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2020-10-30 at 18:11 +0000, Catalin Marinas wrote:
> > On Thu, Oct 29, 2020 at 06:25:43PM +0100, Nicolas Saenz Julienne wrote:
> > > Ard Biesheuvel (1):
> > >   arm64: mm: Set ZONE_DMA size based on early IORT scan
> > > 
> > > Nicolas Saenz Julienne (6):
> > >   arm64: mm: Move reserve_crashkernel() into mem_init()
> > >   arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
> > >   of/address: Introduce of_dma_get_max_cpu_address()
> > >   of: unittest: Add test for of_dma_get_max_cpu_address()
> > >   arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
> > >   mm: Remove examples from enum zone_type comment
> > 
> > Thanks for putting this together. I had a minor comment but the patches
> > look fine to me. We still need an ack from Rob on the DT patch and I can
> > queue the series for 5.11.
> 
> I'm preparing a v6 unifying both functions as you suggested.
> 
> > Could you please also test the patch below on top of this series? It's
> > the removal of the implied DMA offset in the max_zone_phys()
> > calculation.
> 
> Yes, happily. Comments below.
> 
> > --------------------------8<-----------------------------
> > From 3ae252d888be4984a612236124f5b099e804c745 Mon Sep 17 00:00:00 2001
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Date: Fri, 30 Oct 2020 18:07:34 +0000
> > Subject: [PATCH] arm64: Ignore any DMA offsets in the max_zone_phys()
> >  calculation
> > 
> > Currently, the kernel assumes that if RAM starts above 32-bit (or
> > zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
> > such constrained devices have a hardwired DMA offset. In practice, we
> > haven't noticed any such hardware so let's assume that we can expand
> > ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
> > ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
> > zone_bits.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/mm/init.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 095540667f0f..362160e16fb2 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -175,14 +175,21 @@ static void __init reserve_elfcorehdr(void)
> >  #endif /* CONFIG_CRASH_DUMP */
> >  
> >  /*
> > - * Return the maximum physical address for a zone with a given address size
> > - * limit. It currently assumes that for memory starting above 4G, 32-bit
> > - * devices will use a DMA offset.
> > + * Return the maximum physical address for a zone accessible by the given bits
> > + * limit. If the DRAM starts above 32-bit, expand the zone to the maximum
> > + * available memory, otherwise cap it at 32-bit.
> >   */
> >  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> >  {
> > -	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
> > -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> > +	phys_addr_t zone_mask = (1ULL << zone_bits) - 1;
> 
> Maybe use DMA_BIT_MASK(), instead of the manual calculation?

Yes.

> 
> > +	phys_addr_t phys_start = memblock_start_of_DRAM();
> > +
> > +	if (!(phys_start & U32_MAX))
> 
> I'd suggest using 'bigger than' instead of masks. Just to cover ourselves
> against memory starting at odd locations. Also it'll behaves properly when
> phys_start is zero (this breaks things on RPi4).

Good point.

> > +		zone_mask = PHYS_ADDR_MAX;
> > +	else if (!(phys_start & zone_mask))
> > +		zone_mask = U32_MAX;
> > +
> > +	return min(zone_mask + 1, memblock_end_of_DRAM());
> 
> This + 1 isn't going to play well when zone_mask is PHYS_ADDR_MAX.

You are right on PHYS_ADDR_MAX overflowing but I'd keep the +1 since
memblock_end_of_DRAM() returns the first byte past the accessible range
(so exclusive end).

I'll tweak this function a bit to avoid the overflow or use the
arm64-specific PHYS_MASK (that's never going to be the full 64 bits).

Thanks.

-- 
Catalin
