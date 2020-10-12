Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86D28B275
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgJLKnS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 06:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387596AbgJLKnR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Oct 2020 06:43:17 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8152078E
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602499396;
        bh=AJ0Fhu60Tr804rRCM1+P680y3M3FPp/EV8RIsUNxmZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QUrMCuOUSGgm6NhT34utLHj+2M3cYSn2ZzDRFXsfAalA6phMTCwNzIZSy6STpPxU1
         NsZkH8QXngPNzTzDCNVFgVAkkcPU8pukrcNasOXajnsQIUXOIdh+Zh7n7Ih9Hmhqr6
         +fee0mjuWDL2YCkN24H45r84U/o1PwbUrllnKWV8=
Received: by mail-oi1-f173.google.com with SMTP id s81so5878527oie.13
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 03:43:16 -0700 (PDT)
X-Gm-Message-State: AOAM533tJWmwN+aZVqihpKYX/DnjEnZGBKUMfqceuE4+AD/L6+5cMadL
        ZR8cRN13/Vvg03mSEHvHnQ1Hyv0Ip+qdI59oxW8=
X-Google-Smtp-Source: ABdhPJy+fq4uKCteCCnTri1DaNthEYUGEsliRxVnw0Pxl+Uia5bYwZ4wO/aZBWBU9kpgLTCrrg3y3cDwUSVk7q9xc/Q=
X-Received: by 2002:aca:d845:: with SMTP id p66mr9727095oig.47.1602499395977;
 Mon, 12 Oct 2020 03:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201010093153.30177-1-ardb@kernel.org> <20201012092821.GB9844@gaia>
 <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
In-Reply-To: <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 12:43:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
Message-ID: <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 12 Oct 2020 at 11:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 12 Oct 2020 at 11:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Sat, Oct 10, 2020 at 11:31:53AM +0200, Ard Biesheuvel wrote:
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index f0599ae73b8d..829fa63c3d72 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> > >
> > >  #ifdef CONFIG_ZONE_DMA
> > > +     if (IS_ENABLED(CONFIG_ACPI)) {
> > > +             extern unsigned int acpi_iort_get_zone_dma_size(void);
> >
> > Nitpick: can we add this prototype to include/linux/acpi_iort.h?
> >
> > > +
> > > +             zone_dma_bits = min(zone_dma_bits,
> > > +                                 acpi_iort_get_zone_dma_size());
> > > +             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > > +     }
> > > +
> > >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> >
> > I think we should initialise zone_dma_bits slightly earlier via
> > arm64_memblock_init(). We'll eventually have reserve_crashkernel()
> > called before this and it will make use of arm64_dma_phys_limit for
> > "low" reservations:
> >
> > https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-7-chenzhou10@huawei.com/
> >
>
> We don't have access to the ACPI tables yet at that point.

Also, could someone give an executive summary of why it matters where
the crashkernel is loaded? As far as I can tell, reserve_crashkernel()
only allocates memory for the kernel's executable image itself, which
can usually be loaded anywhere in memory. I could see how a
crashkernel might need some DMA'able memory if it needs to use the
hardware, but I don't think that is what is going on here.
