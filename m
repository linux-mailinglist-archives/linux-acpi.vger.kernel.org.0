Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B837E37F8FE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhEMNrc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 09:47:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2661 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhEMNrc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 09:47:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FgtDQ6dQ2zmVcB;
        Thu, 13 May 2021 21:44:06 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:10 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v4 0/8] ACPI/IORT: Support for IORT RMR node
Date:   Thu, 13 May 2021 14:45:42 +0100
Message-ID: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

v3 -->v4
-Included the SMMUv2 SMR bypass install changes suggested by
 Steve(patch #7)
-As per Robin's comments, RMR reserve implementation is now
 more generic  (patch #8) and dropped v3 patches 8 and 10.
-Rebase to 5.13-rc1 

The whole series is available here,
https://github.com/hisilicon/kernel-dev/tree/private-v5.13-rc1-rmr-v4-ext

RFC v2 --> v3
 -Dropped RFC tag as the ACPICA header changes are now ready to be
  part of 5.13[0]. But this series still has a dependency on that patch.
 -Added IORT E.b related changes(node flags, _DSM function 5 checks for
  PCIe).
 -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
  discussion here[1].
 -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!) 

Sanity tested on a HiSilicon D06. Further testing and feedback is greatly
appreciated.

https://github.com/hisilicon/kernel-dev/tree/private-v5.12-rc8-rmr-v3

Thanks,
Shameer

[0] https://lore.kernel.org/linux-acpi/20210406213028.718796-22-erik.kaneda@intel.com/
[1] https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-April/000150.html

RFC v1 --> v2:
 - Added a generic interface for IOMMU drivers to retrieve all the 
   RMR info associated with a given IOMMU.
 - SMMUv3 driver gets the RMR list during probe() and installs
   bypass STEs for all the SIDs in the RMR list. This is to keep
   the ongoing traffic alive(if any) during SMMUv3 reset. This is
   based on the suggestions received for v1 to take care of the
   EFI framebuffer use case. Only sanity tested for now.
 - During the probe/attach device, SMMUv3 driver reserves any
   RMR region associated with the device such that there is a unity
   mapping for them in SMMU.
---    

From RFC v1:
-------------
The series adds support to IORT RMR nodes specified in IORT
Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
ranges that are used by endpoints and require a unity mapping
in SMMU.

We have faced issues with 3408iMR RAID controller cards which
fail to boot when SMMU is enabled. This is because these controllers
make use of host memory for various caching related purposes and when
SMMU is enabled the iMR firmware fails to access these memory regions
as there is no mapping for them. IORT RMR provides a way for UEFI to
describe and report these memory regions so that the kernel can make
a unity mapping for these in SMMU.

Tests:

With a UEFI, that reports the RMR for the dev,
....
[16F0h 5872   1]                         Type : 06
[16F1h 5873   2]                       Length : 007C
[16F3h 5875   1]                     Revision : 00
[1038h 0056   2]                     Reserved : 00000000
[1038h 0056   2]                   Identifier : 00000000
[16F8h 5880   4]                Mapping Count : 00000001
[16FCh 5884   4]               Mapping Offset : 00000040

[1700h 5888   4]    Number of RMR Descriptors : 00000002
[1704h 5892   4]        RMR Descriptor Offset : 00000018

[1708h 5896   8]          Base Address of RMR : 0000E6400000
[1710h 5904   8]                Length of RMR : 000000100000
[1718h 5912   4]                     Reserved : 00000000

[171Ch 5916   8]          Base Address of RMR : 0000000027B00000
[1724h 5924   8]                Length of RMR : 0000000000C00000
[172Ch 5932   4]                     Reserved : 00000000

[1730h 5936   4]                   Input base : 00000000
[1734h 5940   4]                     ID Count : 00000001
[1738h 5944   4]                  Output Base : 00000003
[173Ch 5948   4]             Output Reference : 00000064
[1740h 5952   4]        Flags (decoded below) : 00000001
                               Single Mapping : 1
...

Without the series the RAID controller initialization fails as
below,

...
[   12.631117] megaraid_sas 0000:03:00.0: FW supports sync cache        : Yes   
[   12.637360] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009                                                   
[   18.776377] megaraid_sas 0000:03:00.0: Init cmd return status FAILED for SCSI host 0                                                                         
[   23.019383] megaraid_sas 0000:03:00.0: Waiting for FW to come to ready state 
[  106.684281] megaraid_sas 0000:03:00.0: FW in FAULT state, Fault code:0x10000 subcode:0x0 func:megasas_transition_to_ready                                    
[  106.695186] megaraid_sas 0000:03:00.0: System Register set:                  
[  106.889787] megaraid_sas 0000:03:00.0: Failed to transition controller to ready for scsi0.                                                                   
[  106.910475] megaraid_sas 0000:03:00.0: Failed from megasas_init_fw 6407      
estuary:/$

With the series, now the kernel has direct mapping for the dev as
below,

estuary:/$ cat /sys/kernel/iommu_groups/0/reserved_regions                      
0x0000000008000000 0x00000000080fffff msi                                       
0x0000000027b00000 0x00000000286fffff direct                                    
0x00000000e6400000 0x00000000e64fffff direct                                    
estuary:/$

....
[   12.254318] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009                                                   
[   12.739089] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs: 0      max_lds: 32                                                                      
[   12.746628] megaraid_sas 0000:03:00.0: controller type       : iMR(0MB)      
[   12.752694] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled                                                                               
[   12.759798] megaraid_sas 0000:03:00.0: Secure JBOD support   : Yes           
[   12.765778] megaraid_sas 0000:03:00.0: NVMe passthru support : Yes           
[   12.771931] megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Reset timeou: 6 secs/60 secs                                                                 
[   12.780503] megaraid_sas 0000:03:00.0: JBOD sequence map support     : Yes   
[   12.787000] megaraid_sas 0000:03:00.0: PCI Lane Margining support    : No    
[   12.819179] megaraid_sas 0000:03:00.0: NVME page size        : (4096)        
[   12.825672] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000                                                    
[   12.835199] megaraid_sas 0000:03:00.0: INIT adapter done                     
[   12.873932] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x0017)/(0x19e5)/(0xd213)                                                           
[   12.881644] megaraid_sas 0000:03:00.0: unevenspan support    : no            
[   12.887451] megaraid_sas 0000:03:00.0: firmware crash dump   : no            
[   12.893344] megaraid_sas 0000:03:00.0: JBOD sequence map     : enabled       

RAID controller init is now success and can detect the drives
attached as well.

Jon Nettleton (1):
  iommu/arm-smmu: Get associated RMR info and install bypass SMR

Shameer Kolothum (7):
  ACPI/IORT: Add support for RMR node parsing
  iommu/dma: Introduce generic helper to retrieve RMR info
  ACPI/IORT: Add a helper to retrieve RMR memory regions
  iommu/arm-smmu-v3: Introduce strtab init helper
  iommu/arm-smmu-v3: Add bypass flag to arm_smmu_write_strtab_ent()
  iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
  iommu/dma: Reserve any RMR regions associated with a dev

 drivers/acpi/arm64/iort.c                   | 144 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  69 +++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  64 +++++++++
 drivers/iommu/dma-iommu.c                   | 102 +++++++++++++-
 include/linux/acpi_iort.h                   |   7 +
 include/linux/dma-iommu.h                   |  10 ++
 include/linux/iommu.h                       |  19 +++
 7 files changed, 392 insertions(+), 23 deletions(-)

-- 
2.17.1

