Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004BA3599D2
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Apr 2021 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIJvK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Apr 2021 05:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhDIJvK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Apr 2021 05:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617961857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XloTO/4KZO4SQiWw+kIM60zJVTn3Rta9Nj+OyXz85uQ=;
        b=O5K4r6DNP4iQT+jsaZVCEnWmH6Eu/Qucjr5htQdsIxwy6gDDa1b+Q0omqvht2H9HL4HEAo
        I/vGH9amTpIve85JpTaBL37dU6j5E9uFfoySgHalHyYJhAMO2/E/OK1fUEck8ShQSQCiRp
        y86trqNKAu1VQ16zUsAlEucMX9LYGpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-4jhqtUGPORWr0nAz2VyaVA-1; Fri, 09 Apr 2021 05:50:53 -0400
X-MC-Unique: 4jhqtUGPORWr0nAz2VyaVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E7983DD22;
        Fri,  9 Apr 2021 09:50:51 +0000 (UTC)
Received: from [10.36.114.73] (ovpn-114-73.ams2.redhat.com [10.36.114.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1335D5D9C0;
        Fri,  9 Apr 2021 09:50:46 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
        Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <3f17f414-e602-6c63-6d8c-e37237e27ced@redhat.com>
Date:   Fri, 9 Apr 2021 11:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 11/19/20 1:11 PM, Shameer Kolothum wrote:
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
> RFC because, Patch #1 is to update the actbl2.h and should be done
> through acpica update. I have send out a pull request[1] for that.

What is the state of this series? I wondered if I should consider using
it for nested SMMU to avoid handling nested binding for MSI, as
suggested by Jean. Are there any blocker?

Thanks

Eric
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
> Thanks,
> Shameer
> 
> [0]. https://developer.arm.com/documentation/den0049/latest/
> [1]. https://github.com/acpica/acpica/pull/638
> 
> Shameer Kolothum (8):
>   ACPICA: IORT: Update for revision E
>   ACPI/IORT: Add support for RMR node parsing
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add RMR memory regions reservation helper
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Add bypass flag to arm_smmu_write_strtab_ent()
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
> 
>  drivers/acpi/arm64/iort.c                   | 182 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 112 ++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
>  drivers/iommu/dma-iommu.c                   |  39 +++++
>  include/acpi/actbl2.h                       |  25 ++-
>  include/linux/acpi_iort.h                   |   6 +
>  include/linux/dma-iommu.h                   |   7 +
>  include/linux/iommu.h                       |  16 ++
>  8 files changed, 367 insertions(+), 22 deletions(-)
> 

