Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C641D6BD
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349464AbhI3Jtx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 05:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235763AbhI3Jtx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Sep 2021 05:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632995290;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkERdnxjQvWX8y2vZWvMiljBX7L/3S/wCVIkI75JXx8=;
        b=Pmla94xqPHGpJ7bh8h0WOWM13r+8Dv0DsZoVbn6nTmY75FSHeX8xCLcgSl/u7dM/9xnxG/
        49D3jk16bR9OieZ7chJ+gs+NhrPiuekWigeg7AehgVaKRJe333SDSh28acTT/+doxY3aU4
        tw5SSgkwnh+EhoZCX3LgkfY7Bz4o/To=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-ThiZfM3tOPCRyhJ0JccJvw-1; Thu, 30 Sep 2021 05:48:02 -0400
X-MC-Unique: ThiZfM3tOPCRyhJ0JccJvw-1
Received: by mail-wm1-f69.google.com with SMTP id n3-20020a7bcbc3000000b0030b68c4de38so1759747wmi.8
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 02:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=AkERdnxjQvWX8y2vZWvMiljBX7L/3S/wCVIkI75JXx8=;
        b=iKfIpLB6He6ZDyF4a3tP5ejvA7+bMAGJXbLa6PgR6X5ZXZ3M2Uc9XwXbb6F61V30kI
         rvuMb6SYq0yYvOE6E1WAs04k/ZVNb6sFC0uWcEJtnlSMwuOr103LWWUjxS1kJKYjk7t6
         j55p/ZWSL3/q9/NDf3JjI4bCUaHpGPHq13ZNoMAEoGVuRVq7ih6RzGg0/Hn+mX2Wypo5
         uznxKfh0HK0xDwzAtJFQu+D7ExJ9LchpNvX8XZcw+7svn4WbXqbtYww4rXv6uPF9d+fc
         x3I/eS603uQeTVnmJhE5qz8KtZ8pk8DtsTwIIkXEYspPfmEheF1uHfT4RjVJfvmjzeZ0
         QjOQ==
X-Gm-Message-State: AOAM531nTVF8DyhUfnyDd18w7tQa0U0DQVPGEgl/gT1AHtkOiUPq8QqA
        lgfM7eOZXZA6W5aSNc9S/Oi2cA+gZoKa4DLaY72ULwOwCthhateKEcLiPqTTEPjAyZzAPXhCUZM
        +h6j43F6GLWB6cDhvQ8sClg==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4994016wrs.271.1632995281422;
        Thu, 30 Sep 2021 02:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaDvcFZ2x9w+vQ0EkZIMR3CDNEjtRYvJj08zAq6M2jLFo3lEyLjpSfSP2fGPPBTZ+aX+mPiw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4993985wrs.271.1632995281178;
        Thu, 30 Sep 2021 02:48:01 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id c18sm2430699wmb.27.2021.09.30.02.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 02:48:00 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, yangyicong@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <b546b40c-d047-87a4-1892-1bb9575ecab7@redhat.com>
Date:   Thu, 30 Sep 2021 11:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 8/5/21 10:07 AM, Shameer Kolothum wrote:
> Hi,
>
> The series adds support to IORT RMR nodes specified in IORT
> Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
> memory ranges that are used by endpoints and require a unity
> mapping in SMMU.

I used your series and RMRs to force a guest iommu (vSMMUv3 nested stage
use case) to have a flat mapping for IOVAs within [0x8000000, 0x8100000]
(matching MSI_IOVA_BASE and MSI_IOVA_LENGTH) used by the host to map MSI
physical doorbells.

That way when an assigned device protected by a vSMMUv3 implemented upon
nested stage issues an MSI transaction, let's say using IOVA=0x8000000,
we would get:
                    S1 (guest)           S2 (host)
0x8000000            0x8000000            Physical DB

This method was suggested by Jean-Philippe (added in CC) and it
simplifies the nested stage integration because we don't have to care
about nested stage MSI bindings.

However if I understand correctly we cannot define a range of SIDs using
the same RMR (due to the single mapping bit which must be set, Table 5
flags format). This is a spec restriction and not an issue with your series.

As VFIO devices can be hot-plugged we thus need to create as many RMR
nodes as potential BDFs, leading to 256 * 6 = 1536 RMR nodes if you have
5 pcie root ports as it is usual in VMs. Then this causes some trouble
at qemu level for instance, wrt migration. See [RFC]
hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested binding.

Do you know if there is a plan to remove the single mapping limitation
in the spec?

Thanks

Eric
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
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
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

