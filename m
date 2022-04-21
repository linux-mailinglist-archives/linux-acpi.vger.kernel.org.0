Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11247509891
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 09:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385161AbiDUGyQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385841AbiDUGxg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 02:53:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3F205CE
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2022 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=M/ARur4eua8o6EQjAdFfBizbORl1mZ973Gc8El3Xu7Q=; b=3Mnsa1TpxoJA1Bwarb3A0PMDOI
        ka3ZM/TwhCTShnt0djqnLRL2i7MLW7AjXjynjbxB0vDi4/aymA5aldwBqb1KG14alcuMrGbOic6xs
        B1IlnSognZkfMvMvspDp1c/bBUomu1oCuIfBp+3ZMIpfV0E37IbAw5/CdzTELt2XGc/Zkk7mimnT+
        2LJd7QSDR6IkY/ZKtfL2Fw4d82VRkrHbbnJhoaUHDVAluOLqVoWzShTMYCe+RrBx8qfsx2wT2pZxX
        ZVt/AdCEksr0mv6ouBEYsXDGHvKwn+P4KudV/9Pvxp/W/QV4H4AlUmmScv0HN0yE4TSGzMbr5VEme
        wVEsLx5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQcA-00BqpX-5A; Thu, 21 Apr 2022 06:48:30 +0000
Date:   Wed, 20 Apr 2022 23:48:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <YmD+Puk4xfPpwED9@infradead.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 20, 2022 at 05:48:31PM +0100, Shameer Kolothum wrote:
> Parse through the IORT RMR nodes and populate the reserve region list
> corresponding to a given IOMMU and device(optional). Also, go through
> the ID mappings of the RMR node and retrieve all the SIDs associated
> with it.
> 
> Also make sure we update generic_iommu_put_resv_regions() with
> resv_region_free_fw_data() callback to free up any RMR related
> memory allocation. 
> 
> [Lorenzo: For ACPI IORT]
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 264 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c     |  12 +-
>  2 files changed, 272 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index cd5d1d7823cb..8b189e9eca95 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -788,6 +788,267 @@ void acpi_configure_pmsi_domain(struct device *dev)
>  }
>  
>  #ifdef CONFIG_IOMMU_API
> +static void iort_rmr_free_fw_data(struct device *dev,
> +				  struct iommu_resv_region *region)
> +{
> +	kfree(region->fw_data.rmr.sids);
> +}
> +
> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc,
> +					u32 count)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		u64 end, start = desc[i].base_address, length = desc[i].length;
> +
> +		if (!length) {
> +			pr_err(FW_BUG "RMR descriptor[0x%llx] with zero length, continue anyway\n",
> +			       start);
> +			continue;
> +		}
> +
> +		end = start + length - 1;
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
> +static void iort_get_rmrs(struct acpi_iort_node *node,
> +			  struct acpi_iort_node *smmu,
> +			  u32 *sids, u32 num_sids,
> +			  struct list_head *head)
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
> +				ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
> +			prot |= IOMMU_CACHE;
> +
> +		/* Create a copy of SIDs array to associate with this resv region */
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
> +		region->resv_region_free_fw_data = iort_rmr_free_fw_data;
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
> +	/*
> +	 * Make sure the kernel has preserved the boot firmware PCIe
> +	 * configuration. This is required to ensure that the RMR PCIe
> +	 * StreamIDs are still valid (Refer: ARM DEN 0049E.d Section 3.1.1.5).
> +	 */
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +
> +		if (!host->preserve_config)
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
> +	 * Go through the ID mappings and see if we have a match for SMMU
> +	 * and dev(if !NULL). If found, get the sids for the Node.
> +	 * Please note, id_count is equal to the number of IDs  in the
> +	 * range minus one.
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
> +		/* If dev is valid, check RMR node corresponds to the dev SID */
> +		if (dev && !iort_rmr_has_dev(dev, map->output_base,
> +					     map->id_count))
> +			continue;
> +
> +		/* Retrieve SIDs associated with the Node. */
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
> +	iort_get_rmrs(node, smmu, sids, num_sids, head);
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
> +	/* Only supports ARM DEN 0049E.d onwards */
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
> +/*
> + * Populate the RMR list associated with a given IOMMU and dev(if provided).
> + * If dev is NULL, the function populates all the RMRs associated with the
> + * given IOMMU.
> + */
> +static void iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
> +					    struct device *dev,
> +					    struct list_head *head)
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
>  static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  {
>  	struct acpi_iort_node *iommu;
> @@ -868,7 +1129,10 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
>   */
>  void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
>  	iort_iommu_msi_get_resv_regions(dev, head);
> +	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
>  }
>  
>  static inline bool iort_iommu_driver_enabled(u8 type)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..4431a7a5da0a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2597,16 +2597,20 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>   * @list: reserved region list for device
>   *
>   * IOMMU drivers can use this to implement their .put_resv_regions() callback
> - * for simple reservations. Memory allocated for each reserved region will be
> - * freed. If an IOMMU driver allocates additional resources per region, it is
> - * going to have to implement a custom callback.
> + * for simple reservations. Memory allocated for each reserved region and any
> + * associated firmware specific allocations will be freed. If an IOMMU driver
> + * allocates additional resources per region, it is going to have to
> + * implement a custom callback.
>   */
>  void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  {
>  	struct iommu_resv_region *entry, *next;
>  
> -	list_for_each_entry_safe(entry, next, list, list)
> +	list_for_each_entry_safe(entry, next, list, list) {
> +		if (entry->resv_region_free_fw_data)
> +			entry->resv_region_free_fw_data(dev, entry);
>  		kfree(entry);

I'd move the kfree to the free callback if present.  This would also
allow to hide the union from the common code entirely and use a
container structure like:

struct iommu_iort_rmr_data {
	struct iommu_resv_region rr;

	/* Stream IDs associated with IORT RMR entry */
	const u32 *sids;
	u32 num_sids;
};
