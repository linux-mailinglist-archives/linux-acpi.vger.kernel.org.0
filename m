Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36628FEA0
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394296AbgJPGzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 02:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394276AbgJPGzK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 02:55:10 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C43220FC3;
        Fri, 16 Oct 2020 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602831309;
        bh=b3qDwjjAp5PHcyt8IPdk4OZdAwmA08qCD89V2qvJHaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OnEMUDtfzK0gADScZPt2n5h2HkDxjKlzfLcIFiT2z0pNHcWCzFlaM+Gg9CdaS49Cm
         GGa4rRxzT6s4z6RPwHyrwBHNffZ87P0maEvRUvVl6a9/aOKYXpqaTL3rvmlz1Kr4M4
         OpYcEVUMGGBhILJAXeRULNbnv58Scz98UscOGpEM=
Received: by mail-ot1-f51.google.com with SMTP id n15so1509338otl.8;
        Thu, 15 Oct 2020 23:55:09 -0700 (PDT)
X-Gm-Message-State: AOAM533klGXnv499aBIa7+HubRWuxuq2ixXUQZLD6yihODFiPlcLRent
        tDXLy0hVinXRfsRItDIJKG/vno+oASIY0f+RxPg=
X-Google-Smtp-Source: ABdhPJzFVaXBGl8dFNX52YrC8SMcHfjR/tZskK4YIqFusTZj+VMKn9rDGBEcRadGWaZ6KZRA07DaMJyrRkA2/apa6EA=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr1646843otq.77.1602831308155;
 Thu, 15 Oct 2020 23:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de> <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
 <20201015180340.GB2624@gaia> <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
In-Reply-To: <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Oct 2020 08:54:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
Message-ID: <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT scan
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 16 Oct 2020 at 08:51, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/10/16 2:03, Catalin Marinas wrote:
> > On Thu, Oct 15, 2020 at 10:26:18PM +0800, Hanjun Guo wrote:
> >> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> >>> incorporating masters that can address less than 32 bits of DMA, in
> >>> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> >>> peripherals that can only address up to 1 GB (and its PCIe host
> >>> bridge can only access the bottom 3 GB)
> >>>
> >>> Instructing the DMA layer about these limitations is straight-forward,
> >>> even though we had to fix some issues regarding memory limits set in
> >>> the IORT for named components, and regarding the handling of ACPI _DMA
> >>> methods. However, the DMA layer also needs to be able to allocate
> >>> memory that is guaranteed to meet those DMA constraints, for bounce
> >>> buffering as well as allocating the backing for consistent mappings.
> >>>
> >>> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> >>> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> >>> problems with kdump, and potentially in other places where allocations
> >>> cannot cross zone boundaries. Therefore, we should avoid having two
> >>> separate DMA zones when possible.
> >>>
> >>> So let's do an early scan of the IORT, and only create the ZONE_DMA
> >>> if we encounter any devices that need it. This puts the burden on
> >>> the firmware to describe such limitations in the IORT, which may be
> >>> redundant (and less precise) if _DMA methods are also being provided.
> >>> However, it should be noted that this situation is highly unusual for
> >>> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> >>> the _DMA method if implemented, and so we will not lose the ability to
> >>> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> >>> it.
> >>
> >> Sorry, I'm still a little bit confused. With this patch, if we have
> >> a device which set the right _DMA method (DMA size >= 32), but with the
> >> wrong DMA size in IORT, we still have the ZONE_DMA created which
> >> is actually not needed?
> >
> > With the current kernel, we get a ZONE_DMA already with an arbitrary
> > size of 1GB that matches what RPi4 needs. We are trying to eliminate
> > such unnecessary ZONE_DMA based on some heuristics (well, something that
> > looks "better" than a OEM ID based quirk). Now, if we learn that IORT
> > for platforms in the field is that broken as to describe few bits-wide
> > DMA masks, we may have to go back to the OEM ID quirk.
>
> Some platforms using 0 as the memory size limit, for example D05 [0] and
> D06 [1], I think we need to go back to the OEM ID quirk.
>
> For D05/D06, there are multi interrupt controllers named as mbigen,
> mbigen is using the named component to describe the mappings with
> the ITS controller, and mbigen is using 0 as the memory size limit.
>
> Also since the memory size limit for PCI RC was introduced by later
> IORT revision, so firmware people may think it's fine to set that
> as 0 because the system works without it.
>

Hello Hanjun,

The patch only takes the address limit field into account if its value > 0.

Also, before commit 7fb89e1d44cb6aec ("ACPI/IORT: take _DMA methods
into account for named components"), the _DMA method was not taken
into account for named components at all, and only the IORT limit was
used, so I do not anticipate any problems with that.
