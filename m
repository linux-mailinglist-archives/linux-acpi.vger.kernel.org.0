Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A183790A0
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhEJO0o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 10:26:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhEJOXg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 10:23:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00A61688;
        Mon, 10 May 2021 07:22:31 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF79E3F719;
        Mon, 10 May 2021 07:22:29 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
 <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
 <241042b6d1ea45f790e0766c6f5d3542@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7b586e4-f77c-e20b-dcf6-c383d7a7f2f4@arm.com>
Date:   Mon, 10 May 2021 15:22:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <241042b6d1ea45f790e0766c6f5d3542@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-10 10:19, Shameerali Kolothum Thodi wrote:
> Hi Robin,
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 07 May 2021 11:02
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
>> (Hanjun Guo) <guohanjun@huawei.com>; steven.price@arm.com;
>> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com
>> Subject: Re: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
>> associated with a dev
>>
>> On 2021-04-20 09:27, Shameer Kolothum wrote:
>>> Get RMR regions associated with a dev reserved so that there is
>>> a unity mapping for them in SMMU.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29
>> +++++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 14e9c7034c04..8bacedf7bb34 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2531,6 +2531,34 @@ static int arm_smmu_of_xlate(struct device *dev,
>> struct of_phandle_args *args)
>>>    	return iommu_fwspec_add_ids(dev, args->args, 1);
>>>    }
>>>
>>> +static bool arm_smmu_dev_has_rmr(struct arm_smmu_master *master,
>>> +				 struct iommu_rmr *e)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < master->num_sids; i++) {
>>> +		if (e->sid == master->sids[i])
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static void arm_smmu_rmr_get_resv_regions(struct device *dev,
>>> +					  struct list_head *head)
>>> +{
>>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>> +	struct arm_smmu_device *smmu = master->smmu;
>>> +	struct iommu_rmr *rmr;
>>> +
>>> +	list_for_each_entry(rmr, &smmu->rmr_list, list) {
>>> +		if (!arm_smmu_dev_has_rmr(master, rmr))
>>> +			continue;
>>> +
>>> +		iommu_dma_get_rmr_resv_regions(dev, rmr, head);
>>> +	}
>>> +}
>>> +
>>
>> TBH I wouldn't have thought we need a driver-specific hook for this, or
>> is it too painful to correlate fwspec->iommu_fwnode back to the relevant
>> IORT node generically?
> 
>  From a quick look, I think I could get rid of the above with something like below,
> 
> ------8<----
> +static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
> +                                 struct iommu_rmr *e)
> +{
> +       int i;
> +
> +       for (i = 0; i < fwspec->num_ids; i++) {
> +                if (e->sid == fwspec->ids[i])
> +                        return true;
> +        }
> +
> +        return false;
> +}
> +
> +
> +void iommu_dma_get_rmr_resv_regions(struct device *dev, struct list_head *list)
> +{
> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct list_head rmr_list;
> +       struct iommu_rmr *rmr;
> +
> +       INIT_LIST_HEAD(&rmr_list);
> +       if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
> +               return;
>          ...
> +       list_for_each_entry(rmr, &rmr_list, list) {
> +
> +       if (!iommu_dma_dev_has_rmr(fwspec, rmr)
> +           continue;
> +          ...
> +               region = iommu_alloc_resv_region(rmr->base_address,
> +                                                rmr->length, prot,
> +                                                type);
>           ...
> +       }
> +}
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -188,10 +242,11 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>          if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>                  iort_iommu_msi_get_resv_regions(dev, list);
>   
> +       iommu_dma_get_rmr_resv_regions(dev, list);
>   }
> 
> ----8<----
> 
> But looking at the SMMUv2 code, the fwspec->ids is MASK:SID, so I am not
> sure the RMR sid can be compared directly to fwspec->ids above. Right? Or
> is there a better way here?

Ah, but consider how the IDs got there in the first place ;)

A mask will never be set on ACPI systems, since IORT (intentionally) 
only caters for straightforward mappings rather than arbitrary 
complexity, so the assumption of fwspec ID == SID is already baked in by 
virtue of arm_smmu_iort_xlate(). The IORT code is free to assume its own 
behaviour!

Robin.

> 
> Thanks,
> Shameer
> 
> 
>>
>>>    static void arm_smmu_get_resv_regions(struct device *dev,
>>>    				      struct list_head *head)
>>>    {
>>> @@ -2545,6 +2573,7 @@ static void arm_smmu_get_resv_regions(struct
>> device *dev,
>>>    	list_add_tail(&region->list, head);
>>>
>>>    	iommu_dma_get_resv_regions(dev, head);
>>> +	arm_smmu_rmr_get_resv_regions(dev, head);
>>>    }
>>>
>>>    static bool arm_smmu_dev_has_feature(struct device *dev,
>>>
