Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F740D842
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhIPLSp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbhIPLSg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Sep 2021 07:18:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022FC061766
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 04:17:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v5so15259523edc.2
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg0xzckHIVV7W+CI++paNDzu+/o9fNI3DOu2sTI2cvM=;
        b=Y5w1f0yq+ooQVuascIf6oiAlIPAIcq1PkK/2Wiq1ve7TNMzek6961oApGNgUoEizYo
         9EiUnCz7xPV2b7TUj1MxEEooP+MQe+W0kFoJs/KRjF1vj1AreTAXucPyX85GIqsn98kl
         G5T4GOnViifEZD3bDRq9ENtxLnneDFll1BVME+KJmaUwIvKbi59+kqLs23ERFIl98kiI
         c0MX6rtFibuShtiupMbqa3iigZVX3bZR3x1qaYyDkwl8Dx515ea/eMiJA/W3EJ0GEhB3
         od/6+D7/SyszdXsH27hCaFKuvsOmGzPiXGxv91EPhbT+T1BJfFh6zdAI0ty7NnmfbWEZ
         1aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg0xzckHIVV7W+CI++paNDzu+/o9fNI3DOu2sTI2cvM=;
        b=YfsEHAwprIeZ9JGQcGFPGCyMVJVrQzHGsNkLCOr9AHes3bxa1qZdBceHOT/8oBaXJC
         f3RRFNGjwNKN3/fV8NvJ3KMwGoa2PAVZvEyowxnlX+S/W4VGDNLDT12HZwzsSFGfu3hd
         NASI9jnxH22SDZVzIq65x3m0yfH8miN5xYs7oD9Gp0fiFyelQ/cQCvyJHQi+foiHAXD8
         zGvkqRY2q3tPNky7BhWL7M4b2VWNz+Yi6LYe6q9Ma6/eoOIjhhfboi+0pFDDoGtl8uT3
         aPGTaD3zfD/uDwJYYe6WcuijOQkGkPcq+AoaIE00wf5TBRPpowNY//1e9MtZHozCTRud
         ILUw==
X-Gm-Message-State: AOAM531FzC917NPsEsksSPk+nGAie2LDokZsz0IvHCCQtPzecqKt3n5y
        LfRQUv/hbgTF/bSXnTaf9qRmlGDMksLvhhX7+pUwYQ==
X-Google-Smtp-Source: ABdhPJyglz26x+lmrgv6QCUasZVL5xJn5w0vQbfMzmz7rEnBmOyo3+67cFGRz4jCisM44sKcP+W8/9WYMUYsVmTCErA=
X-Received: by 2002:a17:906:901:: with SMTP id i1mr5900541ejd.248.1631791034238;
 Thu, 16 Sep 2021 04:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi> <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
 <f3fc713365f7465e966aaed7cdd8870a@huawei.com> <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
 <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
