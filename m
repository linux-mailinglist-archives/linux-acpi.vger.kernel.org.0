Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0C4F67C5
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDFRmE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiDFRlo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 13:41:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4F71E1F7B
        for <linux-acpi@vger.kernel.org>; Wed,  6 Apr 2022 08:51:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BC012FC;
        Wed,  6 Apr 2022 08:51:14 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.21.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8973F73B;
        Wed,  6 Apr 2022 08:51:12 -0700 (PDT)
Date:   Wed, 6 Apr 2022 16:51:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com,
        yangyicong@huawei.com
Subject: Re: [PATCH v9 07/11] ACPI/IORT: Add a helper to retrieve RMR info
 directly
Message-ID: <20220406155113.GC27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-8-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2022 at 01:42:05PM +0100, Shameer Kolothum wrote:
> This will provide a way for SMMU drivers to retrieve StreamIDs
> associated with IORT RMR nodes and use that to set bypass settings
> for those IDs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 29 +++++++++++++++++++++++++++++
>  include/linux/acpi_iort.h |  8 ++++++++
>  2 files changed, 37 insertions(+)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 1147387cfddb..fb2b0163c27d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1402,6 +1402,35 @@ int iort_dma_get_ranges(struct device *dev, u64 *size)
>  		return nc_dma_get_range(dev, size);
>  }
>  
> +/**
> + * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
> + *                     associated StreamIDs information.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + */
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head)
> +{
> +	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
> +}
> +EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
> +
> +/**
> + * iort_put_rmr_sids - Free all the memory allocated for RMR reserved regions.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + */
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	iort_iommu_put_resv_regions(NULL, head);
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
> +
>  static void __init acpi_iort_register_irq(int hwirq, const char *name,
>  					  int trigger,
>  					  struct resource *res)
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index eb3c28853110..774b8bc16573 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -33,6 +33,10 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>  					  enum irq_domain_bus_token bus_token);
>  void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head);
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> @@ -47,6 +51,10 @@ static inline struct irq_domain *iort_get_device_domain(
>  	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
>  { return NULL; }
>  static inline void acpi_configure_pmsi_domain(struct device *dev) { }
> +static inline
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
> +static inline
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
>  /* IOMMU interface */
>  static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  { return -ENODEV; }
> -- 
> 2.25.1
> 
