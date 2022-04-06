Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C854F687A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiDFRpT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiDFRol (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 13:44:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 367C92B4DFD
        for <linux-acpi@vger.kernel.org>; Wed,  6 Apr 2022 08:54:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47F712FC;
        Wed,  6 Apr 2022 08:54:11 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.21.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11083F73B;
        Wed,  6 Apr 2022 08:54:09 -0700 (PDT)
Date:   Wed, 6 Apr 2022 16:54:10 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com,
        yangyicong@huawei.com
Subject: Re: [PATCH v9 04/11] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Message-ID: <20220406155410.GE27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404124209.1086-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2022 at 01:42:02PM +0100, Shameer Kolothum wrote:
> Currently IORT provides a helper to retrieve HW MSI reserve regions.
> Change this to a generic helper to retrieve any IORT related reserve
> regions. This will be useful when we add support for RMR nodes in
> subsequent patches.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 23 +++++++++++++++--------
>  drivers/iommu/dma-iommu.c |  2 +-
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> # for ACPI
IORT

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5ebb2be9a19..63acc3c5b275 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -830,16 +830,13 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> -/**
> - * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> - *                                   for HW MSI regions.
> - * @dev: Device from iommu_get_resv_regions()
> - * @head: Reserved region list from iommu_get_resv_regions()
> - *
> +/*
> + * Retrieve platform specific HW MSI reserve regions.
>   * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
>   * associated with the device are the HW MSI reserved regions.
>   */
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +static void
> +iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct acpi_iort_its_group *its;
> @@ -888,6 +885,16 @@ void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  	}
>  }
>  
> +/**
> + * iort_iommu_get_resv_regions - Generic helper to retrieve reserved regions.
> + * @dev: Device from iommu_get_resv_regions()
> + * @head: Reserved region list from iommu_get_resv_regions()
> + */
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	iort_iommu_msi_get_resv_regions(dev, head);
> +}
> +
>  static inline bool iort_iommu_driver_enabled(u8 type)
>  {
>  	switch (type) {
> @@ -1052,7 +1059,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  }
>  
>  #else
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>  { }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..93d76b666888 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -384,7 +384,7 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>  {
>  
>  	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> -		iort_iommu_msi_get_resv_regions(dev, list);
> +		iort_iommu_get_resv_regions(dev, list);
>  
>  }
>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index a8198b83753d..e5d2de9caf7f 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -36,7 +36,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
>  static inline void acpi_iort_init(void) { }
> @@ -52,7 +52,7 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  { return -ENODEV; }
>  static inline
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>  { }
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> -- 
> 2.25.1
> 
