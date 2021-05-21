Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11938C737
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhEUM5V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 08:57:21 -0400
Received: from foss.arm.com ([217.140.110.172]:46640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232627AbhEUM4u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 May 2021 08:56:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C73411B3;
        Fri, 21 May 2021 05:55:26 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4729E3F719;
        Fri, 21 May 2021 05:55:24 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fcb7bec5-f9ea-1785-64fa-af673ce64053@arm.com>
Date:   Fri, 21 May 2021 13:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 13/05/2021 14:45, Shameer Kolothum wrote:
> Hi,
> 
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1 
> 
> The whole series is available here,
> https://github.com/hisilicon/kernel-dev/tree/private-v5.13-rc1-rmr-v4-ext
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
> Sanity tested on a HiSilicon D06. Further testing and feedback is greatly
> appreciated.

With the updated SMMUv2 support this works fine on my Juno with EFIFB
(and corresponding patches to the firmware to expose the ACPI tables).
Feel free to add

Tested-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc8-rmr-v3
> 
> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/linux-acpi/20210406213028.718796-22-erik.kaneda@intel.com/
> [1] https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-April/000150.html
> 
> RFC v1 --> v2:
>  - Added a generic interface for IOMMU drivers to retrieve all the 
>    RMR info associated with a given IOMMU.
>  - SMMUv3 driver gets the RMR list during probe() and installs
>    bypass STEs for all the SIDs in the RMR list. This is to keep
>    the ongoing traffic alive(if any) during SMMUv3 reset. This is
>    based on the suggestions received for v1 to take care of the
>    EFI framebuffer use case. Only sanity tested for now.
>  - During the probe/attach device, SMMUv3 driver reserves any
>    RMR region associated with the device such that there is a unity
>    mapping for them in SMMU.
> ---    
> 
> From RFC v1:
> -------------
> The series adds support to IORT RMR nodes specified in IORT
> Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
> ranges that are used by endpoints and require a unity mapping
> in SMMU.
> 
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these controllers
> make use of host memory for various caching related purposes and when
> SMMU is enabled the iMR firmware fails to access these memory regions
> as there is no mapping for them. IORT RMR provides a way for UEFI to
> describe and report these memory regions so that the kernel can make
> a unity mapping for these in SMMU.
> 
> Tests:
> 
> With a UEFI, that reports the RMR for the dev,
> ....
> [16F0h 5872   1]                         Type : 06
> [16F1h 5873   2]                       Length : 007C
> [16F3h 5875   1]                     Revision : 00
> [1038h 0056   2]                     Reserved : 00000000
> [1038h 0056   2]                   Identifier : 00000000
> [16F8h 5880   4]                Mapping Count : 00000001
> [16FCh 5884   4]               Mapping Offset : 00000040
> 
> [1700h 5888   4]    Number of RMR Descriptors : 00000002
> [1704h 5892   4]        RMR Descriptor Offset : 00000018
> 
> [1708h 5896   8]          Base Address of RMR : 0000E6400000
> [1710h 5904   8]                Length of RMR : 000000100000
> [1718h 5912   4]                     Reserved : 00000000
> 
> [171Ch 5916   8]          Base Address of RMR : 0000000027B00000
> [1724h 5924   8]                Length of RMR : 0000000000C00000
> [172Ch 5932   4]                     Reserved : 00000000
> 
> [1730h 5936   4]                   Input base : 00000000
> [1734h 5940   4]                     ID Count : 00000001
> [1738h 5944   4]                  Output Base : 00000003
> [173Ch 5948   4]             Output Reference : 00000064
> [1740h 5952   4]        Flags (decoded below) : 00000001
>                                Single Mapping : 1
> ...
> 
> Without the series the RAID controller initialization fails as
> below,
> 
> ...
> [   12.631117] megaraid_sas 0000:03:00.0: FW supports sync cache        : Yes   
> [   12.637360] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009                                                   
> [   18.776377] megaraid_sas 0000:03:00.0: Init cmd return status FAILED for SCSI host 0                                                                         
> [   23.019383] megaraid_sas 0000:03:00.0: Waiting for FW to come to ready state 
> [  106.684281] megaraid_sas 0000:03:00.0: FW in FAULT state, Fault code:0x10000 subcode:0x0 func:megasas_transition_to_ready                                    
> [  106.695186] megaraid_sas 0000:03:00.0: System Register set:                  
> [  106.889787] megaraid_sas 0000:03:00.0: Failed to transition controller to ready for scsi0.                                                                   
> [  106.910475] megaraid_sas 0000:03:00.0: Failed from megasas_init_fw 6407      
> estuary:/$
> 
> With the series, now the kernel has direct mapping for the dev as
> below,
> 
> estuary:/$ cat /sys/kernel/iommu_groups/0/reserved_regions                      
> 0x0000000008000000 0x00000000080fffff msi                                       
> 0x0000000027b00000 0x00000000286fffff direct                                    
> 0x00000000e6400000 0x00000000e64fffff direct                                    
> estuary:/$
> 
> ....
> [   12.254318] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009                                                   
> [   12.739089] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs: 0      max_lds: 32                                                                      
> [   12.746628] megaraid_sas 0000:03:00.0: controller type       : iMR(0MB)      
> [   12.752694] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled                                                                               
> [   12.759798] megaraid_sas 0000:03:00.0: Secure JBOD support   : Yes           
> [   12.765778] megaraid_sas 0000:03:00.0: NVMe passthru support : Yes           
> [   12.771931] megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Reset timeou: 6 secs/60 secs                                                                 
> [   12.780503] megaraid_sas 0000:03:00.0: JBOD sequence map support     : Yes   
> [   12.787000] megaraid_sas 0000:03:00.0: PCI Lane Margining support    : No    
> [   12.819179] megaraid_sas 0000:03:00.0: NVME page size        : (4096)        
> [   12.825672] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000                                                    
> [   12.835199] megaraid_sas 0000:03:00.0: INIT adapter done                     
> [   12.873932] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x0017)/(0x19e5)/(0xd213)                                                           
> [   12.881644] megaraid_sas 0000:03:00.0: unevenspan support    : no            
> [   12.887451] megaraid_sas 0000:03:00.0: firmware crash dump   : no            
> [   12.893344] megaraid_sas 0000:03:00.0: JBOD sequence map     : enabled       
> 
> RAID controller init is now success and can detect the drives
> attached as well.
> 
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (7):
>   ACPI/IORT: Add support for RMR node parsing
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Add bypass flag to arm_smmu_write_strtab_ent()
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/dma: Reserve any RMR regions associated with a dev
> 
>  drivers/acpi/arm64/iort.c                   | 144 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  69 +++++++---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  64 +++++++++
>  drivers/iommu/dma-iommu.c                   | 102 +++++++++++++-
>  include/linux/acpi_iort.h                   |   7 +
>  include/linux/dma-iommu.h                   |  10 ++
>  include/linux/iommu.h                       |  19 +++
>  7 files changed, 392 insertions(+), 23 deletions(-)
> 