In-Reply-To: <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 16 Sep 2021 13:16:37 +0200
Message-ID: <CABdtJHuRB29Ufryvz=kCO7b_xgVb1D-7y3RQgCkKvSmshkkH1A@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 10:26 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jon Nettleton [mailto:jon@solid-run.com]
> > Sent: 16 September 2021 08:52
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> > linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> > List <linux-acpi@vger.kernel.org>; Linux IOMMU
> > <iommu@lists.linux-foundation.org>; Joerg Roedel <joro@8bytes.org>; Will
> > Deacon <will@kernel.org>; wanghuiqiang <wanghuiqiang@huawei.com>;
> > Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Steven Price
> > <steven.price@arm.com>; Sami Mujawar <Sami.Mujawar@arm.com>; Eric
> > Auger <eric.auger@redhat.com>; yangyicong <yangyicong@huawei.com>
> > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
> >
> > On Thu, Sep 16, 2021 at 9:26 AM Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jon Nettleton [mailto:jon@solid-run.com]
> > > > Sent: 06 September 2021 20:51
> > > > To: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali
> > > > Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Laurentiu
> > > > Tudor <laurentiu.tudor@nxp.com>; linux-arm-kernel
> > > > <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
> > > > <linux-acpi@vger.kernel.org>; Linux IOMMU
> > > > <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> > > > Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> > > > wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > > <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
> > > > Mujawar <Sami.Mujawar@arm.com>; Eric Auger
> > <eric.auger@redhat.com>;
> > > > yangyicong <yangyicong@huawei.com>
> > > > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node
> > > > parsing
> > > >
> > > [...]
> > >
> > > > > >
> > > > > > On the prot value assignment based on the remapping flag, I'd
> > > > > > like to hear Robin/Joerg's opinion, I'd avoid being in a
> > > > > > situation where "normally" this would work but then we have to quirk
> > it.
> > > > > >
> > > > > > Is this a valid assumption _always_ ?
> > > > >
> > > > > No. Certainly applying IOMMU_CACHE without reference to the
> > > > > device's _CCA attribute or how CPUs may be accessing a shared
> > > > > buffer could lead to a loss of coherency. At worst, applying
> > > > > IOMMU_MMIO to a device-private buffer *could* cause the device to
> > > > > lose coherency with itself if the memory underlying the RMR may
> > > > > have allocated into system caches. Note that the expected use for
> > > > > non-remappable RMRs is the device holding some sort of long-lived
> > > > > private data in system RAM - the MSI doorbell trick is far more of a niche
> > hack really.
> > > > >
> > > > > At the very least I think we need to refer to the device's memory
> > > > > access properties here.
> > > > >
> > > > > Jon, Laurentiu - how do RMRs correspond to the EFI memory map on
> > > > > your firmware? I'm starting to think that as long as the
> > > > > underlying memory is described appropriately there then we should
> > > > > be able to infer correct attributes from the EFI memory type and flags.
> > > >
> > > > The devices are all cache coherent and marked as _CCA, 1.  The
> > > > Memory regions are in the virt table as
> > ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.
> > > >
> > > > The current chicken and egg problem we have is that during the
> > > > fsl-mc-bus initialization we call
> > > >
> > > > error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> > > >                                               &mc_stream_id);
> > > >
> > > > which gets deferred because the SMMU has not been initialized yet.
> > > > Then we initialize the RMR tables but there is no device reference
> > > > there to be able to query device properties, only the stream id.
> > > > After the IORT tables are parsed and the SMMU is setup, on the
> > > > second device probe we associate everything based on the stream id
> > > > and the fsl-mc-bus device is able to claim its 1-1 DMA mappings.
> > >
> > > Can we solve this order problem by delaying the
> > > iommu_alloc_resv_region() to the iommu_dma_get_rmr_resv_regions(dev,
> > > list) ? We could invoke
> > > device_get_dma_attr() from there which I believe will return the _CCA
> > attribute.
> > >
> > > Or is that still early to invoke that?
> >
> > That looks like it should work. Do we then also need to parse through the
> > VirtualMemoryTable matching the start and end addresses to determine the
> > other memory attributes like MMIO?
>
> Yes. But that looks tricky as I can't find that readily available on Arm, like the
> efi_mem_attributes(). I will take a look.
>
> Please let me know if there is one or any other easy way to retrieve it.

maybe we don't need to.  Maybe it is enough to just move
iommu_alloc_resv_regions and then set the IOMMU_CACHE flag
if type = IOMMU_RESV_DIRECT_RELAXABLE and _CCN=1?

-Jon

>
> Thanks,
> Shameer
>
> >
> > -Jon
> >
> > >
> > > Thanks,
> > > Shameer
> > >
> > > > cat /sys/kernel/iommu_groups/0/reserved_regions
> > > > 0x0000000001000000 0x0000000010ffffff direct-relaxable
> > > > 0x0000000008000000 0x00000000080fffff msi
> > > > 0x000000080c000000 0x000000081bffffff direct-relaxable
> > > > 0x0000001c00000000 0x0000001c001fffff direct-relaxable
> > > > 0x0000002080000000 0x000000209fffffff direct-relaxable
> > > >
> > > > -Jon
> > > >
> > > > >
> > > > > Robin.
