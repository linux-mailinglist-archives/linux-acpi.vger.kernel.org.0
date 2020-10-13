Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79B428CEFC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgJMNNy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 09:13:54 -0400
Received: from foss.arm.com ([217.140.110.172]:59794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgJMNNy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 09:13:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 799EE1FB;
        Tue, 13 Oct 2020 06:13:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7B6F3F719;
        Tue, 13 Oct 2020 06:13:51 -0700 (PDT)
Date:   Tue, 13 Oct 2020 14:13:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Message-ID: <20201013131346.GA20925@e121166-lin.cambridge.arm.com>
References: <20201010093153.30177-1-ardb@kernel.org>
 <20201013110929.GB20319@e121166-lin.cambridge.arm.com>
 <CAMj1kXEbZ3cN1N2V6MfbUZsTot+9TsLTC_UMm5JP1OW8AwvuOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEbZ3cN1N2V6MfbUZsTot+9TsLTC_UMm5JP1OW8AwvuOw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 13, 2020 at 01:22:32PM +0200, Ard Biesheuvel wrote:

[...]

> > > diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> > > index 47ecb9930dde..947f5b5c45ef 100644
> > > --- a/Documentation/arm64/arm-acpi.rst
> > > +++ b/Documentation/arm64/arm-acpi.rst
> > > @@ -205,6 +205,13 @@ devices available.  This list of tables is not meant to be all inclusive;
> > >  in some environments other tables may be needed (e.g., any of the APEI
> > >  tables from section 18) to support specific functionality.
> > >
> > > +It is assumed that all DMA capable devices in the system are able to
> > > +access the lowest 4 GB of system memory. If this is not the case, an
> > > +IORT describing those limitations is mandatory, even if an IORT is not
> > > +otherwise necessary to describe the I/O topology, and regardless of
> > > +whether _DMA methods are used to describe the DMA limitations more
> > > +precisely. Once the system has booted, _DMA methods will take precedence
> > > +over DMA addressing limits described in the IORT.
> >
> > If this is a boot requirement it must be in ARM's official documentation,
> > first, not the kernel one.
> >
> > I understand this is an urgent (well - no comments on why bootstrapping
> > ACPI on Raspberry PI4 is causing all this fuss, honestly) fix but that's
> > not a reason to rush through these guidelines.
> >
> > I would not add this paragraph to arm-acpi.rst, yet.
> >
> 
> Which documentation? ACPI compliance by itself is not sufficient for a
> system to be able to boot Linux/arm64, which is why we documented the
> requirements for ACPI boot on Linux/arm64 in this file. I don't think
> we need endorsement from ARM to decide that odd platforms like this
> need to abide by some additional rules if they want to boot in ACPI
> mode.

I think we do - if we don't we should not add this documentation either.

ACPI on ARM64 software stack is based on standardized HW requirements.
The sheer fact that we need to work around a HW deficiency shows that
either this platform should have never been booted with ACPI or the _HW_
design guidelines (BSA) are not tight enough.

Please note that as you may have understood I asked if we can implement
a workaround in IORT because that's information that must be there
regardless (and an OEM ID match in arch code - though pragmatic -
defeats the whole purpose), I don't think we should tell Linux kernel
developers how firmware must be written to work around blatantly
non-compliant systems.

Thanks,
Lorenzo

> > >  ACPI Detection
> > >  --------------
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
> > Yes as Catalin asked please add a declaration in IORT headers.
> >
> 
> Ack.
> 
> > > +             zone_dma_bits = min(zone_dma_bits,
> > > +                                 acpi_iort_get_zone_dma_size());
> > > +             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > > +     }
> > > +
> > >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> > >  #endif
> > >  #ifdef CONFIG_ZONE_DMA32
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index ec782e4a0fe4..c3db44896e49 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -1722,3 +1722,54 @@ void __init acpi_iort_init(void)
> > >
> > >       iort_init_platform_devices();
> > >  }
> > > +
> > > +#ifdef CONFIG_ZONE_DMA
> > > +/*
> > > + * Check the IORT whether any devices exist whose DMA mask is < 32 bits.
> > > + * If so, return the smallest value encountered, or 32 otherwise.
> > > + */
> > > +unsigned int __init acpi_iort_get_zone_dma_size(void)
> > > +{
> > > +     struct acpi_table_iort *iort;
> > > +     struct acpi_iort_node *node, *end;
> > > +     acpi_status status;
> > > +     u8 limit = 32;
> > > +     int i;
> > > +
> > > +     if (acpi_disabled)
> > > +             return limit;
> > > +
> > > +     status = acpi_get_table(ACPI_SIG_IORT, 0,
> > > +                             (struct acpi_table_header **)&iort);
> > > +     if (ACPI_FAILURE(status))
> > > +             return limit;
> > > +
> > > +     node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> > > +     end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> > > +
> > > +     for (i = 0; i < iort->node_count; i++) {
> > > +             if (node >= end)
> > > +                     break;
> > > +
> > > +             switch (node->type) {
> > > +                     struct acpi_iort_named_component *ncomp;
> > > +                     struct acpi_iort_root_complex *rc;
> > > +
> > > +             case ACPI_IORT_NODE_NAMED_COMPONENT:
> > > +                     ncomp = (struct acpi_iort_named_component *)node->node_data;
> > > +                     if (ncomp->memory_address_limit)
> > > +                             limit = min(limit, ncomp->memory_address_limit);
> > > +                     break;
> > > +
> > > +             case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> > > +                     rc = (struct acpi_iort_root_complex *)node->node_data;
> > > +                     if (rc->memory_address_limit);
> >
> > You need a node->revision check here otherwise we may end up
> > dereferencing junk. AKA ACPI versioning in all its glory.
> >
> 
> The address limit field was there since the beginning, and DEN0049B
> defines its value as 0x0, so I don't think we need to check anything
> here.
> 
> 
> > Thanks,
> > Lorenzo
> >
> > > +                             limit = min(limit, rc->memory_address_limit);
> > > +                     break;
> > > +             }
> > > +             node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
> > > +     }
> > > +     acpi_put_table(&iort->header);
> > > +     return limit;
> > > +}
> > > +#endif
> > > --
> > > 2.17.1
> > >
