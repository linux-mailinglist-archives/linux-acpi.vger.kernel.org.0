Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D528BD02
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgJLPz5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 11:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730508AbgJLPz5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Oct 2020 11:55:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A7120797
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602518156;
        bh=hub1pUsQ6j4L0DSXsL6UZmMPdK88ONZg32/xMFIkibA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GzUeYmUT79wPmNg+ZR9wLa6+/0VcgOZyyaA0aVLgk8fknD58q/5HU7F1IKWPvnpV8
         rfE5Gdls4DY0ZPxmvFVOvf+vHZ9RQSh/8o+PdUTCCTmoatDpMBgoidPKuu8C7OBDij
         ekx/jcAZLXtSNy6dBP6pZzAR3Pb49Cxhum67WhRU=
Received: by mail-oi1-f172.google.com with SMTP id 16so19149509oix.9
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 08:55:56 -0700 (PDT)
X-Gm-Message-State: AOAM531K4/Tqi065VBpxB5hKoKlGnDGJGVCa7VTVx4mVfJyfJUUq0/Lo
        Tghlay6/d5Vg6hxyAEySJ+CLRChkxhOy1f+dn34=
X-Google-Smtp-Source: ABdhPJwOaUVqeXUONPkmLLacYp4eFynS2HQ4PinEgAttyptU8xRimxnqS+i6ERzts5Dwz1grElg0MwKybl8PwrNtNZY=
X-Received: by 2002:aca:4085:: with SMTP id n127mr3252731oia.33.1602518156075;
 Mon, 12 Oct 2020 08:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201010093153.30177-1-ardb@kernel.org> <20201012092821.GB9844@gaia>
 <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
 <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
 <20201012112453.GD9844@gaia> <CAMj1kXEmAxytDjcAgpGpCqWcEuO0HijLVuTZcz-vywW=a74mmA@mail.gmail.com>
 <20201012154954.GB6493@gaia>
In-Reply-To: <20201012154954.GB6493@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 17:55:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
Message-ID: <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
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

On Mon, 12 Oct 2020 at 17:50, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Oct 12, 2020 at 04:19:08PM +0200, Ard Biesheuvel wrote:
> > On Mon, 12 Oct 2020 at 13:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Oct 12, 2020 at 12:43:05PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 12 Oct 2020 at 11:30, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > On Mon, 12 Oct 2020 at 11:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > On Sat, Oct 10, 2020 at 11:31:53AM +0200, Ard Biesheuvel wrote:
> > > > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > > > index f0599ae73b8d..829fa63c3d72 100644
> > > > > > > --- a/arch/arm64/mm/init.c
> > > > > > > +++ b/arch/arm64/mm/init.c
> > > > > > > @@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > > > > > >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> > > > > > >
> > > > > > >  #ifdef CONFIG_ZONE_DMA
> > > > > > > +     if (IS_ENABLED(CONFIG_ACPI)) {
> > > > > > > +             extern unsigned int acpi_iort_get_zone_dma_size(void);
> > > > > >
> > > > > > Nitpick: can we add this prototype to include/linux/acpi_iort.h?
> > > > > >
> > > > > > > +
> > > > > > > +             zone_dma_bits = min(zone_dma_bits,
> > > > > > > +                                 acpi_iort_get_zone_dma_size());
> > > > > > > +             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > > > > > > +     }
> > > > > > > +
> > > > > > >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> > > > > >
> > > > > > I think we should initialise zone_dma_bits slightly earlier via
> > > > > > arm64_memblock_init(). We'll eventually have reserve_crashkernel()
> > > > > > called before this and it will make use of arm64_dma_phys_limit for
> > > > > > "low" reservations:
> > > > > >
> > > > > > https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-7-chenzhou10@huawei.com/
> > > > > >
> > > > >
> > > > > We don't have access to the ACPI tables yet at that point.
> > > >
> > > > Also, could someone give an executive summary of why it matters where
> > > > the crashkernel is loaded? As far as I can tell, reserve_crashkernel()
> > > > only allocates memory for the kernel's executable image itself, which
> > > > can usually be loaded anywhere in memory. I could see how a
> > > > crashkernel might need some DMA'able memory if it needs to use the
> > > > hardware, but I don't think that is what is going on here.
> > >
> > > I thought the crashkernel needs some additional reserved RAM as well to
> > > be able to run. It should not touch the original kernel's memory as it
> > > usually needs to dump it.
> >
> > Looking at the code, it is definitely allocating memory for the kernel
> > itself (as it refers to the 2 MB alignment requirement), and given
> > that we used to require the kernel to be at the base of the linear
> > region to even be able to access all of memory, I suspect that we
> > might be able to relax this requirement. Not sure what that means for
> > the userland tools, though.
>
> The 2MB is an interpretation of booting.txt that the DRAM must start at
> this alignment (not sure what we do these days, in lots of
> configurations we just use 4K pages for the linear map).
>

On 4k granule kernels, We still need 2 MB alignment today unless you
use a relocatable kernel. The reason is that virtual addresses are
assigned at link time, and we use section mappings to map the kernel.
If CONFIG_RELOCATABLE=y, the kernel can run happily at any 64k aligned
address (except for the 64k granule kernel with CONFIG_VMAP=y, which
needs 128k in this case)

So keeping a 2 MB alignment requirement in booting.txt still makes sense.

> However, the crashkernel=... range is meant for sufficiently large
> reservation to be able to run the kdump kernel, not just load the image.
>

Sure. But I was referring to the requirement that it is loaded low in
memory. Unless I am misunderstanding something, all we need for the
crashkernel to be able to operate is some ZONE_DMA memory in case it
is needed by the hardware, and beyond that, it could happily live
anywhere in memory.
