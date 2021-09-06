Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4640208F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Sep 2021 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhIFTwv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Sep 2021 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhIFTwv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Sep 2021 15:52:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E34C061575
        for <linux-acpi@vger.kernel.org>; Mon,  6 Sep 2021 12:51:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u14so15269574ejf.13
        for <linux-acpi@vger.kernel.org>; Mon, 06 Sep 2021 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYOIpfoLo1TtPOzly7mCruZDinHXZD4jqzh3rEOq7zU=;
        b=s3VQGvmRtztPI/5nkbWDZhH4pFe2TIABlDp9Z4ocjsCKX4PDE5lS0Xfw2D3tPHfE0K
         IRdlSlSYBRq3ksBcjj4FlA1WQgfp9k0TsJ/VPYDPK/9CrKI8Oivb9TrxVV9lhjqXRARK
         Z6UNm59nnYqVrlDeEcWV46FrlSEhEorZJIOZ9CrAhRqECaTzeMAxSwfxopz83GR7C4jE
         87yuKzScHDkbr42z4doa7OOaiRxeCFV16WoK5GLhM2yFM8wErVYhGp8IbbS64WuSE7Gj
         TB/pyQIvrHjVn2Q2+znoBB1ZKsSKEO1B/Ehwkwwafs9nQpWMkEBS8WD24g0+k+z6BTtj
         9SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYOIpfoLo1TtPOzly7mCruZDinHXZD4jqzh3rEOq7zU=;
        b=iiMfZTlaatu1mjuIG+Kgq4VoQ/K+TJt2nWBdxP3L/sBtQ7wsOK/E+AG5FbxelkSVvF
         7PN79AScIkLBMAoCFQ2vZNU9bBe5bcx/Dur9rRbQxRDDu1nOuKFjHY/LgMEBa2sTpDvZ
         mmQ9RQflfvuFRFkCtuRHxEN78l5byfbn5a7YJU/EfAlCIJqP09ORS5xyB2eLC5uMg72E
         1KdGVKwKjbqx9K8U9fzOZp/dkiF35quokHzcwtkmJUXYfP+vNSpKmXkpdNN6/Pe1UVkC
         yy1qlj1Ztu22p+Wl/kCgCRwytYjLmWmpu+mTaov5dt0hQgQSkcNB38h6wnOHxiVO/m+7
         UtMg==
X-Gm-Message-State: AOAM532+5k02Sx+HieRR2X3WBQQtuevOFcqxAOABQLIEyXc7nmeOvkil
        dvQ6xHHZHZvEBppfOOKZG1dlkLYCnvC2wtVuHX9Nzw==
X-Google-Smtp-Source: ABdhPJzNmHxJtz1P9ezhqHwwF8nhs91bYyqdz6r0gtgvcPAfCo1su2ltyZrM7CQ2UDeayDx0mJOExFIsSv7h5nCpJjQ=
X-Received: by 2002:a17:906:d04f:: with SMTP id bo15mr15064287ejb.309.1630957904502;
 Mon, 06 Sep 2021 12:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi> <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
In-Reply-To: <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 6 Sep 2021 21:51:07 +0200
Message-ID: <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 6, 2021 at 7:44 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 17:03, Lorenzo Pieralisi wrote:
> > On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
> >
> > [...]
> >
> >> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> >> +{
> >> +    struct acpi_iort_node *smmu;
> >> +    struct acpi_iort_rmr *rmr;
> >> +    struct acpi_iort_rmr_desc *rmr_desc;
> >> +    u32 map_count = iort_node->mapping_count;
> >> +    u32 sid;
> >> +    int i;
> >> +
> >> +    if (!iort_node->mapping_offset || map_count != 1) {
> >> +            pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    /* Retrieve associated smmu and stream id */
> >> +    smmu = iort_node_get_id(iort_node, &sid, 0);
> >> +    if (!smmu) {
> >> +            pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    /* Retrieve RMR data */
> >> +    rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> >> +    if (!rmr->rmr_offset || !rmr->rmr_count) {
> >> +            pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> >> +                            rmr->rmr_offset);
> >> +
> >> +    iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> >> +
> >> +    for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> >> +            struct iommu_resv_region *region;
> >> +            enum iommu_resv_type type;
> >> +            int prot = IOMMU_READ | IOMMU_WRITE;
> >> +            u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> >> +
> >> +            if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> >> +                    /* PAGE align base addr and size */
> >> +                    addr &= PAGE_MASK;
> >> +                    size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> >> +
> >> +                    pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> >> +                           rmr_desc->base_address,
> >> +                           rmr_desc->base_address + rmr_desc->length - 1,
> >> +                           addr, addr + size - 1);
> >> +            }
> >> +            if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> >> +                    type = IOMMU_RESV_DIRECT_RELAXABLE;
> >> +                    /*
> >> +                     * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> >> +                     * normally used for allocated system memory that is
> >> +                     * then used for device specific reserved regions.
> >> +                     */
> >> +                    prot |= IOMMU_CACHE;
> >> +            } else {
> >> +                    type = IOMMU_RESV_DIRECT;
> >> +                    /*
> >> +                     * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> >> +                     * for device memory like MSI doorbell.
> >> +                     */
> >> +                    prot |= IOMMU_MMIO;
> >> +            }
> >
> > On the prot value assignment based on the remapping flag, I'd like to
> > hear Robin/Joerg's opinion, I'd avoid being in a situation where
> > "normally" this would work but then we have to quirk it.
> >
> > Is this a valid assumption _always_ ?
>
> No. Certainly applying IOMMU_CACHE without reference to the device's
> _CCA attribute or how CPUs may be accessing a shared buffer could lead
> to a loss of coherency. At worst, applying IOMMU_MMIO to a
> device-private buffer *could* cause the device to lose coherency with
> itself if the memory underlying the RMR may have allocated into system
> caches. Note that the expected use for non-remappable RMRs is the device
> holding some sort of long-lived private data in system RAM - the MSI
> doorbell trick is far more of a niche hack really.
>
> At the very least I think we need to refer to the device's memory access
> properties here.
>
> Jon, Laurentiu - how do RMRs correspond to the EFI memory map on your
> firmware? I'm starting to think that as long as the underlying memory is
> described appropriately there then we should be able to infer correct
> attributes from the EFI memory type and flags.

The devices are all cache coherent and marked as _CCA, 1.  The Memory
regions are in the virt table as ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.

The current chicken and egg problem we have is that during the fsl-mc-bus
initialization we call

error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
                                              &mc_stream_id);

which gets deferred because the SMMU has not been initialized yet. Then we
initialize the RMR tables but there is no device reference there to be able to
query device properties, only the stream id.  After the IORT tables are parsed
and the SMMU is setup, on the second device probe we associate everything
based on the stream id and the fsl-mc-bus device is able to claim its 1-1 DMA
mappings.

cat /sys/kernel/iommu_groups/0/reserved_regions
0x0000000001000000 0x0000000010ffffff direct-relaxable
0x0000000008000000 0x00000000080fffff msi
0x000000080c000000 0x000000081bffffff direct-relaxable
0x0000001c00000000 0x0000001c001fffff direct-relaxable
0x0000002080000000 0x000000209fffffff direct-relaxable

-Jon

>
> Robin.
