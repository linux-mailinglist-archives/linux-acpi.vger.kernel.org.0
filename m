Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C08399FAE
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCLWq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 07:22:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFCLWq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Jun 2021 07:22:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE681063;
        Thu,  3 Jun 2021 04:21:01 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585D83F774;
        Thu,  3 Jun 2021 04:20:59 -0700 (PDT)
Date:   Thu, 3 Jun 2021 12:20:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v4 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Message-ID: <20210603112054.GA14606@lpieralisi>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
 <20210513134550.2117-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513134550.2117-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 02:45:45PM +0100, Shameer Kolothum wrote:
> Add a helper function that retrieves RMR memory descriptors
> associated with a given IOMMU. This will be used by IOMMU
> drivers to setup necessary mappings.
> 
> Now that we have this, invoke it from the generic helper

"Add a helper function (iort_iommu_get_rmrs()) that retrieves RMR memory
descriptors associated with a given IOMMU. This will be used by IOMMU
drivers to setup necessary mappings.

Invoke it from the generic helper iommu_dma_get_rmrs()."

> interface.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 40 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  3 +++
>  include/linux/acpi_iort.h |  7 +++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fea1ffaedf3b..6ca88c38987a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/acpi_iort.h>
>  #include <linux/bitfield.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -837,6 +838,43 @@ static inline int iort_add_device_replay(struct device *dev)
>  	return err;
>  }
>  
> +/**
> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU

iort_iommu_get_rmrs()

please check other functions comments in the patchset.

> + * @iommu: fwnode for the IOMMU

Does not match the parameter.

> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_node *iommu;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu)
> +		return -EINVAL;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		struct acpi_iort_rmr_desc *rmr_desc;
> +		struct iommu_rmr *rmr;
> +
> +		if (e->smmu != iommu)
> +			continue;
> +
> +		rmr_desc = e->rmr_desc;
> +		rmr = iommu_dma_alloc_rmr(rmr_desc->base_address,
> +					  rmr_desc->length, e->sid,
> +					  e->flags);
> +		if (!rmr)
> +			return -ENOMEM;

I suppose it is OK to leave the already allocated regions allocated
on -ENOMEM.

Probably worth clarifying it in the function comment.

Lorenzo

> +
> +		list_add_tail(&rmr->list, head);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -1108,6 +1146,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *input_id)
>  { return NULL; }
> +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 674bd8815159..2d9caf548a32 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -203,6 +203,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>  int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
>  		       struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		return iort_iommu_get_rmrs(iommu_fwnode, list);
> +
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(iommu_dma_get_rmrs);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..e8c45fa59531 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -39,6 +39,8 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
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
