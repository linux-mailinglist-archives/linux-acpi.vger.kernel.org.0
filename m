Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394E2A96AA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFNGS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 08:06:18 -0500
Received: from foss.arm.com ([217.140.110.172]:38048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgKFNGR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 08:06:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E041474;
        Fri,  6 Nov 2020 05:06:16 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B143F718;
        Fri,  6 Nov 2020 05:06:14 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
 <327e6475-eb48-33a1-ef38-fae9df3bf0cb@arm.com>
 <66c52ba92d274adb818d03d2e6813f0a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0123797-4b49-8256-1080-36b9a6f7eee6@arm.com>
Date:   Fri, 6 Nov 2020 13:06:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <66c52ba92d274adb818d03d2e6813f0a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-11-06 08:30, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 05 November 2020 18:04
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org; devel@acpica.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
>> (Hanjun Guo) <guohanjun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>
>> Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
>> helper
>>
>> On 2020-10-27 11:26, Shameer Kolothum wrote:
>>> Add a helper function that retrieves RMR memory descriptors
>>> associated with a given endpoint dev. These memory regions
>>> should have a unity mapping in the SMMU. So reserve them as
>>> IOMMU_RESV_DIRECT.
>>
>> As a general observation, we also need a way into this that isn't from
>> the perspective of endpoint devices. With SMMUv3 we need to know all the
>> active stream IDs relevant to a given SMMU instance at probe time, so
>> that we can set up some kind of valid stream table entries *before*
>> enabling the SMMU in the reset routine.
> 
> So I guess, the idea is to provide an interface here to retrieve those active
> stream Ids? The problem is, at present(AFAICS), RMR doesn’t have any
> means to specify such devices.

I'm thinking we need to check if any RMRs exist in the IORT, if so find 
the devices that map to them, then resolve those devices' ID mappings. 
In terms of the interface, maybe the better option is to do something 
closer to what intel-iommu does and handle *all* the processing up-front 
- let the IOMMU driver just call into the firmware code once to retrieve 
a complete list of all the relevant abstracted RMR (or DT equivalent) 
information, so it can then resolve both its own early initialisation 
and the later per-device setup without calling back into firmware code 
again.

>   Otherwise we're just going to
>> kill ongoing traffic (e.g. EFI GOP) with C_BAD_STE long before we ever
>> start adding devices and worrying about reserved regions for them.
>> Similarly for the initial SMR/S2CR state on SMMUv2 with disable_bypass.
> 
> Ok. I see the discussion here,
> https://lore.kernel.org/linux-iommu/484b9e90-7395-6161-577c-4d3f3716997e@arm.com/
> 
>  From what I gather, the plan is to setup a default IDENTITY_DOMAIN for
> devices that have live stream going on during boot/SMMU probe time.

Well, whether we use bypass or a temporary translation context for the 
period before we even get to default domains... that's a discussion that 
can wait until we have the ability to set up the STEs at all ;)

Robin.

>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>    drivers/acpi/arm64/iort.c | 56
>> +++++++++++++++++++++++++++++++++++++++
>>>    include/linux/acpi_iort.h |  4 +++
>>>    2 files changed, 60 insertions(+)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index b32cd53cca08..c0700149e60b 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -842,6 +842,60 @@ static inline int iort_add_device_replay(struct
>> device *dev)
>>>    	return err;
>>>    }
>>>
>>> +static bool iort_dev_has_rmr(struct device *dev, struct iort_rmr_entry *e)
>>> +{
>>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>> +	struct acpi_iort_node *iommu;
>>> +	struct iort_rmr_id *rmr_ids = e->rmr_ids;
>>> +	int i, j;
>>> +
>>> +	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
>>> +
>>> +	for (i = 0; i < e->rmr_ids_num; i++, rmr_ids++) {
>>> +		for (j = 0; j < fwspec->num_ids; j++) {
>>> +			if (rmr_ids->sid == fwspec->ids[j] &&
>>> +			    rmr_ids->smmu == iommu)
>>> +				return true;
>>> +		}
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/**
>>> + * iort_dev_rmr_get_resv_regions - RMR Reserved region driver helper
>>> + * @dev: Device from iommu_get_resv_regions()
>>> + * @head: Reserved region list from iommu_get_resv_regions()
>>> + *
>>> + * Returns: 0 on success, <0 failure
>>> + */
>>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head
>> *head)
>>> +{
>>> +	struct iort_rmr_entry *e;
>>> +
>>> +	list_for_each_entry(e, &iort_rmr_list, list) {
>>> +		struct iommu_resv_region *region;
>>> +		struct acpi_iort_rmr_desc *rmr;
>>> +		int prot = IOMMU_READ | IOMMU_WRITE |
>>> +			   IOMMU_NOEXEC | IOMMU_MMIO;
>>> +
>>> +		if (!iort_dev_has_rmr(dev, e))
>>> +			continue;
>>> +
>>> +		rmr = e->rmr_desc;
>>> +		region = iommu_alloc_resv_region(rmr->base_address,
>>> +						 rmr->length, prot,
>>> +						 IOMMU_RESV_DIRECT);
>>> +		if (!region) {
>>> +			dev_err(dev, "Out of memory allocating RMR regions\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +		list_add_tail(&region->list, head);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    /**
>>>     * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>>>     * @dev: Device from iommu_get_resv_regions()
>>> @@ -1112,6 +1166,8 @@ int iort_iommu_msi_get_resv_regions(struct
>> device *dev, struct list_head *head)
>>>    const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>>>    						const u32 *input_id)
>>>    { return NULL; }
>>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head
>> *head)
>>> +{ return 0; }
>>>    #endif
>>>
>>>    static int nc_dma_get_range(struct device *dev, u64 *size)
>>> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
>>> index 20a32120bb88..6dd89faf340c 100644
>>> --- a/include/linux/acpi_iort.h
>>> +++ b/include/linux/acpi_iort.h
>>> @@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64
>> *dma_addr, u64 *size);
>>>    const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>>>    						const u32 *id_in);
>>>    int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
>> *head);
>>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head
>> *head);
>>>    #else
>>>    static inline void acpi_iort_init(void) { }
>>>    static inline u32 iort_msi_map_id(struct device *dev, u32 id)
>>> @@ -55,6 +56,9 @@ static inline const struct iommu_ops
>> *iort_iommu_configure_id(
>>>    static inline
>>>    int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
>> *head)
>>>    { return 0; }
>>> +static inline
>>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head
>> *head)
>>> +{ return 0; }
>>>    #endif
>>>
>>>    #endif /* __ACPI_IORT_H__ */
>>>
