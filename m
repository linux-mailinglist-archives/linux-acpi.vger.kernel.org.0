Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9753A60F8
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhFNKkr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 06:40:47 -0400
Received: from foss.arm.com ([217.140.110.172]:60114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233728AbhFNKhR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06BA1FB;
        Mon, 14 Jun 2021 03:35:13 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064133F694;
        Mon, 14 Jun 2021 03:35:11 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
 <260859e85c854b90b513599f4febfbad@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <00b7b9e2-190a-6c84-9248-8526021e4d97@arm.com>
Date:   Mon, 14 Jun 2021 11:35:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <260859e85c854b90b513599f4febfbad@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-26 17:36, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
>> Sent: 26 May 2021 08:53
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
>> regions
>>
>> Hi Shameer,
>>
>> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
>>> Add a helper function that retrieves RMR memory descriptors
>>> associated with a given IOMMU. This will be used by IOMMU
>>> drivers to setup necessary mappings.
>>>
>>> Now that we have this, invoke it from the generic helper
>>> interface.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>   drivers/acpi/arm64/iort.c | 50
>> +++++++++++++++++++++++++++++++++++++++
>>>   drivers/iommu/dma-iommu.c |  4 ++++
>>>   include/linux/acpi_iort.h |  7 ++++++
>>>   3 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index fea1ffaedf3b..01917caf58de 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -12,6 +12,7 @@
>>>
>>>   #include <linux/acpi_iort.h>
>>>   #include <linux/bitfield.h>
>>> +#include <linux/dma-iommu.h>
>>>   #include <linux/iommu.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/list.h>
>>> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
>> device *dev)
>>>   	return err;
>>>   }
>>>
>>> +/**
>>> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
>> IOMMU
>>> + * @iommu: fwnode for the IOMMU
>>> + * @head: RMR list head to be populated
>>> + *
>>> + * Returns: 0 on success, <0 failure
>>> + */
>>> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
>>> +			struct list_head *head)
>>> +{
>>> +	struct iort_rmr_entry *e;
>>> +	struct acpi_iort_node *iommu;
>>> +	int rmrs = 0;
>>> +
>>> +	iommu = iort_get_iort_node(iommu_fwnode);
>>> +	if (!iommu || list_empty(&iort_rmr_list))
>>> +		return -ENODEV;
>>> +
>>> +	list_for_each_entry(e, &iort_rmr_list, list) {
>>> +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
>> IOMMU_MMIO;
>>
>> We have a case with an IP block that needs EXEC rights on its reserved
>> memory, so could you please drop the IOMMU_NOEXEC flag?
> 
> Ok, I think I can drop that one if there are no other concerns. I was not quite
> sure what to include here in the first place as the IORT spec is not giving any
> further details about the RMR regions(May be the flags field can be extended to
> describe these details).

Right, it's reserved for the device to use *somehow* - that's all we 
know, so it's not our place to try and enforce any restrictive 
permissions. All it could possibly achieve is the ability to log an 
error to say "a thing did an unknown thing in a way we didn't expect!", 
and there's hardly much value in that.

Robin.
