Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B14BDBEC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiBUPqV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 10:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbiBUPpa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 10:45:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87055237E1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 07:45:02 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RMQ3v9bz6GD5Q;
        Mon, 21 Feb 2022 23:40:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:45:00 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:44:52 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR nodes
Date:   Mon, 21 Feb 2022 15:43:36 +0000
Message-ID: <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.91.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The helper functions here parse through the IORT RMR nodes and
populate a reserved region list  corresponding to a given iommu
and device(optional). These also go through the ID mappings of
the RMR node and retrieves all the SIDs associated with a RMR
descriptor.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 225 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 0730c4dbb700..05da9ebff50a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -830,6 +830,231 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		end = start + length - 1;
+
+		/* Check for address overlap */
+		for (j = i + 1; j < count; j++) {
+			u64 e_start = desc[j].base_address;
+			u64 e_end = e_start + desc[j].length - 1;
+
+			if (start <= e_end && end >= e_start)
+				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
+				       start, end);
+		}
+	}
+}
+
+/*
+ * Please note, we will keep the already allocated RMR reserve
+ * regions in case of a memory allocation failure.
+ */
+static void iort_rmr_get_resv_regions(struct acpi_iort_node *node,
+				      struct acpi_iort_node *smmu,
+				      u32 *sids, u32 num_sids,
+				      struct list_head *head)
+{
+	struct acpi_iort_rmr *rmr = (struct acpi_iort_rmr *)node->node_data;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	int i;
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
+				rmr->rmr_offset);
+
+	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		u32  *sids_copy;
+		int prot = IOMMU_READ | IOMMU_WRITE;
+		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
+
+		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
+			/* PAGE align base addr and size */
+			addr &= PAGE_MASK;
+			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
+
+			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
+			       rmr_desc->base_address,
+			       rmr_desc->base_address + rmr_desc->length - 1,
+			       addr, addr + size - 1);
+		}
+
+		if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+		else
+			type = IOMMU_RESV_DIRECT;
+
+		if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
+			prot |= IOMMU_PRIV;
+
+		/* Attributes 0x00 - 0x03 represents device memory */
+		if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
+				ACPI_IORT_RMR_ATTR_DEVICE_GRE)
+			prot |= IOMMU_MMIO;
+		else if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) ==
+				ACPI_IORT_RMR_ATTR_NORMAL)
+			prot |= IOMMU_CACHE;
+
+		/* Create a copy of sids array to associate with this resv region */
+		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
+		if (!sids_copy)
+			return;
+
+		region = iommu_alloc_resv_region(addr, size, prot, type);
+		if (!region) {
+			kfree(sids_copy);
+			return;
+		}
+
+		region->fw_data.rmr.sids = sids_copy;
+		region->fw_data.rmr.num_sids = num_sids;
+		list_add_tail(&region->list, head);
+	}
+}
+
+static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
+				u32 new_count)
+{
+	u32 *new_sids;
+	u32 total_count = count + new_count;
+	int i;
+
+	new_sids = krealloc_array(sids, count + new_count,
+				  sizeof(*new_sids), GFP_KERNEL);
+	if (!new_sids)
+		return NULL;
+
+	/*Update new ones */
+	for (i = count; i < total_count; i++)
+		new_sids[i] = id_start++;
+
+	return new_sids;
+}
+
+static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
+			     u32 id_count)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return false;
+	}
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (fwspec->ids[i] >= id_start &&
+		    fwspec->ids[i] <= id_start + id_count)
+			return true;
+	}
+
+	return false;
+}
+
+static void iort_node_get_rmr_info(struct acpi_iort_node *node,
+				   struct acpi_iort_node *iommu,
+				   struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_node *smmu = NULL;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_id_mapping *map;
+	u32 *sids = NULL;
+	u32 num_sids = 0;
+	int i;
+
+	if (!node->mapping_offset || !node->mapping_count) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       node);
+		return;
+	}
+
+	rmr = (struct acpi_iort_rmr *)node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/*
+	 * Go through the ID mappings and see if we have a match
+	 * for smmu and dev(if !NULL). If found, get the sids
+	 * for the Node.
+	 * Please note, id_count is equal to the number of IDs
+	 * in the range minus one.
+	 */
+	for (i = 0; i < node->mapping_count; i++, map++) {
+		struct acpi_iort_node *parent;
+
+		if (!map->id_count)
+			continue;
+
+		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				      map->output_reference);
+		if (parent != iommu)
+			continue;
+
+		/* If dev is valid, check RMR node corresponds to the dev sid */
+		if (dev && !iort_rmr_has_dev(dev, map->output_base,
+					     map->id_count))
+			continue;
+
+		/* Retrieve sids associated with the Node. */
+		sids = iort_rmr_alloc_sids(sids, num_sids, map->output_base,
+					   map->id_count + 1);
+		if (!sids)
+			return;
+
+		num_sids += map->id_count + 1;
+	}
+
+	if (!sids)
+		return;
+
+	iort_rmr_get_resv_regions(node, smmu, sids, num_sids, head);
+	kfree(sids);
+}
+
+static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
+			   struct list_head *head)
+{
+	struct acpi_table_iort *iort;
+	struct acpi_iort_node *iort_node, *iort_end;
+	int i;
+
+	if (iort_table->revision < 5)
+		return;
+
+	iort = (struct acpi_table_iort *)iort_table;
+
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				iort_table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
+			       "IORT node pointer overflows, bad table!\n"))
+			return;
+
+		if (iort_node->type == ACPI_IORT_NODE_RMR)
+			iort_node_get_rmr_info(iort_node, iommu, dev, head);
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
-- 
2.25.1

