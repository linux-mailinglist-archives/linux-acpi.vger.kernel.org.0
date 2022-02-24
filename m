Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80914C2901
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 11:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiBXKOP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 05:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiBXKOL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 05:14:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AC0C1A2758
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 02:13:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02E93ED1;
        Thu, 24 Feb 2022 02:13:41 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E56B3F70D;
        Thu, 24 Feb 2022 02:13:39 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:13:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR
 nodes
Message-ID: <20220224101333.GA3178@lpieralisi>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 21, 2022 at 03:43:36PM +0000, Shameer Kolothum wrote:
> The helper functions here parse through the IORT RMR nodes and
> populate a reserved region list  corresponding to a given iommu
> and device(optional). These also go through the ID mappings of
> the RMR node and retrieves all the SIDs associated with a RMR
> descriptor.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 225 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)

I have very minor comments - I would ask Robin to ack the updated
flags management.

Functions should be introduced where they are used, this patch
is not bisectable:

drivers/acpi/arm64/iort.c:1028:13: warning: ‘iort_find_rmrs’ defined but not used [-Wunused-function]
 1028 | static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 0730c4dbb700..05da9ebff50a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -830,6 +830,231 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		u64 end, start = desc[i].base_address, length = desc[i].length;
> +
> +		end = start + length - 1;

We could probably check for length != 0, the kernel is not there to
validate firmware but this would not hurt either.

> +
> +		/* Check for address overlap */
> +		for (j = i + 1; j < count; j++) {
> +			u64 e_start = desc[j].base_address;
> +			u64 e_end = e_start + desc[j].length - 1;
> +
> +			if (start <= e_end && end >= e_start)
> +				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
> +				       start, end);
> +		}
> +	}
> +}
> +
> +/*
> + * Please note, we will keep the already allocated RMR reserve
> + * regions in case of a memory allocation failure.
> + */
> +static void iort_rmr_get_resv_regions(struct acpi_iort_node *node,
> +				      struct acpi_iort_node *smmu,
> +				      u32 *sids, u32 num_sids,
> +				      struct list_head *head)
> +{
> +	struct acpi_iort_rmr *rmr = (struct acpi_iort_rmr *)node->node_data;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	int i;
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
> +				rmr->rmr_offset);
> +
> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		struct iommu_resv_region *region;
> +		enum iommu_resv_type type;
> +		u32  *sids_copy;
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
> +
> +		if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> +		else
> +			type = IOMMU_RESV_DIRECT;
> +
> +		if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
> +			prot |= IOMMU_PRIV;
> +
> +		/* Attributes 0x00 - 0x03 represents device memory */
> +		if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
> +				ACPI_IORT_RMR_ATTR_DEVICE_GRE)
> +			prot |= IOMMU_MMIO;
> +		else if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) ==
> +				ACPI_IORT_RMR_ATTR_NORMAL)
> +			prot |= IOMMU_CACHE;
> +
> +		/* Create a copy of sids array to associate with this resv region */
> +		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
> +		if (!sids_copy)
> +			return;
> +
> +		region = iommu_alloc_resv_region(addr, size, prot, type);
> +		if (!region) {
> +			kfree(sids_copy);
> +			return;
> +		}
> +
> +		region->fw_data.rmr.sids = sids_copy;
> +		region->fw_data.rmr.num_sids = num_sids;
> +		list_add_tail(&region->list, head);
> +	}
> +}
> +
> +static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
> +				u32 new_count)
> +{
> +	u32 *new_sids;
> +	u32 total_count = count + new_count;
> +	int i;
> +
> +	new_sids = krealloc_array(sids, count + new_count,
> +				  sizeof(*new_sids), GFP_KERNEL);
> +	if (!new_sids)
> +		return NULL;
> +
> +	/*Update new ones */

/* Update new ones */

I'd remove the comment, or improve it, as it stands it does not
help much - we can read the code.

> +	for (i = count; i < total_count; i++)
> +		new_sids[i] = id_start++;
> +
> +	return new_sids;
> +}
> +
> +static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
> +			     u32 id_count)
> +{
> +	int i;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +
> +		if (!host->preserve_config)

Please add a comment here - it helps explain the logic behind it.

Thanks,
Lorenzo

> +			return false;
> +	}
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		if (fwspec->ids[i] >= id_start &&
> +		    fwspec->ids[i] <= id_start + id_count)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void iort_node_get_rmr_info(struct acpi_iort_node *node,
> +				   struct acpi_iort_node *iommu,
> +				   struct device *dev, struct list_head *head)
> +{
> +	struct acpi_iort_node *smmu = NULL;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_id_mapping *map;
> +	u32 *sids = NULL;
> +	u32 num_sids = 0;
> +	int i;
> +
> +	if (!node->mapping_offset || !node->mapping_count) {
> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       node);
> +		return;
> +	}
> +
> +	rmr = (struct acpi_iort_rmr *)node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count)
> +		return;
> +
> +	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +			   node->mapping_offset);
> +
> +	/*
> +	 * Go through the ID mappings and see if we have a match
> +	 * for smmu and dev(if !NULL). If found, get the sids
> +	 * for the Node.
> +	 * Please note, id_count is equal to the number of IDs
> +	 * in the range minus one.
> +	 */
> +	for (i = 0; i < node->mapping_count; i++, map++) {
> +		struct acpi_iort_node *parent;
> +
> +		if (!map->id_count)
> +			continue;
> +
> +		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				      map->output_reference);
> +		if (parent != iommu)
> +			continue;
> +
> +		/* If dev is valid, check RMR node corresponds to the dev sid */
> +		if (dev && !iort_rmr_has_dev(dev, map->output_base,
> +					     map->id_count))
> +			continue;
> +
> +		/* Retrieve sids associated with the Node. */
> +		sids = iort_rmr_alloc_sids(sids, num_sids, map->output_base,
> +					   map->id_count + 1);
> +		if (!sids)
> +			return;
> +
> +		num_sids += map->id_count + 1;
> +	}
> +
> +	if (!sids)
> +		return;
> +
> +	iort_rmr_get_resv_regions(node, smmu, sids, num_sids, head);
> +	kfree(sids);
> +}
> +
> +static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
> +			   struct list_head *head)
> +{
> +	struct acpi_table_iort *iort;
> +	struct acpi_iort_node *iort_node, *iort_end;
> +	int i;
> +
> +	if (iort_table->revision < 5)
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
> +			iort_node_get_rmr_info(iort_node, iommu, dev, head);
> +
> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +					 iort_node->length);
> +	}
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> -- 
> 2.25.1
> 
