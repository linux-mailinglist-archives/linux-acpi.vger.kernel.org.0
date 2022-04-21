Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751AD50A025
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDUNBc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiDUNBb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 09:01:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F94532061
        for <linux-acpi@vger.kernel.org>; Thu, 21 Apr 2022 05:58:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7DB21480;
        Thu, 21 Apr 2022 05:58:40 -0700 (PDT)
Received: from [10.1.33.17] (e122027.cambridge.arm.com [10.1.33.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A833F73B;
        Thu, 21 Apr 2022 05:58:38 -0700 (PDT)
Message-ID: <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
Date:   Thu, 21 Apr 2022 13:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20/04/2022 17:48, Shameer Kolothum wrote:
> Hi
> 
> v9 --> v10
>  - Dropped patch #1 ("Add temporary RMR node flag definitions") since
>    the ACPICA header updates patch is now in the mailing list[1]
>  - Based on the suggestion from Christoph, introduced a 
>    resv_region_free_fw_data() callback in struct iommu_resv_region and
>    used that to free RMR specific memory allocations.
> 
> Though there is a small change from v9 with respect to how we free up
> the FW specific data, I have taken the liberty to pick up the R-by and
> T-by tags from Lorenzo, Steve and Laurentiu. But please do take a look
> again and let me know.

I've given this a go and it works fine on my Juno setup. So do keep my
T-by tag.

Sami has been kind enough to give me an updated firmware which also
fixes the RMR node in the IORT. Although as mentioned before the details
of the RMR node are currently being ignored so this doesn't change the
functionality but silences the warning.

My concern is that with the RMR region effectively ignored we may see
more broken firmware, and while a length of zero produces a warning, an
otherwise incorrect length will currently "silently work" but mean that
any future tightening would cause problems. For example if the SMMU
driver were to recreate the mappings to only cover the region specified
in the RMR it may not be large enough if the RMR base/length are not
correct. It's up to the maintainers as to whether they see this as a
problem or not.

Thanks,

Steve

> Thanks,
> Shameer
> [1] https://lore.kernel.org/all/44610361.fMDQidcC6G@kreacher/
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
> v8 --> v9
>  - Adressed comments from Robin on interfaces.
>  - Addressed comments from Lorenzo.
> 
> v7 --> v8
>   - Patch #1 has temp definitions for RMR related changes till
>     the ACPICA header changes are part of kernel.
>   - No early parsing of RMR node info and is only parsed at the
>     time of use.
>   - Changes to the RMR get/put API format compared to the
>     previous version.
>   - Support for RMR descriptor shared by multiple stream IDs.
> 
> v6 --> v7
>  -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
> 
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
> 
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
> 
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
> 
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> 
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (8):
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
>   ACPI/IORT: Provide a generic helper to retrieve reserve regions
>   ACPI/IORT: Add support to retrieve IORT RMR reserved regions
>   ACPI/IORT: Add a helper to retrieve RMR info directly
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> 
>  drivers/acpi/arm64/iort.c                   | 335 ++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  78 ++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  52 +++
>  drivers/iommu/dma-iommu.c                   |   2 +-
>  drivers/iommu/iommu.c                       |  12 +-
>  include/linux/acpi_iort.h                   |  14 +-
>  include/linux/iommu.h                       |  13 +
>  7 files changed, 461 insertions(+), 45 deletions(-)
> 

