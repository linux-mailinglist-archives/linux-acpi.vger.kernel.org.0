Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02D729D923
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbgJ1Woo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:44:44 -0400
Received: from foss.arm.com ([217.140.110.172]:40608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbgJ1WmP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2557E1A32;
        Wed, 28 Oct 2020 09:43:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7D93F66E;
        Wed, 28 Oct 2020 09:43:49 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     lorenzo.pieralisi@arm.com, joro@8bytes.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com,
        guohanjun@huawei.com, robin.murphy@arm.com,
        wanghuiqiang@huawei.com, Sami Mujawar <Sami.Mujawar@arm.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
Date:   Wed, 28 Oct 2020 16:43:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 27/10/2020 11:26, Shameer Kolothum wrote:
> The series adds support to IORT RMR nodes specified in IORT
> Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
> ranges that are used by endpoints and require a unity mapping
> in SMMU.

Hi Shameer,

I've also been taking a look at RMR, and Sami is helping me get set up 
so that I can do some testing. We're hoping to be able to test an EFI 
framebuffer or splash screen - which has the added complication of the 
unity mapping becoming redundant if a native display driver takes over 
the display controller.

I've looked through your series and the code looks correct to me. 
Hopefully I'll be able to give it some testing soon.

Thanks,

Steve

> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these controllers
> make use of host memory for various caching related purposes and when
> SMMU is enabled the iMR firmware fails to access these memory regions
> as there is no mapping for them. IORT RMR provides a way for UEFI to
> describe and report these memory regions so that the kernel can make
> a unity mapping for these in SMMU.
> 
> RFC because, Patch #1 is to update the actbl2.h and should be done
> through acpica update. I have send out a pull request[1] for that.
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
>                                 Single Mapping : 1
> ...
> 
> Without the series the RAID controller initilization fails as
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
> Thanks,
> Shameer
> 
> [0]. https://developer.arm.com/documentation/den0049/latest/
> [1]. https://github.com/acpica/acpica/pull/638
> 
> Shameer Kolothum (4):
>    ACPICA: IORT: Update for revision E
>    ACPI/IORT: Add support for RMR node parsing
>    ACPI/IORT: Add RMR memory regions reservation helper
>    iommu/dma: Reserve any RMR regions associated with a dev
> 
>   drivers/acpi/arm64/iort.c | 175 +++++++++++++++++++++++++++++++++++++-
>   drivers/iommu/dma-iommu.c |  12 ++-
>   include/acpi/actbl2.h     |  25 ++++--
>   include/linux/acpi_iort.h |   4 +
>   4 files changed, 205 insertions(+), 11 deletions(-)
> 

