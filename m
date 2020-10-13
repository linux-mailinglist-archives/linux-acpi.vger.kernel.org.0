Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFE28CCB0
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgJMLnk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 07:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgJMLnk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 07:43:40 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E9F2080A
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2020 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602589419;
        bh=9yuBNnRR2p1Vja+yc90NKTUA2cfYCx353by450sECpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sjEa3SissCOEIpSoYbuyRZAwJxs+XqpY2X78M5H6AHo590rpgEo6Ihho9hGBQsP5V
         o5x9RM+eQ99iPYdiviH63GRnEaOTkUONYs1oV5NCy6ZDcXgAKXWsyqc8MDex5siiJU
         gjL69pLasZ+56WxqHU/MICjD3oTpq18vYRAsO6bI=
Received: by mail-oo1-f53.google.com with SMTP id f19so4529289oot.4
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2020 04:43:39 -0700 (PDT)
X-Gm-Message-State: AOAM532MGLKgaytNqtEswvowtfb5LqPVziq+S1AnMU879uaehkDMyGUa
        bc/Ph+8UkJNpI+usRMv5QUXcxK79uv4ygK5sUPE=
X-Google-Smtp-Source: ABdhPJxs10R58RNhe6BywzF6G0oqoyPit43IvYBpXbn3y9LEmQgJPaYU1xCr+C02ZXKC8V1BSyog6jggDBKE2dVJQ78=
X-Received: by 2002:a4a:c3ca:: with SMTP id e10mr21829692ooq.41.1602589418491;
 Tue, 13 Oct 2020 04:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201010093153.30177-1-ardb@kernel.org> <20201013110929.GB20319@e121166-lin.cambridge.arm.com>
 <CAMj1kXEbZ3cN1N2V6MfbUZsTot+9TsLTC_UMm5JP1OW8AwvuOw@mail.gmail.com> <CAMj1kXGFHk0qAJoh+SSAS0qgUfe4zDuLmqNMT+Cw1GCZFCLSqg@mail.gmail.com>
In-Reply-To: <CAMj1kXGFHk0qAJoh+SSAS0qgUfe4zDuLmqNMT+Cw1GCZFCLSqg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Oct 2020 13:43:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHDbzYdq5XHo0Qk6xmCkj=tX+nh=fgWjDxAJaY4g-X7kA@mail.gmail.com>
Message-ID: <CAMj1kXHDbzYdq5XHo0Qk6xmCkj=tX+nh=fgWjDxAJaY4g-X7kA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
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

