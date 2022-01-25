Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95149BC20
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jan 2022 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiAYTbA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jan 2022 14:31:00 -0500
Received: from foss.arm.com ([217.140.110.172]:37282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbiAYTaw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jan 2022 14:30:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788AC1FB;
        Tue, 25 Jan 2022 11:30:51 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5BD3F7D8;
        Tue, 25 Jan 2022 11:30:49 -0800 (PST)
Message-ID: <93374408-9522-8648-3417-0d8750d652bb@arm.com>
Date:   Tue, 25 Jan 2022 19:30:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <9da65c2504b944398188e468eac1abff@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9da65c2504b944398188e468eac1abff@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-01-25 13:00, Shameerali Kolothum Thodi wrote:
> Hi Robin/Lorenzo,
> 
>> -----Original Message-----
>> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf
>> Of Shameer Kolothum
>> Sent: 05 August 2021 09:07
>> To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: robin.murphy@arm.com; jon@solid-run.com; Linuxarm
>> <linuxarm@huawei.com>; steven.price@arm.com; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>;
>> Sami.Mujawar@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>
>> Subject: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> Hi,
>>
>> The series adds support to IORT RMR nodes specified in IORT
>> Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
>> memory ranges that are used by endpoints and require a unity
>> mapping in SMMU.
>>
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
>>
>> The only change from v6 is the fix pointed out by Steve to
>> the SMMUv2 SMR bypass install in patch #8.
>>
>> Thanks to the Tested-by tags by Laurentiu with SMMUv2 and
>> Hanjun/Huiqiang with SMMUv3 for v6. I haven't added the tags
>> yet as the series still needs more review[1].
>>
>> Feedback and tests on this series is very much appreciated.
> 
> Since we have an update to IORT spec(E.c) now[1] and includes additional
> attributes/flags for the RMR node, I am planning to respin this series soon.
> 
> Going through the new spec, I have a few queries,
> 
> The memory range attributes can now be described as one of the following,
> 
> 0x00: Device-nGnRnE memory
> 0x01: Device-nGnRE memory
> 0x02: Device-nGRE memory
> 0x03: Device-GRE memory
> 0x04: Normal Inner Non-cacheable Outer Non-cacheable
> 0x05: Normal Inner Write-back Outer Write-back Inner Shareable
> 
> I am not sure how this needs to be captured and used in the kernel. Is there
> any intention of using these fine-grained attributes in the kernel now
> or a generic mapping of the above to the struct iommu_rev_region prot field
> is enough? i.e., something like,
> 
> {
>      ....
>      prot = IOMMU_READ | IOMMU_WRITE;
> 
>      if (rmr_attr == normal_mem) // 0x05
>          prot |= IOMMU_CACHE;
>      
>      if (rmr_attr == device_mem) { //0x00 - 0x03
>          prot |= IOMMU_MMIO;
>          prot |= IOMMU_NOEXEC;
>      }
>      ....
> }

Yup, pretty much that, except don't bother with IOMMU_NOEXEC. We can't 
reliably infer it - e.g. on an AXI-based interconnect AxCACHE and AxPROT 
are entirely orthogonal, so a Device-type read with the "Instruction 
access" hint is perfectly legal - and in the common IORT code we're not 
in a position to second-guess what any given RMR might represent for 
whatever agent is accessing it.

All we can reasonably do here is map the Device types to IOMMU_MMIO and 
Write-back to IOMMU_CACHE, and if anyone ever does want to insist that 
that's not sufficient, then they're welcome to send patches to make the 
IOMMU API more expressive :)

> Similarly for the 'flags' field, the new 'Access Privilege' is intended to set the
> IOMMU_PRIV ?

Yes, exactly!

Cheers,
Robin.

>    
> Please let me know.
> 
> Thanks,
> Shameer
> 
> [1] https://developer.arm.com/documentation/den0049/ec/?lang=en
> 
