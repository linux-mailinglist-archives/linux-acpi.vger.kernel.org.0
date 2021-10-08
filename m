Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCC426B68
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhJHNFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 09:05:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhJHNFs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Oct 2021 09:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF986D;
        Fri,  8 Oct 2021 06:03:50 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575023F66F;
        Fri,  8 Oct 2021 06:03:48 -0700 (PDT)
Subject: Re: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
Date:   Fri, 8 Oct 2021 14:03:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-08-05 09:07, Shameer Kolothum wrote:
> Reserved Memory Regions(RMR) associated with an IOMMU can be
> described through ACPI IORT tables in systems with devices
> that require a unity mapping or bypass for those
> regions.
> 
> Introduce a generic interface so that IOMMU drivers can retrieve
> and set up necessary mappings.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++++++++
>   include/linux/dma-iommu.h | 13 +++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..2fa2445e9070 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -174,6 +174,35 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   }
>   EXPORT_SYMBOL(iommu_put_dma_cookie);
>   
> +/**
> + *
> + * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @list: RMR list to be populated
> + *
> + */
> +int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *list)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(iommu_dma_get_rmrs);
> +
> +/**
> + *
> + * iommu_dma_put_rmrs - Release Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @list: RMR list
> + *
> + */
> +void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list)
> +{
> +}
> +EXPORT_SYMBOL(iommu_dma_put_rmrs);

Unless there's something special you expect to need to do here, can we 
just uphold the prevailing expectation that resv_regions are kmalloc()ed 
and can be freed directly by the generic function?

> +
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 758ca4694257..3b7b2d096c6e 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -42,12 +42,16 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>   
>   extern bool iommu_dma_forcedac;
>   
> +int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
> +void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list);
> +
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
>   struct msi_desc;
>   struct msi_msg;
>   struct device;
> +struct fwnode_handle;
>   
>   static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>   				       u64 dma_limit)
> @@ -83,5 +87,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> +static int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list)
> +{
> +	return -ENODEV;

Hmm, if this needs to be stubbed at all then returning an error seems 
like probably the wrong thing to do. I guess it's for 32-bit builds of 
arm-smmu? It is not an error if the firmware describes no RMRs because 
there are no RMRs, so it hardly deserves to be an error if there are no 
RMRs simply because the firmware isn't ACPI.

Robin.

> +}
> +
> +static void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list)
> +{
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> 
