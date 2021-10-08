Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE3426B7A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJHNMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 09:12:02 -0400
Received: from foss.arm.com ([217.140.110.172]:51206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhJHNMB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Oct 2021 09:12:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D8A6D;
        Fri,  8 Oct 2021 06:10:06 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1BFA3F66F;
        Fri,  8 Oct 2021 06:10:03 -0700 (PDT)
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
Date:   Fri, 8 Oct 2021 14:09:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-08-05 09:07, Shameer Kolothum wrote:
> Get ACPI IORT RMR regions associated with a dev reserved
> so that there is a unity mapping for them in SMMU.

This feels like most of it belongs in the IORT code rather than 
iommu-dma (which should save the temporary list copy as well).

Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1b6e27475279..c1ae0c3d4b33 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>   }
>   EXPORT_SYMBOL(iommu_dma_put_rmrs);
>   
> +static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
> +				  struct iommu_resv_region *e)
> +{
> +	int i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		if (e->fw_data.rmr.sid == fwspec->ids[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void iommu_dma_get_rmr_resv_regions(struct device *dev,
> +					   struct list_head *list)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct list_head rmr_list;
> +	struct iommu_resv_region *rmr, *tmp;
> +
> +	INIT_LIST_HEAD(&rmr_list);
> +	if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
> +		return;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +
> +		if (!host->preserve_config)
> +			return;
> +	}
> +
> +	list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
> +		if (!iommu_dma_dev_has_rmr(fwspec, rmr))
> +			continue;
> +
> +		/* Remove from iommu RMR list and add to dev resv_regions */
> +		list_del_init(&rmr->list);
> +		list_add_tail(&rmr->list, list);
> +	}
> +
> +	iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
> +}
> +
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
>    * @list: Reserved region list from iommu_get_resv_regions()
>    *
>    * IOMMU drivers can use this to implement their .get_resv_regions callback
> - * for general non-IOMMU-specific reservations. Currently, this covers GICv3
> - * ITS region reservation on ACPI based ARM platforms that may require HW MSI
> - * reservation.
> + * for general non-IOMMU-specific reservations. Currently this covers,
> + *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
> + *   require HW MSI reservation.
> + *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
>    */
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   
> -	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
>   		iort_iommu_msi_get_resv_regions(dev, list);
> -
> +		iommu_dma_get_rmr_resv_regions(dev, list);
> +	}
>   }
>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   
> 
