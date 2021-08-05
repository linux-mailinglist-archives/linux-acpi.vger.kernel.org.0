Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1D3E1598
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhHENW6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 09:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhHENW6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Aug 2021 09:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B9A761158
        for <linux-acpi@vger.kernel.org>; Thu,  5 Aug 2021 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628169764;
        bh=rABZo6aAjftHjiZ5IWVoUogsJY3wYwnWG2rnzy4liBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wvd0gPN3bIkbH85Jb8aiK9vAeTaGXkKH0MPPvHrT67OI7Yv4pArZ3mpw+PSlewnAk
         PnYEYc30nVMFJfbbkDTxRhqH4HilA2dnpEQinC6/a2ywTKEu5145yOWfueC31EFsne
         QhqBB69I6VY8hq+RW66dpCUIpmO6LVAeWRUefgRrASbWZBtrtYcVZ1bPgZvE8U7j1Z
         pIK8w0B94XWyw2tc9gxARVmYCPzhqQAjHnGb+TBmGyMiIH1MeZ3T3eUM+Lg7HwHP4C
         w4DGrWG56tp3VXJvpseidZvpVsG86dLc/vIcckBLXQRwspK+ODQ7dt3zdW1045KQDp
         4XqNS2b0S6CLA==
Received: by mail-ot1-f43.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so5107954oti.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Aug 2021 06:22:44 -0700 (PDT)
X-Gm-Message-State: AOAM532vMSah/DbAtyJS1dGVMPc+1diYJGcgHYTWVQD85VxUqIGNSMui
        WJSTb7zfGAe5CyTRt1J0ffCV7KLS2dt1JmEX+Dc=
X-Google-Smtp-Source: ABdhPJx0hDuVxvbP140/VxO38R4dIU/rEbrl3LBsoE8UOKfL6M4pTys5XpazDhygGrztUo1RJOEBxMauD3jhjiaPAZQ=
X-Received: by 2002:a9d:5c2:: with SMTP id 60mr3654201otd.77.1628169763566;
 Thu, 05 Aug 2021 06:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Aug 2021 15:22:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNjeDb2HuPeV_6Er4oALVKFz+g=gQ_0rf+JW22NxqqTA@mail.gmail.com>
Message-ID: <CAMj1kXHNjeDb2HuPeV_6Er4oALVKFz+g=gQ_0rf+JW22NxqqTA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, wanghuiqiang@huawei.com,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Eric Auger <eric.auger@redhat.com>, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 5 Aug 2021 at 10:10, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Hi,
>
> The series adds support to IORT RMR nodes specified in IORT
> Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
> memory ranges that are used by endpoints and require a unity
> mapping in SMMU.
>
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these
> controllers make use of host memory for various caching related
> purposes and when SMMU is enabled the iMR firmware fails to
> access these memory regions as there is no mapping for them.
> IORT RMR provides a way for UEFI to describe and report these
> memory regions so that the kernel can make a unity mapping for
> these in SMMU.
>

Does this mean we are ignoring the RMR memory ranges, and exposing the
entire physical address space to devices using the stream IDs in
question?


> Change History:
>
> v6 --> v7
>
> The only change from v6 is the fix pointed out by Steve to
> the SMMUv2 SMR bypass install in patch #8.
>
> Thanks to the Tested-by tags by Laurentiu with SMMUv2 and
> Hanjun/Huiqiang with SMMUv3 for v6. I haven't added the tags
> yet as the series still needs more review[1].
>
> Feedback and tests on this series is very much appreciated.
>
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
>
> Thanks,
> Shameer
> [0] https://developer.arm.com/documentation/den0049/latest/
> [1] https://lore.kernel.org/linux-acpi/20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com/T/#m043c95b869973a834b2fd57f3e1ed0325c84f3b7
> ------
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
>
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
>
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> ------
>
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
>
> Shameer Kolothum (8):
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Add support for RMR node parsing
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/dma: Reserve any RMR regions associated with a dev
>
>  drivers/acpi/arm64/iort.c                   | 172 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  76 +++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  48 ++++++
>  drivers/iommu/dma-iommu.c                   |  89 +++++++++-
>  include/linux/acpi_iort.h                   |   7 +
>  include/linux/dma-iommu.h                   |  13 ++
>  include/linux/iommu.h                       |  11 ++
>  7 files changed, 393 insertions(+), 23 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
