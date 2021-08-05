Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F213E1909
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbhHEQDx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 12:03:53 -0400
Received: from foss.arm.com ([217.140.110.172]:49718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241250AbhHEQDi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Aug 2021 12:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354FD31B;
        Thu,  5 Aug 2021 09:03:24 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481C93F66F;
        Thu,  5 Aug 2021 09:03:22 -0700 (PDT)
Date:   Thu, 5 Aug 2021 17:03:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Message-ID: <20210805160319.GB23085@lpieralisi>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:

[...]

> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> +{
> +	struct acpi_iort_node *smmu;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	u32 map_count = iort_node->mapping_count;
> +	u32 sid;
> +	int i;
> +
> +	if (!iort_node->mapping_offset || map_count != 1) {
> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	/* Retrieve associated smmu and stream id */
> +	smmu = iort_node_get_id(iort_node, &sid, 0);
> +	if (!smmu) {
> +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	/* Retrieve RMR data */
> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> +				rmr->rmr_offset);
> +
> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		struct iommu_resv_region *region;
> +		enum iommu_resv_type type;
> +		int prot = IOMMU_READ | IOMMU_WRITE;
> +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> +
> +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> +			/* PAGE align base addr and size */
> +			addr &= PAGE_MASK;
> +			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> +
> +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> +			       rmr_desc->base_address,
> +			       rmr_desc->base_address + rmr_desc->length - 1,
> +			       addr, addr + size - 1);
> +		}
> +		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> +			/*
> +			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> +			 * normally used for allocated system memory that is
> +			 * then used for device specific reserved regions.
> +			 */
> +			prot |= IOMMU_CACHE;
> +		} else {
> +			type = IOMMU_RESV_DIRECT;
> +			/*
> +			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> +			 * for device memory like MSI doorbell.
> +			 */
> +			prot |= IOMMU_MMIO;
> +		}

On the prot value assignment based on the remapping flag, I'd like to
hear Robin/Joerg's opinion, I'd avoid being in a situation where
"normally" this would work but then we have to quirk it.

Is this a valid assumption _always_ ?

Thanks,
Lorenzo

> +
> +		region = iommu_alloc_resv_region(addr, size, prot, type);
> +		if (region) {
> +			region->fw_data.rmr.flags = rmr->flags;
> +			region->fw_data.rmr.sid = sid;
> +			region->fw_data.rmr.smmu = smmu;
> +			list_add_tail(&region->list, &iort_rmr_list);
> +		}
> +	}
> +}
> +
> +static void __init iort_parse_rmr(void)
> +{
> +	struct acpi_iort_node *iort_node, *iort_end;
> +	struct acpi_table_iort *iort;
> +	int i;
> +
> +	if (iort_table->revision < 3)
> +		return;
> +
> +	iort = (struct acpi_table_iort *)iort_table;
> +
> +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				 iort->node_offset);
> +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				iort_table->length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> +			       "IORT node pointer overflows, bad table!\n"))
> +			return;
> +
> +		if (iort_node->type == ACPI_IORT_NODE_RMR)
> +			iort_node_get_rmr_info(iort_node);
> +
> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +					 iort_node->length);
> +	}
> +}
>  
>  static void __init iort_init_platform_devices(void)
>  {
> @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
>  	}
>  
>  	iort_init_platform_devices();
> +	iort_parse_rmr();
>  }
>  
>  #ifdef CONFIG_ZONE_DMA
> -- 
> 2.17.1
> 