On Tue, 13 Oct 2020 at 13:38, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 13 Oct 2020 at 13:22, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 13 Oct 2020 at 13:09, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Sat, Oct 10, 2020 at 11:31:53AM +0200, Ard Biesheuvel wrote:
> > > > We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> > > > incorporating masters that can address less than 32 bits of DMA, in
> > > > particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> > > > peripherals that can only address up to 1 GB (and its PCIe host
> > > > bridge can only access the bottom 3 GB)
> > > >
> > > > Instructing the DMA layer about these limitations is straight-forward,
> > > > even though we had to fix some issues regarding memory limits set in
> > > > the IORT for named components, and regarding the handling of ACPI _DMA
> > > > methods. However, the DMA layer also needs to be able to allocate
> > > > memory that is guaranteed to meet those DMA constraints, for bounce
> > > > buffering as well as allocating the backing for consistent mappings.
> > > >
> > > > This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> > > > it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> > > > problems with kdump, and potentially in other places where allocations
> > > > cannot cross zone boundaries. Therefore, we should avoid having two
> > > > separate DMA zones when possible.
> > > >
> > > > So let's do an early scan of the IORT, and only create the ZONE_DMA
> > > > if we encounter any devices that need it. This puts the burden on
> > > > the firmware to describe such limitations in the IORT, which may be
> > > > redundant (and less precise) if _DMA methods are also being provided.
> > > > However, it should be noted that this situation is highly unusual for
> > > > arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> > > > the _DMA method if implemented, and so we will not lose the ability to
> > > > perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> > > > it.
> > > >
> > > > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > > This is related to the discussion in
> > > >
> > > > https://lore.kernel.org/linux-arm-kernel/20201001161740.29064-2-nsaenzjulienne@suse.de/
> > > >
> > > >  Documentation/arm64/arm-acpi.rst |  7 +++
> > > >  arch/arm64/mm/init.c             |  8 +++
> > > >  drivers/acpi/arm64/iort.c        | 51 ++++++++++++++++++++
> > > >  3 files changed, 66 insertions(+)
> > >
> > > Thanks for putting it together so promptly.
> > >
> > > > diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> > > > index 47ecb9930dde..947f5b5c45ef 100644
> > > > --- a/Documentation/arm64/arm-acpi.rst
> > > > +++ b/Documentation/arm64/arm-acpi.rst
> > > > @@ -205,6 +205,13 @@ devices available.  This list of tables is not meant to be all inclusive;
> > > >  in some environments other tables may be needed (e.g., any of the APEI
> > > >  tables from section 18) to support specific functionality.
> > > >
> > > > +It is assumed that all DMA capable devices in the system are able to
> > > > +access the lowest 4 GB of system memory. If this is not the case, an
> > > > +IORT describing those limitations is mandatory, even if an IORT is not
> > > > +otherwise necessary to describe the I/O topology, and regardless of
> > > > +whether _DMA methods are used to describe the DMA limitations more
> > > > +precisely. Once the system has booted, _DMA methods will take precedence
> > > > +over DMA addressing limits described in the IORT.
> > >
> > > If this is a boot requirement it must be in ARM's official documentation,
> > > first, not the kernel one.
> > >
> > > I understand this is an urgent (well - no comments on why bootstrapping
> > > ACPI on Raspberry PI4 is causing all this fuss, honestly) fix but that's
> > > not a reason to rush through these guidelines.
> > >
> > > I would not add this paragraph to arm-acpi.rst, yet.
> > >
> >
> > Which documentation? ACPI compliance by itself is not sufficient for a
> > system to be able to boot Linux/arm64, which is why we documented the
> > requirements for ACPI boot on Linux/arm64 in this file. I don't think
> > we need endorsement from ARM to decide that odd platforms like this
> > need to abide by some additional rules if they want to boot in ACPI
> > mode.
> >
> >
> > > >  ACPI Detection
> > > >  --------------
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > index f0599ae73b8d..829fa63c3d72 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > > >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> > > >
> > > >  #ifdef CONFIG_ZONE_DMA
> > > > +     if (IS_ENABLED(CONFIG_ACPI)) {
> > > > +             extern unsigned int acpi_iort_get_zone_dma_size(void);
> > >
> > > Yes as Catalin asked please add a declaration in IORT headers.
> > >
> >
> > Ack.
> >
> > > > +             zone_dma_bits = min(zone_dma_bits,
> > > > +                                 acpi_iort_get_zone_dma_size());
> > > > +             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > > > +     }
> > > > +
> > > >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> > > >  #endif
> > > >  #ifdef CONFIG_ZONE_DMA32
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index ec782e4a0fe4..c3db44896e49 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -1722,3 +1722,54 @@ void __init acpi_iort_init(void)
> > > >
> > > >       iort_init_platform_devices();
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_ZONE_DMA
> > > > +/*
> > > > + * Check the IORT whether any devices exist whose DMA mask is < 32 bits.
> > > > + * If so, return the smallest value encountered, or 32 otherwise.
> > > > + */
> > > > +unsigned int __init acpi_iort_get_zone_dma_size(void)
> > > > +{
> > > > +     struct acpi_table_iort *iort;
> > > > +     struct acpi_iort_node *node, *end;
> > > > +     acpi_status status;
> > > > +     u8 limit = 32;
> > > > +     int i;
> > > > +
> > > > +     if (acpi_disabled)
> > > > +             return limit;
> > > > +
> > > > +     status = acpi_get_table(ACPI_SIG_IORT, 0,
> > > > +                             (struct acpi_table_header **)&iort);
> > > > +     if (ACPI_FAILURE(status))
> > > > +             return limit;
> > > > +
> > > > +     node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> > > > +     end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> > > > +
> > > > +     for (i = 0; i < iort->node_count; i++) {
> > > > +             if (node >= end)
> > > > +                     break;
> > > > +
> > > > +             switch (node->type) {
> > > > +                     struct acpi_iort_named_component *ncomp;
> > > > +                     struct acpi_iort_root_complex *rc;
> > > > +
> > > > +             case ACPI_IORT_NODE_NAMED_COMPONENT:
> > > > +                     ncomp = (struct acpi_iort_named_component *)node->node_data;
> > > > +                     if (ncomp->memory_address_limit)
> > > > +                             limit = min(limit, ncomp->memory_address_limit);
> > > > +                     break;
> > > > +
> > > > +             case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> > > > +                     rc = (struct acpi_iort_root_complex *)node->node_data;
> > > > +                     if (rc->memory_address_limit);
> > >
> > > You need a node->revision check here otherwise we may end up
> > > dereferencing junk. AKA ACPI versioning in all its glory.
> > >
> >
> > The address limit field was there since the beginning, and DEN0049B
> > defines its value as 0x0, so I don't think we need to check anything
> > here.
> >
>
> I meant here that the NC node revision is defined as 0x0 in DEN0049B

... and you meant the RC node not the NC node. Apologies for being
slow today :-)
