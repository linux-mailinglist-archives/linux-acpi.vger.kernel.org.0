Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A434F66DA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiDFRRo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 13:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiDFRRY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 13:17:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C4BA40E69F
        for <linux-acpi@vger.kernel.org>; Wed,  6 Apr 2022 08:13:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F2F12FC;
        Wed,  6 Apr 2022 08:13:07 -0700 (PDT)
Received: from lpieralisi (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1543F73B;
        Wed,  6 Apr 2022 08:13:04 -0700 (PDT)
Date:   Wed, 6 Apr 2022 16:12:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com,
        yangyicong@huawei.com
Subject: Re: [PATCH v9 03/11] ACPI/IORT: Make
 iort_iommu_msi_get_resv_regions() return void
Message-ID: <20220406151250.GA27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2022 at 01:42:01PM +0100, Shameer Kolothum wrote:
> At present iort_iommu_msi_get_resv_regions() returns the number of
> MSI reserved regions on success and there are no users for this.
> The reserved region list will get populated anyway for platforms
> that require the HW MSI region reservation. Hence, change the
> function to return void instead.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 26 ++++++++++----------------
>  include/linux/acpi_iort.h |  6 +++---
>  2 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fd06cf43ba31..c5ebb2be9a19 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -832,25 +832,23 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> + *                                   for HW MSI regions.

Very minor but is this a spurious change ?

>   * @dev: Device from iommu_get_resv_regions()
>   * @head: Reserved region list from iommu_get_resv_regions()
>   *
> - * Returns: Number of msi reserved regions on success (0 if platform
> - *          doesn't require the reservation or no associated msi regions),
> - *          appropriate error value otherwise. The ITS interrupt translation
> - *          spaces (ITS_base + SZ_64K, SZ_64K) associated with the device
> - *          are the msi reserved regions.
> + * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
> + * associated with the device are the HW MSI reserved regions.
>   */
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct acpi_iort_its_group *its;
>  	struct acpi_iort_node *iommu_node, *its_node = NULL;
> -	int i, resv = 0;
> +	int i;
>  
>  	iommu_node = iort_get_msi_resv_iommu(dev);
>  	if (!iommu_node)
> -		return 0;
> +		return;
>  
>  	/*
>  	 * Current logic to reserve ITS regions relies on HW topologies
> @@ -870,7 +868,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  	}
>  
>  	if (!its_node)
> -		return 0;
> +		return;
>  
>  	/* Move to ITS specific data */
>  	its = (struct acpi_iort_its_group *)its_node->node_data;
> @@ -884,14 +882,10 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  
>  			region = iommu_alloc_resv_region(base + SZ_64K, SZ_64K,
>  							 prot, IOMMU_RESV_MSI);
> -			if (region) {
> +			if (region)
>  				list_add_tail(&region->list, head);
> -				resv++;
> -			}
>  		}
>  	}
> -
> -	return (resv == its->its_count) ? resv : -ENODEV;
>  }
>  
>  static inline bool iort_iommu_driver_enabled(u8 type)
> @@ -1058,8 +1052,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  }
>  
>  #else
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> -{ return 0; }
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +{ }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
>  #endif
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..a8198b83753d 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -36,7 +36,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
>  static inline void acpi_iort_init(void) { }
> @@ -52,8 +52,8 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  { return -ENODEV; }
>  static inline
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> -{ return 0; }
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +{ }
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>  { return PHYS_ADDR_MAX; }
> -- 
> 2.25.1
> 
