Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B834D5F99
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 11:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347957AbiCKKfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347953AbiCKKfe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 05:35:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E871D10241F
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 02:34:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA1D16A3;
        Fri, 11 Mar 2022 02:34:30 -0800 (PST)
Received: from [10.57.43.199] (unknown [10.57.43.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC1E3F7D8;
        Fri, 11 Mar 2022 02:34:27 -0800 (PST)
Message-ID: <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
Date:   Fri, 11 Mar 2022 10:34:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     eric.auger@redhat.com,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-03-11 08:19, Eric Auger wrote:
> Hi guys,
> 
> On 2/21/22 4:43 PM, Shameer Kolothum wrote:
>> Hi,
>>
>> Since we now have an updated verion[0] of IORT spec(E.d) which
>> addresses the memory attributes issues discussed here [1],
>> this series now make use of it.
>>
>> The pull request for ACPICA E.d related changes are already
>> raised and can be found here,
>> https://github.com/acpica/acpica/pull/752
>>
>> v7 --> v8
>>    - Patch #1 has temp definitions for RMR related changes till
>>      the ACPICA header changes are part of kernel.
>>    - No early parsing of RMR node info and is only parsed at the
>>      time of use.
>>    - Changes to the RMR get/put API format compared to the
>>      previous version.
>>    - Support for RMR descriptor shared by multiple stream IDs.
>>
>> Please take a look and let me know your thoughts.
>>
>> Thanks,
>> Shameer
>> [0] https://developer.arm.com/documentation/den0049/ed/
> I still have a question on the IORT E.d spec (unrelated to this series).
> 
> The spec mandates that if RMR nodes are presented in the IORT,
> _DSM function #5 for the PCIe host bridge ACPI device object must return
> 0, indicating the OS must honour the PCI config that the FW computed at
> boot time.
> 
> However implementing this _DSM #5 as above is known to prevent PCI
> devices with IO ports from working, on aarch64 linux.
> 
> "
> The reason is that EFI creates I/O port mappings below
>      0x1000 (in fact, at 0). However Linux, for legacy reasons, does not
>      support I/O ports <= 0x1000 on PCI, so the I/O assignment created by EFI
>      is rejected.
>     
>      EFI creates the mappings primarily for itself, and up until DSM #5
>      started to be enforced, all PCI resource allocations that existed at
>      boot were ignored by Linux and recreated from scratch.
> "
> 
> This is an excerpt of a qemu commit message that reverted the _DMS #5
> change (Revert "acpi/gpex: Inform os to keep firmware resource map").
> Has the situation changed since July 2021 (ie. has UEFI been reworked?).
> [+ Ard]

FWIW I wasn't aware of that, but if it's an issue then it will need to 
be fixed in Linux or UEFI's PCI resource code (arguably if UEFI has 
already allocated from the bottom of I/O space then Linux should be safe 
to assume that there are no legacy PC I/O resources to worry about). The 
DSM is required to prevent bus numbers being reassigned, because if that 
happens then any PCI StreamIDs referenced in IORT may suddenly become 
meaningless and the association of root complex nodes and RMRs to 
physical hardware lost.

Robin.

> Thank you in advance
> 
> Regards
> 
> Eric
> 
> 
> 
> 
>> [1] https://lore.kernel.org/linux-acpi/20210805160319.GB23085@lpieralisi/
>>
>>  From old:
>> We have faced issues with 3408iMR RAID controller cards which
>> fail to boot when SMMU is enabled. This is because these
>> controllers make use of host memory for various caching related
>> purposes and when SMMU is enabled the iMR firmware fails to
>> access these memory regions as there is no mapping for them.
>> IORT RMR provides a way for UEFI to describe and report these
>> memory regions so that the kernel can make a unity mapping for
>> these in SMMU.
>>
>> Change History:
>>
>> v6 --> v7
>>   -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
>>
>> v5 --> v6
>> - Addressed comments from Robin & Lorenzo.
>>    : Moved iort_parse_rmr() to acpi_iort_init() from
>>      iort_init_platform_devices().
>>    : Removed use of struct iort_rmr_entry during the initial
>>      parse. Using struct iommu_resv_region instead.
>>    : Report RMR address alignment and overlap errors, but continue.
>>    : Reworked arm_smmu_init_bypass_stes() (patch # 6).
>> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
>> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>>    on Type of RMR region. Suggested by Jon N.
>>
>> v4 --> v5
>>   -Added a fw_data union to struct iommu_resv_region and removed
>>    struct iommu_rmr (Based on comments from Joerg/Robin).
>>   -Added iommu_put_rmrs() to release mem.
>>   -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>>    yet because of the above changes.
>>
>> v3 -->v4
>> -Included the SMMUv2 SMR bypass install changes suggested by
>>   Steve(patch #7)
>> -As per Robin's comments, RMR reserve implementation is now
>>   more generic  (patch #8) and dropped v3 patches 8 and 10.
>> -Rebase to 5.13-rc1
>>
>> RFC v2 --> v3
>>   -Dropped RFC tag as the ACPICA header changes are now ready to be
>>    part of 5.13[0]. But this series still has a dependency on that patch.
>>   -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>>    PCIe).
>>   -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>>    discussion here[1].
>>   -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
>>
>> Jon Nettleton (1):
>>    iommu/arm-smmu: Get associated RMR info and install bypass SMR
>>
>> Shameer Kolothum (10):
>>    ACPI/IORT: Add temporary RMR node flag definitions
>>    iommu: Introduce a union to struct iommu_resv_region
>>    ACPI/IORT: Add helper functions to parse RMR nodes
>>    iommu/dma: Introduce generic helper to retrieve RMR info
>>    ACPI/IORT: Add a helper to retrieve RMR memory regions
>>    iommu/arm-smmu-v3: Introduce strtab init helper
>>    iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>>      bypass
>>    iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>>    iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
>>    iommu/arm-smmu: Reserve any RMR regions associated with a dev
>>
>>   drivers/acpi/arm64/iort.c                   | 305 ++++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  91 ++++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  65 ++++-
>>   drivers/iommu/dma-iommu.c                   |  25 ++
>>   include/linux/acpi_iort.h                   |  14 +
>>   include/linux/dma-iommu.h                   |  14 +
>>   include/linux/iommu.h                       |   9 +
>>   7 files changed, 504 insertions(+), 19 deletions(-)
>>
> 
