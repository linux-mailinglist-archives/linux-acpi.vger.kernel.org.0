Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105884CBB86
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiCCKig (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 05:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiCCKia (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 05:38:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B7453E08
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 02:37:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0697E1424;
        Thu,  3 Mar 2022 02:37:44 -0800 (PST)
Received: from [10.1.27.23] (e122027.cambridge.arm.com [10.1.27.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D7A3F73D;
        Thu,  3 Mar 2022 02:37:42 -0800 (PST)
Message-ID: <dc755b11-ece7-4028-b153-cc8b9301099c@arm.com>
Date:   Thu, 3 Mar 2022 10:37:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/02/2022 15:43, Shameer Kolothum wrote:
> Hi,
> 
> Since we now have an updated verion[0] of IORT spec(E.d) which
> addresses the memory attributes issues discussed here [1],
> this series now make use of it.
> 
> The pull request for ACPICA E.d related changes are already
> raised and can be found here,
> https://github.com/acpica/acpica/pull/752
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
> Please take a look and let me know your thoughts.

Hi Shameer,

I've now been able to test this on the Juno platform with a modified
firmware supporting the newer spec (thanks Sami!). Everything works, so
feel free to add my:

Tested-by: Steven Price <steven.price@arm.com>

(Note that I haven't tested the smmu-v3 support)

Thanks,

Steve

> Thanks,
> Shameer
> [0] https://developer.arm.com/documentation/den0049/ed/
> [1] https://lore.kernel.org/linux-acpi/20210805160319.GB23085@lpieralisi/
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
>   ACPI/IORT: Add helper functions to parse RMR nodes
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
>   iommu/arm-smmu: Reserve any RMR regions associated with a dev
> 
>  drivers/acpi/arm64/iort.c                   | 305 ++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  91 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  65 ++++-
>  drivers/iommu/dma-iommu.c                   |  25 ++
>  include/linux/acpi_iort.h                   |  14 +
>  include/linux/dma-iommu.h                   |  14 +
>  include/linux/iommu.h                       |   9 +
>  7 files changed, 504 insertions(+), 19 deletions(-)
> 

