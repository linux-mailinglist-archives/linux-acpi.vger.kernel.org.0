Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105E4E467B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Mar 2022 20:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiCVTKV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCVTKU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 15:10:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE68369DA
        for <linux-acpi@vger.kernel.org>; Tue, 22 Mar 2022 12:08:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E61DE152B;
        Tue, 22 Mar 2022 12:08:51 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21053F66F;
        Tue, 22 Mar 2022 12:08:49 -0700 (PDT)
Message-ID: <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
Date:   Tue, 22 Mar 2022 19:08:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
> Add helper functions (iort_iommu_get/put_rmrs()) that
> retrieves/releases RMR memory descriptors associated
> with a given IOMMU. This will be used by IOMMU drivers
> to set up necessary mappings.
> 
> Invoke it from the generic iommu helper functions.

iommu_dma_get_resv_regions() already exists - please extend that rather 
than adding a parallel implementation of the same thing but different. 
IORT should export a single get_resv_regions helper which combines the 
new RMRs with the existing MSI workaround, and a separate "do I need to 
bypass this StreamID" helper for the SMMU drivers to call directly at 
reset time, since the latter isn't really an iommu-dma responsibility.

I'm happy to do that just by shuffling wrappers around for now - we can 
come back and streamline the code properly afterwards - but the sheer 
amount of indirection currently at play here is so hard to follow that 
it's not even all that easy to see how it's crossing abstraction levels 
improperly.

Thanks,
Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  4 +++
>   include/linux/acpi_iort.h | 14 ++++++++++
>   3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 05da9ebff50a..b2c959c72fb2 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1055,6 +1055,57 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
>   	}
>   }
>   
> +/**
> + * iort_iommu_dma_put_rmrs - Free any memory associated with RMRs.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + *
> + * This function go through the provided reserved region list and
> + * free up memory associated with RMR entries and delete them from
> + * the list.
> + */
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *head)
> +{
> +	struct iommu_resv_region *e, *tmp;
> +
> +	/*
> +	 * RMR entries will have mem allocated for fw_data.rmr.sids.
> +	 * Free the mem and delete the node.
> +	 */
> +	list_for_each_entry_safe(e, tmp, head, list) {
> +		if (e->fw_data.rmr.sids) {
> +			kfree(e->fw_data.rmr.sids);
> +			list_del(&e->list);
> +			kfree(e);
> +		}
> +	}
> +}
> +
> +/**
> + *
> + * iort_iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU and dev.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @dev: Device associated with RMR(Optional)
> + * @list: RMR list to be populated
> + *
> + * This function populates the RMR list associated with a given IOMMU and
> + * dev(if provided). If dev is NULL, the function populates all the RMRs
> + * associated with the given IOMMU.
> + */
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *head)
> +{
> +	struct acpi_iort_node *iommu;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu)
> +		return;
> +
> +	iort_find_rmrs(iommu, dev, head);
> +}
> +
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -1287,6 +1338,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
>   int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>   { return -ENODEV; }
> +void iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct device *dev,
> +			 struct list_head *head)
> +{ }
> +void iort_iommu_put_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 65ab01d5128b..b33e4df85de1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -382,12 +382,16 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   void iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
>   			struct list_head *list)
>   {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_get_rmrs(iommu_fwnode, dev, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_get_rmrs);
>   
>   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>   			struct list_head *list)
>   {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_put_rmrs(iommu_fwnode, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_put_rmrs);
>   
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..212f7f178ec3 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,10 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
>   int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *list);
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *list);
>   #else
>   static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -57,6 +61,16 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   
>   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>   { return PHYS_ADDR_MAX; }
> +
> +static inline
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *list)
> +{  }
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *list)
> +{ }
> +
> +{ }
>   #endif
>   
>   #endif /* __ACPI_IORT_H__ */
