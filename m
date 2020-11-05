Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA432A85A6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgKESEI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 13:04:08 -0500
Received: from foss.arm.com ([217.140.110.172]:39174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbgKESEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 13:04:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC0014BF;
        Thu,  5 Nov 2020 10:04:06 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C558F3F719;
        Thu,  5 Nov 2020 10:03:59 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        jonathan.cameron@huawei.com
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <327e6475-eb48-33a1-ef38-fae9df3bf0cb@arm.com>
Date:   Thu, 5 Nov 2020 18:03:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-10-27 11:26, Shameer Kolothum wrote:
> Add a helper function that retrieves RMR memory descriptors
> associated with a given endpoint dev. These memory regions
> should have a unity mapping in the SMMU. So reserve them as
> IOMMU_RESV_DIRECT.

As a general observation, we also need a way into this that isn't from 
the perspective of endpoint devices. With SMMUv3 we need to know all the 
active stream IDs relevant to a given SMMU instance at probe time, so 
that we can set up some kind of valid stream table entries *before* 
enabling the SMMU in the reset routine. Otherwise we're just going to 
kill ongoing traffic (e.g. EFI GOP) with C_BAD_STE long before we ever 
start adding devices and worrying about reserved regions for them. 
Similarly for the initial SMR/S2CR state on SMMUv2 with disable_bypass.

Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_iort.h |  4 +++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index b32cd53cca08..c0700149e60b 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -842,6 +842,60 @@ static inline int iort_add_device_replay(struct device *dev)
>   	return err;
>   }
>   
> +static bool iort_dev_has_rmr(struct device *dev, struct iort_rmr_entry *e)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct acpi_iort_node *iommu;
> +	struct iort_rmr_id *rmr_ids = e->rmr_ids;
> +	int i, j;
> +
> +	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
> +
> +	for (i = 0; i < e->rmr_ids_num; i++, rmr_ids++) {
> +		for (j = 0; j < fwspec->num_ids; j++) {
> +			if (rmr_ids->sid == fwspec->ids[j] &&
> +			    rmr_ids->smmu == iommu)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * iort_dev_rmr_get_resv_regions - RMR Reserved region driver helper
> + * @dev: Device from iommu_get_resv_regions()
> + * @head: Reserved region list from iommu_get_resv_regions()
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	struct iort_rmr_entry *e;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		struct iommu_resv_region *region;
> +		struct acpi_iort_rmr_desc *rmr;
> +		int prot = IOMMU_READ | IOMMU_WRITE |
> +			   IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +		if (!iort_dev_has_rmr(dev, e))
> +			continue;
> +
> +		rmr = e->rmr_desc;
> +		region = iommu_alloc_resv_region(rmr->base_address,
> +						 rmr->length, prot,
> +						 IOMMU_RESV_DIRECT);
> +		if (!region) {
> +			dev_err(dev, "Out of memory allocating RMR regions\n");
> +			return -ENOMEM;
> +		}
> +		list_add_tail(&region->list, head);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -1112,6 +1166,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *input_id)
>   { return NULL; }
> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *head)
> +{ return 0; }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 20a32120bb88..6dd89faf340c 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *head);
>   #else
>   static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -55,6 +56,9 @@ static inline const struct iommu_ops *iort_iommu_configure_id(
>   static inline
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> +static inline
> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *head)
> +{ return 0; }
>   #endif
>   
>   #endif /* __ACPI_IORT_H__ */
> 
