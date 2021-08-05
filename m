Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB00F3E1873
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhHEPob (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 11:44:31 -0400
Received: from foss.arm.com ([217.140.110.172]:49096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242630AbhHEPoL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Aug 2021 11:44:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6447731B;
        Thu,  5 Aug 2021 08:43:56 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75C6E3F66F;
        Thu,  5 Aug 2021 08:43:54 -0700 (PDT)
Date:   Thu, 5 Aug 2021 16:43:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v7 4/9] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Message-ID: <20210805154349.GA23085@lpieralisi>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805080724.480-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 05, 2021 at 09:07:19AM +0100, Shameer Kolothum wrote:
> Add a helper function (iort_iommu_get_rmrs()) that retrieves RMR
> memory descriptors associated with a given IOMMU. This will be used
> by IOMMU drivers to setup necessary mappings.
> 
> Invoke it from the generic helper iommu_dma_get_rmrs().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  4 ++++
>  include/linux/acpi_iort.h |  7 +++++++
>  3 files changed, 49 insertions(+)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d76ba46ebe67..3c32d62e63b6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -809,6 +809,42 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> +/**
> + * iort_iommu_get_rmrs() - Helper to retrieve RMR info associated with IOMMU
> + * @iommu_fwnode: fwnode for the IOMMU
> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure. Please note, we will keep the already
> + *          allocated RMR reserve regions in case of a kmemdup()
> + *          failure.
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iommu_resv_region *e;
> +	struct acpi_iort_node *iommu;
> +	int rmrs = 0;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu || list_empty(&iort_rmr_list))
> +		return -ENODEV;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		struct iommu_resv_region *region;
> +
> +		if (e->fw_data.rmr.smmu != iommu)
> +			continue;
> +
> +		region = kmemdup(e, sizeof(*region), GFP_KERNEL);
> +		if (region) {
> +			list_add_tail(&region->list, head);
> +			rmrs++;
> +		}
> +	}
> +
> +	return (rmrs == 0) ? -ENODEV : 0;
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -1041,6 +1077,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
> +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2fa2445e9070..1b6e27475279 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
>  int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
>  		       struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		return iort_iommu_get_rmrs(iommu_fwnode, list);
> +
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(iommu_dma_get_rmrs);
> @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
>  void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>  			struct list_head *list)
>  {
> +	generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
>  }
>  EXPORT_SYMBOL(iommu_dma_put_rmrs);
>  
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..d8c030c103f5 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,8 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -57,6 +59,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>  { return PHYS_ADDR_MAX; }
> +
> +static inline
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list)
> +{ return -ENODEV; }
>  #endif
>  
>  #endif /* __ACPI_IORT_H__ */
> -- 
> 2.17.1
> 
