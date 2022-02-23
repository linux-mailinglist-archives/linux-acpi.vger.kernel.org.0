Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275F4C1A9C
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Feb 2022 19:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiBWSG2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Feb 2022 13:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243566AbiBWSG1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Feb 2022 13:06:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A9A44779
        for <linux-acpi@vger.kernel.org>; Wed, 23 Feb 2022 10:05:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC370D6E;
        Wed, 23 Feb 2022 10:05:58 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10623F70D;
        Wed, 23 Feb 2022 10:05:56 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:05:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Message-ID: <20220223180549.GA29800@lpieralisi>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 21, 2022 at 03:43:38PM +0000, Shameer Kolothum wrote:
> Add helper functions (iort_iommu_get/put_rmrs()) that
> retrieves/releases RMR memory descriptors associated
> with a given IOMMU. This will be used by IOMMU drivers
> to set up necessary mappings.
> 
> Invoke it from the generic iommu helper functions.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  4 +++
>  include/linux/acpi_iort.h | 14 ++++++++++
>  3 files changed, 74 insertions(+)

I would squash this patch with the previous one - at least the
iommu_dma_get/put_rmrs() are actually used in the patch that is
adding them.

Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 05da9ebff50a..b2c959c72fb2 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1055,6 +1055,57 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
>  	}
>  }
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
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -1287,6 +1338,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
> +void iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct device *dev,
> +			 struct list_head *head)
> +{ }
> +void iort_iommu_put_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 65ab01d5128b..b33e4df85de1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -382,12 +382,16 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  void iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
>  			struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_get_rmrs(iommu_fwnode, dev, list);
>  }
>  EXPORT_SYMBOL(iommu_dma_get_rmrs);
>  
>  void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>  			struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_put_rmrs(iommu_fwnode, list);
>  }
>  EXPORT_SYMBOL(iommu_dma_put_rmrs);
>  
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..212f7f178ec3 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,10 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *list);
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *list);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -57,6 +61,16 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>  { return PHYS_ADDR_MAX; }
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
>  #endif
>  
>  #endif /* __ACPI_IORT_H__ */
> -- 
> 2.25.1
> 
