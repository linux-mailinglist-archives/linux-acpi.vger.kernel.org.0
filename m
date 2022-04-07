Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93E4F83C8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Apr 2022 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiDGPpt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Apr 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiDGPps (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2022 11:45:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 962E71024
        for <linux-acpi@vger.kernel.org>; Thu,  7 Apr 2022 08:43:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB5A12FC;
        Thu,  7 Apr 2022 08:43:43 -0700 (PDT)
Received: from [10.1.39.18] (e122027.cambridge.arm.com [10.1.39.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112223F73B;
        Thu,  7 Apr 2022 08:43:39 -0700 (PDT)
Message-ID: <83313d86-5ee4-4c61-f5a2-48aff4a5f091@arm.com>
Date:   Thu, 7 Apr 2022 16:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 00/11] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com,
        yangyicong@huawei.com
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

I've given it a spin on my Juno board and the EFIFB works fine with it.
However I am getting a warning:

ACPI: IORT: [Firmware Bug]: RMR descriptor[0xf80d0000] with zero length,
continue anyway

Which on examination of the IORT table is correct - the firmware does
indeed seem to have a bug and the length in the IORT table is 0,
hopefully I can get that fixed. However since it "all works" that points
out that the reserved memory region isn't actually used. Instead the
existing entries from the SMMU are reused (even though they don't match
the address/size region in the RMR).

I'm not sure if that matters but I thought it worth pointing out as it's
not currently spelt out that the RMR descriptor's content is currently
actually ignored.

Anyway, FWIW:

Tested-by: Steven Price <steven.price@arm.com>

Steve

On 04/04/2022 13:41, Shameer Kolothum wrote:
> Hi
> 
> v8 --> v9
>  - Adressed comments from Robin on interfaces as discussed here[0].
>  - Addressed comments from Lorenzo.
>  
> Though functionally there aren't any major changes, the interfaces have
> changed from v8 and for that reason not included the T-by tags from
> Steve and Eric yet(Many thanks for that). Appreciate it if you could
> give this a spin and let me know.
> 
> (The revised ACPICA pull request for IORT E.d related changes is
> here[1] and this is now merged to acpica:master.)
> 
> Please take a look and let me know your thoughts.
> 
> Thanks,
> Shameer
> [0] https://lore.kernel.org/linux-arm-kernel/c982f1d7-c565-769a-abae-79c962969d88@arm.com/
> [1] https://github.com/acpica/acpica/pull/765
> 
> From old:
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
> v7 --> v8
>   - Patch #1 has temp definitions for RMR related changes till
>     the ACPICA header changes are part of kernel.
>   - No early parsing of RMR node info and is only parsed at the
>     time of use.
>   - Changes to the RMR get/put API format compared to the
>     previous version.
>   - Support for RMR descriptor shared by multiple stream IDs.
> 
> v6 --> v7
>  -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
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
> 
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (10):
>   ACPI/IORT: Add temporary RMR node flag definitions
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
>   ACPI/IORT: Provide a generic helper to retrieve reserve regions
>   iommu/dma: Introduce a helper to remove reserved regions
>   ACPI/IORT: Add support to retrieve IORT RMR reserved regions
>   ACPI/IORT: Add a helper to retrieve RMR info directly
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> 
>  drivers/acpi/arm64/iort.c                   | 369 ++++++++++++++++++--
>  drivers/iommu/apple-dart.c                  |   2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  80 ++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  54 ++-
>  drivers/iommu/dma-iommu.c                   |  11 +-
>  drivers/iommu/virtio-iommu.c                |   2 +-
>  include/linux/acpi_iort.h                   |  18 +-
>  include/linux/dma-iommu.h                   |   5 +
>  include/linux/iommu.h                       |   9 +
>  9 files changed, 505 insertions(+), 45 deletions(-)
> 

