Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201A40D41F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhIPHyI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhIPHyH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Sep 2021 03:54:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52795C061574
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 00:52:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j13so13365664edv.13
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODMKOAGqD4ItUpYtqxdJhUq4QAGfb72lqYAxg7uVUGE=;
        b=chtAbpIChinWBdEU1gL0ntvM9+0WUqRdjW5xXbWXxve4i322V8dGlTe9RiiuK3Ky4X
         c4akEZ5ZtlGIE4Oq5bKagynGKAzDDWLhPD16IaRA87RHwvszd2Dd9BcUfbSoGsR9eW23
         jCna1ptofFWrFzh1WoFFdzasf5ZaWs3oaf2rCLIudjsKhBAEHN4skc61+FZLbHn63DN0
         rNGf+UyI8WD/28M5HK/XKfP5ioyaoiYkqVrB9g+dtXaUnXSgWMUJPcNDt4JNfSsTxCBj
         blBr5Gzj1Bep+7R7sSd1nskzkOQz0mQNLiq9MFxbbycGsJJRkg9ZK3NBERnWlMz9RRRQ
         voAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODMKOAGqD4ItUpYtqxdJhUq4QAGfb72lqYAxg7uVUGE=;
        b=8OCxSyoUCo7ETrKcCWq+j5+ZQzbEJGcMm3Zh1p5ielzT+wZ5xRZrZa02eqbDItpEJy
         xKBEww5oNQcsI5zYVZe+eCu512ggRhnme8WoLC6AyZ8NikWg+tZ3m07BcPNAvfQq+R4i
         Yh0JVhblyhMbKBS36TmvD2gLNNO8QxBjk4rxbHaqfNIn5RvInUs4VhPH1HJ0G/bJuajJ
         l30r+nQOqH0xY+I5AV8ep3/o7xsWRgqNBYrsPO/hU1yWC+XCTiOhcgLm3+c9FedVN1u0
         JKQmX+dTQYz3FiH0rW3a32xk4twpjMOyQJHx6MFNfw10wx/ikeAcGS3tfju9BG7ZY8JO
         dVIA==
X-Gm-Message-State: AOAM533XOfqsuQyqVycPHxsxltECo05VI40ORF/mobI6WwM7j4IM5X3o
        l3j6lxr/AHdwptK0ulH5tJwpgGI2DO5uNqEr0hx+Ww==
X-Google-Smtp-Source: ABdhPJyKDvyZKYCRYuxgjitZgDg2r13roWQBKzWOY1Mt3prlNydzDybS+gDSrHtYZ6S21wAVeWfjewN4V0nE2cFjwQw=
X-Received: by 2002:a17:906:1341:: with SMTP id x1mr4645297ejb.277.1631778765895;
 Thu, 16 Sep 2021 00:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi> <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com> <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
In-Reply-To: <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 16 Sep 2021 09:52:08 +0200
Message-ID: <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
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

On Thu, Sep 16, 2021 at 9:26 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jon Nettleton [mailto:jon@solid-run.com]
> > Sent: 06 September 2021 20:51
> > To: Robin Murphy <robin.murphy@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; Laurentiu Tudor
> > <laurentiu.tudor@nxp.com>; linux-arm-kernel
> > <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
> > <linux-acpi@vger.kernel.org>; Linux IOMMU
> > <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> > Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> > wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
> > Mujawar <Sami.Mujawar@arm.com>; Eric Auger <eric.auger@redhat.com>;
> > yangyicong <yangyicong@huawei.com>
> > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
> >
> [...]
>
> > > >
> > > > On the prot value assignment based on the remapping flag, I'd like
> > > > to hear Robin/Joerg's opinion, I'd avoid being in a situation where
> > > > "normally" this would work but then we have to quirk it.
> > > >
> > > > Is this a valid assumption _always_ ?
> > >
> > > No. Certainly applying IOMMU_CACHE without reference to the device's
> > > _CCA attribute or how CPUs may be accessing a shared buffer could lead
> > > to a loss of coherency. At worst, applying IOMMU_MMIO to a
> > > device-private buffer *could* cause the device to lose coherency with
> > > itself if the memory underlying the RMR may have allocated into system
> > > caches. Note that the expected use for non-remappable RMRs is the
> > > device holding some sort of long-lived private data in system RAM -
> > > the MSI doorbell trick is far more of a niche hack really.
> > >
> > > At the very least I think we need to refer to the device's memory
> > > access properties here.
> > >
> > > Jon, Laurentiu - how do RMRs correspond to the EFI memory map on your
> > > firmware? I'm starting to think that as long as the underlying memory
> > > is described appropriately there then we should be able to infer
> > > correct attributes from the EFI memory type and flags.
> >
> > The devices are all cache coherent and marked as _CCA, 1.  The Memory
> > regions are in the virt table as ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.
> >
> > The current chicken and egg problem we have is that during the fsl-mc-bus
> > initialization we call
> >
> > error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> >                                               &mc_stream_id);
> >
> > which gets deferred because the SMMU has not been initialized yet. Then we
> > initialize the RMR tables but there is no device reference there to be able to
> > query device properties, only the stream id.  After the IORT tables are parsed
> > and the SMMU is setup, on the second device probe we associate everything
> > based on the stream id and the fsl-mc-bus device is able to claim its 1-1 DMA
> > mappings.
>
> Can we solve this order problem by delaying the iommu_alloc_resv_region()
> to the iommu_dma_get_rmr_resv_regions(dev, list) ? We could invoke
> device_get_dma_attr() from there which I believe will return the _CCA attribute.
>
> Or is that still early to invoke that?

That looks like it should work. Do we then also need to parse through the
VirtualMemoryTable matching the start and end addresses to determine the
other memory attributes like MMIO?

-Jon

>
> Thanks,
> Shameer
>
> > cat /sys/kernel/iommu_groups/0/reserved_regions
> > 0x0000000001000000 0x0000000010ffffff direct-relaxable
> > 0x0000000008000000 0x00000000080fffff msi
> > 0x000000080c000000 0x000000081bffffff direct-relaxable
> > 0x0000001c00000000 0x0000001c001fffff direct-relaxable
> > 0x0000002080000000 0x000000209fffffff direct-relaxable
> >
> > -Jon
> >
> > >
> > > Robin.
