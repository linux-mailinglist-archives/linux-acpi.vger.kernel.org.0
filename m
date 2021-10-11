Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBC428E88
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhJKNtW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 09:49:22 -0400
Received: from foss.arm.com ([217.140.110.172]:55414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234566AbhJKNtW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 09:49:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7024101E;
        Mon, 11 Oct 2021 06:47:21 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9E93F694;
        Mon, 11 Oct 2021 06:47:19 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Jon Nettleton <jon@solid-run.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
 <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
 <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
 <9df40b8f09f6488382f25f419519a2fa@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e3c6befe-7df0-3dc8-3f5a-333c749daf89@arm.com>
Date:   Mon, 11 Oct 2021 14:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9df40b8f09f6488382f25f419519a2fa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-10-11 06:47, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Jon Nettleton [mailto:jon@solid-run.com]
>> Sent: 09 October 2021 07:58
>> To: Robin Murphy <robin.murphy@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
>> List <linux-acpi@vger.kernel.org>; Linux IOMMU
>> <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
>> Steven Price <steven.price@arm.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>; Sami
>> Mujawar <Sami.Mujawar@arm.com>; Will Deacon <will@kernel.org>;
>> wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
>> iommu_resv_region
>>
>> On Fri, Oct 8, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com>
>> wrote:
>>>
>>> On 2021-08-05 09:07, Shameer Kolothum wrote:
>>>> A union is introduced to struct iommu_resv_region to hold any
>>>> firmware specific data. This is in preparation to add support for
>>>> IORT RMR reserve regions and the union now holds the RMR specific
>>>> information.
>>>>
>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi@huawei.com>
>>>> ---
>>>>    include/linux/iommu.h | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
>>>> 32d448050bf7..bd0e4641c569 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -114,6 +114,13 @@ enum iommu_resv_type {
>>>>        IOMMU_RESV_SW_MSI,
>>>>    };
>>>>
>>>> +struct iommu_iort_rmr_data {
>>>> +#define IOMMU_RMR_REMAP_PERMITTED    (1 << 0)
>>>> +     u32 flags;
>>>> +     u32 sid;        /* Stream Id associated with RMR entry */
>>>> +     void *smmu;     /* Associated IORT SMMU node pointer */
>>>> +};
>>>
>>> Do we really need to duplicate all this data? AFAICS we could just
>>> save the acpi_iort_rmr pointer in the iommu_resv_region (with a
>>> forward declaration here if necessary) and defer parsing its actual
>>> mappings until the point where we can directly consume the results.
>>
>>  From earlier discussions on this patchset, the original goal was also for
>> device-tree mechanisms to be able to hook into this code to support similar
>> RMR's and SMMU initialization, just not through the ACPI / IORT path.
> 
> Yes. IIRC, there were some earlier attempts to have DT support for reserved regions
> and there was a suggestion to provide generic interfaces so that when DT solution
> comes up it is easier to add the support.

OK, but in that case why is every single part of it IORT-specific in 
either name, description or function?

Regardless, s/acpi_iort_rmr/original firmware descriptor of whatever 
variety/ and my comment still stands. If a firmware-specific structure 
is still going to exist to begin with, then what do we gain from 
interpreting details earlier than needed and wasting memory storing 
copies of them? This isn't something we're looking up hundreds of times 
per second and need to cache in some more efficient format.

Furthermore, it seems unlikely that the eventual DT solution would end 
up being semantically identical to IORT RMRs, so there's every 
possibility that the One True Abstract Structure would need changing to 
work for another firmware implementation anyway. Heck, it might not even 
fit future IORT if it becomes permissible for multiple StreamIDs to 
share a single RMR descriptor.

Thanks,
Robin.
