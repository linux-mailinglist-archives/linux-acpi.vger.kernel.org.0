Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F403A64A2
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhFNL1J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 07:27:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhFNLZN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 07:25:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0A0D6D;
        Mon, 14 Jun 2021 04:23:10 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8DC3F694;
        Mon, 14 Jun 2021 04:23:08 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        wanghuiqiang@huawei.com
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9e788789-c1c2-10f1-d99c-93cfa6ea3348@arm.com>
Date:   Mon, 14 Jun 2021 12:23:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-24 12:02, Shameer Kolothum wrote:
> Add a helper function that retrieves RMR memory descriptors
> associated with a given IOMMU. This will be used by IOMMU
> drivers to setup necessary mappings.
> 
> Now that we have this, invoke it from the generic helper
> interface.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 50 +++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  4 ++++
>   include/linux/acpi_iort.h |  7 ++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fea1ffaedf3b..01917caf58de 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -12,6 +12,7 @@
>   
>   #include <linux/acpi_iort.h>
>   #include <linux/bitfield.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/list.h>
> @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct device *dev)
>   	return err;
>   }
>   
> +/**
> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU
> + * @iommu: fwnode for the IOMMU
> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_node *iommu;
> +	int rmrs = 0;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu || list_empty(&iort_rmr_list))
> +		return -ENODEV;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +		struct iommu_resv_region *region;
> +		enum iommu_resv_type type;
> +		struct acpi_iort_rmr_desc *rmr_desc;
> +
> +		if (e->smmu != iommu)
> +			continue;
> +
> +		rmr_desc = e->rmr_desc;
> +		if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> +		else
> +			type = IOMMU_RESV_DIRECT;

Wasn't the idea that we can do all this during the initial parsing, i.e. 
we don't even have iort_rmr_entry, we store them as iommu_resv_regions 
and simply kmemdup() or whatever at this point?

Robin.

> +
> +		region = iommu_alloc_resv_region(rmr_desc->base_address,
> +						 rmr_desc->length,
> +						 prot, type);
> +		if (region) {
> +			region->fw_data.rmr.flags = e->flags;
> +			region->fw_data.rmr.sid = e->sid;
> +			list_add_tail(&region->list, head);
> +			rmrs++;
> +		}
> +	}
> +
> +	return (rmrs == 0) ? -ENODEV : 0;
> +}
> +
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -1108,6 +1156,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *input_id)
>   { return NULL; }
> +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ return -ENODEV; }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 229ec65d98be..f893d460cfa4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
>   int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
>   		       struct list_head *list)
>   {
> +	if (!is_of_node(iommu_fwnode))
> +		return iort_iommu_get_rmrs(iommu_fwnode, list);
> +
>   	return -EINVAL;
>   }
>   EXPORT_SYMBOL(iommu_dma_get_rmrs);
> @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
>   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>   			struct list_head *list)
>   {
> +	generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_put_rmrs);
>   
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..e8c45fa59531 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -39,6 +39,8 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list);
>   #else
>   static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   
>   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>   { return PHYS_ADDR_MAX; }
> +
> +static inline
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list)
> +{ return -ENODEV; }
>   #endif
>   
>   #endif /* __ACPI_IORT_H__ */
> 
